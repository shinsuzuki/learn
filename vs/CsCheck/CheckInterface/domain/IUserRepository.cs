using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CheckInterface.domain
{
    interface IUserRepository
    {
        string GetName(string id);
    }
}
