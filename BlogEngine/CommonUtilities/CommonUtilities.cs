using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace BlogEngine.CommonUtilities
{
    public static class CommonUtilities
    {
        #region Global Declaration
        private static string key = "01AB=$6Q";
        private static byte[] iv = { 0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF };
        #endregion

        #region encrypt
        /// <summary>
        /// To encrypt a string and return a encrypted String
        /// </summary>
        /// <param name="text"></param>
        /// <returns>string</returns>
        public static string Encrypt(string text)
        {
            byte[] encodedkey;
            byte[] bytes;

            encodedkey = Encoding.UTF8.GetBytes(key);
            var csp = new DESCryptoServiceProvider();

            bytes = Encoding.UTF8.GetBytes(text);
            var ms = new MemoryStream();

            var cs = new CryptoStream(ms, csp.CreateEncryptor(encodedkey, iv), CryptoStreamMode.Write);
            cs.Write(bytes, 0, bytes.Length);
            cs.FlushFinalBlock();

            return Convert.ToBase64String(ms.ToArray());
        }
        #endregion

        #region decrypt
        /// <summary>
        /// To decrypt a string and return a decrypted String
        /// </summary>
        /// <param name="text"></param>
        /// <returns>string</returns>
        public static string Decrypt(string text)
        {

            byte[] encodedkey;
            byte[] bytes;

            encodedkey = Encoding.UTF8.GetBytes(key);
            var csp = new DESCryptoServiceProvider();

            bytes = Convert.FromBase64String(text);

            var ms = new MemoryStream();

            var cs = new CryptoStream(ms, csp.CreateDecryptor(encodedkey, iv), CryptoStreamMode.Write);
            cs.Write(bytes, 0, bytes.Length);
            cs.FlushFinalBlock();
            return Encoding.UTF8.GetString(ms.ToArray());
        }
        #endregion

    }
}