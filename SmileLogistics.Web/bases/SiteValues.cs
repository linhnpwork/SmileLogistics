using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SmileLogistics.DAL;

namespace SmileLogistics.Web.bases
{
    /// <summary>
    /// Class chứa các giá trị Mặc định, Không thay đổi
    /// </summary>
    public class SiteValues
    {
        public static string LogoPath = "~/img/logo.jpg";

        #region commonpages

        public static string Page_503 = "~/pages/503.html";
        public static string Page_403 = "~/pages/403.html";

        #endregion

        #region GodeSys_User

        public static string Cookie_AuthenticationName = ".sl.membership";
        /// <summary>
        /// Username của GodeSys_User
        /// </summary>
        public static string GodeSys_User_Username = "Administrator@sl.com";
        /// <summary>
        /// Password của GodeSys_User
        /// </summary>
        public static string GodeSys_User_Password = "1234qwerASDF!@#$";

        #endregion               
    }
}