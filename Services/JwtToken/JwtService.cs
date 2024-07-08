using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using DbContexts.DataModels;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;

namespace Services.JwtToken
{
    public class JwtService : IJwtService
    {
        private readonly IConfiguration _configuration;

        public JwtService(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public string CreateJwtToken(User user)
        {
            List<Claim> claims = [
                new("userId", user.Id.ToString()),
                new("firstName", user.FirstName),
                new("lastName", user.LastName),
                new("email", user.Email),
                new("role",user.Role.Name),
            ];
            SymmetricSecurityKey Key = new(Encoding.UTF8.GetBytes(_configuration["Jwt:key"]!));
            SigningCredentials creds = new(Key, SecurityAlgorithms.HmacSha256);
            JwtSecurityToken token = new(
                _configuration["Jwt:Issuer"],
                _configuration["Jwt:Audience"],
                claims,
                expires: DateTime.Now.AddMinutes(30),
                signingCredentials: creds
            );
            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        public bool ValidateJwtToken(string token, out JwtSecurityToken? jwtSecurityToken)
        {
            jwtSecurityToken = null;
            if (token != null)
            {
                JwtSecurityTokenHandler tokenHandler = new();
                SymmetricSecurityKey Key = new(Encoding.UTF8.GetBytes(_configuration["Jwt:key"]!));
                try
                {
                    tokenHandler.ValidateToken(token, new TokenValidationParameters
                    {
                        ValidateIssuerSigningKey = true,
                        IssuerSigningKey = Key,
                        ValidateIssuer = false,
                        ValidateAudience = false,
                        ClockSkew = TimeSpan.Zero
                    }, out SecurityToken securityToken);
                    jwtSecurityToken = (JwtSecurityToken)securityToken;
                    return jwtSecurityToken != null;
                }
                catch (Exception) { }
            }
            return false;
        }
    }
}