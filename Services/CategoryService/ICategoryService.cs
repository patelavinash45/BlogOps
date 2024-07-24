using DbContexts.DataModels;
using Dtos.CommonDtos;
using Dtos.RequestDtos;
using Repositories.GenericRepository;

namespace Services.CategoryService;

public interface ICategoryService : IGenericRepository<Category>
{
    CategoryDto GetCategory(int id);
    List<CategoryDto> GetAllCategories();
    Task<bool> CreateCategory(CreateCategoryRequestDto createCategoryRequestDto);
    Task<bool> UpdateCategory(CategoryDto categoryDto);
    Task<bool> DeleteCategory(int id);
}
