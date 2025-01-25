
namespace Olx.BLL.Models.User
{
    public class UserBlockModel
    {
        public IEnumerable<int> UserIds { get; init; } = [];
        public bool Lock { get; init; }
        public DateTime? LockoutEndDate { get; init; }
        public string? LockReason { get; init; }

    }
}
