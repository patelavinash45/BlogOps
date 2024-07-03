using BlogOpsDbContext;
using Microsoft.EntityFrameworkCore;

namespace Repositories.GenericRepository
{
    public class GenericRepository<T> : IGenericRepository<T> where T : class
    {
        private readonly BlogOpsContext _dbContext;
        private readonly DbSet<T> _dbSet;

        public GenericRepository(BlogOpsContext context)
        {
            _dbContext = context;
            _dbSet = context.Set<T>();
        }

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

        public async Task<int> SaveAsync()
        {
            return await _dbContext.SaveChangesAsync();
        }

        public void Update(T objModel)
        {
            _dbSet.Update(objModel);
        }

        public IEnumerable<T> GetByFunction(Func<T, bool> func)
        {
            return _dbSet.Where(func).ToList();
        }
    }
}