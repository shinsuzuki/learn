using Microsoft.AspNetCore.Diagnostics;
using Microsoft.AspNetCore.Mvc;

namespace MinimalAPI.Extensions
{
    public static class ExceptionHandlerExtensions
    {
        /// <summary>
        /// 別クラス化した例外ハンドラを適用します。
        /// Program.cs では app.UseCustomExceptionHandler(app.Environment); を呼んでください。
        /// </summary>
        public static void UseCustomExceptionHandler(this IApplicationBuilder app, IHostEnvironment env)
        {
            app.UseExceptionHandler(exceptionHandlerApp =>
            {
                exceptionHandlerApp.Run(async context =>
                {
                    var exceptionHandlerPathFeature = context.Features.Get<IExceptionHandlerPathFeature>();
                    var exception = exceptionHandlerPathFeature?.Error;

                    // ログ出力（実務では ILogger を使ってください）
                    // Console.WriteLine($"[予期せぬ例外をキャッチ]: {exception?.Message}");

                    // 静的クラスの制約を避けるため、ILoggerFactory からロガーを作成する
                    var loggerFactory = context.RequestServices.GetRequiredService<ILoggerFactory>();

                    // ログに表示されるカテゴリ名（クラス名に相当する部分）を文字列で指定します
                    var logger = loggerFactory.CreateLogger("MinimalAPI.Extensions.ExceptionHandlerExtensions");

                    // NLog等に例外オブジェクトを丸ごと渡してエラーログを出力
                    logger.LogError(exception, "[Unhandled Exception Occurred] Path: {Path}, Message: {Message}", context.Request.Path, exception?.Message);

                    context.Response.StatusCode = StatusCodes.Status500InternalServerError;
                    await context.Response.WriteAsJsonAsync(new ProblemDetails
                    {
                        Status = StatusCodes.Status500InternalServerError,
                        Title = "サーバー内部で予期せぬエラーが発生しました。",
                        Detail = env.IsDevelopment() ? exception?.Message : "システム管理者に連絡してください。",
                        Instance = context.Request.Path
                    });
                });
            });
        }
    }
}