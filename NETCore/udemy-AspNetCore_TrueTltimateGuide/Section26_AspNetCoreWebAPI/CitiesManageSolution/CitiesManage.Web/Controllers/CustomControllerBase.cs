using CitiesManage.Web.Common;
using Microsoft.AspNetCore.Mvc;

public class CustomControllerBase : ControllerBase
{
    //protected ActionResult ErrorResponse(int statusCode, params ErrorMessage[] messages)
    //{
    //    var error = new ApiErrorResponse
    //    {
    //        Messages = messages,
    //        TraceId = HttpContext.TraceIdentifier
    //    };

    //    return StatusCode(statusCode, error);
    //}

    /// <summary>
    /// 200 OK（成功レスポンス）
    /// </summary>
    protected ActionResult Success<T>(T data)
    {
        return Ok(new ApiSuccessResponse<T>
        {
            TraceId = HttpContext.TraceIdentifier,
            Data = data
        });
    }

    /// <summary>
    /// 201 Created（リソース作成）
    /// </summary>
    protected ActionResult CreatedResponse<T>(T data)
    {
        return StatusCode(201, data);
    }

    /// <summary>
    /// 204 No Content（成功だが返すデータなし）
    /// </summary>
    protected IActionResult NoContentResponse()
    {
        return NoContent();
    }

    /// <summary>
    /// 任意ステータスコードのエラーレスポンス
    /// </summary>
    protected ActionResult ErrorResponse(int statusCode, params ErrorMessage[] messages)
    {
        var response = new ApiErrorResponse
        {
            TraceId = HttpContext.TraceIdentifier,
            Messages = messages.ToList()
        };

        return StatusCode(statusCode, response);
    }

    /// <summary>
    /// 404 Not Found（データなし）
    /// </summary>
    protected ActionResult NotFoundResponse(string message = "データが見つかりません")
    {
        return ErrorResponse(404,
            new ErrorMessage { Field = "", Message = message }
        );
    }

    /// <summary>
    /// 400 Bad Request（不正リクエスト）
    /// </summary>
    protected ActionResult BadRequestResponse(params ErrorMessage[] messages)
    {
        return ErrorResponse(400, messages);
    }
}
