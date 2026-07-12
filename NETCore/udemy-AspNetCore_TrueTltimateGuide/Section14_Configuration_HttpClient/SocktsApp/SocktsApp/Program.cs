namespace SocktsApp
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);
            builder.Services.AddControllers();
            builder.Services.AddHttpClient();

            // builder.Services.AddTransient<IMyService, MyService>();
            builder.Services.AddMyAppServices();

            var app = builder.Build();

            app.MapGet("/", () => "Hello World!");

            app.UseStaticFiles();
            app.UseRouting();
            app.MapControllers();

            app.Run();
        }
    }
}
