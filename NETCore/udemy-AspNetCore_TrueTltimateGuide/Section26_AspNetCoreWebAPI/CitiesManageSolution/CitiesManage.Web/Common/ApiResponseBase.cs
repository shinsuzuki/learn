namespace CitiesManage.Web.Common
{
    public class ErrorMessage
    {
        public string? Field { get; set; }
        public string? Message { get; set; }
    }

    public class ApiErrorResponse
    {
        public required IEnumerable<ErrorMessage> Messages { get; set; }
        public string? TraceId { get; set; }
    }


    public class ApiSuccessResponse<T>
    {
        public string? TraceId { get; set; }
        public T? Data { get; set; }
    }
}
