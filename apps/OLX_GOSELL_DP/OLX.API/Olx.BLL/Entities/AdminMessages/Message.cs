
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Olx.BLL.Entities.AdminMessages
{
    [Table("tbl_Messages")]
    public class Message : BaseEntity
    {
        [StringLength(2000)]
        public string Content { get; set; } = string.Empty;

        [StringLength(200)]
        public string Subject { get; set; } = string.Empty;

        public ICollection<AdminMessage> AdminMessages { get; set; } = new HashSet<AdminMessage>();
    }
}
