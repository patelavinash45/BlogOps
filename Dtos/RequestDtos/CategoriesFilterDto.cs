using Dtos.Enums;

namespace Dtos.RequestDtos;

public record CategoriesFilterDto
{
    public string? SearchContent { get; set; }

    public CategoryStatus Status { get; set; }

    public int PageNo { get; set; }

    public int PageSize { get; set; }
}