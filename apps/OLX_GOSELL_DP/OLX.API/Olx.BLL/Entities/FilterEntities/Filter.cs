using System.ComponentModel.DataAnnotations.Schema;

namespace Olx.BLL.Entities.FilterEntities
{
    [Table("tbl_Filters")]
    public class Filter : BaseNamedEntity
    {
        public ICollection<Category> Categories = new HashSet<Category>();
        public ICollection<FilterValue> Values = new HashSet<FilterValue>();
    }
}
