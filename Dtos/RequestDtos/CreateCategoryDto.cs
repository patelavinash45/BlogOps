using System.ComponentModel.DataAnnotations;

namespace Dtos.RequestDtos;

public class CreateCategoryRequestDto
{
    [StringLength(48)]
    public required string Name { get; set; }
}