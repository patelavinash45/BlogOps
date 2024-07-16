using BlogOps.Configurations;
using BlogOps.HelperClass;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddDistributedMemoryCache();
builder.Services.AddDataBaseAndController(builder.Configuration);
builder.Services.AddSessions();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwagger();
builder.Services.AddHttpContextAccessor();
builder.Services.AddDependenceInjection();


var app = builder.Build();
app.UseCors(options => options.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
app.UseMiddleware<RequestHandler>();
app.UseSession();

app.UseHttpsRedirection();
app.MapControllers();
app.UseAuthorization();

app.Run();

