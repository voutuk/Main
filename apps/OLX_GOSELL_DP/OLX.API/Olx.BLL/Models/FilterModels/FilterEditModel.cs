
namespace Olx.BLL.Models.FilterModels
{
    public class FilterEditModel
    {
        public int Id { get; init; }
        public string Name { get; init; } = string.Empty;
        public string[] NewValues { get; init; } = [];
        public EditFilterValue[] OldValues { get; init; } = [];
    }
}
