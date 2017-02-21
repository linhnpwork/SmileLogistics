using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SmileLogistics.Web.bases;
using SmileLogistics.DAL;
using SmileLogistics.DAL.Entities;

namespace SmileLogistics.Web.modules.global
{
    public partial class Headers : BaseControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                eSys_User currentAdmin = CurrentSys_User;
                if (currentAdmin != null)
                {
                    if (string.IsNullOrEmpty(currentAdmin.Avatar))
                        imgAvatar.Src = ResolveUrl(SiteValues.LogoPath);
                    else
                        imgAvatar.Src = ResolveUrl(currentAdmin.Avatar);
                }
            }
        }
    }
}