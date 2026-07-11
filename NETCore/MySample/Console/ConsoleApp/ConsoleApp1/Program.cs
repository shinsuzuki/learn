using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

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

            // 任意のサービスを登録
            services.AddTransient<MyService>();

            var provider = services.BuildServiceProvider();

            // 実行
            var svc = provider.GetRequiredService<MyService>();
            svc.Run();
        }


    }
}
