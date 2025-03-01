using AutoMapper;
using Olx.BLL.DTOs;
using Olx.BLL.Entities.ChatEntities;

namespace Olx.BLL.Mapper
{
    public class ChatMessageProfile : Profile
    {
        public ChatMessageProfile()
        {
            CreateMap<ChatMessage, ChatMessageDto>()
                .ForMember(x => x.SenderName, opt => opt.MapFrom(x => x.Sender.FirstName ?? x.Sender.LastName ?? x.Sender.Email));
        }
    }
}
