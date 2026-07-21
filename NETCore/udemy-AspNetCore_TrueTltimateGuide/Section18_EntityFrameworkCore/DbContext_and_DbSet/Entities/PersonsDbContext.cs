using Microsoft.EntityFrameworkCore;

namespace Entities
{
    public class PersonsDbContext : DbContext
    {
        public PersonsDbContext(DbContextOptions options) : base(options)
        {
        }


        public DbSet<Person> Persons { get; set; }
        public DbSet<Country> Countries { get; set; }

        // 以下の関数はテーブルに対応するインデックス、主キー、リレーションを設定
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // テーブルをマッピング
            modelBuilder.Entity<Country>().ToTable("Countries");
            modelBuilder.Entity<Person>().ToTable("Persons");

            // seed data
            // TODO: JSONからシードを作るのは良くない手順、今学習中なので良しとする
            string counttiesJson = System.IO.File.ReadAllText("countries.json");
            List<Country>? countries = System.Text.Json.JsonSerializer.Deserialize<List<Country>>(counttiesJson);

            foreach (var country in countries!)
            {
                modelBuilder.Entity<Country>().HasData(country);
            }

            string personJson = System.IO.File.ReadAllText("persons.json");
            List<Person>? persons = System.Text.Json.JsonSerializer.Deserialize<List<Person>>(personJson);

            foreach (var pesrson in persons!)
            {
                modelBuilder.Entity<Person>().HasData(pesrson);
            }

        }
    }
}
