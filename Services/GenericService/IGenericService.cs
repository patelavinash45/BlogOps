namespace Services.GenericService
{
    public interface IGenericService<T> where T : class
    {
        T? GetById(int id);

        IEnumerable<T> GetAll();

        void Add(T objModel);

        bool Remove(int id);

        void Update(T objModel);

        int Save();

        Task<bool> SaveAsync();

        IEnumerable<T> GetByFunction(Func<T, bool> func);
    }
}