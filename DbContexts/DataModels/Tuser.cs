using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace DbContexts.DataModels;

[Table("tusers")]
public partial class Tuser
{
    [Key]
    [Column("userid")]
    public int Userid { get; set; }

    [Column("roleid")]
    public int Roleid { get; set; }

    [Column("firstname")]
    [StringLength(50)]
    public string Firstname { get; set; } = null!;

    [Column("email")]
    [StringLength(256)]
    public string Email { get; set; } = null!;

    [Column("password")]
    [StringLength(256)]
    public string Password { get; set; } = null!;

    [Column("modifydate", TypeName = "timestamp without time zone")]
    public DateTime Modifydate { get; set; }

    [Column("isdeleted")]
    public bool Isdeleted { get; set; }

    [Column("modifyby")]
    public int Modifyby { get; set; }

    [Column("createddate", TypeName = "timestamp without time zone")]
    public DateTime Createddate { get; set; }

    [Column("createdby")]
    public int Createdby { get; set; }

    [Column("lastname")]
    [StringLength(50)]
    public string Lastname { get; set; } = null!;

    [ForeignKey("Roleid")]
    [InverseProperty("Tusers")]
    public virtual Trole Role { get; set; } = null!;

    [InverseProperty("CreatedbyNavigation")]
    public virtual ICollection<Tcategory> TcategoryCreatedbyNavigations { get; set; } = new List<Tcategory>();

    [InverseProperty("ModifybyNavigation")]
    public virtual ICollection<Tcategory> TcategoryModifybyNavigations { get; set; } = new List<Tcategory>();

    [InverseProperty("ModifybyNavigation")]
    public virtual ICollection<Tpost> TpostModifybyNavigations { get; set; } = new List<Tpost>();

    [InverseProperty("User")]
    public virtual ICollection<Tpost> TpostUsers { get; set; } = new List<Tpost>();
}
