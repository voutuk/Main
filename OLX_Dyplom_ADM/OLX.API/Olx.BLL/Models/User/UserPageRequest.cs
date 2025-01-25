using Olx.BLL.Models.Page;

namespace Olx.BLL.Models.User
{
    public class UserPageRequest : PageRequest
    {
        public string? EmailSearch { get; init; }
        public string? PhoneNumberSearch { get; init; }
        public string? FirstNameSearch { get; init; }
        public string? LastNameSearch { get; init; }
        public string? WebSiteSearch { get; init; }
        public string? SettlementRefSearch { get; init; }
    }
}
