using FluentValidation;
using Olx.BLL.Models;
using Olx.BLL.Resources;
using Olx.BLL.Validators.Extentions;

namespace Olx.BLL.Validators
{
    public class ResetPasswordModelValidator : AbstractValidator<ResetPasswordModel>
    {
        public ResetPasswordModelValidator()
        {
            RuleFor(x => x.UserId)
                .GreaterThan(0).WithMessage(ValidationErrors.GreaterZeroError);
            RuleFor(x => x.Password)
                .Password().WithMessage(ValidationErrors.InvalidPassword);
            RuleFor(x => x.Token)
                .NotEmpty().WithMessage(ValidationErrors.NotEmpty);
        }
    }
}
