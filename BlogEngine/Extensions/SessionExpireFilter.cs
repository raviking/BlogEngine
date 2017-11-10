using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace BlogEngine.Extensions
{
    public class SessionExpireFilter:ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            HttpContext context = HttpContext.Current;
            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                FormsAuthentication.SignOut();
                filterContext.Result = new RedirectResult("~/Security/Login");
                return;
            }
            base.OnActionExecuting(filterContext);
        }
    }
}