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
    public partial class QuotationCustoms : BaseControl
    {
        public string _FeeTypes = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadFeeTypes();
            }
        }

        private void LoadFeeTypes()
        {
            _FeeTypes = string.Empty;
            using (DALTools dalTools = new DALTools())
            {
                List<eCustomsProcess_FeeType> all = dalTools.CustomsProcess_FeeType_GetEs(true);
                if (all != null)
                    _FeeTypes = JsonConvert.SerializeObject(all);
            }
        }
    }
}