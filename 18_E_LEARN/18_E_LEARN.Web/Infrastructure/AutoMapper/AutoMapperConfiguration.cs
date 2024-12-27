using _18_E_LEARN.DataAccess.AutoMapper.Courses;
using _18_E_LEARN.DataAccess.AutoMapper.User;

namespace _18_E_LEARN.Web.Infrastructure.AutoMapper
{
    public class AutoMapperConfiguration
    {
        public static void Config(IServiceCollection services)
        {
            // User mapping
            services.AddAutoMapper(typeof(AutoMapperUserProfile));

            // Course mapping
            services.AddAutoMapper(typeof(AutoMapperCourseProfile));
        }
    }
}
