using System.Linq.Expressions;
using DbContexts.DataModels;
using DbContexts.Enums;
using Dtos.Mapper;
using Dtos.PaginationDto;
using Dtos.RequestDtos;
using Dtos.Response;
using Microsoft.IdentityModel.Tokens;
using Repositories.BlogRepository;
using Repositories.GenericRepository;
using Services.GenericService;

namespace Services.BlogService
{
    public class BlogService : GenericService<Blog>, IBlogService
    {
        private readonly IBlogCategoryService _blogCategoryService;
        private readonly IBlogRepository _blogRepository;
        public BlogService(IGenericRepository<Blog> genericRepository, IBlogCategoryService blogCategoryService, IBlogRepository blogRepository) : base(genericRepository)
        {
            _blogCategoryService = blogCategoryService;
            _blogRepository = blogRepository;
        }

        public BlogResponseDto GetBlog(int id)
        {
            Blog? blog = GetById(id) ?? throw new Exception("Blog Not Found");
            return blog.ToResponseDto();
        }

        public PaginationDto<BlogResponseDto> GetAllBlogs(BlogFilterDto blogFilterDto, int userId, int pageNo)
        {
            int skip = (pageNo - 1) * 12;
            Func<Blog, bool> func = a => a.CreatedBy == userId
                            && (blogFilterDto.Status == BlogStatus.All || a.Status == blogFilterDto.Status)
                            && (blogFilterDto.SearchContent == null || a.Title == null || a.Title.Contains(blogFilterDto.SearchContent, StringComparison.CurrentCultureIgnoreCase));

            List<BlogResponseDto> blogResponseDtos =
                       _blogRepository.GetBlogs(skip, func).Select(blog => blog.ToResponseDto()).ToList();

            int totalBlogs = _blogRepository.CountBlogs(func);
            return new PaginationDto<BlogResponseDto>
            {
                DtoList = blogResponseDtos,
                TotalBlogs = totalBlogs,
                PageNo = pageNo,
            };
        }

        public async Task<bool> CreateBlog(CreateBlogRequestDto createBlogRequestDto, int userId)
        {
            List<BlogsCategory>? blogsCategories = [];
            foreach (var categoryId in createBlogRequestDto.BlogsCategoryIds ?? [])
            {
                blogsCategories.Add(categoryId.ToBlogCategory(userId));
            };
            Blog blog = createBlogRequestDto.ToBlog(userId);
            blog.BlogsCategories = blogsCategories;
            Add(blog);
            return await SaveAsync() ? true : throw new Exception();
        }

        public async Task<bool> UpdateBlog(UpdateBlogRequestDto updateBlogRequestDto, int userId)
        {
            Blog? blog = GetById(updateBlogRequestDto.Id) ?? throw new Exception("Blog Not Found");

            List<BlogsCategory>? blogsCategories = _blogCategoryService
                                       .GetBlogsCategoriesBlogWise(updateBlogRequestDto.Id)?.ToList()
                                       ?? [];

            List<BlogsCategory>? categoriesToRemove = new();
            foreach (var blogsCategory in blogsCategories)
            {
                if (!updateBlogRequestDto.BlogsCategoryIds!.Contains(blogsCategory.CategoryId))
                {
                    blogsCategory.IsDeleted = true;
                    blogsCategory.UpdatedBy = userId;
                    blogsCategory.UpdatedDate = DateTime.UtcNow;
                    _blogCategoryService.Update(blogsCategory);
                    categoriesToRemove.Add(blogsCategory);
                }
                else if (blogsCategory.IsDeleted)
                {
                    blogsCategory.IsDeleted = false;
                    blogsCategory.UpdatedBy = userId;
                    blogsCategory.UpdatedDate = DateTime.UtcNow;
                    _blogCategoryService.Update(blogsCategory);
                }
            }

            foreach (var categoryToRemove in categoriesToRemove)
            {
                blogsCategories.Remove(categoryToRemove);
            }

            if (!blogsCategories.IsNullOrEmpty())
            {
                foreach (var categoryId in updateBlogRequestDto.BlogsCategoryIds ?? [])
                {
                    if (!blogsCategories.Any(a => a.CategoryId == categoryId))
                    {
                        _blogCategoryService.CreateBlogCategories(categoryId, updateBlogRequestDto.Id, userId);
                    }
                }
            }
            else
            {
                foreach (var categoryId in updateBlogRequestDto.BlogsCategoryIds ?? [])
                {
                    _blogCategoryService.CreateBlogCategories(categoryId, updateBlogRequestDto.Id, userId);
                }
            }

            blog = updateBlogRequestDto.ToUpdateBlog(userId, blog);
            Update(blog);
            return await SaveAsync() ? true : throw new Exception("");
        }

        public async Task<bool> DeleteBlog(int id, int userId)
        {
            Expression<Func<Blog, bool>> func = a => a.Id == id;
            Expression<Func<Blog, object>> include = a => a.BlogsCategories;
            IEnumerable<Blog>? response = GetByCriteria([include], func) ?? throw new Exception("Blog Not Found");

            response.First().Status = BlogStatus.Deleted;
            response.First().UpdatedBy = userId;
            response.First().UpdatedDate = DateTime.UtcNow;
            foreach (var blogsCategory in response.First().BlogsCategories)
            {
                blogsCategory.IsDeleted = true;
            }
            Update(response.First());
            return await SaveAsync() ? true : throw new Exception();
        }
    }
}