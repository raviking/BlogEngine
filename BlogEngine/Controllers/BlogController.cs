using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BlogEngine.CodeBaseControllers;
using BlogEngine.Log;
using BlogEngine.DAL;
using BlogEngine.Models;
using BlogEngine.DTO;
//using System.Web.Routing;

namespace BlogEngine.Controllers
{
    public class BlogController : MvcBaseController
    {
        //global declarations
        public string classname = "BlogController";
        LoggingHelper logginghelper = new LoggingHelper();
        BlogEngineDAL dataaccess = null;

        //constructor
        public BlogController() : base()
        {
            dataaccess = new BlogEngineDAL();
        }

        public ActionResult Index()
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Index -Begin");
            try
            {

            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: Index" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Index -End");
            return View();
        }

        public ActionResult About()
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: About -Begin");
            try
            {
                ViewBag.Message = "Your application description page.";
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: About" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: About -End");
            return View();
        }

        public ActionResult Contact()
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Contact -Begin");
            try
            {
                ViewBag.Message = "Your contact page.";
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: Contact" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Contact -End");
            return View();
        }

        public ViewResult Posts(int page = 1)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Posts -Begin");
            ListViewModel viewModel = null;
            try
            {
                viewModel = new ListViewModel(dataaccess, page);
                ViewBag.Title = "Latest Posts";
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: Posts " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Posts -End");
            return View("List", viewModel);
        }

        public ViewResult category(string catUrlSlug, int p = 1)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Category - Begin");
            ListViewModel viewModel = null;
            try
            {
                viewModel = new ListViewModel(dataaccess, catUrlSlug, p,"Category");
                if (viewModel.Category == null)
                    throw new HttpException(404, "Category Not Found");
                ViewBag.Title = String.Format(@"Latest posts on category ""{0}""", viewModel.Category.CategoryName);
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: Category " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Category - End");
            return View("List", viewModel);
        }

        public ViewResult tag(string tagSlug, int tp = 1)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Tag - Begin");
            ListViewModel viewModel = null;
            try
            {
                viewModel = new ListViewModel(dataaccess, tagSlug, tp, "Tag");
                if (viewModel.Tag == null)
                    throw new HttpException(404, "Tag Not Found");
                ViewBag.Title = String.Format(@"Latest posts on Tag ""{0}""", viewModel.Tag.TagName);
            }
            catch(Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: Tag " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Tag - End");
            return View("List", viewModel);
        }

        public ViewResult Search(string s,int p = 1)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Search - Begin");
            ListViewModel viewModel = null;
            try
            {
                viewModel = new ListViewModel(dataaccess, s, p, "Search");
                ViewBag.Title = String.Format(@"Lists of posts found for search text ""{0}""", s);
            }
            catch(Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: Search " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Search - End");
            return View("List",viewModel);
        }

        public ViewResult Post(string urlslug)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Post - Begin");
            Post post = null;
            try
            {
                post = dataaccess.Post(urlslug);
                if (post != null)
                    throw new HttpException(404, "Post Not Found");
                else if (post.IsPublished == false && User.Identity.IsAuthenticated==false)
                    throw new HttpException(401, "Post Not Published");
            }
            catch(Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: Post " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Post - End");
            return View(post);
        }

        [ChildActionOnly]
        public PartialViewResult Sidebars()
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Sidebars - Begin");
            WidgetViewModel widgetviewmodel = null;
            try
            {
                widgetviewmodel = new WidgetViewModel(dataaccess);
            }
            catch(Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: Sidebars " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Sidebars - End");
            return PartialView("_Sidebars", widgetviewmodel);
        }
    }
}