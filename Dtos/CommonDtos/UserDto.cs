using System.ComponentModel.DataAnnotations;
using DbContexts.Enums;

namespace Dtos.CommonDtos
{
    public class UserDto
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

        public UserStatus Status { get; set; }
    }
}