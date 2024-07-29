using DbContexts.Enums;

namespace Dtos.RequestDtos;

public record BlogFilterDto
{
    public BlogStatus Status { get; set; }

    public string? SearchContent { get; set; }

    public bool IsAdmin { get; set; } = false;

    public int UserId { get; set; }

    public int PageNo { get; set; }

    public int PageSize { get; set; }
}
