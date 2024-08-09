using DbContexts.FunctionDtos;
using Dtos.ResponseDtos;

namespace Dtos.Mappers;

public static class AdminMapper
{
    public static AdminDashboardResponseDto ToAdminDashboardResponseDto(this AdminDashboardCountsDto adminDashboardCountsDto, List<AdminDashboardBlogsDto> adminDashboardBlogsDtos)
    {
        return new AdminDashboardResponseDto
        {
            ActiveUserCount = adminDashboardCountsDto.ActiveCategoryCount,
            InactiveUserCount = adminDashboardCountsDto.InactiveUserCount,
            ActiveCategoryCount = adminDashboardCountsDto.ActiveCategoryCount,
            InactiveCategoryCount = adminDashboardCountsDto.InactiveCategoryCount,
            TotalBlogsCount = adminDashboardCountsDto.TotalBlogsCount,
            Blogs = adminDashboardBlogsDtos.ToDictionary(a => a.BlogId, a => a.BlogTitle),
        };
    }
}