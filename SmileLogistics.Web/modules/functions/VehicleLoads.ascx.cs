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
    public partial class VehicleLoads : BaseControl
    {
        public string _RolePermissions = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckPermissionAccess();
                _RolePermissions = GetPermissionsAsJSON();

                LoadVehicleTypes();
            }
        }

        private void LoadVehicleTypes()
        {
            using (DALTools dalTools = new DALTools())
            {
                List<eVehicleType> all = dalTools.VehicleType_GetEs();
                if (all != null)
                {
                    string html = "<select id=\"info-vehicletypes\" class=\"select-select2 select2-hidden-accessible\" style=\"width: auto;\">";

                    foreach (eVehicleType obj in all)
                    {
                        html += "<option value=\"" + obj.ID.ToString() + "\">" + obj.Name + " (" + obj.Code + ")" + "</option>";
                    }

                    html += "</select>";

                    divVehicleTypes.InnerHtml = html;
                }
                else
                {
                    divVehicleTypes.InnerHtml = "<label class='control-label label-quicklink'><a href='/loai-xe'>Chưa có dữ liệu Loại xe! Nhấp chọn chuyển sang trang Quản lý!</a></label>";
                }
            }
        }
    }
}