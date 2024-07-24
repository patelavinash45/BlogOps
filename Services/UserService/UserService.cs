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

    public UserDto GetUser(int id)
    {
        User? user = GetById(id) ?? throw new Exception("User Not Found");
        return user.ToUserDto();
    }

    public LogInResponseDto ValidateUser(LogInRequestDto logInRequestDto)
    {
        Expression<Func<User, bool>> func = a => a.Email == logInRequestDto.Email;
        Expression<Func<User, object>> include = a => a.Role;
        IEnumerable<User> response = GetByCriteria([include], func);
        if (response.Any() && VerifyPassword(response.First().Password, logInRequestDto.Password))
        {
            _httpContextAccessor.HttpContext!.Session.SetInt32("userId", response.First().Id);
            string jwtToken = _jwtService.CreateJwtToken(response.First(), logInRequestDto.KeepMeSignIn ? 60 : 20);
            return new LogInResponseDto
            {
                Email = logInRequestDto.Email,
                JwtToken = jwtToken,
                FirstName = response.First().FirstName,
                LastName = response.First().LastName,
                ProfileName = response.First().ProfileName,
                RoleType = response.First().RoleId == 1 ? RoleEnum.Admin : RoleEnum.Author,
            };
        }
        throw new AuthenticationException(ConstantValue.InvalidCredentials);
    }

    public List<UserDto> GetUsers(UserFilterDto userFilterDto)
    {
        Expression<Func<User, bool>> where = a => (userFilterDto.Role == RoleEnum.All
                                                || (userFilterDto.Role == RoleEnum.Admin && a.RoleId == 1)
                                                || (userFilterDto.Role == RoleEnum.Author && a.RoleId == 2))
                                                && (userFilterDto.Status == UserStatus.All || userFilterDto.Status == a.Status)
                                                && (userFilterDto.SearchContent == null || (a.FirstName + " " + a.LastName).ToLower().Contains(userFilterDto.SearchContent.ToLower()));
        Expression<Func<User, object>> orderBy = a => a.Id;
        IEnumerable<User>? users = GetByCriteria(where: where,orderBy: orderBy);
        List<UserDto> userDtos = [];
        foreach (User user in users ?? [])
        {
            userDtos.Add(user.ToUserDto());
        }
        return userDtos;
    }

    public async Task<bool> CreateUser(CreateUserRequestDto createUserRequestDto)
    {
        User user = createUserRequestDto.ToUser();
        Add(user);
        return await SaveAsync() ? true : throw new Exception();
    }

    public async Task<bool> UpdateUser(UserDto userDto)
    {
        User? user = GetById(userDto.Id) ?? throw new Exception("User Not Found");
        user = userDto.ToUpdateUser(user);
        Update(user);
        return await SaveAsync() ? true : throw new Exception();
    }

    public async Task<bool> DeleteUser(int id)
    {
        User? user = GetById(id) ?? throw new Exception("User Not Found");
        user.Status = UserStatus.Deleted;
        Update(user);
        return await SaveAsync() ? true : throw new Exception();
    }

    private static bool VerifyPassword(string hashPassword, string enteredPassword)
    {
        return BCrypt.Net.BCrypt.Verify(enteredPassword, hashPassword);
    }
}

