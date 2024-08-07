using System.Linq.Expressions;
using DbContexts.DataModels;
using Dtos.PaginationDto;
using Dtos.RequestDtos;
using Npgsql;

namespace Repositories.GenericRepository;

public interface IGenericRepository<T> where T : BaseEntity
{
    T? GetById(int id);

    IEnumerable<T> GetAll();

    void Add(T objModel);

    bool Remove(int id);

    void Update(T objModel);

    int Save();

    Task<bool> SaveAsync();

    IEnumerable<T> GetByCriteria(Expression<Func<T, object>>[]? includes = null, Expression<Func<T, bool>>? where = null, Expression<Func<T, object>>? orderBy = null);

    PaginationFromRepository<T> GetByCriteriaAndPagination(int pageNo, int pageSize, Expression<Func<T, object>>[]? includes = null, Expression<Func<T, bool>>? where = null, Expression<Func<T, object>>? orderBy = null);

    void ApproveRejectBlog(int id, ChangeBlogStatusRequestDto changeBlogStatusRequestDto);

    void VerifyEmail(int userId, string token);
}
