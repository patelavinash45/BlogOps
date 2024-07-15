using DbContexts.DataModels;

namespace Repositories.BlogRepository;

public interface IBlogRepository
{
    int CountBlogs(Func<Blog, bool> func);
    List<Blog> GetBlogs(int skip, Func<Blog, bool> func);
}
