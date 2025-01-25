namespace OLX.API.Models.Seeder
{
    public class SeederAdvertModel
    {
        public int UserId { get; init; }
        public string PhoneNumber { get; init; } = string.Empty;
        public string ContactEmail { get; init; } = string.Empty;
        public string ContactPersone { get; init; } = string.Empty;
        public string Title { get; init; } = string.Empty;
        public string Description { get; init; } = string.Empty;
        public bool IsContractPrice { get; init; }
        public decimal Price { get; init; }
        public int CategoryId { get; init; }
        public string SettlementRef { get; init; } = string.Empty;
        public ICollection<int> FilterValueIds { get; init; } = new HashSet<int>();
        public ICollection<string> ImagePaths { get; init; } = [];
    }
}
