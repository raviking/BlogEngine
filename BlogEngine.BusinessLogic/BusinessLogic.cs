using BlogEngine.DAL;
using BlogEngine.Log;
using BlogEngine.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net.Mail;
using System.Configuration;
using System.Net;
using System.Web.Configuration;

namespace BlogEngine.BusinessLogicLayer
{
    public class BusinessLogic
    {
        public string classname = "BusinessLogic";
        LoggingHelper logginghelper = null;
        BlogEngineDAL dataaccess = null;

        public BusinessLogic()
        {
            logginghelper = new LoggingHelper();
            dataaccess = new BlogEngineDAL();
        }
        
        /// <summary>
        /// Sends mail to Admin from Contact form
        /// </summary>
        /// <param name="contact"></param>
        /// <returns></returns>
        public bool SendContactMail(ContactDTO contact)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: ContactMail - Begin");
            bool result = false;
            string ToMailAddress = WebConfigurationManager.AppSettings["ToMailAddress"].ToString();
            try
            {
                MailMessage mail = new MailMessage();
                mail.To.Add(new MailAddress(ToMailAddress));
                mail.Subject = contact.ContactSubject;
                string body = "<table><tbody><td>Name : " + contact.ContactName + "</td>"
                                + "<td>Email  : " + contact.ContactEmail + "</td>"
                                + "<td>Subject  : " + contact.ContactSubject + "</td>"
                                + "<td>Message  : " + contact.ContactMessage + "</td>"
                                + "<tbody></table>";                               

                mail.Body = body;
                mail.IsBodyHtml = true;
                using (var smtp=new SmtpClient())
                {
                    smtp.Send(mail);
                    result = true;
                }
            }     
            catch(Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: ContactMail " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: ContactMail - End");
            return result;
        }
    }
}
