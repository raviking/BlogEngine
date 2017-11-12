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

        public ActionResult NewPost()
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: NewPost - Begin");            
            try
            {
                //
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: NewPost" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: NewPost - Begin");
            return View();
        }

        public ActionResult Categories()
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Categories - Begin");
            List<Category> _lstCategories = null;
            try
            {
                _lstCategories = dataaccess.Categories();
                //if (_lstCategories != null && _lstCategories.Count > 0)
                //{
                //    foreach (var category in _lstCategories)
                //        category.Count = dataaccess.TotalPostsForCategory(category.CategoryId.ToString());
                //}
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: Categories" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Categories - Begin");
            return View(_lstCategories);
        }
    }
}