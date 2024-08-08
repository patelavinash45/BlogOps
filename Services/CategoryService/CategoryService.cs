using System.Linq.Expressions;
using DbContexts.DataModels;
using Dtos.CommonDtos;
using Dtos.Enums;
using Dtos.Mappers;
using Dtos.PaginationDtos;
using Dtos.RequestDtos;
using Repositories.GenericRepository;
using Services.GenericService;

namespace Services.CategoryService;

public class CategoryService(IGenericRepository<Category> genericRepository) : GenericService<Category>(genericRepository), ICategoryService
{
    public CategoryDto GetCategory(int id)
    {
        Category? category = GetById(id) ?? throw new Exception("Category Not Found");
        return category.ToCategoryDto();
    }

    public PaginationDto<CategoryDto> GetCategories(CategoriesFilterDto categoriesFilterDto)
    {
        Expression<Func<Category, bool>> where = a => (string.IsNullOrEmpty(categoriesFilterDto.SearchContent) || a.Name.ToLower().Contains(categoriesFilterDto.SearchContent.ToLower()))
                                                      && (categoriesFilterDto.Status == CategoryStatus.All || (categoriesFilterDto.Status == CategoryStatus.Active && !a.IsDeleted) || (categoriesFilterDto.Status == CategoryStatus.Deleted && a.IsDeleted));
        Expression<Func<Category, object>> orderby = a => a.Id;

        PaginationFromRepository<Category> paginationFromRepository
                                    = GetByCriteriaAndPagination(categoriesFilterDto.PageNo, categoriesFilterDto.PageSize, where: where, orderBy: orderby);

        List<CategoryDto> categoryResponseDtos = [];
        foreach (Category category in paginationFromRepository.Entities ?? [])
        {
            categoryResponseDtos.Add(category.ToCategoryDto());
        };
        int totalPages = (paginationFromRepository.TotalCount + categoriesFilterDto.PageSize - 1)
                                                                            / categoriesFilterDto.PageSize;
        return new PaginationDto<CategoryDto>
        {
            DtoList = categoryResponseDtos,
            TotalCount = paginationFromRepository.TotalCount,
            PageNo = categoriesFilterDto.PageNo,
            IsNext = categoriesFilterDto.PageNo < totalPages,
            IsPrevious = categoriesFilterDto.PageNo != 1,
        };
    }

    public async Task<bool> CreateCategory(CreateCategoryRequestDto createCategoryRequestDto)
    {
        Category category = createCategoryRequestDto.ToCategory();
        Add(category);
        return await SaveAsync();
    }

    public async Task<bool> UpdateCategory(CategoryDto categoryDto)
    {
        Expression<Func<Category, bool>> where = a => a.Id == categoryDto.Id;
        Expression<Func<Category, object>> includeBlogCategories = a => a.BlogsCategories;
        IEnumerable<Category> categories = GetByCriteria([includeBlogCategories], where)
                                                        ?? throw new Exception("Category Not Found");

        if (categoryDto.Status == CategoryStatus.Deleted)
        {
            CanDeleteCategory(categories.First().BlogsCategories);
        }

        categories.First().Name = categoryDto.Name;
        categories.First().IsDeleted = categoryDto.Status == CategoryStatus.Deleted;

        Update(categories.First());
        return await SaveAsync();
    }

    public async Task<bool> DeleteCategory(int id)
    {
        Expression<Func<Category, bool>> where = a => a.Id == id;
        Expression<Func<Category, object>> includeBlogCategories = a => a.BlogsCategories;
        IEnumerable<Category> categories = GetByCriteria([includeBlogCategories], where)
                                                            ?? throw new Exception("Category Not Found");

        CanDeleteCategory(categories.First().BlogsCategories);
        categories.First().IsDeleted = true;
        Update(categories.First());
        return await SaveAsync();
    }

    public bool CategoryExist(string name)
    {
        Expression<Func<Category, bool>> where = a => a.Name.ToLower() == name.ToLower();
        IEnumerable<Category> categories = GetByCriteria(where: where);
        return categories.Any();
    }

    private static void CanDeleteCategory(ICollection<BlogsCategory>? blogsCategories)
    {
        foreach (BlogsCategory blogsCategory in blogsCategories ?? [])
        {
            if (!blogsCategory.IsDeleted)
                throw new Exception("Can Not Delete Category.");
        }
    }

}