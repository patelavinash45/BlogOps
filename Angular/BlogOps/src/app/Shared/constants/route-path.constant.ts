export class RoutePathConstant{
    private static Author = "/author";
    private static Admin = "/admin";
    public static LogInPath = "/login";
    public static AuthorDashboardPath = `${this.Author}/dashboard`;
    public static AuthorNewBlogPath = `${this.Author}/blog/new`;
    public static AuthorEditBlogPath = `${this.Author}/blog/edit`;
    public static AuthorViewBlogPath = `${this.Author}/blog/view`;
    public static AdminDashboardPath = `${this.Admin}/dashboard`;
    public static AdminBlogPath = `${this.Admin}/blog`;
    public static AdminNewBlogPath = `${this.Admin}/blog/new`;
    public static AdminViewBlogPath = `${this.Admin}/blog/view`;
    public static AdminUserPath = `${this.Admin}/user`;
    public static AdminViewUserPath = `${this.Admin}/user/view`;
}