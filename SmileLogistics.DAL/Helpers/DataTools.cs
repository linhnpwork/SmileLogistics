using Decided.Libs;
using SmileLogistics.DAL.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SmileLogistics.DAL.Helpers
{
    public class DALTools : IDisposable
    {
        #region Base

        /// <summary>
        /// Context của Database
        /// </summary>
        public DBDataContext DB = null;

        /// <summary>
        /// Hàm Dispose class
        /// </summary>
        public void Dispose()
        {
            if (DB != null)
                DB.Dispose();
        }

        /// <summary>
        /// Constructor mặc định
        /// </summary>
        public DALTools()
        {
            DB = new DBDataContext();
        }

        #endregion

        #region Sys_Modules

        public bool Sys_Module_Delete(int id)
        {
            try
            {
                Sys_Module obj = DB.Sys_Modules.FirstOrDefault(o => o.ID == id);
                if (obj == null) return false;

                List<Sys_Module> children = Sys_Module_Gets(obj.ID);
                if (children != null)
                {
                    foreach (Sys_Module child in children)
                        Sys_Module_Delete(child.ID);
                }

                obj.IsDeleted = true;
                DB.SubmitChanges();

                return true;
            }
            catch
            {
                return false;
            }
        }

        public int Sys_Module_CheckAlias(string alias)
        {
            try
            {
                Sys_Module obj = DB.Sys_Modules.FirstOrDefault(o => !o.IsDeleted && o.Alias.ToLower() == alias.ToLower());
                if (obj == null) return 0;

                return obj.ID;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public bool Sys_Module_HasChildren(int id)
        {
            try
            {
                if (DB.Sys_Modules.Count(o => !o.IsDeleted && o.ParentID == id) > 0) return true;

                return false;
            }
            catch
            {
                return false;
            }
        }

        public int Sys_Module_Create(Sys_Module obj)
        {
            try
            {
                Sys_Module checkObj = DB.Sys_Modules.FirstOrDefault(o => !o.IsDeleted && o.Alias.ToLower() == obj.Alias.ToLower());
                if (checkObj != null) return 1;

                byte level = 0;
                if (obj.ParentID != int.MinValue)
                {
                    checkObj = DB.Sys_Modules.FirstOrDefault(o => !o.IsDeleted && o.ID == obj.ParentID);
                    while (checkObj != null)
                    {
                        level++;
                        checkObj = DB.Sys_Modules.FirstOrDefault(o => !o.IsDeleted && o.ID == checkObj.ParentID);
                    }

                    if (level == 0) return 2;
                }

                obj.Level = level;

                DB.Sys_Modules.InsertOnSubmit(obj);
                DB.SubmitChanges();

                return 0;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public bool Sys_Module_IsChildOf(int id, int parentId)
        {
            try
            {
                Sys_Module obj = DB.Sys_Modules.FirstOrDefault(o => o.ID == parentId);
                while (obj.ParentID != int.MinValue)
                {
                    if (obj.ParentID == id) return true;
                    obj = DB.Sys_Modules.FirstOrDefault(o => o.ID == obj.ParentID);
                }

                return false;
            }
            catch
            {
                return false;
            }
        }

        public int Sys_Module_Update(Sys_Module obj)
        {
            try
            {
                Sys_Module updateObj = DB.Sys_Modules.FirstOrDefault(o => o.ID == obj.ID);
                if (updateObj == null) return 3;

                Sys_Module checkObj = DB.Sys_Modules.FirstOrDefault(o => !o.IsDeleted && o.Alias.ToLower() == obj.Alias.ToLower());
                if (checkObj != null && checkObj.ID != updateObj.ID) return 1;

                bool changeParent = updateObj.ParentID != obj.ParentID;

                #region Kiểm tra việc move xuống con của nó

                if (changeParent)
                    if (Sys_Module_IsChildOf(obj.ID, obj.ParentID)) return 4;

                #endregion

                byte level = 0;
                if (obj.ParentID != int.MinValue)
                {
                    checkObj = DB.Sys_Modules.FirstOrDefault(o => o.ID == obj.ParentID);
                    while (checkObj != null)
                    {
                        level++;
                        checkObj = DB.Sys_Modules.FirstOrDefault(o => o.ID == checkObj.ParentID);
                    }

                    if (level == 0) return 2;
                }

                updateObj.Level = level;
                updateObj.Actions = obj.Actions;
                updateObj.Alias = obj.Alias;
                updateObj.Description = obj.Description;
                updateObj.IconClass = obj.IconClass;
                updateObj.ParentID = obj.ParentID;
                updateObj.Path = obj.Path;
                updateObj.Name = obj.Name;
                updateObj.ShowInMenu = obj.ShowInMenu;

                DB.SubmitChanges();

                if (changeParent)
                    Sys_Module_ReUpdateChildrenLevel(obj.ID);

                return 0;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public bool Sys_Module_UpdateLevel(int id, int level)
        {
            try
            {
                Sys_Module obj = DB.Sys_Modules.FirstOrDefault(o => o.ID == id);
                if (obj == null) return false;

                obj.Level = level;
                DB.SubmitChanges();

                return true;
            }
            catch
            {
                return false;
            }
        }

        public bool Sys_Module_ReUpdateChildrenLevel(int id)
        {
            try
            {
                Sys_Module obj = DB.Sys_Modules.FirstOrDefault(o => o.ID == id);
                if (obj == null) return false;

                var all = DB.Sys_Modules.Where(o => o.ParentID == id);
                if (all.Count() != 0)
                {
                    foreach (Sys_Module child in all)
                    {
                        Sys_Module_UpdateLevel(child.ID, obj.Level + 1);

                        if (Sys_Module_HasChildren(child.ID))
                            Sys_Module_ReUpdateChildrenLevel(child.ID);
                    }
                }

                return true;
            }
            catch
            {
                return false;
            }
        }

        public List<Sys_Module> Sys_Module_Gets(int parentId, bool showAll = true)
        {
            try
            {
                var all = !showAll ?
                    DB.Sys_Modules.Where(o => !o.IsDeleted && o.ParentID == parentId && o.ShowInMenu) :
                    DB.Sys_Modules.Where(o => !o.IsDeleted && o.ParentID == parentId);
                if (all.Count() == 0) return null;

                return all.OrderBy(o => o.Name).ToList();
            }
            catch
            {
                return null;
            }
        }

        public List<eSys_Module> Sys_Module_GetEs(int parentId, bool showAll = true)
        {
            try
            {
                var all = Sys_Module_Gets(parentId, showAll);
                if (all == null) return null;

                List<eSys_Module> result = new List<eSys_Module>();
                foreach (Sys_Module obj in all)
                    result.Add(Sys_Module_Entity(obj));

                return result.OrderBy(o => o.Name).ToList();
            }
            catch
            {
                return null;
            }
        }

        public List<Sys_Module> Sys_Module_BuildTreeAll(int parentId, bool showAll = true)
        {
            try
            {
                List<Sys_Module> roots = Sys_Module_Gets(parentId, showAll);
                if (roots == null) return null;

                List<Sys_Module> treeAll = new List<Sys_Module>();

                foreach (Sys_Module root in roots)
                {
                    treeAll.Add(root);
                    List<Sys_Module> treeChildren = Sys_Module_BuildTreeAll(root.ID);
                    if (treeChildren != null && treeChildren.Count != 0)
                        treeAll.AddRange(treeChildren);
                }

                if (treeAll.Count > 0) return treeAll;

                return null;
            }
            catch
            {
                return null;
            }
        }

        public List<eSys_Module> Sys_Module_BuildTreeAllE(int parentId, bool showAll = true)
        {
            try
            {
                List<Sys_Module> all = Sys_Module_BuildTreeAll(parentId, showAll);
                if (all == null) return null;

                List<eSys_Module> result = new List<eSys_Module>();

                foreach (Sys_Module obj in all)
                    result.Add(Sys_Module_Entity(obj));

                return result;
            }
            catch
            {
                return null;
            }
        }

        public Sys_Module Sys_Module_Get(string alias)
        {
            try
            {
                return DB.Sys_Modules.FirstOrDefault(o => !o.IsDeleted && o.Alias.ToLower() == alias.ToLower());
            }
            catch
            {
                return null;
            }
        }

        public eSys_Module Sys_Module_GetE(string alias)
        {
            try
            {
                return Sys_Module_Entity(Sys_Module_Get(alias));
            }
            catch
            {
                return null;
            }
        }

        public Sys_Module Sys_Module_Get(int id)
        {
            try
            {
                return DB.Sys_Modules.FirstOrDefault(o => o.ID == id);
            }
            catch
            {
                return null;
            }
        }

        public eSys_Module Sys_Module_Entity(Sys_Module obj)
        {
            try
            {
                if (obj == null) return null;
                Sys_Module parent = obj.ParentID == int.MinValue ? null : Sys_Module_Get(obj.ParentID);
                List<Sys_Module> allChildren = Sys_Module_Gets(obj.ID);
                List<eSys_Module> children = null;
                if (allChildren != null)
                {
                    children = new List<eSys_Module>();
                    foreach (Sys_Module child in allChildren)
                    {
                        children.Add(Sys_Module_Entity(child));
                    }
                }

                return new eSys_Module()
                {
                    Actions = obj.Actions,
                    Alias = obj.Alias,
                    Description = obj.Description,
                    IconClass = obj.IconClass,
                    ID = obj.ID,
                    Level = obj.Level,
                    Name = obj.Name,
                    ParentID = obj.ParentID,
                    Path = obj.Path,
                    //Other
                    IsDeleted = obj.IsDeleted,
                    ParentName = parent == null ? "ROOT" : parent.Name,
                    Children = children,
                    ShowInMenu = obj.ShowInMenu,
                };
            }
            catch
            {
                return null;
            }
        }

        #endregion

        #region Sys_Roles

        public bool Sys_Role_SetPermission(int roleId, int moduleId, string permissions)
        {
            try
            {
                Sys_Role Sys_Role = DB.Sys_Roles.FirstOrDefault(o => o.ID == roleId);
                Sys_Module Sys_Module = DB.Sys_Modules.FirstOrDefault(o => o.ID == moduleId);
                if (Sys_Role == null || Sys_Module == null) return false;

                Sys_Permission obj = DB.Sys_Permissions.FirstOrDefault(o => o.RoleID == roleId && o.ModuleID == moduleId);
                if (obj == null) //Insert
                {
                    obj = new Sys_Permission()
                    {
                        ModuleID = moduleId,
                        RoleID = roleId,
                        Permissions = permissions,
                    };

                    DB.Sys_Permissions.InsertOnSubmit(obj);
                }
                else
                {
                    obj.Permissions = permissions;
                }

                DB.SubmitChanges();

                return true;
            }
            catch
            {
                return false;
            }
        }

        public bool Sys_Role_Delete(int id)
        {
            try
            {
                Sys_Role obj = DB.Sys_Roles.FirstOrDefault(o => o.ID == id);
                if (obj == null) return false;

                obj.IsDeleted = true;
                DB.SubmitChanges();

                return true;
            }
            catch
            {
                return false;
            }
        }

        public int Sys_Role_Update(Sys_Role obj)
        {
            try
            {
                Sys_Role updateObj = DB.Sys_Roles.FirstOrDefault(o => o.ID == obj.ID);
                if (updateObj == null) return 3;

                Sys_Role checkObj = DB.Sys_Roles.FirstOrDefault(o => !o.IsDeleted && o.Name.ToLower() == obj.Name.ToLower());
                if (checkObj != null && checkObj.ID != updateObj.ID) return 1;

                updateObj.Description = obj.Description;
                updateObj.CanAccessSystemMenu = obj.CanAccessSystemMenu;
                updateObj.Name = obj.Name;

                DB.SubmitChanges();

                return 0;
            }
            catch (Exception ex)
            {
                return int.MinValue;
            }
        }

        public int Sys_Role_Create(Sys_Role obj)
        {
            try
            {
                Sys_Role checkObj = DB.Sys_Roles.FirstOrDefault(o => !o.IsDeleted && o.Name.ToLower() == obj.Name.ToLower());
                if (checkObj != null) return 1;

                DB.Sys_Roles.InsertOnSubmit(obj);
                DB.SubmitChanges();

                return 0;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public int Sys_Role_CheckName(string name)
        {
            try
            {
                Sys_Role obj = DB.Sys_Roles.FirstOrDefault(o => !o.IsDeleted && o.Name.ToLower() == name.ToLower());
                if (obj == null) return 0;

                return obj.ID;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public Sys_Role Sys_Role_Get(int id)
        {
            try
            {
                return DB.Sys_Roles.FirstOrDefault(o => o.ID == id);
            }
            catch
            {
                return null;
            }
        }

        public List<Sys_Role> Sys_Role_Gets(int pageIndex, int pageSize, out int totalPages)
        {
            totalPages = 0;
            try
            {
                var all = DB.Sys_Roles.Where(o => !o.IsDeleted && o.ID > 1);
                if (all.Count() == 0) return null;

                int startIndex = pageIndex * pageSize;
                List<Sys_Role> res = all.OrderBy(o => o.Name).Skip(startIndex).Take(pageSize).ToList();

                if (res.Count == 0) return null;

                int div = all.Count() / pageSize;
                int mod = all.Count() % pageSize;
                totalPages = div + (mod > 0 ? 1 : 0);

                return res;
            }
            catch
            {
                return null;
            }
        }

        public List<eSys_Role> Sys_Role_GetEs(int pageIndex, int pageSize, out int totalPages)
        {
            totalPages = 0;
            try
            {
                var all = Sys_Role_Gets(pageIndex, pageSize, out totalPages);
                if (all == null) return null;

                List<eSys_Role> result = new List<eSys_Role>();
                foreach (Sys_Role obj in all)
                    result.Add(Sys_Role_Entity(obj));

                return result;
            }
            catch
            {
                return null;
            }
        }

        public List<Sys_Role> Sys_Role_Gets()
        {
            try
            {
                var all = DB.Sys_Roles.Where(o => !o.IsDeleted && o.ID > 1);
                if (all.Count() == 0) return null;

                return all.OrderBy(o => o.Name).ToList();
            }
            catch
            {
                return null;
            }
        }

        public List<eSys_Role> Sys_Role_GetEs()
        {
            try
            {
                List<Sys_Role> all = Sys_Role_Gets();
                if (all == null) return null;

                List<eSys_Role> result = new List<eSys_Role>();
                foreach (Sys_Role obj in all)
                    result.Add(Sys_Role_Entity(obj));

                return result.OrderBy(o => o.Name).ToList();
            }
            catch
            {
                return null;
            }
        }

        public eSys_Role Sys_Role_Entity(Sys_Role obj)
        {
            try
            {
                if (obj == null) return null;
                List<eSys_RolePermission> permissions = null;
                if (obj.Sys_Permissions.Count > 0)
                {
                    permissions = new List<eSys_RolePermission>();
                    foreach (Sys_Permission permission in obj.Sys_Permissions)
                        permissions.Add(Sys_Permission_Entity(permission));
                }

                return new eSys_Role()
                {
                    CanAccessSystemMenu = obj.CanAccessSystemMenu,
                    Description = obj.Description,
                    ID = obj.ID,
                    IsDelete = obj.IsDeleted,
                    Name = obj.Name,
                    RolePermissions = permissions,
                };
            }
            catch
            {
                return null;
            }
        }

        public eSys_Role Sys_Role_GetE(int id)
        {
            try
            {
                return Sys_Role_Entity(Sys_Role_Get(id));
            }
            catch
            {
                return null;
            }
        }

        public void CheckGodRoleExists()
        {
            try
            {
                var obj = DB.Sys_Roles.FirstOrDefault(o => o.ID == eSys_Role.GodRole.ID);
                if (obj == null)
                {
                    Sys_Role_Create(new Sys_Role()
                    {
                        CanAccessSystemMenu = eSys_Role.GodRole.CanAccessSystemMenu,
                        Description = eSys_Role.GodRole.Description,
                        ID = eSys_Role.GodRole.ID,
                        IsDeleted = eSys_Role.GodRole.IsDelete,
                        Name = eSys_Role.GodRole.Name,
                    });
                }
            }
            catch
            {
                return;
            }
        }

        #endregion

        #region Sys_Users

        public bool Sys_User_Delete(int id)
        {
            try
            {
                Sys_User obj = DB.Sys_Users.FirstOrDefault(o => o.ID == id);
                if (obj == null) return false;

                obj.IsDeleted = true;
                DB.SubmitChanges();

                return true;
            }
            catch
            {
                return false;
            }
        }

        public int Sys_User_Update(Sys_User obj)
        {
            try
            {
                Sys_User updateObj = DB.Sys_Users.FirstOrDefault(o => o.ID == obj.ID);
                if (updateObj == null) return 3;

                Sys_User checkObj = DB.Sys_Users.FirstOrDefault(o => !o.IsDeleted && o.Email.ToLower() == obj.Email.ToLower());
                if (checkObj != null && checkObj.ID != updateObj.ID) return 1;

                updateObj.Address = obj.Address;
                if (!string.IsNullOrEmpty(obj.Avatar))
                    updateObj.Avatar = obj.Avatar;
                updateObj.DateOfBirth = obj.DateOfBirth;
                updateObj.Email = obj.Email;
                updateObj.Firstname = obj.Firstname;
                updateObj.Lastname = obj.Lastname;
                if (!string.IsNullOrEmpty(obj.Password))
                    updateObj.Password = obj.Password;
                updateObj.PhoneNumber = obj.PhoneNumber;
                updateObj.RoleID = obj.RoleID;
                updateObj.Status = obj.Status;
                updateObj.Username = obj.Username;

                DB.SubmitChanges();

                return 0;
            }
            catch (Exception ex)
            {
                return int.MinValue;
            }
        }

        public int Sys_User_Create(Sys_User obj)
        {
            try
            {
                Sys_User checkObj = DB.Sys_Users.FirstOrDefault(o => !o.IsDeleted && o.Email.ToLower() == obj.Email.ToLower());
                if (checkObj != null) return 1;

                DB.Sys_Users.InsertOnSubmit(obj);
                DB.SubmitChanges();

                return 0;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public int Sys_User_CheckEmail(string email)
        {
            try
            {
                Sys_User obj = DB.Sys_Users.FirstOrDefault(o => !o.IsDeleted && o.Email.ToLower() == email.ToLower());
                if (obj == null) return 0;

                return obj.ID;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public List<Sys_User> Sys_User_Gets(int pageIndex, int pageSize, out int totalPages)
        {
            totalPages = 0;
            try
            {
                var all = DB.Sys_Users.Where(o => !o.IsDeleted && o.ID > 1);
                if (all.Count() == 0) return null;

                int startIndex = pageIndex * pageSize;
                List<Sys_User> res = all.OrderBy(o => o.Firstname).ThenBy(o => o.Lastname).Skip(startIndex).Take(pageSize).ToList();

                if (res.Count == 0) return null;

                int div = all.Count() / pageSize;
                int mod = all.Count() % pageSize;
                totalPages = div + (mod > 0 ? 1 : 0);

                return res;
            }
            catch
            {
                return null;
            }
        }

        public List<eSys_User> Sys_User_GetEs(int pageIndex, int pageSize, out int totalPages)
        {
            totalPages = 0;
            try
            {
                var all = Sys_User_Gets(pageIndex, pageSize, out totalPages);
                if (all == null) return null;

                List<eSys_User> result = new List<eSys_User>();
                foreach (Sys_User obj in all)
                    result.Add(Sys_User_Entity(obj));

                return result;
            }
            catch
            {
                return null;
            }
        }

        public Sys_User Sys_User_Get(int id)
        {
            try
            {
                return DB.Sys_Users.FirstOrDefault(o =>
                    o.ID == id);
            }
            catch
            {
                return null;
            }
        }

        public eSys_User Sys_User_GetE(int id)
        {
            try
            {
                return Sys_User_Entity(Sys_User_Get(id));
            }
            catch
            {
                return null;
            }
        }

        public Sys_User Sys_User_Get(string email, string password)
        {
            try
            {
                string encryptPassword = string.Empty;
                PrivateEncryptor encryptor = new PrivateEncryptor();
                encryptPassword = encryptor.Encrypt(password);

                return DB.Sys_Users.FirstOrDefault(o =>
                    !o.IsDeleted &&
                    o.Email.ToLower().Trim() == email.ToLower().Trim() &&
                    o.Password == encryptPassword);
            }
            catch
            {
                return null;
            }
        }

        public eSys_User Sys_User_Entity(Sys_User obj)
        {
            try
            {
                if (obj == null) return null;
                List<eSys_RolePermission> permissions = null;
                if (obj.Sys_Role.Sys_Permissions.Count > 0)
                {
                    permissions = new List<eSys_RolePermission>();
                    foreach (Sys_Permission permission in obj.Sys_Role.Sys_Permissions)
                        permissions.Add(Sys_Permission_Entity(permission));
                }

                return new eSys_User()
                {
                    Address = obj.Address,
                    Avatar = obj.Avatar,
                    DateOfBirth = obj.DateOfBirth,
                    Email = obj.Email,
                    Firstname = obj.Firstname,
                    ID = obj.ID,
                    Lastname = obj.Lastname,
                    PhoneNumber = obj.PhoneNumber,
                    RoleID = obj.RoleID,
                    Status = obj.Status,
                    Username = obj.Username,

                    IsDeleted = obj.IsDeleted,
                    RoleName = obj.Sys_Role.Name,
                    StatusName = GlobalValues.Sys_UserStatuses.FirstOrDefault(o => o.ID == obj.Status).Name,
                    CanAccessSystemMenu = obj.Sys_Role.CanAccessSystemMenu,
                    RolePermissions = permissions,
                    sDateOfBirth = obj.DateOfBirth.ToString(GlobalValues.DateFormat_VN)
                };
            }
            catch
            {
                return null;
            }
        }

        public eSys_RolePermission Sys_Permission_Entity(Sys_Permission obj)
        {
            try
            {
                if (obj == null) return null;

                return new eSys_RolePermission()
                {
                    ID = obj.ID,
                    ModuleID = obj.ModuleID,
                    Permissions = obj.Permissions,
                    RoleID = obj.RoleID,
                };
            }
            catch
            {
                return null;
            }
        }

        public void CheckGodUserExists()
        {
            try
            {
                var obj = DB.Sys_Users.FirstOrDefault(o => o.ID == eSys_User.GodUser.ID);
                if (obj == null)
                {
                    PrivateEncryptor encrypter = new PrivateEncryptor();
                    Sys_User_Create(new Sys_User()
                    {
                        Address = eSys_User.GodUser.Address,
                        Avatar = eSys_User.GodUser.Avatar,
                        DateOfBirth = eSys_User.GodUser.DateOfBirth,
                        Email = eSys_User.GodUser.Email,
                        Firstname = eSys_User.GodUser.Firstname,
                        ID = eSys_User.GodUser.ID,
                        IsDeleted = eSys_User.GodUser.IsDeleted,
                        Lastname = eSys_User.GodUser.Lastname,
                        Password = encrypter.Encrypt(eSys_User.GodUser.Password),
                        PhoneNumber = eSys_User.GodUser.PhoneNumber,
                        RoleID = eSys_Role.GodRole.ID,
                        Status = eSys_User.GodUser.Status,
                        Username = eSys_User.GodUser.Username,
                    });
                }
            }
            catch
            {
                return;
            }
        }

        #endregion

        //---------------------------------------

        #region GoodsTypes

        public bool GoodsType_Delete(GoodsType goodstype)
        {
            try
            {
                GoodsType obj = DB.GoodsTypes.FirstOrDefault(o => o.ID == goodstype.ID);
                if (obj == null) return false;

                obj.IsDeleted = true;
                obj.LastestUpdated = DateTime.Now;
                obj.UpdatedBy = goodstype.UpdatedBy;
                DB.SubmitChanges();

                return true;
            }
            catch
            {
                return false;
            }
        }

        public int GoodsType_Update(GoodsType obj)
        {
            try
            {
                GoodsType updateObj = DB.GoodsTypes.FirstOrDefault(o => o.ID == obj.ID);
                if (updateObj == null) return 3;

                GoodsType checkObj = DB.GoodsTypes.FirstOrDefault(o => !o.IsDeleted && o.Code.ToLower() == obj.Code.ToLower());
                if (checkObj != null && checkObj.ID != updateObj.ID) return 1;

                updateObj.Code = obj.Code;
                updateObj.Description = obj.Description;
                updateObj.LastestUpdated = DateTime.Now;
                updateObj.Name = obj.Name;
                updateObj.UpdatedBy = obj.UpdatedBy;

                DB.SubmitChanges();

                return 0;
            }
            catch (Exception ex)
            {
                return int.MinValue;
            }
        }

        public int GoodsType_Create(GoodsType obj)
        {
            try
            {
                GoodsType checkObj = DB.GoodsTypes.FirstOrDefault(o => !o.IsDeleted && o.Code.ToLower() == obj.Code.ToLower());
                if (checkObj != null) return 1;

                DB.GoodsTypes.InsertOnSubmit(obj);
                DB.SubmitChanges();

                return 0;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public int GoodsType_CheckCode(string code)
        {
            try
            {
                GoodsType obj = DB.GoodsTypes.FirstOrDefault(o => !o.IsDeleted && o.Code.ToLower() == code.ToLower());
                if (obj == null) return 0;

                return obj.ID;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public List<GoodsType> GoodsType_Gets(int pageIndex, int pageSize, out int totalPages)
        {
            totalPages = 0;
            try
            {
                var all = DB.GoodsTypes.Where(o => !o.IsDeleted);
                if (all.Count() == 0) return null;

                int startIndex = pageIndex * pageSize;
                List<GoodsType> res = all.OrderBy(o => o.Name).ThenBy(o => o.Code).Skip(startIndex).Take(pageSize).ToList();

                if (res.Count == 0) return null;

                int div = all.Count() / pageSize;
                int mod = all.Count() % pageSize;
                totalPages = div + (mod > 0 ? 1 : 0);

                return res;
            }
            catch
            {
                return null;
            }
        }

        public List<eGoodsType> GoodsType_GetEs(int pageIndex, int pageSize, out int totalPages)
        {
            totalPages = 0;
            try
            {
                var all = GoodsType_Gets(pageIndex, pageSize, out totalPages);
                if (all == null) return null;

                List<eGoodsType> result = new List<eGoodsType>();
                foreach (GoodsType obj in all)
                    result.Add(GoodsType_Entity(obj));

                return result;
            }
            catch
            {
                return null;
            }
        }

        public List<GoodsType> GoodsType_Gets()
        {
            try
            {
                var all = DB.GoodsTypes.Where(o => !o.IsDeleted);
                if (all.Count() == 0) return null;

                return all.OrderBy(o => o.Name).ThenBy(o => o.Code).ToList();
            }
            catch
            {
                return null;
            }
        }

        public List<eGoodsType> GoodsType_GetEs()
        {
            try
            {
                var all = GoodsType_Gets();
                if (all == null) return null;

                List<eGoodsType> result = new List<eGoodsType>();
                foreach (GoodsType obj in all)
                    result.Add(GoodsType_Entity(obj));

                return result;
            }
            catch
            {
                return null;
            }
        }

        public GoodsType GoodsType_Get(int id)
        {
            try
            {
                return DB.GoodsTypes.FirstOrDefault(o =>
                    o.ID == id);
            }
            catch
            {
                return null;
            }
        }

        public eGoodsType GoodsType_GetE(int id)
        {
            try
            {
                return GoodsType_Entity(GoodsType_Get(id));
            }
            catch
            {
                return null;
            }
        }

        public GoodsType GoodsType_Get(string code)
        {
            try
            {
                return DB.GoodsTypes.FirstOrDefault(o =>
                    !o.IsDeleted &&
                    o.Code.ToLower().Trim() == code.ToLower().Trim());
            }
            catch
            {
                return null;
            }
        }

        public eGoodsType GoodsType_GetE(string code)
        {
            try
            {
                return GoodsType_Entity(GoodsType_Get(code));
            }
            catch
            {
                return null;
            }
        }

        public eGoodsType GoodsType_Entity(GoodsType obj)
        {
            try
            {
                if (obj == null) return null;

                return new eGoodsType()
                {
                    Code = obj.Code,
                    Description = obj.Description,
                    ID = obj.ID,
                    IsDeleted = obj.IsDeleted,
                    LastestUpdate = obj.LastestUpdated,
                    Name = obj.Name,
                    sLastestUpdate = obj.LastestUpdated.ToString(GlobalValues.DateFormat_VN),
                    UpdatedBy = Sys_User_GetE(obj.UpdatedBy)
                };
            }
            catch
            {
                return null;
            }
        }

        #endregion

        #region VehicleTypes

        public bool VehicleType_Delete(VehicleType goodstype)
        {
            try
            {
                VehicleType obj = DB.VehicleTypes.FirstOrDefault(o => o.ID == goodstype.ID);
                if (obj == null) return false;

                obj.IsDeleted = true;
                obj.LastestUpdated = DateTime.Now;
                obj.UpdatedBy = goodstype.UpdatedBy;
                DB.SubmitChanges();

                return true;
            }
            catch
            {
                return false;
            }
        }

        public int VehicleType_Update(VehicleType obj)
        {
            try
            {
                VehicleType updateObj = DB.VehicleTypes.FirstOrDefault(o => o.ID == obj.ID);
                if (updateObj == null) return 3;

                VehicleType checkObj = DB.VehicleTypes.FirstOrDefault(o => !o.IsDeleted && o.Code.ToLower() == obj.Code.ToLower());
                if (checkObj != null && checkObj.ID != updateObj.ID) return 1;

                updateObj.Code = obj.Code;
                updateObj.Description = obj.Description;
                updateObj.LastestUpdated = DateTime.Now;
                updateObj.Name = obj.Name;
                updateObj.UpdatedBy = obj.UpdatedBy;
                updateObj.GoodsTypeID = obj.GoodsTypeID;

                DB.SubmitChanges();

                return 0;
            }
            catch (Exception ex)
            {
                return int.MinValue;
            }
        }

        public int VehicleType_Create(VehicleType obj)
        {
            try
            {
                VehicleType checkObj = DB.VehicleTypes.FirstOrDefault(o => !o.IsDeleted && o.Code.ToLower() == obj.Code.ToLower());
                if (checkObj != null) return 1;

                DB.VehicleTypes.InsertOnSubmit(obj);
                DB.SubmitChanges();

                return 0;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public int VehicleType_CheckCode(string code)
        {
            try
            {
                VehicleType obj = DB.VehicleTypes.FirstOrDefault(o => !o.IsDeleted && o.Code.ToLower() == code.ToLower());
                if (obj == null) return 0;

                return obj.ID;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public List<VehicleType> VehicleType_Gets(int pageIndex, int pageSize, out int totalPages)
        {
            totalPages = 0;
            try
            {
                var all = DB.VehicleTypes.Where(o => !o.IsDeleted);
                if (all.Count() == 0) return null;

                int startIndex = pageIndex * pageSize;
                List<VehicleType> res = all.OrderBy(o => o.Name).ThenBy(o => o.Code).Skip(startIndex).Take(pageSize).ToList();

                if (res.Count == 0) return null;

                int div = all.Count() / pageSize;
                int mod = all.Count() % pageSize;
                totalPages = div + (mod > 0 ? 1 : 0);

                return res;
            }
            catch
            {
                return null;
            }
        }

        public List<eVehicleType> VehicleType_GetEs(int pageIndex, int pageSize, out int totalPages)
        {
            totalPages = 0;
            try
            {
                var all = VehicleType_Gets(pageIndex, pageSize, out totalPages);
                if (all == null) return null;

                List<eVehicleType> result = new List<eVehicleType>();
                foreach (VehicleType obj in all)
                    result.Add(VehicleType_Entity(obj));

                return result;
            }
            catch
            {
                return null;
            }
        }

        public List<VehicleType> VehicleType_Gets()
        {
            try
            {
                var all = DB.VehicleTypes.Where(o => !o.IsDeleted);
                if (all.Count() == 0) return null;

                return all.OrderBy(o => o.Name).ThenBy(o => o.Code).ToList();
            }
            catch
            {
                return null;
            }
        }

        public List<eVehicleType> VehicleType_GetEs()
        {
            try
            {
                var all = VehicleType_Gets();
                if (all == null) return null;

                List<eVehicleType> result = new List<eVehicleType>();
                foreach (VehicleType obj in all)
                    result.Add(VehicleType_Entity(obj));

                return result;
            }
            catch
            {
                return null;
            }
        }

        public VehicleType VehicleType_Get(int id)
        {
            try
            {
                return DB.VehicleTypes.FirstOrDefault(o =>
                    o.ID == id);
            }
            catch
            {
                return null;
            }
        }

        public eVehicleType VehicleType_GetE(int id)
        {
            try
            {
                return VehicleType_Entity(VehicleType_Get(id));
            }
            catch
            {
                return null;
            }
        }

        public VehicleType VehicleType_Get(string code)
        {
            try
            {
                return DB.VehicleTypes.FirstOrDefault(o =>
                    !o.IsDeleted &&
                    o.Code.ToLower().Trim() == code.ToLower().Trim());
            }
            catch
            {
                return null;
            }
        }

        public eVehicleType VehicleType_GetE(string code)
        {
            try
            {
                return VehicleType_Entity(VehicleType_Get(code));
            }
            catch
            {
                return null;
            }
        }

        public eVehicleType VehicleType_Entity(VehicleType obj)
        {
            try
            {
                if (obj == null) return null;
                List<eVehicleLoad> loads = new List<eVehicleLoad>();
                if (obj.VehicleLoads.Count > 0)
                {
                    foreach (VehicleLoad load in obj.VehicleLoads.Where(o => !o.IsDeleted))
                        loads.Add(VehicleLoad_Entity(load, false));
                }

                return new eVehicleType()
                {
                    Code = obj.Code,
                    Description = obj.Description,
                    ID = obj.ID,
                    GoodsTypeID = obj.GoodsTypeID,

                    IsDeleted = obj.IsDeleted,
                    LastestUpdate = obj.LastestUpdated,
                    Name = obj.Name,
                    sLastestUpdate = obj.LastestUpdated.ToString(GlobalValues.DateFormat_VN),
                    UpdatedBy = Sys_User_GetE(obj.UpdatedBy),
                    GoodsType = GoodsType_GetE(obj.GoodsTypeID),
                    VehicleLoads = loads.Count == 0 ? null : loads,
                };
            }
            catch
            {
                return null;
            }
        }

        #endregion

        #region VehicleLoads

        public bool VehicleLoad_Delete(VehicleLoad vehicleload)
        {
            try
            {
                VehicleLoad obj = DB.VehicleLoads.FirstOrDefault(o => o.ID == vehicleload.ID);
                if (obj == null) return false;

                obj.IsDeleted = true;
                obj.LastestUpdated = DateTime.Now;
                obj.UpdatedBy = vehicleload.UpdatedBy;
                DB.SubmitChanges();

                return true;
            }
            catch
            {
                return false;
            }
        }

        public int VehicleLoad_Update(VehicleLoad obj)
        {
            try
            {
                VehicleLoad updateObj = DB.VehicleLoads.FirstOrDefault(o => o.ID == obj.ID);
                if (updateObj == null) return 3;

                VehicleLoad checkObj = DB.VehicleLoads.FirstOrDefault(o => !o.IsDeleted && o.Code.ToLower() == obj.Code.ToLower());
                if (checkObj != null && checkObj.ID != updateObj.ID) return 1;

                updateObj.Code = obj.Code;
                updateObj.Description = obj.Description;
                updateObj.LastestUpdated = DateTime.Now;
                updateObj.Name = obj.Name;
                updateObj.UpdatedBy = obj.UpdatedBy;
                updateObj.VehicleTypeID = obj.VehicleTypeID;
                updateObj.FullLoad = obj.FullLoad;

                DB.SubmitChanges();

                return 0;
            }
            catch (Exception ex)
            {
                return int.MinValue;
            }
        }

        public int VehicleLoad_Create(VehicleLoad obj)
        {
            try
            {
                VehicleLoad checkObj = DB.VehicleLoads.FirstOrDefault(o => !o.IsDeleted && o.Code.ToLower() == obj.Code.ToLower());
                if (checkObj != null) return 1;

                DB.VehicleLoads.InsertOnSubmit(obj);
                DB.SubmitChanges();

                return 0;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public int VehicleLoad_CheckCode(string code)
        {
            try
            {
                VehicleLoad obj = DB.VehicleLoads.FirstOrDefault(o => !o.IsDeleted && o.Code.ToLower() == code.ToLower());
                if (obj == null) return 0;

                return obj.ID;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public List<VehicleLoad> VehicleLoad_Gets(int pageIndex, int pageSize, out int totalPages)
        {
            totalPages = 0;
            try
            {
                var all = DB.VehicleLoads.Where(o => !o.IsDeleted);
                if (all.Count() == 0) return null;

                int startIndex = pageIndex * pageSize;
                List<VehicleLoad> res = all.OrderBy(o => o.Name).ThenBy(o => o.Code).Skip(startIndex).Take(pageSize).ToList();

                if (res.Count == 0) return null;

                int div = all.Count() / pageSize;
                int mod = all.Count() % pageSize;
                totalPages = div + (mod > 0 ? 1 : 0);

                return res;
            }
            catch
            {
                return null;
            }
        }

        public List<eVehicleLoad> VehicleLoad_GetEs(int pageIndex, int pageSize, out int totalPages)
        {
            totalPages = 0;
            try
            {
                var all = VehicleLoad_Gets(pageIndex, pageSize, out totalPages);
                if (all == null) return null;

                List<eVehicleLoad> result = new List<eVehicleLoad>();
                foreach (VehicleLoad obj in all)
                    result.Add(VehicleLoad_Entity(obj));

                return result;
            }
            catch
            {
                return null;
            }
        }

        public List<VehicleLoad> VehicleLoad_Gets()
        {
            try
            {
                var all = DB.VehicleLoads.Where(o => !o.IsDeleted);
                if (all.Count() == 0) return null;

                return all.OrderBy(o => o.Name).ThenBy(o => o.Code).ToList();
            }
            catch
            {
                return null;
            }
        }

        public List<eVehicleLoad> VehicleLoad_GetEs()
        {
            try
            {
                var all = VehicleLoad_Gets();
                if (all == null) return null;

                List<eVehicleLoad> result = new List<eVehicleLoad>();
                foreach (VehicleLoad obj in all)
                    result.Add(VehicleLoad_Entity(obj));

                return result;
            }
            catch
            {
                return null;
            }
        }

        public VehicleLoad VehicleLoad_Get(int id)
        {
            try
            {
                return DB.VehicleLoads.FirstOrDefault(o =>
                    o.ID == id);
            }
            catch
            {
                return null;
            }
        }

        public eVehicleLoad VehicleLoad_GetE(int id)
        {
            try
            {
                return VehicleLoad_Entity(VehicleLoad_Get(id));
            }
            catch
            {
                return null;
            }
        }

        public VehicleLoad VehicleLoad_Get(string code)
        {
            try
            {
                return DB.VehicleLoads.FirstOrDefault(o =>
                    !o.IsDeleted &&
                    o.Code.ToLower().Trim() == code.ToLower().Trim());
            }
            catch
            {
                return null;
            }
        }

        public eVehicleLoad VehicleLoad_GetE(string code)
        {
            try
            {
                return VehicleLoad_Entity(VehicleLoad_Get(code));
            }
            catch
            {
                return null;
            }
        }

        public eVehicleLoad VehicleLoad_Entity(VehicleLoad obj, bool includeEntity = true)
        {
            try
            {
                if (obj == null) return null;

                return new eVehicleLoad()
                {
                    Code = obj.Code,
                    Description = obj.Description,
                    ID = obj.ID,
                    VehicleTypeID = obj.VehicleTypeID,
                    FullLoad = obj.FullLoad,

                    IsDeleted = obj.IsDeleted,
                    LastestUpdate = obj.LastestUpdated,
                    Name = obj.Name,
                    sLastestUpdate = obj.LastestUpdated.ToString(GlobalValues.DateFormat_VN),
                    UpdatedBy = Sys_User_GetE(obj.UpdatedBy),
                    VehicleType = !includeEntity ? null : VehicleType_GetE(obj.VehicleTypeID)
                };
            }
            catch
            {
                return null;
            }
        }

        #endregion

        #region TransportPlaces

        public bool TransportPlace_Delete(TransportPlace TransportPlace)
        {
            try
            {
                TransportPlace obj = DB.TransportPlaces.FirstOrDefault(o => o.ID == TransportPlace.ID);
                if (obj == null) return false;

                obj.IsDeleted = true;
                obj.LastestUpdated = DateTime.Now;
                obj.UpdatedBy = TransportPlace.UpdatedBy;
                DB.SubmitChanges();

                return true;
            }
            catch
            {
                return false;
            }
        }

        public int TransportPlace_Update(TransportPlace obj)
        {
            try
            {
                TransportPlace updateObj = DB.TransportPlaces.FirstOrDefault(o => o.ID == obj.ID);
                if (updateObj == null) return 3;

                TransportPlace checkObj = DB.TransportPlaces.FirstOrDefault(o => !o.IsDeleted && o.Name.ToLower() == obj.Name.ToLower());
                if (checkObj != null && checkObj.ID != updateObj.ID) return 1;

                updateObj.Address = obj.Address;
                updateObj.Email = obj.Email;
                updateObj.LastestUpdated = DateTime.Now;
                updateObj.Name = obj.Name;
                updateObj.PhoneNumber = obj.PhoneNumber;
                updateObj.UpdatedBy = obj.UpdatedBy;

                DB.SubmitChanges();

                return 0;
            }
            catch (Exception ex)
            {
                return int.MinValue;
            }
        }

        public int TransportPlace_Create(TransportPlace obj)
        {
            try
            {
                TransportPlace checkObj = DB.TransportPlaces.FirstOrDefault(o => !o.IsDeleted && o.Name.ToLower() == obj.Name.ToLower());
                if (checkObj != null) return 1;

                DB.TransportPlaces.InsertOnSubmit(obj);
                DB.SubmitChanges();

                return 0;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public int TransportPlace_CheckName(string name)
        {
            try
            {
                TransportPlace obj = DB.TransportPlaces.FirstOrDefault(o => !o.IsDeleted && o.Name.ToLower() == name.ToLower());
                if (obj == null) return 0;

                return obj.ID;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public List<TransportPlace> TransportPlace_Gets(int pageIndex, int pageSize, out int totalPages)
        {
            totalPages = 0;
            try
            {
                var all = DB.TransportPlaces.Where(o => !o.IsDeleted);
                if (all.Count() == 0) return null;

                int startIndex = pageIndex * pageSize;
                List<TransportPlace> res = all.OrderBy(o => o.Name).ThenBy(o => o.Address).Skip(startIndex).Take(pageSize).ToList();

                if (res.Count == 0) return null;

                int div = all.Count() / pageSize;
                int mod = all.Count() % pageSize;
                totalPages = div + (mod > 0 ? 1 : 0);

                return res;
            }
            catch
            {
                return null;
            }
        }

        public List<eTransportPlace> TransportPlace_GetEs(int pageIndex, int pageSize, out int totalPages)
        {
            totalPages = 0;
            try
            {
                var all = TransportPlace_Gets(pageIndex, pageSize, out totalPages);
                if (all == null) return null;

                List<eTransportPlace> result = new List<eTransportPlace>();
                foreach (TransportPlace obj in all)
                    result.Add(TransportPlace_Entity(obj));

                return result;
            }
            catch
            {
                return null;
            }
        }

        public List<TransportPlace> TransportPlace_Gets()
        {
            try
            {
                var all = DB.TransportPlaces.Where(o => !o.IsDeleted);
                if (all.Count() == 0) return null;

                return all.OrderBy(o => o.Name).ThenBy(o => o.Address).ToList();
            }
            catch
            {
                return null;
            }
        }

        public List<eTransportPlace> TransportPlace_GetEs()
        {
            try
            {
                var all = TransportPlace_Gets();
                if (all == null) return null;

                List<eTransportPlace> result = new List<eTransportPlace>();
                foreach (TransportPlace obj in all)
                    result.Add(TransportPlace_Entity(obj));

                return result;
            }
            catch
            {
                return null;
            }
        }

        public TransportPlace TransportPlace_Get(int id)
        {
            try
            {
                return DB.TransportPlaces.FirstOrDefault(o =>
                    o.ID == id);
            }
            catch
            {
                return null;
            }
        }

        public eTransportPlace TransportPlace_GetE(int id)
        {
            try
            {
                return TransportPlace_Entity(TransportPlace_Get(id));
            }
            catch
            {
                return null;
            }
        }

        public eTransportPlace TransportPlace_Entity(TransportPlace obj)
        {
            try
            {
                if (obj == null) return null;

                return new eTransportPlace()
                {
                    Address = obj.Address,
                    Email = obj.Email,
                    ID = obj.ID,
                    IsDeleted = obj.IsDeleted,
                    LastestUpdate = obj.LastestUpdated,
                    Name = obj.Name,
                    PhoneNumber = obj.PhoneNumber,
                    sLastestUpdate = obj.LastestUpdated.ToString(GlobalValues.DateFormat_VN),
                    UpdatedBy = Sys_User_GetE(obj.UpdatedBy)
                };
            }
            catch
            {
                return null;
            }
        }

        #endregion

        #region TransportCompanies

        public bool TransportCompany_Delete(TransportCompany TransportCompany)
        {
            try
            {
                TransportCompany obj = DB.TransportCompanies.FirstOrDefault(o => o.ID == TransportCompany.ID);
                if (obj == null) return false;

                obj.IsDeleted = true;
                obj.LastestUpdated = DateTime.Now;
                obj.UpdatedBy = TransportCompany.UpdatedBy;
                DB.SubmitChanges();

                return true;
            }
            catch
            {
                return false;
            }
        }

        public int TransportCompany_Update(TransportCompany obj, List<aTransportCompany_VehicleType> vehicleTypes = null)
        {
            try
            {
                TransportCompany updateObj = DB.TransportCompanies.FirstOrDefault(o => o.ID == obj.ID);
                if (updateObj == null) return 3;

                TransportCompany checkObj = DB.TransportCompanies.FirstOrDefault(o => !o.IsDeleted && o.Name.ToLower() == obj.Name.ToLower());
                if (checkObj != null && checkObj.ID != updateObj.ID) return 1;

                updateObj.Address = obj.Address;
                updateObj.Email = obj.Email;
                updateObj.LastestUpdated = DateTime.Now;
                updateObj.Name = obj.Name;
                updateObj.PhoneNumber = obj.PhoneNumber;
                updateObj.UpdatedBy = obj.UpdatedBy;
                updateObj.Status = obj.Status;

                DB.SubmitChanges();

                TransportCompany_UpdateVehicleTypes(obj, vehicleTypes);

                return 0;
            }
            catch (Exception ex)
            {
                return int.MinValue;
            }
        }

        public int TransportCompany_Create(TransportCompany obj, List<aTransportCompany_VehicleType> vehicleTypes = null)
        {
            try
            {
                TransportCompany checkObj = DB.TransportCompanies.FirstOrDefault(o => !o.IsDeleted && o.Name.ToLower() == obj.Name.ToLower());
                if (checkObj != null) return 1;

                DB.TransportCompanies.InsertOnSubmit(obj);
                DB.SubmitChanges();

                TransportCompany_UpdateVehicleTypes(obj, vehicleTypes);

                return 0;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public int TransportCompany_UpdateVehicleTypes(TransportCompany company, List<aTransportCompany_VehicleType> vehicleTypes)
        {
            try
            {
                if (company == null) return 0;

                List<VehicleType> allTypes = VehicleType_Gets();
                if (allTypes == null) return 0;

                foreach (VehicleType type in allTypes)
                {
                    aTransportCompany_VehicleType aType = vehicleTypes == null ? null : vehicleTypes.FirstOrDefault(o => o.ID == type.ID);

                    TransportCompany_VehicleType dbType = DB.TransportCompany_VehicleTypes.FirstOrDefault(o =>
                        o.TransCompID == company.ID &&
                        o.VehicleTypeID == type.ID);

                    if (dbType == null)//Chưa có
                    {
                        if (aType != null)
                        {
                            dbType = new TransportCompany_VehicleType()
                            {
                                IsDeleted = false,
                                LastestUpdated = DateTime.Now,
                                TransCompID = company.ID,
                                UpdatedBy = company.UpdatedBy,
                                VehicleTypeID = type.ID,
                            };

                            DB.TransportCompany_VehicleTypes.InsertOnSubmit(dbType);
                            DB.SubmitChanges();
                        }
                    }
                    else //Đã có
                    {
                        if (aType != null && dbType.IsDeleted)
                        {
                            dbType.IsDeleted = false;
                            DB.SubmitChanges();
                        }

                        if (aType == null && !dbType.IsDeleted)
                        {
                            dbType.IsDeleted = true;
                            DB.SubmitChanges();
                        }
                    }

                    #region Loads

                    if (aType != null)
                    {
                        foreach (VehicleLoad load in type.VehicleLoads)
                        {
                            aTransportCompany_VehicleType_Load aLoad = aType.Loads == null ? null : aType.Loads.FirstOrDefault(o => o.ID == load.ID);
                            TransportCompany_VehicleType_Load dbLoad = DB.TransportCompany_VehicleType_Loads.FirstOrDefault(o =>
                                o.TransComp_VehicleTypeID == dbType.ID &&
                                o.VehicleLoadID == load.ID);

                            if (dbLoad == null)//Chưa có
                            {
                                if (aLoad != null)
                                {
                                    dbLoad = new TransportCompany_VehicleType_Load()
                                    {
                                        IsDeleted = false,
                                        LastestUpdated = DateTime.Now,
                                        TransComp_VehicleTypeID = dbType.ID,
                                        UpdatedBy = company.UpdatedBy,
                                        VehicleLoadID = load.ID,
                                    };

                                    DB.TransportCompany_VehicleType_Loads.InsertOnSubmit(dbLoad);
                                    DB.SubmitChanges();
                                }
                            }
                            else //Đã có
                            {
                                if (aLoad != null && dbLoad.IsDeleted)
                                {
                                    dbLoad.IsDeleted = false;
                                    DB.SubmitChanges();
                                }

                                if (aLoad == null && !dbLoad.IsDeleted)
                                {
                                    dbLoad.IsDeleted = true;
                                    DB.SubmitChanges();
                                }
                            }
                        }
                    }

                    #endregion
                }

                return 0;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public int TransportCompany_CheckName(string name)
        {
            try
            {
                TransportCompany obj = DB.TransportCompanies.FirstOrDefault(o => !o.IsDeleted && o.Name.ToLower() == name.ToLower());
                if (obj == null) return 0;

                return obj.ID;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public List<TransportCompany> TransportCompany_Gets(int pageIndex, int pageSize, out int totalPages)
        {
            totalPages = 0;
            try
            {
                var all = DB.TransportCompanies.Where(o => !o.IsDeleted);
                if (all.Count() == 0) return null;

                int startIndex = pageIndex * pageSize;
                List<TransportCompany> res = all.OrderBy(o => o.Name).ThenBy(o => o.Address).Skip(startIndex).Take(pageSize).ToList();

                if (res.Count == 0) return null;

                int div = all.Count() / pageSize;
                int mod = all.Count() % pageSize;
                totalPages = div + (mod > 0 ? 1 : 0);

                return res;
            }
            catch
            {
                return null;
            }
        }

        public List<eTransportCompany> TransportCompany_GetEs(int pageIndex, int pageSize, out int totalPages)
        {
            totalPages = 0;
            try
            {
                var all = TransportCompany_Gets(pageIndex, pageSize, out totalPages);
                if (all == null) return null;

                List<eTransportCompany> result = new List<eTransportCompany>();
                foreach (TransportCompany obj in all)
                    result.Add(TransportCompany_Entity(obj));

                return result;
            }
            catch
            {
                return null;
            }
        }

        public List<TransportCompany> TransportCompany_Gets()
        {
            try
            {
                var all = DB.TransportCompanies.Where(o => !o.IsDeleted);
                if (all.Count() == 0) return null;

                return all.OrderBy(o => o.Name).ThenBy(o => o.Address).ToList();
            }
            catch
            {
                return null;
            }
        }

        public List<eTransportCompany> TransportCompany_GetEs()
        {
            try
            {
                var all = TransportCompany_Gets();
                if (all == null) return null;

                List<eTransportCompany> result = new List<eTransportCompany>();
                foreach (TransportCompany obj in all)
                    result.Add(TransportCompany_Entity(obj));

                return result;
            }
            catch
            {
                return null;
            }
        }

        public TransportCompany TransportCompany_Get(int id)
        {
            try
            {
                return DB.TransportCompanies.FirstOrDefault(o =>
                    o.ID == id);
            }
            catch
            {
                return null;
            }
        }

        public eTransportCompany TransportCompany_GetE(int id)
        {
            try
            {
                return TransportCompany_Entity(TransportCompany_Get(id));
            }
            catch
            {
                return null;
            }
        }

        public eTransportCompany TransportCompany_Entity(TransportCompany obj)
        {
            try
            {
                if (obj == null) return null;
                List<eTransportCompany_VehicleType> vehicleTypes = new List<eTransportCompany_VehicleType>();
                if (obj.TransportCompany_VehicleTypes.Count > 0)
                {
                    foreach (TransportCompany_VehicleType type in obj.TransportCompany_VehicleTypes.Where(o => !o.IsDeleted && !o.VehicleType.IsDeleted))
                        vehicleTypes.Add(TransportCompany_VehicleType_Entity(type));
                }

                List<eRoute> routes = new List<eRoute>();
                if (obj.TransportCompany_Routes.Count > 0)
                {
                    foreach (TransportCompany_Route route in obj.TransportCompany_Routes.Where(o => !o.IsDeleted && !o.TransportPlace.IsDeleted))
                        routes.Add(TransportCompany_Route_Entity(route, false));
                }

                return new eTransportCompany()
                {
                    Address = obj.Address,
                    Email = obj.Email,
                    ID = obj.ID,
                    IsDeleted = obj.IsDeleted,
                    LastestUpdate = obj.LastestUpdated,
                    Name = obj.Name,
                    PhoneNumber = obj.PhoneNumber,
                    Status = obj.Status,
                    StatusName = GlobalValues.TransportCompanyStatuses.FirstOrDefault(o => o.ID == obj.Status).Name,
                    sLastestUpdate = obj.LastestUpdated.ToString(GlobalValues.DateFormat_VN),
                    UpdatedBy = Sys_User_GetE(obj.UpdatedBy),
                    VehicleTypes = vehicleTypes.Count == 0 ? null : vehicleTypes,
                    Routes = routes
                };
            }
            catch
            {
                return null;
            }
        }

        public eTransportCompany_VehicleType TransportCompany_VehicleType_Entity(TransportCompany_VehicleType obj)
        {
            try
            {
                if (obj == null) return null;
                List<eTransportCompany_VehicleType_Load> vehicleLoads = new List<eTransportCompany_VehicleType_Load>();
                if (obj.TransportCompany_VehicleType_Loads.Count > 0)
                {
                    foreach (TransportCompany_VehicleType_Load load in obj.TransportCompany_VehicleType_Loads.Where(o => !o.IsDeleted && !o.VehicleLoad.IsDeleted))
                        vehicleLoads.Add(TransportCompany_VehicleType_Load_Entity(load));
                }

                return new eTransportCompany_VehicleType()
                {
                    ID = obj.ID,
                    IsDeleted = obj.IsDeleted,
                    LastestUpdate = obj.LastestUpdated,
                    sLastestUpdate = obj.LastestUpdated.ToString(GlobalValues.DateFormat_VN),
                    TransCompID = obj.TransCompID,
                    UpdatedBy = Sys_User_GetE(obj.UpdatedBy),
                    VehicleTypeID = obj.VehicleTypeID,
                    Loads = vehicleLoads,
                    sVehicleTypeName = obj.VehicleType.Name,
                };
            }
            catch
            {
                return null;
            }
        }

        public eTransportCompany_VehicleType_Load TransportCompany_VehicleType_Load_Entity(TransportCompany_VehicleType_Load obj)
        {
            try
            {
                if (obj == null) return null;

                return new eTransportCompany_VehicleType_Load()
                {
                    ID = obj.ID,
                    IsDeleted = obj.IsDeleted,
                    LastestUpdate = obj.LastestUpdated,
                    sLastestUpdate = obj.LastestUpdated.ToString(GlobalValues.DateFormat_VN),
                    TransComp_VehicleTypeID = obj.TransComp_VehicleTypeID,
                    UpdatedBy = Sys_User_GetE(obj.UpdatedBy),
                    VehicleLoadID = obj.VehicleLoadID,
                    VehicleLoad = VehicleLoad_GetE(obj.VehicleLoadID),
                    VehicleType = VehicleType_GetE(obj.TransportCompany_VehicleType.VehicleTypeID),
                };
            }
            catch
            {
                return null;
            }
        }

        #endregion

        #region Routes

        public bool TransportCompany_Route_Delete(TransportCompany_Route route)
        {
            try
            {
                TransportCompany_Route obj = DB.TransportCompany_Routes.FirstOrDefault(o => o.ID == route.ID);
                if (obj == null) return false;

                obj.IsDeleted = true;
                obj.LastestUpdated = DateTime.Now;
                obj.UpdatedBy = route.UpdatedBy;
                DB.SubmitChanges();

                return true;
            }
            catch
            {
                return false;
            }
        }

        public int TransportCompany_Route_Update(TransportCompany_Route obj)
        {
            try
            {
                TransportCompany_Route updateObj = DB.TransportCompany_Routes.FirstOrDefault(o => o.ID == obj.ID);
                if (updateObj == null) return 3;

                TransportCompany_Route checkObj = DB.TransportCompany_Routes.FirstOrDefault(o =>
                    !o.IsDeleted &&
                    o.TransCompID == obj.TransCompID &&
                    ((o.StartPoint == obj.StartPoint &&
                    o.EndPoint == obj.EndPoint) ||
                    (o.StartPoint == obj.EndPoint &&
                    o.EndPoint == obj.StartPoint)));

                if (checkObj != null && checkObj.ID != updateObj.ID) return 1;

                updateObj.TransCompID = obj.TransCompID;
                updateObj.StartPoint = obj.StartPoint;
                updateObj.LastestUpdated = DateTime.Now;
                updateObj.EndPoint = obj.EndPoint;
                updateObj.UpdatedBy = obj.UpdatedBy;

                DB.SubmitChanges();

                return 0;
            }
            catch (Exception ex)
            {
                return int.MinValue;
            }
        }

        public int TransportCompany_Route_Create(TransportCompany_Route obj)
        {
            try
            {
                TransportCompany_Route checkObj = DB.TransportCompany_Routes.FirstOrDefault(o =>
                    !o.IsDeleted &&
                    o.TransCompID == obj.TransCompID &&
                    ((o.StartPoint == obj.StartPoint &&
                    o.EndPoint == obj.EndPoint) ||
                    (o.StartPoint == obj.EndPoint &&
                    o.EndPoint == obj.StartPoint)));

                if (checkObj != null) return 1;

                DB.TransportCompany_Routes.InsertOnSubmit(obj);
                DB.SubmitChanges();

                return 0;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public int TransportCompany_Route_CheckRoute(int comp, int start, int end)
        {
            try
            {
                TransportCompany_Route checkObj = DB.TransportCompany_Routes.FirstOrDefault(o =>
                    !o.IsDeleted &&
                    o.TransCompID == comp &&
                    ((o.StartPoint == start &&
                    o.EndPoint == end) ||
                    (o.StartPoint == end &&
                    o.EndPoint == start)));

                if (checkObj == null) return 0;

                return checkObj.ID;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public List<TransportCompany_Route> TransportCompany_Route_Gets(int pageIndex, int pageSize, out int totalPages)
        {
            totalPages = 0;
            try
            {
                var all = DB.TransportCompany_Routes.Where(o => !o.IsDeleted);
                if (all.Count() == 0) return null;

                int startIndex = pageIndex * pageSize;
                List<TransportCompany_Route> res = all.OrderBy(o => o.TransportCompany.Name).ThenBy(o => o.TransportPlace.Name).ThenBy(o => o.TransportPlace1.Name).Skip(startIndex).Take(pageSize).ToList();

                if (res.Count == 0) return null;

                int div = all.Count() / pageSize;
                int mod = all.Count() % pageSize;
                totalPages = div + (mod > 0 ? 1 : 0);

                return res;
            }
            catch
            {
                return null;
            }
        }

        public List<eRoute> TransportCompany_Route_GetEs(int pageIndex, int pageSize, out int totalPages)
        {
            totalPages = 0;
            try
            {
                var all = TransportCompany_Route_Gets(pageIndex, pageSize, out totalPages);
                if (all == null) return null;

                List<eRoute> result = new List<eRoute>();
                foreach (TransportCompany_Route obj in all)
                    result.Add(TransportCompany_Route_Entity(obj));

                return result;
            }
            catch
            {
                return null;
            }
        }

        public List<TransportCompany_Route> TransportCompany_Route_Gets()
        {
            try
            {
                var all = DB.TransportCompany_Routes.Where(o => !o.IsDeleted);
                if (all.Count() == 0) return null;

                return all.OrderBy(o => o.TransportCompany.Name).ThenBy(o => o.TransportPlace.Name).ThenBy(o => o.TransportPlace1.Name).ToList();
            }
            catch
            {
                return null;
            }
        }

        public List<eRoute> TransportCompany_Route_GetEs()
        {
            try
            {
                var all = TransportCompany_Route_Gets();
                if (all == null) return null;

                List<eRoute> result = new List<eRoute>();
                foreach (TransportCompany_Route obj in all)
                    result.Add(TransportCompany_Route_Entity(obj));

                return result;
            }
            catch
            {
                return null;
            }
        }

        public TransportCompany_Route TransportCompany_Route_Get(int id)
        {
            try
            {
                return DB.TransportCompany_Routes.FirstOrDefault(o =>
                    o.ID == id);
            }
            catch
            {
                return null;
            }
        }

        public eRoute TransportCompany_Route_GetE(int id)
        {
            try
            {
                return TransportCompany_Route_Entity(TransportCompany_Route_Get(id));
            }
            catch
            {
                return null;
            }
        }

        public eRoute TransportCompany_Route_Entity(TransportCompany_Route obj, bool includeEntity = true)
        {
            try
            {
                if (obj == null) return null;

                return new eRoute()
                {
                    EndPoint = obj.EndPoint,
                    ID = obj.ID,
                    StartPoint = obj.StartPoint,
                    TransCompID = obj.TransCompID,

                    IsDeleted = obj.IsDeleted,
                    LastestUpdate = obj.LastestUpdated,
                    sLastestUpdate = obj.LastestUpdated.ToString(GlobalValues.DateFormat_VN),
                    UpdatedBy = Sys_User_GetE(obj.UpdatedBy),
                    TransportCompany = !includeEntity ? null : TransportCompany_GetE(obj.TransCompID),
                    PointStart = //!includeEntity ? null : 
                        TransportPlace_GetE(obj.StartPoint),
                    PointEnd = //!includeEntity ? null : 
                        TransportPlace_GetE(obj.EndPoint),
                };
            }
            catch
            {
                return null;
            }
        }

        #endregion

        #region QuotationRoutes

        public List<Quotation_Route> Quotation_Route_Gets(eJobFilter_Quotation filter)
        {
            try
            {
                var all = DB.Quotation_Routes.Where(o => !o.IsDeleted &&
                    //o.Expire_End >= DateTime.Now.AddDays(-1) &&
                    o.VehicleLoadID == filter.LoadID &&
                    ((o.TransportCompany_Route.StartPoint == filter.PlaceStart && o.TransportCompany_Route.EndPoint == filter.PlaceEnd) ||
                    (o.TransportCompany_Route.StartPoint == filter.PlaceEnd && o.TransportCompany_Route.EndPoint == filter.PlaceStart)));

                if (all.Count() == 0) return null;

                return all.OrderByDescending(o => o.Expire_Start).ThenByDescending(o => o.Expire_End).ToList();
            }
            catch
            {
                return null;
            }
        }

        public List<eQuotationRoute> Quotation_Route_GetEs(eJobFilter_Quotation filter)
        {
            try
            {
                var all = Quotation_Route_Gets(filter);
                if (all == null) return null;

                List<eQuotationRoute> result = new List<eQuotationRoute>();
                foreach (Quotation_Route obj in all)
                    result.Add(Quotation_Route_Entity(obj));

                return result;
            }
            catch
            {
                return null;
            }
        }

        public bool Quotation_Route_Delete(Quotation_Route route)
        {
            try
            {
                Quotation_Route obj = DB.Quotation_Routes.FirstOrDefault(o => o.ID == route.ID);
                if (obj == null) return false;

                obj.IsDeleted = true;
                obj.LastestUpdated = DateTime.Now;
                obj.UpdatedBy = route.UpdatedBy;
                DB.SubmitChanges();

                return true;
            }
            catch
            {
                return false;
            }
        }

        public int Quotation_Route_Update(Quotation_Route obj)
        {
            try
            {
                if (obj.Expire_End < DateTime.Now) return 1;

                Quotation_Route updateObj = DB.Quotation_Routes.FirstOrDefault(o => o.ID == obj.ID);
                if (updateObj == null) return 3;

                updateObj.Expire_End = obj.Expire_End;
                updateObj.Expire_Start = obj.Expire_Start;
                updateObj.LastestUpdated = DateTime.Now;
                updateObj.IsSamePrice = obj.IsSamePrice;
                updateObj.UpdatedBy = obj.UpdatedBy;
                updateObj.IsUSD = obj.IsUSD;
                updateObj.Price = obj.Price;
                updateObj.Price_RoundedTrip = obj.Price_RoundedTrip;
                updateObj.RouteID = obj.RouteID;
                updateObj.VehicleLoadID = obj.VehicleLoadID;

                DB.SubmitChanges();

                return 0;
            }
            catch (Exception ex)
            {
                return int.MinValue;
            }
        }

        public int Quotation_Route_Create(Quotation_Route obj)
        {
            try
            {
                if (obj.Expire_End < DateTime.Now) return 1;

                DB.Quotation_Routes.InsertOnSubmit(obj);
                DB.SubmitChanges();

                return 0;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public List<Quotation_Route> Quotation_Route_Gets(int pageIndex, int pageSize, out int totalPages)
        {
            totalPages = 0;
            try
            {
                var all = DB.Quotation_Routes.Where(o => !o.IsDeleted);
                if (all.Count() == 0) return null;

                int startIndex = pageIndex * pageSize;
                List<Quotation_Route> res = all.OrderBy(o => o.TransportCompany_Route.TransportCompany.Name).ThenBy(o => o.TransportCompany_VehicleType_Load.TransportCompany_VehicleType.VehicleType.Name).ThenBy(o => o.TransportCompany_VehicleType_Load.VehicleLoad.Name).ThenByDescending(o => o.Expire_Start).ThenByDescending(o => o.Expire_End).Skip(startIndex).Take(pageSize).ToList();

                if (res.Count == 0) return null;

                int div = all.Count() / pageSize;
                int mod = all.Count() % pageSize;
                totalPages = div + (mod > 0 ? 1 : 0);

                return res;
            }
            catch
            {
                return null;
            }
        }

        public List<eQuotationRoute> Quotation_Route_GetEs(int pageIndex, int pageSize, out int totalPages)
        {
            totalPages = 0;
            try
            {
                var all = Quotation_Route_Gets(pageIndex, pageSize, out totalPages);
                if (all == null) return null;

                List<eQuotationRoute> result = new List<eQuotationRoute>();
                foreach (Quotation_Route obj in all)
                    result.Add(Quotation_Route_Entity(obj));

                return result;
            }
            catch
            {
                return null;
            }
        }

        public List<Quotation_Route> Quotation_Route_Gets()
        {
            try
            {
                var all = DB.Quotation_Routes.Where(o => !o.IsDeleted);
                if (all.Count() == 0) return null;

                return all.OrderBy(o => o.TransportCompany_Route.TransportCompany.Name).ThenBy(o => o.TransportCompany_VehicleType_Load.TransportCompany_VehicleType.VehicleType.Name).ThenBy(o => o.TransportCompany_VehicleType_Load.VehicleLoad.Name).ThenByDescending(o => o.Expire_Start).ThenByDescending(o => o.Expire_End).ToList();
            }
            catch
            {
                return null;
            }
        }

        public List<eQuotationRoute> Quotation_Route_GetEs()
        {
            try
            {
                var all = Quotation_Route_Gets();
                if (all == null) return null;

                List<eQuotationRoute> result = new List<eQuotationRoute>();
                foreach (Quotation_Route obj in all)
                    result.Add(Quotation_Route_Entity(obj));

                return result;
            }
            catch
            {
                return null;
            }
        }

        public Quotation_Route Quotation_Route_Get(int id)
        {
            try
            {
                return DB.Quotation_Routes.FirstOrDefault(o =>
                    o.ID == id);
            }
            catch
            {
                return null;
            }
        }

        public eQuotationRoute Quotation_Route_GetE(int id)
        {
            try
            {
                return Quotation_Route_Entity(Quotation_Route_Get(id));
            }
            catch
            {
                return null;
            }
        }

        public eQuotationRoute Quotation_Route_Entity(Quotation_Route obj, bool includeEntity = true)
        {
            try
            {
                if (obj == null) return null;

                return new eQuotationRoute()
                {
                    Expire_End = obj.Expire_End,
                    Expire_Start = obj.Expire_Start,
                    ID = obj.ID,
                    IsSamePrice = obj.IsSamePrice,
                    IsUSD = obj.IsUSD,
                    Price = obj.Price,
                    Price_RoundedTrip = obj.Price_RoundedTrip,
                    RouteID = obj.RouteID,
                    VehicleLoadID = obj.VehicleLoadID,

                    IsDeleted = obj.IsDeleted,
                    LastestUpdate = obj.LastestUpdated,
                    sLastestUpdate = obj.LastestUpdated.ToString(GlobalValues.DateFormat_VN),
                    UpdatedBy = Sys_User_GetE(obj.UpdatedBy),
                    Load = TransportCompany_VehicleType_Load_Entity(obj.TransportCompany_VehicleType_Load),
                    Route = TransportCompany_Route_Entity(obj.TransportCompany_Route),
                    sExpireEnd = obj.Expire_End.ToString(GlobalValues.DateFormat_VN),
                    sExpireStart = obj.Expire_Start.ToString(GlobalValues.DateFormat_VN),
                };
            }
            catch
            {
                return null;
            }
        }

        #endregion

        #region CustomsProcess_FeeTypes

        public bool CustomsProcess_FeeType_Delete(CustomsProcess_FeeType CustomsProcess_FeeType)
        {
            try
            {
                CustomsProcess_FeeType obj = DB.CustomsProcess_FeeTypes.FirstOrDefault(o => o.ID == CustomsProcess_FeeType.ID);
                if (obj == null) return false;

                obj.IsDeleted = true;
                obj.LastestUpdated = DateTime.Now;
                obj.UpdatedBy = CustomsProcess_FeeType.UpdatedBy;
                DB.SubmitChanges();

                return true;
            }
            catch
            {
                return false;
            }
        }

        public int CustomsProcess_FeeType_Update(CustomsProcess_FeeType obj)
        {
            try
            {
                CustomsProcess_FeeType updateObj = DB.CustomsProcess_FeeTypes.FirstOrDefault(o => o.ID == obj.ID);
                if (updateObj == null) return 3;

                CustomsProcess_FeeType checkObj = DB.CustomsProcess_FeeTypes.FirstOrDefault(o => !o.IsDeleted && o.Name.ToLower() == obj.Name.ToLower());
                if (checkObj != null && checkObj.ID != updateObj.ID) return 1;

                updateObj.Description = obj.Description;
                updateObj.LastestUpdated = DateTime.Now;
                updateObj.Name = obj.Name;
                updateObj.ProcessOneTime = obj.ProcessOneTime;
                updateObj.UpdatedBy = obj.UpdatedBy;

                DB.SubmitChanges();

                return 0;
            }
            catch (Exception ex)
            {
                return int.MinValue;
            }
        }

        public int CustomsProcess_FeeType_Create(CustomsProcess_FeeType obj)
        {
            try
            {
                CustomsProcess_FeeType checkObj = DB.CustomsProcess_FeeTypes.FirstOrDefault(o => !o.IsDeleted && o.Name.ToLower() == obj.Name.ToLower());
                if (checkObj != null) return 1;

                DB.CustomsProcess_FeeTypes.InsertOnSubmit(obj);
                DB.SubmitChanges();

                return 0;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public int CustomsProcess_FeeType_CheckName(string name)
        {
            try
            {
                CustomsProcess_FeeType obj = DB.CustomsProcess_FeeTypes.FirstOrDefault(o => !o.IsDeleted && o.Name.ToLower() == name.ToLower());
                if (obj == null) return 0;

                return obj.ID;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public List<CustomsProcess_FeeType> CustomsProcess_FeeType_Gets(int pageIndex, int pageSize, out int totalPages)
        {
            totalPages = 0;
            try
            {
                var all = DB.CustomsProcess_FeeTypes.Where(o => !o.IsDeleted);
                if (all.Count() == 0) return null;

                int startIndex = pageIndex * pageSize;
                List<CustomsProcess_FeeType> res = all.OrderBy(o => o.Name).Skip(startIndex).Take(pageSize).ToList();

                if (res.Count == 0) return null;

                int div = all.Count() / pageSize;
                int mod = all.Count() % pageSize;
                totalPages = div + (mod > 0 ? 1 : 0);

                return res;
            }
            catch
            {
                return null;
            }
        }

        public List<eCustomsProcess_FeeType> CustomsProcess_FeeType_GetEs(int pageIndex, int pageSize, out int totalPages)
        {
            totalPages = 0;
            try
            {
                var all = CustomsProcess_FeeType_Gets(pageIndex, pageSize, out totalPages);
                if (all == null) return null;

                List<eCustomsProcess_FeeType> result = new List<eCustomsProcess_FeeType>();
                foreach (CustomsProcess_FeeType obj in all)
                    result.Add(CustomsProcess_FeeType_Entity(obj));

                return result;
            }
            catch
            {
                return null;
            }
        }

        public List<CustomsProcess_FeeType> CustomsProcess_FeeType_Gets(bool isLoadDeleted = false)
        {
            try
            {
                var all =
                    isLoadDeleted ? DB.CustomsProcess_FeeTypes :
                    DB.CustomsProcess_FeeTypes.Where(o => !o.IsDeleted);

                if (all.Count() == 0) return null;

                return all.OrderBy(o => o.Name).ToList();
            }
            catch
            {
                return null;
            }
        }

        public List<eCustomsProcess_FeeType> CustomsProcess_FeeType_GetEs(bool isLoadDeleted = false)
        {
            try
            {
                var all = CustomsProcess_FeeType_Gets(isLoadDeleted);
                if (all == null) return null;

                List<eCustomsProcess_FeeType> result = new List<eCustomsProcess_FeeType>();
                foreach (CustomsProcess_FeeType obj in all)
                    result.Add(CustomsProcess_FeeType_Entity(obj));

                return result;
            }
            catch
            {
                return null;
            }
        }

        public CustomsProcess_FeeType CustomsProcess_FeeType_Get(int id)
        {
            try
            {
                return DB.CustomsProcess_FeeTypes.FirstOrDefault(o =>
                    o.ID == id);
            }
            catch
            {
                return null;
            }
        }

        public eCustomsProcess_FeeType CustomsProcess_FeeType_GetE(int id)
        {
            try
            {
                return CustomsProcess_FeeType_Entity(CustomsProcess_FeeType_Get(id));
            }
            catch
            {
                return null;
            }
        }

        public eCustomsProcess_FeeType CustomsProcess_FeeType_Entity(CustomsProcess_FeeType obj)
        {
            try
            {
                if (obj == null) return null;

                return new eCustomsProcess_FeeType()
                {
                    Description = obj.Description,
                    ID = obj.ID,
                    IsDeleted = obj.IsDeleted,
                    LastestUpdate = obj.LastestUpdated,
                    Name = obj.Name,
                    ProcessOneTime = obj.ProcessOneTime,
                    sLastestUpdate = obj.LastestUpdated.ToString(GlobalValues.DateFormat_VN),
                    UpdatedBy = Sys_User_GetE(obj.UpdatedBy)
                };
            }
            catch
            {
                return null;
            }
        }

        #endregion

        #region Quotation_CustomsProcess

        public eCustomsProcess_FeeDetail CustomsProcess_FeeDetail_Entity(CustomsProcess_FeeDetail obj, bool includedRelation = true)
        {
            try
            {
                if (obj == null) return null;

                return new eCustomsProcess_FeeDetail()
                {
                    FeeTypeID = obj.FeeTypeID,
                    Price = obj.Price,
                    QuotationID = obj.QuotationID,
                    ID = obj.ID,
                    IsDeleted = obj.IsDeleted,
                    LastestUpdate = obj.LastestUpdated,
                    sLastestUpdate = obj.LastestUpdated.ToString(GlobalValues.DateFormat_VN),
                    UpdatedBy = Sys_User_GetE(obj.UpdatedBy),
                    FeeType = CustomsProcess_FeeType_GetE(obj.FeeTypeID),
                    Quotation = !includedRelation ? null : Quotation_CustomsProcess_GetE(obj.QuotationID)
                };
            }
            catch
            {
                return null;
            }
        }

        public bool Quotation_CustomsProcess_Delete(Quotation_CustomsProcess Quotation_CustomsProcess)
        {
            try
            {
                Quotation_CustomsProcess obj = DB.Quotation_CustomsProcesses.FirstOrDefault(o => o.ID == Quotation_CustomsProcess.ID);
                if (obj == null) return false;

                obj.IsDeleted = true;
                obj.LastestUpdated = DateTime.Now;
                obj.UpdatedBy = Quotation_CustomsProcess.UpdatedBy;
                DB.SubmitChanges();

                return true;
            }
            catch
            {
                return false;
            }
        }

        public int Quotation_CustomsProcess_Update(Quotation_CustomsProcess obj, List<aCustomsProcess_FeeType> feeDetails = null)
        {
            try
            {
                Quotation_CustomsProcess updateObj = DB.Quotation_CustomsProcesses.FirstOrDefault(o => o.ID == obj.ID);
                if (updateObj == null) return 3;

                updateObj.ExpireFrom = obj.ExpireFrom;
                updateObj.IsUSD = obj.IsUSD;
                updateObj.LastestUpdated = DateTime.Now;
                updateObj.UpdatedBy = obj.UpdatedBy;

                DB.SubmitChanges();

                Quotation_CustomsProcess_UpdateFeeDetails(obj, feeDetails);

                return 0;
            }
            catch (Exception ex)
            {
                return int.MinValue;
            }
        }

        public int Quotation_CustomsProcess_Create(Quotation_CustomsProcess obj, List<aCustomsProcess_FeeType> feeDetails = null)
        {
            try
            {
                DB.Quotation_CustomsProcesses.InsertOnSubmit(obj);
                DB.SubmitChanges();

                Quotation_CustomsProcess_UpdateFeeDetails(obj, feeDetails);

                return 0;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public int Quotation_CustomsProcess_UpdateFeeDetails(Quotation_CustomsProcess obj, List<aCustomsProcess_FeeType> feeDetails)
        {
            try
            {
                if (obj == null) return 0;

                foreach (aCustomsProcess_FeeType detail in feeDetails)
                {
                    CustomsProcess_FeeDetail dbType = DB.CustomsProcess_FeeDetails.FirstOrDefault(o =>
                        o.FeeTypeID == detail.ID &&
                        o.QuotationID == obj.ID);

                    if (dbType == null)//Chưa có
                    {
                        dbType = new CustomsProcess_FeeDetail()
                        {
                            IsDeleted = false,
                            LastestUpdated = DateTime.Now,
                            QuotationID = obj.ID,
                            UpdatedBy = obj.UpdatedBy,
                            FeeTypeID = detail.ID,
                            Price = detail.Value,
                        };

                        DB.CustomsProcess_FeeDetails.InsertOnSubmit(dbType);
                        DB.SubmitChanges();
                    }
                    else //Đã có
                    {
                        dbType.Price = detail.Value;
                        dbType.LastestUpdated = DateTime.Now;
                        dbType.UpdatedBy = obj.UpdatedBy;
                        DB.SubmitChanges();
                    }
                }

                return 0;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public List<Quotation_CustomsProcess> Quotation_CustomsProcess_Gets(int pageIndex, int pageSize, out int totalPages)
        {
            totalPages = 0;
            try
            {
                var all = DB.Quotation_CustomsProcesses.Where(o => !o.IsDeleted);
                if (all.Count() == 0) return null;

                int startIndex = pageIndex * pageSize;
                List<Quotation_CustomsProcess> res = all.OrderByDescending(o => o.LastestUpdated).Skip(startIndex).Take(pageSize).ToList();

                if (res.Count == 0) return null;

                int div = all.Count() / pageSize;
                int mod = all.Count() % pageSize;
                totalPages = div + (mod > 0 ? 1 : 0);

                return res;
            }
            catch
            {
                return null;
            }
        }

        public List<eQuotation_CustomsProcess> Quotation_CustomsProcess_GetEs(int pageIndex, int pageSize, out int totalPages)
        {
            totalPages = 0;
            try
            {
                var all = Quotation_CustomsProcess_Gets(pageIndex, pageSize, out totalPages);
                if (all == null) return null;

                List<eQuotation_CustomsProcess> result = new List<eQuotation_CustomsProcess>();
                foreach (Quotation_CustomsProcess obj in all)
                    result.Add(Quotation_CustomsProcess_Entity(obj));

                return result;
            }
            catch
            {
                return null;
            }
        }

        public List<Quotation_CustomsProcess> Quotation_CustomsProcess_Gets()
        {
            try
            {
                var all = DB.Quotation_CustomsProcesses.Where(o => !o.IsDeleted);
                if (all.Count() == 0) return null;

                return all.OrderByDescending(o => o.ExpireFrom).ToList();
            }
            catch
            {
                return null;
            }
        }

        public List<eQuotation_CustomsProcess> Quotation_CustomsProcess_GetEs()
        {
            try
            {
                var all = Quotation_CustomsProcess_Gets();
                if (all == null) return null;

                List<eQuotation_CustomsProcess> result = new List<eQuotation_CustomsProcess>();
                foreach (Quotation_CustomsProcess obj in all)
                    result.Add(Quotation_CustomsProcess_Entity(obj));

                return result;
            }
            catch
            {
                return null;
            }
        }

        public Quotation_CustomsProcess Quotation_CustomsProcess_Get(int id)
        {
            try
            {
                return DB.Quotation_CustomsProcesses.FirstOrDefault(o =>
                    o.ID == id);
            }
            catch
            {
                return null;
            }
        }

        public eQuotation_CustomsProcess Quotation_CustomsProcess_GetE(int id)
        {
            try
            {
                return Quotation_CustomsProcess_Entity(Quotation_CustomsProcess_Get(id));
            }
            catch
            {
                return null;
            }
        }

        public eQuotation_CustomsProcess Quotation_CustomsProcess_Entity(Quotation_CustomsProcess obj)
        {
            try
            {
                if (obj == null) return null;
                List<eCustomsProcess_FeeDetail> feeTypes = new List<eCustomsProcess_FeeDetail>();
                if (obj.CustomsProcess_FeeDetails.Count() > 0)
                {
                    foreach (CustomsProcess_FeeDetail type in obj.CustomsProcess_FeeDetails)
                        feeTypes.Add(CustomsProcess_FeeDetail_Entity(type, false));
                }

                return new eQuotation_CustomsProcess()
                {
                    ExpireFrom = obj.ExpireFrom,
                    ID = obj.ID,
                    IsDeleted = obj.IsDeleted,
                    IsUSD = obj.IsUSD,
                    LastestUpdate = obj.LastestUpdated,
                    sExpireFrom = obj.ExpireFrom.ToString(GlobalValues.DateFormat_VN),
                    sLastestUpdate = obj.LastestUpdated.ToString(GlobalValues.DateFormat_VN),
                    UpdatedBy = Sys_User_GetE(obj.UpdatedBy),
                    FeeDetails = feeTypes,
                };
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        #endregion

        #region Customers

        public bool Customer_Delete(Customer customer)
        {
            try
            {
                Customer obj = DB.Customers.FirstOrDefault(o => o.ID == customer.ID);
                if (obj == null) return false;

                obj.IsDeleted = true;
                obj.LastestUpdated = DateTime.Now;
                obj.UpdatedBy = customer.UpdatedBy;
                DB.SubmitChanges();

                return true;
            }
            catch
            {
                return false;
            }
        }

        public int Customer_Update(Customer obj)
        {
            try
            {
                Customer updateObj = DB.Customers.FirstOrDefault(o => o.ID == obj.ID);
                if (updateObj == null) return 3;

                Customer checkObj = DB.Customers.FirstOrDefault(o => !o.IsDeleted && o.Name.ToLower() == obj.Name.ToLower());
                if (checkObj != null && checkObj.ID != updateObj.ID) return 1;

                updateObj.Email = obj.Email;
                updateObj.PhoneNumber = obj.PhoneNumber;
                updateObj.Address = obj.Address;
                updateObj.LastestUpdated = DateTime.Now;
                updateObj.Name = obj.Name;
                updateObj.UpdatedBy = obj.UpdatedBy;

                DB.SubmitChanges();

                return 0;
            }
            catch (Exception ex)
            {
                return int.MinValue;
            }
        }

        public int Customer_Create(Customer obj)
        {
            try
            {
                Customer checkObj = DB.Customers.FirstOrDefault(o => !o.IsDeleted && o.Name.ToLower() == obj.Name.ToLower());
                if (checkObj != null) return 1;

                obj.Prepaids = 0;

                DB.Customers.InsertOnSubmit(obj);
                DB.SubmitChanges();

                return 0;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public int Customer_CheckName(string name)
        {
            try
            {
                Customer obj = DB.Customers.FirstOrDefault(o => !o.IsDeleted && o.Name.ToLower() == name.ToLower());
                if (obj == null) return 0;

                return obj.ID;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public List<Customer> Customer_Gets(int pageIndex, int pageSize, out int totalPages)
        {
            totalPages = 0;
            try
            {
                var all = DB.Customers.Where(o => !o.IsDeleted);
                if (all.Count() == 0) return null;

                int startIndex = pageIndex * pageSize;
                List<Customer> res = all.OrderBy(o => o.Name).Skip(startIndex).Take(pageSize).ToList();

                if (res.Count == 0) return null;

                int div = all.Count() / pageSize;
                int mod = all.Count() % pageSize;
                totalPages = div + (mod > 0 ? 1 : 0);

                return res;
            }
            catch
            {
                return null;
            }
        }

        public List<eCustomer> Customer_GetEs(int pageIndex, int pageSize, out int totalPages)
        {
            totalPages = 0;
            try
            {
                var all = Customer_Gets(pageIndex, pageSize, out totalPages);
                if (all == null) return null;

                List<eCustomer> result = new List<eCustomer>();
                foreach (Customer obj in all)
                    result.Add(Customer_Entity(obj));

                return result;
            }
            catch
            {
                return null;
            }
        }

        public List<Customer> Customer_Gets()
        {
            try
            {
                var all = DB.Customers.Where(o => !o.IsDeleted);
                if (all.Count() == 0) return null;

                return all.OrderBy(o => o.Name).ToList();
            }
            catch
            {
                return null;
            }
        }

        public List<eCustomer> Customer_GetEs()
        {
            try
            {
                var all = Customer_Gets();
                if (all == null) return null;

                List<eCustomer> result = new List<eCustomer>();
                foreach (Customer obj in all)
                    result.Add(Customer_Entity(obj));

                return result;
            }
            catch
            {
                return null;
            }
        }

        public Customer Customer_Get(int id)
        {
            try
            {
                return DB.Customers.FirstOrDefault(o =>
                    o.ID == id);
            }
            catch
            {
                return null;
            }
        }

        public eCustomer Customer_GetE(int id)
        {
            try
            {
                return Customer_Entity(Customer_Get(id));
            }
            catch
            {
                return null;
            }
        }

        public eCustomer Customer_Entity(Customer obj)
        {
            try
            {
                if (obj == null) return null;

                return new eCustomer()
                {
                    Email = obj.Email,
                    PhoneNumber = obj.PhoneNumber,
                    Address = obj.Address,
                    ID = obj.ID,
                    IsDeleted = obj.IsDeleted,
                    LastestUpdate = obj.LastestUpdated,
                    Name = obj.Name,
                    sLastestUpdate = obj.LastestUpdated.ToString(GlobalValues.DateFormat_VN),
                    UpdatedBy = Sys_User_GetE(obj.UpdatedBy)
                };
            }
            catch
            {
                return null;
            }
        }

        #endregion

        #region Jobs

        public bool Job_Delete(Job job)
        {
            try
            {
                Job obj = DB.Jobs.FirstOrDefault(o => o.ID == job.ID);
                if (obj == null) return false;

                obj.IsDeleted = true;
                obj.LastestUpdated = DateTime.Now;
                obj.UpdatedBy = job.UpdatedBy;
                DB.SubmitChanges();

                return true;
            }
            catch
            {
                return false;
            }
        }

        public int Job_Update_Status(Job obj)
        {
            try
            {
                Job updateObj = DB.Jobs.FirstOrDefault(o => o.ID == obj.ID);
                if (updateObj == null) return 3;

                updateObj.IsConsigned = obj.IsConsigned;
                updateObj.ConsignedDate = obj.ConsignedDate;
                updateObj.IsInformTransportComp = obj.IsInformTransportComp;
                updateObj.IsPayedForTransportComp = obj.IsPayedForTransportComp;
                updateObj.LastestUpdated = DateTime.Now;
                updateObj.UpdatedBy = obj.UpdatedBy;

                DB.SubmitChanges();

                return 0;
            }
            catch (Exception ex)
            {
                return int.MinValue;
            }
        }

        public int Job_Update(Job obj)
        {
            try
            {
                Job updateObj = DB.Jobs.FirstOrDefault(o => o.ID == obj.ID);
                if (updateObj == null) return 3;

                Job checkObj = DB.Jobs.FirstOrDefault(o => !o.IsDeleted && o.JobID.ToLower() == obj.JobID.ToLower());
                if (checkObj != null && checkObj.ID != updateObj.ID) return 1;

                updateObj.Type = obj.Type;
                updateObj.JobID = obj.JobID;
                updateObj.InvoiceNO = obj.InvoiceNO;
                updateObj.BillLadingNO = obj.BillLadingNO;
                updateObj.TKHQNO = obj.TKHQNO;
                updateObj.CustomerID = obj.CustomerID;
                updateObj.LastestUpdated = DateTime.Now;
                updateObj.UpdatedBy = obj.UpdatedBy;

                DB.SubmitChanges();

                return 0;
            }
            catch (Exception ex)
            {
                return int.MinValue;
            }
        }

        public int Job_Create(ref Job obj)
        {
            try
            {
                string id = obj.JobID;
                Job checkObj = DB.Jobs.FirstOrDefault(o => !o.IsDeleted && o.JobID.ToLower() == id.ToLower());
                if (checkObj != null) return 1;

                obj.AttachedFiles = string.Empty;
                obj.ConsignedDate = DateTime.MaxValue;
                obj.CustomerPrepaids = 0;
                obj.IsConsigned = false;
                obj.IsInformTransportComp = false;
                obj.IsPaidFromCustomer = false;
                obj.IsPayedForTransportComp = false;
                obj.IsUrgent = false;
                obj.ProcessedDate = DateTime.Now;
                obj.Status = 0;
                obj.AgentPrepaids = 0;

                DB.Jobs.InsertOnSubmit(obj);
                DB.SubmitChanges();

                return 0;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public int Job_CheckJobID(string jobID)
        {
            try
            {
                Job obj = DB.Jobs.FirstOrDefault(o => !o.IsDeleted && o.JobID.ToLower() == jobID.ToLower());
                if (obj == null) return 0;

                return obj.ID;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public List<Job> Job_Gets(eJobFilter filter, int pageIndex, int pageSize, out int totalPages)
        {
            totalPages = 0;
            try
            {
                var all = DB.Jobs.Where(o => !o.IsDeleted);

                if (filter != null)
                {
                    if (!string.IsNullOrEmpty(filter.BillLadingNO))
                        all = all.Where(o => o.BillLadingNO.ToLower().IndexOf(filter.BillLadingNO.ToLower()) > -1);

                    if (!string.IsNullOrEmpty(filter.InvoiceNO))
                        all = all.Where(o => o.InvoiceNO.ToLower().IndexOf(filter.InvoiceNO.ToLower()) > -1);

                    if (!string.IsNullOrEmpty(filter.JobID))
                        all = all.Where(o => o.JobID.ToLower().IndexOf(filter.JobID.ToLower()) > -1);

                    if (!string.IsNullOrEmpty(filter.TKHQNO))
                        all = all.Where(o => o.TKHQNO.ToLower().IndexOf(filter.TKHQNO.ToLower()) > -1);

                    if (filter.Customer != -1)
                        all = all.Where(o => o.CustomerID == filter.Customer);

                    if (filter.InformTransComp != -1)
                        all = all.Where(o => o.IsInformTransportComp == (filter.InformTransComp == 1));

                    if (filter.IsPaidCustomer != -1)
                        all = all.Where(o => o.IsPaidFromCustomer == (filter.IsPaidCustomer == 1));

                    if (filter.IsPaidTransComp != -1)
                        all = all.Where(o => o.IsPayedForTransportComp == (filter.IsPaidTransComp == 1));

                    if (filter.Status != -1)
                        all = all.Where(o => o.Status == filter.Status);

                    if (filter.Type != -1)
                        all = all.Where(o => o.Type == filter.Type);
                }

                if (all.Count() == 0) return null;

                int startIndex = pageIndex * pageSize;
                List<Job> res = all.OrderByDescending(o => o.ProcessedDate).Skip(startIndex).Take(pageSize).ToList();

                if (res.Count == 0) return null;

                int div = all.Count() / pageSize;
                int mod = all.Count() % pageSize;
                totalPages = div + (mod > 0 ? 1 : 0);

                return res;
            }
            catch
            {
                return null;
            }
        }

        public List<eJob> Job_GetEs(eJobFilter filter, int pageIndex, int pageSize, out int totalPages)
        {
            totalPages = 0;
            try
            {
                var all = Job_Gets(filter, pageIndex, pageSize, out totalPages);
                if (all == null) return null;

                List<eJob> result = new List<eJob>();
                foreach (Job obj in all)
                    result.Add(Job_Entity(obj));

                return result;
            }
            catch
            {
                return null;
            }
        }

        public List<Job> Job_Gets()
        {
            try
            {
                var all = DB.Jobs.Where(o => !o.IsDeleted);
                if (all.Count() == 0) return null;

                return all.OrderByDescending(o => o.ProcessedDate).ToList();
            }
            catch
            {
                return null;
            }
        }

        public List<eJob> Job_GetEs()
        {
            try
            {
                var all = Job_Gets();
                if (all == null) return null;

                List<eJob> result = new List<eJob>();
                foreach (Job obj in all)
                    result.Add(Job_Entity(obj));

                return result;
            }
            catch
            {
                return null;
            }
        }

        public Job Job_Get(int id)
        {
            try
            {
                return DB.Jobs.FirstOrDefault(o =>
                    o.ID == id);
            }
            catch
            {
                return null;
            }
        }

        public eJob Job_GetE(int id)
        {
            try
            {
                return Job_Entity(Job_Get(id));
            }
            catch
            {
                return null;
            }
        }

        public Job Job_Get(string jobID)
        {
            try
            {
                return DB.Jobs.FirstOrDefault(o =>
                    !o.IsDeleted &&
                    o.JobID.ToLower().Trim() == jobID.ToLower().Trim());
            }
            catch
            {
                return null;
            }
        }

        public eJob Job_GetE(string jobID)
        {
            try
            {
                return Job_Entity(Job_Get(jobID));
            }
            catch
            {
                return null;
            }
        }

        public eJob Job_Entity(Job obj)
        {
            try
            {
                if (obj == null) return null;

                var routes = obj.Job_QuotationRoutes.Where(o => !o.IsDeleted);
                List<eJob_QuotationRoute> quotationRoutes = new List<eJob_QuotationRoute>();
                foreach (Job_QuotationRoute route in routes)
                    quotationRoutes.Add(Job_QuotationRoute_Entity(route));

                return new eJob()
                {
                    AttachedFiles = obj.AttachedFiles,
                    BillLadingNO = obj.BillLadingNO,
                    ConsignedDate = obj.ConsignedDate,
                    CustomerID = obj.CustomerID == null ? int.MinValue : (int)obj.CustomerID,
                    CustomerPrepaids = obj.CustomerPrepaids,
                    ID = obj.ID,
                    InvoiceNO = obj.InvoiceNO,
                    IsConsigned = obj.IsConsigned,
                    IsInformTransportComp = obj.IsInformTransportComp,
                    IsPaidFromCustomer = obj.IsPaidFromCustomer,
                    IsPayedForTransportComp = obj.IsPayedForTransportComp,
                    IsUrgent = obj.IsUrgent,
                    JobID = obj.JobID,
                    ProcessedDate = obj.ProcessedDate,
                    Status = obj.Status,
                    TKHQNO = obj.TKHQNO,
                    Type = obj.Type,
                    Quotation_CustomProcID = obj.Quotation_CustomProcID == null ? int.MinValue : (int)obj.Quotation_CustomProcID,
                    AgentPrepaids = obj.AgentPrepaids,
                    Total_Customs_In = obj.Total_Customs_In,
                    Total_Customs_Out = obj.Total_Customs_Out,
                    Total_In = obj.Total_In,
                    Total_Out = obj.Total_Out,
                    Total_Transport_In = obj.Total_Transport_In,
                    Total_Transport_Out = obj.Total_Transport_Out,

                    IsDeleted = obj.IsDeleted,
                    LastestUpdate = obj.LastestUpdated,
                    sLastestUpdate = obj.LastestUpdated.ToString(GlobalValues.DateFormat_VN),
                    UpdatedBy = Sys_User_GetE(obj.UpdatedBy),
                    sConsignedTime = !obj.IsConsigned ? string.Empty : obj.ConsignedDate.ToString("HH:mm:ss"),
                    sConsignedDate = !obj.IsConsigned ? string.Empty : obj.ConsignedDate.ToString(GlobalValues.DateFormat_VN),
                    sProcessedDate = obj.ProcessedDate.ToString(GlobalValues.DateFormat_VN),
                    sStatus = GlobalValues.JobStatus.FirstOrDefault(o => o.ID == obj.Status).Name,
                    sType = GlobalValues.JobTypes.FirstOrDefault(o => o.ID == obj.Type).Name,
                    Customer = obj.CustomerID == null ? null : Customer_GetE((int)obj.CustomerID),
                    Routes = quotationRoutes.Count == 0 ? null : quotationRoutes,
                };
            }
            catch
            {
                return null;
            }
        }

        public void Job_CalculateProfit(int jobid)
        {
            try
            {
                Job job = Job_Get(jobid);
                if (job == null) return;

                Job_CalculateProfit_QuotationRoutes(job);
            }
            catch
            {
                return;
            }
        }

        private void Job_CalculateProfit_QuotationRoutes(Job job)
        {
            try
            {
                if (job == null) return;

                double total_in = 0;
                double total_out = 0;

                List<Job_QuotationRoute> routes = DB.Job_QuotationRoutes.Where(o => !o.IsDeleted && o.JobID == job.ID).ToList();
                if (routes != null)
                {
                    foreach (Job_QuotationRoute route in routes)
                    {
                        double compPrice = 0;
                        if (route.CustomerQuotation_Route.Quotation_Route.IsSamePrice)
                            compPrice = route.CustomerQuotation_Route.Quotation_Route.Price;
                        else
                        {
                            compPrice =
                                route.PlaceStart == route.CustomerQuotation_Route.Quotation_Route.TransportCompany_Route.StartPoint ?
                                route.CustomerQuotation_Route.Quotation_Route.Price :
                                route.CustomerQuotation_Route.Quotation_Route.Price_RoundedTrip;
                        }
                        route.Total_In = route.ExtraFee + route.CustomerQuotation_Route.Price * route.Quantity;
                        route.Total_Out = compPrice * route.Quantity - route.PromotionByTransComp;

                        DB.SubmitChanges();

                        total_in += route.Total_In;
                        total_out += route.Total_Out;
                    }

                    job.Total_Transport_In = total_in;
                    job.Total_Transport_Out = total_out;
                    DB.SubmitChanges();
                }
            }
            catch
            {
                return;
            }
        }

        #endregion

        #region CustomerQuotation_Route

        public int CustomerQuotation_Route_Update(CustomerQuotation_Route quotation)
        {
            try
            {
                CustomerQuotation_Route obj = DB.CustomerQuotation_Routes.FirstOrDefault(o => o.ID == quotation.ID);
                if (obj == null) return -1;

                obj.Expire_End = quotation.Expire_End;
                obj.Expire_Start = quotation.Expire_Start;
                obj.IsUSD = quotation.IsUSD;
                obj.LastestUpdated = DateTime.Now;
                obj.PlaceEnd = quotation.PlaceEnd;
                obj.PlaceStart = quotation.PlaceStart;
                obj.Price = quotation.Price;
                obj.QuotationID = quotation.QuotationID;
                obj.UpdatedBy = quotation.UpdatedBy;

                DB.CustomerQuotation_Routes.InsertOnSubmit(obj);
                DB.SubmitChanges();

                return 0;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public int CustomerQuotation_Route_Create(ref CustomerQuotation_Route obj)
        {
            try
            {
                DB.CustomerQuotation_Routes.InsertOnSubmit(obj);
                DB.SubmitChanges();

                return 0;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public CustomerQuotation_Route CustomerQuotation_Route_Get(int id)
        {
            try
            {
                return DB.CustomerQuotation_Routes.FirstOrDefault(o => !o.IsDeleted && o.ID == id);
            }
            catch
            {
                return null;
            }
        }

        public eCustomerQuotation_Route CustomerQuotation_Route_GetE(int id)
        {
            try
            {
                return CustomerQuotation_Route_Entity(CustomerQuotation_Route_Get(id));
            }
            catch
            {
                return null;
            }
        }

        public List<CustomerQuotation_Route> CustomerQuotation_Route_Gets(eJobFilter_Quotation filter)
        {
            try
            {
                var all = DB.CustomerQuotation_Routes.Where(o => !o.IsDeleted &&
                    //o.Expire_End >= DateTime.Now.AddDays(-1) &&
                    o.Quotation_Route.TransportCompany_VehicleType_Load.ID == filter.LoadID &&
                    ((o.PlaceStart == filter.PlaceStart && o.PlaceEnd == filter.PlaceEnd) ||
                    (o.PlaceStart == filter.PlaceEnd && o.PlaceEnd == filter.PlaceStart)));

                if (all.Count() == 0) return null;

                return all.OrderByDescending(o => o.Expire_Start).ThenByDescending(o => o.Expire_End).ToList();
            }
            catch
            {
                return null;
            }
        }

        public List<eCustomerQuotation_Route> CustomerQuotation_Route_GetEs(eJobFilter_Quotation filter)
        {
            try
            {
                var all = CustomerQuotation_Route_Gets(filter);
                if (all == null) return null;

                List<eCustomerQuotation_Route> result = new List<eCustomerQuotation_Route>();
                foreach (CustomerQuotation_Route obj in all)
                    result.Add(CustomerQuotation_Route_Entity(obj));

                return result;
            }
            catch
            {
                return null;
            }
        }

        public eCustomerQuotation_Route CustomerQuotation_Route_Entity(CustomerQuotation_Route obj, bool includeEntity = true)
        {
            try
            {
                if (obj == null) return null;

                return new eCustomerQuotation_Route()
                {
                    ID = obj.ID,
                    PlaceEnd = obj.PlaceEnd == null ? int.MinValue : (int)obj.PlaceEnd,
                    PlaceStart = obj.PlaceStart == null ? int.MinValue : (int)obj.PlaceStart,
                    CustomerID = obj.CustomerID,
                    Expire_End = obj.Expire_End,
                    Expire_Start = obj.Expire_Start,
                    IsUSD = obj.IsUSD,
                    QuotationID = obj.QuotationID,
                    Price = obj.Price,

                    IsDeleted = obj.IsDeleted,
                    LastestUpdate = obj.LastestUpdated,
                    sLastestUpdate = obj.LastestUpdated.ToString(GlobalValues.DateFormat_VN),
                    UpdatedBy = Sys_User_GetE(obj.UpdatedBy),
                    sExpireEnd = obj.Expire_End.ToString(GlobalValues.DateFormat_VN),
                    sExpireStart = obj.Expire_Start.ToString(GlobalValues.DateFormat_VN),
                };
            }
            catch
            {
                return null;
            }
        }

        #endregion

        #region CustomerQuotation_Customs

        public List<CustomerQuotation_Custom> CustomerQuotation_Custom_Gets(eCustomerQuotation_Custom_Filter filter)
        {
            try
            {
                var all = DB.CustomerQuotation_Customs.Where(o => !o.IsDeleted &&
                    o.CustomerID == filter.CustomerID);
                if (all.Count() == 0) return null;

                return all.OrderByDescending(o => o.LastestUpdated).ToList();
            }
            catch
            {
                return null;
            }
        }

        public List<eCustomerQuotation_Custom> CustomerQuotation_Custom_GetEs(eCustomerQuotation_Custom_Filter filter)
        {
            try
            {
                var all = CustomerQuotation_Custom_Gets(filter);
                if (all == null) return null;

                List<eCustomerQuotation_Custom> result = new List<eCustomerQuotation_Custom>();
                foreach (CustomerQuotation_Custom obj in all)
                    result.Add(CustomerQuotation_Custom_Entity(obj));

                return result;
            }
            catch
            {
                return null;
            }
        }

        private eCustomerQuotation_Custom CustomerQuotation_Custom_Entity(CustomerQuotation_Custom obj)
        {
            try
            {
                if (obj == null) return null;

                return new eCustomerQuotation_Custom()
                {
                    CustomerID = obj.CustomerID,
                    DecreasePercentFromSecondCont = obj.DecreasePercentFromSecondCont,
                    Expire_End = obj.Expire_End,
                    Expire_Start = obj.Expire_Start,
                    ID = obj.ID,
                    IsDeleted = obj.IsDeleted,
                    IsUSD = obj.IsUSD,
                    LastestUpdate = obj.LastestUpdated,
                    QuotationID = obj.QuotationID,
                    Total_In = obj.Total_In,
                    Total_Out = obj.Total_Out,
                    USDRate = obj.USDRate,

                    UpdatedBy = Sys_User_GetE(obj.UpdatedBy),
                    sLastestUpdate = obj.LastestUpdated.ToString(GlobalValues.DateFormat_VN),
                    sExpireEnd = obj.Expire_End.ToString(GlobalValues.DateFormat_VN),
                    sExpireStart = obj.Expire_Start.ToString(GlobalValues.DateFormat_VN),
                };
            }
            catch
            {
                return null;
            }
        }


        #endregion

        #region Job_QuotationRoute

        public int Job_QuotationRoute_Update(Job_QuotationRoute route)
        {
            try
            {
                Job_QuotationRoute obj = DB.Job_QuotationRoutes.FirstOrDefault(o => o.ID == route.ID);
                if (obj == null) return -1;

                obj.Description = route.Description;
                obj.DriverPhoneNumber = route.DriverPhoneNumber;
                obj.ExtraFee = route.ExtraFee;
                obj.LastestUpdate = DateTime.Now;
                obj.Loads = route.Loads;
                obj.PlaceEnd = route.PlaceEnd;
                obj.PlaceStart = route.PlaceStart;
                obj.PromotionByTransComp = route.PromotionByTransComp;
                obj.Quantity = route.Quantity;
                obj.RouteID = route.RouteID;
                obj.UpdatedBy = route.UpdatedBy;
                obj.USDRate = route.USDRate;
                obj.VehicleNO = route.VehicleNO;

                DB.SubmitChanges();

                Job_CalculateProfit(obj.JobID);

                return 0;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public bool Job_QuotationRoute_Delete(Job_QuotationRoute job)
        {
            try
            {
                Job_QuotationRoute obj = DB.Job_QuotationRoutes.FirstOrDefault(o => o.ID == job.ID);
                if (obj == null) return false;

                obj.IsDeleted = true;
                obj.LastestUpdate = DateTime.Now;
                obj.UpdatedBy = job.UpdatedBy;
                DB.SubmitChanges();

                Job_CalculateProfit(job.JobID);

                return true;
            }
            catch
            {
                return false;
            }
        }

        public int Job_QuotationRoute_Create(ref Job_QuotationRoute obj)
        {
            try
            {
                DB.Job_QuotationRoutes.InsertOnSubmit(obj);
                DB.SubmitChanges();

                Job_CalculateProfit(obj.JobID);

                return 0;
            }
            catch
            {
                return int.MinValue;
            }
        }

        public Job_QuotationRoute Job_QuotationRoute_Get(int id)
        {
            try
            {
                return DB.Job_QuotationRoutes.FirstOrDefault(o => !o.IsDeleted && o.ID == id);
            }
            catch
            {
                return null;
            }
        }

        public eJob_QuotationRoute Job_QuotationRoute_GetE(int id)
        {
            try
            {
                return Job_QuotationRoute_Entity(Job_QuotationRoute_Get(id));
            }
            catch
            {
                return null;
            }
        }

        public List<Job_QuotationRoute> Job_QuotationRoute_Gets(int jobID)
        {
            try
            {
                var all = DB.Job_QuotationRoutes.Where(o => !o.IsDeleted &&
                    o.JobID == jobID);

                if (all.Count() == 0) return null;

                return all.OrderBy(o => o.ID).ToList();
            }
            catch
            {
                return null;
            }
        }

        public List<eJob_QuotationRoute> Job_QuotationRoute_GetEs(int jobID)
        {
            try
            {
                var all = Job_QuotationRoute_Gets(jobID);
                if (all == null) return null;

                List<eJob_QuotationRoute> result = new List<eJob_QuotationRoute>();
                foreach (Job_QuotationRoute obj in all)
                    result.Add(Job_QuotationRoute_Entity(obj));

                return result;
            }
            catch
            {
                return null;
            }
        }

        public eJob_QuotationRoute Job_QuotationRoute_Entity(Job_QuotationRoute obj, bool includeEntity = true)
        {
            try
            {
                if (obj == null) return null;

                TransportCompany_VehicleType_Load loadtype = obj.CustomerQuotation_Route.Quotation_Route.TransportCompany_VehicleType_Load;

                return new eJob_QuotationRoute()
                {
                    ID = obj.ID,
                    PlaceEnd = obj.PlaceEnd == null ? int.MinValue : (int)obj.PlaceEnd,
                    PlaceStart = obj.PlaceStart == null ? int.MinValue : (int)obj.PlaceStart,
                    Description = obj.Description,
                    DriverPhoneNumber = obj.DriverPhoneNumber,
                    ExtraFee = obj.ExtraFee,
                    JobID = obj.JobID,
                    Loads = obj.Loads,
                    PromotionByTransComp = obj.PromotionByTransComp,
                    Quantity = obj.Quantity,
                    RouteID = obj.RouteID,
                    Status = obj.Status,
                    Total_In = obj.Total_In,
                    Total_Out = obj.Total_Out,
                    USDRate = obj.USDRate,
                    VehicleNO = obj.VehicleNO,

                    IsDeleted = obj.IsDeleted,
                    LastestUpdate = obj.LastestUpdate,
                    sLastestUpdate = obj.LastestUpdate.ToString(GlobalValues.DateFormat_VN),
                    UpdatedBy = Sys_User_GetE(obj.UpdatedBy),
                    sExpireEnd = obj.CustomerQuotation_Route.Expire_End.ToString(GlobalValues.DateFormat_VN),
                    sExpireStart = obj.CustomerQuotation_Route.Expire_Start.ToString(GlobalValues.DateFormat_VN),
                    Price = obj.CustomerQuotation_Route.Price,
                    sStatus = GlobalValues.Job_QuotationRoute_Status.FirstOrDefault(o => o.ID == obj.Status).Name,
                    sPlaceEnd = TransportPlace_Get((int)obj.PlaceEnd).Name,
                    sPlaceStart = TransportPlace_Get((int)obj.PlaceStart).Name,
                    sVehicleTypeLoad = loadtype.TransportCompany_VehicleType.VehicleType.Name + "-" + loadtype.VehicleLoad.Name,
                    TransCompID = obj.CustomerQuotation_Route.Quotation_Route.TransportCompany_Route.TransCompID,
                    VehicleTypeID = obj.CustomerQuotation_Route.Quotation_Route.TransportCompany_VehicleType_Load.TransComp_VehicleTypeID,
                    VehicleLoadID = obj.CustomerQuotation_Route.Quotation_Route.TransportCompany_VehicleType_Load.ID,
                    QuotationCompID = obj.CustomerQuotation_Route.QuotationID,
                    QuotationCustomerID = obj.RouteID,
                };
            }
            catch
            {
                return null;
            }
        }

        #endregion
    }
}
