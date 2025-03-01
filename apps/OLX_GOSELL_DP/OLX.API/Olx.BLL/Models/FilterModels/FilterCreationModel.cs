namespace Olx.BLL.Models.FilterModels
{
    public class FilterCreationModel
    {
        public string Name { get; init; } = string.Empty;
        public IEnumerable<string> Values { get; init; } = new HashSet<string>();
    }
}
