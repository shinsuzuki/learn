using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CheckInterface.domain
{
    internal class User: IUser
    {
        IUserRepository _userRepository;
        IAddressRepository _addressRepository; 

        public User(IUserRepository userRepository, IAddressRepository addressRepository)
        {
            _userRepository = userRepository;
            _addressRepository = addressRepository;
        }

        public string GetName(string id)
        {
            return _userRepository.GetName(id);
        }

        public string GetAddress(string id)
        {
            return _addressRepository.GetAddress(id);

        }
    }
}
