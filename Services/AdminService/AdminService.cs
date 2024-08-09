using DbContexts.FunctionDtos;
using Dtos.Mappers;
using Dtos.ResponseDtos;
using Repositories.AdminRepository;

namespace Services.AdminService;

public class AdminService(IAdminRepository adminRepository) : IAdminService
{
    private readonly IAdminRepository _adminRepository = adminRepository;

    public AdminDashboardResponseDto GetDashboardData()
    {
        AdminDashboardCountsDto adminDashboardCountsDto = _adminRepository.GetAllCounts();
        List<AdminDashboardBlogsDto> adminDashboardBlogsDtos = _adminRepository.GetBlogs();
        return adminDashboardCountsDto.ToAdminDashboardResponseDto(adminDashboardBlogsDtos);
    }
}