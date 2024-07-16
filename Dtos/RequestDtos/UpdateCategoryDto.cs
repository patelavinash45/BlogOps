using System.ComponentModel.DataAnnotations;

namespace Dtos.RequestDtos;

public record UpdateCategoryRequestDto
{
    [Range(1, int.MaxValue)]
    public int Id { get; set; }

    [StringLength(48)]
    public required string Name { get; set; }
}
