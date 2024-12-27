using _18_E_LEARN.DataAccess.Data.Context;
using _18_E_LEARN.DataAccess.Data.IRepository;
using _18_E_LEARN.DataAccess.Data.Models.Courses;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _18_E_LEARN.DataAccess.Data.Repository
{
    public class CourseRepository : ICourseRepository
    {
        public async Task Create(Course model)
        {
            using (var _context = new AppDbContext())
            {
                await _context.Courses.AddAsync(model);
                await _context.SaveChangesAsync();
            }
        }

        public async Task<IEnumerable<Course>> GetAllAsync()
        {
            using(var _context = new AppDbContext())
            {
                IEnumerable<Course> courses = await _context.Courses.ToListAsync();
                return courses;
            }
        }
    }
}
