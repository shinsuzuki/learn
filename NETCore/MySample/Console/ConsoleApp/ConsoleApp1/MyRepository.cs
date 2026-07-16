namespace ConsoleApp1
{
    public interface IMyRepository
    {
        string LoadData();
    }

    public class MyRepository : IMyRepository
    {
        public string LoadData()
        {
            return File.ReadAllText("data.txt");
        }
    }
}
