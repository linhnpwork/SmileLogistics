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
    public partial class sysmodules : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string mod = Request.Form["mod"];
            if (string.IsNullOrEmpty(mod))
                return;

            switch (mod.ToLower())
            {
                case "create":
                    CreateModule();
                    break;
                case "loadlist":
                    LoadListModules();
                    break;
                case "edit":
                    EditeModule();
                    break;
                case "delete":
                    DeleteModule();
                    break;
            }
        }

        private void DeleteModule()
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
                if (!dalTools.Sys_Module_Delete(id))
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
                        Message = "Xóa thành công! Đang chuyển...",
                    }));
            }
        }

        private void EditeModule()
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
                    Message = "Dữ liệu không hợp lệ!!",
                }));

                return;
            }

            using (DALTools dalTools = new DALTools())
            {
                int checkAlias = dalTools.Sys_Module_CheckAlias(data.alias.ToString());
                if (checkAlias != 0 && checkAlias.ToString() != data.id.ToString())
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 1,
                        Message = "Alias đã tồn tại!",
                    }));

                    return;
                }

                Sys_Module obj = new Sys_Module()
                {
                    ID = int.Parse(data.id.ToString()),
                    Actions = data.actions.ToString(),
                    Alias = data.alias.ToString(),
                    Description = data.description.ToString(),
                    IconClass = data.icon.ToString(),
                    ParentID = int.Parse(data.parent.ToString()),
                    Path = data.path.ToString(),
                    Name = data.name.ToString(),
                    IsDeleted = false,
                    ShowInMenu = bool.Parse(data.showinmenu.ToString()),
                };

                int result = dalTools.Sys_Module_Update(obj);
                if (result != 0)
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = result,
                        Message = result == 4 ? "Cập nhật thất bại! Không thể chuyển vào cấp con của chính nó!" : "Cập nhật thất bại, vui lòng kiểm tra lại dữ liệu!",
                    }));
                else
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 0,
                        Message = "Cập nhật thành công! Đang chuyển...",
                    }));
            }
        }

        private void LoadListModules()
        {
            using (DALTools dalTools = new DALTools())
            {
                List<eSys_Module> all = BindListModules(int.MinValue, dalTools);

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
                        Data = JsonConvert.SerializeObject(all),
                        ErrorCode = 0,
                        Message = string.Empty,
                    }));
                }
            }
        }

        private List<eSys_Module> BindListModules(int parentId, DALTools dalTools)
        {
            List<eSys_Module> result = new List<eSys_Module>();
            List<eSys_Module> all = dalTools.Sys_Module_GetEs(parentId);
            if (all != null)
            {
                foreach (eSys_Module eSys_Module in all)
                {
                    result.Add(eSys_Module);
                    if (dalTools.Sys_Module_HasChildren(eSys_Module.ID))
                    {
                        result.AddRange(BindListModules(eSys_Module.ID, dalTools));
                    }
                }
            }

            return result;
        }

        private void CreateModule()
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
                int checkAlias = dalTools.Sys_Module_CheckAlias(data.alias.ToString());
                if (checkAlias != 0)
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 1,
                        Message = "Alias đã tồn tại!",
                    }));

                    return;
                }

                Sys_Module obj = new Sys_Module()
                {
                    Actions = data.actions.ToString(),
                    Alias = data.alias.ToString(),
                    Description = data.description.ToString(),
                    IconClass = data.icon.ToString(),
                    ParentID = int.Parse(data.parent.ToString()),
                    Path = data.path.ToString(),
                    Name = data.name.ToString(),
                    IsDeleted = false,
                    ShowInMenu = bool.Parse(data.showinmenu.ToString()),
                };

                int result = dalTools.Sys_Module_Create(obj);
                if (result != 0)
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = result,
                        Message = "Thêm mới thất bại, vui lòng kiểm tra lại dữ liệu!",
                    }));
                else
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 0,
                        Message = "Thêm mới thành công! Đang chuyển...",
                    }));
            }
        }
    }
}