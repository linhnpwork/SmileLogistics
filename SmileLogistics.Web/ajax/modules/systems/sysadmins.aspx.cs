using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SmileLogistics.Web.bases;
using SmileLogistics.DAL;
using Decided.Libs;
using System.IO;
using SmileLogistics.DAL.Helpers;
using SmileLogistics.DAL.Entities;

namespace SmileLogistics.Web.ajax.modules.systems
{
    public partial class sysadmins : BasePage
    {
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
            }
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
                if (!dalTools.Sys_User_Delete(id))
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

            #region Avatar

            string avatar = string.Empty;
            if (Request.Files.Count > 0)
            {
                HttpPostedFile file = Request.Files[0];
                string ext = file.FileName.Substring(file.FileName.LastIndexOf('.') + 1).ToLower();
                if (ext != "png" && ext != "jpg")
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 1,
                        Message = "Ảnh đại diện chỉ chấp nhận loại tệp: PNG/JPG!",
                    }));

                    return;
                }

                avatar = "~/uploads/avatars/" + DateTime.Now.Ticks.ToString() + "." + ext;
                file.SaveAs(Server.MapPath(ResolveUrl(avatar)));
            }

            #endregion

            using (DALTools dalTools = new DALTools())
            {
                int check = dalTools.Sys_User_CheckEmail(data.email.ToString());
                if (check != 0 && check.ToString() != data.id.ToString())
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 1,
                        Message = "Email đã tồn tại!",
                    }));

                    return;
                }

                string sDateofbirth = data.dateofbirth.ToString();
                DateTime dateOfBirth = CommonUtils.SQLMinValue;
                if (!string.IsNullOrEmpty(sDateofbirth))
                {
                    dateOfBirth = CommonUtils.ConvertDateFromVNString(sDateofbirth);
                }

                Sys_User obj = new Sys_User()
                {
                    ID = int.Parse(data.id.ToString()),
                    Address = data.address.ToString(),
                    Avatar = avatar,
                    DateOfBirth = dateOfBirth,
                    Email = data.email.ToString(),
                    Firstname = data.firstname.ToString(),
                    Lastname = data.lastname.ToString(),
                    Password = string.IsNullOrEmpty(data.password.ToString()) ? string.Empty : new PrivateEncryptor().Encrypt(data.password.ToString()),
                    PhoneNumber = data.phone.ToString(),
                    RoleID = int.Parse(data.roleid.ToString()),
                    Status = byte.Parse(data.status.ToString()),
                    Username = data.username.ToString(),
                };

                int result = dalTools.Sys_User_Update(obj);
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
                        Message = "Cập nhật thành công! Đang chuyển...",
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
                    ErrorCode = -2,
                    Message = "Dữ liệu không hợp lệ!",
                }));

                return;
            }

            #region Avatar

            string avatar = string.Empty;
            if (Request.Files.Count > 0)
            {
                HttpPostedFile file = Request.Files[0];
                string ext = file.FileName.Substring(file.FileName.LastIndexOf('.') + 1).ToLower();
                if (ext != "png" && ext != "jpg")
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 1,
                        Message = "Ảnh đại diện chỉ chấp nhận loại tệp: PNG/JPG!",
                    }));

                    return;
                }

                avatar = "~/uploads/avatars/" + DateTime.Now.Ticks.ToString() + "." + ext;
                file.SaveAs(Server.MapPath(ResolveUrl(avatar)));
            }

            #endregion

            using (DALTools dalTools = new DALTools())
            {
                int checkEmail = dalTools.Sys_User_CheckEmail(data.email.ToString());
                if (checkEmail != 0)
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 2,
                        Message = "Email đã tồn tại!",
                    }));

                    return;
                }

                string sDateofbirth = data.dateofbirth.ToString();
                DateTime dateOfBirth = CommonUtils.SQLMinValue;
                if (!string.IsNullOrEmpty(sDateofbirth))
                {
                    dateOfBirth = CommonUtils.ConvertDatetimeFromVNString(sDateofbirth);
                }

                Sys_User obj = new Sys_User()
                {
                    Address = data.address.ToString(),
                    Avatar = string.IsNullOrEmpty(avatar) ? SiteValues.LogoPath : avatar,
                    DateOfBirth = dateOfBirth,
                    Email = data.email.ToString(),
                    Firstname = data.firstname.ToString(),
                    Lastname = data.lastname.ToString(),
                    Password = new PrivateEncryptor().Encrypt(data.password.ToString()),
                    PhoneNumber = data.phone.ToString(),
                    RoleID = int.Parse(data.roleid.ToString()),
                    Status = byte.Parse(data.status.ToString()),
                    Username = data.username.ToString(),
                    IsDeleted = false,
                };

                int result = dalTools.Sys_User_Create(obj);
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

        private void LoadList()
        {
            string sPageIndex = Request.Form["page"];
            int pageIndex = 0;
            try { pageIndex = int.Parse(sPageIndex); }
            catch { pageIndex = 0; }

            using (DALTools dalTools = new DALTools())
            {
                int totalPages = 0;
                List<eSys_User> all = dalTools.Sys_User_GetEs(pageIndex, GlobalValues.DefaultPagingSize, out totalPages);

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