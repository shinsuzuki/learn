using CitiesManage.Web.DatabaseContext;
using CitiesManage.Web.Extensions;
using CitiesManage.Web.Middleware;
using Microsoft.EntityFrameworkCore;

namespace CitiesManage.Web
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // Add services to the container.

            builder.Services.AddControllers();
            builder.Services.AddDbContext<ApplicationDbContext>(options =>
            {
                options.UseSqlServer(builder.Configuration.GetConnectionString("Default"));
            });

            // Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
            builder.Services.AddOpenApi();

            builder.Services.AddCustomModelStateResponse();

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.MapOpenApi();
            }

            app.UseHsts();
            app.UseHttpsRedirection();

            app.UseAuthorization();

            app.MapControllers();
            // 統一レスポンス対応例外
            app.UseMiddleware<ExceptionMiddleware>();

            app.Run();
        }
    }
}
