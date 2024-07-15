using BlogOpsDbContext;
using DbContexts.DataModels;

namespace Repositories.BlogRepository;

public class BlogRepository(BlogOpsContext context) : IBlogRepository
{
    private readonly BlogOpsContext _dbContext = context;

    public int CountBlogs(Func<Blog, bool> func)
    {
        return _dbContext.Blogs.Count(func);
    }

    public List<Blog> GetBlogs(int skip, Func<Blog, bool> func)
    {
        return _dbContext.Blogs.Where(func).OrderByDescending(a => a.Id).Skip(skip).Take(9).ToList();
    }
}
