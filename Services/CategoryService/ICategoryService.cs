using DbContexts.DataModels;
using Dtos.RequestDtos;
using Dtos.Response;
using Repositories.GenericRepository;

namespace Services.BlogService
{
    public interface ICategoryService : IGenericRepository<Category>
    {
        CategoryResponseDto GetCategory(int id);
        List<CategoryResponseDto> GetAllCategories();
        Task<bool> CreateCategory(CreateCategoryRequestDto createCategoryRequestDto, int userId);
        Task<bool> UpdateCategory(UpdateCategoryRequestDto updateCategoryRequestDto, int userId);
        Task<bool> DeleteCategory(int id, int userId);
    }
}