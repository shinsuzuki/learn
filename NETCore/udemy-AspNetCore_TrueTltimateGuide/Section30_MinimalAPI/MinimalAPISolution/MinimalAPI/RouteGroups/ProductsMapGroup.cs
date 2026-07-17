using MinimalAPI.Models;
using MiniValidation;
using System.Text;

namespace MinimalAPI.RouteGroups
{
    public static class ProductsMapGroup
    {
        // Results.Json<T>(obj) — JSON を返す（ファイル内で使用）
        // Results.BadRequest(objOrMessage) — 400 を返す（ファイル内で使用）
        // Results.Created<T>(location, obj) — 201 を返す（ファイル内で使用）
        // Results.NoContent() — 204 を返す（ファイル内で使用）
        // Results.Ok<T>(obj) — 200 を返す
        // Results.NotFound() — 404 を返す
        // Results.Problem(detail) — RFC 準拠の問題レスポンス
        // Results.Accepted(location, obj) / Results.AcceptedAtRoute(...)
        // Results.Redirect(url) / Results.RedirectPermanent(url)
        // Results.Content(string, contentType) — 指定 MIME で文字列を返す
        // Results.File(...) / Results.PhysicalFile(...) — ファイルレスポンス（ダウンロード）

        // 設計のアドバイス
        // Minimal APIのエンドポイント（ハンドラー内部）で HttpContext を多用すると、
        // コードのテスト（単体テスト）が難しくなり、Minimal API本来の「見通しの良さ」が失われがちです。
        //そのため、上記の 1〜4（ヘッダー、クッキー、IP、認証など）のような共通処理を行う場合は、
        //エンドポイントの関数内に直接書くのではなく、
        //「ミドルウェア（Middleware）」や「エンドポイントフィルタ（IEndpointFilter）」の中に
        //HttpContext を閉じ込めるのが、アーキテクチャとして非常に綺麗な落としどころになります。

        private static List<Product> products = new List<Product>()
        {
            new Product() {Id = 1, ProductName = "Smart Phone"},
            new Product() {Id = 2, ProductName = "Smart Tv "},
        };

        public static RouteGroupBuilder ProductsAPI(this RouteGroupBuilder group)
        {
            // Get /products
            group.MapGet("/", async (HttpContext context) =>
            {
                //await context.Response.WriteAsync("Get Hello World!"); 
                //var content = string.Join("\n", products.Select(x => x.ToString()));
                //await context.Response.WriteAsync(content);
                //return Results.Ok<List<Product>>(products);
                //return Results.Json<List<Product>>(products);
                return TypedResults.Json<List<Product>>(products);
            })
            .Produces<List<Product>>(StatusCodes.Status200OK);

            // Get /products/{id}
            group.MapGet("/{id}", async (HttpContext context, int id) =>
            {
                //await context.Response.WriteAsync("Get Hello World!"); 
                var content = products.FirstOrDefault(x => x.Id == id);
                if (content == null)
                {
                    //context.Response.StatusCode = 400;
                    //await context.Response.WriteAsync("Incorrect Proeuct ID");
                    //return Results.BadRequest("Incorrect Proeuct ID");

                    // 通常の異常系は Results.Problem を使用
                    // これにより、500例外や400検証エラーと全く同じ項目（Title, Status等）のJSON構造になる
                    return Results.Problem(
                                statusCode: StatusCodes.Status404NotFound,
                                title: "対象の商品が見つかりません。",
                                detail: $"ID: {id} に該当するデータはシステムに存在しません。"
                            );
                }
                else
                {
                    //await context.Response.WriteAsync(content.ToString());
                    //await context.Response.WriteAsync(JsonSerializer.Serialize(content));
                    //return Results.Ok<Product>(content);
                    return Results.Json<Product>(content);
                }
            })
            .Produces<Product>(StatusCodes.Status200OK);

            // Post /products
            group.MapPost("/", async (HttpContext context, Product product) =>
            {
                // 
                // 2. 検証を実行し、エラーがあれば 400 Bad Request とエラー内容を返す
                if (!MiniValidator.TryValidate(product, out var errors))
                {
                    return Results.ValidationProblem(errors);
                }

                // 手動で入力チェックする場合
                //if (string.IsNullOrWhiteSpace(product.ProductName))
                //{
                //    var errors = new Dictionary<string, string[]> {
                //        { "Name", new[] { "商品名は必須項目です。" } }
                //    };

                //    // ValidationProblemを使うと、自動的に「400」「エラー詳細」が標準構造で返る
                //    return Results.ValidationProblem(errors);
                //}

                products.Add(product);
                //await context.Response.WriteAsync("Product Added");
                return Results.Created<Product>("", product);
            })
            .Produces(StatusCodes.Status201Created);

            // Put /products
            group.MapPut("/{id:int}", async (HttpContext context, int id, Product product) =>
            {
                var item = products.FirstOrDefault(x => x.Id == id);
                if (item == null)
                {
                    //context.Response.StatusCode = 400;
                    //await context.Response.WriteAsync("Incorrect Product ID");
                    //return;
                    return Results.BadRequest(new { message = "Incorrect Product ID" });
                }

                item.ProductName = product.ProductName;
                //await context.Response.WriteAsync("Product Updated");
                return Results.NoContent();
            })
            .Produces(StatusCodes.Status204NoContent);

            // Delete /products
            group.MapDelete("/{id:int}", async (HttpContext context, int id) =>
            {
                var item = products.FirstOrDefault(x => x.Id == id);
                if (item == null)
                {
                    //context.Response.StatusCode = 400;
                    //await context.Response.WriteAsync("Incorrect Product ID");
                    //return;
                    return Results.BadRequest(new { message = "Incorrect Product ID" });
                }

                products.Remove(item);
                // await context.Response.WriteAsync("Product Deleted");
                //Results.Ok(new { messsage = "Product Deleted" });
                return Results.NoContent();
            })
            .Produces(StatusCodes.Status204NoContent);

            group.MapGet("/file-download/{id}", async (string id) =>
            {
                var list = new List<string>();
                list.Add("a,b,c");
                list.Add("d,e,f");
                var content = string.Join("\n", list);

                byte[] fileBytes = Encoding.UTF8.GetBytes(content);
                return Results.File(
                    fileBytes,
                    contentType: "text/csv",
                    fileDownloadName: $"sample_{id}.csv");
            })
            .Produces(StatusCodes.Status200OK);

            group.MapGet("/error-test", () =>
            {
                // あえて例外を発生させる（上の UseExceptionHandler で自動キャッチされる）
                throw new InvalidOperationException("データベースへの接続に失敗しました。");
            });

            return group;
        }
    }
}
