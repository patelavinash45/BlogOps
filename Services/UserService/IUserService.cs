using DbContexts.DataModels;
using Dtos.CommonDtos;
using Dtos.PaginationDto;
using Dtos.RequestDtos;
using Dtos.ResponseDtos;
using Services.GenericService;

namespace Services.UserService;

public interface IUserService : IGenericService<User>
{
    UserDto GetUser(int id);
    LogInResponseDto ValidateUser(LogInRequestDto logInRequestDto);
    PaginationDto<UserDto> GetUsers(UserFilterDto userFilterDto);
    Task<bool> CreateUser(CreateUserRequestDto createUserRequestDto);
    Task<bool> UpdateUser(UserDto userDto);
    Task<bool> DeleteUser(int id);
    bool EmailExist(string email);
}
