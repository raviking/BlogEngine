using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BlogEngine.DTO
{
    public class Comment
    {
        public long Comment_Id
        {
            get;set;
        }
        public string Comment_Content
        {
            get;set;
        }
        public bool Comment_Approved
        {
            get;set;
        }
        public DateTime Comment_Date
        {
            get;set;
        }
        public string Comment_Author
        {
            get;set;
        }
        public string Comment_AuthorEmail
        {
            get;set;
        }
        public long Comment_Parent
        {
            get;set;
        }
        public long UserId
        {
            get;set;                            
        }
        public string postName
        {
            get;set;
        }
    }
}
