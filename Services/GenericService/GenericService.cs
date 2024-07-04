using Repositories.GenericRepository;

namespace Services.GenericService
{
    public class GenericService<T> : IGenericService<T> where T : class
    {
        private readonly IGenericRepository<T> _repository;

        public GenericService(IGenericRepository<T> genericRepository)
        {
            _repository = genericRepository;
        }

        public void Add(T objModel)
        {
            _repository.Add(objModel);
        }

        public IEnumerable<T> GetAll()
        {
            return _repository.GetAll();
        }

        public T? GetById(int id)
        {
            return _repository.GetById(id);
        }

        public bool Remove(int id)
        {
            return _repository.Remove(id);
        }

        public int Save()
        {
            return _repository.Save();
        }

        public async Task<bool> SaveAsync()
        {
            return await _repository.SaveAsync();
        }

        public void Update(T objModel)
        {
            _repository.Update(objModel);
        }

        public IEnumerable<T> GetByFunction(Func<T, bool> func)
        {
            return _repository.GetByFunction(func);
        }
    }
}