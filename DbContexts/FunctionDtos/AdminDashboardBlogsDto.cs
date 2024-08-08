using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace DbContexts.FunctionDtos;

[Keyless]
public record AdminDashboardBlogsDto
{
    [Column("blog_id")]
    public int BlogId { get; set; }

    [Column("blog_title")]
    public string BlogTitle { get; set; } = null!;
}