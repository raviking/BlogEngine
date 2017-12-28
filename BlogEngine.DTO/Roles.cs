using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace BlogEngine.DTO
{
    public class Role
    {
        [Key]
        public int RoleId
        {
            get;set;
        }
        public string RoleName
        {
            get;set;
        }
        public string RoleDescription
        {
            get;set;
        }
    }
}
