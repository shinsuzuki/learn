namespace ErrorHandlingExample.Middleware
{
    /// <summary>
    /// 統一レスポンス対応
    /// </summary>
    public class ExceptionMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger<ExceptionMiddleware> _logger;

        public ExceptionMiddleware(RequestDelegate next, ILogger<ExceptionMiddleware> logger)
        {
            _next = next;
            _logger = logger;
        }

        public async Task InvokeAsync(HttpContext context)
        {
            try
            {
                await _next(context);
            }
            catch (Exception ex)
            {
                var traceId = context.Items["X-Correlation-ID"]?.ToString();

                _logger.LogError(ex, "Unhandled exception occurred.");

                var errors = new List<string>
            {
                ex.Message
            };

                var response = new
                {
                    traceId,
                    errors
                };

                context.Response.StatusCode = 500;
                context.Response.ContentType = "application/json";
                await context.Response.WriteAsJsonAsync(response);
            }
        }
    }
}
