using DbContexts.DataModels;

namespace Dtos.Mappers;

public static class BlogCategoryMapper
{
    public static BlogsCategory ToBlogCategory(this int categoryId)
    {
        return new BlogsCategory
        {
            CategoryId = categoryId,
        };
    }

    public static BlogsCategory ToBlogCategory(this int categoryId, int blogId)
    {
        return new BlogsCategory
        {
            CategoryId = categoryId,
            BlogId = blogId,
        };
    } 
}
