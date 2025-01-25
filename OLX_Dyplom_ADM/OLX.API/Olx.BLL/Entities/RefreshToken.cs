
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace Olx.BLL.Entities
{
    [Table("tbl_RefreshTokens")]
    public class RefreshToken :BaseEntity
    {
        public int OlxUserId { get; set; }
        public OlxUser OlxUser { get; set; } = null!;

        [Unicode(false)]
        public string Token { get; set; } = string.Empty;
        public DateTime ExpirationDate { get; set; }
    }
}
