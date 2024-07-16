using Dtos.Constants;

namespace BlogOps.HelperClass;

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