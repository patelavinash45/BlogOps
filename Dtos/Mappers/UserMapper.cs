using DbContexts.DataModels;
using Dtos.CommonDtos;
using Dtos.RequestDtos;

namespace Dtos.Mappers;

public static class UserMapper
{
    public static User ToUser(this UserDto userDto, User user)
    {
        user.FirstName = userDto.FirstName;
        user.LastName = userDto.LastName;
        user.ProfileName = userDto.ProfileName ?? user.ProfileName;
        user.Email = userDto.Email;
        user.Password = userDto.Password != null ? HashString(userDto.Password!) : user.Password;
        user.Status = userDto.Status;
        user.RoleId = (int)userDto.Role;
        return user;
    }

    public static UserDto ToUserDto(this User user)
    {
        return new UserDto
        {
            Id = user.Id,
            FirstName = user.FirstName,
            LastName = user.LastName,
            ProfileName = user.ProfileName,
            Email = user.Email,
            Status = user.Status,
            Role = (Enums.RoleEnum)user.RoleId,
        };
    }

    public static User ToUser(this CreateUserRequestDto createUserRequestDto)
    {
        return new User
        {
            RoleId = (int)createUserRequestDto.Role,
            FirstName = createUserRequestDto.FirstName,
            LastName = createUserRequestDto.LastName,
            ProfileName = createUserRequestDto.ProfileName,
            Email = createUserRequestDto.Email,
            Password = HashString(createUserRequestDto.Password),
            Status = createUserRequestDto.Status,
            VerificationToken = HashString(createUserRequestDto.Email).Replace("/", "$"),
        };
    }

    private static string HashString(string str)
    {
        string salt = BCrypt.Net.BCrypt.GenerateSalt();
        return BCrypt.Net.BCrypt.HashPassword(str, salt);
    }
}