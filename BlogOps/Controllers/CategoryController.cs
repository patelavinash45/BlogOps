using Dtos.Enums;
using Dtos.RequestDtos;
using Microsoft.AspNetCore.Mvc;
using Services.BlogService;

namespace BlogOps.Controllers
{
    [ApiController]
    [Route("categories")]
    public class CategoryController : ControllerBase
    {
        private readonly ICategoryService _categoryService;
        private readonly UserInfo _userInfo;
        public CategoryController(ICategoryService categoryService, UserInfo userInfo)
        {
            _userInfo = userInfo;
            _categoryService = categoryService;
        }

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
}