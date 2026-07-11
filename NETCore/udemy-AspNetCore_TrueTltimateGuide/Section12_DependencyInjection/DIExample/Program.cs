namespace DIExample
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);
            builder.Services.AddControllersWithViews();

            // DI registration for ICitiesService and CitiesService
            //builder.Services.Add(new ServiceDescriptor(
            //    typeof(ServiceContracts.ICitiesService),
            //    typeof(Services.CitiesService),
            //    ServiceLifetime.Transient));

            // Transient: 新しいインスタンスを要求ごとに作成
            // Scoped: 同じスコープ内で同じインスタンスを使用、通常はHTTPリクエストごとに1つのインスタンスが作成される
            // Singleton: アプリケーション全体で1つのインスタンスを使用
            builder.Services.AddTransient<ServiceContracts.ICitiesService, Services.CitiesService>();

            var app = builder.Build();

            app.UseStaticFiles();
            app.UseRouting();
            app.MapControllers();

            app.Run();
        }
    }
}
