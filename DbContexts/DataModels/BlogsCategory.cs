using System.ComponentModel.DataAnnotations.Schema;

namespace DbContexts.DataModels;

[Table("blogs_categories")]
public partial class BlogsCategory : BaseEntity
{
    [Column("blog_id")]
    public int BlogId { get; set; }

    [Column("category_id")]
    public int CategoryId { get; set; }

    [Column("is_deleted")]
    public bool IsDeleted { get; set; }

    [ForeignKey("BlogId")]
    [InverseProperty("BlogsCategories")]
    public virtual Blog Blog { get; set; } = null!;

    [ForeignKey("CategoryId")]
    [InverseProperty("BlogsCategories")]
    public virtual Category Category { get; set; } = null!;

    [ForeignKey("CreatedBy")]
    [InverseProperty("BlogsCategoryCreatedByNavigations")]
    public virtual User CreatedByNavigation { get; set; } = null!;

    [ForeignKey("UpdatedBy")]
    [InverseProperty("BlogsCategoryUpdatedByNavigations")]
    public virtual User UpdatedByNavigation { get; set; } = null!;
}
