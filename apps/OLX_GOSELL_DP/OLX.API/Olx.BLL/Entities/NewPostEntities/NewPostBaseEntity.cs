using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;

namespace Olx.BLL.Entities.NewPost
{
    public class NewPostBaseEntity
    {
        [Key]
        [StringLength(36)]
        [Unicode(false)]
        public string Ref { get; set; }

        [StringLength(128)]
        public string Description { get; set; }
    }
}
