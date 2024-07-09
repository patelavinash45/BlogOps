using DbContexts.DataModels;
using Dtos.CommonDtos;
using Dtos.RequestDtos;
using Dtos.Response;
using Services.GenericService;

namespace Services.UserService
{
    public interface IUserService : IGenericService<User>
    {
        LogInResponseDto ValidateUser(LogInRequestDto logInRequestDto);
        List<UserDto> GetUsers();
        Task<bool> UpdateUser(UserDto userDto, int currentUserId);
        Task<bool> DeleteUser(int id, int currentUserId);
    }
}