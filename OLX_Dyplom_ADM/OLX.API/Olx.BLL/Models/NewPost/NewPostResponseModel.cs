using Olx.BLL.Entities.NewPost;

namespace Olx.BLL.Models.NewPost
{
    public class NewPostResponseModel<T> where T : NewPostBaseEntity
    {
        public T[] Data { get; set; }
    }
}
