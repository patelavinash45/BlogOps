using DbContexts.DataModels;
using Repositories.GenericRepository;
using Services.GenericService;

namespace Services.BlogService
{
    public class BlogCategoryService : GenericService<BlogsCategory>, IBlogCategoryService
    {
        public BlogCategoryService(IGenericRepository<BlogsCategory> genericRepository) : base(genericRepository)
        { }

        public void CreateBlogCategories(int categoryId, int blogId, int userId)
        {
            BlogsCategory blogsCategory = new()
            {
                BlogId = blogId,
                CategoryId = categoryId,
                CreatedDate = DateTime.UtcNow,
                UpdatedDate = DateTime.UtcNow,
                CreatedBy = userId,
                UpdatedBy = userId,
            };
            Add(blogsCategory);
        }

        public IEnumerable<BlogsCategory>? GetBlogsCategoriesBlogWise(int blogId)
        {
            Func<BlogsCategory, bool> func = a => a.BlogId == blogId;
            return GetByFunction(func);
        }
    }
}