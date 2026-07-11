using Microsoft.Extensions.Configuration;

namespace ConsoleApp1
{
    public class MyService
    {
        private readonly IConfiguration _config;

        public MyService(IConfiguration config)
        {
            _config = config;
        }

        public void Run()
        {
            Console.WriteLine(_config["MySettings:Value"]);
        }
    }
}
