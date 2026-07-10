using IActionResultExample.Models;
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

        [HttpGet("BadRequestResult")]
        public IActionResult BadRequestResult()
        {
            return BadRequest("This is a bad request example.");
        }


        [HttpGet("NotFoundResult")]
        public IActionResult NotFoundResult()
        {
            return NotFound("This is a not found example.");
        }

        [HttpGet("UnauthorizedResult")]
        public IActionResult UnauthorizedResult()
        {
            return Unauthorized("This is a Unauthorized request example.");
        }

        [HttpGet("StatusCodeResult")]
        public IActionResult StatusCodeResult()
        {
            return StatusCode(409, "コンフリエラー");
        }

        // よく使うレスポンス
        //① 成功系（2xx）
        //  Ok(object)
        //  Created() / CreatedAtAction()
        //  NoContent()
        //② クライアントエラー系（4xx）
        //  BadRequest("message")（400）
        //  Unauthorized("message")（401）
        //  Forbidden("message")（403）
        //  NotFound("message")（404）
        //  Conflict("message")（409）
        //  UnprocessableEntity("message")（422）
        //③ サーバーエラー系（5xx）
        //  StatusCode(500)
        //  Problem()（RFC7807準拠の標準エラーフォーマット）


        // クエリーパラメータから指定
        [HttpGet("QueryCheck")]
        public IActionResult QueryCheck([FromQuery] int? id, [FromQuery] string? name)
        //[HttpGet("QueryCheck/{id}/{name}")]
        // ルートパラメータから値を取得
        //public IActionResult QueryCheck([FromRoute] int? id, [FromRoute] string? name)
        {
            if (!id.HasValue)
            {
                return BadRequest("The 'id' parameter is required.");
            }

            // name が指定されていない場合の処理
            if (string.IsNullOrEmpty(name))
            {
                return BadRequest("The 'name' parameter is required.");
            }

            // id が指定されている場合の処理
            return Ok($"id:{id}, name:{name}");
        }

        [HttpPost("BookRequest")]
        public IActionResult BookRequest(Book book)
        // Formデータから値を取得する場合は、[FromForm] 属性を使用して、フォームデータから値をバインドすることができます。
        //public IActionResult BookRequest([FromForm] Book book)
        {
            // get で 階層を表現してバインドも可能

            if (book == null)
            {
                return BadRequest("The book parameter is required.");
            }

            return Ok(book);
        }

    }
}
