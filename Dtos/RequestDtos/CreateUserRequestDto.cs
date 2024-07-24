using System.ComponentModel.DataAnnotations;
using DbContexts.Enums;
using Dtos.CustomValidation;
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

    [UserRoleValidation(ErrorMessage = "Role Is Not Valid.")]
    public RoleEnum Role { get; set; }

    [UserStatusValidation(ErrorMessage = "Status Is Not Valid.")]
    public UserStatus Status { get; set; }

}
