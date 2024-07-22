using DbContexts.DataModels;
using Dtos.PaginationDto;
using Dtos.RequestDtos;
using Dtos.ResponseDtos;
using Services.GenericService;

namespace Services.BlogService;

public interface IBlogService : IGenericService<Blog>
{
    BlogResponseDto GetBlog(int id);
    PaginationDto<BlogResponseDto> GetAllBlogs(BlogFilterDto blogFilterDto, int pageNo);
    Task<bool> CreateBlog(CreateBlogRequestDto createBlogRequestDto);
    Task<bool> UpdateBlog(UpdateBlogRequestDto updateBlogRequestDto);
    Task<bool> DeleteBlog(int id);
    Task<bool> ChangeBlogStatus(int id, ChangeBlogStatusRequestDto changeBlogStatusRequestDto);
}
