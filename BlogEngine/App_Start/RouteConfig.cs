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

            routes.MapRoute(
               "Homepage",
               "page/{page}",
               defaults:new
               {
                   controller = "Blog",
                   action = "Posts",
                   page = UrlParameter.Optional
               }
           );

            //single post url 
            routes.MapRoute(
                "Post",
                "{urlslug}",
                new { controller = "Blog",action = "Post"}
            );           

            //category url
            routes.MapRoute(
               "Category",
               "category/{catUrlSlug}/{p}",
               new
               {
                   controller = "Blog",
                   action = "category",
                   p = UrlParameter.Optional 
               }
           );

            //tag url
            routes.MapRoute(
               "Tag",
               "tag/{tagSlug}/{tp}", //tags pagination
               new
               {
                   controller = "Blog",
                   action = "tag",
                   tp = UrlParameter.Optional
               }
           );

            //Default route
            routes.MapRoute(
               name: "Default",
               url: "{Controller}/{Action}/{p}",
               defaults: new
               {
                   controller = "Blog",
                   action = "Posts",
                   p = UrlParameter.Optional
               }
           );
        }
    }
}
