using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BlogEngine.DTO
{
    public class ResponseDTO
    {
        public int Status
        {
            get; set;
        }
        public string ResponseMessage
        {
            set; get;
        }
        public int Id
        {
            set; get;
        }
        public bool IsSucess
        {
            set; get;
        }
        public int Count
        {
            set; get;
        }
    }
}
