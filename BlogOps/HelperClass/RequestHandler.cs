using System.Net;
using Dtos.Constants;
using Newtonsoft.Json;

public class RequestHandler(RequestDelegate request)
{
    private readonly RequestDelegate _request = request;

    public async Task Invoke(HttpContext httpContext)
    {
        try
        {
            await _request(httpContext);
        }
        catch (Exception ex)
        {
            await HandleError(httpContext, ex);
        }
    }

    private static Task HandleError(HttpContext httpContext, Exception ex)
    {
        httpContext.Response.StatusCode = (int)HttpStatusCode.InternalServerError;
        httpContext.Response.ContentType = "application/json";
        object errorMessage = ex switch
        {
            BadHttpRequestException => new { error = ConstantValue.BadRequestString },
            ArgumentException => new { error = ex.Message },
            //_ => new { error = "Internal Server Error." },
            _ => new { error = ex },
        };
        return httpContext.Response.WriteAsync(JsonConvert.SerializeObject(errorMessage));
    }
}