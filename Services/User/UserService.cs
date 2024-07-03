using System.Security.Authentication;
using System.Text;
using DbContexts.DataModels;
using Dtos.RequestDtos;
using Repositories.GenericRepository;
using Services.GenericService;
using Services.JwtToken;

namespace Services.User
{
    public class UserService : GenericService<Tuser>, IUserService
    {
        private readonly IJwtService _jwtService;
        public UserService(IGenericRepository<Tuser> genericRepository, IJwtService jwtService) : base(genericRepository)
        {
            _jwtService = jwtService;
        }

        public LogInResponseDto ValidateUser(LogInRequestDto logInRequestDto)
        {
            string hashPassword = HashPassword(logInRequestDto);
            Func<Tuser, bool> func = a => a.Email == logInRequestDto.Email && a.Password == hashPassword;
            IEnumerable<Tuser> response = GetByFunction(func);
            if (!response.Any())
            {
                throw new AuthenticationException("Invalid email or password");
            }
            return new LogInResponseDto
            {
                Email = logInRequestDto.Email,
                JwtToken = _jwtService.CreateJwtToken(response.First()),
            };
        }

        private static string HashPassword(LogInRequestDto logInRequestDto)
        {
            var bytes = Encoding.UTF8.GetBytes(logInRequestDto.Password + logInRequestDto.Email);
            return Convert.ToBase64String(bytes);
        }
    }
}