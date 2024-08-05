using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using DbContexts.Enums;
using Microsoft.EntityFrameworkCore;

namespace DbContexts.DataModels;

[Table("users")]
[Index("Email", Name = "users_email_key", IsUnique = true)]
public partial class User : BaseEntity
{
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

    [Column("status")]
    public UserStatus Status { get; set; }

    [Column("is_verified")]
    public bool IsVerified { get; set; }

    [Column("verification_Token ")]
    [StringLength(60)]
    public string? VerificationToken { get; set; }

    [InverseProperty("CreatedByUser")]
    public virtual ICollection<Blog> BlogCreatedByBlogs { get; set; } = new List<Blog>();

    [InverseProperty("UpdatedByUser")]
    public virtual ICollection<Blog> BlogUpdatedByBlogs { get; set; } = new List<Blog>();

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
