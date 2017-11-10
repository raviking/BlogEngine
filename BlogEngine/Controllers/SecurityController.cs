using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using BlogEngine.CodeBaseControllers;
using BlogEngine.DTO;
using BlogEngine.DAL;
using BlogEngine.Log;
using BlogEngine.Models;

namespace BlogEngine.Controllers
{
    public class SecurityController : MvcBaseController
    {
        //global declarations
        public string classname = "HomeController";
        LoggingHelper logginghelper = new LoggingHelper();
        BlogEngineDAL dataaccess = null;

        //Constructor
        public SecurityController()
        {
            dataaccess = new BlogEngineDAL();
        }

        [HttpGet]
        public ActionResult Login(string returnUrl)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Login(HttpGet) - Begin");
            try
            {
                if (User.Identity.IsAuthenticated)
                {
                    if (!String.IsNullOrEmpty(returnUrl) && Url.IsLocalUrl(returnUrl))
                        return Redirect(returnUrl);
                    return RedirectToAction("Manage", "Account");
                }
                ViewBag.ReturnUrl = returnUrl;
            }
            catch(Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: Login(HttpGet) " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Login(HttpGet) - End");
            return View();
        }

        [HttpPost]
        public JsonResult Login(LoginModel loginModel)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Login(HttpPost) - Begin");
            ResponseDTO response = new ResponseDTO();
            User currentuser = null;
            try
            {
                if (loginModel != null)
                {
                    currentuser = dataaccess.GetCurrentUser(loginModel.UserName, loginModel.Password);
                    if (currentuser != null)
                    {
                        if (currentuser.UserName == loginModel.UserName && currentuser.Password == loginModel.Password)
                        {
                            Session["CurrentUser"] = currentuser;
                            response.IsSucess = true;
                            FormsAuthentication.SetAuthCookie(loginModel.UserName, false);
                            if (!String.IsNullOrEmpty(loginModel.ReturnUrl) && Url.IsLocalUrl(loginModel.ReturnUrl))
                                response.ResponseMessage = loginModel.ReturnUrl;
                            else
                                response.ResponseMessage = "";                      
                        }
                    }                    
                    else
                    {
                        response.ResponseMessage = "Incorrect User credentials";
                        response.IsSucess = false;
                    }
                }
            }
            catch(Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: Login(HttpPost) " + ex);
            }            
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Login(HttpPost) - End");
            return Json(response,JsonRequestBehavior.AllowGet);
        }

        public ActionResult Logout()
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Logout - Begin");

            FormsAuthentication.SignOut();

            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Logout - End");
            return RedirectToAction("Login", "Security");
        }
    }
}