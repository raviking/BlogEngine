using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BlogEngine.DTO
{
    public class Tag
    {
        public long TagId
        {
            get; set;
        }

        public string TagName
        {
            get; set;
        }

        public string TagUrlSlug
        {
            get; set;
        }

        public string TagDescription
        {
            get; set;
        }

        public int PostCount
        {
            get;set;
        }
    }
}
