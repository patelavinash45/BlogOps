using System.ComponentModel.DataAnnotations;
using DbContexts.Enums;
using Dtos.CustomValidation;
using Dtos.Enums;

namespace Dtos.CommonDtos;

public record UserDto
{
    [Range(1, int.MaxValue)]
    public int Id { get; set; }

    [StringLength(48)]
    public required string FirstName { get; set; }

    [StringLength(48)]
    public required string LastName { get; set; }

    [StringLength(48)]
    public string? ProfileName { get; set; }

    [StringLength(256)]
    public required string Email { get; set; }

    [StringLength(256)]
    public string? Password { get; set; }

    [UserStatusValidation(ErrorMessage = "Status is not Valid.")]
    public UserStatus Status { get; set; }

    [UserRoleValidation(ErrorMessage = "Role is not Valid.")]
    public RoleEnum Role { get; set; }
}
