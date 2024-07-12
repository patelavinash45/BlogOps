using Dtos.Enums;
using Dtos.RequestDtos;
using Microsoft.AspNetCore.Mvc;
using Services.BlogService;

namespace BlogOps.Controllers
{
    [ApiController]
    [Route("blogs")]
    public class BlogController : ControllerBase
    {
        private readonly IBlogService _blogService;
        private readonly UserInfo _userInfo;

        public BlogController(IBlogService blogService, UserInfo userInfo)
        {
            _userInfo = userInfo;
            _blogService = blogService;
        }

        [Authentication(RoleEnum.All)]
        [HttpGet]
        [Route("blog/{id:int}")]
        public IActionResult GetBlog(int id)
        {
            var response = _blogService.GetBlog(id);
            return Ok(response);
        }

        [Authentication(RoleEnum.All)]
        [HttpPost]
        [Route("{pageNo:int}")]
        public IActionResult GetBlogs(int pageNo, [FromBody] BlogFilterDto blogFilterDto)
        {
            var response = _blogService.GetAllBlogs(blogFilterDto, _userInfo.UserId, pageNo);
            return Ok(response);
        }

        [Authentication(RoleEnum.All)]
        [HttpPost]
        [Route("blog")]
        public async Task<IActionResult> CreateBlog(CreateBlogRequestDto createBlogRequestDto)
        {
            if (string.IsNullOrEmpty(createBlogRequestDto.Title) && string.IsNullOrEmpty(createBlogRequestDto.Content))
                throw new BadHttpRequestException(nameof(CreateBlogRequestDto));

            await _blogService.CreateBlog(createBlogRequestDto, _userInfo.UserId);
            return Ok();
        }

        [Authentication(RoleEnum.All)]
        [HttpPut]
        [Route("blog/{id:int}")]
        public async Task<IActionResult> UpdateBlog(int id, [FromBody] UpdateBlogRequestDto updateBlogRequestDto)
        {
            if (id <= 0 || !ModelState.IsValid)
                throw new BadHttpRequestException(nameof(LogInRequestDto));

            await _blogService.UpdateBlog(updateBlogRequestDto, _userInfo.UserId);
            return Ok();
        }

        [Authentication(RoleEnum.Author)]
        [HttpDelete]
        [Route("blog/{id:int}")]
        public async Task<IActionResult> DeleteBlog(int id)
        {
            await _blogService.DeleteBlog(id, _userInfo.UserId);
            return Ok();
        }
    }
}