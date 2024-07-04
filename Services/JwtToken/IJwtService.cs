using System.IdentityModel.Tokens.Jwt;
using DbContexts.DataModels;

namespace Services.JwtToken
{
    public interface IJwtService
    {
        bool ValidateJwtToken(string token, out JwtSecurityToken? jwtSecurityToken);

        string CreateJwtToken(User user);
    }
}