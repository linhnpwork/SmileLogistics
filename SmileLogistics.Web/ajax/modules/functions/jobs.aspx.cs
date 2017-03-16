﻿using Newtonsoft.Json;
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
    public partial class jobs : BasePage
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
                case "update_status":
                    UpdateStatus();
                    break;
                case "loadquotations":
                    LoadQuotations();
                    break;
                case "create_quotation_route":
                    Create_QuotationRoute();
                    break;
                case "delete_quotation_route":
                    Delete_QuotationRoute();
                    break;
                case "edit_quotation_route":
                    Update_QuotationRoute();
                    break;
                case "update_quotation_customs":
                    Update_QuotationCustoms();
                    break;
            }
        }

        private void Update_QuotationCustoms()
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
                Job job = dalTools.Job_Get(int.Parse(data.jobid.ToString()));
                if (job == null)
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 1,
                        Message = "Dữ liệu không hợp lệ!",
                    }));

                    return;
                }

                DateTime expireStart = CommonUtils.ConvertDateFromVNString(data.expirestart.ToString());
                DateTime expireEnd = CommonUtils.ConvertDateFromVNString(data.expireend.ToString());
                if (expireStart == CommonUtils.SQLMinValue || expireEnd == CommonUtils.SQLMinValue)
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 4,
                        Message = "Dữ liệu không hợp lệ!",
                    }));

                    return;
                }

                if (expireEnd < DateTime.Now.AddDays(1))
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 5,
                        Message = "Hiệu lực báo giá không hợp lệ!",
                    }));

                    return;
                }

                bool isusd = bool.Parse(data.isusd.ToString());
                double usdrate = double.Parse(data.usdrate.ToString());
                if (isusd && usdrate <= 0)
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 6,
                        Message = "Tỉ giá USD không hợp lệ!",
                    }));

                    return;
                }

                List<aCustomerQuotation_CustomsDetail> feeDetails = JsonConvert.DeserializeObject<List<aCustomerQuotation_CustomsDetail>>(data.feetypes.ToString());

                eCustomerQuotation_Custom obj = new eCustomerQuotation_Custom()
                {
                    CustomerID = (int)job.CustomerID,
                    Description = data.description.ToString(),
                    Expire_End = expireEnd,
                    Expire_Start = expireStart,
                    IsUSD = isusd,
                    LastestUpdate = DateTime.Now,
                    UpdatedByID = CurrentSys_User.ID,
                    USDRate = usdrate,
                    JobID = job.ID,
                    DecreasePercentForSecondCont = double.Parse(data.decreasepercent.ToString()),
                    BasicQuotationID = int.Parse(data.basequotationid.ToString()),
                };

                int res = dalTools.CustomerQuotation_Customs_Update(obj, feeDetails);
                if (res != 0)
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = res,
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

        private void Update_QuotationRoute()
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
                Job_QuotationRoute quotation = dalTools.Job_QuotationRoute_Get(int.Parse(data.id.ToString()));
                if (quotation == null)
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 1,
                        Message = "Dữ liệu không hợp lệ!",
                    }));

                    return;
                }

                Quotation_Route quotation_route = dalTools.Quotation_Route_Get(int.Parse(data.quotationcomp.ToString()));
                if (quotation_route == null)
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 1,
                        Message = "Dữ liệu không hợp lệ!",
                    }));

                    return;
                }

                int placestartID = int.Parse(data.placestart.ToString());
                int placeendID = int.Parse(data.placeend.ToString());
                if ((placestartID != quotation_route.TransportCompany_Route.StartPoint && placestartID != quotation_route.TransportCompany_Route.EndPoint) ||
                    (placeendID != quotation_route.TransportCompany_Route.StartPoint && placeendID != quotation_route.TransportCompany_Route.EndPoint))
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 2,
                        Message = "Dữ liệu không hợp lệ!",
                    }));

                    return;
                }

                int quotation_customerID = int.Parse(data.quotationcustomer.ToString());
                CustomerQuotation_Route quotation_customer = dalTools.CustomerQuotation_Route_Get(quotation_customerID);

                if (quotation_customerID != -1 && quotation_customer == null)
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 3,
                        Message = "Dữ liệu không hợp lệ!",
                    }));

                    return;
                }

                DateTime expireStart = CommonUtils.ConvertDateFromVNString(data.expirestart.ToString());
                DateTime expireEnd = CommonUtils.ConvertDateFromVNString(data.expireend.ToString());
                if (expireStart == CommonUtils.SQLMinValue || expireEnd == CommonUtils.SQLMinValue)
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 4,
                        Message = "Dữ liệu không hợp lệ!",
                    }));

                    return;
                }

                if (expireEnd < DateTime.Now.AddDays(1))
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 5,
                        Message = "Hiệu lực báo giá không hợp lệ!",
                    }));

                    return;
                }

                bool isusd = bool.Parse(data.isusd.ToString());
                double usdrate = double.Parse(data.usdrate.ToString());
                if (isusd && usdrate <= 0)
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 6,
                        Message = "Tỉ giá USD không hợp lệ!",
                    }));

                    return;
                }

                int quantity = int.Parse(data.quantity.ToString());
                if (quantity < 1)
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 7,
                        Message = "Số lượng xe không hợp lệ!",
                    }));

                    return;
                }

                double loads = double.Parse(data.loads.ToString());
                if (loads > quotation_route.TransportCompany_VehicleType_Load.VehicleLoad.FullLoad * quantity)
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 8,
                        Message = "Trọng lượng hàng vượt quá tải trọng tối đa của xe!",
                    }));

                    return;
                }

                double price = double.Parse(data.price.ToString());

                #region Kiểm tra Báo giá theo Khách hàng hiện tại

                bool isCreateNewQuotationCustomer = false;
                if (quotation_customerID == -1) isCreateNewQuotationCustomer = true;
                else
                {
                    if (price == quotation_customer.Price &&
                       isusd == quotation_customer.IsUSD)
                        isCreateNewQuotationCustomer = false;
                    else
                        isCreateNewQuotationCustomer = true;
                }

                //Tạo mới Báo giá theo KH
                if (isCreateNewQuotationCustomer)
                {
                    quotation_customer = new CustomerQuotation_Route()
                    {
                        CustomerID = quotation.CustomerQuotation_Route.CustomerID,
                        Expire_End = expireEnd,
                        Expire_Start = expireStart,
                        IsDeleted = false,
                        IsUSD = isusd,
                        LastestUpdated = DateTime.Now,
                        PlaceEnd = placeendID,
                        PlaceStart = placestartID,
                        Price = price,
                        QuotationID = quotation_route.ID,
                        UpdatedBy = CurrentSys_User.ID,
                    };

                    int result = dalTools.CustomerQuotation_Route_Create(ref quotation_customer);
                    if (result != 0)
                    {
                        DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                        {
                            Data = null,
                            ErrorCode = 9,
                            Message = "Có lỗi trong quá trình xử lý! Vui lòng liên hệ Kỹ thuật viên!",
                        }));

                        return;
                    }
                }

                #endregion

                #region Kiểm tra hạn Báo giá

                //Báo giá từ Hãng
                if (quotation_route.Expire_End < expireEnd)
                {
                    quotation_route.Expire_End = expireEnd;
                    quotation_route.UpdatedBy = CurrentSys_User.ID;
                    dalTools.Quotation_Route_Update(quotation_route);
                }

                //Báo giá theo Khách
                if (!isCreateNewQuotationCustomer)
                {
                    if (quotation_customer.Expire_End < expireEnd)
                    {
                        quotation_customer.Expire_End = expireEnd;
                        quotation_customer.UpdatedBy = CurrentSys_User.ID;
                        dalTools.CustomerQuotation_Route_Update(quotation_customer);
                    }
                }

                #endregion

                Job_QuotationRoute obj = new Job_QuotationRoute()
                {
                    ID = quotation.ID,
                    Description = data.description.ToString(),
                    DriverPhoneNumber = data.driverphone.ToString(),
                    ExtraFee = double.Parse(data.extrafee.ToString()),
                    LastestUpdate = DateTime.Now,
                    Loads = loads,
                    PlaceEnd = placeendID,
                    PlaceStart = placestartID,
                    PromotionByTransComp = double.Parse(data.comppromotion.ToString()),
                    Quantity = quantity,
                    RouteID = quotation_customer.ID,
                    UpdatedBy = CurrentSys_User.ID,
                    USDRate = usdrate,
                    VehicleNO = data.vehicleno.ToString(),
                };

                int res = dalTools.Job_QuotationRoute_Update(obj);
                if (res != 0)
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = res,
                        Message = "Cập nhật thất bại, vui lòng kiểm tra lại dữ liệu!",
                    }));
                else
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = obj.ID.ToString(),
                        ErrorCode = 0,
                        Message = "Cập nhật thành công! Đang chuyển...",
                    }));
            }
        }

        private void Delete_QuotationRoute()
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
                Job_QuotationRoute obj = dalTools.Job_QuotationRoute_Get(id);
                if (obj == null)
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = -1,
                        Message = "Không tìm thấy Báo giá Vận chuyển!",
                    }));

                    return;
                }

                obj.UpdatedBy = CurrentSys_User.ID;
                if (!dalTools.Job_QuotationRoute_Delete(obj))
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

        private void Create_QuotationRoute()
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
                eJob job = dalTools.Job_GetE(int.Parse(data.jobid.ToString()));
                if (job == null)
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 1,
                        Message = "Dữ liệu không hợp lệ!",
                    }));

                    return;
                }

                Quotation_Route quotation_route = dalTools.Quotation_Route_Get(int.Parse(data.quotationcomp.ToString()));
                if (quotation_route == null)
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 1,
                        Message = "Dữ liệu không hợp lệ!",
                    }));

                    return;
                }

                int placestartID = int.Parse(data.placestart.ToString());
                int placeendID = int.Parse(data.placeend.ToString());
                if ((placestartID != quotation_route.TransportCompany_Route.StartPoint && placestartID != quotation_route.TransportCompany_Route.EndPoint) ||
                    (placeendID != quotation_route.TransportCompany_Route.StartPoint && placeendID != quotation_route.TransportCompany_Route.EndPoint))
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 2,
                        Message = "Dữ liệu không hợp lệ!",
                    }));

                    return;
                }

                int quotation_customerID = int.Parse(data.quotationcustomer.ToString());
                CustomerQuotation_Route quotation_customer = dalTools.CustomerQuotation_Route_Get(quotation_customerID);

                if (quotation_customerID != -1 && quotation_customer == null)
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 3,
                        Message = "Dữ liệu không hợp lệ!",
                    }));

                    return;
                }

                DateTime expireStart = CommonUtils.ConvertDateFromVNString(data.expirestart.ToString());
                DateTime expireEnd = CommonUtils.ConvertDateFromVNString(data.expireend.ToString());
                if (expireStart == CommonUtils.SQLMinValue || expireEnd == CommonUtils.SQLMinValue)
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 4,
                        Message = "Dữ liệu không hợp lệ!",
                    }));

                    return;
                }

                if (expireEnd < DateTime.Now.AddDays(1))
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 5,
                        Message = "Hiệu lực báo giá không hợp lệ!",
                    }));

                    return;
                }

                bool isusd = bool.Parse(data.isusd.ToString());
                double usdrate = double.Parse(data.usdrate.ToString());
                if (isusd && usdrate <= 0)
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 6,
                        Message = "Tỉ giá USD không hợp lệ!",
                    }));

                    return;
                }

                int quantity = int.Parse(data.quantity.ToString());
                if (quantity < 1)
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 7,
                        Message = "Số lượng xe không hợp lệ!",
                    }));

                    return;
                }

                double loads = double.Parse(data.loads.ToString());
                if (loads > quotation_route.TransportCompany_VehicleType_Load.VehicleLoad.FullLoad * quantity)
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 8,
                        Message = "Trọng lượng hàng vượt quá tải trọng tối đa của xe!",
                    }));

                    return;
                }

                double price = double.Parse(data.price.ToString());

                #region Kiểm tra Báo giá theo Khách hàng hiện tại

                bool isCreateNewQuotationCustomer = false;
                if (quotation_customerID == -1) isCreateNewQuotationCustomer = true;
                else
                {
                    if (price == quotation_customer.Price &&
                       isusd == quotation_customer.IsUSD)
                        isCreateNewQuotationCustomer = false;
                    else
                        isCreateNewQuotationCustomer = true;
                }

                //Tạo mới Báo giá theo KH
                if (isCreateNewQuotationCustomer)
                {
                    quotation_customer = new CustomerQuotation_Route()
                    {
                        CustomerID = job.CustomerID,
                        Expire_End = expireEnd,
                        Expire_Start = expireStart,
                        IsDeleted = false,
                        IsUSD = isusd,
                        LastestUpdated = DateTime.Now,
                        PlaceEnd = placeendID,
                        PlaceStart = placestartID,
                        Price = price,
                        QuotationID = quotation_route.ID,
                        UpdatedBy = CurrentSys_User.ID,
                    };

                    int result = dalTools.CustomerQuotation_Route_Create(ref quotation_customer);
                    if (result != 0)
                    {
                        DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                        {
                            Data = null,
                            ErrorCode = 9,
                            Message = "Có lỗi trong quá trình xử lý! Vui lòng liên hệ Kỹ thuật viên!",
                        }));

                        return;
                    }
                }

                #endregion

                #region Kiểm tra hạn Báo giá

                //Báo giá từ Hãng
                if (quotation_route.Expire_End < expireEnd)
                {
                    quotation_route.Expire_End = expireEnd;
                    quotation_route.UpdatedBy = CurrentSys_User.ID;
                    dalTools.Quotation_Route_Update(quotation_route);
                }

                //Báo giá theo Khách
                if (!isCreateNewQuotationCustomer)
                {
                    if (quotation_customer.Expire_End < expireEnd)
                    {
                        quotation_customer.Expire_End = expireEnd;
                        quotation_customer.UpdatedBy = CurrentSys_User.ID;
                        dalTools.CustomerQuotation_Route_Update(quotation_customer);
                    }
                }

                #endregion

                Job_QuotationRoute obj = new Job_QuotationRoute()
                {
                    Description = data.description.ToString(),
                    DriverPhoneNumber = data.driverphone.ToString(),
                    ExtraFee = double.Parse(data.extrafee.ToString()),
                    IsDeleted = false,
                    JobID = int.Parse(data.jobid.ToString()),
                    LastestUpdate = DateTime.Now,
                    Loads = loads,
                    PlaceEnd = placeendID,
                    PlaceStart = placestartID,
                    PromotionByTransComp = double.Parse(data.comppromotion.ToString()),
                    Quantity = quantity,
                    RouteID = quotation_customer.ID,
                    Status = 0,
                    Total_In = 0,
                    Total_Out = 0,
                    UpdatedBy = CurrentSys_User.ID,
                    USDRate = usdrate,
                    VehicleNO = data.vehicleno.ToString(),
                };

                int res = dalTools.Job_QuotationRoute_Create(ref obj);
                if (res != 0)
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = res,
                        Message = "Thêm mới thất bại, vui lòng kiểm tra lại dữ liệu!",
                    }));
                else
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = obj.ID.ToString(),
                        ErrorCode = 0,
                        Message = "Thêm mới thành công! Đang chuyển...",
                    }));
            }
        }

        private void LoadQuotations()
        {
            string sFilter = Request.Form["filter"].ToString();

            eJobFilter_Quotation filter = JsonConvert.DeserializeObject<eJobFilter_Quotation>(sFilter);

            using (DALTools dalTools = new DALTools())
            {
                List<eQuotationRoute> allRoutes_Comp = dalTools.Quotation_Route_GetEs(filter);
                List<eCustomerQuotation_Route> allRoutes_Customer = dalTools.CustomerQuotation_Route_GetEs(filter);

                DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                {
                    Data = new
                    {
                        List_ByComp = allRoutes_Comp == null ? string.Empty : JsonConvert.SerializeObject(allRoutes_Comp),
                        List_ByCustomer = allRoutes_Customer == null ? string.Empty : JsonConvert.SerializeObject(allRoutes_Customer),
                    },
                    ErrorCode = 0,
                    Message = string.Empty,
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
                int check = dalTools.Job_CheckJobID(data.jobid.ToString());
                if (check != 0 && check.ToString() != data.id.ToString())
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 1,
                        Message = "JobID đã tồn tại!",
                    }));

                    return;
                }

                Job obj = new Job()
                {
                    ID = int.Parse(data.id.ToString()),
                    Type = int.Parse(data.type.ToString()),
                    JobID = data.jobid.ToString(),
                    InvoiceNO = data.invoiceno.ToString(),
                    BillLadingNO = data.billladingno.ToString(),
                    TKHQNO = data.tkhq.ToString(),
                    CustomerID = int.Parse(data.customer.ToString()),
                    UpdatedBy = CurrentSys_User.ID,
                    LastestUpdated = DateTime.Now
                };

                int result = dalTools.Job_Update(obj);
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
                        Data = obj.ID.ToString(),
                        ErrorCode = 0,
                        Message = "Cập nhật thành công! Đang chuyển...",
                    }));
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
                Job obj = dalTools.Job_Get(id);
                if (obj == null)
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = -1,
                        Message = "Không tìm thấy Job!",
                    }));

                    return;
                }

                obj.UpdatedBy = CurrentSys_User.ID;
                if (!dalTools.Job_Delete(obj))
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

        private void UpdateStatus()
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

            string sTime = data.consignedtime.ToString();
            string sDate = data.consigneddate.ToString();
            sDate = sDate.Replace("-", "/");
            DateTime consignedDate = CommonUtils.ConvertDatetimeFromVNString(sDate.Trim() + " " + sTime.Trim());
            bool isConsigned = bool.Parse(data.isconsigned.ToString());
            if (isConsigned && consignedDate == CommonUtils.SQLMinValue)
            {
                DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                {
                    Data = null,
                    ErrorCode = -1,
                    Message = "Ngày/Giờ giao hàng không hợp lệ!",
                }));

                return;
            }

            using (DALTools dalTools = new DALTools())
            {
                Job obj = new Job()
                {
                    ID = int.Parse(data.id.ToString()),
                    IsConsigned = isConsigned,
                    ConsignedDate = isConsigned ? consignedDate : DateTime.MaxValue,
                    IsInformTransportComp = bool.Parse(data.isinformtranscomp.ToString()),
                    IsPayedForTransportComp = bool.Parse(data.ispayedfortranscomp.ToString()),
                    UpdatedBy = CurrentSys_User.ID,
                    LastestUpdated = DateTime.Now
                };

                int result = dalTools.Job_Update_Status(obj);
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
                        Data = obj.ID.ToString(),
                        ErrorCode = 0,
                        Message = "Cập nhật thành công!",
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
                int check = dalTools.Job_CheckJobID(data.jobid.ToString());
                if (check != 0)
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 2,
                        Message = "Code đã tồn tại!",
                    }));

                    return;
                }

                Job obj = new Job()
                {
                    Type = int.Parse(data.type.ToString()),
                    JobID = data.jobid.ToString(),
                    InvoiceNO = data.invoiceno.ToString(),
                    BillLadingNO = data.billladingno.ToString(),
                    TKHQNO = data.tkhq.ToString(),
                    CustomerID = int.Parse(data.customer.ToString()),
                    IsDeleted = false,
                    UpdatedBy = CurrentSys_User.ID,
                    LastestUpdated = DateTime.Now,
                };

                int result = dalTools.Job_Create(ref obj);
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
                        Data = obj.ID.ToString(),
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

            string sFilter = Request.Form["filter"].ToString();

            eJobFilter filter = JsonConvert.DeserializeObject<eJobFilter>(sFilter);

            using (DALTools dalTools = new DALTools())
            {
                int totalPages = 0;
                List<eJob> all = dalTools.Job_GetEs(filter, pageIndex, GlobalValues.DefaultPagingSize, out totalPages);

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