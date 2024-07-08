using Dtos.RequestDtos;
using Microsoft.AspNetCore.Mvc;
using Services.BlogService;

namespace BlogOps.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class CategoryController : ControllerBase
    {
        private readonly ICategoryService _categoryService;
        private readonly GetUser _getUser;
        public CategoryController(ICategoryService categoryService, GetUser getUser)
        {
            _getUser = getUser;
            _categoryService = categoryService;
        }

        [Authentication("Admin")]
        [HttpGet]
        [Route("{id:int}")]
        public IActionResult GetCategory(int id)
        {
            var response = _categoryService.GetCategory(id);
            return Ok(response);
        }

        [Authentication]
        [HttpGet]
        [Route("/Categories")]
        public IActionResult GetAllCategories()
        {
            var response = _categoryService.GetAllCategories();
            return Ok(response);
        }

        [Authentication("Admin")]
        [HttpPost]
        public async Task<IActionResult> CreateCategory([FromBody] CreateCategoryRequestDto createCategoryRequestDto)
        {
            if (!ModelState.IsValid)
                throw new ArgumentException(nameof(CreateCategoryRequestDto));

            await _categoryService.CreateCategory(createCategoryRequestDto, _getUser.UserId);
            return Ok();
        }

        [Authentication("Admin")]
        [HttpPut]
        [Route("{id:int}")]
        public async Task<IActionResult> UpdateCategory(int id, [FromBody] UpdateCategoryRequestDto updateCategoryRequestDto)
        {
            if (id <= 0 || !ModelState.IsValid)
                throw new ArgumentException(nameof(UpdateCategoryRequestDto));

            await _categoryService.UpdateCategory(updateCategoryRequestDto, _getUser.UserId);
            return Ok();
        }

        [Authentication("Admin")]
        [HttpDelete]
        [Route("{id:int}")]
        public async Task<IActionResult> DeleteCategory(int id)
        {
            await _categoryService.DeleteCategory(id, _getUser.UserId);
            return Ok();
        }
    }
}