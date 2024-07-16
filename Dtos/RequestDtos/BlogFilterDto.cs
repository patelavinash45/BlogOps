using DbContexts.Enums;

namespace Dtos.RequestDtos;

public record BlogFilterDto
{
    public BlogStatus Status { get; set; }

    public string? SearchContent { get; set; }
}
