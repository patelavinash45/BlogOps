using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace DbContexts.FunctionDtos;

[Keyless]
public record FunctionReturnDto
{
    [Column("return_id")]
    public int ReturnId { get; set; }
}