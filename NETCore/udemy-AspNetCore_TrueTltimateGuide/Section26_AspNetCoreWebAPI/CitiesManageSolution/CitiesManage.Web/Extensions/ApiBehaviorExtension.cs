using CitiesManage.Web.Common;
using Microsoft.AspNetCore.Mvc;

namespace CitiesManage.Web.Extensions
{
    public static class ApiBehaviorExtensions
    {
        public static IServiceCollection AddCustomModelStateResponse(this IServiceCollection services)
        {
            services.Configure<ApiBehaviorOptions>(options =>
            {
                options.InvalidModelStateResponseFactory = context =>
                {
                    var errorMessages = context.ModelState
                        .Where(x => x.Value!.Errors.Count > 0)
                        .SelectMany(x => x.Value!.Errors.Select(e =>
                            new ErrorMessage { Field = x.Key, Message = e.ErrorMessage }))
                        .ToList();

                    var errorResponse = new ApiErrorResponse()
                    {
                        TraceId = context.HttpContext.TraceIdentifier,
                        Messages = errorMessages
                    };

                    return new BadRequestObjectResult(errorResponse);
                };
            });

            return services;
        }
    }
}
