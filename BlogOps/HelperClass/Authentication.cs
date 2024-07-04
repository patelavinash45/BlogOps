using System.IdentityModel.Tokens.Jwt;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.Extensions.Primitives;
using Services.JwtToken;

public class Authentication : Attribute, IAuthorizationFilter
{
    private readonly string? _role;
    public Authentication(string? role = null)
    {
        _role = role;
    }

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
                return;
            }
        }
        throw new UnauthorizedAccessException("Unauthorized Access.");
    }
}