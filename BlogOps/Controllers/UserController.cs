using BlogOps.HelperClass;
using Dtos.CommonDtos;
using Dtos.Enums;
using Dtos.RequestDtos;
using Microsoft.AspNetCore.Mvc;
using Services.UserService;

namespace BlogOps.Controllers;

[ApiController]
[Route("api/users")]
public class UserController(IUserService userService) : ControllerBase
{
    private readonly IUserService _userService = userService;

    [Authentication(RoleEnum.Admin)]
    [HttpGet]
    [Route("{id:int}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public IActionResult GetUser(int id)
    {
        var response = _userService.GetUser(id);
        return Ok(response);
    }

    [Authentication(RoleEnum.Admin)]
    [HttpPost]
    [Route("filter")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public IActionResult GetUsers([FromBody] UserFilterDto userFilterDto)
    {
        var response = _userService.GetUsers(userFilterDto);
        return Ok(response);
    }

    [Authentication(RoleEnum.Admin)]
    [HttpPost]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> CreateUser([FromBody] CreateUserRequestDto createUserRequestDto)
    {
        if (!ModelState.IsValid)
            throw new BadHttpRequestException(nameof(CreateUserRequestDto));

        await _userService.CreateUser(createUserRequestDto);
        return Ok();
    }

    [HttpPost]
    [Route("login")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
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
    [Route("{id:int}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> UpdateUser(int id, [FromBody] UserDto userDto)
    {
        if (id <= 0 || !ModelState.IsValid)
            throw new BadHttpRequestException(nameof(userDto));

        await _userService.UpdateUser(userDto);
        return Ok();
    }

    [Authentication(RoleEnum.Admin)]
    [HttpDelete]
    [Route("{id:int}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public async Task<IActionResult> DeleteUser(int id)
    {
        await _userService.DeleteUser(id);
        return Ok();
    }

    [HttpGet]
    [Route("email-exist/{email}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public IActionResult EmailExist(string email)
    {
        var response = _userService.EmailExist(email);
        return Ok(response);
    }
}
