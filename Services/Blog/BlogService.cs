using DbContexts.DataModels;
using Dtos.RequestDtos;
using Repositories.GenericRepository;
using Services.GenericService;

namespace Services.BlogService
{
    public class BlogService : GenericService<Blog>, IBlogService
    {
        public BlogService(IGenericRepository<Blog> genericRepository) : base(genericRepository)
        { }

        public async Task<bool> CreateBlog(CreateBlogRequestDto createBlogRequestDto, int userId)
        {
            Blog blog = new()
            {
                Title = createBlogRequestDto?.Title ?? null,
                Content = createBlogRequestDto?.Content ?? null,
                Status = createBlogRequestDto!.IsDraft ? BlogStatus.Draft : BlogStatus.Pending,
                CreatedDate = DateTime.UtcNow,
                UpdatedDate = DateTime.UtcNow,
                CreatedBy = userId,
                UpdatedBy = userId,
            };
            Add(blog);
            if (await SaveAsync())
            {
                return true;
            }
            throw new Exception();
        }
    }
}