using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using log4net;
using System.Configuration;

namespace BlogEngine.Log
{
    public class LoggingHelper
    {
        private ILog log;

        public LoggingHelper()
        {
            log = LogManager.GetLogger(this.GetType());
        }

        public void Log(LoggingLevels level, string message)
        {
            if (bool.Parse(ConfigurationManager.AppSettings["EnableLogs"].ToString().ToLower()))
            {
                switch (level)
                {
                    case LoggingLevels.Debug:
                        log.Debug(message);
                        break;
                    case LoggingLevels.Error:
                        log.Error(message);
                        break;
                    case LoggingLevels.Info:
                        log.Info(message);
                        break;
                    case LoggingLevels.Warn:
                        log.Warn(message);
                        break;
                    case LoggingLevels.Fatal:
                        log.Fatal(message);
                        break;
                    default:
                        break;
                }
            }
        }

        public void Log(LoggingLevels level, string message, System.Exception exception)
        {
            if (bool.Parse(ConfigurationManager.AppSettings["EnableLogs"].ToString().ToLower()))
            {
                switch (level)
                {
                    case LoggingLevels.Debug:
                        log.Debug(message, exception);
                        break;
                    case LoggingLevels.Error:
                        log.Error(message, exception);
                        break;
                    case LoggingLevels.Info:
                        log.Info(message, exception);
                        break;
                    case LoggingLevels.Warn:
                        log.Warn(message, exception);
                        break;
                    case LoggingLevels.Fatal:
                        log.Fatal(message, exception);
                        break;
                    default:
                        break;
                }
            }
        }
    }
    public enum LoggingLevels
    {
        Warn,
        Info,
        Debug,
        Error,
        Fatal
    }
}
