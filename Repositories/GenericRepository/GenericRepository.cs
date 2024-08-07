using System.Linq.Expressions;
using Microsoft.EntityFrameworkCore;
using Dtos.PaginationDto;
using DbContexts.DataModels;
using Npgsql;
using DbContexts.HelperClass;
using DbContexts.DataContext;
using Dtos.RequestDtos;
using System.Data.Common;

namespace Repositories.GenericRepository;

public class GenericRepository<T>(BlogOpsContext context, UserInfo userInfo) : IGenericRepository<T> where T : BaseEntity
{
    private readonly BlogOpsContext _dbContext = context;
    private readonly UserInfo _userInfo = userInfo;
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
        return await _dbContext.SaveChangesAsync() > 0 ? true : throw new Exception();
    }

    public void Update(T objModel)
    {
        _dbSet.Update(objModel);
    }

    public IEnumerable<T> GetByCriteria(Expression<Func<T, object>>[]? includes = null, Expression<Func<T, bool>>? where = null, Expression<Func<T, object>>? orderBy = null)
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

    public PaginationFromRepository<T> GetByCriteriaAndPagination(int pageNo, int pageSize, Expression<Func<T, object>>[]? includes = null, Expression<Func<T, bool>>? where = null, Expression<Func<T, object>>? orderBy = null)
    {
        int skip = (pageNo - 1) * pageSize;
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
            query = query.OrderByDescending(orderBy);
        }
        int count = query.Count();
        query = query.Skip(skip).Take(pageSize);
        return new PaginationFromRepository<T>
        {
            TotalCount = count,
            Entities = query.AsEnumerable<T>()
        };
    }

    public void ApproveRejectBlog(int id, ChangeBlogStatusRequestDto changeBlogStatusRequestDto)
                    => _dbContext.ApproveOrRejectBlog(id, changeBlogStatusRequestDto.IsApproved, changeBlogStatusRequestDto.AdminComment ?? "", _userInfo.UserId).ToList();

    public void VerifyEmail(int userId, string token)
                            => _dbContext.VerifyEmail(userId, token).ToList();
}
