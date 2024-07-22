using System.Linq.Expressions;
using DbContexts.DataModels;
using DbContexts.Enums;
using DbContexts.HelperClass;
using Dtos.Mappers;
using Dtos.PaginationDto;
using Dtos.RequestDtos;
using Dtos.ResponseDtos;
using Microsoft.IdentityModel.Tokens;
using Repositories.GenericRepository;
using Services.BlogCategoryService;
using Services.GenericService;

namespace Services.BlogService;

public class BlogService(IGenericRepository<Blog> genericRepository, IBlogCategoryService blogCategoryService, UserInfo userInfo) : GenericService<Blog>(genericRepository), IBlogService
{
    private readonly IBlogCategoryService _blogCategoryService = blogCategoryService;
    private readonly UserInfo _userInfo = userInfo;

    public BlogResponseDto GetBlog(int id)
    {
        Expression<Func<Blog, bool>> where = a => a.Id == id;
        Expression<Func<Blog, object>> includeCategories = a => a.BlogsCategories.Where(x => !x.IsDeleted);
        Expression<Func<Blog, object>> includeCreatedBy = a => a.CreatedByUser;
        Expression<Func<Blog, object>> includeUpdatedBy = a => a.UpdatedByUser;

        IEnumerable<Blog>? blogs = GetByCriteria([includeCategories, includeCreatedBy, includeUpdatedBy], where)
                                            ?? throw new Exception("Blog Not Found");
        return blogs.First().ToResponseDto();
    }

    public PaginationDto<BlogResponseDto> GetAllBlogs(BlogFilterDto blogFilterDto, int pageNo)
    {
        int userId = _userInfo.UserId;
        int skip = (pageNo - 1) * 9;
        Expression<Func<Blog, bool>> where = a =>
                        ((blogFilterDto.IsAdmin && (blogFilterDto.UserId == 0 || a.CreatedBy == blogFilterDto.UserId)) || a.CreatedBy == userId)
                        && (!blogFilterDto.IsAdmin || a.Status != BlogStatus.Draft)
                        && a.Status != BlogStatus.Deleted
                        && (blogFilterDto.Status == BlogStatus.All || a.Status == blogFilterDto.Status)
                        && (blogFilterDto.SearchContent == null || a.Title.ToLower().Contains(blogFilterDto.SearchContent.ToLower()));

        Expression<Func<Blog, object>> includeCategories = a => a.BlogsCategories.Where(x => !x.IsDeleted);
        Expression<Func<Blog, object>> includeCreatedBy = a => a.CreatedByUser;
        Expression<Func<Blog, object>> includeUpdatedBy = a => a.UpdatedByUser;
        Expression<Func<Blog, object>> orderBy = a => a.Id;

        PaginationFromRepository<Blog> paginationFromRepository
                                = GetByCriteriaAndPagination(skip, 9, [includeCategories, includeCreatedBy, includeUpdatedBy], where, orderBy);

        List<BlogResponseDto> blogResponseDtos = [];
        foreach (Blog blog in paginationFromRepository.Entities ?? [])
        {
            blogResponseDtos.Add(blog.ToResponseDto());
        }

        int totalPages = (paginationFromRepository.TotalCount + 8) / 9;
        return new PaginationDto<BlogResponseDto>
        {
            DtoList = blogResponseDtos,
            TotalCount = paginationFromRepository.TotalCount,
            PageNo = pageNo,
            IsNext = pageNo < totalPages,
            IsPrevious = pageNo != 1,
        };
    }

    public async Task<bool> CreateBlog(CreateBlogRequestDto createBlogRequestDto)
    {
        List<BlogsCategory>? blogsCategories = [];
        foreach (var categoryId in createBlogRequestDto.BlogCategories ?? [])
        {
            blogsCategories.Add(categoryId.ToBlogCategory());
        };
        Blog blog = createBlogRequestDto.ToBlog();
        blog.BlogsCategories = blogsCategories;
        Add(blog);
        return await SaveAsync() ? true : throw new Exception();
    }

    public async Task<bool> UpdateBlog(UpdateBlogRequestDto updateBlogRequestDto)
    {
        Blog? blog = GetById(updateBlogRequestDto.Id) ?? throw new Exception("Blog Not Found");

        List<BlogsCategory>? blogsCategories = _blogCategoryService
                                   .GetBlogsCategoriesBlogWise(updateBlogRequestDto.Id)?.ToList()
                                   ?? [];

        List<BlogsCategory>? categoriesToRemove = [];
        foreach (var blogsCategory in blogsCategories)
        {
            if (!updateBlogRequestDto.BlogCategories!.Contains(blogsCategory.CategoryId))
            {
                blogsCategory.IsDeleted = true;
                _blogCategoryService.Update(blogsCategory);
                categoriesToRemove.Add(blogsCategory);
            }
            else if (blogsCategory.IsDeleted)
            {
                blogsCategory.IsDeleted = false;
                _blogCategoryService.Update(blogsCategory);
            }
        }

        foreach (var categoryToRemove in categoriesToRemove)
        {
            blogsCategories.Remove(categoryToRemove);
        }

        if (!blogsCategories.IsNullOrEmpty())
        {
            foreach (var categoryId in updateBlogRequestDto.BlogCategories ?? [])
            {
                if (!blogsCategories.Any(a => a.CategoryId == categoryId))
                {
                    _blogCategoryService.CreateBlogCategories(categoryId, updateBlogRequestDto.Id);
                }
            }
        }
        else
        {
            foreach (var categoryId in updateBlogRequestDto.BlogCategories ?? [])
            {
                _blogCategoryService.CreateBlogCategories(categoryId, updateBlogRequestDto.Id);
            }
        }

        blog = updateBlogRequestDto.ToUpdateBlog(blog);
        Update(blog);
        return await SaveAsync() ? true : throw new Exception("");
    }

    public async Task<bool> DeleteBlog(int id)
    {
        Expression<Func<Blog, bool>> func = a => a.Id == id;
        Expression<Func<Blog, object>> include = a => a.BlogsCategories.Where(x => !x.IsDeleted);
        IEnumerable<Blog>? response = GetByCriteria([include], func)
                                            ?? throw new Exception("Blog Not Found");

        response.First().Status = BlogStatus.Deleted;
        foreach (var blogsCategory in response.First().BlogsCategories)
        {
            blogsCategory.IsDeleted = true;
        }
        Update(response.First());
        return await SaveAsync() ? true : throw new Exception();
    }

    public async Task<bool> ChangeBlogStatus(int id, ChangeBlogStatusRequestDto changeBlogStatusRequestDto)
    {
        Blog? blog = GetById(id) ?? throw new Exception("Blog Not Found");

        blog.Status = changeBlogStatusRequestDto.IsApproved ? BlogStatus.Approved : BlogStatus.Rejected;
        if (changeBlogStatusRequestDto.IsApproved)
        {
            blog.PublishDate = UserInfo.CurrentTime;
        }
        else
        {
            blog.AdminComment = changeBlogStatusRequestDto.AdminComment ?? null;
        }

        Update(blog);
        return await SaveAsync() ? true : throw new Exception();
    }
}
