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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
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
                    string html = "<select id=\"info-vehicletypes\" class=\"form-control\" style=\"width: auto;\">";

                    foreach (eVehicleType obj in all)
                    {
                        html += "<option value=\"" + obj.ID.ToString() + "\">" + obj.Name + " (" + obj.Code + ")" + "</option>";
                    }

                    html += "</select>";

                    divVehicleTypes.InnerHtml = html;
                }
            }
        }
    }
}