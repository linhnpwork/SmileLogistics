using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SmileLogistics.Web.bases;
using SmileLogistics.DAL.Helpers;

namespace SmileLogistics.Web
{
    public partial class Authentication : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (CurrentSys_User != null)
                Response.Redirect(ResolveUrl("~/"));            
        }
    }
}