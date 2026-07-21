using Console1.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace Console1
{
    public class JoinDto
    {
        public string? CategoryName { get; set; }
        public string? ProductName { get; set; }
        public decimal ProductPrice { get; set; }
    }

    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("> start");


            try
            {
                var config = new ConfigurationBuilder()
                    .SetBasePath(Directory.GetCurrentDirectory())
                    .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
                    .Build();

                var connectionString = config["ConnectionStrings:Default"];

                var options = new DbContextOptionsBuilder<TestEfCoreDbContext>()
                    .UseSqlServer(connectionString)
                    .Options;

                using var db = new TestEfCoreDbContext(options);

                // select
                //var products = db.Products.ToList();

                // add, commit
                //var newProduct = new Product { Name = "キーボード", Price = 12000, CategoryId = 1 };
                //db.Products.Add(newProduct);
                //db.SaveChanges();

                // update, commit
                //var updateItem = db.Products.FirstOrDefault(x => x.Name == "キーボード");
                //if (updateItem != null)
                //{
                //    updateItem.Price *= (decimal)1.2;
                //    db.SaveChanges();
                //}

                // delete, commit
                //var delTarget = db.Products.FirstOrDefault(x => x.Name == "マウス");
                //if (delTarget != null)
                //{
                //    db.Products.Remove(delTarget);
                //    db.SaveChanges();
                //}

                //------------------------
                Console.WriteLine("== where");
                var target = db.Products.Where(p => p.Name == "4Kモニター").FirstOrDefault();
                Console.WriteLine($"4Kモニター: {target?.Price}");
                //------------------------



                //------------------------
                Console.WriteLine("== IncludeでJOINを発行してカテゴリ名も同時に取得（Eager Loading）");
                //------------------------
                // Include は JOIN の代替ではなく、ORM の関連読み込み機能。
                // Include → 親エンティティに子エンティティを“くっつける”
                // JOIN の代わりに使うものではない
                // DTO を返す API では使わない
                // 複雑な結合では使わない
                // 既存調査改修では出番が少ない
                //------------------------
                var list = db.Products
                             .Include(p => p.Category)
                             .AsNoTracking() // 追跡をオフにして読み取りを高速化、取得したデータをプログラム内で書き換えて db.SaveChanges() を呼んでも、データベースには一切反映されません
                             .Where(p => p.Price > 3000)
                             .ToList();

                foreach (var item in list)
                {
                    // p.Category が NULL の場合の安全対策（?.）を含めると安心です
                    string categoryName = item.Category?.Name ?? "カテゴリなし";
                    Console.WriteLine($"カテゴリ: {categoryName} | 商品名: {item.Name} | 価格: {item.Price:C}");
                }
                //------------------------

                //------------------------
                Console.WriteLine("== inner join");
                //------------------------
                var query = from p in db.Products
                            join c in db.Categories
                                on p.CategoryId equals c.CategoryId
                            select new
                            {
                                CategoryName = c.Name,
                                ProductName = p.Name,
                                ProductPrice = p.Price
                            };

                foreach (var item in query)
                {
                    Console.WriteLine($"カテゴリ: {item.CategoryName} | 商品名: {item.ProductName} | 価格: {item.ProductPrice:C}");
                }
                //------------------------


                //------------------------
                Console.WriteLine("== SqlQuery");
                //------------------------
                // SQLを実行するときはFromSQLよりSqlQueryを使う
                // 任意の型（DTO・匿名型に近い構造）を返せる
                // DbSet が不要
                // SELECT の列名と DTO のプロパティ名が一致していれば OK
                // JOIN の結果をそのまま受け取れる
                // JOIN を SQL で書く人にとって最も使いやすい
                //------------------------
                var results = db.Database.SqlQuery<JoinDto>(@$"
                        select 
                            c.Name as CategoryName, 
                            p.Name as ProductName, 
                            p.Price as ProductPrice 
                        from 
                            Products as p 
                        left join 
                            Categories as c 
                        on 
                            p.CategoryId = c.CategoryID").ToList();

                foreach (var item in results)
                {
                    Console.WriteLine($"{item.CategoryName}, {item.ProductName}, {item.ProductPrice}");
                }
                //------------------------



                Console.WriteLine("< end");
            }
            catch (Exception ex)
            {
                Console.WriteLine("----------------------------------------");
                Console.WriteLine(ex.ToString());
                Console.WriteLine("----------------------------------------");
            }

            Console.WriteLine("any key to exit...");
            Console.ReadLine();
        }
    }
}
