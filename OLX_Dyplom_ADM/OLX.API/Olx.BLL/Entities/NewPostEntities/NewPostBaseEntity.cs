using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;


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
