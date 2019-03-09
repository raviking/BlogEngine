using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BlogEngine.DTO;

namespace BlogEngine.Models
{
    public class CommentsViewModel
    {
        public Comment Comment
        {
            get;set;
        }
        public Reply Reply
        {
            get;set;
        }
    }
}