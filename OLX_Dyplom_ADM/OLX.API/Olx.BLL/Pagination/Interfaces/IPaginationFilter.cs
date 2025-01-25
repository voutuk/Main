namespace Olx.BLL.Pagination.Interfaces
{
    public interface IPaginationFilter<TEntity>
    {
        IQueryable<TEntity> FilterQuery(IQueryable<TEntity> query);
    }
}
