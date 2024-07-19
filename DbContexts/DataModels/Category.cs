using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace DbContexts.DataModels;

[Table("categories")]
[Index("Name", Name = "categories_name_key", IsUnique = true)]
public partial class Category : BaseEntity
{
    [Column("name")]
    [StringLength(48)]
    public string Name { get; set; } = null!;

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
