using ErrorHandlingExample.Middleware;
using Microsoft.AspNetCore.Mvc;

namespace ErrorHandlingExample
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);
            builder.Services.AddControllers();

            // 統一レスポンス対応、400を上書きする
            builder.Services.Configure<ApiBehaviorOptions>(options =>
            {
                options.InvalidModelStateResponseFactory = context =>
                {
                    var traceId = context.HttpContext.Items["X-Correlation-ID"]?.ToString();

                    var errors = context.ModelState
                        .Where(x => x.Value!.Errors.Count > 0)
                        .SelectMany(x => x.Value!.Errors)
                        .Select(e => e.ErrorMessage)
                        .ToList();

                    var response = new
                    {
                        traceId,
                        errors
                    };

                    return new BadRequestObjectResult(response);
                };
            });

            var app = builder.Build();

            // 統一レスポンス対応
            // 相関IDミドルウェア
            app.UseMiddleware<CorrelationIdMiddleware>();
            // 統一レスポンス対応、例外、※ミドルウェアで対応できるため、例外キャッチは不要(UseExceptionHandler)
            app.UseMiddleware<ExceptionMiddleware>();

            app.UseRouting();
            app.MapControllers();

            app.Run();
        }
    }
}
