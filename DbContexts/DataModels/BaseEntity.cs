using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DbContexts.DataModels;

public class BaseEntity {
    [Key]
    [Column("id")]
    public int Id { get; set; }

    [Column("created_date")]
    public DateTime CreatedDate { get; set; }

    [Column("created_by")]
    public int CreatedBy { get; set; }

    [Column("updated_date")]
    public DateTime UpdatedDate { get; set; }

    [Column("updated_by")]
    public int UpdatedBy { get; set; }
}