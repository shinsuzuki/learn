using Microsoft.AspNetCore.Mvc;
using System.ComponentModel.DataAnnotations;

namespace ErrorHandlingExample.Controllers
{
    [ApiController]
    [Route("home")]
    public class HomeController : ControllerBase
    {
        [HttpGet("index")]
        public IActionResult Index([MaxLength(10)] string? key)
        {
            //throw new Exception("test Exception!!!");
            return Content("test");
        }
    }
}
