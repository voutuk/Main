using _18_E_LEARN.DataAccess.Data.ViewModels.User;
using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _18_E_LEARN.DataAccess.Validation.User
{
    public class UpdateProfileValidation : AbstractValidator<UpdateProfileVM>
    {
        public UpdateProfileValidation()
        {
            RuleFor(r => r.Name).NotEmpty();
            RuleFor(r => r.Surname).NotEmpty();
            RuleFor(r => r.Email).NotEmpty().EmailAddress();
            RuleFor(r => r.PhoneNumber).NotEmpty();
            RuleFor(r => r.OldPassword).NotEmpty().MinimumLength(6);
            RuleFor(r => r.Password).NotEmpty().MinimumLength(6);
            RuleFor(r => r.ConfirmPassword).NotEmpty().MinimumLength(6);
            RuleFor(r => r.ConfirmPassword).Equal(r => r.Password);
            RuleFor(r => r.OldPassword).NotEqual(r => r.Password).WithMessage("'Old Password' must not be equal to current password.");
        }
    }
}
