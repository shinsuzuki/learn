using CheckInterface.domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CheckInterface.repository
{
    internal class UserRepository : IUserRepository
    {
        public UserRepository()
        {
                
        }

        public string GetName(string id)
        {
            return "akiya eigo";
        }
    }
}
