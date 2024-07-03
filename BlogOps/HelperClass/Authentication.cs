using System.IdentityModel.Tokens.Jwt;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.Extensions.Primitives;
using Services.JwtToken;

public class Authentication : Attribute, IAuthorizationFilter
{
    public void OnAuthorization(AuthorizationFilterContext context)
    {
        IHeaderDictionary requestHeader = context.HttpContext.Request.Headers;
        if (requestHeader.TryGetValue("Authorization", out StringValues authorizationToken))
        {
            JwtSecurityToken jwtSecurityToken = new();
            var JwtService = context.HttpContext.RequestServices.GetService<IJwtService>();
            if (JwtService != null && JwtService.ValidateJwtToken(authorizationToken[0], out jwtSecurityToken))
            {
                return;
            }
        }
        throw new UnauthorizedAccessException("Unauthorized Access.");
    }
}