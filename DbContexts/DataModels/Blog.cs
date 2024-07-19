using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using DbContexts.Enums;

namespace DbContexts.DataModels;

[Table("blogs")]
public partial class Blog : BaseEntity
{
    [Column("title")]
    [StringLength(128)]
    public string Title { get; set; } = null!;

    [Column("content", TypeName = "character varying")]
    public string Content { get; set; } = null!;

    [Column("admin_comment")]
    [StringLength(256)]
    public string? AdminComment { get; set; }

    [Column("status")]
    public BlogStatus Status { get; set; }

    [Column("publish_date", TypeName = "timestamp without time zone")]
    public DateTime? PublishDate { get; set; }

    [InverseProperty("Blog")]
    public virtual ICollection<BlogsCategory> BlogsCategories { get; set; } = new List<BlogsCategory>();

    [ForeignKey("CreatedBy")]
    [InverseProperty("BlogCreatedByBlogs")]
    public virtual User CreatedByUser { get; set; } = null!;

    [ForeignKey("UpdatedBy")]
    [InverseProperty("BlogUpdatedByBlogs")]
    public virtual User UpdatedByUser { get; set; } = null!;
}
