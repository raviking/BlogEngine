using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BlogEngine.DAL;
using BlogEngine.DTO;

namespace BlogEngine.Models
{
    public class UserDropdowns
    {
        public UserDropdowns(BlogEngineDAL dataaccess)
        {
            Countries = dataaccess.GetCountryDropdowns();
            Roles=dataaccess.GetRoleDropdowns();
        }

        public List<Country> Countries
        {
            get;set;
        }
        public List<Role> Roles
        {
            get;set;
        }
    }
}