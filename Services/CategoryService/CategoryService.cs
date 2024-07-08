using DbContexts.DataModels;
using Dtos.Mapper;
using Dtos.RequestDtos;
using Dtos.Response;
using Repositories.GenericRepository;
using Services.GenericService;

namespace Services.BlogService
{
    public class CategoryService : GenericService<Category>, ICategoryService
    {
        public CategoryService(IGenericRepository<Category> genericRepository) : base(genericRepository)
        {
        }

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
                categoryResponseDtos.Add(new CategoryResponseDto()
                {
                    Id = category.Id,
                    Name = category.Name,
                });
            };
            return categoryResponseDtos;
        }

        public async Task<bool> CreateCategory(CreateCategoryRequestDto createCategoryRequestDto, int userId)
        {
            Category category = createCategoryRequestDto.ToCategory(userId);
            Add(category);
            return await SaveAsync();
        }

        public async Task<bool> UpdateCategory(UpdateCategoryRequestDto updateCategoryRequestDto, int userId)
        {
            Category? category = GetById(updateCategoryRequestDto.Id)
                                        ?? throw new Exception("Category Not Found");

            category.Name = updateCategoryRequestDto.Name;
            category.UpdatedBy = userId;
            category.UpdatedDate = DateTime.UtcNow;
            Update(category);
            return await SaveAsync();
        }

        public async Task<bool> DeleteCategory(int id, int userId)
        {
            Category? category = GetById(id) ?? throw new Exception("Category Not Found");

            category.IsDeleted = true;
            category.UpdatedBy = userId;
            category.UpdatedDate = DateTime.UtcNow;
            Update(category);
            return await SaveAsync();
        }
    }
}