using Entities.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Text;

namespace Entities
{
    public class RepositoryContext : DbContext
    {
        public RepositoryContext(DbContextOptions options) 
            : base(options) 
        { }

        public DbSet<Post> Posts { get; set; }
        public DbSet<Role> Roles { get; set; }
        public DbSet<Topic> Topics { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Credential> Credentials { get; set; }
        public DbSet<Like> Likes { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Like>().
                HasKey(l => new { l.PostId, l.UserId });

            modelBuilder.Entity<Reply>().
                HasKey(r => new { r.BasePostId, r.AnswPostId });

            modelBuilder.Entity<Reply>().
                HasOne(r => r.BasePost).WithMany(r => r.BasePosts);

            modelBuilder.Entity<Reply>().
                HasOne(r => r.AnswPost).WithMany(r => r.AnswPosts);

        }

    }
}
