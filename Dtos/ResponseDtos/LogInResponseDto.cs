using Dtos.Enums;

namespace Dtos.ResponseDtos;

public record LogInResponseDto
{
    public required string Email { get; set; }

    public required string JwtToken { get; set; }

    public required string FirstName { get; set; }

    public required string LastName { get; set; }

    public required RoleEnum RoleType { get; set; }
}
