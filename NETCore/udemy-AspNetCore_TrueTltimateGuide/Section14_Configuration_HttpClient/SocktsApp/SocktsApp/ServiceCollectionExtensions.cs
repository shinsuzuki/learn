using SocktsApp.Services;

namespace SocktsApp
{
    public static class ServiceCollectionExtensions
    {
        public static IServiceCollection AddMyAppServices(this IServiceCollection services)
        {
            services.AddTransient<IMyService, MyService>();
            return services;
        }
    }
}
