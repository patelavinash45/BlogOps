using DbContexts.DataModels;

namespace Dtos.Mappers;

public static class BlogCategoryMapper
{
    public static BlogsCategory ToBlogCategory(this int categoryId, int userId)
    {
        return new BlogsCategory
        {
            CategoryId = categoryId,
            CreatedDate = DateTime.UtcNow,
            UpdatedDate = DateTime.UtcNow,
            CreatedBy = userId,
            UpdatedBy = userId,
        };
    }
}
