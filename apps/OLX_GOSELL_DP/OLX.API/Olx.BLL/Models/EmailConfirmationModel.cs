namespace Olx.BLL.Models
{
    public class EmailConfirmationModel
    {
        public int Id { get; init; }
        public string Token { get; init; } = string.Empty;
    }
}
