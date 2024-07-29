using System.Linq.Expressions;
using DbContexts.DataModels;
using Dtos.PaginationDto;
using Repositories.GenericRepository;

namespace Services.GenericService;

public class GenericService<T>(IGenericRepository<T> genericRepository) : IGenericService<T> where T : BaseEntity
{
    private readonly IGenericRepository<T> _repository = genericRepository;

    public void Add(T objModel) => _repository.Add(objModel);

    public IEnumerable<T> GetAll() => _repository.GetAll();

    public T? GetById(int id) => _repository.GetById(id);

    public bool Remove(int id) => _repository.Remove(id);

    public int Save() => _repository.Save();

    public async Task<bool> SaveAsync() => await _repository.SaveAsync();

    public void Update(T objModel) => _repository.Update(objModel);

    public IEnumerable<T> GetByCriteria(
        Expression<Func<T, object>>[]? includes = null,
        Expression<Func<T, bool>>? where = null,
        Expression<Func<T, object>>? orderBy = null
    ) => _repository.GetByCriteria(includes, where, orderBy);

    public PaginationFromRepository<T> GetByCriteriaAndPagination(
        int pageNo,
        int pageSize,
        Expression<Func<T, object>>[]? includes = null,
        Expression<Func<T, bool>>? where = null,
        Expression<Func<T, object>>? orderBy = null
    ) => _repository.GetByCriteriaAndPagination(pageNo, pageSize, includes, where, orderBy);
}
