using NLog.Web;

namespace LoggingExample.Extensions
{
    public static class LoggingExtensions
    {
        public static void AddMyAppLogging(this WebApplicationBuilder builder)
        {
            builder.Logging.ClearProviders();
            builder.Host.UseNLog();
        }
    }
}
