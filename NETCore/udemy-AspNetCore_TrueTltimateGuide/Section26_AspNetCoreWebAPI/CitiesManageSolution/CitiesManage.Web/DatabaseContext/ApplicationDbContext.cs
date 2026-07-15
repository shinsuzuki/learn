using CitiesManage.Web.Models;
using Microsoft.EntityFrameworkCore;

namespace CitiesManage.Web.DatabaseContext
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext() { }

        public ApplicationDbContext(DbContextOptions options) : base(options)
        {
        }

        public virtual DbSet<City> Cities { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<City>().HasData(new City()
            {
                CityID = Guid.Parse("FABDAEB1-7531-4034-9DB1-77C31FF14C79"),
                CityName = "New York"
            });

            modelBuilder.Entity<City>().HasData(new City()
            {
                CityID = Guid.Parse("FABDAEB1-7531-4034-9DB1-77C31FF14C72"),
                CityName = "London"
            });

        }
    }
}
