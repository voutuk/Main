using _18_E_LEARN.DataAccess.Data.IRepository;
using _18_E_LEARN.DataAccess.Data.Models.Courses;
using _18_E_LEARN.DataAccess.Data.ViewModels.Course;
using AutoMapper;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _18_E_LEARN.BusinessLogic.Services
{
    public class CourseService
    {
        private readonly ICourseRepository _courseRepository;
        private readonly IMapper _mapper;
        private readonly ICategoryRepository _categoryRepository;
        private readonly IHostingEnvironment _hostEnvironment;
        private readonly IConfiguration _configuration;

        public CourseService(IMapper mapper, IConfiguration configuration, IHostingEnvironment hostEnvironment, ICourseRepository courseRepository, ICategoryRepository categoryRepository)
        {
            _courseRepository = courseRepository;
            _categoryRepository = categoryRepository;
            _hostEnvironment = hostEnvironment;
            _configuration = configuration;
            _mapper = mapper;
        }

        public async Task<ServiceResponse> GetAllAsync()
        {
            IEnumerable<Course> courses = await _courseRepository.GetAllAsync();
            return new ServiceResponse
            {
                Success = true,
                Message = "All courses loaded.",
                Payload = courses
            };
        }

        public async Task<ServiceResponse> Create(AddCourseVM model)
        {
           
            if(model.Files != null)
            {
                string webPath = _hostEnvironment.WebRootPath;
                var files = model.Files;
                string upload = webPath + Settings.ImagePath;
                string fileName = Guid.NewGuid().ToString();
                string extension = Path.GetExtension(files[0].FileName);
                using (var fileStream = new FileStream(Path.Combine(upload, fileName + extension), FileMode.Create))
                {
                    files[0].CopyTo(fileStream);
                }

                model.Image = fileName + extension;
            }
            else
            {
                model.Image = Settings.DefaultCurseImage;
            }

            var mappedCourse = _mapper.Map<AddCourseVM, Course>(model);

            await _courseRepository.Create(mappedCourse);
            return new ServiceResponse
            {
                Success = true,
                Message = "Course successfully updated."
            };
        }
    }
}
