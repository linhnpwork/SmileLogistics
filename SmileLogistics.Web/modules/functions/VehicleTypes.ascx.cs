﻿using System;
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
        public string _RolePermissions = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckPermissionAccess();
                _RolePermissions = GetPermissionsAsJSON();

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
                    string html = "<select id=\"info-goodstypes\" class=\"select-select2 select2-hidden-accessible\" style=\"width: auto;\">";

                    foreach (eGoodsType obj in all)
                    {
                        html += "<option value=\"" + obj.ID.ToString() + "\">" + obj.Name + " (" + obj.Code + ")" + "</option>";
                    }

                    html += "</select>";

                    divGoodsTypes.InnerHtml = html;
                }
                else
                {
                    divGoodsTypes.InnerHtml = "<label class='control-label label-quicklink'><a href='/loai-hang-hoa'>Chưa có dữ liệu Loại hàng hóa! Nhấp chọn chuyển sang trang Quản lý!</a></label>";
                }
            }
        }
    }
}