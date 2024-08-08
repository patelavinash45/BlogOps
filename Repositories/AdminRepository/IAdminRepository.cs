using DbContexts.FunctionDtos;

namespace Repositories.AdminRepository;

public interface IAdminRepository{
    AdminDashboardCountsDto GetAllCounts();
    List<AdminDashboardBlogsDto> GetBlogs();
}