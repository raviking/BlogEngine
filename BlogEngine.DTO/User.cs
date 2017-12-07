using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BlogEngine.DTO
{
    public class User
    {
        public long UserId
        {
            get;set;
        }
        public string FirstName
        {
            get; set;
        }
        public string LastName
        {
            get; set;
        }
        public string UserName
        {
            get; set;
        }
        public string Password
        {
            get; set;
        }
        public string Role
        {
            get; set;
        }
        public int UserStatus
        {
            get; set;
        }
        public string Gender
        {
            get; set;
        }
        public int Country
        {
            get; set;
        }
        public string Designation
        {
            get; set;
        }
        public DateTime RegistrationDate
        {
            get; set;
        }
        public string Email
        {
            get; set;
        }
        public int PostCount
        {
            get; set;
        }
    }
}
