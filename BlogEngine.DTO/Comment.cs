using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace BlogEngine.DTO
{
    public class Comment
    {
        [Key]
        public long Comment_Id
        {
            get;set;
        }
        public string Comment_Content
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
        public long Comment_PostId
        {
            get;set;
        }
        public bool IsReply
        {

            get;set;
        }
    }
}
