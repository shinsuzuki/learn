namespace SocktsApp.Services
{
    public class MyService : IMyService
    {
        private readonly IHttpClientFactory _httpClientFactory;

        public MyService(IHttpClientFactory httpClientFactory)
        {
            _httpClientFactory = httpClientFactory;
        }

        public async void GetMethod1()
        {
            using (var httpClient = _httpClientFactory.CreateClient())
            {
                var httpRequestMessage = new HttpRequestMessage()
                {
                    RequestUri = new Uri("https://jsonplaceholder.typicode.com/posts/1/comments"),
                    Method = HttpMethod.Get,
                };

                var response = await httpClient.SendAsync(httpRequestMessage);
                Console.WriteLine($"response:{response}");
            }
        }
    }
}
