using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BlogEngine.DTO;
using BlogEngine.DAL;

namespace BlogEngine.Models
{
    public class WidgetViewModel
    {
        public WidgetViewModel(BlogEngineDAL dataaccess)
        {
            Categories = dataaccess.Categories();
            Tags = dataaccess.Tags();
            LatestPosts = dataaccess.Posts(0, 10);
        }

        public List<Category> Categories
        {
            get;private set;
        }
        public List<Tag> Tags
        {
            get;private set;
        }
        public List<Post> LatestPosts
        {
            get;private set;
        }
    }
}