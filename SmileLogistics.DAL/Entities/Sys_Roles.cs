using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SmileLogistics.DAL.Entities
{
    public class eSys_Role
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public bool CanAccessSystemMenu { get; set; }

        public bool IsDelete { get; set; }
        public List<eSys_RolePermission> RolePermissions { get; set; }

        #region Const

        private static eSys_Role _GodRole = null;
        public static eSys_Role GodRole
        {
            get
            {
                return new eSys_Role()
                {
                    CanAccessSystemMenu = true,
                    Description = "God Administrators",
                    ID = 1,
                    IsDelete = false,
                    Name = "God Administrator",
                    RolePermissions = null
                };
            }
        }

        #endregion
    }

    public class eSys_RolePermission
    {
        public int ID { get; set; }
        public int RoleID { get; set; }
        public int ModuleID { get; set; }
        public string Permissions { get; set; }
    }
}
