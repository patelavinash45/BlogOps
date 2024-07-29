using System.Linq.Expressions;
using DbContexts.DataModels;
using Dtos.PaginationDto;

namespace Services.GenericService;

public interface IGenericService<T> where T : BaseEntity
{
    T? GetById(int id);

    IEnumerable<T> GetAll();

    void Add(T objModel);

    bool Remove(int id);

    void Update(T objModel);

    int Save();

    Task<bool> SaveAsync();

    IEnumerable<T> GetByCriteria(Expression<Func<T, object>>[]? includes = null, Expression<Func<T, bool>>? where = null, Expression<Func<T, Object>>? orderBy = null);

    PaginationFromRepository<T> GetByCriteriaAndPagination(int pageNo, int pageSize, Expression<Func<T, object>>[]? includes = null, Expression<Func<T, bool>>? where = null, Expression<Func<T, Object>>? orderBy = null);
}
