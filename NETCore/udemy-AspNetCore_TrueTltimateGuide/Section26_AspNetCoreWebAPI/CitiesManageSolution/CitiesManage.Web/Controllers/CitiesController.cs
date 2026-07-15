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

    // todo: ActionResultを返す(更新、削除はIAtionResultを返す)

    // GET: api/City
    [HttpGet]
    public async Task<ActionResult<ApiSuccessResponse<List<City>>>> GetCity()
    {
        var cities = await _context.Cities.OrderBy(x => x.CityName).ToListAsync();
        return Success(cities);
    }

    // GET: api/City/5
    [HttpGet("{cityid}")]
    public async Task<ActionResult<ApiSuccessResponse<City>>> GetCity(System.Guid cityid)
    {
        var city = await _context.Cities.FindAsync(cityid);

        // throw new NotImplementedException("my-test!!");

        if (city == null)
        {
            //return NotFound();
            return ErrorResponse((int)HttpStatusCode.NotFound, new ErrorMessage { Field = "", Message = "データ取得失敗" });
        }

        return Success<City>(city);
        //return Ok(city);
        //return city;
        //return StatusCode((int)HttpStatusCode.OK, city);
    }


    // PUT: api/City/5
    // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
    [HttpPut("{cityid}")]
    public async Task<IActionResult> PutCity(System.Guid? cityid, City city)
    {
        // throw new Exception("test !!!!!!!!!!!!!!");

        if (cityid != city.CityID)
        {
            return BadRequestResponse(new ErrorMessage() { Field = "", Message = "バッドリクエストです。" });
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
                return NotFoundResponse();
            }
            else
            {
                throw;
            }
        }

        return NoContentResponse();
    }

    // POST: api/City
    // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
    [HttpPost]
    public async Task<ActionResult<ApiSuccessResponse<City>>> PostCity(City city)
    {
        _context.Cities.Add(city);
        await _context.SaveChangesAsync();

        // return CreatedAtAction("GetCity", new { cityid = city.CityID }, city);
        //return StatusCode((int)HttpStatusCode.Created, city);
        return CreatedResponse<City>(city);
    }

    // DELETE: api/City/5
    [HttpDelete("{cityid}")]
    public async Task<IActionResult> DeleteCity(System.Guid? cityid)
    {
        var city = await _context.Cities.FindAsync(cityid);
        if (city == null)
        {
            return NotFoundResponse();
        }

        _context.Cities.Remove(city);
        await _context.SaveChangesAsync();

        return NoContentResponse();
    }

    private bool CityExists(System.Guid? cityid)
    {
        return _context.Cities.Any(e => e.CityID == cityid);
    }
}
