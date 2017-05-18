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
    public partial class QuotationRoutes : BaseControl
    {
        public string _RolePermissions = string.Empty;
        public string _AllComps = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckPermissionAccess();
                _RolePermissions = GetPermissionsAsJSON();

                LoadTransportCompanies();
            }
        }

        private void LoadTransportCompanies()
        {
            using (DALTools dalTools = new DALTools())
            {
                List<eTransportCompany> all = dalTools.TransportCompany_GetEs();
                if (all != null)
                {
                    string html = "<select id=\"info-transcomp\" onchange=\"quotationroutes.loadlist_routes();\" class=\"select-select2 select2-hidden-accessible\" style=\"width: auto;\">";

                    foreach (eTransportCompany obj in all)
                    {
                        html += "<option value=\"" + obj.ID.ToString() + "\">" + obj.Name + "</option>";
                    }

                    html += "</select>";

                    divTransportCompanies.InnerHtml = html;

                    _AllComps = JsonConvert.SerializeObject(all);
                }
                else
                {
                    divTransportCompanies.InnerHtml = "<label class='control-label label-quicklink'><a href='/hang-van-chuyen'>Chưa có dữ liệu Hãng vận chuyển! Nhấp chọn chuyển sang trang Quản lý!</a></label>";
                }
            }
        }
    }
}