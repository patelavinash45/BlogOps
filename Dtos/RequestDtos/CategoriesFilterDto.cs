using System.ComponentModel.DataAnnotations;
using Dtos.Enums;

namespace Dtos.RequestDtos;

public record CategoriesFilterDto
{
    public string? SearchContent { get; set; }

    public CategoryStatus Status { get; set; }

    [Range(1, int.MaxValue)]
    public int PageNo { get; set; }

    [Range(1, int.MaxValue)]
    public int PageSize { get; set; }
}