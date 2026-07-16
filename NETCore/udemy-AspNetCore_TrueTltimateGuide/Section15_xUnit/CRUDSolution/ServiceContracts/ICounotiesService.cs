using ServiceContracts.DTO;

namespace ServiceContracts
{
    public interface ICounotiesService
    {
        CountryResponse AddCountry(CountryAddRequest? CountryAddRequest);
    }
}
