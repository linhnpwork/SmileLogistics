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
    public partial class TransportCompanies : BaseControl
    {
        public string _VehicleTypes = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStatus();
                LoadVehicleTypes();
            }
        }

        private void LoadStatus()
        {
            string html = "<select id=\"info-statuses\" class=\"form-control\" style=\"width: auto;\">";

            for (int i = 0; i < GlobalValues.TransportCompanyStatuses.Count; i++)
                html += "<option value = \"" + GlobalValues.TransportCompanyStatuses[i].ID.ToString() + "\">" + GlobalValues.TransportCompanyStatuses[i].Name + "</option>";

            html += "</select>";

            divStatuses.InnerHtml = html;
        }

        private void LoadVehicleTypes()
        {
            _VehicleTypes = string.Empty;
            using (DALTools dalTools = new DALTools())
            {
                List<eVehicleType> all = dalTools.VehicleType_GetEs();
                if (all != null)
                    _VehicleTypes = JsonConvert.SerializeObject(all);
            }
        }
    }
}