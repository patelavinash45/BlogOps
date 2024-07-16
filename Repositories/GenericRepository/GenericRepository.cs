using System.Linq.Expressions;
using BlogOpsDbContext;
using Microsoft.EntityFrameworkCore;
using Dtos.PaginationDto;

namespace Repositories.GenericRepository;

public class GenericRepository<T>(BlogOpsContext context) : IGenericRepository<T> where T : class
{
    private readonly BlogOpsContext _dbContext = context;
    private readonly DbSet<T> _dbSet = context.Set<T>();

    public void Add(T objModel)
    {
        _dbSet.Add(objModel);
    }

    public IEnumerable<T> GetAll()
    {
        return _dbSet.ToList();
    }

    public T? GetById(int id)
    {
        return _dbSet.Find(id);
    }

    public bool Remove(int id)
    {
        T? objModel = GetById(id);
        if (objModel != null)
        {
            _dbSet.Remove(objModel);
            return true;
        }
        return false;
    }

    public int Save()
    {
        return _dbContext.SaveChanges();
    }

    public async Task<bool> SaveAsync()
    {
        return await _dbContext.SaveChangesAsync() > 0;
    }

    public void Update(T objModel)
    {
        _dbSet.Update(objModel);
    }

    public IEnumerable<T> GetByCriteria(Expression<Func<T, object>>[]? includes = null, Expression<Func<T, bool>>? where = null, Expression<Func<T, Object>>? orderBy = null)
    {
        IQueryable<T> query = _dbSet;
        if (where != null)
        {
            query = query.Where(where);
        }
        if (includes != null)
        {
            foreach (var include in includes)
            {
                query = query.Include(include);
            }
        }
        if (orderBy != null)
        {
            query = query.OrderBy(orderBy);
        }
        return query.AsEnumerable<T>();
    }

    public PaginationFromRepository<T> GetByCriteriaAndPagination(int skip, int pageSize, Expression<Func<T, object>>[]? includes = null, Expression<Func<T, bool>>? where = null, Expression<Func<T, Object>>? orderBy = null)
    {
        IQueryable<T> query = _dbSet;
        if (where != null)
        {
            query = query.Where(where);
        }
        if (includes != null)
        {
            foreach (var include in includes)
            {
                query = query.Include(include);
            }
        }
        if (orderBy != null)
        {
            query = query.OrderBy(orderBy);
        }
        int count = query.Count();
        query = query.Skip(skip).Take(pageSize);
        return new PaginationFromRepository<T>
        {
            TotalCount = count,
            Entities = query.AsEnumerable<T>()
        };
    }
}
