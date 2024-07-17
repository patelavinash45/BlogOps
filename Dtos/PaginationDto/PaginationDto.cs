namespace Dtos.PaginationDto;

public record PaginationDto<T>
{
    public List<T>? DtoList { get; set; }

    public int PageNo { get; set; }

    public int TotalCount { get; set; }

    public bool IsNext { get; set; }

    public bool IsPrevious { get; set; }
}

public record PaginationFromRepository<T>
{
    public IEnumerable<T>? Entities { get; set; }

    public int TotalCount { get; set; }
}
