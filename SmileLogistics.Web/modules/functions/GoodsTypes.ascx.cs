using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SmileLogistics.Web.bases;
using SmileLogistics.DAL;
using SmileLogistics.DAL.Entities;
using SmileLogistics.DAL.Helpers;

namespace SmileLogistics.Web.modules.functions
{
    public partial class GoodsTypes : BaseControl
    {
        public string _RolePermissions = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckPermissionAccess();
                _RolePermissions = GetPermissionsAsJSON();
            }
        }
    }
}