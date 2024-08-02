using System.ComponentModel.DataAnnotations;
using DbContexts.Enums;
using Dtos.Enums;

namespace Dtos.RequestDtos;

public record UserFilterDto
{
    public UserStatus Status { get; set; }

    public string? SearchContent { get; set; }

    public RoleEnum Role { get; set; }

    [Range(1, int.MaxValue)]
    public int PageNo { get; set; }

    [Range(1, int.MaxValue)]
    public int PageSize { get; set; }
}
