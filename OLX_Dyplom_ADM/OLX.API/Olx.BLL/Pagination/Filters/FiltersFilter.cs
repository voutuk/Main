using Microsoft.EntityFrameworkCore;
using Olx.BLL.Entities.FilterEntities;
using Olx.BLL.Pagination.Interfaces;

namespace Olx.BLL.Pagination.Filters
{
    public class FiltersFilter(string? searchString) : IPaginationFilter<Filter>
    {
        public IQueryable<Filter> FilterQuery(IQueryable<Filter> query)
        {
            if (!string.IsNullOrWhiteSpace(searchString))
            {
                query = query.Where(x => x.Name.ToLower().Contains(searchString.ToLower()));
            }

            return query;
        }
    }
}
