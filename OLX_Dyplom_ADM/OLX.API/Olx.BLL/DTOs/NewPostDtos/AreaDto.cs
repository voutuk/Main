
namespace Olx.BLL.DTOs.NewPost
{
    public class AreaDto
    {
        public string Ref { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public string RegionType { get; set; } = string.Empty;
        public IEnumerable<string> Regions { get; set; } = new HashSet<string>();
    }
}