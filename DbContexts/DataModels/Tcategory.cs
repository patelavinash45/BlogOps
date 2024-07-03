using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace DbContexts.DataModels;

[Table("tcategories")]
public partial class Tcategory
{
    [Key]
    [Column("categoryid")]
    public int Categoryid { get; set; }

    [Column("name")]
    [StringLength(50)]
    public string Name { get; set; } = null!;

    [Column("createdby")]
    public int Createdby { get; set; }

    [Column("createddate", TypeName = "timestamp without time zone")]
    public DateTime Createddate { get; set; }

    [Column("modifyby")]
    public int Modifyby { get; set; }

    [Column("modifydate", TypeName = "timestamp without time zone")]
    public DateTime Modifydate { get; set; }

    [Column("isdeleted")]
    public bool Isdeleted { get; set; }

    [ForeignKey("Createdby")]
    [InverseProperty("TcategoryCreatedbyNavigations")]
    public virtual Tuser CreatedbyNavigation { get; set; } = null!;

    [ForeignKey("Modifyby")]
    [InverseProperty("TcategoryModifybyNavigations")]
    public virtual Tuser ModifybyNavigation { get; set; } = null!;

    [InverseProperty("Category")]
    public virtual ICollection<Tpostcategory> Tpostcategories { get; set; } = new List<Tpostcategory>();
}
