using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SmileLogistics.Web.bases;
using SmileLogistics.DAL;
using SmileLogistics.DAL.Helpers;
using SmileLogistics.DAL.Entities;

namespace SmileLogistics.Web.modules.systems
{
    public partial class RolePermission : BaseControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string sId = Request.QueryString["id"];
                if (string.IsNullOrEmpty(sId))
                    Response.Redirect(ResolveUrl("~/sysroles"));

                int id = 0;
                try { id = int.Parse(sId); } catch { Response.Redirect(ResolveUrl("~/sysroles")); }

                using (DALTools dalTools = new DALTools())
                {
                    eSys_Role role = dalTools.Sys_Role_GetE(id);
                    if (role == null) Response.Redirect(ResolveUrl("~/sysroles"));

                    strRoleName.InnerHtml = role.Name;
                }
            }
        }
    }
}