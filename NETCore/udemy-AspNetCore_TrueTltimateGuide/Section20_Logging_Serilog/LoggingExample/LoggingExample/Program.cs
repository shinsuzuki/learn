using LoggingExample.Extensions;
using LoggingExample.Middleware;
using Microsoft.AspNetCore.HttpLogging;

namespace LoggingExample
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);
            // NLog を読み込む
            //builder.Logging.ClearProviders();
            //builder.Host.UseNLog();
            builder.AddMyAppLogging();

            builder.Services.AddControllers();

            // 「HTTP リクエスト／レスポンスの内容をミドルウェアで横取りしてログに書く」処理。
            builder.Services.AddHttpLogging(logging =>
            {
                logging.LoggingFields = HttpLoggingFields.All;
            });

            var app = builder.Build();
            app.Logger.LogInformation("logger example start");

            // 「HTTP リクエスト／レスポンスの内容をミドルウェアで横取りしてログに書く」処理。
            app.UseMiddleware<CorrelationIdMiddleware>();
            app.UseHttpLogging();

            //app.MapGet("/", () => "Hello World!");
            app.UseRouting();
            app.MapControllers();

            app.Run();
        }
    }
}
