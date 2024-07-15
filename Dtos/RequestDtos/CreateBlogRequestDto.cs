using System.ComponentModel.DataAnnotations;

namespace Dtos.RequestDtos;

public class CreateBlogRequestDto
{
    [StringLength(128)]
    public string? Title { get; set; }

    public string? Content { get; set; }

    public bool IsDraft { get; set; } = true;

    public List<int>? BlogsCategoryIds { get; set; }
}
