using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BlogEngine.Log;
using BlogEngine.CodeBaseControllers;

namespace BlogEngine.Controllers
{
    [Authorize]
    public class AccountController : MvcBaseController
    {
        // GET: Admin
        LoggingHelper logginghelper = new LoggingHelper();
        public string classname = "AccountController";

        //Constructor..
        public AccountController()
            : base()
        {

        }

        public ActionResult Dashboard()
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Dashboard - Begin");
            try
            {
                ViewBag.Title = "Dashboard";
            }
            catch(Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: Dashboard" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Dashboard - End");
            return View();
        }
        public ActionResult AuthorCreatedPosts()
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Logout - Begin");
            return View("AuthorPosts");
        }
    }
}