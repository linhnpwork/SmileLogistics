using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SmileLogistics.Web.bases;
using SmileLogistics.DAL;
using SmileLogistics.DAL.Helpers;

namespace SmileLogistics.Web
{
    public partial class Default : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (CurrentSys_User == null)
                Response.Redirect(ResolveUrl("~/authentication"));

            Control ctr = null;
            string seSys_Module = Page.RouteData.Values["mod"] as string;
            if (string.IsNullOrEmpty(seSys_Module))
            {
                ctr = LoadControl(ResolveUrl("~/modules/Default.ascx"));
            }
            else
            {
                switch (seSys_Module.ToLower())
                {
                    case "home":
                        ctr = LoadControl(ResolveUrl("~/modules/Default.ascx"));
                        break;
                    case "profile":
                        ctr = LoadControl(ResolveUrl("~/modules/Profile.ascx"));
                        break;
                    case "sysroles":
                        ctr = LoadControl(ResolveUrl("~/modules/systems/Roles.ascx"));
                        break;
                    case "sysrole-permission":
                        ctr = LoadControl(ResolveUrl("~/modules/systems/RolePermission.ascx"));
                        break;
                    case "sysadmins":
                        ctr = LoadControl(ResolveUrl("~/modules/systems/Administrators.ascx"));
                        break;
                    case "sysmodules":
                        ctr = LoadControl(ResolveUrl("~/modules/systems/Modules.ascx"));
                        break;
                    default:
                        using (DALTools dalTools = new DALTools())
                        {
                            var sysModule = dalTools.Sys_Module_GetE(seSys_Module);
                            if (sysModule == null)
                                ctr = LoadControl(ResolveUrl("~/modules/Default.ascx"));
                            else
                                ctr = LoadControl(ResolveUrl(sysModule.Path));
                        }
                        break;
                }
            }

            if (ctr != null)
                divMain.Controls.Add(ctr);
        }
    }
}