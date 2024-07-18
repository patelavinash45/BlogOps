using System.Linq.Expressions;
using System.Security.Authentication;
using DbContexts.DataModels;
using DbContexts.Enums;
using Dtos.CommonDtos;
using Dtos.Constants;
using Dtos.Enums;
using Dtos.Mappers;
using Dtos.RequestDtos;
using Dtos.ResponseDtos;
using Microsoft.AspNetCore.Http;
using Repositories.GenericRepository;
using Services.GenericService;
using Services.JwtService;

namespace Services.UserService;

public class UserService(IGenericRepository<User> genericRepository, IJwtService jwtService, IHttpContextAccessor httpContextAccessor) : GenericService<User>(genericRepository), IUserService
{
    private readonly IJwtService _jwtService = jwtService;
    private readonly IHttpContextAccessor _httpContextAccessor = httpContextAccessor;

    public LogInResponseDto ValidateUser(LogInRequestDto logInRequestDto)
    {
        Expression<Func<User, bool>> func = a => a.Email == logInRequestDto.Email;
        Expression<Func<User, object>> include = a => a.Role;
        IEnumerable<User> response = GetByCriteria([include], func);
        if (response.Any() && VerifyPassword(response.First().Password, logInRequestDto.Password))
        {
            _httpContextAccessor.HttpContext!.Session.SetInt32("userId", response.First().Id);
            string jwtToken = _jwtService.CreateJwtToken(response.First(), logInRequestDto.KeepMeSignIn ? 60 : 20);
            _httpContextAccessor.HttpContext!.Response.Cookies.Append("JwtToken", jwtToken, new CookieOptions
            {
                Expires = DateTime.UtcNow.AddMinutes(logInRequestDto.KeepMeSignIn ? 60 : 20),
                HttpOnly = true,
                IsEssential = true
            });
            return new LogInResponseDto
            {
                Email = logInRequestDto.Email,
                JwtToken = jwtToken,
                FirstName = response.First().FirstName,
                LastName = response.First().LastName,
                RoleType = response.First().RoleId == 1 ? RoleEnum.Admin : RoleEnum.Author,
            };
        }
        throw new AuthenticationException(ConstantValue.InvalidCredentials);
    }

    public List<UserDto> GetUsers(string role)
    {
        if (!Enum.TryParse(role, out RoleEnum roleType))
            throw new Exception("Role Is Invalid.");

        Expression<Func<User, bool>> where = a => roleType == RoleEnum.All
                                                || (roleType == RoleEnum.Admin && a.RoleId == 1)
                                                || (roleType == RoleEnum.Author && a.RoleId == 2);
        IEnumerable<User>? users = GetByCriteria(where: where);
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
        return await SaveAsync() ? true : throw new Exception();
    }

    public async Task<bool> DeleteUser(int id, int currentUserId)
    {
        User? user = GetById(id) ?? throw new Exception("User Not Found");
        user.Status = UserStatus.Deleted;
        user.UpdatedBy = currentUserId;
        user.UpdatedDate = DateTime.UtcNow;
        Update(user);
        return await SaveAsync() ? true : throw new Exception();
    }

    private static bool VerifyPassword(string hashPassword, string enteredPassword)
    {
        return BCrypt.Net.BCrypt.Verify(enteredPassword, hashPassword);
    }
}
