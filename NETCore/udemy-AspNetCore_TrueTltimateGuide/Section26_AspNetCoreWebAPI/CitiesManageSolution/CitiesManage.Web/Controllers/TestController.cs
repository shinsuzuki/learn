using Microsoft.AspNetCore.Mvc;

namespace CitiesManage.Web.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TestController : ControllerBase
    {
        [HttpGet("Method")]
        public string Method()
        {
            return "hello world";
        }
    }
}
