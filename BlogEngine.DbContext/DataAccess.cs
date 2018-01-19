using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;
using BlogEngine.DTO;
using System.Data.Entity.ModelConfiguration.Conventions;

namespace BlogEngine.Db
{
    public class BlogEngineDbContext:DbContext
    {
        public BlogEngineDbContext():base("BlogEngineConnection")
        {

        }

        public DbSet<Post> Posts
        {
            get;set;
        }
        public DbSet<Category> Categories
        {
            get;set;
        }
        public DbSet<Tag> Tags
        {
            get;set;
        }
        public DbSet<Comment> Comments {
            get; set;
        }
        public DbSet<User> Users
        {
            get;set;
        }
        public DbSet<ResponseDTO> ResponseDTOs
        {
            get;set;
        }
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            //base.OnModelCreating(modelBuilder);
            modelBuilder.Conventions.Remove<PluralizingTableNameConvention>();
        }
    }
}
