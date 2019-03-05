using BlogEngine.DAL;
using BlogEngine.Log;
using BlogEngine.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BlogEngine.BusinessLogic
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
        public bool ContactMail(ContactDTO contact)
        {
            bool result = false;
            //MailMessage mail = new MailMessage("you@yourcompany.com", "user@hotmail.com");
            //SmtpClient client = new SmtpClient();
            //client.Port = 25;
            //client.DeliveryMethod = SmtpDeliveryMethod.Network;
            //client.UseDefaultCredentials = false;
            //client.Host = "smtp.gmail.com";
            //mail.Subject = "this is a test email.";
            //mail.Body = "this is my test email body";
            //client.Send(mail);
            return result;
        }
    }
}
