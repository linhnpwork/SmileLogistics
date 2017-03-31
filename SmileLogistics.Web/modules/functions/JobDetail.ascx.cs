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
        private string jobID = string.Empty;
        private eJob job = null;
        public string _JobDetail = string.Empty;
        public string _JobID = string.Empty;
        public string _AllCompanies = string.Empty;
        public string _AllCustomsFeeTypes = string.Empty;
        public string _AllCustomerQuotation_Smiles = string.Empty;
        public string _AllEmployees = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                using (DALTools dalTools = new DALTools())
                {
                    jobID = Request.QueryString["job"];
                    job = string.IsNullOrEmpty(jobID) ? null : dalTools.Job_GetE(int.Parse(jobID));

                    LoadTypes();
                    LoadCustomers(dalTools);

                    LoadRoutePlaces(dalTools);
                    LoadTransportCompanies(dalTools);

                    LoadCustomsFeeTypes(dalTools);

                    LoadEmployees(dalTools);

                    LoadJobWorkings(dalTools);

                    LoadJobDetail(dalTools);
                }
            }
        }

        private void LoadJobWorkings(DALTools dalTools)
        {
            List<eJob_Working> all = dalTools.Job_Working_GetEs();
            if (all != null)
            {
                string html = string.Empty;

                foreach (eJob_Working obj in all)
                {
                    html +=
                        "<div class=\"checkbox\">" +
                            "<label for=\"cbxAgentPrepaid_JobWorking_" + obj.ID.ToString() + "\">" +
                                "<input class=\"checked-agentprepaid-jobworking\" dat-id=\"" + obj.ID.ToString() + "\" type=\"checkbox\" id=\"cbxAgentPrepaid_JobWorking_" + obj.ID.ToString() + "\" name=\"cbxAgentPrepaid_JobWorking_" + obj.ID.ToString() + "\" value=\"" + obj.ID.ToString() + "\">" +
                                obj.Name +
                            "</label>" +
                        "</div>";
                }

                divAgentPrepaidsJobWorkings.InnerHtml = html;
            }
            else
            {
                divAgentPrepaidsJobWorkings.InnerHtml = "<label class='control-label label-quicklink'><a href='/muc-chi-lam-hang'>Chưa có dữ liệu Mục chi làm hàng! Nhấp chọn chuyển sang trang Quản lý!</a></label>";
            }
        }

        private void LoadEmployees(DALTools dalTools)
        {
            List<eSys_User> all = dalTools.Sys_User_GetEs();
            if (all != null)
            {
                string html = "<select id=\"info-prepaid-employee\" class=\"form-control\" style=\"width: auto;\">";

                foreach (eSys_User obj in all)
                {
                    html += "<option value=\"" + obj.ID.ToString() + "\">" + obj.Firstname + ", " + obj.Lastname + "</option>";
                }

                html += "</select>";

                divAgentPrepaidEmployees.InnerHtml = html;
            }
            else
            {
                divAgentPrepaidEmployees.InnerHtml = "<label class='control-label label-quicklink'><a href='/sysadmins'>Chưa có dữ liệu Nhân viên! Nhấp chọn chuyển sang trang Quản lý!</a></label>";
            }
        }

        private void LoadCustomsFeeTypes(DALTools dalTools)
        {
            if (job == null) return;

            List<eCustomsProcess_FeeType> allCustomsFeeTypes = dalTools.CustomsProcess_FeeType_GetEs();
            _AllCustomsFeeTypes = allCustomsFeeTypes == null ? string.Empty : JsonConvert.SerializeObject(allCustomsFeeTypes);

            List<eCustomsProcess_Quotation> allCustomerQuotation_Smiles = dalTools.CustomsProcess_Quotation_GetEs();
            _AllCustomerQuotation_Smiles = allCustomerQuotation_Smiles == null ? string.Empty : JsonConvert.SerializeObject(allCustomerQuotation_Smiles);
        }

        private void LoadTransportCompanies(DALTools dalTools)
        {
            List<eTransportCompany> all = dalTools.TransportCompany_GetEs();
            _AllCompanies = all == null ? string.Empty : JsonConvert.SerializeObject(all);
        }

        private void LoadRoutePlaces(DALTools dalTools)
        {
            List<eTransportPlace> all = dalTools.TransportPlace_GetEs();
            if (all != null)
            {
                string htmlStart = "<select id=\"info-quotation-route-place-start\" onchange=\"jobs.load_quotations();\" class=\"form-control\" style=\"width: 100%;\">";
                string htmlEnd = "<select id=\"info-quotation-route-place-end\" onchange=\"jobs.load_quotations();\" class=\"form-control\" style=\"width: 100%;\">";

                foreach (eTransportPlace obj in all)
                {
                    htmlStart += "<option value=\"" + obj.ID.ToString() + "\">" + obj.Name + "</option>";
                    htmlEnd += "<option value=\"" + obj.ID.ToString() + "\">" + obj.Name + "</option>";
                }

                htmlStart += "</select>";
                htmlEnd += "</select>";

                divQuotationRoute_Place_Start.InnerHtml = htmlStart;
                divQuotationRoute_Place_End.InnerHtml = htmlEnd;
            }
            else
            {
                divQuotationRoute_Place_Start.InnerHtml = "<label class='control-label label-quicklink'><a href='/dia-diem-van-chuyen'>Chưa có dữ liệu Địa điểm vận chuyển! Nhấp chọn chuyển sang trang Quản lý!</a></label>";
                divQuotationRoute_Place_End.InnerHtml = "<label class='control-label label-quicklink'><a href='/dia-diem-van-chuyen'>Chưa có dữ liệu Địa điểm vận chuyển! Nhấp chọn chuyển sang trang Quản lý!</a></label>";
            }
        }

        private void LoadJobDetail(DALTools dalTools)
        {
            if (!string.IsNullOrEmpty(jobID))
            {
                eJob obj = dalTools.Job_GetE(int.Parse(jobID));
                _JobDetail = obj == null ? string.Empty : JsonConvert.SerializeObject(obj);
                _JobID = obj != null ? obj.JobID : DateTime.Now.ToString("ddMMyyyy-HHmmss");
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

        private void LoadCustomers(DALTools dalTools)
        {
            List<eCustomer> all = dalTools.Customer_GetEs();
            if (all != null)
            {
                string html = "<select id=\"info-customers\" class=\"form-control\" style=\"width: auto;\">";

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