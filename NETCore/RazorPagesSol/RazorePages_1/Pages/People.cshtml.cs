using Microsoft.AspNetCore.Mvc.RazorPages;
using RazorePages_1.Models;

namespace RazorePages_1.Pages
{
    public class PeopleModel : PageModel
    {
        public List<Person> People { get; set; } = new List<Person>();

        public void OnGet()
        {
            People = new List<Person>
            {
                new Person { Id = 1, Name = "Alice", Age = 30 },
                new Person { Id = 2, Name = "Bob", Age = 25 },
                new Person { Id = 3, Name = "Charlie", Age = 35 }
            };
        }
    }
}
