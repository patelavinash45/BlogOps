using DbContexts.DataModels;
using Dtos.CommonDtos;
using Dtos.Enums;
using Dtos.RequestDtos;

namespace Dtos.Mappers;

public static class CategoryMapper
{
    public static Category ToCategory(this CreateCategoryRequestDto createCategoryRequestDto)
    {
        return new Category
        {
            Name = createCategoryRequestDto.Name,
        };
    }

    public static CategoryDto ToCategoryDto(this Category category)
    {
        return new CategoryDto
        {
            Id = category.Id,
            Name = category.Name,
            Status = category.IsDeleted ? CategoryStatus.Deleted : CategoryStatus.Active,
        };
    }
}
