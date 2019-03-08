using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BlogEngine.DTO;
using BlogEngine.DAL;
using System.Configuration;

namespace BlogEngine.Models
{
    public class ListViewModel
    {
        public int postsCountInHomePage = Convert.ToInt32(ConfigurationManager.AppSettings["NumberOfPostsOnHomePage"].ToString());

        public ListViewModel()
        {

        }
        public ListViewModel(BlogEngineDAL dataaccess, int p)
        {
            PageNo = p;
            isHomePage = true;
            Posts = dataaccess.Posts(p - 1, postsCountInHomePage);
            LatestPost = Posts[0];
            TotalPosts = dataaccess.TotalPosts();
        }

        public ListViewModel(BlogEngineDAL dataaccess, string searchType, int p,string type)
        {
            isHomePage = false;
            PageNo = p; //page number
            switch (type)
            {
                case "Tag":
                    Posts = dataaccess.PostsForTag(searchType, p - 1, postsCountInHomePage);
                    TotalPosts = dataaccess.TotalPostForTag(searchType);
                    Tag = dataaccess.Tag(searchType);
                    break;
                case "Category":
                    Posts = dataaccess.PostsForCategory(searchType, p - 1, postsCountInHomePage);
                    TotalPosts = dataaccess.TotalPostsForCategory(searchType);
                    Category = dataaccess.Category(searchType);
                    break;
                default:
                    Posts = dataaccess.PostsForSearch(searchType, p - 1, postsCountInHomePage);
                    TotalPosts = dataaccess.TotalPostsForSearch(searchType);
                    Search = searchType;//search text
                    break;
            }
            
        }
       
        public List<Post> Posts
        {
            get;private set;
        }
        public Post LatestPost
        {
            get;set;
        }
        public int TotalPosts
        {
            get;private set;
        }
        public Category Category
        {
            get;private set;
        }
        public Tag Tag
        {
            get;private set;
        }
        public string Search
        {
            get;private set;
        }
        public int PageNo
        {
            get; private set;
        }
        public bool isHomePage
        {
            get;private set;
        }
    }
}