using Microsoft.AspNetCore.Mvc;

namespace ControllersExample.Controllers
{
    // mvcの確認
    [Route("home2")]
    public class Home2Controller : Controller
    {
        [HttpGet("")]
        public IActionResult Index() => View(); // 画面を作っていないのでエラーになります

        [HttpGet("about")]
        public IActionResult About() => Content("About page"); // 文字列を返す

        [HttpGet("contact")]
        public IActionResult Contact() => View(); // 画面を作っていないのでエラーになります
    }
}


