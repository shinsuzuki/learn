using Entites;
using ServiceContracts;
using ServiceContracts.DTO;

namespace Services
{
    public class CoutriesService : ICounotiesService
    {
        private readonly List<Country> _countries;

        public CoutriesService()
        {
            _countries = new List<Country>();
        }

        public CountryResponse AddCountry(CountryAddRequest? countryAddRequest)
        {
            if (countryAddRequest == null)
            {
                throw new ArgumentNullException(nameof(countryAddRequest));
            }

            if (countryAddRequest.CountryName == null)
            {
                throw new ArgumentException(nameof(countryAddRequest.CountryName));
            }

            if (_countries.Any(x => x.CountryName == countryAddRequest.CountryName))
            {
                throw new ArgumentException("Given coutry name already exists.");
            }

            var country = countryAddRequest.ToCountry();
            country.CountryID = Guid.NewGuid();
            _countries.Add(country);
            return country.ToCountryResponse();
        }
    }
}
