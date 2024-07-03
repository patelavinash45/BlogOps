using DbContexts.DataModels;
using Dtos.RequestDtos;
using Services.GenericService;

namespace Services.User
{
    public interface IUserService : IGenericService<Tuser>
    {
        LogInResponseDto ValidateUser(LogInRequestDto logInRequestDto);
    }
}