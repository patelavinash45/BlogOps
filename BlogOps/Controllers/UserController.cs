using BlogOps.HelperClass;
using Dtos.CommonDtos;
using Dtos.Enums;
using Dtos.RequestDtos;
using Microsoft.AspNetCore.Mvc;
using Services.UserService;

namespace BlogOps.Controllers;

[ApiController]
[Route("api/users")]
public class UserController(IUserService userService, UserInfo userInfo) : ControllerBase
{
    private readonly IUserService _userService = userService;
    private readonly UserInfo _userInfo = userInfo;

    [Authentication(RoleEnum.Admin)]
    [HttpGet]
    public IActionResult GetUsers()
    {
        var response = _userService.GetUsers();
        return Ok(response);
    }

    [HttpPost]
    [Route("login")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public IActionResult LogIn([FromBody] LogInRequestDto model)
    {
        if (!ModelState.IsValid)
            throw new BadHttpRequestException(nameof(LogInRequestDto));

        var response = _userService.ValidateUser(model);
        return Ok(response);
    }

    [Authentication(RoleEnum.Admin)]
    [HttpPut]
    [Route("user")]
    public async Task<IActionResult> UpdateUser([FromBody] UserDto userDto)
    {
        if (!ModelState.IsValid)
            throw new BadHttpRequestException(nameof(userDto));

        await _userService.UpdateUser(userDto, _userInfo.UserId);
        return Ok();
    }

    [Authentication(RoleEnum.Admin)]
    [HttpDelete]
    [Route("user/{id:int}")]
    public async Task<IActionResult> DeleteUser(int id)
    {
        await _userService.DeleteUser(id, _userInfo.UserId);
        return Ok();
    }
}
