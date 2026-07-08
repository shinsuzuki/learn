var builder = WebApplication.CreateBuilder(
    new WebApplicationOptions()
    {
        // こちらが危険、推奨されない
        WebRootPath = "myroot"
    });
var app = builder.Build();

// path (myroot),url直下
app.UseStaticFiles();

// こちらが自然、安全
// add a route (mywebrootのパスでアクセス)
app.UseStaticFiles(new StaticFileOptions()
{
    FileProvider = new Microsoft.Extensions.FileProviders.PhysicalFileProvider(
        Path.Combine(Directory.GetCurrentDirectory(), "mywebroot")),
    RequestPath = @"/mywebroot"
});

app.MapGet("/", () => "Hello World!");

app.Run();
