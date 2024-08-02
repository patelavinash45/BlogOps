using System.ComponentModel.DataAnnotations;
using DbContexts.Enums;

namespace Dtos.RequestDtos;

public record BlogFilterDto
{
    public BlogStatus Status { get; set; }

    public string? SearchContent { get; set; }

    public bool IsAdmin { get; set; } = false;

    public int UserId { get; set; }

    [Range(1, int.MaxValue)]
    public int PageNo { get; set; }

    [Range(1, int.MaxValue)]
    public int PageSize { get; set; }
}
