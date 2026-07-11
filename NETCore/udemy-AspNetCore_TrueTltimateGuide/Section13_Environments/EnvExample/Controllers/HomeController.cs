using Microsoft.AspNetCore.Mvc;

namespace EnvExample.Controllers
{
    [ApiController]
    [Route("home")]
    public class HomeController : ControllerBase
    {
        private IWebHostEnvironment _webHostEnvironment;

        public HomeController(IWebHostEnvironment webHostEnvironment)
        {
            _webHostEnvironment = webHostEnvironment;
        }

        [HttpGet("index")]
        public IActionResult Index()
        {
            // 環境変数名を取得して表示する
            Console.WriteLine($"Environment: {_webHostEnvironment.EnvironmentName}");
            return Content("hello world");
        }
    }
}
