using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;

namespace ConfigurationExample.Controller
{
    [ApiController]
    [Route("[controller]")]
    public class Home1Controller : ControllerBase
    {
        private readonly IOptions<WeatherApiOptions> _options;

        public Home1Controller(IOptions<WeatherApiOptions> options)
        {
            _options = options;
        }

        [HttpGet("index")]
        public IActionResult Index()
        {
            var weatherApiOptions = _options.Value;
            Console.WriteLine(weatherApiOptions.ClientID);
            return Content($"Weather API Base URL: {weatherApiOptions.ClientID}");
        }
    }
}
