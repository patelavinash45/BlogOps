using DbContexts.DataModels;
using Dtos.Mappers;
using Dtos.RequestDtos;
using Dtos.ResponseDtos;
using Repositories.GenericRepository;
using Services.GenericService;

namespace Services.CategoryService;

public class CategoryService(IGenericRepository<Category> genericRepository) : GenericService<Category>(genericRepository), ICategoryService
{
    public CategoryResponseDto GetCategory(int id)
    {
        Category? category = GetById(id) ?? throw new Exception("Category Not Found");
        return new CategoryResponseDto()
        {
            Id = category.Id,
            Name = category.Name,
        };
    }

    public List<CategoryResponseDto> GetAllCategories()
    {
        IEnumerable<Category> categories = GetAll();
        List<CategoryResponseDto> categoryResponseDtos = [];
        foreach (Category category in categories ?? [])
        {
            categoryResponseDtos.Add(category.ToCategoryResponseDto());
        };
        return categoryResponseDtos;
    }

    public async Task<bool> CreateCategory(CreateCategoryRequestDto createCategoryRequestDto, int userId)
    {
        Category category = createCategoryRequestDto.ToCategory(userId);
        Add(category);
        return await SaveAsync() ? true : throw new Exception("");
    }

    public async Task<bool> UpdateCategory(UpdateCategoryRequestDto updateCategoryRequestDto, int userId)
    {
        Category? category = GetById(updateCategoryRequestDto.Id)
                                    ?? throw new Exception("Category Not Found");

        category.Name = updateCategoryRequestDto.Name;
        category.UpdatedBy = userId;
        category.UpdatedDate = DateTime.UtcNow;
        Update(category);
        return await SaveAsync() ? true : throw new Exception("");
    }

    public async Task<bool> DeleteCategory(int id, int userId)
    {
        Category? category = GetById(id) ?? throw new Exception("Category Not Found");

        category.IsDeleted = true;
        category.UpdatedBy = userId;
        category.UpdatedDate = DateTime.UtcNow;
        Update(category);
        return await SaveAsync() ? true : throw new Exception("");
    }

}