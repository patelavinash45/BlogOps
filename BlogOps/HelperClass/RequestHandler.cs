using System.Net;
using Newtonsoft.Json;

public class RequestHandler
{
    private readonly RequestDelegate _request;

    public RequestHandler(RequestDelegate request)
    {
        _request = request;
    }

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
            BadHttpRequestException => new { error = "Bed Request." },
            ArgumentException => new { error = ex.Message },
            _ => new { error = "Internal Server Error." },
        };
        return httpContext.Response.WriteAsync(JsonConvert.SerializeObject(errorMessage));
    }
}