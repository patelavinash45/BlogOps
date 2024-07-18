using System.ComponentModel.DataAnnotations;
using Dtos.CustomValidation;

namespace Dtos.RequestDtos;

public record CreateBlogRequestDto
{
    [StringLength(128)]
    public required string Title { get; set; }

    public required string Content { get; set; }

    public bool IsDraft { get; set; } = true;

    [IntListValidation(ErrorMessage = "CategoryId is not Valid.")]
    public List<int>? BlogCategories { get; set; }
}
