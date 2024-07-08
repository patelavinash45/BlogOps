using DbContexts.DataModels;
using Dtos.RequestDtos;

namespace Dtos.Mapper
{
    public static class CategoryMapper
    {
        public static Category ToCategory(this CreateCategoryRequestDto createCategoryRequestDto, int userId)
        {
            return new Category
            {
                Name = createCategoryRequestDto.Name,
                CreatedBy = userId,
                CreatedDate = DateTime.UtcNow,
                UpdatedBy = userId,
                UpdatedDate = DateTime.UtcNow,
            };
        }
    }
}