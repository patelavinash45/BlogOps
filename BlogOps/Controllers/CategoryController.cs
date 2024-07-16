using BlogOps.HelperClass;
using Dtos.Enums;
using Dtos.RequestDtos;
using Microsoft.AspNetCore.Mvc;
using Services.CategoryService;

namespace BlogOps.Controllers;

[ApiController]
[Route("api/categories")]
public class CategoryController(ICategoryService categoryService, UserInfo userInfo) : ControllerBase
{
    private readonly ICategoryService _categoryService = categoryService;
    private readonly UserInfo _userInfo = userInfo;

    [Authentication(RoleEnum.Admin)]
    [HttpGet]
    [Route("category/{id:int}")]
    public IActionResult GetCategory(int id)
    {
        var response = _categoryService.GetCategory(id);
        return Ok(response);
    }

    [Authentication(RoleEnum.All)]
    [HttpGet]
    public IActionResult GetAllCategories()
    {
        var response = _categoryService.GetAllCategories();
        return Ok(response);
    }

    [Authentication(RoleEnum.Admin)]
    [HttpPost]
    [Route("category")]
    public async Task<IActionResult> CreateCategory([FromBody] CreateCategoryRequestDto createCategoryRequestDto)
    {
        if (!ModelState.IsValid)
            throw new BadHttpRequestException(nameof(CreateCategoryRequestDto));

        await _categoryService.CreateCategory(createCategoryRequestDto, _userInfo.UserId);
        return Ok();
    }

    [Authentication(RoleEnum.Admin)]
    [HttpPut]
    [Route("category/{id:int}")]
    public async Task<IActionResult> UpdateCategory(int id, [FromBody] UpdateCategoryRequestDto updateCategoryRequestDto)
    {
        if (id <= 0 || !ModelState.IsValid)
            throw new BadHttpRequestException(nameof(UpdateCategoryRequestDto));

        await _categoryService.UpdateCategory(updateCategoryRequestDto, _userInfo.UserId);
        return Ok();
    }

    [Authentication(RoleEnum.Admin)]
    [HttpDelete]
    [Route("category/{id:int}")]
    public async Task<IActionResult> DeleteCategory(int id)
    {
        await _categoryService.DeleteCategory(id, _userInfo.UserId);
        return Ok();
    }
}
