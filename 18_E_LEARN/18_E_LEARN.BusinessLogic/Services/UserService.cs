using _18_E_LEARN.DataAccess.Data.Models.User;
using _18_E_LEARN.DataAccess.Data.ViewModels.User;
using AutoMapper;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.WebUtilities;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _18_E_LEARN.BusinessLogic.Services
{
    public class UserService
    {
        private readonly IConfiguration _configuration;
        private readonly UserManager<AppUser> _userManager;
        private readonly SignInManager<AppUser> _signInManager;
        private readonly EmailService _emailService;
        private readonly IMapper _mapper;

        public UserService(EmailService emailService, IConfiguration configuration, IMapper mapper, UserManager<AppUser> userManager, SignInManager<AppUser> signInManager)
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _mapper = mapper;
            _configuration = configuration;
            _emailService = emailService;
        }

        public async Task<ServiceResponse> LoginUserAsync(LoginUserVM model)
        {
            AppUser user = await _userManager.FindByEmailAsync(model.Email);
            if (user == null)
            {
                return new ServiceResponse
                {
                    Success = false,
                    Message = "User or password incorrect."
                };
            }

            var result = await _signInManager.PasswordSignInAsync(user, model.Password, model.RememberMe, lockoutOnFailure: true);
            if (result.Succeeded)
            {
                await _signInManager.SignInAsync(user, false);
                return new ServiceResponse
                {
                    Success = true,
                    Message = "User logged in successfully."
                };
            }

            if (result.IsNotAllowed)
            {
                return new ServiceResponse
                {
                    Success = false,
                    Message = "Confirm your email please."
                };
            }

            if (result.IsLockedOut)
            {
                return new ServiceResponse
                {
                    Success = false,
                    Message = "Your account is locked. Connect with administrator."
                };
            }

            return new ServiceResponse
            {
                Success = false,
                Message = "User or password incorrect."
            };
        }

        public async Task<ServiceResponse> LogoutUserAsync()
        {
            await _signInManager.SignOutAsync();
            return new ServiceResponse
            {
                Success = true,
                Message = "User logged out."
            };
        }

        public async Task<ServiceResponse> GetAllUsers()
        {
            List<AppUser> users = await _userManager.Users.ToListAsync();
            List<AllUsersVM> mappedUsers = users.Select(u => _mapper.Map<AppUser, AllUsersVM>(u)).ToList();
            for (int i = 0; i < users.Count; i++)
            {
                mappedUsers[i].Role = (await _userManager.GetRolesAsync(users[i])).FirstOrDefault();
            }

            return new ServiceResponse
            {
                Success = true,
                Message = "All users loaded.",
                Payload = mappedUsers
            };
        }


        public async Task<ServiceResponse> UpdateProfileAsync(UpdateProfileVM model)
        {
            var user = await _userManager.FindByIdAsync(model.Id);
            if(user == null)
            {
                return new ServiceResponse
                {
                    Success = false,
                    Message = "User not found."
                };
            }

            if(model.Password != model.ConfirmPassword)
            {
                return new ServiceResponse
                {
                    Success = false,
                    Message = "Password do not match."
                };
            }

            if(user.Email != model.Email)
            {
                user.EmailConfirmed = false;
            }
            user.Name = model.Name;
            user.Surname = model.Surname;
            user.Email = model.Email;
            user.PhoneNumber = model.PhoneNumber;
            user.UserName = model.Email;

            var changePassword = await _userManager.ChangePasswordAsync(user, model.OldPassword, model.Password);
            if(changePassword.Succeeded) 
            {
                var result = await _userManager.UpdateAsync(user);
                if(result.Succeeded)
                {
                    await SendConfirmationEmailAsync(user);
                    await _signInManager.SignOutAsync();
                    return new ServiceResponse
                    {
                        Success = true,
                        Message = "Profile successfully updated."
                    };
                }
            }

            List<IdentityError> errorList = changePassword.Errors.ToList();
            string errors = string.Empty;

            foreach (var error in errorList)
            {
                errors = errors + error.Description.ToString();
            }

            return new ServiceResponse
            {
                Success = true,
                Message = errors
            };

        }

        public async Task<ServiceResponse> GetUserForSettingsAsync(string userId)
        {
            var user = await _userManager.FindByIdAsync(userId);
            if(user == null)
            {
                return new ServiceResponse
                {
                    Success = false,
                    Message = "User not found."
                };
            }

            var mappedUser = _mapper.Map<AppUser, UpdateProfileVM>(user);
            return new ServiceResponse
            {
                Success = true,
                Message = "User data loaded.",
                Payload = mappedUser
            };
        }

        public async Task<ServiceResponse> RegisterUserAsync(RegisterUserVM model)
        {
            if(model.Password != model.ConfirmPassword)
            {
                return new ServiceResponse
                {
                    Success = false,
                    Message = "Psswords do not match.",
                };
            }

            var mappedUser = _mapper.Map<RegisterUserVM, AppUser>(model);
            mappedUser.UserName = model.Email;
            var result = await _userManager.CreateAsync(mappedUser, model.Password);
            if (result.Succeeded)
            {
                await _userManager.AddToRoleAsync(mappedUser, model.Role);
                await SendConfirmationEmailAsync(mappedUser);
                return new ServiceResponse
                {
                    Success = true,
                    Message = "User successfully created.",
                };
            }

            List<IdentityError> errorList = result.Errors.ToList();
            string errors = "";

            foreach (var error in errorList)
            {
                errors = errors + error.Description.ToString();
            }

            return new ServiceResponse
            {
                Success = false,
                Message = errors
            };
        }

        public async Task<ServiceResponse> ConfirmEmailAsync(string userId, string token)
        {
            var user = await _userManager.FindByIdAsync(userId);
            if (user == null)
            {
                return new ServiceResponse
                {
                    Success = false,
                    Message = "User not found"
                };
            }

            var decodedToken = WebEncoders.Base64UrlDecode(token);
            string normalToken = Encoding.UTF8.GetString(decodedToken);

            var result = await _userManager.ConfirmEmailAsync(user, normalToken);

            if (result.Succeeded)
                return new ServiceResponse
                {
                    Message = "Email confirmed successfully!",
                    Success = true,
                };

            return new ServiceResponse
            {
                Success = false,
                Message = "Email did not confirm",
                Errors = result.Errors.Select(e => e.Description)
            };
        }

        public async Task SendConfirmationEmailAsync(AppUser newUser)
        {
            var token = await _userManager.GenerateEmailConfirmationTokenAsync(newUser);

            var encodedEmailToken = Encoding.UTF8.GetBytes(token);
            var validEmailToken = WebEncoders.Base64UrlEncode(encodedEmailToken);

            string url = $"{_configuration["HostSettings:URL"]}/Admin/ConfirmEmail?userid={newUser.Id}&token={validEmailToken}";

            string emailBody = $"<h1>Confirm your email</h1> <a href='{url}'>Confirm now</a>";
            await _emailService.SendEmailAsync(newUser.Email, "Email confirmation.", emailBody);
        }

        public async Task<ServiceResponse> GetUserProfileAsync(string userId)
        {
            var user = await _userManager.FindByIdAsync(userId);
            if(user == null)
            {
                return new ServiceResponse
                {
                    Success = false,
                    Message = "User not found."
                };
            }

            var roles = await _userManager.GetRolesAsync(user);
            var mappedUder = _mapper.Map<AppUser, UserProfileVM>(user);
            mappedUder.Role = roles[0];

            return new ServiceResponse
            {
                Success = true,
                Message = "User profile loaded.",
                Payload = mappedUder
            };
        }

        public async Task<ServiceResponse> GetUserByAsync(string id)
        {
            var user = await _userManager.FindByIdAsync(id);
            if (user == null)
            {
                return new ServiceResponse
                {
                    Success = false,
                    Message = "User not found."
                };
            }

            var mappedUser = _mapper.Map<AppUser, EditUserVM>(user);
            return new ServiceResponse
            {
                Success = true,
                Message = "User loaded.",
                Payload = mappedUser
            };
        }

        public async Task<ServiceResponse> EditUserAsync(EditUserVM model)
        {
            var user = await _userManager.FindByIdAsync(model.Id);
            if (user == null)
            {
                return new ServiceResponse
                {
                    Success = false,
                    Message = "User not found."
                };
            }

            user.Name = model.Name;
            user.Surname = model.Surname;
            user.PhoneNumber = model.PhoneNumber;
            if(user.Email != model.Email)
            {
                user.Email = model.Email;
                user.UserName = model.Email;
                user.EmailConfirmed = false;
                await SendConfirmationEmailAsync(user);
            }

            var result = await _userManager.UpdateAsync(user);
            if (result.Succeeded)
            {
                return new ServiceResponse
                {
                    Success = true,
                    Message = "User successfully updated."
                };
            }

            List<IdentityError> errorList = result.Errors.ToList();
            string errors = "";

            foreach (var error in errorList)
            {
                errors = errors + error.Description.ToString();
            }

            return new ServiceResponse
            {
                Success = false,
                Message = errors
            };
        }
    }
}
