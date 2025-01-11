using _18_E_LEARN.DataAccess.Data.Models.Categories;
using _18_E_LEARN.DataAccess.Data.Models.Courses;
using _18_E_LEARN.DataAccess.Data.Models.User;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _18_E_LEARN.DataAccess.Data.Context
{
    public class AppDbContext : IdentityDbContext

    {
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            IConfigurationRoot configuration = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json")
                .Build();
            var connectionStrings = configuration.GetConnectionString("DefaultConnection");
            optionsBuilder.UseSqlServer(connectionStrings);

        }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);
            // Makes categorie's name unique
            builder.Entity<Category>()
                .HasIndex(c => c.Name).IsUnique();
            // Makes course's name unique
            builder.Entity<Course>()
                .HasIndex(c => c.Name).IsUnique();
        }

        public DbSet<AppUser> AppUsers { get; set; }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Course> Courses { get; set; }
    }
}
