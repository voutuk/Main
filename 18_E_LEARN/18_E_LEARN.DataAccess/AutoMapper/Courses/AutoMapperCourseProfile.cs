using _18_E_LEARN.DataAccess.Data.Models.Courses;
using _18_E_LEARN.DataAccess.Data.ViewModels.Course;
using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _18_E_LEARN.DataAccess.AutoMapper.Courses
{
    public class AutoMapperCourseProfile: Profile
    {
        public AutoMapperCourseProfile()
        {
            CreateMap<Course, AddCourseVM>().ReverseMap();
        }
    }
}
