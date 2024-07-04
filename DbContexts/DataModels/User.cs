using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace DbContexts.DataModels;

[Table("users")]
[Index("Email", Name = "users_email_key", IsUnique = true)]
public partial class User
{
    [Key]
    [Column("id")]
    public long Id { get; set; }

    [Column("role_id")]
    public int RoleId { get; set; }

    [Column("first_name")]
    [StringLength(48)]
    public string FirstName { get; set; } = null!;

    [Column("last_name")]
    [StringLength(48)]
    public string LastName { get; set; } = null!;

    [Column("profile_name")]
    [StringLength(48)]
    public string? ProfileName { get; set; }

    [Column("email")]
    [StringLength(256)]
    public string Email { get; set; } = null!;

    [Column("password")]
    [StringLength(256)]
    public string Password { get; set; } = null!;

    [Column("updated_date")]
    public DateTime UpdatedDate { get; set; }

    [Column("updated_by")]
    public long UpdatedBy { get; set; }

    [Column("created_date")]
    public DateTime CreatedDate { get; set; }

    [Column("created_by")]
    public long CreatedBy { get; set; }

    [InverseProperty("CreatedByNavigation")]
    public virtual ICollection<Blog> BlogCreatedByNavigations { get; set; } = new List<Blog>();

    [InverseProperty("UpdatedByNavigation")]
    public virtual ICollection<Blog> BlogUpdatedByNavigations { get; set; } = new List<Blog>();

    [InverseProperty("CreatedByNavigation")]
    public virtual ICollection<BlogsCategory> BlogsCategoryCreatedByNavigations { get; set; } = new List<BlogsCategory>();

    [InverseProperty("UpdatedByNavigation")]
    public virtual ICollection<BlogsCategory> BlogsCategoryUpdatedByNavigations { get; set; } = new List<BlogsCategory>();

    [InverseProperty("CreatedByNavigation")]
    public virtual ICollection<Category> CategoryCreatedByNavigations { get; set; } = new List<Category>();

    [InverseProperty("UpdatedByNavigation")]
    public virtual ICollection<Category> CategoryUpdatedByNavigations { get; set; } = new List<Category>();

    [ForeignKey("CreatedBy")]
    [InverseProperty("InverseCreatedByNavigation")]
    public virtual User CreatedByNavigation { get; set; } = null!;

    [InverseProperty("CreatedByNavigation")]
    public virtual ICollection<User> InverseCreatedByNavigation { get; set; } = new List<User>();

    [InverseProperty("UpdatedByNavigation")]
    public virtual ICollection<User> InverseUpdatedByNavigation { get; set; } = new List<User>();

    [ForeignKey("RoleId")]
    [InverseProperty("Users")]
    public virtual Role Role { get; set; } = null!;

    [ForeignKey("UpdatedBy")]
    [InverseProperty("InverseUpdatedByNavigation")]
    public virtual User UpdatedByNavigation { get; set; } = null!;
}

public enum UserStatus{
    Active,
    DeActive,
    Deleted
}
