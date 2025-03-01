
namespace Olx.BLL.Models.Authentication
{
    public class RecaptchaVerificationResponse
    {
        public bool Success { get; set; }
        public string Action { get; set; } // Дія, яку передав фронтенд
        public float Score { get; set; } // Рівень довіри
    }
}
