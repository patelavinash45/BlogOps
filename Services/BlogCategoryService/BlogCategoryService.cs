using System.Linq.Expressions;
using DbContexts.DataModels;
using Dtos.Mappers;
using Repositories.GenericRepository;
using Services.GenericService;

namespace Services.BlogCategoryService;

public class BlogCategoryService(IGenericRepository<BlogsCategory> genericRepository) : GenericService<BlogsCategory>(genericRepository), IBlogCategoryService
{
    public void CreateBlogCategories(int categoryId, int blogId)
    {
        BlogsCategory blogsCategory = categoryId.ToBlogCategory(blogId);
        Add(blogsCategory);
    }

    public IEnumerable<BlogsCategory>? GetBlogsCategoriesBlogWise(int blogId)
    {
        Expression<Func<BlogsCategory, bool>>? where = a => a.BlogId == blogId;
        return GetByCriteria(where: where);
    }
}
