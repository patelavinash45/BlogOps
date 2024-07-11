using System.ComponentModel.DataAnnotations;

namespace Dtos.RequestDtos
{
    public class LogInRequestDto
    {
        [StringLength(256)]
        [DataType(DataType.EmailAddress)]
        public required string Email { get; set; }

        [StringLength(256)]
        [DataType(DataType.Password)]
        public required string Password { get; set; }

        public bool KeepMeSignIn { get; set; } = false;
    }
}