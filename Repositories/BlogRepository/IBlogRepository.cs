using DbContexts.DataModels;

namespace Repositories.BlogRepository
{
    public interface IBlogRepository
    {
        List<Blog> GetBlogs(int skip, Func<Blog,bool> func);
    }
}