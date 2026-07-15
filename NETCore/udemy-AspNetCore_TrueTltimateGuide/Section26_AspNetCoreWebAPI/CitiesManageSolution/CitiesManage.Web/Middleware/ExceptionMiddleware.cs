using CitiesManage.Web.Common;
using System.Net;

namespace CitiesManage.Web.Middleware
{
    public class ExceptionMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger<ExceptionMiddleware> _logger;
        private ApiErrorResponse _response;

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
                if (!context.Response.HasStarted)
                {
                    context.Response.StatusCode = (int)HttpStatusCode.InternalServerError;
                    context.Response.ContentType = "application/json";

                    //var traceId = context.Items["X-Correlation-ID"]?.ToString();
                    _logger.LogError(ex, "Unhandled exception occurred.");

                    var errorMessages = new List<ErrorMessage>();
                    errorMessages.Add(new ErrorMessage() { Field = "", Message = ex.ToString() });

                    _response = new ApiErrorResponse()
                    {
                        TraceId = context.TraceIdentifier,
                        Messages = errorMessages
                    };

                    await context.Response.WriteAsJsonAsync<ApiErrorResponse>(_response);
                }
            }
        }
    }
}
