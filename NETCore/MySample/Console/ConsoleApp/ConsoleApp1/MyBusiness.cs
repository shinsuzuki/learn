using Microsoft.Extensions.Logging;

namespace ConsoleApp1
{
    public interface IMyBusiness
    {
        void Execute(string value);
    }

    public class MyBusiness : IMyBusiness
    {
        private readonly ILogger<MyBusiness> _logger;

        public MyBusiness(ILogger<MyBusiness> logger)
        {
            _logger = logger;
        }

        public void Execute(string value)
        {
            _logger.LogInformation($"MyBusiness.Execute: {value}");
        }
    }
}
