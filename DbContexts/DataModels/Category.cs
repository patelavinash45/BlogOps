using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace DbContexts.DataModels;

[Table("categories")]
[Index("Name", Name = "categories_name_key", IsUnique = true)]
public partial class Category
{
    [Key]
    [Column("id")]
    public int Id { get; set; }

    [Column("name")]
    [StringLength(48)]
    public string Name { get; set; } = null!;

    [Column("created_by")]
    public int CreatedBy { get; set; }

    [Column("created_date")]
    public DateTime CreatedDate { get; set; }

    [Column("updated_by")]
    public int UpdatedBy { get; set; }

    [Column("updated_date")]
    public DateTime UpdatedDate { get; set; }

    [Column("is_deleted")]
    public bool IsDeleted { get; set; }

    [InverseProperty("Category")]
    public virtual ICollection<BlogsCategory> BlogsCategories { get; set; } = new List<BlogsCategory>();

    [ForeignKey("CreatedBy")]
    [InverseProperty("CategoryCreatedByNavigations")]
    public virtual User CreatedByNavigation { get; set; } = null!;

    [ForeignKey("UpdatedBy")]
    [InverseProperty("CategoryUpdatedByNavigations")]
    public virtual User UpdatedByNavigation { get; set; } = null!;
}
