using BlogOps.HelperClass;
using Dtos.Enums;
using Dtos.RequestDtos;
using Microsoft.AspNetCore.Mvc;
using Services.BlogService;

namespace BlogOps.Controllers;

[ApiController]
[Route("api/blogs")]
public class BlogController(IBlogService blogService) : ControllerBase
{
    private readonly IBlogService _blogService = blogService;

    [Authentication(RoleEnum.All)]
    [HttpGet]
    [Route("{id:int}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public IActionResult GetBlog(int id)
    {
        var response = _blogService.GetBlog(id);
        return Ok(response);
    }

    [Authentication(RoleEnum.All)]
    [HttpPost]
    [Route("{pageNo:int}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public IActionResult GetBlogs(int pageNo, [FromBody] BlogFilterDto blogFilterDto)
    {
        var response = _blogService.GetAllBlogs(blogFilterDto, pageNo);
        return Ok(response);
    }

    [Authentication(RoleEnum.All)]
    [HttpPost]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> CreateBlog(CreateBlogRequestDto createBlogRequestDto)
    {
        if (!ModelState.IsValid)
            throw new BadHttpRequestException(nameof(CreateBlogRequestDto));

        await _blogService.CreateBlog(createBlogRequestDto);
        return Ok();
    }

    [Authentication(RoleEnum.All)]
    [HttpPut]
    [Route("{id:int}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> UpdateBlog(int id, [FromBody] UpdateBlogRequestDto updateBlogRequestDto)
    {
        if (id <= 0 || !ModelState.IsValid)
            throw new BadHttpRequestException(nameof(LogInRequestDto));

        await _blogService.UpdateBlog(updateBlogRequestDto);
        return Ok();
    }

    [Authentication(RoleEnum.All)]
    [HttpPut]
    [Route("approve/{id:int}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public async Task<IActionResult> ApprovedBlog(int id)
    {
        await _blogService.ChangeBlogStatus(id, true);
        return Ok();
    }

    [Authentication(RoleEnum.All)]
    [HttpPut]
    [Route("reject/{id:int}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public async Task<IActionResult> RejectBlog(int id)
    {
        await _blogService.ChangeBlogStatus(id, false);
        return Ok();
    }

    [Authentication(RoleEnum.Author)]
    [HttpDelete]
    [Route("{id:int}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public async Task<IActionResult> DeleteBlog(int id)
    {
        await _blogService.DeleteBlog(id);
        return Ok();
    }
}
