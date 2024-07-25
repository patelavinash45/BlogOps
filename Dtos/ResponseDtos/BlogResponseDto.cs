using DbContexts.Enums;

namespace Dtos.ResponseDtos;

public record BlogResponseDto
{
    public int Id { get; set; }

    public required string Title { get; set; }

    public required string Content { get; set; }

    public string? AdminComment { get; set; }

    public BlogStatus Status { get; set; }

    public DateTime CreatedDate { get; set; }

    public List<int>? BlogCategories { get; set; }

    public required string CreatedBy { get; set; }
    
    public required string UpdatedBy { get; set; }
}
