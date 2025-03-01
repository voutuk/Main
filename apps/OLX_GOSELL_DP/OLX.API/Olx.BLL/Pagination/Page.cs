namespace Olx.BLL.Pagination
{
    public class Page<TEntity>
    {
        public int Total { get; init; }
        public IEnumerable<TEntity> Items { get; init; } = [];
    }
}
