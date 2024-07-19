using Microsoft.AspNetCore.Http;

namespace DbContexts.HelperClass;

public static class UserInfo
{
    private static HttpContext? _httpContext;

     public static void Initialize(HttpContext httpContent)
    {
        _httpContext = httpContent;
    }

    public static int UserId
    {
        get
        {
            return _httpContext!.Session.TryGetValue("userId", out var userId)
                        ? userId[3]
                        : throw new UnauthorizedAccessException("Unauthorized Access.");
        }
    }

    public static DateTime CurrentTime
    {
        get{
            return DateTime.UtcNow;
        }
    }
}