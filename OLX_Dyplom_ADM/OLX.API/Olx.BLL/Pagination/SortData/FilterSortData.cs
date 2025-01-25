using Olx.BLL.Entities.FilterEntities;
using Olx.BLL.Pagination.Interfaces;
using System.Linq.Expressions;

namespace Olx.BLL.Pagination.SortData
{
    public class FilterSortData(bool descending, string sortKey) : IPaginationSortData<Filter>
    {
        public IQueryable<Filter> Sort(IQueryable<Filter> query)
        {
            Expression<Func<Filter, object?>>? sortExpr =
                sortKey switch
                {
                    "id" => x => x.Id,
                    "name" => x => x.Name,
                    _ => x => x.Id,
                };
            return descending ? query.OrderByDescending(sortExpr) : query.OrderBy(sortExpr);
        }
    }
}
