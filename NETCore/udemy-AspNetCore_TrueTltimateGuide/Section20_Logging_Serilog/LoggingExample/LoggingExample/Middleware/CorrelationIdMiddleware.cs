namespace LoggingExample.Middleware
{
    public class CorrelationIdMiddleware
    {
        private readonly RequestDelegate _next;
        private const string HeaderName = "X-Correlation-ID";

        public CorrelationIdMiddleware(RequestDelegate next)
        {
            _next = next;
        }

        public async Task InvokeAsync(HttpContext context)
        {
            // 既にクライアントが送ってきた場合はそれを使う
            if (!context.Request.Headers.TryGetValue(HeaderName, out var correlationId))
            {
                correlationId = Guid.NewGuid().ToString();
                context.Request.Headers[HeaderName] = correlationId;
            }

            // レスポンスにも付与
            context.Response.Headers[HeaderName] = correlationId;

            // ログに出すために Items に保存
            context.Items[HeaderName] = correlationId;

            await _next(context);
        }
    }
}
