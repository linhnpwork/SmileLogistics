using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SmileLogistics.Web.bases;
using SmileLogistics.DAL;
using SmileLogistics.DAL.Helpers;
using SmileLogistics.DAL.Entities;

namespace SmileLogistics.Web.ajax.modules.systems
{
    public partial class sysroles : BasePage
    {
        private int CurrentPage = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            string mod = Request.Form["mod"];
            if (string.IsNullOrEmpty(mod))
                return;

            switch (mod.ToLower())
            {
                case "create":
                    Create();
                    break;
                case "loadlist":
                    LoadList();
                    break;
                case "edit":
                    Edit();
                    break;
                case "delete":
                    Delete();
                    break;
                case "permission-loadlist":
                    PermissionLoadListModules();
                    break;
                case "permission-save":
                    PermissionSaveChanges();
                    break;
            }
        }

        private void PermissionSaveChanges()
        {
            string postdata = Request.Form["data"];
            if (postdata == string.Empty)
            {
                DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                {
                    Data = null,
                    ErrorCode = -1,
                    Message = "Dữ liệu không hợp lệ",
                }));

                return;
            }

            dynamic data;
            try { data = JsonConvert.DeserializeObject(postdata); }
            catch { data = null; }

            if (data == null)
            {
                DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                {
                    Data = null,
                    ErrorCode = -2,
                    Message = "Dữ liệu không hợp lệ!",
                }));

                return;
            }

            using (DALTools dalTools = new DALTools())
            {
                int roleId = int.Parse(data.roleid.ToString());
                eSys_Role role = dalTools.Sys_Role_GetE(roleId);
                if (role == null)
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = -3,
                        Message = "Không thể truy xuất dữ liệu của Nhóm quyền!",
                    }));

                    return;
                }

                for (int i = 0; i < data.eSys_Modules.Count; i++)
                {
                    int eSys_ModuleId = int.Parse(data.eSys_Modules[i].eSys_Moduleid.ToString());
                    dalTools.Sys_Role_SetPermission(roleId, eSys_ModuleId, data.eSys_Modules[i].permissions.ToString());
                }
            }

            DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
            {
                Data = null,
                ErrorCode = 0,
                Message = "Cập nhật thành công!",
            }));
        }

        private void PermissionLoadListModules()
        {
            string sId = Request.Form["id"];
            if (string.IsNullOrEmpty(sId))
            {
                DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                {
                    Data = "Dữ liệu không hợp lệ!",
                    ErrorCode = -1,
                    Message = "Dữ liệu không hợp lệ",
                }));

                return;
            }

            int id = 0;
            try
            {
                id = int.Parse(sId);
            }
            catch
            {
                DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                {
                    Data = "Dữ liệu không hợp lệ!",
                    ErrorCode = -2,
                    Message = "Dữ liệu không hợp lệ",
                }));

                return;
            }

            using (DALTools dalTools = new DALTools())
            {
                eSys_Role role = dalTools.Sys_Role_GetE(id);
                if (role == null)
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = "Nhóm quyền không tồn tại!",
                        ErrorCode = -3,
                        Message = "RolesNULL",
                    }));

                    return;
                }

                List<eSys_Module> eSys_Modules = dalTools.Sys_Module_BuildTreeAllE(int.MinValue);
                if (eSys_Modules == null)
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = "Không thể truy xuất danh sách Chức năng hệ thống!",
                        ErrorCode = -4,
                        Message = "ModulesNULL",
                    }));

                    return;
                }

                string html = string.Empty;

                List<eSys_ModuleAction> sActions = ((IEnumerable<Sys_Module_Actions>)Enum.GetValues(typeof(Sys_Module_Actions))).Select(o => new eSys_ModuleAction() { ID = (int)o, Name = o.ToString() }).ToList();
                bool allRowChecked = true;
                foreach (eSys_Module eSys_Module in eSys_Modules)
                {
                    string levelSep = string.Empty;
                    for (int j = 0; j < eSys_Module.Level; j++)
                        levelSep += "---";

                    bool allActionChecked = true;
                    string htmlActions = PermissionRole_RenderPermission(role, eSys_Module, sActions, out allActionChecked);

                    html +=
                        "<tr class=\"tr-rowdata\" dat-id=\"" + eSys_Module.ID.ToString() + "\">" +
                            "<td class=\"text-center\"><input " + (allActionChecked ? "checked" : "") + " onclick=\"sysrolepermission.oncheckrow(this);\" type=\"checkbox\" class=\"cbxRow\"></td>" +
                            "<td class=\"text-center\">" +
                                "<i class=\"" + eSys_Module.IconClass + "\"></i>" +
                            "</td>" +
                            "<td>" + levelSep + " " + eSys_Module.Name + "</td>" +
                            "<td class=\"text-center\">" +
                                htmlActions +
                            "</td>" +
                        "</tr>";

                    if (!allActionChecked) allRowChecked = false;
                }

                html =
                    "<table id=\"tbleSys_Modules\" class=\"table table-vcenter table-striped table-condensed table-hover table-bordered\">" +
                        "<thead>" +
                            "<tr>" +
                                "<th class=\"text-center\"><input " + (allRowChecked ? "checked" : "") + " onclick=\"sysrolepermission.oncheckall(this);\" type=\"checkbox\" class=\"cbxAll\"></th>" +
                                "<th class=\"text-center\"><i class=\"gi gi-picture\"></i></th>" +
                                "<th class=\"text-center\">Tên</th>" +
                                "<th class=\"text-center\">Phân quyền</th>" +
                            "</tr>" +
                        "</thead>" +
                        "<tbody>" +
                            html +
                        "</tbody>" +
                    "</table>";

                DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                {
                    Data = html,
                    ErrorCode = 0,
                    Message = "OK",
                }));
            }
        }

        private string PermissionRole_RenderPermission(eSys_Role role, eSys_Module eSys_Module, List<eSys_ModuleAction> actions, out bool allActionChecked)
        {
            allActionChecked = false;
            if (role == null || eSys_Module == null) return string.Empty;

            eSys_RolePermission permission = role.RolePermissions == null ? null : role.RolePermissions.FirstOrDefault(o => o.ModuleID == eSys_Module.ID);

            string[] eSys_ModuleActions = eSys_Module.Actions.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
            if (eSys_ModuleActions.Length == 0) return string.Empty;

            string html = string.Empty;

            allActionChecked = true;
            foreach (string sActionId in eSys_ModuleActions)
            {
                int actionId = int.Parse(sActionId.Replace("@", ""));
                eSys_ModuleAction actionEntity = actions.FirstOrDefault(o => o.ID == actionId);
                if (actionEntity == null) continue;

                bool hasAction = permission == null ? false : permission.Permissions.IndexOf("@" + actionId.ToString() + ";") >= 0 ? true : false;
                string cbxId = "cbxPermission-" + eSys_Module.ID.ToString() + "_" + actionId.ToString();
                html +=
                    "<label class=\"checkbox-inline\" for=\"" + cbxId + "\">" +
                        "<input class=\"cbxAction\" onclick=\"sysrolepermission.oncheckaction(this);\" " + (hasAction ? "checked" : "") + " type=\"checkbox\" id=\"" + cbxId + "\" name=\"" + cbxId + "\" value=\"" + actionEntity.ID.ToString() + "\"> " + actionEntity.Name +
                    "</label>";

                if (!hasAction) allActionChecked = false;
            }

            return html;
        }

        private void Delete()
        {
            string sId = Request.Form["id"];
            if (string.IsNullOrEmpty(sId))
            {
                DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                {
                    Data = null,
                    ErrorCode = -1,
                    Message = "Dữ liệu không hợp lệ!",
                }));

                return;
            }

            using (DALTools dalTools = new DALTools())
            {
                int id = int.Parse(sId);
                if (!dalTools.Sys_Role_Delete(id))
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 1,
                        Message = "Xóa thất bại, vui lòng kiểm tra lại dữ liệu!",
                    }));
                else
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 0,
                        Message = "Xóa thành công! Đang chuyển ...",
                    }));
            }
        }

        private void Edit()
        {
            string postdata = Request.Form["data"];
            if (postdata == string.Empty)
            {
                DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                {
                    Data = null,
                    ErrorCode = -1,
                    Message = "Dữ liệu không hợp lệ!",
                }));

                return;
            }

            dynamic data;
            try { data = JsonConvert.DeserializeObject(postdata); }
            catch { data = null; }

            if (data == null)
            {
                DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                {
                    Data = null,
                    ErrorCode = -1,
                    Message = "Dữ liệu không hợp lệ!",
                }));

                return;
            }

            using (DALTools dalTools = new DALTools())
            {
                int check = dalTools.Sys_Role_CheckName(data.name.ToString());
                if (check != 0 && check.ToString() != data.id.ToString())
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 1,
                        Message = "Tên đã tồn tại!",
                    }));

                    return;
                }

                Sys_Role obj = new Sys_Role()
                {
                    ID = int.Parse(data.id.ToString()),
                    Description = data.description.ToString(),
                    CanAccessSystemMenu = bool.Parse(data.accesssystemmenu.ToString()),
                    Name = data.name.ToString(),
                };

                int result = dalTools.Sys_Role_Update(obj);
                if (result != 0)
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = result,
                        Message = "Cập nhật thất bại, vui lòng kiểm tra lại dữ liệu!",
                    }));
                else
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 0,
                        Message = "Cập nhật thành công! Đang chuyển ...",
                    }));
            }
        }

        private void Create()
        {
            string postdata = Request.Form["data"];
            if (postdata == string.Empty)
            {
                DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                {
                    Data = null,
                    ErrorCode = -1,
                    Message = "Dữ liệu không hợp lệ",
                }));

                return;
            }

            dynamic data;
            try { data = JsonConvert.DeserializeObject(postdata); }
            catch { data = null; }

            if (data == null)
            {
                DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                {
                    Data = null,
                    ErrorCode = -1,
                    Message = "Dữ liệu không hợp lệ!",
                }));

                return;
            }

            using (DALTools dalTools = new DALTools())
            {
                int checkName = dalTools.Sys_Role_CheckName(data.name.ToString());
                if (checkName != 0)
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 1,
                        Message = "Tên đã tồn tại!",
                    }));

                    return;
                }

                Sys_Role obj = new Sys_Role()
                {
                    CanAccessSystemMenu = bool.Parse(data.accesssystemmenu.ToString()),
                    Name = data.name.ToString(),
                    Description = data.description.ToString(),
                    IsDeleted = false,
                };

                int result = dalTools.Sys_Role_Create(obj);
                if (result != 0)
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = result,
                        Message = "Thêm thất bại, vui lòng kiểm tra lại dữ liệu!",
                    }));
                else
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 0,
                        Message = "Thêm thành công! Đang chuyển ...",
                    }));
            }
        }

        private void LoadList()
        {
            string sPageIndex = Request.Form["page"];
            int pageIndex = 0;
            try { pageIndex = int.Parse(sPageIndex); }
            catch { pageIndex = 0; }

            using (DALTools dalTools = new DALTools())
            {
                int totalPages = 0;
                List<eSys_Role> all = dalTools.Sys_Role_GetEs(pageIndex, GlobalValues.DefaultPagingSize, out totalPages);

                if (all == null || all.Count == 0)
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 1,
                        Message = "Không có dữ liệu!",
                    }));
                else
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = new
                        {
                            PageIndex = pageIndex,
                            PageSize = GlobalValues.DefaultPagingSize,
                            TotalPages = totalPages,
                            List = JsonConvert.SerializeObject(all)
                        },
                        ErrorCode = 0,
                        Message = string.Empty,
                    }));
                }
            }
        }
    }
}