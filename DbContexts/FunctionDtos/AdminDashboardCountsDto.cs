using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace DbContexts.FunctionDtos;

[Keyless]
public record AdminDashboardCountsDto
{
    [Column("active_user_count")]
    public int ActiveUserCount { get; set; }

    [Column("inactive_user_count")]
    public int InactiveUserCount { get; set; }

    [Column("active_category_count")]
    public int ActiveCategoryCount { get; set; }

    [Column("inactive_category_count")]
    public int InactiveCategoryCount { get; set; }

    [Column("total_blogs_count")]
    public int TotalBlogsCount { get; set; }
}