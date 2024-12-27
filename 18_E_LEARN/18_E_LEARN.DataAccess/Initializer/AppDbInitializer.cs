using _18_E_LEARN.DataAccess.Data.Context;
using _18_E_LEARN.DataAccess.Data.Models.User;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _18_E_LEARN.DataAccess.Initializer
{
    public class AppDbInitializer
    {
        public static async Task Seed(IApplicationBuilder applicationBuilder)
        {
            using (var serviceScope = applicationBuilder.ApplicationServices.CreateScope())
            {
                var _context = serviceScope.ServiceProvider.GetService<AppDbContext>();
                UserManager<AppUser> userManager = serviceScope.ServiceProvider.GetRequiredService<UserManager<AppUser>>();
                if (userManager.FindByEmailAsync("admin@email.com").Result == null)
                {
                    AppUser admin = new AppUser
                    {
                        UserName = "admin@email.com",
                        Email = "admin@email.com",
                        EmailConfirmed = true,
                        Name = "Admin name",
                        Surname = "Admin surname",
                        PhoneNumber = "+xx(xxx)xx-xx-xxx",
                        PhoneNumberConfirmed = true,
                    };

                    AppUser teacher = new AppUser
                    {
                        UserName = "teacher@email.com",
                        Email = "teacher@email.com",
                        EmailConfirmed = true,
                        Name = "Teacher name",
                        Surname = "Teacher surname",
                        PhoneNumber = "+xx(xxx)xx-xx-xxx",
                        PhoneNumberConfirmed = true,
                    };

                    AppUser student = new AppUser
                    {
                        UserName = "student@email.com",
                        Email = "student@email.com",
                        EmailConfirmed = true,
                        Name = "Student name",
                        Surname = "Student surname",
                        PhoneNumber = "+xx(xxx)xx-xx-xxx",
                        PhoneNumberConfirmed = true,
                    };

                    await _context.Roles.AddRangeAsync(
                        new IdentityRole()
                        {
                            Name = "Administrators",
                            NormalizedName = "ADMINISTRATORS"
                        },
                        new IdentityRole()
                        {
                            Name = "Teachers",
                            NormalizedName = "TEACHERS"
                        },
                         new IdentityRole()
                         {
                             Name = "Students",
                             NormalizedName = "STUDENTS"
                         }
                    );

                    await _context.SaveChangesAsync();

                    IdentityResult resultAdmin = userManager.CreateAsync(admin, "Qwerty-1").Result; 
                    IdentityResult resultTeacher = userManager.CreateAsync(teacher, "Qwerty-1").Result; 
                    IdentityResult resultStudent = userManager.CreateAsync(student, "Qwerty-1").Result;

                    if (resultAdmin.Succeeded)
                    {
                        userManager.AddToRoleAsync(admin, "Administrators").Wait();
                    }

                    if (resultTeacher.Succeeded)
                    {
                        userManager.AddToRoleAsync(teacher, "Teachers").Wait();
                    }

                    if (resultStudent.Succeeded)
                    {
                        userManager.AddToRoleAsync(student, "Students").Wait();
                    }
                }
            }
        }
    }
}
