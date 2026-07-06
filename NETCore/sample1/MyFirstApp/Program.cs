namespace MyFirstApp
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);
            var app = builder.Build();

            // パスを無視する
            //app.MapGet("/", () => "Hello World!");


            // 以下は全てのリクエストに対して処理を行う

            // ミドルウェアの追加
            app.Use(async (context, next) =>
            {
                Console.WriteLine("Hello World!");
                await next();
            });

            // 全てのリクエストを処理
            app.Run(async (HttpContext context) =>
            {
                // context.Response.StatusCode = 400;
                //Console.WriteLine($"path: {context.Request.Path}");

                //context.Response.Headers.Append("X-Custom-Header", "Hello World");
                //context.Response.Headers.Append("X-Custom-Header2", "Hello World");
                //context.Response.Headers.Append("content-type", "text/html; charset=utf-8");
                //await context.Response.WriteAsync("<h1>Hello</h1>");
                //await context.Response.WriteAsync("<h2>World</h2>");

                // ボディ部を取得
                var reader = new StreamReader(context.Request.Body);
                var bodyContent = await reader.ReadToEndAsync();

                if (bodyContent == "Hello")
                {
                    Console.WriteLine($"Body Content: {bodyContent}");
                }
            });

            app.Run();
        }
    }
}
