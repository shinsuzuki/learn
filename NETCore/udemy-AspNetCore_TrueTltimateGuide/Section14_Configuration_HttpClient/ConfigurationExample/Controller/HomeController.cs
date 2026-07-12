using Microsoft.AspNetCore.Mvc;

namespace ConfigurationExample.Controller
{
    [ApiController]
    [Route("[controller]")]
    public class HomeController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public HomeController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [HttpGet("index")]
        public IActionResult Index()
        {
            Console.WriteLine("--------------------------------");
            Console.WriteLine(_configuration["MyKey"]);
            Console.WriteLine(_configuration.GetValue<string>("MyKey", "default value"));
            Console.WriteLine(_configuration["MasterKey:SubKey1"]);
            Console.WriteLine(_configuration["MasterKey:SubKey2"]);

            Console.WriteLine("-------------------------------- GetSection");
            var masterKeySection = _configuration.GetSection("MasterKey");
            Console.WriteLine(masterKeySection["SubKey1"]);
            Console.WriteLine(masterKeySection["SubKey2"]);

            Console.WriteLine("-------------------------------- Options");
            var options = _configuration.GetSection("WeatherApi").Get<WeatherApiOptions>();

            return Content("Hello from HomeController!");
        }
    }
}
