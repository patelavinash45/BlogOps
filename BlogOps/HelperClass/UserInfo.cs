public class UserInfo
{
    private readonly IHttpContextAccessor _httpContextAccessor;

    public UserInfo(IHttpContextAccessor httpContextAccessor)
    {
        _httpContextAccessor = httpContextAccessor;
    }

    public int UserId
    {
        get
        {
            return _httpContextAccessor.HttpContext!.Session.GetInt32("userId")
                         ?? throw new UnauthorizedAccessException("Unauthorized Access.");
        }
    }
}