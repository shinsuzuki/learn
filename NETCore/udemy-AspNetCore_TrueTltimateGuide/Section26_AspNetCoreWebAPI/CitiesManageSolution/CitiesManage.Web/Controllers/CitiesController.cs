using CitiesManage.Web.Common;
using CitiesManage.Web.DatabaseContext;
using CitiesManage.Web.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Net;


[Route("api/[controller]")]
[ApiController]
public class CitiesController : CustomControllerBase
{
    private readonly ApplicationDbContext _context;
    public CitiesController(ApplicationDbContext context)
    {
        _context = context;
    }

    // GET: api/City
    [HttpGet]
    public async Task<ActionResult<IEnumerable<City>>> GetCity()
    {
        return await _context.Cities.OrderBy(x => x.CityName).ToListAsync();
    }

    // GET: api/City/5
    [HttpGet("{cityid}")]
    public async Task<ActionResult<City>> GetCity(System.Guid cityid)
    {
        var city = await _context.Cities.FindAsync(cityid);

        throw new NotImplementedException("my-test!!");

        if (city == null)
        {
            //return NotFound();
            return ErrorResponse((int)HttpStatusCode.NotFound, new ErrorMessage { Field = "", Message = "データ取得失敗" });
        }

        return Ok(city);
        //return city;
        //return StatusCode((int)HttpStatusCode.OK, city);
    }


    // PUT: api/City/5
    // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
    [HttpPut("{cityid}")]
    public async Task<IActionResult> PutCity(System.Guid? cityid, City city)
    {
        throw new Exception("test !!!!!!!!!!!!!!");

        if (cityid != city.CityID)
        {
            return BadRequest();
        }

        _context.Entry(city).State = EntityState.Modified;

        try
        {
            await _context.SaveChangesAsync();
        }
        catch (DbUpdateConcurrencyException)
        {
            if (!CityExists(cityid))
            {
                return NotFound();
            }
            else
            {
                throw;
            }
        }

        return NoContent();
    }

    // POST: api/City
    // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
    [HttpPost]
    public async Task<ActionResult<City>> PostCity(City city)
    {
        _context.Cities.Add(city);
        await _context.SaveChangesAsync();

        // return CreatedAtAction("GetCity", new { cityid = city.CityID }, city);
        return StatusCode((int)HttpStatusCode.Created, city);
    }

    // DELETE: api/City/5
    [HttpDelete("{cityid}")]
    public async Task<IActionResult> DeleteCity(System.Guid? cityid)
    {
        var city = await _context.Cities.FindAsync(cityid);
        if (city == null)
        {
            return NotFound();
        }

        _context.Cities.Remove(city);
        await _context.SaveChangesAsync();

        return NoContent();
    }

    private bool CityExists(System.Guid? cityid)
    {
        return _context.Cities.Any(e => e.CityID == cityid);
    }
}
