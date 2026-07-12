namespace ConfigurationExample
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);
            builder.Services.AddControllers();

            // options を設定
            builder.Services.Configure<WeatherApiOptions>(
                builder.Configuration.GetSection("WeatherApi"));

            var app = builder.Build();

            app.UseStaticFiles();
            app.UseRouting();
            app.MapControllers();

            //app.MapGet("/",
            //    async context =>
            //    {
            //        //var myValue = app.Configuration["MyKey"];
            //        var myValue = app.Configuration.GetValue<string>("MyKey2", "default_value");
            //        await context.Response.WriteAsync($"MyKey: {myValue}");
            //    });

            app.Run();
        }
    }
}
