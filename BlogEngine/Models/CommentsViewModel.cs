using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BlogEngine.DTO;

namespace BlogEngine.Models
{
    public class CommentsViewModel
    {
        public int Comment_Id
        {
            get;set;
        }
        public bool Comment_Approved
        {
            get;
            set;
        }
        public string Comment_Author
        {
            get;
            set;
        }
        public string Comment_AuthorEmail
        {
            get;
            set;
        }
        public string Comment_Content
        {
            get;
            set;
        }
        public DateTime Comment_Date
        {
            get;
            set;
        }
        public List<Comment> SubComments
        {
            get;set;
        }
    }
}