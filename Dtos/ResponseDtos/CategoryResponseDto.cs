namespace Dtos.ResponseDtos;

public record CategoryResponseDto
{
    public int Id { get; set; }

    public required string Name { get; set; }
}
