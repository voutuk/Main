

using Olx.BLL.Entities;
using Olx.BLL.DTOs.FilterDtos;
using AutoMapper;

namespace Olx.BLL.DTOs
{
    [AutoMap(typeof(Advert))]
    public class AdvertDto
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public string PhoneNumber { get; set; } = string.Empty;
        public string ContactEmail { get; set; } = string.Empty;
        public string ContactPersone { get; set; } = string.Empty;
        public DateTime Date { get; set; }
        public string Title { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public bool IsContractPrice { get; set; }
        public decimal Price { get; set; }
        public int CategoryId { get; set; }
        public string SettlementRef { get; set; }
        public ICollection<FilterValueDto> FilterValues { get; set; } = new HashSet<FilterValueDto>();
        public ICollection<AdvertImageDto> Images { get; set; } = new HashSet<AdvertImageDto>();
    }
}
