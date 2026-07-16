using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

namespace ConsoleApp1
{
    public interface IMyService
    {
        void Run(string args);
    }


    public class MyService : IMyService
    {
        private readonly IConfiguration _config;
        private readonly ILogger<MyService> _logger;
        private readonly IMyBusiness _business;

        public MyService(IConfiguration config, ILogger<MyService> logger, IMyBusiness business)
        {
            _config = config;
            _logger = logger;
            _business = business;
        }

        public void Run(string message)
        {
            // service
            Console.WriteLine(_config["MySettings:Value"]);
            _logger.LogInformation($"MyService: Run: message={message}");

            // biz
            var res = _business.Execute("hello business");
            _logger.LogInformation($"result:{res}");
        }
    }
}
