using BlogOps.HelperClass;
using Dtos.Enums;
using Dtos.RequestDtos;
using Microsoft.AspNetCore.Mvc;
using Services.CategoryService;

namespace BlogOps.Controllers;

[ApiController]
[Route("api/categories")]
public class CategoryController(ICategoryService categoryService) : ControllerBase
{
    private readonly ICategoryService _categoryService = categoryService;

    [Authentication(RoleEnum.Admin)]
    [HttpGet]
    [Route("{id:int}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public IActionResult GetCategory(int id)
    {
        var response = _categoryService.GetCategory(id);
        return Ok(response);
    }

    [Authentication(RoleEnum.All)]
    [HttpGet]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public IActionResult GetAllCategories()
    {
        var response = _categoryService.GetAllCategories();
        return Ok(response);
    }

    [Authentication(RoleEnum.Admin)]
    [HttpPost]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> CreateCategory([FromBody] CreateCategoryRequestDto createCategoryRequestDto)
    {
        if (!ModelState.IsValid)
            throw new BadHttpRequestException(nameof(CreateCategoryRequestDto));

        await _categoryService.CreateCategory(createCategoryRequestDto);
        return Ok();
    }

    [Authentication(RoleEnum.Admin)]
    [HttpPut]
    [Route("{id:int}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> UpdateCategory(int id, [FromBody] UpdateCategoryRequestDto updateCategoryRequestDto)
    {
        if (id <= 0 || !ModelState.IsValid)
            throw new BadHttpRequestException(nameof(UpdateCategoryRequestDto));

        await _categoryService.UpdateCategory(updateCategoryRequestDto);
        return Ok();
    }

    [Authentication(RoleEnum.Admin)]
    [HttpDelete]
    [Route("{id:int}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public async Task<IActionResult> DeleteCategory(int id)
    {
        await _categoryService.DeleteCategory(id);
        return Ok();
    }
}
