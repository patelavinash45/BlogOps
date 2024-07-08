using DbContexts.DataModels;
using DbContexts.Enums;
using Dtos.RequestDtos;
using Dtos.Response;

namespace Dtos.Mapper
{
    public static class BlogMapper
    {
        public static BlogResponseDto ToResponseDto(this Blog blog)
        {
            return new BlogResponseDto
            {
                Id = blog.Id,
                Title = blog.Title,
                Content = blog.Content,
                AdminComment = blog.AdminComment,
                Status = blog.Status,
                CreatedDate = blog.CreatedDate,
            };
        }

        public static Blog ToBlog(this CreateBlogRequestDto createBlogRequestDto, int userId)
        {
            return new Blog
            {
                Title = createBlogRequestDto.Title,
                Content = createBlogRequestDto.Content,
                Status = createBlogRequestDto.IsDraft ? BlogStatus.Draft : BlogStatus.Pending,
                CreatedDate = DateTime.UtcNow,
                UpdatedDate = DateTime.UtcNow,
                CreatedBy = userId,
                UpdatedBy = userId,
            };
        }
    }
}