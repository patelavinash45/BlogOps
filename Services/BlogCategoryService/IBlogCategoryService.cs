using DbContexts.DataModels;
using Services.GenericService;

namespace Services.BlogCategoryService;

public interface IBlogCategoryService : IGenericService<BlogsCategory>
{
    void CreateBlogCategories(int categoryId, int blogId, int userId);
    IEnumerable<BlogsCategory>? GetBlogsCategoriesBlogWise(int blogId);
}
