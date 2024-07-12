using DbContexts.DataModels;
using Dtos.CommonDtos;

namespace Dtos.Mapper
{
    public static class UserMapper
    {
        public static User ToUpdateUser(this UserDto userDto, int currentUserId, User user)
        {
            user.FirstName = userDto.FirstName;
            user.LastName = userDto.LastName;
            user.ProfileName = userDto.ProfileName ?? user.ProfileName;
            user.Email = userDto.Email;
            user.Password = userDto.Password != null ? HashPassword(userDto.Password!) : user.Password;
            user.Status = userDto.Status;
            user.UpdatedBy = currentUserId;
            user.UpdatedDate = DateTime.UtcNow;
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

        private static string HashPassword(string password)
        {
            string salt = BCrypt.Net.BCrypt.GenerateSalt();
            return BCrypt.Net.BCrypt.HashPassword(password, salt);
        }
    }
}