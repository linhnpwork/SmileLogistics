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

namespace SmileLogistics.Web.modules.global
{
    public partial class SideBarLeft : BaseControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                eSys_User currentAdmin = CurrentSys_User;
                if (currentAdmin != null)
                {
                    if (string.IsNullOrEmpty(currentAdmin.Avatar))
                        imgAvatar.Src = ResolveUrl(SiteValues.LogoPath);
                    else
                        imgAvatar.Src = ResolveUrl(currentAdmin.Avatar);

                    divFullname.InnerHtml = currentAdmin.Firstname + ", " + currentAdmin.Lastname;
                }

                LoadMenus();
            }
        }

        private void LoadMenus()
        {
            string htmlMenus = string.Empty;

            string eSys_Module = Page.RouteData.Values["mod"] as string;
            bool isDashboard = string.IsNullOrEmpty(eSys_Module) || eSys_Module == "home";

            htmlMenus +=
                    "<li>" +
                        "<a href = \"/\" " + (isDashboard ? "class=\"active\"" : "") + " ><i class=\"gi gi-stopwatch sidebar-nav-icon\" ></i>Dashboard</a>" +
                    "</li>";

            #region eSys_Modules

            bool hasActive = false;
            string htmlFunctions = RenderFunctionsMenus(int.MinValue, out hasActive);
            if (!string.IsNullOrEmpty(htmlFunctions))
            {
                htmlMenus +=
                    "<li class=\"sidebar-header\">" +
                        "<span class=\"sidebar-header-title\">Chức năng</span>" +
                    "</li>" +
                    htmlFunctions;
            }

            #endregion

            #region System menus

            if (CurrentSys_User.CanAccessSystemMenu) //Kiểm tra quyền SystemMenus
            {
                htmlMenus +=
                    //"<li>" +
                    //    "<a href = \"/\" " + (isDashboard ? "class=\"active\"" : "") + " ><i class=\"gi gi-stopwatch sidebar-nav-icon\" ></i>Dashboard</a>" +
                    //"</li>" +
                    "<li class=\"sidebar-header\">" +
                        "<span class=\"sidebar-header-title\">Hệ thống</span>" +
                    "</li>" +
                    "<li>" +
                        "<a " + (eSys_Module == "sysroles" || eSys_Module == "sysrole-permission" ? "class=\"active\"" : "") + " href = \"/sysroles\" ><i class=\"gi gi-group sidebar-nav-icon\" ></i>Nhóm quyền</a>" +
                    "</li>" +
                    "<li>" +
                        "<a " + (eSys_Module == "sysadmins" ? "class=\"active\"" : "") + " href = \"/sysadmins\" ><i class=\"gi gi-user sidebar-nav-icon\" ></i>Người dùng</a>" +
                    "</li>" +
                    "<li>" +
                        "<a " + (eSys_Module == "sysmodules" ? "class=\"active\"" : "") + " href = \"/sysmodules\" ><i class=\"fa fa-sitemap sidebar-nav-icon\"></i>Chức năng</a>" +
                    "</li>";
            }

            #endregion

            ulMenu.InnerHtml = htmlMenus;
        }

        private string RenderFunctionsMenus(int parentId, out bool hasActive)
        {
            hasActive = false;
            try
            {
                using (DALTools dalTools = new DALTools())
                {
                    string html = string.Empty;

                    List<eSys_Module> root = dalTools.Sys_Module_GetEs(parentId, false);
                    if (root == null || root.Count == 0) return string.Empty;

                    foreach (eSys_Module obj in root)
                    {
                        if (!HasPermission(obj, CurrentSys_User, Sys_Module_Actions.Access))
                            continue;

                        string htmlChildren = string.Empty;
                        bool hasChildren = dalTools.Sys_Module_HasChildren(obj.ID);
                        if (hasChildren)
                            htmlChildren += "<ul>" + RenderFunctionsMenus(obj.ID, out hasActive) + "</ul>";

                        html += "<li class=\"" + (hasChildren && hasActive ? "active" : string.Empty) + "\">" +
                            "<a href=\"" + (obj.Path == "#" ? "#" : ("/" + obj.Alias)) + "\" class=\"" + (!hasChildren ? string.Empty : "sidebar-nav-" + (obj.Level == 0 ? "menu" : "submenu")) + " " + (obj.Alias.ToLower() == CurrentSys_Module.Alias.ToLower() ? "active" : string.Empty) + "\">" +
                                (!hasChildren ? string.Empty : "<i class=\"fa fa-angle-left sidebar-nav-indicator\"></i>") +
                                "<i class=\"" + obj.IconClass + " sidebar-nav-icon\"></i>" +
                                obj.Name +
                            "</a>";

                        html += htmlChildren;

                        html += "</li>";

                        if (obj.Alias.ToLower() == CurrentSys_Module.Alias.ToLower())
                            hasActive = true;
                    }

                    return html;
                }
            }
            catch
            {
                return string.Empty;
            }
        }
    }
}