using DbContexts.DataModels;
using Dtos.RequestDtos;
using Services.GenericService;

namespace Services.BlogService
{
    public interface IBlogService : IGenericService<Blog>
    {
        Task<bool> CreateBlog(CreateBlogRequestDto createBlogRequestDto, int userId);
    }
}