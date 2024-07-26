using System.ComponentModel.DataAnnotations;
using Dtos.Enums;

namespace Dtos.CommonDtos;

public record CategoryDto
{
    [Range(1, int.MaxValue)]
    public int Id { get; set; }

    [StringLength(48)]
    public required string Name { get; set; }

    public CategoryStatus Status { get; set; }
}
