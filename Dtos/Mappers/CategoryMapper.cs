using DbContexts.DataModels;
using Dtos.RequestDtos;
using Dtos.ResponseDtos;

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

    public static CategoryResponseDto ToCategoryResponseDto(this Category category)
    {
        return new CategoryResponseDto
        {
            Id = category.Id,
            Name = category.Name,
        };
    }
}
