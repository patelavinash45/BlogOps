using DbContexts.DataModels;
using DbContexts.HelperClass;
using Microsoft.EntityFrameworkCore;

namespace BlogOpsDbContext;

public partial class BlogOpsContext : DbContext
{
    private readonly UserInfo _userInfo;
    public BlogOpsContext(UserInfo userInfo)
    {
        _userInfo = userInfo;
    }

    public BlogOpsContext(DbContextOptions<BlogOpsContext> options, UserInfo userInfo)
        : base(options)
    {
        _userInfo = userInfo;
    }

    public override async Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
    {
        var entityList = ChangeTracker.Entries()
                   .Where(a => a.Entity is BaseEntity
                     && (a.State == EntityState.Added || a.State == EntityState.Modified));

        foreach (var entity in entityList)
        {
            BaseEntity? baseEntity = entity.Entity as BaseEntity;
            int userId = _userInfo.UserId;
            baseEntity!.UpdatedBy = userId;
            baseEntity.UpdatedDate = UserInfo.CurrentTime;
            if (entity.State == EntityState.Added)
            {
                baseEntity.CreatedBy = userId;
                baseEntity.CreatedDate = UserInfo.CurrentTime;
            }
        }
        return await base.SaveChangesAsync(cancellationToken);
    }

    public virtual DbSet<Blog> Blogs { get; set; }

    public virtual DbSet<BlogsCategory> BlogsCategories { get; set; }

    public virtual DbSet<Category> Categories { get; set; }

    public virtual DbSet<Role> Roles { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder
            .HasPostgresEnum("blog_status", new[] { "Pending", "Approved", "Rejected", "Deleted", "Draft" })
            .HasPostgresEnum("user_status", new[] { "Active", "Deactive", "Deleted" });

        modelBuilder.Entity<Blog>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("blogs_pkey");

            entity.HasOne(d => d.CreatedByUser).WithMany(p => p.BlogCreatedByBlogs)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("blogs_created_by_fkey");

            entity.HasOne(d => d.UpdatedByUser).WithMany(p => p.BlogUpdatedByBlogs)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("blogs_updated_by_fkey");
        });

        modelBuilder.Entity<BlogsCategory>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("blogs_categories_pkey");

            entity.Property(e => e.IsDeleted).HasDefaultValue(false);

            entity.HasOne(d => d.Blog).WithMany(p => p.BlogsCategories)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("blogs_categories_blog_id_fkey");

            entity.HasOne(d => d.Category).WithMany(p => p.BlogsCategories)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("blogs_categories_category_id_fkey");

            entity.HasOne(d => d.CreatedByNavigation).WithMany(p => p.BlogsCategoryCreatedByNavigations)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("blogs_categories_created_by_fkey");

            entity.HasOne(d => d.UpdatedByNavigation).WithMany(p => p.BlogsCategoryUpdatedByNavigations)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("blogs_categories_updated_by_fkey");
        });

        modelBuilder.Entity<Category>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("categories_pkey");

            entity.Property(e => e.IsDeleted).HasDefaultValue(false);

            entity.HasOne(d => d.CreatedByNavigation).WithMany(p => p.CategoryCreatedByNavigations)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("categories_created_by_fkey");

            entity.HasOne(d => d.UpdatedByNavigation).WithMany(p => p.CategoryUpdatedByNavigations)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("categories_updated_by_fkey");
        });

        modelBuilder.Entity<Role>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("roles_pkey");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("users_pkey");

            entity.HasOne(d => d.CreatedByNavigation).WithMany(p => p.InverseCreatedByNavigation)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("users_created_by_fkey");

            entity.HasOne(d => d.Role).WithMany(p => p.Users)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("users_role_id_fkey");

            entity.HasOne(d => d.UpdatedByNavigation).WithMany(p => p.InverseUpdatedByNavigation)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("users_updated_by_fkey");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);

}
