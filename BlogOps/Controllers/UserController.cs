using Dtos.RequestDtos;
using Microsoft.AspNetCore.Mvc;
using Services.User;

namespace BlogOps.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UserController : ControllerBase
    {
        private readonly IUserService _userService;

        public UserController(IUserService userService)
        {
            _userService = userService;
        }

        [Authentication]
        [HttpPost]
        [Route("signup")]
        public IActionResult SignUp()
        {
            return Ok();
        }

        [HttpPost]
        [Route("login")]
        public IActionResult LogIn([FromBody] LogInRequestDto model)
        {
            if (!ModelState.IsValid)
                throw new ArgumentException("Model is invalid", nameof(ModelState));

            var response = _userService.ValidateUser(model);
            return Ok(response);
        }
    }
}