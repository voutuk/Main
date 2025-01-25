

using Olx.BLL.Models.Page;


namespace Olx.BLL.Models.Advert
{
    public class AdvertPageRequest : PageRequest
    {
        public decimal PriceFrom { get; init; }
        public decimal PriceTo { get; init; }
        public string? Search { get; init; }
        public bool IsContractPrice { get; init; } = false;
        public bool Approved { get; init; } = false;
        public bool Blocked { get; init; } = false;
        public IEnumerable<int>? CategoryIds { get; init; }
        public IEnumerable<int>? Filters { get; init; }
    }
}
