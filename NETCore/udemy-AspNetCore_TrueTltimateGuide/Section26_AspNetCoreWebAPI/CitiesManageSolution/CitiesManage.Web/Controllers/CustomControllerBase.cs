using CitiesManage.Web.Common;
using Microsoft.AspNetCore.Mvc;

public class CustomControllerBase : ControllerBase
{
    protected ActionResult ErrorResponse(int statusCode, params ErrorMessage[] messages)
    {
        var error = new ApiErrorResponse
        {
            Messages = messages,
            TraceId = HttpContext.TraceIdentifier
        };

        return StatusCode(statusCode, error);
    }
}