using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BlogEngine.DTO
{
    public class Reply
    {
        public long ReplyId
        {
            get;set;
        }
        public string Reply_Content
        {
            get;set;
        }
        public DateTime Reply_Date
        {
            get;set;
        }
        public string Reply_Author
        {
            get;set;
        }
        public long Reply_CoommentId
        {
            get;set;                
        }
    }
}
