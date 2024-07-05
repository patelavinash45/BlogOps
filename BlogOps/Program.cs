using BlogOpsDbContext;
using DbContexts.Enums;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using Npgsql;
using Repositories.BlogRepository;
using Repositories.GenericRepository;
using Services.BlogService;
using Services.GenericService;
using Services.JwtToken;
using Services.UserService;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddDistributedMemoryCache();
builder.Services.AddSession(Options =>
{
    Options.Cookie.Name = ".session";
    Options.IdleTimeout = TimeSpan.FromMinutes(20);
    Options.Cookie.HttpOnly = true;
    Options.Cookie.IsEssential = true;
});
builder.Services.AddControllers();
builder.Services.AddCors(c =>
 {
     c.AddPolicy("AllowOrigin", options => options.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());
 });
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(
    c =>
    {
        c.SwaggerDoc("v1", new OpenApiInfo
        {
            Title = "BlogsOps",
            Version = "v1"
        });
        c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme()
        {
            Name = "Authorization",
            Type = SecuritySchemeType.ApiKey,
            Scheme = "Bearer",
            BearerFormat = "JWT",
            In = ParameterLocation.Header,
        });
        c.AddSecurityRequirement(new OpenApiSecurityRequirement(){
            {
            new OpenApiSecurityScheme {
                Reference = new OpenApiReference {
                    Type = ReferenceType.SecurityScheme,
                        Id = "Bearer"
                }
            },
            new string[] {}
        }
        });
    }
);
builder.Services.AddHttpContextAccessor();
builder.Services.AddScoped<GetUser>();
builder.Services.AddControllers().AddNewtonsoftJson();
builder.Services.AddDbContext<BlogOpsContext>(options =>
{
    NpgsqlDataSourceBuilder builder = new("User ID = postgres;Password=aVI@12345;Server=localhost;Port=5432;Database=blogops;Pooling=true;");
    builder.MapEnum<BlogStatus>();
    builder.MapEnum<UserStatus>();
    builder.EnableUnmappedTypes();
    options.UseNpgsql(builder.Build());
});
builder.Services.AddScoped(typeof(IGenericRepository<>), typeof(GenericRepository<>));
builder.Services.AddScoped(typeof(IGenericService<>), typeof(GenericService<>));
builder.Services.AddScoped<IUserService, UserService>();
builder.Services.AddScoped<IJwtService, JwtService>();
builder.Services.AddScoped<IBlogService, BlogService>();
builder.Services.AddScoped<IBlogCategoryService, BlogCategoryService>();
builder.Services.AddScoped<IBlogRepository, BlogRepository>();


var app = builder.Build();
app.UseCors(options => options.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());

// Configure the HTTP request pipeline.
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

