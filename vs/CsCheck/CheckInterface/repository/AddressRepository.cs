using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CheckInterface.domain;

namespace CheckInterface.repository
{
    internal class AddressRepository : IAddressRepository
    {

        public string GetAddress(string id)
        {
            return "tokyo";
        }

    }
}
