namespace Dtos.PaginationDto;

public class PaginationDto<T>
{
    public List<T>? DtoList { get; set; }

    public int PageNo { get; set; }

    public int TotalBlogs { get; set; }
}
