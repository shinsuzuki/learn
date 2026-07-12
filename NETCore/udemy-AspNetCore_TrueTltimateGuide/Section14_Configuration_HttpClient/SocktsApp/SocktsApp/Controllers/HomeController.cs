using Microsoft.AspNetCore.Mvc;
using SocktsApp.Services;

namespace SocktsApp.Controllers
{
    [ApiController]
    [Route("home")]
    public class HomeController : ControllerBase
    {
        private IMyService _myService;

        public HomeController(IMyService myService)
        {
            _myService = myService;
        }

        [HttpGet("index")]
        public IActionResult Index()
        {
            _myService.GetMethod1();
            return Content("test");
        }
    }
}
