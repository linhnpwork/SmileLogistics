using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SmileLogistics.DAL;
using SmileLogistics.DAL.Entities;
using SmileLogistics.DAL.Helpers;
using Newtonsoft.Json;

namespace SmileLogistics.Web.bases
{
    public class BaseControl : System.Web.UI.UserControl
    {
        #region Properties

        private string CurrentSys_UserPermissions
        {
            get
            {
                return GetPermissionsAsJSON();
            }
        }

        /// <summary>
        /// Đối tượng eSys_User hiện tại
        /// </summary>
        public eSys_User CurrentSys_User
        {
            get
            {
                return ((BasePage)this.Page).CurrentSys_User;
            }
        }

        public eSys_Module CurrentSys_Module
        {
            get
            {
                return ((BasePage)this.Page).CurentSys_Module;
            }
        }

        #endregion

        #region Functions

        public void CheckPermissionAccess()
        {
            if (!HasPermission(Sys_Module_Actions.Access))
            {
                Response.Redirect(ResolveUrl(SiteValues.Page_403));
                return;
            }
        }

        public string GetPermissionsAsJSON()
        {
            try
            {

                List<eSys_ModuleAction> actions = GetPermissions();
                if (actions == null || actions.Count == 0) return string.Empty;

                return JsonConvert.SerializeObject(actions);
            }
            catch
            {
                return string.Empty;
            }
        }

        public List<eSys_ModuleAction> GetPermissions()
        {
            try
            {
                List<eSys_ModuleAction> sActions = ((IEnumerable<Sys_Module_Actions>)Enum.GetValues(typeof(Sys_Module_Actions))).Select(o => new eSys_ModuleAction() { ID = (int)o, Name = o.ToString() }).ToList();
                if (sActions == null || sActions.Count == 0) return null;

                if (CurrentSys_Module == null || CurrentSys_User == null) return null;
                if (CurrentSys_User.ID == eSys_User.GodUser.ID) return new List<eSys_ModuleAction>() { new eSys_ModuleAction() { ID = -1, Name = "all" } };

                using (DALTools dalTools = new DALTools())
                {
                    eSys_Role role = dalTools.Sys_Role_GetE(CurrentSys_User.RoleID);
                    if (role == null) return null;

                    eSys_RolePermission permission = role.RolePermissions == null ? null : role.RolePermissions.FirstOrDefault(o => o.ModuleID == CurrentSys_Module.ID);
                    if (permission == null) return null;

                    //string[] eSys_ModuleActions = CurrentSys_Module.Actions.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
                    //if (eSys_ModuleActions.Length == 0) return null;

                    List<eSys_ModuleAction> result = new List<eSys_ModuleAction>();

                    foreach (eSys_ModuleAction sAction in sActions)
                    {
                        if (permission.Permissions.IndexOf("@" + sAction.ID.ToString() + ";") >= 0)
                            result.Add(sAction);
                    }

                    if (result.Count == 0) return null;

                    return result;
                }
            }
            catch
            {
                return null;
            }
        }

        public bool HasPermission(Sys_Module_Actions action)
        {
            return ((BasePage)this.Page).HasPermission(action);
        }

        public bool HasPermission(eSys_Module eSys_Module, eSys_User admin, Sys_Module_Actions action)
        {
            return ((BasePage)this.Page).HasPermission(eSys_Module, admin, action);
        }

        #endregion
    }
}