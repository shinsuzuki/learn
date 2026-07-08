var builder = WebApplication.CreateBuilder(args);
builder.Services.AddRouting(options =>
{
    options.ConstraintMap.Add("alphaCustom", typeof(RouteExample.CustomConstaints.AlphaCustomConstaint));
});

var app = builder.Build();

// ルーティング
// ミドルウェアを分岐
app.Map("map1", async (context) =>
{
    await context.Response.WriteAsync("Hello from map1!");
});

app.Map("map2", async (context) =>
{
    await context.Response.WriteAsync("Hello from map2!");
});

// Getルートを定義
//app.MapGet("map3", async (context) =>
//{
//    await context.Response.WriteAsync("Hello from map3!");
//});

// ルートパラメータを取得
app.MapGet("files/{filename}.{extension}", async (context) =>
{
    string? filename = context.Request.RouteValues["filename"]?.ToString();
    string? extension = context.Request.RouteValues["extension"]?.ToString();
    await context.Response.WriteAsync($"from files: {filename}.{extension}");
});

// eg. employee/profile/john
app.Map("employee/profile/{employeename:length(4, 7):alpha=scott}", async context =>
{
    string? employeeName = Convert.ToString(context.Request.RouteValues["employeename"]);
    await context.Response.WriteAsync($"employeeName: {employeeName}");
});

// eg. ルートパラメータオプショナル
app.Map("products/details/{id:int:range(1, 100)?}", async context =>
{
    if (context.Request.RouteValues.ContainsKey("id"))
    {
        int id = Convert.ToInt32(context.Request.RouteValues["id"]);
        await context.Response.WriteAsync($"product details id: {id}");
    }
    else
    {
        await context.Response.WriteAsync($"product details id is not supplied");
    }
});

// eg. ルートパラメータの制約
app.Map("daily-digest-report/{reportdate:datetime}", async context =>
{
    DateTime reportDate = Convert.ToDateTime(context.Request.RouteValues["reportdate"]);
    await context.Response.WriteAsync($"daily digest report date: {reportDate.ToString("yyyy-MM-dd")}");
});

// eg. cities/{cityid}
app.Map("cities/{cityid:guid}", async context =>
{
    Guid cityId = Guid.Parse(Convert.ToString(context.Request.RouteValues["cityid"])!);
    await context.Response.WriteAsync($"city id: {cityId}");
});

// 正規表現も使えるよ
app.Map("regex/{text:regex(^[a-zA-Z]+$)}", async context =>
{
    string? text = Convert.ToString(context.Request.RouteValues["text"]);
    await context.Response.WriteAsync($"from regex: {text}");
});

// eg. カスタムルート制約を使う
app.Map("regex2/{text:alphaCustom}", async context =>
{
    string? text = Convert.ToString(context.Request.RouteValues["text"]);
    await context.Response.WriteAsync($"from regex: {text}");
});


// Postルートを定義
app.MapPost("map4", async (context) =>
{
    await context.Response.WriteAsync("Hello from map4!");
});

// 通常ルートがすべて試されて どれにも一致しなかった場合 にこのフォールバックが呼ばれる。
app.MapFallback(async (context) =>
{
    await context.Response.WriteAsync($"from fallback! {context.Request.Path}");
});

app.Run();
