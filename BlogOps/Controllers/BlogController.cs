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

        [HttpPost]
        public async Task<IActionResult> CreateBlog(CreateBlogRequestDto createBlogRequestDto)
        {
            if (string.IsNullOrEmpty(createBlogRequestDto.Title) && string.IsNullOrEmpty(createBlogRequestDto.Content))
                throw new ArgumentException("Model is invalid", nameof(CreateBlogRequestDto));

            int userId = (int)HttpContext.Session.GetInt32("userId");
            await _blogService.CreateBlog(createBlogRequestDto, userId); 
            return Ok();
        }
    }
}