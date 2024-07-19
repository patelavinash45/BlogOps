using System.Net;
using Dtos.Constants;
using Newtonsoft.Json;
using DbContexts.HelperClass;

namespace BlogOps.HelperClass;

public class RequestHandler(RequestDelegate request)
{
    private readonly RequestDelegate _request = request;

    public async Task Invoke(HttpContext httpContext)
    {
        try
        {
            UserInfo.Initialize(httpContext);
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
        object errorMessage;
        switch(ex){
            case BadHttpRequestException : errorMessage = new { error = ConstantValue.BadRequestString };
                                           httpContext.Response.StatusCode = (int)HttpStatusCode.InternalServerError;
                                           break;
            default : //errorMessage =  new { error = "Internal Server Error." };
                      errorMessage =  new { error = ex };
                      break;
        }
        return httpContext.Response.WriteAsync(JsonConvert.SerializeObject(errorMessage));
    }
}