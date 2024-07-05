using BlogOpsDbContext;
using DbContexts.DataModels;

namespace Repositories.BlogRepository
{
    public class BlogRepository : IBlogRepository
    {
        private readonly BlogOpsContext _dbContext;
        public BlogRepository(BlogOpsContext context)
        {
            _dbContext = context;
        }
        public List<Blog> GetBlogs(int skip, Func<Blog, bool> func)
        {
            return _dbContext.Blogs.Where(func).OrderByDescending(a => a.Id).Skip(skip).Take(9).ToList();
        }
    }
}