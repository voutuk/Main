using AutoMapper;
using Olx.BLL.Models.Advert;
using Olx.BLL.Pagination.Filters;

namespace Olx.BLL.Mapper
{
    public class AdvertPageRequestProfile :Profile
    {
        public AdvertPageRequestProfile()
        {
            CreateMap<AdvertPageRequest, AdvertFilter>();
        }
    }
}
