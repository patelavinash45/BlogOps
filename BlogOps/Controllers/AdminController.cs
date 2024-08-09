using BlogOps.HelperClass;
using Dtos.Enums;
using Microsoft.AspNetCore.Mvc;
using Services.AdminService;

namespace BlogOps.Controllers;

[Authentication(RoleEnum.Admin)]
[ApiController]
[Route("api/admin")]
public class AdminController(IAdminService adminService) : ControllerBase
{
    private readonly IAdminService _adminService = adminService;

    [HttpGet]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public IActionResult GetDashboardData()
    {
        var response = _adminService.GetDashboardData();
        return Ok(response);
    }
}