using Dtos.RequestDtos;
using Microsoft.AspNetCore.Mvc;
using Services.BlogService;

namespace BlogOps.Controllers
{
    [Authentication]
    [ApiController]
    [Route("[controller]")]
    public class BlogController : ControllerBase
    {
        private readonly IBlogService _blogService;
        private readonly GetUser _getUser;

        public BlogController(IBlogService blogService, GetUser getUser)
        {
            _getUser = getUser;
            _blogService = blogService;
        }

        [HttpGet]
        [Route("{id:int}")]
        public IActionResult GetBlog(int id)
        {
            var response = _blogService.GetBlog(id);
            return Ok(response);
        }

        [HttpGet]
        [Route("/Blogs/{pageNo:int}")]
        public IActionResult GetBlogs(int pageNo)
        {
            var response = _blogService.GetAllBlogs(_getUser.UserId, pageNo);
            return Ok(response);
        }

        [HttpPost]
        public async Task<IActionResult> CreateBlog(CreateBlogRequestDto createBlogRequestDto)
        {
            if (string.IsNullOrEmpty(createBlogRequestDto.Title) && string.IsNullOrEmpty(createBlogRequestDto.Content))
                throw new ArgumentException(nameof(CreateBlogRequestDto));

            await _blogService.CreateBlog(createBlogRequestDto, _getUser.UserId);
            return Ok();
        }

        [HttpPut]
        [Route("{id:int}")]
        public async Task<IActionResult> UpdateBlog(int id, [FromBody] UpdateBlogRequestDto updateBlogRequestDto)
        {
            if (id <= 0 || !ModelState.IsValid)
                throw new ArgumentException(nameof(LogInRequestDto));

            await _blogService.UpdateBlog(updateBlogRequestDto, _getUser.UserId);
            return Ok();
        }

        [HttpDelete]
        [Route("{id:int}")]
        public async Task<IActionResult> DeleteBlog(int id)
        {
            await _blogService.DeleteBlog(id, _getUser.UserId);
            return Ok();
        }
    }
}