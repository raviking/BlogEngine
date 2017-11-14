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
                ViewBag.Title = "Posts";
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: AuthorCreatedPosts" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: AuthorCreatedPosts - Begin");
            return View("AuthorPosts", objpostuserviewmodel);
        }
        public ActionResult Categories()
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Categories - Begin");
            List<Category> _lstCategory = null;
            try
            {
                _lstCategory = dataaccess.Categories();
                ViewBag.Title = "Categories";
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: Categories" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Categories - Begin");
            return View(_lstCategory);
        }
        public ActionResult Tags()
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Tags - Begin");
            List<Tag> _lstTags = null;
            try
            {
                _lstTags = dataaccess.Tags();
                ViewBag.Title = "Tags";
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: Tags" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Tags - Begin");
            return View(_lstTags);
        }
        public ActionResult NewPost()
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: NewPost - Begin");
            WidgetViewModel widgetviewmodel = null;         
            try
            {
                ViewBag.Title = "Add New Post";
                widgetviewmodel = new WidgetViewModel(dataaccess);
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: NewPost" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: NewPost - Begin");
            return View(widgetviewmodel);
        }  
        public ActionResult Users()
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Users - Begin");
            List<User> _lstUsers = null;
            try
            {
                ViewBag.Title = "All Users";
                _lstUsers = dataaccess.GetUserList();
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: Users" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Users - Begin");
            return View(_lstUsers);
        }    
    }
}