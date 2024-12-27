using _18_E_LEARN.DataAccess.Data.Models.Courses;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _18_E_LEARN.DataAccess.Data.IRepository
{
    public interface ICourseRepository
    {
        Task<IEnumerable<Course>> GetAllAsync();
        Task Create(Course model);
    }
}
