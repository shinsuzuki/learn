namespace ControllersExample
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);
            // 全コントローラをサービスに追加
            builder.Services.AddControllers();

            var app = builder.Build();
            app.UseStaticFiles();

            // 各アクションメソッドのルーティングを有効化
            app.MapControllers();

            app.Run();
        }
    }
}
