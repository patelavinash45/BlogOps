using DbContexts.DataModels;
using Dtos.CommonDtos;
using Dtos.RequestDtos;
using Dtos.ResponseDtos;
using Services.GenericService;

namespace Services.UserService;

public interface IUserService : IGenericService<User>
{
    LogInResponseDto ValidateUser(LogInRequestDto logInRequestDto);
    List<UserDto> GetUsers(UserFilterDto userFilterDto);
    //Task<bool> CreateUser(CreateUserRequestDto createUserRequestDto);
    Task<bool> UpdateUser(UserDto userDto);
    Task<bool> DeleteUser(int id);
}
