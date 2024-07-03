using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace DbContexts.DataModels;

[Table("troles")]
public partial class Trole
{
    [Key]
    [Column("roleid")]
    public int Roleid { get; set; }

    [Column("rolename")]
    [StringLength(255)]
    public string Rolename { get; set; } = null!;

    [InverseProperty("Role")]
    public virtual ICollection<Tuser> Tusers { get; set; } = new List<Tuser>();
}
