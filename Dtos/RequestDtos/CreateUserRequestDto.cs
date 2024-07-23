using System.ComponentModel.DataAnnotations;
using Dtos.Enums;

namespace Dtos.RequestDtos;

public record CreateUserRequestDto
{
    [StringLength(256)]
    [DataType(DataType.EmailAddress)]
    public required string Email { get; set; }

    [StringLength(256)]
    [DataType(DataType.Password)]
    public required string Password { get; set; }

    [StringLength(48)]
    public required string FirstName { get; set; }

    [StringLength(48)]
    public required string LastName { get; set; }

    [StringLength(48)]
    public string? ProfileName { get; set; }

    public RoleEnum Role { get; set; }

}
