
namespace Olx.BLL.Models
{
    public class ResetPasswordModel
    {
        public string Password { get; init; } = string.Empty;
        public string Token { get; init; } = string.Empty;
        public int UserId { get; init; }
    }
}
