using Olx.BLL.Models.Page;

namespace Olx.BLL.Models.FilterModels
{
    public class FilterPageRequest : PageRequest
    {
        public string? SearchName { get; init; }
    }
}
