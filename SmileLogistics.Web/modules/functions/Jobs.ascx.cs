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
    public partial class Jobs : BaseControl
    {
        public string _RolePermissions = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckPermissionAccess();
                _RolePermissions = GetPermissionsAsJSON();

                LoadFilters();
            }
        }

        private void LoadFilters()
        {
            using (DALTools dalTools = new DALTools())
            {
                LoadFilter_Types();
                LoadFilter_Customers(dalTools);
                LoadFilter_Status();
            }
        }

        private void LoadFilter_Status()
        {
            if (GlobalValues.JobStatus != null)
            {
                string html =
                    "<select id=\"filter-statuses\" class=\"form-control\" style=\"width: 100%;\">" +
                        "<option value=\"-1\">Tất cả</option>";

                foreach (Commons.eStatus obj in GlobalValues.JobStatus)
                {
                    html += "<option value=\"" + obj.ID.ToString() + "\">" + obj.Name + "</option>";
                }

                html += "</select>";

                divFilterStatuses.InnerHtml = html;
            }
            else
            {
                divFilterStatuses.InnerHtml = "<label class='control-label label-quicklink'><a href='#'>Chưa có dữ liệu Trạng thái JOB! Vui lòng liên hệ Kỹ thuật viên!</a></label>";
            }
        }

        private void LoadFilter_Customers(DALTools dalTools)
        {
            List<eCustomer> all = dalTools.Customer_GetEs();
            if (all != null)
            {
                string html =
                    "<select id=\"filter-customers\" class=\"select-select2 select2-hidden-accessible\" style=\"width: 100%;\">" +
                        "<option value=\"-1\">Tất cả</option>";

                foreach (eCustomer obj in all)
                {
                    html += "<option value=\"" + obj.ID.ToString() + "\">" + obj.Name + "</option>";
                }

                html += "</select>";

                divFilterCustomers.InnerHtml = html;
            }
            else
            {
                divFilterCustomers.InnerHtml = "<label class='control-label label-quicklink'><a href='/khach-hang'>Chưa có dữ liệu Khách hàng! Nhấp chọn để chuyển sang trang Quản lý!</a></label>";
            }
        }

        private void LoadFilter_Types()
        {
            if (GlobalValues.JobTypes != null)
            {
                string html =
                    "<select id=\"filter-types\" class=\"form-control\" style=\"width: 100%;\">" +
                        "<option value=\"-1\">Tất cả</option>";

                foreach (Commons.eStatus obj in GlobalValues.JobTypes)
                {
                    html += "<option value=\"" + obj.ID.ToString() + "\">" + obj.Name + "</option>";
                }

                html += "</select>";

                divFilterTypes.InnerHtml = html;
            }
            else
            {
                divFilterTypes.InnerHtml = "<label class='control-label label-quicklink'><a href='#'>Chưa có dữ liệu Loại JOB! Vui lòng liên hệ Kỹ thuật viên!</a></label>";
            }
        }
    }
}