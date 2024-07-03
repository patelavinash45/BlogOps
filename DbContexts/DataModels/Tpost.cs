using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace DbContexts.DataModels;

[Table("tpost")]
public partial class Tpost
{
    [Key]
    [Column("postid")]
    public int Postid { get; set; }

    [Column("userid")]
    public int Userid { get; set; }

    [Column("title")]
    [StringLength(100)]
    public string? Title { get; set; }

    [Column("content", TypeName = "character varying")]
    public string? Content { get; set; }

    [Column("createddate", TypeName = "timestamp without time zone")]
    public DateTime Createddate { get; set; }

    [Column("modifydate", TypeName = "timestamp without time zone")]
    public DateTime Modifydate { get; set; }

    [Column("modifyby")]
    public int Modifyby { get; set; }

    [Column("isdeleted")]
    public bool Isdeleted { get; set; }

    [Column("rejectednote")]
    [StringLength(500)]
    public string? Rejectednote { get; set; }

    [Column("publishdate", TypeName = "timestamp without time zone")]
    public DateTime? Publishdate { get; set; }

    [ForeignKey("Modifyby")]
    [InverseProperty("TpostModifybyNavigations")]
    public virtual Tuser ModifybyNavigation { get; set; } = null!;

    [InverseProperty("Post")]
    public virtual ICollection<Tpostcategory> Tpostcategories { get; set; } = new List<Tpostcategory>();

    [ForeignKey("Userid")]
    [InverseProperty("TpostUsers")]
    public virtual Tuser User { get; set; } = null!;
}
