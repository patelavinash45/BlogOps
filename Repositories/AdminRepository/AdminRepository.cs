using DbContexts.DataContext;
using DbContexts.FunctionDtos;

namespace Repositories.AdminRepository;

public class AdminRepository(BlogOpsContext blogOpsContext) : IAdminRepository
{
    private readonly BlogOpsContext _dbContext = blogOpsContext;

    public AdminDashboardCountsDto GetAllCounts(){
        return _dbContext.AdminDashBoardCounts().ToList().First();
    }

    public List<AdminDashboardBlogsDto> GetBlogs(){
        return _dbContext.AdminDashBoardBlogs().ToList();
    }
}