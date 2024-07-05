using Dtos.RequestDtos;
using Microsoft.AspNetCore.Mvc;
using Services.UserService;

namespace BlogOps.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UserController : ControllerBase
    {
        private readonly IUserService  _userService;

        public UserController(IUserService userService)
        {
            _userService = userService;
        }

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public IActionResult LogIn([FromBody] LogInRequestDto model)
        {
            if (!ModelState.IsValid)
                throw new ArgumentException("Model is invalid", nameof(LogInRequestDto));

            var response = _userService.ValidateUser(model);
            return Ok(response);
        }
    }
}