using System;
using System.Collections.Generic;
using DbContexts.DataModels;
using Microsoft.EntityFrameworkCore;

namespace BlogOpsDbContext;

public partial class BlogOpsContext : DbContext
{
    public BlogOpsContext()
    {
    }

    public BlogOpsContext(DbContextOptions<BlogOpsContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Tcategory> Tcategories { get; set; }

    public virtual DbSet<Tpost> Tposts { get; set; }

    public virtual DbSet<Tpostcategory> Tpostcategories { get; set; }

    public virtual DbSet<Trole> Troles { get; set; }

    public virtual DbSet<Tuser> Tusers { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseNpgsql("User ID = postgres;Password=aVI@12345;Server=localhost;Port=5432;Database=blogops;Pooling=true;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.HasPostgresEnum("status_t", new[] { "1", "2", "3" });

        modelBuilder.Entity<Tcategory>(entity =>
        {
            entity.HasKey(e => e.Categoryid).HasName("tcategories_pkey");

            entity.Property(e => e.Isdeleted).HasDefaultValue(false);

            entity.HasOne(d => d.CreatedbyNavigation).WithMany(p => p.TcategoryCreatedbyNavigations)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("tcategories_createdby_fkey");

            entity.HasOne(d => d.ModifybyNavigation).WithMany(p => p.TcategoryModifybyNavigations)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("tcategories_modifyby_fkey");
        });

        modelBuilder.Entity<Tpost>(entity =>
        {
            entity.HasKey(e => e.Postid).HasName("tpost_pkey");

            entity.Property(e => e.Isdeleted).HasDefaultValue(false);

            entity.HasOne(d => d.ModifybyNavigation).WithMany(p => p.TpostModifybyNavigations)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("tpost_modifyby_fkey");

            entity.HasOne(d => d.User).WithMany(p => p.TpostUsers)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("tpost_userid_fkey");
        });

        modelBuilder.Entity<Tpostcategory>(entity =>
        {
            entity.HasKey(e => e.Postcategoryid).HasName("tpostcategories_pkey");

            entity.HasOne(d => d.Category).WithMany(p => p.Tpostcategories)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("tpostcategories_categoryid_fkey");

            entity.HasOne(d => d.Post).WithMany(p => p.Tpostcategories)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("tpostcategories_postid_fkey");
        });

        modelBuilder.Entity<Trole>(entity =>
        {
            entity.HasKey(e => e.Roleid).HasName("troles_pkey");
        });

        modelBuilder.Entity<Tuser>(entity =>
        {
            entity.HasKey(e => e.Userid).HasName("tusers_pkey");

            entity.Property(e => e.Isdeleted).HasDefaultValue(false);

            entity.HasOne(d => d.Role).WithMany(p => p.Tusers)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("tusers_roleid_fkey");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
