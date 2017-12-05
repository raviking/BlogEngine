using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;


namespace BlogEngine
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            log4net.Config.XmlConfigurator.Configure();

            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            //routes.MapMvcAttributeRoutes();                      

            //single post url 
            routes.MapRoute(
                "Post",
                "{urlslug}",
                new { controller = "Blog",action = "Post"}
            );

            //category url
            routes.MapRoute(
               "Category",
               "category/{catUrlSlug}",
               new
               {
                   controller = "Blog",
                   action = "Category"
               }
           );

            //tag url
            routes.MapRoute(
               "Tag",
               "tag/{tagSlug}",
               new
               {
                   controller = "Blog",
                   action = "Tag"
               }
           );

            //Default route
            routes.MapRoute(
               name: "Default",
               url: "{Controller}/{Action}/{id}",
               defaults: new
               {
                   controller = "Blog",
                   action = "Posts",
                   id = UrlParameter.Optional
               }
           );
        }
    }
}
