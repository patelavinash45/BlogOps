using System.Linq.Expressions;

namespace Repositories.GenericRepository
{
    public interface IGenericRepository<T> where T : class
    {
        T? GetById(int id);

        IEnumerable<T> GetAll();

        void Add(T objModel);

        bool Remove(int id);

        void Update(T objModel);

        int Save();

        Task<bool> SaveAsync();

        IEnumerable<T> GetByCriteria(Expression<Func<T, object>>[]? includes = null, Expression<Func<T, bool>>? func = null, Expression<Func<T, Object>>? orderBy = null);
    }
}