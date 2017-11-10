using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BlogEngine.DTO
{
    public class Category
    {
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

    }
}
