using SmileLogistics.DAL.Entities;
using SmileLogistics.DAL.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SmileLogistics.Web.modules
{
    public partial class Default : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                LoadDashboard();
            }
        }

        private void LoadDashboard()
        {
            using (DALTools dalTools = new DALTools())
            {
                Load_MiniTopStats(dalTools);
            }
        }

        private void Load_MiniTopStats(DALTools dalTools)
        {
            Dashboard_MiniTopStats result = dalTools.Dashboard_MiniTopStats();

            if (result == null)
                divMiniTopStats.Visible = false;
            else
            {
                htmlDashboard_MiniTopStats_FinishedJobs.InnerHtml =  result.Total_FinishJobs.ToString();
                htmlDashboard_MiniTopStats_OpeningJobs.InnerHtml = result.Total_OpeningJobs.ToString();
                htmlDashboard_MiniTopStats_TotalCustomers.InnerHtml = result.Total_Customers.ToString();
                htmlDashboard_MiniTopStats_TotalJobs.InnerHtml = result.Total_Jobs.ToString();
            }
        }
    }
}