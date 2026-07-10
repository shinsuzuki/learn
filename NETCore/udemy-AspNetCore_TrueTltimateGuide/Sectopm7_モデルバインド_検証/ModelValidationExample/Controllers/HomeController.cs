using Microsoft.AspNetCore.Mvc;
using ModelValidationExample.Models;

namespace ModelValidationExample.Controllers
{
    [ApiController]
    [Route("home")]
    public class HomeController : ControllerBase
    {
        [HttpPost("Regist")]
        public IActionResult RegistRequest(Person person, [FromHeader(Name = "User-Agent")] string userAgent)
        {
            Console.WriteLine($"userAgent: {userAgent}");
            return Ok(person);
        }
    }
}
