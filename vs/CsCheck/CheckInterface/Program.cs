using CheckInterface.domain;
using CheckInterface.repository;

namespace CheckInterface
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello, World!");

            var user = new User(new UserRepository(), new AddressRepository());
            Console.WriteLine(user.GetName("A123"));
            Console.WriteLine(user.GetAddress("A123"));

            Console.WriteLine("press any key to exit...");
            Console.ReadLine();
        }
    }
}
