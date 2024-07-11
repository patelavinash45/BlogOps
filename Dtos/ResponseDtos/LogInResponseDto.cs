namespace Dtos.Response
{
    public class LogInResponseDto
    {
        public required string Email { get; set; }

        public required string JwtToken { get; set; }

        public required string FirstName { get; set; }
        
        public required string LastName { get; set; }
    }
}