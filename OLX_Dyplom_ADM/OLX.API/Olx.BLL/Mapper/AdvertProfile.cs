using AutoMapper;
using Olx.BLL.Entities;
using Olx.BLL.Models.Advert;


namespace Olx.BLL.Mapper
{
    public class AdvertProfile :Profile
    {
        public AdvertProfile()
        {
            CreateMap<AdvertCreationModel,Advert>();
        }
    }
}
