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
using System.Configuration;
using Newtonsoft.Json.Linq;

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

        #region Dashboard
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

        #endregion Dashboard

        #region Author Content
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
        [HttpGet]
        public ActionResult NewPost()
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: NewPost - Begin");
            WidgetViewModel widgetviewmodel = null;         
            try
            {
                ViewBag.Title = "Add New Post";
                ViewBag.HostUrl = ConfigurationManager.AppSettings["WebHostAddress"].ToString();
                widgetviewmodel = new WidgetViewModel(dataaccess);
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: NewPost" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: NewPost - Begin");
            return View(widgetviewmodel);
        }
        [HttpPost]
        public ActionResult NewPost(Post postObj)
        {
            ResponseDTO response = new ResponseDTO();                         
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: NewPost(httppost) - Begin");
            try
            {
                if (Session["CurrentUser"] != null)
                {
                    User _currentuser = Session["CurrentUser"] as User;
                    if (postObj.PostId > 0)
                    {
                        postObj.ModifiedBy = _currentuser.UserId.ToString();
                        postObj.ModifiedDate = DateTime.Now;
                        response = dataaccess.SavePost(postObj);
                    }
                    else
                    {
                        postObj.UserId = _currentuser.UserId;
                        postObj.CreatedBy = _currentuser.UserId;
                        response = dataaccess.SavePost(postObj);
                    }                                      
                }                
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: NewPost(httppost)" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: NewPost(httppost) - Begin");
            return Json(response,JsonRequestBehavior.AllowGet);
        }
        public ActionResult EditPost(long postId)
        {
            WidgetViewModel widgetviewmodel = null;
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: EditPost - Begin");
            try
            {
                ViewBag.Title = "Edit Post";
                ViewBag.PostId = postId;
                ViewBag.HostUrl = ConfigurationManager.AppSettings["WebHostAddress"].ToString();
                widgetviewmodel = new WidgetViewModel(dataaccess);                                
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: EditPost" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: EditPost - Begin");
            return View(widgetviewmodel);
        }
        public JsonResult GetPostDetailsById(long postId)
        {
            Post objPost = null;
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetPostDetailsById - Begin");
            try
            {                                
                objPost = dataaccess.GetPostDetailsById(postId);
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: GetPostDetailsById" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetPostDetailsById - Begin");
            return Json(objPost,JsonRequestBehavior.AllowGet);
        }
        public JsonResult DeletePost(long postId)
        {
            ResponseDTO response = null;
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: DeletePost - Begin");
            try
            {
                response = dataaccess.deletePost(postId);
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: DeletePost" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: DeletePost - Begin");
            return Json(response,JsonRequestBehavior.AllowGet);
        }

        #endregion Author Content

        #region Users
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
        [HttpGet]
        public ActionResult AddNewUser()
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: AddNewUser - Begin");
            UserDropdowns objuserDropdowns = null;
            try
            {
                ViewBag.Title = "Add New User";
                objuserDropdowns = new UserDropdowns(dataaccess);
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: AddNewUser" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: AddNewUser - Begin");
            return View(objuserDropdowns);
        }

        public JsonResult SaveUser(User objUser)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: AddNewUser(Post) - Begin");
            ResponseDTO response = null;
            try
            {
                response = dataaccess.SaveUser(objUser);
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " ::  AddNewUser(Post)" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " ::  AddNewUser(Post) - Begin");
            return Json(response,JsonRequestBehavior.AllowGet);
        }

        #endregion Users
    }
}