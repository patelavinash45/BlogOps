using BlogOps.HelperClass;
using Dtos.CommonDtos;
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
    [HttpPost]
    [Route("filter")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public IActionResult GetCategories(CategoriesFilterDto categoriesFilterDto)
    {
        if (!ModelState.IsValid)
            throw new BadHttpRequestException(nameof(CategoriesFilterDto));

        var response = _categoryService.GetCategories(categoriesFilterDto);
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
    public async Task<IActionResult> UpdateCategory(int id, [FromBody] CategoryDto categoryDto)
    {
        if (id <= 0 || !ModelState.IsValid)
            throw new BadHttpRequestException(nameof(CategoryDto));

        await _categoryService.UpdateCategory(categoryDto);
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
