using System.ComponentModel.DataAnnotations;
using DbContexts.Enums;
using Dtos.CustomValidation;

namespace Dtos.RequestDtos;

public record UpdateBlogRequestDto
{
    [Range(1, int.MaxValue)]
    public int Id { get; set; }

    [StringLength(128)]
    public required string Title { get; set; }

    public required string Content { get; set; }

    [StringLength(256)]
    public string? AdminComment { get; set; }

    public BlogStatus Status { get; set; }

    [IntListValidation(ErrorMessage = "CategoryId is not Valid.")]
    public List<int>? BlogCategories { get; set; }
}


