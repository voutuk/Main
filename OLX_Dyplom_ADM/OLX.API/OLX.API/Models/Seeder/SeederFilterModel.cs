namespace OLX.API.Models.Seeder
{
    public class SeederFilterModel
    {
        public string Name { get; init; } = string.Empty;
        public IEnumerable<string> Values { get; init; } = new List<string>();
    }
}
