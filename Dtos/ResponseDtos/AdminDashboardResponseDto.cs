namespace Dtos.ResponseDtos;

public record AdminDashboardResponseDto
{
    public int ActiveUserCount { get; set; }

    public int InactiveUserCount { get; set; }

    public int ActiveCategoryCount { get; set; }

    public int InactiveCategoryCount { get; set; }

    public int TotalBlogsCount { get; set; }

    public Dictionary<int, string>? Blogs { get; set; }
}