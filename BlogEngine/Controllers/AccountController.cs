using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BlogEngine.Log;
using BlogEngine.CodeBaseControllers;
using BlogEngine.Extensions;
using BlogEngine.DTO;
using BlogEngine.DAL;
using BlogEngine.Models;

namespace BlogEngine.Controllers
{
    [Authorize]
    [SessionExpireFilter]
    public class AccountController : MvcBaseController
    {
        // GET: Admin       
        public string classname = "AccountController";
        LoggingHelper logginghelper = null;
        BlogEngineDAL dataaccess = null;

        //Constructor..
        public AccountController()
            : base()
        {
            logginghelper = new LoggingHelper();
            dataaccess= new BlogEngineDAL();
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
        public ActionResult AuthorCreatedPosts(long UserId)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: AuthorCreatedPosts - Begin");
            PostUserViewModel objpostuserviewmodel = null;
            try
            {
                objpostuserviewmodel = new PostUserViewModel(dataaccess, UserId);
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: AuthorCreatedPosts" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: AuthorCreatedPosts - Begin");
            return View("AuthorPosts", objpostuserviewmodel);
        }
    }
}