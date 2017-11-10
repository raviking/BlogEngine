using BlogEngine.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Html;

namespace BlogEngine
{
    public static class ActionLinkExtensions
    {
        public static MvcHtmlString PostLink(this HtmlHelper htmlHelper, Post post)
        {
            return htmlHelper.ActionLink(post.Title, "Post", "Blog",
                    new
                    {
                        postId=post.PostId
                    },
                    new
                    {
                        title = post.Title
                    }
                );
        }

        public static MvcHtmlString CategoryLink(this HtmlHelper htmlHelper, Category category)
        {
            return htmlHelper.ActionLink(category.CategoryName, "Category", "Blog",
                    new
                    {
                        categoryId = category.CategoryId
                    },
                    new
                    {
                        title = String.Format("See all posts in {0}", category.CategoryName)
                    }
                );
        }

        public static MvcHtmlString TagLink(this HtmlHelper htmlHelper, Tag tag)
        {
            return htmlHelper.ActionLink(tag.TagName, "Tag", "Blog",
                    new
                    {
                        tagId=tag.TagId
                    },
                    new
                    {
                        title = String.Format("See all posts in {0}", tag.TagName)
                    }
                );
        }
    }
}