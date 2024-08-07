using System.Linq.Expressions;
using System.Security.Authentication;
using DbContexts.DataModels;
using DbContexts.Enums;
using Dtos.CommonDtos;
using Dtos.Constants;
using Dtos.Enums;
using Dtos.Mappers;
using Dtos.PaginationDto;
using Dtos.RequestDtos;
using Dtos.ResponseDtos;
using Microsoft.AspNetCore.Http;
using Npgsql;
using Repositories.GenericRepository;
using Services.BlogService;
using Services.GenericService;
using Services.JwtService;
using Services.MailService;

namespace Services.UserService;

public class UserService(IGenericRepository<User> genericRepository, IJwtService jwtService, IHttpContextAccessor httpContextAccessor, IBlogService blogService, IMailService mailService) : GenericService<User>(genericRepository), IUserService
{
    private readonly IJwtService _jwtService = jwtService;
    private readonly IHttpContextAccessor _httpContextAccessor = httpContextAccessor;
    private readonly IBlogService _blogService = blogService;
    private readonly IMailService _mailService = mailService;

    public UserDto GetUser(int id)
    {
        User? user = GetById(id) ?? throw new Exception("User Not Found");
        return user.ToUserDto();
    }

    public UserDto GetUserByToken(string token)
    {
        Expression<Func<User, bool>> where = a => a.VerificationToken != null && a.VerificationToken == token;
        IEnumerable<User> response = GetByCriteria(where: where);
        return response.Any() ? response.First().ToUserDto() : throw new Exception("User Not Found");
    }

    public LogInResponseDto ValidateUser(LogInRequestDto logInRequestDto)
    {
        Expression<Func<User, bool>> where = a => a.Email == logInRequestDto.Email;
        Expression<Func<User, object>> include = a => a.Role;
        IEnumerable<User> response = GetByCriteria([include], where);
        if (response.Any() && response.First().Status == UserStatus.Active
                       && VerifyPassword(response.First().Password, logInRequestDto.Password))
        {
            _httpContextAccessor.HttpContext!.Session.SetInt32("userId", response.First().Id);
            string jwtToken = _jwtService.CreateJwtToken(response.First(), logInRequestDto.KeepMeSignIn ? 60 : 20);
            return new LogInResponseDto
            {
                Email = logInRequestDto.Email,
                JwtToken = jwtToken,
                FirstName = response.First().FirstName,
                LastName = response.First().LastName,
                ProfileName = response.First().ProfileName,
                RoleType = response.First().RoleId == 1 ? RoleEnum.Admin : RoleEnum.Author,
            };
        }
        throw new AuthenticationException(ConstantValue.InvalidCredentials);
    }

    public PaginationDto<UserDto> GetUsers(UserFilterDto userFilterDto)
    {
        Expression<Func<User, bool>> where = a => (userFilterDto.Role == RoleEnum.All
                                        || (userFilterDto.Role == RoleEnum.Admin && a.RoleId == 1)
                                        || (userFilterDto.Role == RoleEnum.Author && a.RoleId == 2))
                                        && a.Status != UserStatus.Deleted
                                        && (userFilterDto.Status == UserStatus.All || userFilterDto.Status == a.Status)
                                        && (string.IsNullOrEmpty(userFilterDto.SearchContent) || (a.FirstName + " " + a.LastName).ToLower().Contains(userFilterDto.SearchContent.ToLower()));
        Expression<Func<User, object>> orderBy = a => a.FirstName;
        PaginationFromRepository<User> paginationFromRepository
                                    = GetByCriteriaAndPagination(userFilterDto.PageNo, userFilterDto.PageSize, where: where, orderBy: orderBy);
        List<UserDto> userDtos = [];
        foreach (User user in paginationFromRepository.Entities ?? [])
        {
            userDtos.Add(user.ToUserDto());
        }

        int totalPages = (paginationFromRepository.TotalCount + userFilterDto.PageSize - 1)
                                                                           / userFilterDto.PageSize;
        return new PaginationDto<UserDto>
        {
            DtoList = userDtos,
            TotalCount = paginationFromRepository.TotalCount,
            PageNo = userFilterDto.PageNo,
            IsNext = userFilterDto.PageNo < totalPages,
            IsPrevious = userFilterDto.PageNo != 1,
        };
    }

    public async Task<bool> CreateUser(CreateUserRequestDto createUserRequestDto)
    {
        User user = createUserRequestDto.ToUser();
        Add(user);
        if (await SaveAsync())
        {
            await _mailService.NewUser(user);
            return true;
        }
        else
        {
            throw new Exception();
        }
    }

    public async Task<bool> UpdateUser(UserDto userDto)
    {
        User? user = GetById(userDto.Id) ?? throw new Exception("User Not Found");
        user = userDto.ToUser(user);
        Update(user);
        if (userDto.Status == UserStatus.Deleted)
            OnUserDeleted(user.Id);
        return await SaveAsync();
    }

    public async Task<bool> DeleteUser(int id)
    {
        User? user = GetById(id) ?? throw new Exception("User Not Found");
        user.Status = UserStatus.Deleted;
        Update(user);
        return await SaveAsync();
    }

    public bool EmailExist(string email)
    {
        Expression<Func<User, bool>> where = a => a.Email.ToLower().Contains(email.ToLower());
        IEnumerable<User> users = GetByCriteria(where: where);
        return users.Any();
    }

    public void VerifyUser(int id, string token) => VerifyEmail(id, token);

    private static bool VerifyPassword(string hashPassword, string enteredPassword)
    {
        return BCrypt.Net.BCrypt.Verify(enteredPassword, hashPassword);
    }

    private void OnUserDeleted(int userId)
    {
        Expression<Func<Blog, bool>> where = a => a.CreatedBy == userId && a.Status != BlogStatus.Deleted;
        Expression<Func<Blog, object>> include = a => a.BlogsCategories.Where(x => !x.IsDeleted);

        IEnumerable<Blog> blogs = _blogService.GetByCriteria(where: where, includes: [include]);

        foreach (Blog blog in blogs ?? [])
        {
            blog.Status = BlogStatus.Deleted;
            foreach (BlogsCategory blogsCategory in blog.BlogsCategories ?? [])
            {
                blogsCategory.IsDeleted = true;
            }
            _blogService.Update(blog);
        }
    }
}

