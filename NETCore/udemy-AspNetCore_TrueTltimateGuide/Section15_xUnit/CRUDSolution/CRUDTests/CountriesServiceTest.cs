using ServiceContracts;
using ServiceContracts.DTO;
using Services;

namespace CRUDTests
{
    public class CountriesServiceTest
    {
        private ICounotiesService _countriesService;

        public CountriesServiceTest()
        {
            _countriesService = new CoutriesService();
        }

        [Fact]
        public void AddCountry_NullCoutry()
        {
            // arrange
            CountryAddRequest? request = null;

            // assert
            Assert.Throws<ArgumentNullException>(() =>
            {
                // act
                _countriesService.AddCountry(request);
            });
        }

        [Fact]
        public void AddCountry_CoutryNameIsNull()
        {
            // arrange
            CountryAddRequest? request = new CountryAddRequest() { CountryName = null };

            // assert
            Assert.Throws<ArgumentException>(() =>
            {
                // act
                _countriesService.AddCountry(request);
            });
        }

        [Fact]
        public void AddCountry_DuplicateCoutryName()
        {
            // arrange
            CountryAddRequest? request1 = new CountryAddRequest() { CountryName = "USA" };
            CountryAddRequest? request2 = new CountryAddRequest() { CountryName = "USA" };

            // assert
            Assert.Throws<ArgumentException>(() =>
            {
                // act
                _countriesService.AddCountry(request1);
                _countriesService.AddCountry(request2);
            });
        }

        [Fact]
        public void AddCountry_PropertyCoutryDetails()
        {
            // arrange
            CountryAddRequest? request = new CountryAddRequest() { CountryName = "Japan" };

            // act
            var response = _countriesService.AddCountry(request);

            // assert
            Assert.True(response.CountryID != Guid.Empty);
            Assert.True(response.CountryName == "Japan");
        }
    }
}
