using Microsoft.AspNetCore.Mvc;

namespace IActionResultExample.Controllers
{
    [ApiController]
    [Route("home")]
    public class HomeController : ControllerBase
    {

        [HttpGet("index")]
        public IActionResult Index()
        {
            if (!Request.Query.ContainsKey("bookid"))
            {
                return Content("Missing 'bookid' query parameter.");
            }

            if (!int.TryParse(Request.Query["bookid"], out int bookId))
            {
                return Content("Invalid 'bookid' query parameter. It must be an integer.");
            }

            int bookid = Convert.ToInt16(ControllerContext.HttpContext.Request.Query["bookid"]);

            return File("sample.pdf", "application/pdf");

            //// ファイルをメモリ上で作成して返す場合は FileContentResult を使う。
            //var lines = new List<string>
            //{
            //    "Hello World 1",
            //    "Hello World 2"
            //};
            //var contents = string.Join("\n", lines);
            //var bytes = System.Text.Encoding.UTF8.GetBytes(contents);

            //// newは不要、
            //// FileContentResult(bytes, "application/csv") の代わりに、
            //// ControllerBase クラスの File メソッドを使うと短く書ける。
            //return File(bytes, "application/csv", "sample.csv");
        }
    }
}
