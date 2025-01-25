
namespace Olx.BLL.DTOs.CategoryDtos
{
    public class CategoryDto
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public string? Image { get; set; }
        public int? ParentId { get; set; }
        public string? ParentName { get; set; }
        public IEnumerable<int> Filters { get; set; } = new HashSet<int>();
        public IEnumerable<string> FilterNames { get; set; } = new HashSet<string>();
        public IEnumerable<CategoryDto> Childs { get; set; } = new HashSet<CategoryDto>();
    }
}
