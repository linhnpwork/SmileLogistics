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
    public partial class VehicleTypes : BaseControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadGoodsTypes();
            }
        }

        private void LoadGoodsTypes()
        {
            using (DALTools dalTools = new DALTools())
            {
                List<eGoodsType> all = dalTools.GoodsType_GetEs();
                if (all != null)
                {
                    string html = "<select id=\"info-goodstypes\" class=\"form-control\" style=\"width: auto;\">";

                    foreach (eGoodsType obj in all)
                    {
                        html += "<option value=\"" + obj.ID.ToString() + "\">" + obj.Name + " (" + obj.Code + ")" + "</option>";
                    }

                    html += "</select>";

                    divGoodsTypes.InnerHtml = html;
                }
            }
        }
    }
}