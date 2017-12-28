using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace BlogEngine.DTO
{
    public class Category
    {
        [Key]
        public long CategoryId
        {
            get; set;
        }

        public string CategoryName
        {
            get; set;
        }

        public string CategoryUrlSlug
        {
            get; set;
        }

        public string CategoryDescription
        {
            get; set;
        }

        public int? Postcount
        {
            get;set;
        } 
    }
}
