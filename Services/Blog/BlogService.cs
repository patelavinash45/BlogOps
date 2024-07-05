using DbContexts.DataModels;
using DbContexts.Enums;
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
            return new BlogResponseDto()
            {
                Id = blog.Id,
                Title = blog.Title,
                Content = blog.Content,
                AdminComment = blog.AdminComment,
                Status = blog.Status,
                CreatedDate = blog.CreatedDate,
            };
        }

        public List<BlogResponseDto> GetAllBlogs(int userId, int pageNo)
        {
            int skip = (pageNo - 1) * 9;
            Func<Blog, bool> func = a => a.CreatedBy == userId;
            List<BlogResponseDto> blogResponseDtos =
                       _blogRepository.GetBlogs(skip, func).Select(blog => new BlogResponseDto()
                       {
                           Id = blog.Id,
                           Title = blog.Title,
                           Content = blog.Content,
                           AdminComment = blog.AdminComment,
                           Status = blog.Status,
                           CreatedDate = blog.CreatedDate,
                       }).ToList();
            return blogResponseDtos;
        }

        public async Task<bool> CreateBlog(CreateBlogRequestDto createBlogRequestDto, int userId)
        {
            List<BlogsCategory>? blogsCategories = new();
            foreach (var categoryId in createBlogRequestDto.BlogsCategoryIds ?? [])
            {
                blogsCategories.Add(new BlogsCategory()
                {
                    CategoryId = categoryId,
                    CreatedDate = DateTime.UtcNow,
                    UpdatedDate = DateTime.UtcNow,
                    CreatedBy = userId,
                    UpdatedBy = userId,
                });
            };
            Blog blog = new()
            {
                Title = createBlogRequestDto.Title,
                Content = createBlogRequestDto.Content,
                Status = createBlogRequestDto.IsDraft ? BlogStatus.Draft : BlogStatus.Pending,
                CreatedDate = DateTime.UtcNow,
                UpdatedDate = DateTime.UtcNow,
                CreatedBy = userId,
                UpdatedBy = userId,
                BlogsCategories = blogsCategories
            };
            Add(blog);
            if (await SaveAsync())
            {
                return true;
            }
            throw new Exception();
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

            blog.Title = updateBlogRequestDto.Title;
            blog.Content = updateBlogRequestDto.Content;
            blog.AdminComment = updateBlogRequestDto.AdminComment;
            blog.Status = updateBlogRequestDto.Status;
            Update(blog);
            if (await SaveAsync())
            {
                return true;
            }
            throw new Exception();
        }

        public async Task<bool> DeleteBlog(int id)
        {
            Blog? blog = GetById(id) ?? throw new Exception("Blog Not Found");
            blog.Status = BlogStatus.Deleted;
            Update(blog);
            if (await SaveAsync())
            {
                return true;
            }
            throw new Exception();
        }
    }
}