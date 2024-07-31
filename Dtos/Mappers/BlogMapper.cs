using DbContexts.DataModels;
using DbContexts.Enums;
using Dtos.RequestDtos;
using Dtos.ResponseDtos;

namespace Dtos.Mappers;

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
            BlogCategories = blog.BlogsCategories.Select(blogCategory => blogCategory.CategoryId).ToList(),
            CreatedBy = $"{blog.CreatedByUser.FirstName} {blog.CreatedByUser.LastName}",
            UpdatedBy = $"{blog.UpdatedByUser.FirstName} {blog.UpdatedByUser.LastName}",
        };
    }

    public static Blog ToBlog(this CreateBlogRequestDto createBlogRequestDto)
    {
        return new Blog
        {
            Title = createBlogRequestDto.Title,
            Content = createBlogRequestDto.Content,
            Status = createBlogRequestDto.IsDraft ? BlogStatus.Draft : BlogStatus.Pending,
        };
    }

    public static Blog ToUpdateBlog(this UpdateBlogRequestDto updateBlogRequestDto, Blog blog)
    {
        blog.Title = updateBlogRequestDto.Title;
        blog.Content = updateBlogRequestDto.Content;
        blog.AdminComment = updateBlogRequestDto.AdminComment;
        blog.Status = updateBlogRequestDto.Status;
        return blog;
    }
}
