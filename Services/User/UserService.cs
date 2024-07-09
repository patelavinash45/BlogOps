using System.Linq.Expressions;
using System.Security.Authentication;
using DbContexts.DataModels;
using DbContexts.Enums;
using Dtos.CommonDtos;
using Dtos.Mapper;
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

        public List<UserDto> GetUsers()
        {
            IEnumerable<User>? users = GetByCriteria();
            List<UserDto> userDtos = [];
            foreach (User user in users ?? [])
            {
                userDtos.Add(user.ToUserDto());
            }
            return userDtos;
        }

        public async Task<bool> UpdateUser(UserDto userDto, int currentUserId)
        {
            User? user = GetById(userDto.Id) ?? throw new Exception("User Not Found");
            user = userDto.ToUpdateUser(currentUserId, user);
            Update(user);
            return await SaveAsync() ? true : throw new Exception("");
        }

        public async Task<bool> DeleteUser(int id, int currentUserId)
        {
            User? user = GetById(id) ?? throw new Exception("User Not Found");
            user.Status = UserStatus.Deleted;
            user.UpdatedBy = currentUserId;
            user.UpdatedDate = DateTime.UtcNow;
            Update(user);
            return await SaveAsync() ? true : throw new Exception("");
        }

        private static bool VerifyPassword(string hashPassword, string enteredPassword)
        {
            return BCrypt.Net.BCrypt.Verify(enteredPassword, hashPassword);
        }
    }
}