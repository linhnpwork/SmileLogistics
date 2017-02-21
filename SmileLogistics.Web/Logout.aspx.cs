using Decided.Libs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SmileLogistics.Web.bases;

namespace SmileLogistics.Web
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            WebUtils.DeleteCookie(SiteValues.Cookie_AuthenticationName, Response, Request);
            Response.Redirect(ResolveUrl("~/"));
        }
    }
}