using System.Security.Authentication;
using DbContexts.DataModels;
using Dtos.RequestDtos;
using Dtos.Response;
using Microsoft.Extensions.ObjectPool;
using Repositories.GenericRepository;
using Services.GenericService;
using Services.JwtToken;

namespace Services.UserService
{
    public class UserService : GenericService<User>, IUserService
    {
        private readonly IJwtService _jwtService;
        public UserService(IGenericRepository<User> genericRepository, IJwtService jwtService) : base(genericRepository)
        {
            _jwtService = jwtService;
        }

        public LogInResponseDto ValidateUser(LogInRequestDto logInRequestDto)
        {
            Func<User, bool> func = a => a.Email == logInRequestDto.Email && VerifyPassword(a.Password,logInRequestDto.Password);
            IEnumerable<User> response = GetByFunction(func);
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

        private static string HashPassword(string password)
        {
            string salt = BCrypt.Net.BCrypt.GenerateSalt();
            return BCrypt.Net.BCrypt.HashPassword(password, salt);
        }

        private static bool VerifyPassword(string hashPassword, string enteredPassword){
            return BCrypt.Net.BCrypt.Verify(enteredPassword, hashPassword);
        }
    }
}