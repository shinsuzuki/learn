using MiddlewareExample.CustomMiddleware;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddTransient<MyCustomMiddleware>();

var app = builder.Build();

// Runは後続のMWに処理に転送しません
//app.Run(async (HttpContext context) =>
//{
//    await context.Response.WriteAsync("Hello World!");
//});


// mw1, useは次mwを呼び出せる 
app.Use(async (HttpContext context, RequestDelegate next) =>
{
    await context.Response.WriteAsync("From mw 1\n");
    await next(context);
});

// mw2
//app.Use(async (HttpContext context, RequestDelegate next) =>
//{
//    await context.Response.WriteAsync("Hello World 2");
//    await next(context);
//});

//app.UseMiddleware<MyCustomMiddleware>();
app.UseMyCustomMiddleware();

//app.UseMiddleware<HelloCustomMiddleware>();
app.UseHelloCustomMiddleware();

// mw3
app.Run(async (HttpContext context) =>
{
    await context.Response.WriteAsync("From mw 3\n");
});


app.Run();
