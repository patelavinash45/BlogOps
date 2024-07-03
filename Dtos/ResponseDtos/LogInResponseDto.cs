using System.ComponentModel.DataAnnotations;

namespace Dtos.RequestDtos
{
    public class LogInResponseDto
    {
        public required string Email { get; set; }

        public required string JwtToken { get; set; }
    }
}