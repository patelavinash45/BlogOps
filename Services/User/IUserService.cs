using DbContexts.DataModels;
using Dtos.RequestDtos;
using Dtos.Response;
using Services.GenericService;

namespace Services.UserService
{
    public interface IUserService : IGenericService<User>
    {
        LogInResponseDto ValidateUser(LogInRequestDto logInRequestDto);
    }
}