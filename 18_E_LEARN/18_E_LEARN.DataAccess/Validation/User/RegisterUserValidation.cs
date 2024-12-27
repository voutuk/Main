using _18_E_LEARN.DataAccess.Data.ViewModels.User;
using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _18_E_LEARN.DataAccess.Validation.User
{
    public class RegisterUserValidation : AbstractValidator<RegisterUserVM>
    {
        public RegisterUserValidation()
        {
            RuleFor(r => r.Name).NotEmpty();
            RuleFor(r => r.Surname).NotEmpty();
            RuleFor(r => r.Email).NotEmpty().EmailAddress();
            RuleFor(r => r.Password).NotEmpty().MinimumLength(6);
            RuleFor(r => r.ConfirmPassword).NotEmpty().MinimumLength(6);
            RuleFor(r => r.ConfirmPassword).Equal(x => x.Password);
            RuleFor(r => r.Role).NotEmpty();
        }
    }
}
