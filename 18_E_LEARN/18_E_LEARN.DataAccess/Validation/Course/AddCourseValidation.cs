using _18_E_LEARN.DataAccess.Data.ViewModels.Course;
using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _18_E_LEARN.DataAccess.Validation.Course
{
    public class AddCourseValidation : AbstractValidator<AddCourseVM>
    {
        public AddCourseValidation()
        {
            RuleFor(r => r.Name).NotEmpty();
            RuleFor(r => r.Description).NotEmpty();
            RuleFor(r => r.Price).NotEmpty().GreaterThanOrEqualTo(0).LessThanOrEqualTo(100000);
            RuleFor(r => r.CategoryId).NotEmpty();
        }
    }
}
