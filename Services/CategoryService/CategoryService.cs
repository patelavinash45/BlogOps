using System.Linq.Expressions;
using DbContexts.DataModels;
using Dtos.CommonDtos;
using Dtos.Mappers;
using Dtos.RequestDtos;
using Repositories.GenericRepository;
using Services.GenericService;

namespace Services.CategoryService;

public class CategoryService(IGenericRepository<Category> genericRepository) : GenericService<Category>(genericRepository), ICategoryService
{
    public CategoryDto GetCategory(int id)
    {
        Category? category = GetById(id) ?? throw new Exception("Category Not Found");
        return new CategoryDto()
        {
            Id = category.Id,
            Name = category.Name,
        };
    }

    public List<CategoryDto> GetAllCategories()
    {
        IEnumerable<Category> categories = GetAll();
        List<CategoryDto> categoryResponseDtos = [];
        foreach (Category category in categories ?? [])
        {
            categoryResponseDtos.Add(category.ToCategoryResponseDto());
        };
        return categoryResponseDtos;
    }

    public async Task<bool> CreateCategory(CreateCategoryRequestDto createCategoryRequestDto)
    {
        Category category = createCategoryRequestDto.ToCategory();
        Add(category);
        return await SaveAsync() ? true : throw new Exception("");
    }

    public async Task<bool> UpdateCategory(CategoryDto categoryDto)
    {
        Category? category = GetById(categoryDto.Id)
                                    ?? throw new Exception("Category Not Found");

        category.Name = categoryDto.Name;
        Update(category);
        return await SaveAsync() ? true : throw new Exception("");
    }

    public async Task<bool> DeleteCategory(int id)
    {
        Expression<Func<Category, bool>> where = a => a.Id == id;
        Expression<Func<Category, object>> includeBlogCategories = a => a.BlogsCategories;
        IEnumerable<Category> categories = GetByCriteria(includes: [includeBlogCategories], where) 
                                                              ?? throw new Exception("Category Not Found");

        foreach (BlogsCategory blogsCategory in categories.First().BlogsCategories ?? [])
        {
            if (!blogsCategory.IsDeleted)
                throw new Exception("Can Not Delete Category.");
        }
        categories.First().IsDeleted = true;
        Update(categories.First());
        return await SaveAsync() ? true : throw new Exception("");
    }

}