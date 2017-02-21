using SmileLogistics.DAL.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace SmileLogistics.Web
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls11 | System.Net.SecurityProtocolType.Tls12;
            RegisterRoutes(RouteTable.Routes);

            using (DALTools dalTools = new DALTools())
            {
                dalTools.CheckGodRoleExists();
                dalTools.CheckGodUserExists();
            }
        }

        public static void RegisterRoutes(RouteCollection routeCollection)
        {
            routeCollection.MapPageRoute("Home", "home", "~/");
            routeCollection.MapPageRoute("Authentication", "authentication", "~/Authentication.aspx");
            routeCollection.MapPageRoute("Logout", "logout", "~/Logout.aspx");
            routeCollection.MapPageRoute("AllOthers", "{mod}", "~/Default.aspx");
        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}