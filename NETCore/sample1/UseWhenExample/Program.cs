namespace UseWhenExample
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);
            var app = builder.Build();

            // mwの分岐処理を行う
            app.UseWhen((context) =>
            {
                // チェックする条件を指定する
                return context.Request.Query.ContainsKey("username");
            }, app =>
            {
                // 分岐した場合の処理を記述する
                app.Use(async (context, next) =>
                {
                    var username = context.Request.Query["username"];
                    await context.Response.WriteAsync("Hello from Middleware branch");
                    await next();
                });
            });

            app.Run(async context =>
            {
                await context.Response.WriteAsync("Hello from the main pipeline");
            });

            app.Run();
        }
    }
}
