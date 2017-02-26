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
using Newtonsoft.Json;

namespace SmileLogistics.Web.modules.functions
{
    public partial class JobDetail : BaseControl
    {
        private int jobID = int.MinValue;
        public string _JobDetail = string.Empty;
        public string _JobID = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTypes();
                LoadCustomers();

                LoadJobDetail();
            }
        }

        private void LoadJobDetail()
        {
            if (!string.IsNullOrEmpty(Request.QueryString["job"]))
            {
                try
                {
                    jobID = int.Parse(Request.QueryString["job"]);
                }
                catch
                {
                    jobID = int.MinValue;
                }

                using (DALTools dalTools = new DALTools())
                {
                    eJob obj = dalTools.Job_GetE(jobID);
                    _JobDetail = obj == null ? string.Empty : JsonConvert.SerializeObject(obj);
                    _JobID = obj != null ? obj.JobID : DateTime.Now.ToString("ddMMyyyy-HHmmss");
                }
            }
            else
            {
                _JobID = DateTime.Now.ToString("ddMMyyyy-HHmmss");
            }
        }

        private void LoadTypes()
        {
            List<Commons.eStatus> all = GlobalValues.JobTypes;
            if (all != null)
            {
                string html = "<select id=\"info-types\" class=\"form-control\" style=\"width: auto;\">";

                foreach (Commons.eStatus obj in all)
                {
                    html += "<option value=\"" + obj.ID.ToString() + "\">" + obj.Name + "</option>";
                }

                html += "</select>";

                divTypes.InnerHtml = html;
            }
            else
            {
                divTypes.InnerHtml = "<label class='control-label label-quicklink'><a href='#'>Chưa có dữ liệu Loại JOB! Vui lòng liên hệ với Kỹ thuật viên!</a></label>";
            }
        }

        private void LoadCustomers()
        {
            using (DALTools dalTools = new DALTools())
            {
                List<eCustomer> all = dalTools.Customer_GetEs();
                if (all != null)
                {
                    string html = "<select id=\"info-customers\" class=\"select-select2 select2-hidden-accessible\" style=\"width: auto;\">";

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