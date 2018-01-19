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

        #region Admin    
                   
        #region Posts
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
        #endregion Posts

        #region Categories

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
        public JsonResult SaveCategory(Category objCategory)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: SaveCategory - Begin");
            ResponseDTO response = new ResponseDTO();
            try
            {
                response = dataaccess.SaveCategory(objCategory);
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: SaveCategory" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: SaveCategory - Begin");
            return Json(response,JsonRequestBehavior.AllowGet);
        }
        public ActionResult EditCategory(long categoryId)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: EditCategory - Begin");
           Category objCategory = null;
            try
            {
                objCategory = dataaccess.GetCategoryById(categoryId);
                ViewBag.Title = "Edit Category";
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: EditCategory" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: EditCategory - Begin");
            return View(objCategory);
        }
        public JsonResult DeleteCategory(long categoryId)
        {
            ResponseDTO response = null;
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: DeleteCategory - Begin");
            try
            {
                response = dataaccess.DeleteCategory(categoryId);
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: DeleteCategory" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: DeleteCategory - End");
            return Json(response, JsonRequestBehavior.AllowGet);
        }

        public JsonResult IsCategorySlugExists(string categorySlug)
        {
            ResponseDTO response = null;
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: IsCategorySlugExists - Begin");
            try
            {
                response = dataaccess.IsCategorySlugExists(categorySlug);
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: IsCategorySlugExists" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: IsCategorySlugExists - End");
            return Json(response, JsonRequestBehavior.AllowGet);
        }

        #endregion Categories

        #region Tags

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
        public JsonResult SaveTag(Tag objTag)
        {
            ResponseDTO response = null;
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: SaveTag - Begin");
            try
            {
                response = dataaccess.SaveTag(objTag);
            }
            catch(Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: SaveTag" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: SaveTag - End");
            return Json(response,JsonRequestBehavior.AllowGet);
        }
        public ViewResult EditTag(long tagId)
        {
            Tag objTag = null;
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: EditTag - Begin");
            try
            {
                objTag = dataaccess.GetTagById(tagId);
                ViewBag.Title = "Edit Tag";
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: EditTag" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: EditTag - End");
            return View(objTag);
        }
        public JsonResult DeleteTag(long tagId)
        {
            ResponseDTO response = null;
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: DeleteTag - Begin");
            try
            {
                response = dataaccess.DeleteTag(tagId);
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: DeleteTag" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: DeleteTag - End");
            return Json(response, JsonRequestBehavior.AllowGet);
        }
        public JsonResult IsTagSlugExists(string tagSlug)
        {
            ResponseDTO response = null;
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: IsTagSlugExists - Begin");
            try
            {
                response = dataaccess.IsTagSlugExists(tagSlug);
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: IsTagSlugExists" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: IsTagSlugExists - End");
            return Json(response, JsonRequestBehavior.AllowGet);
        }

        #endregion Tags

        #endregion Admin

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
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Users - End");
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
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: AddNewUser - End");
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
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " ::  AddNewUser(Post) - End");
            return Json(response,JsonRequestBehavior.AllowGet);
        }
        public ViewResult UserProfile(long userId)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: UserProfile - Begin");
            UserDropdowns objuserDropdowns = null;
            try
            {
                objuserDropdowns = new UserDropdowns(dataaccess);
                ViewBag.Title = "User Profile";
                ViewBag.UserId = userId;
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " ::  UserProfile" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " ::  UserProfile - End");
            return View(objuserDropdowns);
        }
        public JsonResult UserDetailsById(long userId)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: UserDetailsById - Begin");
            User objUser = new User();
            try
            {
                objUser = dataaccess.GetUserDetailsById(userId);
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " ::  UserDetailsById" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " ::  UserDetailsById - End");
            return Json(objUser,JsonRequestBehavior.AllowGet);
        }
        public JsonResult DeleteUser(long userId)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: DeleteUser - Begin");
            ResponseDTO response = new ResponseDTO();     
            try
            {
                response = dataaccess.DeleteUser(userId);
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " ::  DeleteUser" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " ::  DeleteUser - End");
            return Json(response,JsonRequestBehavior.AllowGet);
        }

        #endregion Users

        #region Comments

        public ViewResult Comments()
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Comments - Begin");
            List<Comment> lstComments = new List<Comment>();
            try
            {
                lstComments = dataaccess.GetAllComments();
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " ::  Comments" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " ::  Comments - End");
            return View(lstComments);
        }

        public JsonResult DeleteComment(long commentId)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: DeleteComment - Begin");
            ResponseDTO response = new ResponseDTO();
            try
            {
                response = dataaccess.DeleteComment(commentId);
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " ::  DeleteComment" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " ::  DeleteComment - End");
            return Json(response,JsonRequestBehavior.AllowGet);
        }

        public JsonResult SaveCommentReply(Comment objReply)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: SaveReply - Begin");
            ResponseDTO response = new ResponseDTO();
            try
            {
                if (Session["CurrentUser"] != null)
                {
                    User _currentUser = Session["CurrentUser"] as User;
                    objReply.Comment_Author = _currentUser.FirstName + _currentUser.LastName;
                    objReply.Comment_AuthorEmail = _currentUser.Email;
                    objReply.UserId = _currentUser.UserId;

                    response = dataaccess.SaveCommentReply(objReply);
                }                
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " ::  SaveReply" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " ::  SaveReply - End");
            return Json(response, JsonRequestBehavior.AllowGet);
        }

        #endregion Comments

        #region Subscribers
        
        public ViewResult SubscribersView()
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: SubscribersView - Begin");
            List<User> _lstSubscribers = new List<DTO.User>();
            try
            {
                _lstSubscribers = dataaccess.GetAllSubscribers();
            }
            catch(Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " ::  SubscribersView" + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: SubscribersView - End");
            return View(_lstSubscribers);
        }

        #endregion Subscribers
    }
}