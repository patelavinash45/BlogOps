public class GetUser
{
    private readonly IHttpContextAccessor _httpContextAccessor;

    public GetUser(IHttpContextAccessor httpContextAccessor)
    {
        _httpContextAccessor = httpContextAccessor;
    }

    public int? UserId
    {
        get { return _httpContextAccessor.HttpContext!.Session.GetInt32("userId"); }
    }
}