namespace Olx.BLL.Pagination.Interfaces
{
    public interface IPaginationSortData<TEntity> where TEntity : class
    {
        IQueryable<TEntity> Sort(IQueryable<TEntity> query);
    }
}
