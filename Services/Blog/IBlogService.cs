using DbContexts.DataModels;
using Dtos.RequestDtos;
using Dtos.Response;
using Services.GenericService;

namespace Services.BlogService
{
    public interface IBlogService : IGenericService<Blog>
    {
        BlogResponseDto GetBlog(int id);
        List<BlogResponseDto> GetAllBlogs(int userId,int pageNo);
        Task<bool> CreateBlog(CreateBlogRequestDto createBlogRequestDto, int userId);
        Task<bool> UpdateBlog(UpdateBlogRequestDto updateBlogRequestDto, int userId);
        Task<bool> DeleteBlog(int id);
    }
}