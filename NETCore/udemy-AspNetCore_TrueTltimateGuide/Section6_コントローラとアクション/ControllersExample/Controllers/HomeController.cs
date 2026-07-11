using ControllersExample.Models;
using Microsoft.AspNetCore.Mvc;

namespace ControllersExample.Controllers
{

    [ApiController]
    [Route("home")]
    public class HomeController : ControllerBase
    {
        [HttpGet("")]
        public ContentResult Index()
        {
            // テキスト返す
            return new ContentResult()
            {
                Content = "Hello from Index",
                ContentType = "text/plain",
                StatusCode = 200
            };
        }

        [HttpGet("about")]
        public string About()
        {
            return "Hello from about";
        }

        [HttpGet("contact/{id:int}")]
        public string Contact(int id)
        {
            return $"Hello from Contact with ID: {id}";
        }

        [HttpGet("person")]
        public JsonResult Person()
        {
            var person = new Person()
            {
                Id = Guid.NewGuid(),
                FirstName = "John",
                LastName = "Doe",
                Age = 30
            };

            return new JsonResult(person);
        }

        [HttpGet("file-download")]
        public IActionResult FileDownload()
        {
            // VirtualFileResult は「物理ファイルではなく“仮想パス（IFileProvider）
            // 上のファイル”を返すための返却クラス」。wwwroot や埋め込みリソースなど、
            // 物理パスを直接使わずにファイルを返したいときに使う。
            //return new VirtualFileResult("/sample.pdf", "application/pdf")
            //{
            //    FileDownloadName = "sample.pdf"
            //};

            // 以下のように短くかける
            return File("/sample.pdf", "application/pdf");
        }

        [HttpGet("file-download2")]
        public IActionResult FileDownload2()
        {
            // PhysicalFileResult は「物理パス上のファイルを返すための返却クラス」。
            // 以下の案件では、c:\astpnetcore\sample.pdf という物理パス上のファイルを返す。
            return new PhysicalFileResult(@"c:\astpnetcore\sample.pdf", "application/pdf")
            {
                FileDownloadName = "sample.pdf"
            };

        }

        [HttpGet("file-download3")]
        public IActionResult FileDownload3()
        {
            // ファイルをメモリ上で作成して返す場合は FileContentResult を使う。
            var lines = new List<string>
            {
                "Hello World 1",
                "Hello World 2"
            };
            var contents = string.Join("\n", lines);
            var bytes = System.Text.Encoding.UTF8.GetBytes(contents);
            //return new FileContentResult(bytes, "application/csv")
            //{
            //    FileDownloadName = "sample.csv"
            //}

            // newは不要、
            // FileContentResult(bytes, "application/csv") の代わりに、
            // ControllerBase クラスの File メソッドを使うと短く書ける。
            return File(bytes, "application/csv", "sample.csv");

        }

    }
}
