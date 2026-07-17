using MinimalAPI.EndPointFilter;
using MinimalAPI.Extensions;
using MinimalAPI.RouteGroups;
using NLog;
using NLog.Web;

namespace MinimalAPI
{
    public class Program
    {
        // エラーはAPIの標準規格である Problem Details（RFC 7807） に
        // 準拠したレスポンス構造に統一するのがベストプラクティスです。

        // ASP.NET CoreのMinimal API（最小限の API）では、[StringLength]などのデータアノテーション（DataAnnotations）
        // による自動検証（バリデーション）がデフォルトでは実行されません。
        // [1]従来のMVCやWeb API（コントローラーベース）とは異なり、Minimal APIは軽量化のために自動検証機能が省かれているためです。
        // 解決策1：MiniValidation ライブラリを使う（最も簡単・推奨）
        // dotnet add package MiniValidation

        public static void Main(string[] args)
        {
            // NLogの初期化
            var logger = LogManager.Setup()
                .LoadConfigurationFromFile("nlog.config", optional: false)
                .GetCurrentClassLogger();

            try
            {
                logger.Info("Starting up the application...");

                var builder = WebApplication.CreateBuilder(args);

                // NLogをシステムに統合
                builder.Logging.ClearProviders();
                builder.Host.UseNLog();

                // swaggerの登録
                builder.Services.AddEndpointsApiExplorer();
                builder.Services.AddSwaggerGen();

                // Problem Details（RFC 7807形式の標準エラー応答）の基本サービスを登録
                builder.Services.AddCustomProblemDetails();


                var app = builder.Build();

                // 開発環境（Development）の場合のみ
                if (app.Environment.IsDevelopment())
                {
                    // UI 画面（/swagger/index.html）が有効になります
                    app.UseSwagger();
                    app.UseSwaggerUI();
                }

                // 予期せぬ例外（500エラー）を一括キャッチするグローバル例外ハンドラーの設定
                app.UseCustomExceptionHandler(app.Environment);

                // グループ毎にまとめる
                var mapGroup = app.MapGroup("/products")
                    .AddEndpointFilter<RequestLoggingFilter>()
                    .ProductsAPI();

                app.Run();
            }
            catch (Exception e)
            {
                // 起動時や実行中に発生した未処理例外をファイルに書き残す
                logger.Fatal(e, "Stopped program because of an unhandled exception.");
                throw;
            }
            finally
            {
                // 💡 アプリ終了時にバッファ内のログを物理ファイルへ完全に書き出し、リソースを安全に解放する
                LogManager.Shutdown();
            }
        }
    }
}
