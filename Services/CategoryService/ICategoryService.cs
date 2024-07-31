using DbContexts.DataModels;
using Dtos.CommonDtos;
using Dtos.PaginationDto;
using Dtos.RequestDtos;
using Repositories.GenericRepository;

namespace Services.CategoryService;

public interface ICategoryService : IGenericRepository<Category>
{
    CategoryDto GetCategory(int id);
    PaginationDto<CategoryDto> GetCategories(CategoriesFilterDto categoriesFilterDto);
    Task<bool> CreateCategory(CreateCategoryRequestDto createCategoryRequestDto);
    Task<bool> UpdateCategory(CategoryDto categoryDto);
    Task<bool> DeleteCategory(int id);
}
