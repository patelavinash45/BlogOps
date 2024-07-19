using DbContexts.Enums;
using Dtos.Enums;

namespace Dtos.RequestDtos;

public record UserFilterDto
{
    public UserStatus Status { get; set; }

    public string? SearchContent { get; set; }

    public RoleEnum Role { get; set; }
}
