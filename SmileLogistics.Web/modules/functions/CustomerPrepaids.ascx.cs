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
    public partial class CustomerPrepaids : BaseControl
    {
        public string _RolePermissions = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckPermissionAccess();
                _RolePermissions = GetPermissionsAsJSON();

                LoadGoodsTypes();
            }
        }

        private void LoadGoodsTypes()
        {
            using (DALTools dalTools = new DALTools())
            {
                List<eCustomer> all = dalTools.Customer_GetEs();
                if (all != null)
                {
                    string html = "<select id=\"info-customers\" class=\"form-control\" style=\"width: 100%;\">";

                    foreach (eCustomer obj in all)
                    {
                        html += "<option value=\"" + obj.ID.ToString() + "\">" + obj.Name + "</option>";
                    }

                    html += "</select>";

                    divCustomers.InnerHtml = html;
                }
                else
                {
                    divCustomers.InnerHtml = "<label class='control-label label-quicklink'><a href='/khach-hang'>Chưa có dữ liệu Khách hàng! Nhấp chọn chuyển sang trang Quản lý!</a></label>";
                }
            }
        }
    }
}