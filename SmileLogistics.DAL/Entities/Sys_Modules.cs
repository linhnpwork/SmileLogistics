using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SmileLogistics.DAL.Entities
{
    #region Defines

    public class eSys_Module
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Alias { get; set; }
        public string Path { get; set; }
        public string IconClass { get; set; }
        public int ParentID { get; set; }
        public int Level { get; set; }
        public string Description { get; set; }
        public string Actions { get; set; }


        public bool IsDeleted { get; set; }
        public string ParentName { get; set; }
        public List<eSys_Module> Children { get; set; }
    }

    public enum Sys_Module_Actions
    {
        Access = 0,
        Create = 1,
        Edit = 2,
        Delete = 3,
        SetPermission = 4,
        Block = 5,
        Unblock = 6,
        ViewHistories = 7,
    };

    public class eSys_ModuleAction
    {
        /// <summary>
        /// Tên Action
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// ID Action
        /// </summary>
        public int ID { get; set; }
    }

    #endregion
}
