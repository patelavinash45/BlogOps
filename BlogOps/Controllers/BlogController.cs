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

        public BlogController(IBlogService blogService)
        {
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
            int userId = (int)HttpContext.Session.GetInt32("userId");
            var response = _blogService.GetAllBlogs(userId, pageNo);
            return Ok(response);
        }

        [HttpPost]
        public async Task<IActionResult> CreateBlog(CreateBlogRequestDto createBlogRequestDto)
        {
            if (string.IsNullOrEmpty(createBlogRequestDto.Title) && string.IsNullOrEmpty(createBlogRequestDto.Content))
                throw new ArgumentException("Model is invalid", nameof(CreateBlogRequestDto));

            int userId = (int)HttpContext.Session.GetInt32("userId");
            await _blogService.CreateBlog(createBlogRequestDto, userId);
            return Ok();
        }

        [HttpPut]
        [Route("{id:int}")]
        public async Task<IActionResult> UpdateBlog(int id, [FromBody] UpdateBlogRequestDto updateBlogRequestDto)
        {
            if (id <= 0 || !ModelState.IsValid)
                throw new ArgumentException("Model is invalid", nameof(LogInRequestDto));

            int userId = (int)HttpContext.Session.GetInt32("userId");
            await _blogService.UpdateBlog(updateBlogRequestDto, userId);
            return Ok();
        }

        [HttpDelete]
        [Route("{id:int}")]
        public async Task<IActionResult> DeleteBlog(int id)
        {
            await _blogService.DeleteBlog(id);
            return Ok();
        }
    }
}