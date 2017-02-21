using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SmileLogistics.DAL;
using SmileLogistics.DAL.Entities;

namespace SmileLogistics.Web.bases
{
    public class BaseControl : System.Web.UI.UserControl
    {
        #region Properties

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