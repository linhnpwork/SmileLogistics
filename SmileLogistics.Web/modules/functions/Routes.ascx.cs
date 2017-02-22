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
    public partial class Routes : BaseControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTransportCompanies();
                LoadTransportPlaces();
            }
        }

        private void LoadTransportPlaces()
        {
            using (DALTools dalTools = new DALTools())
            {
                List<eTransportPlace> all = dalTools.TransportPlace_GetEs();
                if (all != null)
                {
                    string html1 = "<select id=\"info-transplace-1\" class=\"select-select2 select2-hidden-accessible\" style=\"width: auto;\">";
                    string html2 = "<select id=\"info-transplace-2\" class=\"select-select2 select2-hidden-accessible\" style=\"width: auto;\">";

                    foreach (eTransportPlace obj in all)
                    {
                        html1 += "<option value=\"" + obj.ID.ToString() + "\">" + obj.Name + "</option>";
                        html2 += "<option value=\"" + obj.ID.ToString() + "\">" + obj.Name + "</option>";
                    }

                    html1 += "</select>";
                    html2 += "</select>";

                    divTransportPlaces1.InnerHtml = html1;
                    divTransportPlaces2.InnerHtml = html2;
                }
                else
                {
                    string alerMess = "<label class='control-label label-quicklink'><a href='/dia-diem-van-chuyen'>Chưa có dữ liệu Địa điểm vận chuyển! Nhấp chọn chuyển sang trang Quản lý!</a></label>";
                    divTransportPlaces1.InnerHtml = alerMess;
                    divTransportPlaces2.InnerHtml = alerMess;
                }
            }
        }

        private void LoadTransportCompanies()
        {
            using (DALTools dalTools = new DALTools())
            {
                List<eTransportCompany> all = dalTools.TransportCompany_GetEs();
                if (all != null)
                {
                    string html = "<select id=\"info-transcomp\" class=\"select-select2 select2-hidden-accessible\" style=\"width: auto;\">";

                    foreach (eTransportCompany obj in all)
                    {
                        html += "<option value=\"" + obj.ID.ToString() + "\">" + obj.Name + "</option>";
                    }

                    html += "</select>";

                    divTransportCompanies.InnerHtml = html;
                }
                else
                {
                    divTransportCompanies.InnerHtml = "<label class='control-label label-quicklink'><a href='/hang-van-chuyen'>Chưa có dữ liệu Hãng vận chuyển! Nhấp chọn chuyển sang trang quản lý!</a></label>";
                }
            }
        }
    }
}