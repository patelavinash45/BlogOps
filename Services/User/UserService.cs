using System.Linq.Expressions;
using System.Security.Authentication;
using DbContexts.DataModels;
using Dtos.RequestDtos;
using Dtos.Response;
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
            Expression<Func<User, bool>>? func = a => a.Email == logInRequestDto.Email;
            Expression<Func<User, object>> include = a => a.Role;
            IEnumerable<User> response = GetByCriteria([include], func);
            if (response.Any() && VerifyPassword(response.First().Password, logInRequestDto.Password))
            {
                return new LogInResponseDto
                {
                    Email = logInRequestDto.Email,
                    JwtToken = _jwtService.CreateJwtToken(response.First()),
                };
            }
            throw new AuthenticationException("Invalid email or password");
        }

        private static string HashPassword(string password)
        {
            string salt = BCrypt.Net.BCrypt.GenerateSalt();
            return BCrypt.Net.BCrypt.HashPassword(password, salt);
        }

        private static bool VerifyPassword(string hashPassword, string enteredPassword)
        {
            return BCrypt.Net.BCrypt.Verify(enteredPassword, hashPassword);
        }
    }
}