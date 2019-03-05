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
            string adminEmailUsername = ConfigurationManager.AppSettings["AdminEmailUsername"].ToString();
            string adminEmailPassword=ConfigurationManager.AppSettings["AdminEmailPassword"].ToString();
            try
            {
                MailMessage mail = new MailMessage();
                SmtpClient client = new SmtpClient();
                mail.From = new MailAddress(adminEmailUsername);
                mail.To.Add(new MailAddress(adminEmailUsername));
                mail.Subject = contact.ContactSubject;
                string body = "<table><tbody><td>Name : " + contact.ContactName + "</td>"
                                + "<td>Email  : " + contact.ContactEmail + "</td>"
                                + "<td>Subject  : " + contact.ContactSubject + "</td>"
                                + "<td>Message  : " + contact.ContactMessage + "</td>"
                                + "<tbody></table>";                               

                mail.Body = body;
                client.Port = 587;
                client.DeliveryMethod = SmtpDeliveryMethod.Network;
                client.UseDefaultCredentials = false;
                client.Host = "smtp.gmail.com";
                client.Credentials = new NetworkCredential(adminEmailUsername, adminEmailPassword);
                client.Send(mail);

                result = true;
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
