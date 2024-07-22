using Microsoft.AspNetCore.Http;

namespace DbContexts.HelperClass;

public class UserInfo(IHttpContextAccessor httpContextAccessor)
{
    private readonly IHttpContextAccessor _httpContextAccessor = httpContextAccessor;


    public int UserId
    {
        get
        {
            return _httpContextAccessor.HttpContext!.Session.TryGetValue("userId", out var userId)
                        ? userId[3]
                        : throw new UnauthorizedAccessException("Unauthorized Access.");
        }
    }

    public static DateTime CurrentTime
    {
        get
        {
            return DateTime.UtcNow;
        }
    }
}