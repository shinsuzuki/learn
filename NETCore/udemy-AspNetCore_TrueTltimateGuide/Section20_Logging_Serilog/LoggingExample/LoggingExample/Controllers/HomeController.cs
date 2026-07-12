using Microsoft.AspNetCore.Mvc;

namespace LoggingExample.Controllers
{
    [ApiController]
    [Route("home")]
    public class HomeController : ControllerBase
    {
        ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        [HttpGet("index")]
        public IActionResult Index()
        {
            _logger.LogInformation("call index");
            return Content("test");
        }
    }
}
