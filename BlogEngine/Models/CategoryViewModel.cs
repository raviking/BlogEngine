using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BlogEngine.DTO;
using BlogEngine.DAL;

namespace BlogEngine.Models
{
    public class CategoryViewModel:ResponseDTO
    {
        public CategoryViewModel(BlogEngineDAL dataaccess)
        {
            Categories = dataaccess.Categories();
            
        }
        public List<Category> Categories { get; private set; }
        public int PostsCountForCategory { get; private set; }
    }
}