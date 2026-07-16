using Microsoft.Extensions.Logging;

namespace ConsoleApp1
{
    public interface IMyBusiness
    {
        string Execute(string value);
    }

    public class MyBusiness : IMyBusiness
    {
        private readonly ILogger<MyBusiness> _logger;
        private readonly IMyRepository _repo;

        public MyBusiness(ILogger<MyBusiness> logger, IMyRepository repo)
        {
            _logger = logger;
            _repo = repo;
        }

        public string Execute(string value)
        {
            _logger.LogInformation($"MyBusiness.Execute: {value}");
            return _repo.LoadData();
        }
    }
}
