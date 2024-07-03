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

        Task<int> SaveAsync();

        IEnumerable<T> GetByFunction(Func<T, bool> func);
    }
}