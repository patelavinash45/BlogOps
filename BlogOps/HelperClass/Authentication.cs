using System.IdentityModel.Tokens.Jwt;
using Dtos.Constants;
using Dtos.Enums;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.Extensions.Primitives;
using Services.JwtService;

namespace BlogOps.HelperClass;

public class Authentication(RoleEnum role) : Attribute, IAuthorizationFilter
{
    private readonly RoleEnum _role = role;

    public void OnAuthorization(AuthorizationFilterContext context)
    {
        IHeaderDictionary requestHeader = context.HttpContext.Request.Headers;
        if (requestHeader.TryGetValue("Authorization", out StringValues authorizationToken))
        {
            JwtSecurityToken jwtSecurityToken = new();
            var JwtService = context.HttpContext.RequestServices.GetService<IJwtService>();
            if (JwtService != null && JwtService.ValidateJwtToken(authorizationToken[0]!, out jwtSecurityToken!))
            {
                int? userId = context.HttpContext.Session.GetInt32("userId");
                if (userId == null)
                {
                    userId = int.Parse(jwtSecurityToken!.Claims.First(a => a.Type == "userId").Value);
                    context.HttpContext.Session.SetInt32("userId", (int)userId);
                }
                if (_role != RoleEnum.All)
                {
                    string jwtRole = jwtSecurityToken!.Claims.First(a => a.Type == "role").Value;
                    if (Enum.TryParse(jwtRole, out RoleEnum role) && _role != role)
                    {
                        throw new UnauthorizedAccessException(ConstantValue.UnauthorizedString);
                    }
                }
                return;
            }
        }
        throw new UnauthorizedAccessException(ConstantValue.UnauthorizedString);
    }
}