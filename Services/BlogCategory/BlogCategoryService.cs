using System.Linq.Expressions;
using DbContexts.DataModels;
using Dtos.Mapper;
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
            BlogsCategory blogsCategory = categoryId.ToBlogCategory(userId);
            Add(blogsCategory);
        }

        public IEnumerable<BlogsCategory>? GetBlogsCategoriesBlogWise(int blogId)
        {
            Expression<Func<BlogsCategory, bool>>? func = a => a.BlogId == blogId;
            return GetByCriteria(func: func);
        }
    }
}