﻿using AutoMapper;
using Olx.BLL.DTOs.AdminMessage;
using Olx.BLL.Entities.AdminMessages;
using Olx.BLL.Models;

namespace Olx.BLL.Mapper
{
    public class AdminMessageProfile : Profile
    {
        public AdminMessageProfile()
        {
            CreateMap<AdminMessageCreationModel, AdminMessage>()
                 .ForMember(x => x.Message, opt => opt.MapFrom(x => new Message() { Content = x.Content,Subject = x.Subject }));
            CreateMap<Message, MessageDto>();
            CreateMap<AdminMessage, AdminMessageDto>()
                .ForMember(x => x.UserName, opt => opt.MapFrom(x => x.User == null ? "Адміністратор" : x.User.FirstName ?? x.User.LastName ?? x.User.Email));
               
        }
    }
}
