using Entities;
using Microsoft.EntityFrameworkCore;
using ServiceContracts;
using Services;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddControllersWithViews();

//add services into IoC container
builder.Services.AddScoped<ICountriesService, CountriesService>();
builder.Services.AddScoped<IPersonsService, PersonsService>();

// add db context(sql server)
builder.Services.AddDbContext<PersonsDbContext>(
    option => { option.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")); });

//Data Source = (localdb)\MSSQLLocalDB; Initial Catalog = PersonsDatabase; Integrated Security = True; Connect Timeout = 30; Encrypt = True; Trust Server Certificate=False; Application Intent = ReadWrite; Multi Subnet Failover=False; Command Timeout = 30

var app = builder.Build();

if (builder.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
}

app.UseStaticFiles();
app.MapControllers();

app.Run();
