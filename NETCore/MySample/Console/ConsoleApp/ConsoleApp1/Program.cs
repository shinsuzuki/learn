using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using NLog.Extensions.Logging;

namespace ConsoleApp1
{
    internal class Program
    {
        static void Main(string[] args)
        {
            var services = new ServiceCollection();

            // Configuration を作成
            var config = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
                .Build();

            // DI に登録
            services.AddSingleton<IConfiguration>(config);

            // ★ Logging を DI に登録（NLog を差し込む）
            services.AddLogging(builder =>
            {
                builder.ClearProviders();
                builder.SetMinimumLevel(LogLevel.Information);
                builder.AddNLog();
            });

            // 任意のサービスを登録
            services.AddTransient<IMyService, MyService>();
            services.AddTransient<IMyBusiness, MyBusiness>();

            var provider = services.BuildServiceProvider();

            // 実行
            var svc = provider.GetRequiredService<IMyService>();
            svc.Run("hello world!");
        }


    }
}
