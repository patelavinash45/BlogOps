using DbContexts.DataModels;
using Dtos.CommonDtos;
using Dtos.RequestDtos;

namespace Dtos.Mappers;

public static class UserMapper
{
    public static User ToUpdateUser(this UserDto userDto, User user)
    {
        user.FirstName = userDto.FirstName;
        user.LastName = userDto.LastName;
        user.ProfileName = userDto.ProfileName ?? user.ProfileName;
        user.Email = userDto.Email;
        user.Password = userDto.Password != null ? HashPassword(userDto.Password!) : user.Password;
        user.Status = userDto.Status;
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
        };
    }

    public static User ToUser(this CreateUserRequestDto createUserRequestDto)
    {
        return new User
        {
            FirstName = createUserRequestDto.FirstName,
            LastName = createUserRequestDto.LastName,
            ProfileName = createUserRequestDto.ProfileName,
            Email = createUserRequestDto.Email,
            Password = HashPassword(createUserRequestDto.Password),
        };
    }

    private static string HashPassword(string password)
    {
        string salt = BCrypt.Net.BCrypt.GenerateSalt();
        return BCrypt.Net.BCrypt.HashPassword(password, salt);
    }
}