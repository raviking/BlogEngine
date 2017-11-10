using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BlogEngine.DTO;
using BlogEngine.DAL;

namespace BlogEngine.Models
{
    public class PostUserViewModel
    {
        //DEefault Constructors
        public PostUserViewModel()
        {

        }
        //Parameterized constructor.
        public PostUserViewModel(BlogEngineDAL dataaccess, long userId)
        {
            Posts = dataaccess.GetPostsByUserId(userId);
            User = dataaccess.GetUserDetailsById(userId);
        }
        public List<Post> Posts
        {
            get;private set;
        }
            
        public User User
        {
            get;private set;
        }
        //public List<Comments> Comments
        //{
        //    get;set;
        //}
    }
}