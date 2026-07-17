using System.Diagnostics;
using System.Text.Json;

namespace MinimalAPI.EndPointFilter
{
    public class RequestLoggingFilter : IEndpointFilter
    {

        private readonly ILogger<RequestLoggingFilter> _logger;

        public RequestLoggingFilter(ILogger<RequestLoggingFilter> logger)
        {
            _logger = logger;
        }

        public async ValueTask<object?> InvokeAsync(EndpointFilterInvocationContext context, EndpointFilterDelegate next)
        {
            // [前処理] リクエスト開始時の情報を取得
            var httpContext = context.HttpContext;
            var path = httpContext.Request.Path;
            var method = httpContext.Request.Method;

            // 引数（Arguments）からリクエストボディに相当するオブジェクトを安全に取得して JSON 化する
            var bodyText = GetRequestBodyLog(context);

            _logger.LogInformation("--- [API Start] {Method} {Path} {Body}---", method, path, bodyText);

            // 処理時間を測るためにストップウォッチを開始
            var stopwatch = Stopwatch.StartNew();

            try
            {
                // [本処理の実行] 次のパイプライン（実際のAPI処理）を呼び出す
                var result = await next(context);

                // [後処理] 正常終了時の処理
                stopwatch.Stop();
                var statusCode = httpContext.Response.StatusCode;

                _logger.LogInformation(
                    "--- [API End] {Method} {Path} - Status: {StatusCode} (Took {Elapsed}ms) ---",
                    method, path, statusCode, stopwatch.ElapsedMilliseconds);

                return result;
            }
            catch (Exception ex)
            {
                // [例外時の処理] 
                // ここでキャッチしてログを残し、例外はそのまま上流（UseExceptionHandler）へスルーする
                stopwatch.Stop();
                _logger.LogError(ex, "--- [API Error] {Method} {Path} (Failed after {Elapsed}ms) ---",
                    method, path, stopwatch.ElapsedMilliseconds);

                throw;
            }
        }

        /// <summary>
        /// フィルターの引数から、バインドされたリクエストボディ用のオブジェクトを見つけ出してJSON化します。
        /// </summary>
        private static string GetRequestBodyLog(EndpointFilterInvocationContext context)
        {
            // CancellationToken や HttpContext など、フレームワークがインジェクションする引数は除外する
            var bodyObject = context.Arguments.FirstOrDefault(arg =>
                arg is not null &&
                arg is not HttpContext &&
                arg is not CancellationToken);

            if (bodyObject == null)
            {
                return "(None)";
            }

            try
            {
                // オブジェクトを JSON 文字列にしてログ出力（NLogが構造化ログでそのまま扱えるようにします）
                return JsonSerializer.Serialize(bodyObject);
            }
            catch
            {
                // シリアライズに失敗した場合は、型名だけフォールバック
                return $"({bodyObject.GetType().Name} serialization failed)";
            }
        }
    }
}
