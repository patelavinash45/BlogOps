
using Dtos.Constants;

public class UserInfo(IHttpContextAccessor httpContextAccessor)
{
    private readonly IHttpContextAccessor _httpContextAccessor = httpContextAccessor;

    public int UserId
    {
        get
        {
            return _httpContextAccessor.HttpContext!.Session.GetInt32("userId")
                         ?? throw new UnauthorizedAccessException(ConstantValue.UnauthorizedString);
        }
    }
}