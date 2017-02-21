using Decided.Libs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SmileLogistics.Web.bases;
using SmileLogistics.DAL;
using SmileLogistics.DAL.Entities;
using SmileLogistics.DAL.Helpers;

namespace SmileLogistics.Web.bases
{
    public class BasePage : System.Web.UI.Page
    {
        #region Properties

        private eSys_Module _CurrentSys_Module = null;
        public eSys_Module CurentSys_Module
        {
            get
            {
                if (_CurrentSys_Module != null) return _CurrentSys_Module;

                string eSys_Module = Page.RouteData.Values["mod"] as string;
                if (string.IsNullOrEmpty(eSys_Module))
                {
                    return new eSys_Module()
                    {
                        Actions = string.Empty,
                        Alias = string.Empty,
                        Description = "Dashboard",
                        IconClass = string.Empty,
                        ID = 0,
                        Level = 0,
                        ParentID = int.MinValue,
                        Path = string.Empty,
                        Name = "Dashboard",
                        Children = null,
                        IsDeleted = false,
                        ParentName = "ROOT"
                    };
                }

                eSys_Module = eSys_Module.ToLower();
                if (eSys_Module == "profile" ||
                    eSys_Module == "sysroles" ||
                    eSys_Module == "sysrole-permission" ||
                    eSys_Module == "sysadmins" ||
                    eSys_Module == "sysmodules")
                {
                    string[] sysmodinfo = GetSys_ModuleInfo(eSys_Module);
                    return new eSys_Module()
                    {
                        Actions = "@" + (int)Sys_Module_Actions.Access + ";",
                        Alias = eSys_Module,
                        Description = sysmodinfo == null ? string.Empty : sysmodinfo[1],
                        IconClass = sysmodinfo == null ? string.Empty : sysmodinfo[2],
                        ID = 0,
                        Level = 0,
                        ParentID = int.MinValue,
                        Path = eSys_Module,
                        Name = sysmodinfo == null ? string.Empty : sysmodinfo[0],
                        Children = null,
                        IsDeleted = false,
                        ParentName = "ROOT"
                    };
                }

                using (DALTools dalTools = new DALTools())
                    return dalTools.Sys_Module_GetE(eSys_Module);
            }
        }

        private string[] GetSys_ModuleInfo(string alias)
        {
            switch (alias.ToLower())
            {
                case "profile": return new string[] { "Trang cá nhân", "Tất cả thông tin cá nhân của bạn", "gi gi-user" };
                case "sysroles": return new string[] { "Nhóm quyền", "Quản lý tất cả Nhóm quyền hệ thống", "gi gi-group" };
                case "sysrole-permission": return new string[] { "Phân quyền", "Cho phép thiết lập phân quyền của Nhóm quyền", "gi gi-group" };
                case "sysadmins": return new string[] { "Người dùng", "Quản lý tất cả Người dùng hệ thống", "gi gi-user" };
                case "syseSys_Modules": return new string[] { "Chức năng", "Quản lý tất cả Chức năng hệ thống <i>(Khuyến cáo: chỉ sử dụng chức năng này khi có hỗ trợ của Kỹ thuật viên Hệ thống!)</i>", "fa fa-sitemap" };
                default: return null;
            }
        }

        /// <summary>
        /// Thực thể eSys_User hiện tại
        /// </summary>
        private eSys_User _CurrentSys_User = null;

        /// <summary>
        /// Đối tượng eSys_User hiện tại
        /// </summary>

        public eSys_User CurrentSys_User
        {
            get
            {
                if (_CurrentSys_User != null) return _CurrentSys_User;

                string cookieMembership = WebUtils.ReadCookieWithDecrypted(SiteValues.Cookie_AuthenticationName, Page.Request);
                if (string.IsNullOrEmpty(cookieMembership)) return null;

                //if (cookieMembership == "0")
                //{
                //    _CurrentSys_User = eSys_User.GodUser;
                //}
                //else
                //{
                using (DALTools dalTools = new DALTools())
                    _CurrentSys_User = dalTools.Sys_User_GetE(int.Parse(cookieMembership));
                //}

                return _CurrentSys_User;
            }
        }

        #endregion

        #region Functions

        public bool HasPermission(Sys_Module_Actions action)
        {
            return HasPermission(CurentSys_Module, CurrentSys_User, action);
        }

        public bool HasPermission(eSys_Module eSys_Module, eSys_User admin, Sys_Module_Actions action)
        {
            try
            {
                if (eSys_Module == null || admin == null) return false;

                if (eSys_Module.ID == 0) //System
                    return admin.CanAccessSystemMenu;

                //Nếu là God, luôn TRUE
                if (admin.ID == eSys_User.GodUser.ID) return true;

                string actionid = "@" + (int)action + ";";

                //Bản thân eSys_Module ko có action này
                if (eSys_Module.Actions.IndexOf(actionid) < 0) return false;

                eSys_RolePermission permission = admin.RolePermissions.FirstOrDefault(o => o.ModuleID == eSys_Module.ID);
                if (permission == null) return false;

                if (permission.Permissions.IndexOf(actionid) < 0) return false;

                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// Trả về Response dạng Text
        /// </summary>
        /// <param name="responseText">Text cần trả về</param>
        public void DoResponse(string responseText)
        {
            Response.ContentType = "text/plain";
            Response.Expires = -1;
            Response.Write(responseText);
            Response.End();
        }

        #endregion
    }
}