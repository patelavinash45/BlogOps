using Dtos.ResponseDtos;

namespace Services.AdminService;

public interface IAdminService{
    AdminDashboardResponseDto GetDashboardData();
}