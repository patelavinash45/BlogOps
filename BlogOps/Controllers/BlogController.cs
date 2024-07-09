using Dtos.Enums;
using Dtos.RequestDtos;
using Microsoft.AspNetCore.Mvc;
using Services.BlogService;

namespace BlogOps.Controllers
{
    [Authentication(RoleEnum.All)]
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

        [HttpGet]
        [Route("blog/{id:int}")]
        public IActionResult GetBlog(int id)
        {
            var response = _blogService.GetBlog(id);
            return Ok(response);
        }

        [HttpPost]
        [Route("{pageNo:int}")]
        public IActionResult GetBlogs(int pageNo,[FromBody] BlogFilterDto blogFilterDto)
        {
            var response = _blogService.GetAllBlogs(blogFilterDto, _userInfo.UserId, pageNo);
            return Ok(response);
        }

        [HttpPost]
        [Route("blog")]
        public async Task<IActionResult> CreateBlog(CreateBlogRequestDto createBlogRequestDto)
        {
            if (string.IsNullOrEmpty(createBlogRequestDto.Title) && string.IsNullOrEmpty(createBlogRequestDto.Content))
                throw new BadHttpRequestException(nameof(CreateBlogRequestDto));

            await _blogService.CreateBlog(createBlogRequestDto, _userInfo.UserId);
            return Ok();
        }

        [HttpPut]
        [Route("blog/{id:int}")]
        public async Task<IActionResult> UpdateBlog(int id, [FromBody] UpdateBlogRequestDto updateBlogRequestDto)
        {
            if (id <= 0 || !ModelState.IsValid)
                throw new BadHttpRequestException(nameof(LogInRequestDto));

            await _blogService.UpdateBlog(updateBlogRequestDto, _userInfo.UserId);
            return Ok();
        }

        [HttpDelete]
        [Route("blog/{id:int}")]
        public async Task<IActionResult> DeleteBlog(int id)
        {
            await _blogService.DeleteBlog(id, _userInfo.UserId);
            return Ok();
        }
    }
}