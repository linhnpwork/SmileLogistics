using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SmileLogistics.DAL.Entities
{
    public class eSys_User
    {
        public int ID { get; set; }
        public string Firstname { get; set; }
        public string Lastname { get; set; }
        public string Email { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public DateTime DateOfBirth { get; set; }
        public string Avatar { get; set; }
        public string Address { get; set; }
        public string PhoneNumber { get; set; }
        public int Status { get; set; }
        public int RoleID { get; set; }

        public bool IsDeleted { get; set; }
        public string RoleName { get; set; }
        public string StatusName { get; set; }
        public bool CanAccessSystemMenu { get; set; }
        public List<eSys_RolePermission> RolePermissions { get; set; }
        public string sDateOfBirth { get; set; }

        #region Const

        private static eSys_User _GodUser = null;
        public static eSys_User GodUser
        {
            get
            {
                return new eSys_User()
                {
                    Address = string.Empty,
                    Avatar = string.Empty,
                    ID = 1,
                    DateOfBirth = DateTime.Now,
                    Email = "Administrator@sl.com",
                    Firstname = "God",
                    Lastname = "Administrator",
                    PhoneNumber = "093.5757.345",
                    RoleID = eSys_Role.GodRole.ID,
                    CanAccessSystemMenu = true,
                    Status = 1,
                    Username = "GodAdministrator",
                    Password = "1234qwerASDF!@#$",
                    IsDeleted = false,
                    RoleName = eSys_Role.GodRole.Name,
                    StatusName = "Active"
                };
            }
        }

        #endregion
    }
}
