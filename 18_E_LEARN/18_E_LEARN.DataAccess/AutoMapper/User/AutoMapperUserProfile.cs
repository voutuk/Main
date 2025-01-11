using _18_E_LEARN.DataAccess.Data.Models.User;
using _18_E_LEARN.DataAccess.Data.ViewModels.User;
using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _18_E_LEARN.DataAccess.AutoMapper.User
{
    public class AutoMapperUserProfile : Profile
    {
        public AutoMapperUserProfile()
        {
            CreateMap<AppUser, LoginUserVM>().ReverseMap();
            CreateMap<AppUser, RegisterUserVM>().ReverseMap();
            CreateMap<AppUser, UserProfileVM>().ReverseMap();
            CreateMap<AppUser, UpdateProfileVM>().ReverseMap();
            CreateMap<AppUser, AllUsersVM>().ReverseMap();
            CreateMap<AppUser, EditUserVM>().ReverseMap();
        }
    }
}
