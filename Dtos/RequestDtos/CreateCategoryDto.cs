using System.ComponentModel.DataAnnotations;

namespace Dtos.RequestDtos;

public record CreateCategoryRequestDto
{
    [StringLength(48)]
    public required string Name { get; set; }
}