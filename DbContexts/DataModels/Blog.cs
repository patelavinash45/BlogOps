﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;
using NpgsqlTypes;

namespace DbContexts.DataModels;

[Table("blogs")]
public partial class Blog
{
    [Key]
    [Column("id")]
    public long Id { get; set; }

    [Column("title")]
    [StringLength(128)]
    public string? Title { get; set; }

    [Column("content", TypeName = "character varying")]
    public string? Content { get; set; }

    [Column("admin_comment")]
    [StringLength(256)]
    public string? AdminComment { get; set; }

    [Column("status")]
    public BlogStatus Status { get; set; }

    [Column("created_date")]
    public DateTime CreatedDate { get; set; }

    [Column("updated_date")]
    public DateTime UpdatedDate { get; set; }

    [Column("updated_by")]
    public long UpdatedBy { get; set; }

    [Column("publish_date", TypeName = "timestamp without time zone")]
    public DateTime? PublishDate { get; set; }

    [Column("created_by")]
    public long CreatedBy { get; set; }

    [InverseProperty("Blog")]
    public virtual ICollection<BlogsCategory> BlogsCategories { get; set; } = new List<BlogsCategory>();

    [ForeignKey("CreatedBy")]
    [InverseProperty("BlogCreatedByNavigations")]
    public virtual User CreatedByNavigation { get; set; } = null!;

    [ForeignKey("UpdatedBy")]
    [InverseProperty("BlogUpdatedByNavigations")]
    public virtual User UpdatedByNavigation { get; set; } = null!;
}

public enum BlogStatus
{
    [PgName("Pending")]
    Pending,
    [PgName("Approved")]
    Approved,
    [PgName("Rejected")]

    Rejected,
    [PgName("Deleted")]

    Deleted,
    [PgName("Draft")]

    Draft
}
