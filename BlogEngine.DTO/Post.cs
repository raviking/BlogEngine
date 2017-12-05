using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BlogEngine.DTO
{
    public class Post
    {
        public long PostId
        {
            get;set;
        }
        public string Title
        {
            get;set;
        }
        public string ShortDescription
        {
            get;set;
        }
        public string PostDescription
        {
            get; set;
        }

        public string PostMeta
        {
            get; set;
        }

        public int postStatus
        {
            get;set;
        }
        public string PostUrlSlug
        {
            get; set;
        }

        public bool IsPublished
        {
            get; set;
        }

        public DateTime? PostedOn
        {
            get; set;
        }

        public string CreatedBy
        {
            get;set;
        }

        public DateTime CreatedDate
        {
            get;set;
        }

        public string ModifiedBy
        {
            get;set;
        }

        public DateTime? ModifiedDate
        {
            get; set;
        }

        public Category Category
        {
            get; set;
        }

        public List<Tag> Tags
        {
            get; set;
        }

        public long CategoryId
        {
            get;set;
        }

        public long UserId
        {
            get;set;
        }
    }

}

