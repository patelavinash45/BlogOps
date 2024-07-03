using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace DbContexts.DataModels;

[Table("tpostcategories")]
public partial class Tpostcategory
{
    [Key]
    [Column("postcategoryid")]
    public int Postcategoryid { get; set; }

    [Column("postid")]
    public int Postid { get; set; }

    [Column("categoryid")]
    public int Categoryid { get; set; }

    [ForeignKey("Categoryid")]
    [InverseProperty("Tpostcategories")]
    public virtual Tcategory Category { get; set; } = null!;

    [ForeignKey("Postid")]
    [InverseProperty("Tpostcategories")]
    public virtual Tpost Post { get; set; } = null!;
}
