namespace MinimalAPI.Extensions
{
    public static class ProblemDetailsExtensions
    {
        public static IServiceCollection AddCustomProblemDetails(this IServiceCollection services)
        {
            services.AddProblemDetails(options =>
            {
                // 必要に応じて、すべてのエラー応答に共通のカスタマイズ（環境名など）を入れることも可能
                options.CustomizeProblemDetails = context =>
                {
                    context.ProblemDetails.Extensions["timestamp"] = DateTime.UtcNow;
                };
            });

            return services;
        }
    }
}