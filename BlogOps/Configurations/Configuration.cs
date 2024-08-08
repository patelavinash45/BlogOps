using DbContexts.Enums;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using Npgsql;
using Repositories.GenericRepository;
using Services.GenericService;
using DbContexts.HelperClass;
using DbContexts.DataContext;

namespace BlogOps.Configurations;

public static class Configuration
{
    public static IServiceCollection AddDataBaseAndController(this IServiceCollection services, IConfiguration configuration)
    {
        services.AddControllers().AddNewtonsoftJson();
        var connectionString = configuration.GetConnectionString("BaseConnectionString");
        NpgsqlDataSourceBuilder builder = new(connectionString);
        builder.MapEnum<BlogStatus>();
        builder.MapEnum<UserStatus>();
        builder.EnableUnmappedTypes();
        var dbBuild = builder.Build();
        services.AddDbContext<BlogOpsContext>(options =>
        {
            options.UseNpgsql(dbBuild);
        });
        services.AddCors(c =>
        {
            c.AddPolicy("AllowOrigin", options => options.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());
        });
        return services;
    }

    public static IServiceCollection AddSwagger(this IServiceCollection services)
    {
        services.AddSwaggerGen(
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
        return services;
    }

    public static IServiceCollection AddSessions(this IServiceCollection services)
    {
        services.AddSession(Options =>
        {
            Options.Cookie.Name = ".Session";
            Options.IdleTimeout = TimeSpan.FromMinutes(20);
            Options.Cookie.HttpOnly = true;
            Options.Cookie.IsEssential = true;
        });
        return services;
    }

    public static IServiceCollection AddDependenceInjection(this IServiceCollection services)
    {
        services.AddScoped<UserInfo>();
        services.Scan(selector => selector
            .FromAssemblies(
            typeof(IGenericRepository<>).Assembly,
            typeof(IGenericService<>).Assembly
            )
        .AddClasses(publicOnly: false)
        .AsMatchingInterface()
        .WithScopedLifetime());
        return services;
    }

}