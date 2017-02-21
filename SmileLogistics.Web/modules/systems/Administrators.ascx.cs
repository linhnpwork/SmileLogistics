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

namespace SmileLogistics.Web.modules.systems
{
    public partial class Administrators : BaseControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadRoles();
                //LoadCountries();
                LoadStatus();
            }
        }

        private void LoadStatus()
        {
            string html = "<select id=\"info-statuses\" class=\"form-control\" style=\"width: auto;\">";

            for (int i = 0; i < GlobalValues.Sys_UserStatuses.Count; i++)
                html += "<option value = \"" + GlobalValues.Sys_UserStatuses[i].ID.ToString() + "\">" + GlobalValues.Sys_UserStatuses[i].Name + "</option>";

            html += "</select>";

            divStatuses.InnerHtml = html;
        }

        //private void LoadCountries()
        //{
        //    string html =
        //        "<select id=\"info-countries\" class=\"select-chosen form-control\" data-placeholder=\"Choose a Country..\" style=\"width: auto; display: none;\">" +
        //            "<option></option>";

        //    for (int i = 0; i < GlobalValues.Countries.Length; i++)
        //    {
        //        html += "<option value=\"" + i.ToString() + "\">" + GlobalValues.Countries[i] + "</option>";
        //    }

        //    html += "</select>";

        //    divCountries.InnerHtml = html;
        //}

        private void LoadRoles()
        {
            using (DALTools dalTools = new DALTools())
            {
                List<eSys_Role> all = dalTools.Sys_Role_GetEs();
                if (all != null)
                {
                    string html = "<select id=\"info-role\" class=\"form-control\" style=\"width: auto;\">";

                    foreach (eSys_Role obj in all)
                    {
                        html += "<option value=\"" + obj.ID.ToString() + "\">" + obj.Name + "</option>";
                    }

                    html += "</select>";

                    divRoles.InnerHtml = html;
                }
            }
        }
    }
}