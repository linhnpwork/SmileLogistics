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

namespace SmileLogistics.Web.ajax.modules.functions
{
    public partial class quotationroutes : BasePage
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
                Quotation_Route obj = dalTools.Quotation_Route_Get(id);
                if (obj == null)
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = -1,
                        Message = "Không tìm thấy Báo giá vận chuyển!",
                    }));

                    return;
                }

                obj.UpdatedBy = CurrentSys_User.ID;
                if (!dalTools.Quotation_Route_Delete(obj))
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
                Quotation_Route obj = new Quotation_Route()
                {
                    ID = int.Parse(data.id.ToString()),
                    Expire_End = CommonUtils.ConvertDateFromVNString(data.expireend.ToString()),
                    Expire_Start = CommonUtils.ConvertDateFromVNString(data.expirestart.ToString()),
                    IsSamePrice = bool.Parse(data.issameprice.ToString()),
                    IsUSD = bool.Parse(data.isusd.ToString()),
                    Price = double.Parse(data.price.ToString()),
                    Price_RoundedTrip = double.Parse(data.priceroundedtrip.ToString()),
                    RouteID = int.Parse(data.route.ToString()),
                    VehicleLoadID = int.Parse(data.load.ToString()),
                    UpdatedBy = CurrentSys_User.ID,
                    LastestUpdated = DateTime.Now,
                };

                if (obj.Expire_End < DateTime.Now)
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = -3,
                        Message = "Ngày hiệu lực không hợp lệ!",
                    }));

                    return;
                }

                int result = dalTools.Quotation_Route_Update(obj);
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

            using (DALTools dalTools = new DALTools())
            {
                Quotation_Route obj = new Quotation_Route()
                {
                    Expire_End = CommonUtils.ConvertDateFromVNString(data.expireend.ToString()),
                    Expire_Start = CommonUtils.ConvertDateFromVNString(data.expirestart.ToString()),
                    IsSamePrice = bool.Parse(data.issameprice.ToString()),
                    IsUSD = bool.Parse(data.isusd.ToString()),
                    Price = double.Parse(data.price.ToString()),
                    Price_RoundedTrip = double.Parse(data.priceroundedtrip.ToString()),
                    RouteID = int.Parse(data.route.ToString()),
                    VehicleLoadID = int.Parse(data.load.ToString()),
                    IsDeleted = false,
                    UpdatedBy = CurrentSys_User.ID,
                    LastestUpdated = DateTime.Now,
                };

                if (obj.Expire_End < DateTime.Now)
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = -3,
                        Message = "Ngày hiệu lực không hợp lệ!",
                    }));

                    return;
                }

                int result = dalTools.Quotation_Route_Create(obj);
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
                List<eQuotationRoute> all = dalTools.Quotation_Route_GetEs(pageIndex, GlobalValues.DefaultPagingSize, out totalPages);

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