﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="JobDetail.ascx.cs" Inherits="SmileLogistics.Web.modules.functions.JobDetail" %>
<style type="text/css">
    .modal-body .nav-tabs {
        padding: 3px 1px 0 !important;
        margin: 0 !important;
        margin-bottom: -2px !important;
    }

    .block {
        padding-bottom: 0 !important;
    }

    .row-header-filter {
        background-color: #f9fafc !important;
        font-size: 11px !important;
        font-weight: normal !important;
    }

        .row-header-filter th {
            border: none !important;
            font-size: 11px !important;
            font-weight: normal !important;
        }
</style>
<div id="page-content">
    <div class="content-header">
        <div class="header-section">
            <h1>
                <i class='<% = CurrentSys_Module.IconClass %>'></i><% = CurrentSys_Module.Name %><br>
                <small><% = CurrentSys_Module.Description %></small>
            </h1>
        </div>
    </div>
    <ul class="breadcrumb breadcrumb-top" style="text-align: right;">
        <%--<li><button class="btn btn-xs btn-info"><i class="fa fa-twitter"></i> Tweet</button></li>
        <li><button class="btn btn-xs btn-info"><i class="fa fa-twitter"></i> Tweet</button></li>--%>
        <a id="btn-job-status-requestconfirm" onclick="jobs.doflow_start_requestConfirm();" class="btn btn-xs btn-success"><i class="gi gi-disk_export"></i>&nbsp;Chuyển Giám đốc duyệt</a>
        <a id="btn-job-status-requestaccountant" onclick="jobs.doflow_start_sendback();" class="btn btn-xs btn-info"><i class="gi gi-pushpin"></i>&nbsp;Chuyển trả bổ sung</a>
        <%--<a id="btn-job-status-requestemployee" class="btn btn-xs btn-info"><i class="gi gi-pin_flag"></i>&nbsp;Chuyển Nhân viên bổ sung</a>--%>
        <a id="btn-job-status-finish" onclick="jobs.doflow_start_finishjob();" class="btn btn-xs btn-warning"><i class="gi gi-pen"></i>&nbsp;Duyệt hoàn tất</a>
    </ul>
    <div class="row">
        <div class="col-md-5">
            <div class="block full">
                <div class="block-title">
                    <h2>Thông tin JOB <strong id="jobID"></strong></h2>
                </div>
                <div class="form-horizontal form-bordered">
                    <div class="form-group">
                        <label class="col-md-3 control-label">Loại</label>
                        <div id="divTypes" onchange="jobs.onchange_type();" runat="server" class="col-md-9">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">JOB ID</label>
                        <div class="col-md-9">
                            <input type="text" id="info-jobid" class="form-control" placeholder="JOB ID" disabled>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Invoice NO</label>
                        <div class="col-md-9">
                            <input type="text" id="info-invoiceno" class="form-control" placeholder="Invoice NO">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">BillLading NO</label>
                        <div class="col-md-9">
                            <input type="text" id="info-billladingno" class="form-control" placeholder="BillLading NO">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">TKHQ</label>
                        <div class="col-md-9">
                            <input type="text" id="info-tkhq" class="form-control" placeholder="TKHQ">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Khách hàng</label>
                        <div id="divCustomers" runat="server" class="col-md-9">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Tỉ giá USD</label>
                        <div class="col-md-9">
                            <input type="text" id="info-usdrate" class="form-control" placeholder="1 USD = ? VND" style="width: auto;" value="0" onkeyup="globalhelpers.On_InputMoney_KeyPress(this);">
                            <span class="help-block">(Dùng dấm chấm '.' để xác định số thập phân! Đây là tỉ giá USD tạm thời, được sử dụng để tính toán trong quá trình xử lý JOB. Nếu trong JOB có sử dụng đồng USD (ở các tính năng: Thu/Chi hộ, ...) thì phải cung cấp tỉ giá này!)</span>
                        </div>
                    </div>
                    <div class="form-group form-actions text-right">
                        <a id="btn-do-save-info" onclick="jobs.doAdd();" class="btn btn-sm btn-primary">Lưu</a>
                    </div>
                </div>
            </div>
            <div class="block full block-related-edit">
                <div class="block-title">
                    <h2>Trạng thái</h2>
                </div>
                <div class="form-horizontal form-bordered">
                    <div class="form-group">
                        <label class="col-md-3 control-label">Đã giao hàng?</label>
                        <div class="col-md-9">
                            <label class='switch switch-success'>
                                <input id="info-isconsigned" onchange="jobs.onchange_isconsigned(this);" type='checkbox'><span></span>
                            </label>
                        </div>
                    </div>
                    <div id="div-info-consigned" class="form-group">
                        <label class="col-md-3 control-label">Thời gian giao hàng</label>
                        <div class="col-md-4">
                            <div class="input-group bootstrap-timepicker">
                                <input type="text" id="info-consigned-time" name="info-consigned-time" class="form-control input-timepicker24">
                                <span class="input-group-btn">
                                    <a href="javascript:void(0)" class="btn btn-primary"><i class="fa fa-clock-o"></i></a>
                                </span>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <input type="text" id="info-consigned-date" class="form-control input-datepicker" data-date-format="dd/mm/yyyy" placeholder="dd/mm/yyyy">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Đã báo nhà xe?</label>
                        <div class="col-md-9">
                            <label class='switch switch-success'>
                                <input id="info-isinformtranscomp" type='checkbox'><span></span></label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Đã thanh toán cho nhà xe?</label>
                        <div class="col-md-9">
                            <label class='switch switch-success'>
                                <input id="info-ispayedfortranscomp" type='checkbox'><span></span></label>
                        </div>
                    </div>
                    <div class="form-group form-actions text-right">
                        <a id="btn-do-save-status" onclick="jobs.dosave_status();" class="btn btn-sm btn-primary">Lưu</a>
                    </div>
                </div>
            </div>
            <div class="block full block-related-edit">
                <div class="block-title">
                    <h2>Thanh toán từ <strong>Khách hàng</strong></h2>
                </div>
                <div class="form-horizontal form-bordered">
                    <div class="form-group">
                        <label class="col-md-4 control-label">Khách hàng đã thanh toán?</label>
                        <div class="col-md-8">
                            <label class='switch switch-success'>
                                <input id="info-ispaidfromcustomer" type='checkbox'><span></span></label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div id="divCustomerPrepaids" class="col-md-12">
                            <table id="tblList_CustomerPrepaids" class="table table-vcenter table-striped table-condensed table-hover table-bordered">
                                <thead>
                                    <tr id="tr-customerprepaids-controls" class="row-header-filter">
                                        <th colspan="3" class="text-left" style="font-weight: bold !important;">Lịch sử chi từ Tạm ứng của Khách hàng</th>
                                        <th class="text-right"><a id="btn-do-add-customerpayment" onclick="jobs.startAdd_jobprepaid();" class="btn btn-sm btn-warning" data-toggle="tooltip" title="Thêm mới"><i class="gi gi-plus"></i></a></th>
                                    </tr>
                                    <tr>
                                        <th class="text-center">Ngày chi</th>
                                        <th class="text-center">Số tiền</th>
                                        <th class="text-center">Ghi chú</th>
                                        <th class="text-center">#</th>
                                    </tr>
                                </thead>
                                <tbody id="tbodyList_CustomerPrepaids">
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="form-group form-actions text-right">
                        <a id="btn-do-save-customerpayment" class="btn btn-sm btn-primary">Lưu</a>
                    </div>
                </div>
            </div>
            <div class="block full block-related-edit">
                <div class="block-title">
                    <h2><strong>Danh mục Hàng</strong></h2>
                    <div class="block-options pull-right">
                        <a id="btn-info-add-jobgoods" onclick="jobs.startadd_jobgood();" class="btn btn-sm btn-success" data-toggle="tooltip" title="Thêm mới"><i class="gi gi-plus"></i></a>
                    </div>
                </div>
                <div class="form-horizontal">
                    <div id="divJobGoods" class="table-responsive">
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-7">
            <div class="block full block-related-edit">
                <div class="block-title">
                    <h2>Báo giá <strong>TTHQ</strong></h2>
                    <div id="divQuotation-customs-settings" class="block-options pull-right">
                        <a onclick="jobs.startAdd_quotation_customs();" class="btn btn-sm btn-success" data-toggle="tooltip" title="Thiết lập báo giá"><i class="hi hi-cog"></i></a>
                    </div>
                </div>
                <div id="divQuotation-customs-details" class="form-horizontal form-bordered">
                    <div id="divQuotationCustoms_Row_Customers" class="form-group">
                        <label class="col-md-3 control-label">Sử dụng bảng giá</label>
                        <div id="divQuotationCustoms_By_Smiles" class="col-md-3">
                        </div>
                        <label class="col-md-3 control-label">% giảm cho Cont thứ 2 trở đi</label>
                        <div class="col-md-3">
                            <input type="text" id="info-quotation-customs-decreasepercent" onchange="jobs.generate_quotationcustoms_feedetails_total();" class="form-control" placeholder="Tỉ lệ %: từ 0 đến 100" value="50">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Hiệu lực báo giá</label>
                        <div class="col-md-9">
                            <div class="input-group input-daterange" data-date-format="dd/mm/yyyy">
                                <input type="text" id="info-quotation-customs-expire-start" class="form-control text-center" placeholder="Từ ngày">
                                <span class="input-group-addon"><i class="fa fa-angle-right"></i></span>
                                <input type="text" id="info-quotation-customs-expire-end" class="form-control text-center" placeholder="Đến ngày">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Sử dụng USD?</label>
                        <div class="col-md-3">
                            <label class='switch switch-success'>
                                <input id="info-quotation-customs-isusd" type='checkbox'><span></span>
                            </label>
                        </div>
                        <label class="col-md-3 control-label">Tỉ giá USD</label>
                        <div class="col-md-3">
                            <input type="text" id="info-quotation-customs-usdrate" class="form-control" placeholder="1 USD = ? VND" onkeyup="globalhelpers.On_InputMoney_KeyPress(this);">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Ghi chú</label>
                        <div class="col-md-9">
                            <input type="text" id="info-quotation-customs-description" class="form-control" placeholder="Ghi chú">
                        </div>
                    </div>
                    <div class="form-group">
                        <div id="divQuotation_Customs_FeeDetails" class="col-md-12">
                            <table id="tblList" class="table table-vcenter table-striped table-condensed table-hover table-bordered">
                                <thead>
                                    <tr id="tr-quotation-customs-controls" class="row-header-filter">
                                        <th colspan="4" class="text-left" style="font-weight: normal !important; font-style: italic;">(<b>Lưu ý:</b> mọi thao tác <b>Thêm/Sửa/Xóa</b> danh sách báo giá TTHQ chỉ có hiệu lực khi thực hiện <b>Lưu</b> dữ liệu! Hãy đảm bảo đã tiến hành <b>Lưu</b> khi muốn áp dụng thay đổi thông tin TTHQ!)</th>
                                        <th class="text-right"><a id="btn-do-add-quotationcustoms" onclick="jobs.startAdd_quotation_customs_detail();" class="btn btn-sm btn-warning" data-toggle="tooltip" title="Thêm mới"><i class="gi gi-plus"></i></a></th>
                                    </tr>
                                    <tr>
                                        <th class="text-center">Loại phí</th>
                                        <th class="text-center" style="width: 50px;">Số lượng</th>
                                        <th class="text-center">Giá</th>
                                        <th class="text-center">Tổng tiền</th>
                                        <th class="text-center">#</th>
                                    </tr>
                                </thead>
                                <tbody id="tbodyList_Quotation_Customs_FeeDetails">
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div id="divModalAlert-quotation-customs" class="form-group" style="display: none;">
                        <div class="col-md-3">
                        </div>
                        <div id="divModalAlert-quotation-customs-content" class="col-md-9">
                        </div>
                    </div>
                </div>
                <div id="divQuotation-customs-controls" class="form-horizontal form-bordered">
                    <div class="form-group form-actions text-right">
                        <a id="btn-do-save-quotationcustoms" onclick="jobs.doAdd_quotation_customs();" class="btn btn-sm btn-primary">Lưu</a>
                    </div>
                </div>
            </div>
            <div class="block full block-related-edit">
                <div class="block-title">
                    <h2>Báo giá <strong>Vận chuyển</strong></h2>
                    <div class="block-options pull-right">
                        <a id="btn-do-add-quotationroute" onclick="jobs.startAdd_quotation_route();" class="btn btn-sm btn-success" data-toggle="tooltip" title="Thêm mới"><i class="gi gi-plus"></i></a>
                    </div>
                </div>
                <div class="form-horizontal">
                    <div id="divQuotation_Routes" class="table-responsive">
                    </div>
                </div>
            </div>
            <div class="block full block-related-edit">
                <div class="block-title">
                    <h2><strong>Thu/Chi hộ</strong></h2>
                    <div class="block-options pull-right">
                        <a id="btn-do-add-inoutfee" onclick="jobs.startAdd_inoutfee();" class="btn btn-sm btn-success" data-toggle="tooltip" title="Thêm mới"><i class="gi gi-plus"></i></a>
                    </div>
                </div>
                <div class="form-horizontal">
                    <div id="divInOutFees" class="table-responsive">
                    </div>
                </div>
            </div>
            <div class="block full block-related-edit">
                <div class="block-title">
                    <h2>Tạm ứng cho <strong>Nhân viên</strong></h2>
                    <div class="block-options pull-right">
                        <a id="btn-do-add-agentprepaid" onclick="jobs.startAdd_agentprepaid();" class="btn btn-sm btn-success" data-toggle="tooltip" title="Thêm mới"><i class="gi gi-plus"></i></a>
                    </div>
                </div>
                <div class="form-horizontal">
                    <div id="divAgentPrepaids" class="table-responsive">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="modal-delete-quotation-route" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-xs">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Xóa Báo giá Vận chuyển?</h3>
            </div>
            <div class="modal-body">
                Bạn chắc chắn muốn xóa Báo giá Vận chuyển <b id="bDeleteName"></b>?<br />
                <%--<i class="text-danger">(Điều này đồng nghĩa việc xóa kèm theo lịch sử hoạt động!!!)</i>--%>
            </div>
            <div class="modal-footer">
                <a id="btn-modal-delete-close-quotation-route" class="btn btn-sm btn-default" data-dismiss="modal">Hủy</a>
                <a id="btn-do-delete-quotation-route" onclick="jobs.startdelete_quotation_route();" class="btn btn-sm btn-danger">Xóa</a>
            </div>
        </div>
    </div>
</div>
<div id="modal-info-quotation-route" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Thêm mới Báo giá Vận chuyển</h3>
            </div>
            <div class="modal-body">
                <div class="form-horizontal form-bordered">
                    <div class="form-group">
                        <label class="col-md-3 control-label">Từ</label>
                        <div id="divQuotationRoute_Place_Start" runat="server" class="col-md-3">
                        </div>
                        <label class="col-md-3 control-label">đến</label>
                        <div id="divQuotationRoute_Place_End" runat="server" class="col-md-3">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Hãng vận chuyển</label>
                        <div id="divQuotationRoute_TransportComps" class="col-md-9">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Loại xe</label>
                        <div id="divQuotationRoute_Vehicle_Types" class="col-md-3">
                        </div>
                        <label class="col-md-3 control-label">Tải trọng</label>
                        <div id="divQuotationRoute_Vehicle_Loads" class="col-md-3">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Báo giá từ Hãng</label>
                        <div id="divQuotationRoute_By_TransportCompanies" class="col-md-3">
                        </div>
                        <label class="col-md-3 control-label">Báo giá theo Khách hàng</label>
                        <div id="divQuotationRoute_By_Customers" class="col-md-3">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-12">
                            <div id="clickable-wizard-quotation-infos" class="form-horizontal form-bordered ui-formwizard">
                                <div id="tab-quotation" class="step ui-formwizard-content">
                                    <div class="form-group">
                                        <div class="col-xs-12">
                                            <ul class="nav nav-pills nav-justified clickable-steps">
                                                <li class="active"><a href="javascript:void(0)" data-gotostep="tab-quotation"><strong>1. Báo giá chi tiết</strong></a></li>
                                                <li><a href="javascript:void(0)" data-gotostep="tab-info"><strong>2. Thông tin bổ sung</strong></a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Giá</label>
                                        <div class="col-md-9">
                                            <input type="text" id="info-quotationroute-value-price" class="form-control" placeholder="Giá" style="width: auto;" onkeyup="globalhelpers.On_InputMoney_KeyPress(this);">
                                            <span class="help-block">(Dùng dấm chấm '.' để xác định số thập phân!)</span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Số lượng xe</label>
                                        <div class="col-md-9">
                                            <input type="text" id="info-quotationroute-value-quantity" class="form-control" placeholder="Số lượng xe" value="1" style="width: auto;">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Sử dụng đồng USD?</label>
                                        <div class="col-md-2">
                                            <label class='switch switch-success'>
                                                <input id="info-quotationroute-value-isusd" type='checkbox'><span></span></label>
                                        </div>
                                        <label class="col-md-3 control-label">Tỉ giá USD</label>
                                        <div class="col-md-4">
                                            <input type="text" id="info-quotationroute-info-usdrate" class="form-control" placeholder="1 USD = ? VND" style="width: auto;" value="0" onkeyup="globalhelpers.On_InputMoney_KeyPress(this);">
                                            <span class="help-block">(Dùng dấm chấm '.' để xác định số thập phân!)</span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Hiệu lực báo giá</label>
                                        <div class="col-md-9">
                                            <div class="input-group input-daterange" data-date-format="dd/mm/yyyy">
                                                <input type="text" id="info-quotationroute-value-expire-start" class="form-control text-center" placeholder="Từ ngày">
                                                <span class="input-group-addon"><i class="fa fa-angle-right"></i></span>
                                                <input type="text" id="info-quotationroute-value-expire-end" class="form-control text-center" placeholder="Đến ngày">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="tab-info" class="step ui-formwizard-content">
                                    <div class="form-group">
                                        <div class="col-xs-12">
                                            <ul class="nav nav-pills nav-justified clickable-steps">
                                                <li><a href="javascript:void(0)" data-gotostep="tab-quotation"><strong>1. Báo giá chi tiết</strong></a></li>
                                                <li class="active"><a href="javascript:void(0)" data-gotostep="tab-info"><strong>2. Thông tin bổ sung</strong></a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Giảm giá từ Hãng</label>
                                        <div class="col-md-3">
                                            <input type="text" id="info-quotationroute-info-comppromotion" class="form-control" placeholder="Giảm giá từ Hãng" style="width: auto;" value="0" onkeyup="globalhelpers.On_InputMoney_KeyPress(this);">
                                        </div>
                                        <label class="col-md-3 control-label">Phí phụ thu</label>
                                        <div class="col-md-3">
                                            <input type="text" id="info-quotationroute-info-extrafee" class="form-control" placeholder="Phí phụ thu (nếu có)" style="width: auto;" value="0" onkeyup="globalhelpers.On_InputMoney_KeyPress(this);">
                                        </div>
                                        <div class="col-md-3">
                                        </div>
                                        <div class="col-md-9">
                                            <span class="help-block">(Dùng dấm chấm '.' để xác định số thập phân!)</span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Ghi chú</label>
                                        <div class="col-md-9">
                                            <input type="text" id="info-quotationroute-info-description" class="form-control" placeholder="Ghi chú">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Biển số xe/Số hiệu Cont</label>
                                        <div class="col-md-3">
                                            <input type="text" id="info-quotationroute-info-vehicleno" class="form-control" placeholder="Biển số xe/Số hiệu Cont">
                                        </div>
                                        <label class="col-md-3 control-label">Số điện thoại tài xế</label>
                                        <div class="col-md-3">
                                            <input type="text" id="info-quotationroute-info-driverphone" class="form-control" placeholder="Số điện thoại tài xế">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Trọng lượng hàng</label>
                                        <div class="col-md-9">
                                            <input type="text" id="info-quotationroute-info-loads" class="form-control" placeholder="Trọng lượng hàng" style="width: auto;" value="0" onkeyup="globalhelpers.On_InputMoney_KeyPress(this);">
                                            <span class="help-block">(Dùng dấm chấm '.' để xác định số thập phân!)</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="divModalAlert" class="form-group" style="display: none;">
                        <div class="col-md-3">
                        </div>
                        <div id="divModalAlert-content" class="col-md-9">
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <a id="btn-modal-add-close" class="btn btn-sm btn-default" data-dismiss="modal">Hủy</a>
                <a id="btn-do-save-quotationroute" onclick="jobs.doAdd_quotation_route();" class="btn btn-sm btn-primary">Lưu</a>
            </div>
        </div>
    </div>
</div>
<div id="modal-info-quotation-customs-details" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Thêm mới Loại phí TTHQ</h3>
            </div>
            <div class="modal-body">
                <div class="form-horizontal form-bordered">
                    <div class="form-group">
                        <label class="col-md-3 control-label">Loại phí</label>
                        <div id="divQuotation_Customs_Detail_FeeTypes" class="col-md-3">
                        </div>
                        <label class="col-md-3 control-label">Số lượng Cont</label>
                        <div id="divQuotation_Customs_Detail_Quantity" class="col-md-3">
                            <input type="text" id="info-quotation-customs-detail-quantity" class="form-control" placeholder="Số lượng Cont" value="1" style="width: 100%;" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Ghi chú</label>
                        <div id="divQuotation_Customs_Detail_Description" class="col-md-9">
                            <input type="text" id="info-quotation-customs-detail-description" class="form-control" placeholder="Ghi chú" style="width: 100%;">
                        </div>
                    </div>
                    <div id="divModalAlert_Quotation_Customs_Detail" class="form-group" style="display: none;">
                        <div class="col-md-3">
                        </div>
                        <div id="divModalAlert-content_Quotation_Customs_Detail" class="col-md-9">
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <a id="btn-modal-add-close-quotation-customs-detail" class="btn btn-sm btn-default" data-dismiss="modal">Hủy</a>
                <a id="btn-do-save-quotation-customs-detail" onclick="jobs.doAdd_quotation_customs_detail_Temp();" class="btn btn-sm btn-primary">Lưu</a>
            </div>
        </div>
    </div>
</div>
<div id="modal-info-inoutfee" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Thêm mới Thu/Chi hộ</h3>
            </div>
            <div class="modal-body">
                <div class="form-horizontal form-bordered">
                    <div class="form-group">
                        <label class="col-md-3 control-label">Tên</label>
                        <div class="col-md-9">
                            <input type="text" id="info-inoutfee-name" class="form-control" placeholder="Tên mục Thu/Chi hộ" style="width: 100%;">
                            <%--<span class="help-block">(Dùng dấm chấm '.' để xác định số thập phân!)</span>--%>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Tên đơn vị</label>
                        <div class="col-md-9">
                            <input type="text" id="info-inoutfee-company" class="form-control" placeholder="Tên đơn vị xuất Hóa đơn" style="width: 100%;">
                            <%--<span class="help-block">(Dùng dấm chấm '.' để xác định số thập phân!)</span>--%>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Số hóa đơn</label>
                        <div class="col-md-9">
                            <input type="text" id="info-inoutfee-invoiceno" class="form-control" placeholder="Số Hóa đơn" style="width: auto;">
                            <%--<span class="help-block">(Dùng dấm chấm '.' để xác định số thập phân!)</span>--%>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Ngày xuất Hóa đơn</label>
                        <div class="col-md-9">
                            <input type="text" id="info-inoutfee-invoicedate" name="info-inoutfee-invoicedate" class="form-control input-datepicker" data-date-format="dd/mm/yyyy" placeholder="dd/mm/yyyy" style="width: auto;">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Số tiền</label>
                        <div class="col-md-9">
                            <input type="text" id="info-inoutfee-money" class="form-control" placeholder="Số tiền trên Hóa đơn" style="width: auto;" onkeyup="globalhelpers.On_InputMoney_KeyPress(this);">
                            <span class="help-block">(Dùng dấm chấm '.' để xác định số thập phân!)</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Sử dụng đồng USD?</label>
                        <div class="col-md-9">
                            <label class='switch switch-success'>
                                <input id="info-inoutfee-isusd" type='checkbox' checked><span></span></label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Tệp đính kèm</label>
                        <div class="col-md-9">
                            <span id="info-inoutfee-currentattached" class="help-block"></span>
                            <input type="file" id="info-inoutfee-attached">
                        </div>
                    </div>
                    <div id="divModalAlert-InOutFees" class="form-group" style="display: none;">
                        <div class="col-md-3">
                        </div>
                        <div id="divModalAlert-content-InOutFees" class="col-md-9">
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <a id="btn-modal-add-close-info-inoutfee" class="btn btn-sm btn-default" data-dismiss="modal">Hủy</a>
                <a id="btn-do-save-info-inoutfee" onclick="jobs.doAdd_inoutfee();" class="btn btn-sm btn-primary">Lưu</a>
            </div>
        </div>
    </div>
</div>
<div id="modal-delete-inoutfee" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-xs">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Xóa Thu/Chi hộ?</h3>
            </div>
            <div class="modal-body">
                Bạn chắc chắn muốn xóa Mục Thu/Chi hộ này?<br />
                <%--<i class="text-danger">(Điều này đồng nghĩa việc xóa kèm theo lịch sử hoạt động!!!)</i>--%>
            </div>
            <div class="modal-footer">
                <a id="btn-modal-delete-close-inoutfee" class="btn btn-sm btn-default" data-dismiss="modal">Hủy</a>
                <a id="btn-do-delete-inoutfee" onclick="jobs.startdelete_inoutfee();" class="btn btn-sm btn-danger">Xóa</a>
            </div>
        </div>
    </div>
</div>
<div id="modal-info-agentprepaid" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Thêm mới Tạm ứng</h3>
            </div>
            <div class="modal-body">
                <div class="form-horizontal form-bordered">
                    <div class="form-group">
                        <div class="col-xs-12">
                            <div class="form-group">
                                <label class="col-md-3 control-label">Nhân viên</label>
                                <div id="divAgentPrepaidEmployees" runat="server" class="col-md-9">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">Số tiền</label>
                                <div class="col-md-9">
                                    <input type="text" id="info-agentprepaid-money" class="form-control" placeholder="Số tiền tạm ứng" style="width: auto;" onkeyup="globalhelpers.On_InputMoney_KeyPress(this);">
                                    <span class="help-block">(Dùng dấm chấm '.' để xác định số thập phân!)</span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">Ghi chú</label>
                                <div class="col-md-9">
                                    <input type="text" id="info-agentprepaid-description" class="form-control" placeholder="Ghi chú" style="width: 100%;">
                                </div>
                            </div>
                            <div id="div-agentprepaid-result">
                                <div class="form-group">
                                    <label class="col-md-3 control-label">Chi thực tế</label>
                                    <div class="col-md-9">
                                        <input type="text" id="info-agentprepaid-totalpaid" class="form-control" placeholder="Số tiền đã chi thực tế" style="width: auto;" onkeyup="globalhelpers.On_InputMoney_KeyPress(this);">
                                        <span class="help-block">(Dùng dấm chấm '.' để xác định số thập phân!)</span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-3 control-label">Mục chi</label>
                                    <div id="divAgentPrepaidsJobWorkings" runat="server" class="col-md-9">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-12 table-responsive">
                                        <table id="tblList-agentprepaid" class="table table-vcenter table-striped table-condensed table-hover table-bordered">
                                            <thead>
                                                <tr>
                                                    <th class="text-center">Link</th>
                                                    <th class="text-center">#</th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbodyList-agentprepaids">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-3 control-label">Upload tệp đính kèm</label>
                                    <div class="col-md-9">
                                        <input type="file" id="info-agentprepaid-attached" onchange="jobs.onchange_agentprepaid_attachedfile(this);">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="divModalAlert-AgentPrepaids" class="form-group" style="display: none;">
                        <div class="col-md-3">
                        </div>
                        <div id="divModalAlert-content-AgentPrepaids" class="col-md-9">
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <a id="btn-modal-add-close-agentprepaid" class="btn btn-sm btn-default" data-dismiss="modal">Hủy</a>
                <a id="btn-do-save-agentprepaid" onclick="jobs.doAdd_agentprepaid();" class="btn btn-sm btn-primary">Lưu</a>
                <a id="btn-do-confirm-agentprepaid" onclick="jobs.doConfirm_agentprepaid();" class="btn btn-sm btn-success">Duyệt chi</a>
            </div>
        </div>
    </div>
</div>
<div id="modal-delete-agentprepaid" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-xs">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Xóa Tạm ứng?</h3>
            </div>
            <div class="modal-body">
                Bạn chắc chắn muốn xóa Tạm ứng này?<br />
                <%--<i class="text-danger">(Điều này đồng nghĩa việc xóa kèm theo lịch sử hoạt động!!!)</i>--%>
            </div>
            <div class="modal-footer">
                <a id="btn-modal-delete-close-agentprepaid" class="btn btn-sm btn-default" data-dismiss="modal">Hủy</a>
                <a id="btn-do-delete-agentprepaid" onclick="jobs.dodelete_agentprepaid();" class="btn btn-sm btn-danger">Xóa</a>
            </div>
        </div>
    </div>
</div>
<div id="modal-info-jobprepaid" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Thêm mới Tạm ứng</h3>
            </div>
            <div class="modal-body">
                <div class="form-horizontal form-bordered">

                    <div class="form-group">
                        <div class="col-xs-12">
                            <div class="form-group">
                                <label class="col-md-3 control-label">Số tiền tạm ứng khả dụng</label>
                                <label id="divInfo-jobprepaid-prepaids" class="col-md-9 control-label" style="text-align: left;"></label>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">Số tiền</label>
                                <div class="col-md-9">
                                    <input type="text" id="info-jobprepaid-money" class="form-control" placeholder="Số tiền chi từ tạm ứng" style="width: auto;" onkeyup="globalhelpers.On_InputMoney_KeyPress(this);">
                                    <span class="help-block">(Dùng dấm chấm '.' để xác định số thập phân!)</span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">Ghi chú</label>
                                <div class="col-md-9">
                                    <input type="text" id="info-jobprepaid-description" class="form-control" placeholder="Ghi chú" style="width: 100%;">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="divModalAlert-jobprepaid" class="form-group" style="display: none;">
                        <div class="col-md-3">
                        </div>
                        <div id="divModalAlert-content-jobprepaid" class="col-md-9">
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <a id="btn-modal-add-close-jobprepaid" class="btn btn-sm btn-default" data-dismiss="modal">Hủy</a>
                <a id="btn-do-save-jobprepaid" onclick="jobs.doAdd_jobprepaid();" class="btn btn-sm btn-primary">Lưu</a>
            </div>
        </div>
    </div>
</div>
<div id="modal-delete-jobprepaid" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-xs">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Xóa Chi tạm ứng?</h3>
            </div>
            <div class="modal-body">
                Bạn chắc chắn muốn xóa Chi tạm ứng này?<br />
                <%--<i class="text-danger">(Điều này đồng nghĩa việc xóa kèm theo lịch sử hoạt động!!!)</i>--%>
            </div>
            <div class="modal-footer">
                <a id="btn-modal-delete-close-jobprepaid" class="btn btn-sm btn-default" data-dismiss="modal">Hủy</a>
                <a id="btn-do-delete-jobprepaid" onclick="jobs.dodelete_jobprepaid();" class="btn btn-sm btn-danger">Xóa</a>
            </div>
        </div>
    </div>
</div>
<div id="modal-info-jobgood" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Thêm mới Danh mục hàng hóa</h3>
            </div>
            <div class="modal-body">
                <div class="form-horizontal form-bordered">
                    <div class="form-group">
                        <label class="col-md-3 control-label">Mã hàng</label>
                        <div class="col-md-9">
                            <input type="text" id="info-jobgood-code" class="form-control" placeholder="Mã hàng" style="width: 100%;">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Tên</label>
                        <div class="col-md-9">
                            <input type="text" aria-multiline="true" id="info-jobgood-name" class="form-control" placeholder="Tên hàng" style="width: 100%;">
                        </div>
                    </div>
                    <div id="divModalAlert-JobGood" class="form-group" style="display: none;">
                        <div class="col-md-3">
                        </div>
                        <div id="divModalAlert-content-JobGood" class="col-md-9">
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <a id="btn-modal-add-close-info-jobgood" class="btn btn-sm btn-default" data-dismiss="modal">Hủy</a>
                <a id="btn-do-save-info-jobgood" onclick="jobs.doadd_jobgood();" class="btn btn-sm btn-primary">Lưu</a>
            </div>
        </div>
    </div>
</div>
<div id="modal-delete-jobgood" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-xs">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Xóa Danh mục Hàng hóa</h3>
            </div>
            <div class="modal-body">
                Bạn chắc chắn muốn xóa Danh mục Hàng hóa này?<br />
                <%--<i class="text-danger">(Điều này đồng nghĩa việc xóa kèm theo lịch sử hoạt động!!!)</i>--%>
            </div>
            <div class="modal-footer">
                <a id="btn-modal-delete-close-jobgood" class="btn btn-sm btn-default" data-dismiss="modal">Hủy</a>
                <a id="btn-do-delete-jobgood" onclick="jobs.startdelete_jobgood();" class="btn btn-sm btn-danger">Xóa</a>
            </div>
        </div>
    </div>
</div>
<div id="modal-flow-requestconfirm" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Chuyển Giám đốc duyệt</h3>
            </div>
            <div class="modal-body">
                <div class="form-horizontal form-bordered">

                    <div class="form-group">
                        <div class="col-md-12">
                            <div class="alert alert-info">
                                <p><i class="fa fa-fw fa-info-circle"></i><b>&nbsp;Lưu ý:</b></p>
                                <ul class="fa-ul list-li-push" style="margin-top: 10px;">
                                    <li><i class="fa fa-li fa-bolt text-warning"></i>&nbsp;Khi tiến hành chuyển Giám đốc duyệt, các đơn vận chuyển sẽ được tự động chuyển sang Đã hoàn tất (nếu có)</li>
                                    <li><i class="fa fa-li fa-bolt text-warning"></i>&nbsp;Mặc định, hệ thống sẽ căn cứ vào tỉ giá USD ở từng nội dung để tính toán giá trị JOB, nếu muốn đồng nhất tỉ giá - chuyển sang chế độ <b>Đồng nhất tỉ giá</b></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Đồng nhất tỉ giá?</label>
                        <div class="col-md-9">
                            <label class='switch switch-success'>
                                <input id="flow-requestconfirm-isuniform" type='checkbox' onchange="jobs.onchange_flow_requestconfirm_isuniform(this);"><span></span>
                            </label>
                        </div>
                    </div>
                    <div id="div-flow-requestconfirm-isuniform" class="form-group" style="display: none;">
                        <label class="col-md-3 control-label">Tỉ giá USD</label>
                        <div class="col-md-9">
                            <input type="text" id="flow-requestconfirm-usdrate" class="form-control" placeholder="1 USD = ? VND" style="width: auto;" value="0" onkeyup="globalhelpers.On_InputMoney_KeyPress(this);">
                            <span class="help-block">(Dùng dấm chấm '.' để xác định số thập phân! Đây là tỉ giá USD tạm thời, được sử dụng để tính toán trong quá trình xử lý JOB. Nếu trong JOB có sử dụng đồng USD (ở các tính năng: Thu/Chi hộ, ...) thì phải cung cấp tỉ giá này!)</span>
                        </div>
                    </div>
                    <div id="divModalAlert-flow-requestconfirm" class="form-group" style="display: none;">
                        <div class="col-md-3">
                        </div>
                        <div id="divModalAlert-content-flow-requestconfirm" class="col-md-9">
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <a id="btn-modal-cancel-flow-requestconfirm-jobgood" class="btn btn-sm btn-default" data-dismiss="modal">Hủy</a>
                <a id="btn-modal-do-save-flow-requestconfirm-jobgood" onclick="jobs.doflow_requestconfirm();" class="btn btn-sm btn-primary">Chuyển</a>
            </div>
        </div>
    </div>
</div>
<div id="modal-flow-sendback" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-xs">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Chuyển trả chờ bổ sung?</h3>
            </div>
            <div class="modal-body">
                Bạn chắc chắn muốn chuyển lại yêu cầu bổ sung thông tin?<br />
                <%--<i class="text-danger">(Điều này đồng nghĩa việc xóa kèm theo lịch sử hoạt động!!!)</i>--%>
            </div>
            <div class="modal-footer">
                <a id="btn-modal-flow-close-sendback" class="btn btn-sm btn-default" data-dismiss="modal">Hủy</a>
                <a id="btn-modal-flow-do-sendback" onclick="jobs.doflow_sendback();" class="btn btn-sm btn-danger">Yêu cầu bổ sung</a>
            </div>
        </div>
    </div>
</div>
<div id="modal-flow-finishjob" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-xs">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Xác nhận hoàn tất JOB?</h3>
            </div>
            <div class="modal-body">
                Bạn chắc chắn muốn xác nhận hoàn tất JOB này?<br />
                <%--<i class="text-danger">(Điều này đồng nghĩa việc xóa kèm theo lịch sử hoạt động!!!)</i>--%>
            </div>
            <div class="modal-footer">
                <a id="btn-modal-flow-close-finishjob" class="btn btn-sm btn-default" data-dismiss="modal">Hủy</a>
                <a id="btn-modal-flow-do-finishjob" onclick="jobs.doflow_finishjob();" class="btn btn-sm btn-danger">Xác nhận</a>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var jobs =
        {
            ajaxPath: '/ajax/modules/functions/jobs.aspx',
            mode: 'create',
            mode_quotationroute: 'create',
            mode_quotationcustoms_detail: 'create',
            permissions: null,
            currentobj: null,
            currentobj_quotation_route: null,
            currentjobID: '',
            allComps: null,
            allQuotation_Comp: null,
            allQuotation_Customer: null,
            allInOutFees: null,

            allCustomsFeeTypes: null,
            allQuotationCustoms_BySmiles: null,

            allowEmployeeEdit: true,

            alert_quotation_route: function (content) {
                $('#divModalAlert').show();
                $('#divModalAlert-content').html(
                    '<div class="alert alert-danger alert-dismissable">' +
                        '<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>' +
                        '<h4><i class="fa fa-times-circle"></i>&nbsp;Lỗi</h4>' +
                        content +
                    '</div>'
                    );
            },

            alert_quotation_customs: function (content) {
                $('#divModalAlert-quotation-customs').show();
                $('#divModalAlert-quotation-customs-content').html(
                    '<div class="alert alert-danger alert-dismissable">' +
                        '<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>' +
                        '<h4><i class="fa fa-times-circle"></i>&nbsp;Lỗi</h4>' +
                        content +
                    '</div>'
                    );
            },

            alert_flow_requestconfirm: function (content) {
                $('#divModalAlert-flow-requestconfirm').show();
                $('#divModalAlert-content-flow-requestconfirm').html(
                    '<div class="alert alert-danger alert-dismissable">' +
                        '<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>' +
                        '<h4><i class="fa fa-times-circle"></i>&nbsp;Lỗi</h4>' +
                        content +
                    '</div>'
                    );
            },

            permissionCanEditAll: 'Job_Nghiepvu_XacnhanHoantat',
            init: function () {
                var sQuotation = $("#clickable-wizard-quotation-infos");
                sQuotation.formwizard({ disableUIStyles: !0, inDuration: 0, outDuration: 0 });
                $("#clickable-wizard-quotation-infos .clickable-steps a").on("click", function ()
                { var rQuotation = $(this).data("gotostep"); sQuotation.formwizard("show", rQuotation) });

                var sAgentPrepaids = $("#clickable-wizard-agentprepaids");
                sAgentPrepaids.formwizard({ disableUIStyles: !0, inDuration: 0, outDuration: 0 });
                $("#clickable-wizard-agentprepaids .clickable-steps a").on("click", function ()
                { var rAgentPrepaids = $(this).data("gotostep"); sAgentPrepaids.formwizard("show", rAgentPrepaids) });

                var sObj = '<%= _JobDetail %>';
                if (sObj == '')
                    this.currentobj = null;
                else
                    this.currentobj = JSON.parse(sObj);

                this.allowEmployeeEdit = this.currentobj.Status == 0 || this.currentobj.Status == 3;

                //----- PERMISSIONS -----

                var sPermissions = '<%= _RolePermissions %>';
                if (sPermissions != '')
                    this.permissions = JSON.parse(sPermissions);

                if (!jobs.allowEmployeeEdit) {
                    if (globalhelpers.HasPermission(jobs.permissionCanEditAll, jobs.permissions))
                        $('#btn-do-save-info').show();
                    else
                        $('#btn-do-save-info').hide();
                }
                else {
                    if (!globalhelpers.HasPermission("edit", jobs.permissions))
                        $('#btn-do-save-info').hide();
                    else
                        $('#btn-do-save-info').show();
                }


                if (!jobs.allowEmployeeEdit) {
                    if (globalhelpers.HasPermission(jobs.permissionCanEditAll, jobs.permissions))
                        $('#btn-do-save-status').show();
                    else
                        $('#btn-do-save-status').hide();
                }
                else {
                    if (!globalhelpers.HasPermission("Job_Trangthai_Capnhat", jobs.permissions))
                        $('#btn-do-save-status').hide();
                    else
                        $('#btn-do-save-status').show();
                }

                //Job status
                if (this.currentobj.Status == 0 || this.currentobj.Status == 3) {
                    if (!jobs.allowEmployeeEdit) {
                        if (globalhelpers.HasPermission(jobs.permissionCanEditAll, jobs.permissions))
                            $('#btn-job-status-requestconfirm').show();
                        else
                            $('#btn-job-status-requestconfirm').hide();
                    }
                    else {
                        if (globalhelpers.HasPermission("Job_Nghiepvu_GiamdocDuyet", jobs.permissions))
                            $('#btn-job-status-requestconfirm').show();
                        else
                            $('#btn-job-status-requestconfirm').hide();
                    }
                }
                else $('#btn-job-status-requestconfirm').hide();

                if (this.currentobj.Status == 2) {
                    if (!jobs.allowEmployeeEdit) {
                        if (globalhelpers.HasPermission(jobs.permissionCanEditAll, jobs.permissions))
                            $('#btn-job-status-requestaccountant').show();
                        else
                            $('#btn-job-status-requestaccountant').hide();
                    }
                    else {
                        if (globalhelpers.HasPermission("Job_Nghiepvu_ChuyenKetoan", jobs.permissions))
                            $('#btn-job-status-requestaccountant').show();
                        else
                            $('#btn-job-status-requestaccountant').hide();
                    }
                }
                else $('#btn-job-status-requestaccountant').hide();

                if (this.currentobj.Status == 2) {
                    if (!jobs.allowEmployeeEdit) {
                        if (globalhelpers.HasPermission(jobs.permissionCanEditAll, jobs.permissions))
                            $('#btn-job-status-requestaccountant').show();
                        else
                            $('#btn-job-status-requestaccountant').hide();
                    }
                    else {
                        if (globalhelpers.HasPermission("Job_Nghiepvu_ChuyenNhanvien", jobs.permissions))
                            $('#btn-job-status-requestaccountant').show();
                        else
                            $('#btn-job-status-requestaccountant').hide();
                    }
                }
                else $('#btn-job-status-requestaccountant').hide();

                if (this.currentobj.Status == 2) {
                    if (!jobs.allowEmployeeEdit) {
                        if (globalhelpers.HasPermission(jobs.permissionCanEditAll, jobs.permissions))
                            $('#btn-job-status-finish').show();
                        else
                            $('#btn-job-status-finish').hide();
                    }
                    else {
                        if (globalhelpers.HasPermission("Job_Nghiepvu_XacnhanHoantat", jobs.permissions))
                            $('#btn-job-status-finish').show();
                        else
                            $('#btn-job-status-finish').hide();
                    }
                }
                else $('#btn-job-status-finish').hide();


                //Permission: Tạm ứng KH

                if (!jobs.allowEmployeeEdit) {
                    if (globalhelpers.HasPermission(jobs.permissionCanEditAll, jobs.permissions))
                        $('#btn-do-add-customerpayment').show();
                    else
                        $('#btn-do-add-customerpayment').hide();
                }
                else {
                    if (!globalhelpers.HasPermission("Job_TamungKH_Them", jobs.permissions))
                        $('#btn-do-add-customerpayment').hide();
                    else
                        $('#btn-do-add-customerpayment').show();
                }

                if (!jobs.allowEmployeeEdit) {
                    if (globalhelpers.HasPermission(jobs.permissionCanEditAll, jobs.permissions))
                        $('#btn-do-save-customerpayment').show();
                    else
                        $('#btn-do-save-customerpayment').hide();
                }
                else {
                    if (!globalhelpers.HasPermission("Job_TamungKH_Capnhat", jobs.permissions))
                        $('#btn-do-save-customerpayment').hide();
                    else
                        $('#btn-do-save-customerpayment').show();
                }

                //Permission: Hàng hóa

                if (!jobs.allowEmployeeEdit) {
                    if (globalhelpers.HasPermission(jobs.permissionCanEditAll, jobs.permissions))
                        $('#btn-info-add-jobgoods').show();
                    else
                        $('#btn-info-add-jobgoods').hide();
                }
                else {
                    if (!globalhelpers.HasPermission("Job_DMHanghoa_Them", jobs.permissions))
                        $('#btn-info-add-jobgoods').hide();
                    else
                        $('#btn-info-add-jobgoods').show();
                }

                //Permission: TTHQ

                if (!jobs.allowEmployeeEdit) {
                    if (globalhelpers.HasPermission(jobs.permissionCanEditAll, jobs.permissions))
                        $('#btn-do-add-quotationcustoms').show();
                    else
                        $('#btn-do-add-quotationcustoms').hide();
                }
                else {
                    if (!globalhelpers.HasPermission("Job_TTHQ_Them", jobs.permissions))
                        $('#btn-do-add-quotationcustoms').hide();
                    else
                        $('#btn-do-add-quotationcustoms').show();
                }

                if (!jobs.allowEmployeeEdit) {
                    if (globalhelpers.HasPermission(jobs.permissionCanEditAll, jobs.permissions))
                        $('#btn-do-save-quotationcustoms').show();
                    else
                        $('#btn-do-save-quotationcustoms').hide();
                }
                else {
                    if (!globalhelpers.HasPermission("Job_TTHQ_Capnhat", jobs.permissions))
                        $('#btn-do-save-quotationcustoms').hide();
                    else
                        $('#btn-do-save-quotationcustoms').show();
                }

                //Permission: Routes

                if (!jobs.allowEmployeeEdit) {
                    if (globalhelpers.HasPermission(jobs.permissionCanEditAll, jobs.permissions))
                        $('#btn-do-add-quotationroute').show();
                    else
                        $('#btn-do-add-quotationroute').hide();
                }
                else {
                    if (!globalhelpers.HasPermission("Job_Vanchuyen_Them", jobs.permissions))
                        $('#btn-do-add-quotationroute').hide();
                    else
                        $('#btn-do-add-quotationroute').show();
                }

                //Permission: InOutFees

                if (!jobs.allowEmployeeEdit) {
                    if (globalhelpers.HasPermission(jobs.permissionCanEditAll, jobs.permissions))
                        $('#btn-do-add-inoutfee').show();
                    else
                        $('#btn-do-add-inoutfee').hide();
                }
                else {
                    if (!globalhelpers.HasPermission("Job_Thuchi_Them", jobs.permissions))
                        $('#btn-do-add-inoutfee').hide();
                    else
                        $('#btn-do-add-inoutfee').show();
                }

                //Permission: AgentPrepaids

                if (!jobs.allowEmployeeEdit) {
                    if (globalhelpers.HasPermission(jobs.permissionCanEditAll, jobs.permissions))
                        $('#btn-do-add-agentprepaid').show();
                    else
                        $('#btn-do-add-agentprepaid').hide();
                }
                else {
                    if (!globalhelpers.HasPermission("Job_TamungNV_Them_Yeucau", jobs.permissions))
                        $('#btn-do-add-agentprepaid').hide();
                    else
                        $('#btn-do-add-agentprepaid').show();
                }

                //-------------------------------------------------

                if (this.currentobj != null) {
                    this.currentjobID = this.currentobj.JobID;
                    $('.block-related-edit').show();
                    this.startEdit();
                }
                else {
                    this.currentjobID = '<%= _JobID %>';
                    $('.block-related-edit').hide();
                    this.startAdd();
                }

                var sComps = '<%= _AllCompanies %>';
                if (sComps == '')
                    this.allComps = null;
                else
                    this.allComps = JSON.parse(sComps);

                var sCustomsFeeTypes = '<%= _AllCustomsFeeTypes %>';
                if (sCustomsFeeTypes == '')
                    this.allCustomsFeeTypes = null;
                else
                    this.allCustomsFeeTypes = JSON.parse(sCustomsFeeTypes);

                this.generate_quotationcustoms_feetypes();

                var sQuotationCustoms_Smiles = '<%= _AllCustomerQuotation_Smiles %>';
                if (sQuotationCustoms_Smiles == '')
                    this.allQuotationCustoms_BySmiles = null;
                else
                    this.allQuotationCustoms_BySmiles = JSON.parse(sQuotationCustoms_Smiles);

                this.generate_companies();
                this.generate_quotationcustoms_controls_bysmiles();
                this.generate_quotationcustoms_values();
                this.loadlist_inoutfees();
                this.loadlist_jobgoods();
                this.loadlist_agentprepaid();
                this.loadlist_jobprepaid();
            },

            //-----------------------------------------------------------------------------------------------

            doflow_start_finishjob: function () {
                $('#btn-modal-flow-do-finishjob').html('Hoàn tất');
                $('#modal-flow-finishjob').modal('show');
            },

            doflow_finishjob: function () {
                var postdata = jobs.validateform_flow_finishjob();
                if (postdata == null)
                    return;

                NProgress.start();
                $('#btn-modal-flow-do-finishjob').addClass('disabled');
                $('#btn-modal-flow-do-finishjob').html('Đang xử lý...');

                var xhr = new XMLHttpRequest();
                xhr.open('POST', jobs.ajaxPath + '?ts=' + new Date().getTime().toString());
                xhr.onload = function () {
                    NProgress.done();

                    var result = JSON.parse(xhr.responseText);
                    $('#btn-modal-flow-do-finishjob').removeClass('disabled');
                    $('#btn-modal-flow-do-finishjob').html('Xác nhận');
                    alert(result.Message);

                    if (result.ErrorCode == 0) {
                        jobs.reloadpage();
                    }
                };

                var form = new FormData();
                form.append('mod', 'flow_finishjob');
                form.append('data', JSON.stringify(postdata));

                xhr.send(form);
            },

            validateform_flow_finishjob: function () {
                var message = '';
                var data = new Object();

                data.jobid = jobs.currentobj.ID;

                return data;
            },

            //-----------------------------------------------------------------------------------------------
            doflow_start_sendback: function () {
                $('#btn-modal-flow-do-sendback').html('Yêu cầu bổ sung');
                $('#modal-flow-sendback').modal('show');
            },

            doflow_sendback: function () {
                var postdata = jobs.validateform_flow_sendback();
                if (postdata == null)
                    return;

                NProgress.start();
                $('#btn-modal-flow-do-sendback').addClass('disabled');
                $('#btn-modal-flow-do-sendback').html('Đang xử lý...');

                var xhr = new XMLHttpRequest();
                xhr.open('POST', jobs.ajaxPath + '?ts=' + new Date().getTime().toString());
                xhr.onload = function () {
                    NProgress.done();

                    var result = JSON.parse(xhr.responseText);
                    $('#btn-modal-flow-do-sendback').removeClass('disabled');
                    $('#btn-modal-flow-do-sendback').html('Yêu cầu bổ sung');
                    alert(result.Message);

                    if (result.ErrorCode == 0) {
                        jobs.reloadpage();
                    }
                };

                var form = new FormData();
                form.append('mod', 'flow_sendback');
                form.append('data', JSON.stringify(postdata));

                xhr.send(form);
            },

            validateform_flow_sendback: function () {
                var message = '';
                var data = new Object();

                data.jobid = jobs.currentobj.ID;

                return data;
            },

            //-----------------------------------------------------------------------------------------------

            doflow_start_requestConfirm: function () {
                $('#btn-modal-do-save-flow-requestconfirm-jobgood').html('Chuyển');
                $('#modal-flow-requestconfirm').modal('show');
                //$('#btn-do-confirm-jobgood').hide();
            },

            onchange_flow_requestconfirm_isuniform: function (ctrl) {
                if ($(ctrl).prop('checked'))
                    $('#div-flow-requestconfirm-isuniform').show();
                else
                    $('#div-flow-requestconfirm-isuniform').hide();
            },

            doflow_requestconfirm: function () {
                var postdata = jobs.validateform_flow_requestconfirm();
                if (postdata == null)
                    return;

                NProgress.start();
                $('#btn-modal-do-save-flow-requestconfirm-jobgood').addClass('disabled');
                $('#btn-modal-do-save-flow-requestconfirm-jobgood').html('Đang xử lý...');

                var xhr = new XMLHttpRequest();
                xhr.open('POST', jobs.ajaxPath + '?ts=' + new Date().getTime().toString());
                xhr.onload = function () {
                    NProgress.done();

                    var result = JSON.parse(xhr.responseText);
                    $('#btn-modal-do-save-flow-requestconfirm-jobgood').removeClass('disabled');
                    $('#btn-modal-do-save-flow-requestconfirm-jobgood').html('Chuyển');
                    alert(result.Message);

                    if (result.ErrorCode == 0) {
                        jobs.reloadpage();
                    }
                };

                var form = new FormData();
                form.append('mod', 'flow_requestconfirm');
                form.append('data', JSON.stringify(postdata));

                xhr.send(form);
            },

            validateform_flow_requestconfirm: function () {
                var message = '';
                var data = new Object();

                data.jobid = jobs.currentobj.ID;

                data.isuniform = $('#flow-requestconfirm-isuniform').prop('checked');
                data.usdrate = Number(globalhelpers.Convert_FromMoney($('#flow-requestconfirm-usdrate').val()));
                if (data.isuniform && (isNaN(data.usdrate) || data.usdrate <= 0))
                    message += '- Tỉ giá USD không hợp lệ!<br/>';

                if (message != '') {
                    jobs.alert_flow_requestconfirm(message);
                    return null;
                }

                return data;
            },

            //-----------------------------------------------------------------------------------------------

            mode_jobgood: 'create',
            currentobj_jobgood: null,
            loadlist_jobgoods: function () {
                var html =
                    "<table id=\"tblList_JobGoods\" class=\"table table-vcenter table-striped table-condensed table-hover table-bordered\">" +
                        "<thead>" +
                            "<tr>" +
                                "<th class=\"text-center\">STT</th>" +
                                "<th class=\"text-center\">Mã hàng</th>" +
                                "<th class=\"text-center\">Tên hàng hóa</th>" +
                                "<th class=\"text-center\">#</th>" +
                            "</tr>" +
                        "</thead>" +
                        "<tbody>";

                if (jobs.currentobj.List_JobGoods == null) {
                    html +=
                        "<tr>" +
                            "<td class=\"text-center\" colspan=\"4\">" +
                                "Không có dữ liệu!" +
                            "</td>" +
                        "</tr>";
                }
                else {
                    for (var i = 0; i < jobs.currentobj.List_JobGoods.length; i++) {
                        var obj = jobs.currentobj.List_JobGoods[i];

                        html +=
                            "<tr>" +
                                "<td class=\"text-center\">" +
                                    (i + 1) +
                                "</td>" +
                                "<td class=\"text-center\">" + obj.Code + "</td>" +
                                "<td class=\"text-center\">" + obj.Name + "</td>" +
                                "<td class=\"text-center\">" +
                                        (!globalhelpers.HasPermission("Job_DMHanghoa_Sua", jobs.permissions) ? "" : "<a onclick=\"jobs.startedit_jobgood('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Sửa\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-pencil\"></i></a>") +
                                        (!globalhelpers.HasPermission("Job_DMHanghoa_Xoa", jobs.permissions) ? "" : "<a onclick=\"jobs.startdelete_jobgood('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Xóa\" class=\"btn btn-xs btn-danger\"><i class=\"fa fa-times\"></i></a>") +
                                "</td>" +
                            "</tr>";
                    }
                }

                html += "</tbody></table>";

                $('#divJobGoods').html(html);

                $('[data-toggle="tooltip"]').tooltip();
                //                    });
            },

            startadd_jobgood: function () {
                this.mode_jobgood = 'create';
                $('#modal-info-jobgood .modal-header .modal-title').html('Thêm mới Danh mục Hàng hóa');
                $('#btn-do-save-jobgood').html('Thêm');
                $('#modal-info-jobgood').modal('show');
                $('#btn-do-confirm-jobgood').hide();
            },

            doadd_jobgood: function () {
                var postdata = jobs.validateForm_jobgood();
                if (postdata == null)
                    return;

                NProgress.start();
                $('#btn-do-save-jobgood').addClass('disabled');
                $('#btn-do-save-jobgood').html('Đang xử lý...');

                var xhr = new XMLHttpRequest();
                xhr.open('POST', jobs.ajaxPath + '?ts=' + new Date().getTime().toString());
                xhr.onload = function () {
                    NProgress.done();

                    var result = JSON.parse(xhr.responseText);
                    $('#btn-do-save-jobgood').removeClass('disabled');
                    $('#btn-do-save-jobgood').html(jobs.mode_jobgood == 'create' ? 'Thêm' : 'Lưu');
                    alert(result.Message);

                    if (result.ErrorCode == 0) {
                        jobs.reloadpage();
                    }
                };

                var form = new FormData();
                form.append('mod', this.mode_jobgood + '_jobgood');
                form.append('data', JSON.stringify(postdata));

                xhr.send(form);
            },

            validateForm_jobgood: function () {
                var message = '';
                var data = new Object();

                data.jobid = jobs.currentobj.ID;

                data.name = $('#info-jobgood-name').val();
                if (data.name == '')
                    message += '- Tên không hợp lệ!<br/>';

                data.code = $('#info-jobgood-code').val();
                if (data.code == '')
                    message += '- Mã không hợp lệ!<br/>';

                data.id = jobs.mode_jobgood == "create" ? 0 : jobs.currentobj_jobgood.ID;

                return data;
            },

            startedit_jobgood: function (id) {
                jobs.mode_jobgood = 'edit';
                jobs.currentobj_jobgood = jobs.getobj(id, this.currentobj.List_JobGoods);
                if (jobs.currentobj_jobgood == null) {
                    alert('Không tìm thấy Danh mục Hàng hóa!');
                    return;
                }

                $('#info-jobgood-code').val(jobs.currentobj_jobgood.Code);
                $('#info-jobgood-name').val(jobs.currentobj_jobgood.Name);

                $('#modal-info-jobgood .modal-header .modal-title').html('Cập nhật Danh mục Hàng hóa');
                $('#btn-do-save-jobgood').html('Lưu');
                $('#modal-info-jobgood').modal('show');
            },

            startdelete_jobgood: function (id) {
                jobs.currentobj_jobgood = jobs.getobj(id, jobs.currentobj.List_JobGoods);
                if (jobs.currentobj_jobgood == null) {
                    alert('Không tìm thấy Danh mục Hàng hóa!');
                    return;
                }

                $('#modal-delete-jobgood').modal('show');
            },

            dodelete_jobgood: function () {
                NProgress.start();
                $('#btn-do-delete-jobgood').addClass('disabled');
                $('#btn-modal-delete-close-jobgood').addClass('disabled');
                $('#btn-do-delete-jobgood').html('Đang xử lý...');

                $.post(jobs.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': 'delete_jobgood', 'id': jobs.currentobj_jobgood.ID },
                                function (data) {
                                    NProgress.done();

                                    var result = JSON.parse(data);
                                    $('#btn-do-delete-jobgood').removeClass('disabled');
                                    $('#btn-modal-delete-close-jobgood').removeClass('disabled');
                                    $('#btn-do-delete-jobgood').html('Xóa');
                                    alert(result.Message);

                                    if (result.ErrorCode == 0)
                                        jobs.reloadpage();
                                });
            },

            //-----------------------------------------------------------------------------------------------

            mode_jobprepaid: 'create',
            currentobj_jobprepaid: null,
            loadlist_jobprepaid: function () {
                var html = "";

                if (jobs.currentobj.List_JobPrepaids == null) {
                    html +=
                        "<tr>" +
                            "<td class=\"text-center\" colspan=\"4\">" +
                                "Không có dữ liệu!" +
                            "</td>" +
                        "</tr>";
                }
                else {
                    for (var i = 0; i < jobs.currentobj.List_JobPrepaids.length; i++) {
                        var obj = jobs.currentobj.List_JobPrepaids[i];

                        html +=
                            "<tr>" +
                                "<td class=\"text-center\">" + obj.sPrepaidDate + "</td>" +
                                "<td class=\"text-center\">" + globalhelpers.Format_Money(obj.Money.toFixed(2)) + "</td>" +
                                "<td class=\"text-center\">" + obj.Description + "</td>" +
                                "<td class=\"text-center\">" +
                                    (!globalhelpers.HasPermission("Job_TamungKH_Sua", jobs.permissions) ? "" : "<a onclick=\"jobs.startedit_jobprepaid('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Sửa\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-pencil\"></i></a>") +
                                    (!globalhelpers.HasPermission("Job_TamungKH_Xoa", jobs.permissions) ? "" : "<a onclick=\"jobs.startdelete_jobprepaid('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Xóa\" class=\"btn btn-xs btn-danger\"><i class=\"fa fa-times\"></i></a>") +
                                "</td>" +
                            "</tr>";
                    }
                }

                html += "</tbody></table>";

                $('#tbodyList_CustomerPrepaids').html(html);

                $('[data-toggle="tooltip"]').tooltip();
            },

            startAdd_jobprepaid: function () {
                this.mode_jobprepaid = 'create';
                $('#modal-info-jobprepaid .modal-header .modal-title').html('Thêm mới Chi tạm ứng');
                $('#btn-do-save-jobprepaid').html('Thêm');
                $('#modal-info-jobprepaid').modal('show');
                $('#divInfo-jobprepaid-prepaids').html(globalhelpers.Format_Money(this.currentobj.Customer.Prepaids.toFixed(2)));
            },

            validateForm_jobprepaid: function () {
                var message = '';
                var data = new Object();

                data.jobid = jobs.currentobj.ID;

                data.description = $('#info-jobprepaid-description').val();

                data.money = Number(globalhelpers.Convert_FromMoney($('#info-jobprepaid-money').val()));
                if (isNaN(data.money))
                    message += '- Số tiền chi không hợp lệ!<br/>';

                var addMoney = this.currentobj_jobprepaid == null ? data.money : (data.money - this.currentobj_jobprepaid.Money);
                if (this.currentobj.Customer.Prepaids < addMoney)
                    message += '- Số tiền tạm ứng của Khách hàng không đủ!<br/>';

                data.id = jobs.mode_jobprepaid == "create" ? 0 : jobs.currentobj_jobprepaid.ID;

                return data;
            },

            doAdd_jobprepaid: function () {
                var postdata = jobs.validateForm_jobprepaid();
                if (postdata == null)
                    return;

                NProgress.start();
                $('#btn-do-save-jobprepaid').addClass('disabled');
                $('#btn-do-save-jobprepaid').html('Đang xử lý...');

                var xhr = new XMLHttpRequest();
                xhr.open('POST', jobs.ajaxPath + '?ts=' + new Date().getTime().toString());
                xhr.onload = function () {
                    NProgress.done();

                    var result = JSON.parse(xhr.responseText);
                    $('#btn-do-save-jobprepaid').removeClass('disabled');
                    $('#btn-do-save-jobprepaid').html(jobs.mode_jobprepaid == 'create' ? 'Thêm' : 'Lưu');
                    alert(result.Message);

                    if (result.ErrorCode == 0) {
                        jobs.reloadpage();
                    }
                };

                var form = new FormData();
                form.append('mod', this.mode_jobprepaid + '_jobprepaid');
                form.append('data', JSON.stringify(postdata));

                xhr.send(form);
            },

            startedit_jobprepaid: function (id) {
                jobs.mode_jobprepaid = 'edit';
                jobs.currentobj_jobprepaid = jobs.getobj(id, this.currentobj.List_JobPrepaids);
                if (jobs.currentobj_jobprepaid == null) {
                    alert('Không tìm thấy Chi tạm ứng!');
                    return;
                }

                $('#info-jobprepaid-money').val(globalhelpers.Format_Money(jobs.currentobj_jobprepaid.Money));
                $('#info-jobprepaid-description').val(jobs.currentobj_jobprepaid.Description);
                $('#divInfo-jobprepaid-prepaids').html(globalhelpers.Format_Money(this.currentobj.Customer.Prepaids.toFixed(2)));

                $('#modal-info-jobprepaid .modal-header .modal-title').html('Cập nhật Chi tạm ứng');
                $('#btn-do-save-jobprepaid').html('Lưu');
                $('#modal-info-jobprepaid').modal('show');
            },

            startdelete_jobprepaid: function (id) {
                jobs.currentobj_jobprepaid = jobs.getobj(id, jobs.currentobj.List_JobPrepaids);
                if (jobs.currentobj_jobprepaid == null) {
                    alert('Không tìm thấy Chi tạm ứng!');
                    return;
                }

                $('#modal-delete-jobprepaid').modal('show');
            },

            dodelete_jobprepaid: function () {
                NProgress.start();
                $('#btn-do-delete-jobprepaid').addClass('disabled');
                $('#btn-modal-delete-close-jobprepaid').addClass('disabled');
                $('#btn-do-delete-jobprepaid').html('Đang xử lý...');

                $.post(jobs.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': 'delete_jobprepaid', 'id': jobs.currentobj_jobprepaid.ID },
                                function (data) {
                                    NProgress.done();

                                    var result = JSON.parse(data);
                                    $('#btn-do-delete-jobprepaid').removeClass('disabled');
                                    $('#btn-modal-delete-close-jobprepaid').removeClass('disabled');
                                    $('#btn-do-delete-jobprepaid').html('Xóa');
                                    alert(result.Message);

                                    if (result.ErrorCode == 0)
                                        jobs.reloadpage();
                                });
            },

            //----------------------------------------
            dodelete_agentprepaid_attached: function (ctrl) {
                var link = $(ctrl).attr('dat-link');
                if (this.agentprepaid_attacheds != null && this.agentprepaid_attacheds.length > 0) {
                    for (var i = 0; i < this.agentprepaid_attacheds.length; i++) {
                        if (this.agentprepaid_attacheds[i] == link) {
                            this.agentprepaid_attacheds.splice(i, 1);
                            break;
                        }
                    }
                }

                var tr = $(ctrl).parent().parent();
                $(tr).remove();
            },

            agentprepaid_attacheds: null,
            onchange_agentprepaid_attachedfile: function () {
                if (this.currentobj_agentprepaid == null) return;
                if (this.currentobj_agentprepaid.Status != 1) return;

                var postdata = new Object();
                postdata.id = this.currentobj_agentprepaid.ID;

                NProgress.start();
                $('#btn-modal-add-close-agentprepaid').addClass('disabled');
                $('#btn-do-save-agentprepaid').addClass('disabled');
                $('#btn-do-save-agentprepaid').html('Đang xử lý...');

                var xhr = new XMLHttpRequest();
                xhr.open('POST', jobs.ajaxPath + '?ts=' + new Date().getTime().toString());
                xhr.onload = function () {
                    NProgress.done();

                    var result = JSON.parse(xhr.responseText);
                    $('#btn-modal-add-close-agentprepaid').removeClass('disabled');
                    $('#btn-do-save-agentprepaid').removeClass('disabled');
                    $('#btn-do-save-agentprepaid').html('Lưu');
                    alert(result.Message);

                    if (result.ErrorCode == 0) {
                        var uploadeds = result.Data.split(';');
                        var html = "";
                        if (jobs.agentprepaid_attacheds == null) jobs.agentprepaid_attacheds = new Array();
                        for (var i = 0; i < uploadeds.length; i++) {
                            jobs.agentprepaid_attacheds.push(uploadeds[i]);
                            var link = uploadeds[i].replace('~', '');
                            html +=
                            "<tr>" +
                                "<td class=\"text-center\">" +
                                    "<a target=\"_blank\" href=\"" + link + "\">" + link + "</a>" +
                                "</td>" +
                                "<td class=\"text-center\">" +
                                    "<a dat-link=\"" + uploadeds[i] + "\" onclick=\"jobs.dodelete_agentprepaid_attached(this);\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Xóa\" class=\"btn btn-xs btn-danger\"><i class=\"fa fa-times\"></i></a>" +
                                "</td>" +
                            "</tr>";
                        }

                        $('#tbodyList-agentprepaids').append(html);
                    }
                };

                var form = new FormData();
                form.append('mod', 'attached_agentprepaid');
                form.append('attached', $('#info-agentprepaid-attached')[0].files[0]);
                form.append('data', JSON.stringify(postdata));

                xhr.send(form);
            },

            doConfirm_agentprepaid: function () {
                if (this.currentobj_agentprepaid == null) return;
                if (this.currentobj_agentprepaid.Status != 0) {
                    alert('Tạm ứng này đã Duyệt chi!');
                    return;
                }

                NProgress.start();
                $('#btn-modal-add-close-agentprepaid').addClass('disabled');
                $('#btn-do-save-agentprepaid').addClass('disabled');
                $('#btn-do-confirm-agentprepaid').addClass('disabled');
                $('#btn-do-confirm-agentprepaid').html('Đang xử lý...');

                $.post(jobs.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': 'confirm_agentprepaid', 'id': jobs.currentobj_agentprepaid.ID },
                                function (data) {
                                    NProgress.done();

                                    var result = JSON.parse(data);
                                    $('#btn-modal-add-close-agentprepaid').removeClass('disabled');
                                    $('#btn-do-save-agentprepaid').removeClass('disabled');
                                    $('#btn-do-confirm-agentprepaid').removeClass('disabled');
                                    $('#btn-do-confirm-agentprepaid').html('Duyệt chi');
                                    alert(result.Message);

                                    if (result.ErrorCode == 0)
                                        jobs.reloadpage();
                                });
            },

            currentobj_agentprepaid: null,
            startedit_agentprepaid: function (id) {
                jobs.mode_agentprepaid = 'edit';
                jobs.currentobj_agentprepaid = jobs.getobj(id, this.currentobj.List_AgentPrepaids);
                if (jobs.currentobj_agentprepaid == null) {
                    alert('Không tìm thấy Tạm ứng!');
                    return;
                }

                $('#info-agentprepaid-employee').val(jobs.currentobj_agentprepaid.AgentID);
                $('#info-agentprepaid-money').val(globalhelpers.Format_Money(jobs.currentobj_agentprepaid.TotalRequest));
                $('#info-agentprepaid-description').val(jobs.currentobj_agentprepaid.Description);
                $('#info-agentprepaid-totalpaid').val(globalhelpers.Format_Money(jobs.currentobj_agentprepaid.TotalPaid));

                this.agentprepaid_attacheds = jobs.currentobj_agentprepaid.AttachedFiles == "" ? null : jobs.currentobj_agentprepaid.AttachedFiles.split(';');
                if (this.agentprepaid_attacheds != null) {
                    var html = "";
                    for (var i = 0; i < this.agentprepaid_attacheds.length; i++) {
                        var link = this.agentprepaid_attacheds[i].replace('~', '');
                        html +=
                            "<tr>" +
                                "<td class=\"text-center\">" +
                                    "<a target=\"_blank\" href=\"" + link + "\">" + link + "</a>" +
                                "</td>" +
                                "<td class=\"text-center\">" +
                                    "<a dat-link=\"" + this.agentprepaid_attacheds[i] + "\" onclick=\"jobs.dodelete_agentprepaid_attached(this);\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Xóa\" class=\"btn btn-xs btn-danger\"><i class=\"fa fa-times\"></i></a>" +
                                "</td>" +
                            "</tr>";
                    }
                    $('#tbodyList-agentprepaids').html(html);
                }

                $('.checked-agentprepaid-jobworking').prop('checked', false);
                var jobIDs = this.currentobj_agentprepaid.JobWorkings.split(';');
                for (var i = 0; i < jobIDs.length; i++) {
                    var jobid = Number(jobIDs[i].replace('@', ''));
                    if (!isNaN(jobid))
                        $('#cbxAgentPrepaid_JobWorking_' + jobid).prop('checked', true);
                }

                $('#modal-info-agentprepaid .modal-header .modal-title').html('Cập nhật Tạm ứng');
                $('#btn-do-save-agentprepaid').html('Lưu');
                $('#modal-info-agentprepaid').modal('show');

                if (this.currentobj_agentprepaid.Status == 0) {
                    $('#div-agentprepaid-result').hide();
                    if (!globalhelpers.HasPermission("Job_TamungNV_Duyetchi", jobs.permissions))
                        $('#btn-do-confirm-agentprepaid').hide();
                    else
                        $('#btn-do-confirm-agentprepaid').show();
                }
                else {
                    $('#div-agentprepaid-result').show();
                    $('#btn-do-confirm-agentprepaid').hide();
                }

                if (!globalhelpers.HasPermission("Job_TamungNV_Sua_Yecau", jobs.permissions)) {
                    $('#info-agentprepaid-employee').attr('disabled', 'disabled');
                    $('#info-agentprepaid-money').attr('disabled', 'disabled');
                    $('#info-agentprepaid-description').attr('disabled', 'disabled');
                }
                else {
                    $('#info-agentprepaid-employee').removeAttr('disabled');
                    $('#info-agentprepaid-money').removeAttr('disabled');
                    $('#info-agentprepaid-description').removeAttr('disabled');
                }
            },

            startdelete_agentprepaid: function (id) {
                jobs.currentobj_agentprepaid = jobs.getobj(id, jobs.currentobj.List_AgentPrepaids);
                if (jobs.currentobj_agentprepaid == null) {
                    alert('Không tìm thấy Tạm ứng!');
                    return;
                }

                $('#modal-delete-agentprepaid').modal('show');
            },

            dodelete_agentprepaid: function () {
                NProgress.start();
                $('#btn-do-delete-agentprepaid').addClass('disabled');
                $('#btn-modal-delete-close-agentprepaid').addClass('disabled');
                $('#btn-do-delete-agentprepaid').html('Đang xử lý...');

                $.post(jobs.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': 'delete_agentprepaid', 'id': jobs.currentobj_agentprepaid.ID },
                                function (data) {
                                    NProgress.done();

                                    var result = JSON.parse(data);
                                    $('#btn-do-delete-agentprepaid').removeClass('disabled');
                                    $('#btn-modal-delete-close-agentprepaid').removeClass('disabled');
                                    $('#btn-do-delete-agentprepaid').html('Xóa');
                                    alert(result.Message);

                                    if (result.ErrorCode == 0)
                                        jobs.reloadpage();
                                });
            },

            loadlist_agentprepaid: function () {
                //NProgress.start();

                //$.post(jobs.ajaxPath + '?ts=' + new Date().getTime().toString(),
                //    { 'mod': "loadlist_prepaids", 'jobid': jobs.currentobj.ID },
                //                function (data) {
                //                    NProgress.done();
                //                    var result = JSON.parse(data);

                var html =
                    "<table id=\"tblList_AgentPrepaids\" class=\"table table-vcenter table-striped table-condensed table-hover table-bordered\">" +
                        "<thead>" +
                            "<tr>" +
                                "<th class=\"text-center\">STT</th>" +
                                "<th class=\"text-center\">Nhân viên</th>" +
                                "<th class=\"text-center\">Ngày yêu cầu</th>" +
                                "<th class=\"text-center\">Ghi chú</th>" +
                                "<th class=\"text-center\">Số tiền</th>" +
                                "<th class=\"text-center\">Người duyệt</th>" +
                                "<th class=\"text-center\">Ngày duyệt</th>" +
                                "<th class=\"text-center\">Chi thực tế</th>" +
                                "<th class=\"text-center\">Hoàn ứng</th>" +
                                "<th class=\"text-center\">Trạng thái</th>" +
                                "<th class=\"text-center\">#</th>" +
                            "</tr>" +
                        "</thead>" +
                        "<tbody>";

                if (jobs.currentobj.List_AgentPrepaids == null) {
                    html +=
                        "<tr>" +
                            "<td class=\"text-center\" colspan=\"11\">" +
                                "Không có dữ liệu!" +
                            "</td>" +
                        "</tr>";
                }
                else {
                    //jobs.allprepaids = JSON.parse(result.Data.List);

                    for (var i = 0; i < jobs.currentobj.List_AgentPrepaids.length; i++) {
                        var obj = jobs.currentobj.List_AgentPrepaids[i];

                        html +=
                            "<tr>" +
                                "<td class=\"text-center\">" +
                                    (i + 1) +
                                "</td>" +
                                "<td class=\"text-center\">" + obj.AgentName + "</td>" +
                                "<td class=\"text-center\">" + obj.sRequestedDate + "</td>" +
                                "<td class=\"text-center\">" + obj.Description + "</td>" +
                                "<td class=\"text-center\">" + globalhelpers.Format_Money(obj.TotalRequest) + "</td>" +
                                "<td class=\"text-center\">" + (obj.Status == 0 ? "---" : obj.ConfirmerName) + "</td>" +
                                "<td class=\"text-center\">" + (obj.Status == 0 ? "---" : obj.sConfirmedDate) + "</td>" +
                                "<td class=\"text-center\">" + globalhelpers.Format_Money(obj.TotalPaid) + "</td>" +
                                "<td class=\"text-center\">" + globalhelpers.Format_Money((obj.TotalRequest - obj.TotalPaid)) + "</td>" +
                                "<td class=\"text-center\">" + obj.sStatus + "</td>" +
                                "<td class=\"text-center\">" +
                                        (!globalhelpers.HasPermission("Job_TamungNV_Capnhat", jobs.permissions) ? "" : "<a onclick=\"jobs.startedit_agentprepaid('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Sửa\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-pencil\"></i></a>") +
                                        (!globalhelpers.HasPermission("Job_TamungNV_Xoa_Yeucau", jobs.permissions) ? "" : "<a onclick=\"jobs.startdelete_agentprepaid('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Xóa\" class=\"btn btn-xs btn-danger\"><i class=\"fa fa-times\"></i></a>") +
                                "</td>" +
                            "</tr>";
                    }
                }

                html += "</tbody></table>";

                $('#divAgentPrepaids').html(html);

                $('[data-toggle="tooltip"]').tooltip();
                //                    });
            },

            mode_agentprepaid: 'create',
            doAdd_agentprepaid: function () {
                var postdata = jobs.validateForm_agentprepaid();
                if (postdata == null)
                    return;

                NProgress.start();
                $('#btn-do-save-agentprepaid').addClass('disabled');
                $('#btn-do-save-agentprepaid').html('Đang xử lý...');

                var xhr = new XMLHttpRequest();
                xhr.open('POST', jobs.ajaxPath + '?ts=' + new Date().getTime().toString());
                xhr.onload = function () {
                    NProgress.done();

                    var result = JSON.parse(xhr.responseText);
                    $('#btn-do-save-agentprepaid').removeClass('disabled');
                    $('#btn-do-save-agentprepaid').html(jobs.mode_agentprepaid == 'create' ? 'Thêm' : 'Lưu');
                    alert(result.Message);

                    if (result.ErrorCode == 0) {
                        jobs.reloadpage();
                    }
                };

                var form = new FormData();
                form.append('mod', this.mode_agentprepaid + '_agentprepaid');
                form.append('data', JSON.stringify(postdata));

                xhr.send(form);
            },

            validateForm_agentprepaid: function () {
                var message = '';
                var data = new Object();

                data.jobid = jobs.currentobj.ID;

                data.employid = Number($('#info-agentprepaid-employee').val());
                if (isNaN(data.employid))
                    message += '- Nhân viên không hợp lệ!<br/>';

                data.description = $('#info-agentprepaid-description').val();

                data.totalrequest = Number(globalhelpers.Convert_FromMoney($('#info-agentprepaid-money').val()));
                if (isNaN(data.totalrequest))
                    message += '- Số tiền duyệt chi không hợp lệ!<br/>';

                data.totalpaid = Number(globalhelpers.Convert_FromMoney($('#info-agentprepaid-totalpaid').val()));
                if (jobs.mode_agentprepaid != "create" && isNaN(data.totalpaid))
                    message += '- Số tiền chi thực tế không hợp lệ!<br/>';

                data.attacheds = "";
                if (this.agentprepaid_attacheds != null && this.agentprepaid_attacheds.length > 0) {
                    var sAttacheds = "";
                    for (var i = 0; i < this.agentprepaid_attacheds.length; i++) {
                        if (data.attacheds != "") data.attacheds += ";";
                        data.attacheds += this.agentprepaid_attacheds[i];
                    }
                }

                data.jobworkings = "";
                var cbxJobs = $('.checked-agentprepaid-jobworking');
                for (var i = 0; i < $(cbxJobs).length; i++) {
                    var cbxJob = $(cbxJobs[i]);
                    if ($(cbxJob).prop('checked'))
                        data.jobworkings += "@" + $(cbxJob).attr('dat-id') + ";";
                }

                data.id = jobs.mode_agentprepaid == "create" ? 0 : jobs.currentobj_agentprepaid.ID;

                return data;
            },

            startAdd_agentprepaid: function () {
                this.mode_agentprepaid = 'create';
                $('#modal-info-agentprepaid .modal-header .modal-title').html('Thêm mới Tạm ứng');
                $('#btn-do-save-agentprepaid').html('Thêm');
                $('#modal-info-agentprepaid').modal('show');
                $('#div-agentprepaid-result').hide();
                $('#btn-do-confirm-agentprepaid').hide();

                $('#info-agentprepaid-employee').removeAttr('disabled');
                $('#info-agentprepaid-money').removeAttr('disabled');
                $('#info-agentprepaid-description').removeAttr('disabled');

                //$('#info-prepaid-employee').val('<%= CurrentSys_User.ID %>');
                this.agentprepaid_attacheds = null;
            },

            //-----------------------------------

            currentobj_inoutfee: null,
            startedit_inoutfee: function (id) {
                jobs.mode_inoutfee = 'edit';
                jobs.currentobj_inoutfee = jobs.getobj(id, this.currentobj.InOutFees);
                if (jobs.currentobj_inoutfee == null) {
                    alert('Không tìm thấy Mục Thu/Chi hộ!');
                    return;
                }

                $('#info-inoutfee-name').val(jobs.currentobj_inoutfee.Name);
                $('#info-inoutfee-company').val(jobs.currentobj_inoutfee.Company);
                $('#info-inoutfee-invoiceno').val(jobs.currentobj_inoutfee.InvoiceNO);

                $('#info-inoutfee-invoicedate').val(jobs.currentobj_inoutfee.sInvoiceDate);
                $('#info-inoutfee-money').val(globalhelpers.Format_Money(jobs.currentobj_inoutfee.Money));
                $('#info-inoutfee-isusd').prop('checked', jobs.currentobj_inoutfee.IsUSD);
                var file = jobs.currentobj_inoutfee.AttachedFiles.replace('~', '');
                $('#info-inoutfee-currentattached').html('<a target="_blank" href="' + file + '">' + file + '</a>');

                $('#modal-info-inoutfee .modal-header .modal-title').html('Cập nhật Mục Thu/Chi hộ');
                $('#btn-do-save-inoutfee').html('Lưu');
                $('#modal-info-inoutfee').modal('show');
            },

            startdelete_inoutfee: function (id) {
                jobs.currentobj_inoutfee = jobs.getobj(id, jobs.currentobj.InOutFees);
                if (jobs.currentobj_inoutfee == null) {
                    alert('Không tìm thấy Mục Thu/Chi hộ!');
                    return;
                }

                //$('#modal-delete-quotation-route #bDeleteName').html(jobs.currentobj.Name);
                $('#modal-delete-inoutfee').modal('show');
            },

            dodelete_inoutfee: function () {
                NProgress.start();
                $('#btn-do-delete-inoutfee').addClass('disabled');
                $('#btn-modal-delete-close-inoutfee').addClass('disabled');
                $('#btn-do-delete-inoutfee').html('Đang xử lý...');

                $.post(jobs.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': 'delete_inoutfee', 'id': jobs.currentobj_inoutfee.ID },
                                function (data) {
                                    NProgress.done();

                                    var result = JSON.parse(data);
                                    $('#btn-do-delete-inoutfee').removeClass('disabled');
                                    $('#btn-modal-delete-close-inoutfee').removeClass('disabled');
                                    $('#btn-do-delete-inoutfee').html('Xóa');
                                    alert(result.Message);

                                    if (result.ErrorCode == 0)
                                        jobs.reloadpage();
                                });
            },

            loadlist_inoutfees: function () {
                //NProgress.start();

                //$.post(jobs.ajaxPath + '?ts=' + new Date().getTime().toString(),
                //    { 'mod': "loadlist_inoutfees", 'jobid': jobs.currentobj.ID },
                //                function (data) {
                //                    NProgress.done();
                //                    var result = JSON.parse(data);

                var html =
                    "<table id=\"tblList\" class=\"table table-vcenter table-striped table-condensed table-hover table-bordered\">" +
                        "<thead>" +
                            "<tr>" +
                                "<th class=\"text-center\">STT</th>" +
                                "<th class=\"text-center\">Tên mục</th>" +
                                "<th class=\"text-center\">Tên đơn vị</th>" +
                                "<th class=\"text-center\">Mã Hóa đơn</th>" +
                                "<th class=\"text-center\">Ngày xuất</th>" +
                                "<th class=\"text-center\">Số tiền</th>" +
                                "<th class=\"text-center\">Đính kèm</th>" +
                                "<th class=\"text-center\">#</th>" +
                            "</tr>" +
                        "</thead>" +
                        "<tbody>";

                if (jobs.currentobj.InOutFees == null) {
                    html +=
                        "<tr>" +
                            "<td class=\"text-center\" colspan=\"8\">" +
                                "Không có dữ liệu!" +
                            "</td>" +
                        "</tr>";
                }
                else {
                    //jobs.allInOutFees = JSON.parse(result.Data.List);

                    for (var i = 0; i < jobs.currentobj.InOutFees.length; i++) {
                        var obj = jobs.currentobj.InOutFees[i];

                        html +=
                            "<tr>" +
                                "<td class=\"text-center\">" +
                                    (i + 1) +
                                "</td>" +
                                "<td class=\"text-center\">" + obj.Name + "</td>" +
                                "<td class=\"text-center\">" + obj.Company + "</td>" +
                                "<td class=\"text-center\">" + obj.InvoiceNO + "</td>" +
                                "<td class=\"text-center\">" + obj.sInvoiceDate + "</td>" +
                                "<td class=\"text-center\">" + globalhelpers.Format_Money(obj.Money.toFixed(2)) + "</td>" +
                                "<td class=\"text-center\">" +
                                        "<a target=\"_blank\" href=\"" + obj.AttachedFiles.replace('~', '') + "\" data-toggle=\"tooltip\" title=\"Xem tệp đính kèm\" class=\"btn btn-xs btn-success\"><i class=\"hi hi-paperclip\"></i></a>" +
                                "</td>" +
                                "<td class=\"text-center\">" +
                                        (!globalhelpers.HasPermission("Job_Thuchi_Sua", jobs.permissions) ? "" : "<a onclick=\"jobs.startedit_inoutfee('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Sửa\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-pencil\"></i></a>") +
                                        (!globalhelpers.HasPermission("Job_Thuchi_Xoa", jobs.permissions) ? "" : "<a onclick=\"jobs.startdelete_inoutfee('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Xóa\" class=\"btn btn-xs btn-danger\"><i class=\"fa fa-times\"></i></a>") +
                                "</td>" +
                            "</tr>";
                    }
                }

                html += "</tbody></table>";

                $('#divInOutFees').html(html);

                $('[data-toggle="tooltip"]').tooltip();
                //                    });
            },

            mode_inoutfee: 'create',
            doAdd_inoutfee: function () {
                var postdata = jobs.validateForm_inoutfee();
                if (postdata == null)
                    return;

                NProgress.start();
                $('#btn-do-save-info-inoutfee').addClass('disabled');
                $('#btn-do-save-info-inoutfee').html('Đang xử lý...');

                var xhr = new XMLHttpRequest();
                xhr.open('POST', jobs.ajaxPath + '?ts=' + new Date().getTime().toString());
                xhr.onload = function () {
                    NProgress.done();

                    var result = JSON.parse(xhr.responseText);
                    $('#btn-do-save-info-inoutfee').removeClass('disabled');
                    $('#btn-do-save-info-inoutfee').html(jobs.mode_inoutfee == 'create' ? 'Thêm' : 'Lưu');
                    alert(result.Message);

                    if (result.ErrorCode == 0) {
                        jobs.reloadpage();
                    }
                };

                var form = new FormData();
                form.append('mod', this.mode_inoutfee + '_inoutfee');
                form.append('attached', $('#info-inoutfee-attached')[0].files[0]);
                form.append('data', JSON.stringify(postdata));

                xhr.send(form);
            },

            currentInOutFeeID: null,
            validateForm_inoutfee: function () {
                var message = '';
                var data = new Object();

                data.jobid = jobs.currentobj.ID;

                data.name = $('#info-inoutfee-name').val();
                if (data.name == "")
                    message += '- Tên mục Thu/Chi không hợp lệ!<br/>';

                data.company = $('#info-inoutfee-company').val();
                if (data.company == "")
                    message += '- Tên đơn vị không hợp lệ!<br/>';

                data.invoiceno = $('#info-inoutfee-invoiceno').val();
                if (data.company == "")
                    message += '- Số hóa đơn không hợp lệ!<br/>';

                data.date = $('#info-inoutfee-invoicedate').val();
                if (data.date == "")
                    message += '- Thời gian xuất Hóa đơn không hợp lệ!<br/>';

                data.money = Number(globalhelpers.Convert_FromMoney($('#info-inoutfee-money').val()));
                if (isNaN(data.money))
                    message += '- Số tiền không hợp lệ!<br/>';

                data.isusd = $('#info-inoutfee-isusd').prop('checked');

                data.id = jobs.mode_inoutfee == "create" ? 0 : jobs.currentobj_inoutfee.ID;

                return data;
            },

            startAdd_inoutfee: function () {
                this.mode_inoutfee = 'create';
                $('#modal-info-inoutfee .modal-header .modal-title').html('Thêm mới Thu/Chi hộ');
                $('#btn-do-save-inoutfee').html('Thêm');
                $('#modal-info-inoutfee').modal('show');
            },

            generate_quotationcustoms_feetypes: function () {
                if (this.allCustomsFeeTypes == null || this.allCustomsFeeTypes.length == 0) {
                    $('#divQuotation_Customs_Detail_FeeTypes').html('<label class="control-label label-quicklink"><a href="/loai-phi-tthq">Chưa có dữ liệu Loại phí TTHQ! Nhấp chọn chuyển sang trang Quản lý!</a></label>');
                    $('#divQuotation_Customs_Detail_Loads').html('');
                }
                else {
                    var html = "<select id=\"info-quotation-customs-detail-feetypes\" class=\"form-control\" style=\"width: 100%;\">";

                    for (var i = 0; i < this.allCustomsFeeTypes.length; i++) {
                        var feeType = this.allCustomsFeeTypes[i];
                        html += "<option value=\"" + feeType.ID + "\">" + feeType.Name + "</option>";
                    }

                    html += "</select>";

                    $('#divQuotation_Customs_Detail_FeeTypes').html(html);
                }
            },

            startAdd_quotation_customs: function () {
                $('#divQuotation-customs-settings').hide();
                $('#divQuotation-customs-details').show();
                $('#divQuotation-customs-controls').show();
            },

            startAdd_quotation_customs_detail: function () {
                this.mode_quotationcustoms_detail = 'create';
                $('#modal-info-quotation-customs-details .modal-header .modal-title').html('Thêm mới Loại phí TTHQ');
                $('#btn-do-save-quotation-customs-details').html('Thêm');
                $('#modal-info-quotation-customs-details').modal('show');
            },

            doDelete_quotation_customs_detail: function (ctrl) {
                var tr = $(ctrl).parent().parent();
                var typeId = Number($(tr).attr('dat-ti'));
                var feeIndex = globalhelpers.GetIndexInList(typeId, this.quotationcustoms_details_temp, "FeeTypeID");

                this.quotationcustoms_details_temp.splice(feeIndex, 1);
                $(tr).remove();
            },

            quotationcustoms_details_temp: null,
            quotationcustoms_details_temp_reorder: function () {
                if (this.quotationcustoms_details_temp == null || this.quotationcustoms_details_temp.length == 0) return;
                var quotationID = Number($('#info-quotation-customs-quotation-by-smiles').val());
                var customsQuotation = globalhelpers.GetObjInList(quotationID, this.allQuotationCustoms_BySmiles, "ID");
                if (customsQuotation == null) return;

                for (var i = 0; i < this.quotationcustoms_details_temp.length - 1; i++) {
                    for (var j = i + 1; j < this.quotationcustoms_details_temp.length; j++) {
                        var price = globalhelpers.GetObjInList(this.quotationcustoms_details_temp[i].FeeTypeID, customsQuotation.FeeDetails, "FeeTypeID").Price;
                        var price2 = globalhelpers.GetObjInList(this.quotationcustoms_details_temp[j].FeeTypeID, customsQuotation.FeeDetails, "FeeTypeID").Price;

                        if (price < price2) {
                            var temp = this.quotationcustoms_details_temp[i];
                            this.quotationcustoms_details_temp[i] = this.quotationcustoms_details_temp[j];
                            this.quotationcustoms_details_temp[j] = temp;
                        }
                    }
                }
            },
            doAdd_quotation_customs_detail_Temp: function () {
                var quotationID = Number($('#info-quotation-customs-quotation-by-smiles').val());
                var feeTypeID = Number($('#info-quotation-customs-detail-feetypes').val());
                var quantity = Number($('#info-quotation-customs-detail-quantity').val());
                var description = $('#info-quotation-customs-detail-description').val();

                if (isNaN(quotationID) || isNaN(feeTypeID) || isNaN(quantity)) {
                    alert("Dữ liệu nhập không hợp lệ!");
                    return;
                }

                var customsQuotation = globalhelpers.GetObjInList(quotationID, this.allQuotationCustoms_BySmiles, "ID");
                if (customsQuotation == null) return;

                var quotationDetail = globalhelpers.GetObjInList(feeTypeID, customsQuotation.FeeDetails, "FeeTypeID");
                if (quotationDetail == null) {
                    alert("Không tìm thấy dữ liệu Bảng giá phù hợp!");
                    return;
                }

                var dbFeeType = globalhelpers.GetObjInList(feeTypeID, this.allCustomsFeeTypes);

                if (this.quotationcustoms_details_temp == null)
                    this.quotationcustoms_details_temp = new Array();

                var feeIndex = globalhelpers.GetIndexInList(feeTypeID, this.quotationcustoms_details_temp, "FeeTypeID");
                if (feeIndex == -1) {
                    var feeType = new Object();
                    feeType.FeeTypeID = feeTypeID;
                    feeType.Order = 1;
                    feeType.Description = description;
                    feeType.Quantity = quantity;
                    this.quotationcustoms_details_temp.push(feeType);

                    feeIndex = globalhelpers.GetIndexInList(feeTypeID, this.quotationcustoms_details_temp, "FeeTypeID");

                    this.quotationcustoms_details_temp_reorder();
                }
                else this.quotationcustoms_details_temp[feeIndex].Quantity += quantity;

                $('#modal-info-quotation-customs-details').modal('hide');

                this.generate_quotationcustoms_values_fees();
            },

            doAdd_quotation_customs: function () {
                var postdata = jobs.validateForm_quotation_customs();
                if (postdata == null)
                    return;

                NProgress.start();
                $('#btn-do-save-quotationcustoms').addClass('disabled');
                $('#btn-do-save-quotationcustoms').html('Đang xử lý...');

                var xhr = new XMLHttpRequest();
                xhr.open('POST', jobs.ajaxPath + '?ts=' + new Date().getTime().toString());
                xhr.onload = function () {
                    NProgress.done();

                    var result = JSON.parse(xhr.responseText);
                    $('#btn-do-save-quotationcustoms').removeClass('disabled');
                    $('#btn-do-save-quotationcustoms').html(jobs.mode_quotationroute == 'create' ? 'Thêm' : 'Lưu');
                    alert(result.Message);

                    if (result.ErrorCode == 0) {
                        jobs.reloadpage();
                    }
                };

                var form = new FormData();
                form.append('mod', 'update_quotation_customs');
                form.append('data', JSON.stringify(postdata));

                xhr.send(form);
            },

            validateForm_quotation_customs: function () {
                var message = '';
                var data = new Object();

                data.jobid = jobs.currentobj.ID;

                data.description = $('#info-quotation-customs-description').val();

                data.isusd = $('#info-quotation-customs-isusd').prop('checked');

                data.expirestart = $('#info-quotation-customs-expire-start').val();
                data.expireend = $('#info-quotation-customs-expire-end').val();
                if (data.expirestart == "" || data.expireend == "")
                    message += '- Thời gian hiệu lực không hợp lệ!<br/>';

                data.usdrate = Number(globalhelpers.Convert_FromMoney($('#info-quotation-customs-usdrate').val()));
                if (data.isusd && (isNaN(data.usdrate) || data.usdrate <= 0))
                    message += '- Tỉ giá USD không hợp lệ!<br/>';

                data.decreasepercent = Number($('#info-quotation-customs-decreasepercent').val());
                if (isNaN(data.decreasepercent))
                    message += '- % giảm giá không hợp lệ!<br/>';

                data.basequotationid = Number($('#info-quotation-customs-quotation-by-smiles').val());

                data.feetypes = this.quotationcustoms_details_temp;
                if (data.feetypes == null || data.feetypes.length == 0)
                    message += '- Báo giá TTHQ không hợp lệ!<br/>';

                return data;
            },

            generate_quotationcustoms_values_fees: function () {
                if (this.quotationcustoms_details_temp == null || this.quotationcustoms_details_temp.length == 0) return;

                var quotationID = Number($('#info-quotation-customs-quotation-by-smiles').val());
                var customsQuotation = globalhelpers.GetObjInList(quotationID, this.allQuotationCustoms_BySmiles, "ID");
                if (customsQuotation == null) return;

                var html = "";

                for (var i = 0; i < this.quotationcustoms_details_temp.length; i++) {
                    var feeType = this.quotationcustoms_details_temp[i];

                    var quotationDetail = globalhelpers.GetObjInList(feeType.FeeTypeID, customsQuotation.FeeDetails, "FeeTypeID");
                    if (quotationDetail == null) {
                        alert("Không tìm thấy dữ liệu Bảng giá phù hợp!");
                        return;
                    }

                    var dbFeeType = globalhelpers.GetObjInList(feeType.FeeTypeID, this.allCustomsFeeTypes);

                    html +=
                        "<tr id=\"tr-quotationcustoms-byload-" + feeType.FeeTypeID + "\"  class=\"tr-quotationcustoms-byfeetype-" + feeType.FeeTypeID + " tr-load-quotation\" dat-ti=\"" + feeType.FeeTypeID + "\">" +
                            "<td id=\"td-quotationcustoms-byload-name-" + feeType.FeeTypeID + "\" class=\"text-left\" style=\"padding-left: 20px;\">" +
                                dbFeeType.Name +
                            "</td>" +
                            "<td id=\"td-quotationcustoms-byload-quantity-" + feeType.FeeTypeID + "\" class=\"text-center\">" +
                                "<input onchange=\"jobs.generate_quotationcustoms_feedetails_total();\" type=\"text\" id=\"info-quotationcustoms-byload-quantity-" + feeType.FeeTypeID + "\" value=\"" + feeType.Quantity + "\" class=\"form-control\" style=\"width: 100%;\">" +
                            "</td>" +
                            "<td id=\"td-quotationcustoms-byload-price-" + feeType.FeeTypeID + "\" dat-price=\"" + quotationDetail.Price + "\" class=\"text-center\">" +
                                globalhelpers.Format_Money(quotationDetail.Price.toFixed(2)) +
                            "</td>" +
                            "<td id=\"td-quotationcustoms-byload-total-" + feeType.FeeTypeID + "\" class=\"text-center\">" +
                                "0" +
                            "</td>" +
                            "<td class=\"text-center\">" +
                                (!globalhelpers.HasPermission("Job_TTHQ_Xoa", jobs.permissions) ? "" : "<a onclick=\"jobs.doDelete_quotation_customs_detail(this);\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Xóa\" class=\"btn btn-xs btn-danger\"><i class=\"fa fa-times\"></i></a>") +
                                "<a href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"" + feeType.Description + "\" class=\"btn btn-xs btn-default\"><i class=\"hi hi-question-sign\"></i></a>" +
                            "</td>" +
                        "</tr>";
                }

                $('#tbodyList_Quotation_Customs_FeeDetails').html(html);

                this.generate_quotationcustoms_feedetails_total();
            },

            generate_quotationcustoms_values: function () {
                if (this.currentobj == null) {
                    $('#divQuotation-customs-settings').hide();
                    $('#divQuotation-customs-details').hide();
                    $('#divQuotation-customs-controls').hide();
                    return;
                }

                if (this.currentobj.QuotationCustoms == null) {
                    if (!globalhelpers.HasPermission("Job_TTHQ_Capnhat", jobs.permissions))
                        $('#divQuotation-customs-settings').hide();
                    else
                        $('#divQuotation-customs-settings').show();

                    //$('#divQuotation-customs-settings').show();
                    $('#divQuotation-customs-details').hide();
                    $('#divQuotation-customs-controls').hide();
                    return;
                }

                $('#divQuotation-customs-settings').hide();
                $('#divQuotation-customs-details').show();
                $('#divQuotation-customs-controls').show();

                $('#info-quotation-customs-quotation-by-smiles').val(this.currentobj.QuotationCustoms.BasicQuotationID);
                $('#info-quotation-customs-decreasepercent').val(this.currentobj.QuotationCustoms.DecreasePercentForSecondCont);

                $('#info-quotation-customs-expire-start').val(this.currentobj.QuotationCustoms.sExpireStart);
                $('#info-quotation-customs-expire-end').val(this.currentobj.QuotationCustoms.sExpireEnd);

                $('#info-quotation-customs-isusd').prop('checked', this.currentobj.QuotationCustoms.IsUSD);
                $('#info-quotation-customs-usdrate').val(globalhelpers.Format_Money(this.currentobj.QuotationCustoms.USDRate));

                $('#info-quotation-customs-description').val(this.currentobj.QuotationCustoms.Description);

                var customsQuotation = globalhelpers.GetObjInList(this.currentobj.QuotationCustoms.BasicQuotationID, this.allQuotationCustoms_BySmiles, "ID");
                if (customsQuotation == null) return;

                this.quotationcustoms_details_temp = this.currentobj.QuotationCustoms.FeeDetails;

                this.generate_quotationcustoms_values_fees();

                $('[data-toggle="tooltip"]').tooltip();
            },

            generate_quotationcustoms_feedetails_total: function () {
                var trs = $('#tbodyList_Quotation_Customs_FeeDetails').find('.tr-load-quotation');
                if (trs.length == 0) return;

                var decreasePercent = Number($('#info-quotation-customs-decreasepercent').val());
                if (isNaN(decreasePercent)) return;

                var quotationID = Number($('#info-quotation-customs-quotation-by-smiles').val());
                var customsQuotation = globalhelpers.GetObjInList(quotationID, this.allQuotationCustoms_BySmiles, "ID");
                if (customsQuotation == null) return;

                for (var i = 0; i < trs.length; i++) {
                    var tr = trs[i];
                    var feeTypeID = Number($(tr).attr('dat-ti'));

                    var quotationDetail = globalhelpers.GetObjInList(feeTypeID, customsQuotation.FeeDetails, "FeeTypeID");
                    if (quotationDetail == null) {
                        $('#td-quotationcustoms-byload-total-' + feeTypeID).html('--Không tìm thấy dữ liệu giá!--');
                        continue;
                    }

                    var quantity = Number($('#info-quotationcustoms-byload-quantity-' + feeTypeID).val());
                    //var price = Number($('#td-quotationcustoms-byload-price-' + feeTypeID + "-" + loadID).attr('dat-price'));
                    var total = 0;

                    if (i == 0)//first
                    {
                        curFeeTypeID = feeTypeID;
                        total = quotationDetail.Price + (quantity - 1) * quotationDetail.Price * (100 - decreasePercent) / 100;
                    }
                    else {
                        total = quantity * quotationDetail.Price * (100 - decreasePercent) / 100;
                    }

                    $('#td-quotationcustoms-byload-total-' + feeTypeID).html(globalhelpers.Format_Money(total.toFixed(2)));
                }
            },

            generate_quotationcustoms_controls_bysmiles: function () {
                if (this.allQuotationCustoms_BySmiles == null) {
                    $('#divQuotationCustoms_By_Smiles').html('<label class="control-label label-quicklink"><a href="/bang-gia-tthq">Không tìm thấy Bảng giá TTHQ! Chuyển sang trang Quản lý?</a></label>');
                    return;
                }

                var html =
                    "<select id=\"info-quotation-customs-quotation-by-smiles\" onchange=\"jobs.generate_quotationcustoms_feedetails_total();\" class=\"form-control\" style=\"width: 100%;\">";

                if (jobs.allQuotationCustoms_BySmiles != null && jobs.allQuotationCustoms_BySmiles.length > 0) {
                    for (var i = 0; i < jobs.allQuotationCustoms_BySmiles.length; i++) {
                        var quotation = jobs.allQuotationCustoms_BySmiles[i];

                        html += "<option value=\"" + quotation.ID + "\">Hiệu lực từ " + quotation.sExpireFrom + "</option>";
                    }
                }

                html += "</select>";

                $('#divQuotationCustoms_By_Smiles').html(html);

                //if (jobs.currentobj.QuotationCustoms != null)
                //    $('#info-quotation-customs-quotation-by-smiles').val(jobs.currentobj.QuotationCustoms.ID);

                //---------------

                $('[data-toggle="tooltip"]').tooltip();
            },

            generate_quotation_routes: function () {
                var html =
                    "<table id=\"tblList_Quotation_Routes\" class=\"table table-vcenter table-striped table-condensed table-hover table-bordered\">" +
                        "<thead>" +
                            "<tr>" +
                                "<th class=\"text-center\">STT</th>" +
                                "<th class=\"text-center\">Tuyến đường</th>" +
                                "<th class=\"text-center\">Loại xe</th>" +
                                "<th class=\"text-center\">Tổng tiền</th>" +
                                "<th class=\"text-center\">Trạng thái</th>" +
                                "<th class=\"text-center\">#</th>" +
                            "</tr>" +
                        "</thead>" +
                        "<tbody>";

                if (this.currentobj.Routes == null || this.currentobj.Routes.length == 0) {
                    html +=
                        "<tr>" +
                            "<td class=\"text-center\" colspan=\"6\">" +
                                "Không có dữ liệu" +
                            "</td>" +
                        "</tr>";
                }
                else {
                    for (var i = 0; i < this.currentobj.Routes.length; i++) {
                        var route = this.currentobj.Routes[i];
                        var statusClassName = globalhelpers.GetStatusClass(route.Status);

                        html +=
                            "<tr>" +
                                "<td class=\"text-center\">" +
                                    (i + 1) +
                                "</td>" +
                                "<td class=\"text-center\">" +
                                    route.sPlaceStart + " <i class='hi hi-arrow-right'></i> " + route.sPlaceEnd +
                                "</td>" +
                                "<td class=\"text-center\">" +
                                    "<strong style=\"color: #1bbae1;\">" + route.Quantity + "</strong> " + route.sVehicleTypeLoad +
                                "</td>" +
                                "<td class=\"text-center\">" +
                                    globalhelpers.Format_Money(route.Total_In.toFixed(2)) +
                                "</td>" +
                                "<td class=\"text-center\"><span class=\"" + (statusClassName == "" ? "" : ("text-" + statusClassName)) + "\">" + route.sStatus + "</span></td>" +
                                "<td class=\"text-center\">" +
                                    (!globalhelpers.HasPermission("Job_Vanchuyen_Sua", jobs.permissions) ? "" : "<a onclick=\"jobs.startedit_quotation_route('" + route.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Sửa\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-pencil\"></i></a>") +
                                    (!globalhelpers.HasPermission("Job_Vanchuyen_Xoa", jobs.permissions) ? "" : "<a onclick=\"jobs.startdelete_quotation_route('" + route.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Xóa\" class=\"btn btn-xs btn-danger\"><i class=\"fa fa-times\"></i></a>") +
                                    "<a href=\"#\" data-toggle=\"tooltip\" title=\"Ghi chú: " + route.Description + "\" class=\"btn btn-xs btn-default\"><i class=\"hi hi-question-sign\"></i></a>" +
                                "</td>" +
                            "</tr>";
                    }
                }

                html += "</tbody></table>";

                $('#divQuotation_Routes').html(html);

                $('[data-toggle="tooltip"]').tooltip();
            },

            startedit_quotation_route: function (id) {
                jobs.mode_quotationroute = 'edit';
                jobs.currentobj_quotation_route = jobs.getobj(id, this.currentobj.Routes);
                if (jobs.currentobj_quotation_route == null) {
                    alert('Không tìm thấy Báo giá Vận chuyển!');
                    return;
                }

                $('#info-quotation-route-place-start').val(jobs.currentobj_quotation_route.PlaceStart);
                $('#info-quotation-route-place-end').val(jobs.currentobj_quotation_route.PlaceEnd);
                $('#info-quotation-route-transcomps').val(jobs.currentobj_quotation_route.TransCompID);
                jobs.generate_vehicletypes();

                $('#info-quotation-route-vehicletypes').val(jobs.currentobj_quotation_route.VehicleTypeID);
                jobs.generate_vehicleloads();
                $('#info-quotation-route-vehicleloads').val(jobs.currentobj_quotation_route.VehicleLoadID);
                jobs.load_quotations();

                $('#info-quotationroute-value-quantity').val(jobs.currentobj_quotation_route.Quantity);
                $('#info-quotationroute-value-isusd').prop('checked', jobs.currentobj_quotation_route.IsUSD);
                $('#info-quotationroute-value-expire-start').val(jobs.currentobj_quotation_route.sExpireStart);
                $('#info-quotationroute-value-expire-end').val(jobs.currentobj_quotation_route.sExpireEnd);
                $('#info-quotationroute-info-extrafee').val(globalhelpers.Format_Money(jobs.currentobj_quotation_route.ExtraFee));
                $('#info-quotationroute-info-description').val(jobs.currentobj_quotation_route.Description);
                $('#info-quotationroute-info-vehicleno').val(jobs.currentobj_quotation_route.VehicleNO);
                $('#info-quotationroute-info-driverphone').val(jobs.currentobj_quotation_route.DriverPhoneNumber);
                $('#info-quotationroute-info-loads').val(jobs.currentobj_quotation_route.Loads);
                $('#info-quotationroute-info-comppromotion').val(globalhelpers.Format_Money(jobs.currentobj_quotation_route.PromotionByTransComp));
                $('#info-quotationroute-info-usdrate').val(globalhelpers.Format_Money(jobs.currentobj_quotation_route.USDRate));

                $('#modal-info-quotation-route .modal-header .modal-title').html('Cập nhật Báo giá Vận chuyển');
                $('#btn-do-save-quotation-route').html('Lưu');
                $('#modal-info-quotation-route').modal('show');
            },

            startdelete_quotation_route: function (id) {
                jobs.quotationRouteID = id;
                var route = jobs.getobj(id, jobs.currentobj.Routes);
                if (route == null) {
                    alert('Không tìm thấy Báo giá Vận chuyển!');
                    return;
                }

                //$('#modal-delete-quotation-route #bDeleteName').html(jobs.currentobj.Name);
                $('#modal-delete-quotation-route').modal('show');
            },

            dodelete_quotation_route: function () {
                NProgress.start();
                $('#btn-do-delete-quotation-route').addClass('disabled');
                $('#btn-modal-delete-close-quotation-route').addClass('disabled');
                $('#btn-do-delete-quotation-route').html('Đang xử lý...');

                $.post(jobs.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': 'delete_quotation_delete', 'id': jobs.quotationRouteID },
                                function (data) {
                                    NProgress.done();

                                    var result = JSON.parse(data);
                                    $('#btn-do-delete-quotation-route').removeClass('disabled');
                                    $('#btn-modal-delete-close-quotation-route').removeClass('disabled');
                                    $('#btn-do-delete-quotation-route').html('Xóa');
                                    alert(result.Message);

                                    if (result.ErrorCode == 0)
                                        jobs.reloadpage();
                                });
            },

            doAdd_quotation_route: function () {
                var postdata = jobs.validateForm_quotation_route();
                if (postdata == null)
                    return;

                NProgress.start();
                $('#btn-do-save-quotationroute').addClass('disabled');
                $('#btn-do-save-quotationroute').html('Đang xử lý...');

                var xhr = new XMLHttpRequest();
                xhr.open('POST', jobs.ajaxPath + '?ts=' + new Date().getTime().toString());
                xhr.onload = function () {
                    NProgress.done();

                    var result = JSON.parse(xhr.responseText);
                    $('#btn-do-save-quotationroute').removeClass('disabled');
                    $('#btn-do-save-quotationroute').html(jobs.mode_quotationroute == 'create' ? 'Thêm' : 'Lưu');
                    alert(result.Message);

                    if (result.ErrorCode == 0) {
                        jobs.reloadpage();
                    }
                };

                var form = new FormData();
                form.append('mod', jobs.mode_quotationroute + '_quotation_route');
                form.append('data', JSON.stringify(postdata));

                xhr.send(form);
            },

            validateForm_quotation_route: function () {
                var message = '';
                var data = new Object();

                data.jobid = jobs.currentobj.ID;

                data.placestart = Number($('#info-quotation-route-place-start').val());
                data.placeend = Number($('#info-quotation-route-place-end').val());
                if (data.placestart == data.placeend)
                    message += '- Lộ trình không hợp lệ!<br/>';

                data.company = Number($('#info-quotation-route-transcomps').val());

                data.vehicletype = Number($('#info-quotation-route-vehicletypes').val());
                data.vehicleload = Number($('#info-quotation-route-vehicleloads').val());

                data.quotationcomp = Number($('#info-quotation-route-quotation-by-comp').val());
                if (isNaN(data.quotationcomp))
                    message += '- Cần chọn báo giá gốc từ Hãng vận chuyển!<br/>';
                data.quotationcustomer = Number($('#info-quotation-route-quotation-by-customer').val());

                data.price = Number(globalhelpers.Convert_FromMoney($('#info-quotationroute-value-price').val()));
                if (isNaN(data.price))
                    message += '- Giá không hợp lệ!<br/>';

                data.quantity = Number($('#info-quotationroute-value-quantity').val());
                if (isNaN(data.quantity) || data.quantity <= 0)
                    message += '- Số lượng xe không hợp lệ!<br/>';

                data.isusd = $('#info-quotationroute-value-isusd').prop('checked');

                data.expirestart = $('#info-quotationroute-value-expire-start').val();
                data.expireend = $('#info-quotationroute-value-expire-end').val();

                data.extrafee = Number(globalhelpers.Convert_FromMoney($('#info-quotationroute-info-extrafee').val()));
                if (isNaN(data.extrafee))
                    message += '- Phí phụ thu không hợp lệ!<br/>';

                data.description = $('#info-quotationroute-info-description').val();

                data.vehicleno = $('#info-quotationroute-info-vehicleno').val();
                data.driverphone = $('#info-quotationroute-info-driverphone').val();

                data.loads = Number($('#info-quotationroute-info-loads').val());
                if (isNaN(data.loads))
                    message += '- Trọng lượng hàng không hợp lệ!<br/>';

                data.comppromotion = Number(globalhelpers.Convert_FromMoney($('#info-quotationroute-info-comppromotion').val()));
                if (isNaN(data.comppromotion))
                    message += '- Giảm giá từ Hãng không hợp lệ!<br/>';

                data.usdrate = Number(globalhelpers.Convert_FromMoney($('#info-quotationroute-info-usdrate').val()));
                if (data.isusd && (isNaN(data.usdrate) || data.usdrate <= 0))
                    message += '- Tỉ giá USD không hợp lệ!<br/>';

                data.id = jobs.mode_quotationroute == "create" ? 0 : jobs.currentobj_quotation_route.ID;

                if (message != '') {
                    jobs.alert_quotation_route(message);
                    return null;
                }

                return data;
            },

            generate_quotation_value: function () {
                var quotationCompID = Number($('#info-quotation-route-quotation-by-comp').val());
                var quotationComp = jobs.getobj(quotationCompID, jobs.allQuotation_Comp);
                if (quotationComp == null) return;

                var placeStart = Number($('#info-quotation-route-place-start').val());
                var priceFromComp = quotationComp.IsSamePrice ? quotationComp.Price : placeStart == quotationComp.Route.StartPoint ? quotationComp.Price : quotationComp.Price_RoundedTrip;

                var quotationCustomerID = Number($('#info-quotation-route-quotation-by-customer').val());
                var quotationCustomer = jobs.getobj(quotationCustomerID, jobs.allQuotation_Customer);

                if (jobs.mode_quotationroute == 'create') {
                    $('#info-quotationroute-value-price').val(globalhelpers.Format_Money(quotationCustomer != null ? quotationCustomer.Price : priceFromComp));
                    $('#info-quotationroute-value-isusd').prop('checked', quotationCustomer != null ? quotationCustomer.IsUSD : quotationComp.IsUSD);
                    $('#info-quotationroute-value-expire-start').val(quotationCustomer != null ? quotationCustomer.sExpireStart : quotationComp.sExpireStart);
                    $('#info-quotationroute-value-expire-end').val(quotationCustomer != null ? quotationCustomer.sExpireEnd : quotationComp.sExpireEnd);
                }
                else {
                    $('#info-quotationroute-value-price').val(globalhelpers.Format_Money(jobs.currentobj_quotation_route.Price));
                }
            },

            getfilter: function () {
                var filter = new Object();
                filter.PlaceStart = Number($('#info-quotation-route-place-start').val());
                filter.PlaceEnd = Number($('#info-quotation-route-place-end').val());
                filter.LoadID = Number($('#info-quotation-route-vehicleloads').val());

                return filter;
            },

            getlist: function (value, list, field) {
                if (value == undefined || list == undefined || list == null || list.length == 0 || field == undefined) return null;
                var result = new Array();
                for (var i = 0; i < list.length; i++) {
                    if (list[i][field] == value) result.push(list[i]);
                }

                return result.length == 0 ? null : result;
            },

            load_quotation_customer: function () {
                //Báo giá Khách hàng
                var quotationCompID = Number($('#info-quotation-route-quotation-by-comp').val());
                if (isNaN(quotationCompID)) {
                    $('#divQuotationRoute_By_Customers').html('');
                    return;
                }
                var quotation = jobs.getobj(quotationCompID, jobs.allQuotation_Comp);

                var html_Customer = "";

                if (quotation == null) {
                    html_Customer += "<label class='control-label label-quicklink'><a href='/bao-gia-van-chuyen'>Chưa có dữ liệu Báo giá vận chuyển! Nhấp chọn chuyển sang trang Quản lý!</a></label>";
                }
                else {
                    html_Customer =
                        "<select id=\"info-quotation-route-quotation-by-customer\" onchange=\"jobs.generate_quotation_value();\" class=\"form-control\" style=\"width: 100%;\">" +
                            "<option value=\"-1\">--- Tạo mới ---</option>";

                    var list = jobs.getlist(quotationCompID, jobs.allQuotation_Customer, "QuotationID");

                    if (list != null)

                        for (var i = 0; i < list.length; i++) {
                            var quotationCustomer = list[i];

                            html_Customer += "<option value=\"" + quotationCustomer.ID + "\">" + "Giá: " + globalhelpers.Format_Money(quotationCustomer.Price.toFixed(2)) + " - Hiệu lực từ " + quotationCustomer.sExpireStart + " đến " + quotationCustomer.sExpireEnd + "</option>";
                        }
                }

                html_Customer += "</select>";

                $('#divQuotationRoute_By_Customers').html(html_Customer);

                if (jobs.mode_quotationroute == 'edit')
                    $('#info-quotation-route-quotation-by-customer').val(jobs.currentobj_quotation_route.QuotationCustomerID);

                jobs.generate_quotation_value();

                //---------------

                $('[data-toggle="tooltip"]').tooltip();
            },

            load_quotations: function () {
                var filter = this.getfilter();

                NProgress.start();
                globalhelpers.ShowOverlay(true, 'Đang lấy dữ liệu Báo giá');
                var filterString = JSON.stringify(filter);
                $.post(jobs.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': "loadquotations", 'page': jobs.currentpage, 'filter': filterString },
                                function (data) {
                                    NProgress.done();
                                    globalhelpers.ShowOverlay(false);

                                    var result = JSON.parse(data);

                                    //Báo giá Hãng

                                    var html_Comp = "";

                                    if (result.ErrorCode != 0) {
                                        html_Comp += "<label class='control-label label-quicklink'><a href='/bao-gia-van-chuyen'>Chưa có dữ liệu Báo giá vận chuyển! Nhấp chọn chuyển sang trang Quản lý!</a></label>";
                                    }
                                    else {
                                        jobs.allQuotation_Comp = result.Data.List_ByComp == "" ? null : JSON.parse(result.Data.List_ByComp);
                                        jobs.allQuotation_Customer = result.Data.List_ByCustomer == "" ? null : JSON.parse(result.Data.List_ByCustomer);
                                        if (jobs.allQuotation_Comp == null)
                                            html_Comp += "<label class='control-label label-quicklink'><a href='/bao-gia-van-chuyen'>Chưa có dữ liệu Báo giá vận chuyển! Nhấp chọn chuyển sang trang Quản lý!</a></label>";
                                        else {
                                            html_Comp = "<select id=\"info-quotation-route-quotation-by-comp\" onchange=\"jobs.load_quotation_customer();\" class=\"form-control\" style=\"width: 100%;\">";

                                            for (var i = 0; i < jobs.allQuotation_Comp.length; i++) {
                                                var quotationComp = jobs.allQuotation_Comp[i];

                                                html_Comp += "<option value=\"" + quotationComp.ID + "\">" + ("Giá: " + (quotationComp.IsSamePrice ? globalhelpers.Format_Money(quotationComp.Price.toFixed(2)) : (filter.PlaceStart == quotationComp.Route.StartPoint ? globalhelpers.Format_Money(quotationComp.Price.toFixed(2)) : globalhelpers.Format_Money(quotationComp.Price_RoundedTrip.toFixed(2)))) + " - Hiệu lực từ " + quotationComp.sExpireStart + " đến " + quotationComp.sExpireEnd) + "</option>";
                                            }

                                            html_Comp += "</select>";
                                        }
                                    }

                                    $('#divQuotationRoute_By_TransportCompanies').html(html_Comp);

                                    if (jobs.mode_quotationroute == 'edit')
                                        $('#info-quotation-route-quotation-by-comp').val(jobs.currentobj_quotation_route.QuotationCompID);

                                    jobs.load_quotation_customer();

                                    //---------------

                                    $('[data-toggle="tooltip"]').tooltip();
                                });
            },

            generate_vehicleloads: function () {
                var compId = Number($('#info-quotation-route-transcomps').val());
                var comp = this.getobj(compId, this.allComps);
                if (comp == null) return;

                var typeId = Number($('#info-quotation-route-vehicletypes').val());
                var type = this.getobj(typeId, comp.VehicleTypes);
                if (type == null) return;

                if (type.Loads == null || type.Loads.length == 0) {
                    $('#divQuotationRoute_Vehicle_Loads').html('<label class="control-label label-quicklink"><a href="/hang-van-chuyen">Chưa có dữ liệu Tải trọng xe của hãng! Nhấp chọn chuyển sang trang Quản lý!</a></label>');
                }
                else {
                    var html = "<select id=\"info-quotation-route-vehicleloads\" onchange=\"jobs.load_quotations();\" class=\"form-control\" style=\"width: auto;\">";

                    for (var i = 0; i < type.Loads.length; i++) {
                        var load = type.Loads[i];
                        html += "<option value=\"" + load.ID + "\">" + load.VehicleLoad.Name + "</option>";
                    }

                    html += "</select>";

                    $('#divQuotationRoute_Vehicle_Loads').html(html);

                    this.load_quotations();
                }
            },

            generate_vehicletypes: function () {
                var compId = Number($('#info-quotation-route-transcomps').val());
                var comp = this.getobj(compId, this.allComps);
                if (comp == null) return;

                if (comp.VehicleTypes == null || comp.VehicleTypes.length == 0) {
                    $('#divQuotationRoute_Vehicle_Types').html('<label class="control-label label-quicklink"><a href="/hang-van-chuyen">Chưa có dữ liệu Loại xe của hãng! Nhấp chọn chuyển sang trang Quản lý!</a></label>');
                    $('#divQuotationRoute_Vehicle_Loads').html('');
                }
                else {
                    var html = "<select id=\"info-quotation-route-vehicletypes\" onchange=\"jobs.generate_vehicleloads();\" class=\"form-control\" style=\"width: auto;\">";

                    for (var i = 0; i < comp.VehicleTypes.length; i++) {
                        var type = comp.VehicleTypes[i];
                        html += "<option value=\"" + type.ID + "\">" + type.sVehicleTypeName + "</option>";
                    }

                    html += "</select>";

                    $('#divQuotationRoute_Vehicle_Types').html(html);

                    this.generate_vehicleloads();
                }
            },

            generate_companies: function () {
                if (this.allComps == null || this.allComps.length == 0) {
                    $('#divQuotationRoute_TransportComps').html('<label class="control-label label-quicklink"><a href="/hang-van-chuyen">Chưa có dữ liệu Hãng vận chuyển! Nhấp chọn chuyển sang trang Quản lý!</a></label>');
                    $('#divQuotationRoute_Vehicle_Types').html('');
                    $('#divQuotationRoute_Vehicle_Loads').html('');
                }
                else {
                    var html = "<select id=\"info-quotation-route-transcomps\" onchange=\"jobs.generate_vehicletypes();\" class=\"form-control\" style=\"width: auto;\">";

                    for (var i = 0; i < this.allComps.length; i++) {
                        var comp = this.allComps[i];
                        html += "<option value=\"" + comp.ID + "\">" + comp.Name + "</option>";
                    }

                    html += "</select>";

                    $('#divQuotationRoute_TransportComps').html(html);

                    this.generate_vehicletypes();
                }
            },

            startAdd_quotation_route: function () {
                this.mode_quotationroute = 'create';
                $('#modal-info-quotation-route .modal-header .modal-title').html('Thêm mới Báo giá Vận chuyển');
                $('#btn-do-save-quotationroute').html('Thêm');
                $('#modal-info-quotation-route').modal('show');
            },

            onchange_type: function () {
                var id = this.generateJobID();

                $('#jobID').html('[' + id + ']');
                $('#info-jobid').val(id);
            },

            startEdit: function (id) {
                jobs.mode = 'edit';

                $('#info-types').val(jobs.currentobj.Type);
                $('#info-jobid').val(this.generateJobID());
                $('#info-invoiceno').val(jobs.currentobj.InvoiceNO);
                $('#info-billladingno').val(jobs.currentobj.BillLadingNO);
                $('#info-tkhq').val(jobs.currentobj.TKHQNO);
                $('#info-customers').val(jobs.currentobj.CustomerID);
                $('#info-usdrate').val(globalhelpers.Format_Money(jobs.currentobj.USDRate));

                //Status
                $('#info-isconsigned').prop('checked', jobs.currentobj.IsConsigned);
                if (jobs.currentobj.IsConsigned) {
                    $('#div-info-consigned').show();
                    $('#info-consigned-time').val(jobs.currentobj.sConsignedTime);
                    $('#info-consigned-date').val(jobs.currentobj.sConsignedDate);
                }
                else {
                    $('#div-info-consigned').hide();
                    $('#info-consigned-time').val('');
                    $('#info-consigned-date').val('');
                }

                $('#info-isinformtranscomp').prop('checked', jobs.currentobj.IsInformTransportComp);
                $('#info-ispayedfortranscomp').prop('checked', jobs.currentobj.IsPayedForTransportComp);

                //Quotation routes
                jobs.generate_quotation_routes();

                $('#btn-do-save').html('Lưu');
                $('#modal-info').modal('show');
            },

            onchange_isconsigned: function (ctrl) {
                if ($(ctrl).prop('checked'))
                    $('#div-info-consigned').show();
                else
                    $('#div-info-consigned').hide();
            },

            dosave_status: function () {
                var postdata = jobs.validateForm_status();
                if (postdata == null)
                    return;

                NProgress.start();
                $('#btn-do-save-status').addClass('disabled');
                $('#btn-do-save-status').html('Đang xử lý...');

                var xhr = new XMLHttpRequest();
                xhr.open('POST', jobs.ajaxPath + '?ts=' + new Date().getTime().toString());
                xhr.onload = function () {
                    NProgress.done();

                    var result = JSON.parse(xhr.responseText);
                    $('#btn-do-save-status').removeClass('disabled');
                    $('#btn-do-save-status').html('Lưu');
                    alert(result.Message);
                };

                var form = new FormData();
                form.append('mod', 'update_status');
                form.append('data', JSON.stringify(postdata));

                xhr.send(form);
            },

            validateForm_status: function () {
                var message = '';
                var data = new Object();
                data.isconsigned = $('#info-isconsigned').prop('checked');

                data.consignedtime = $('#info-consigned-time').val();
                data.consigneddate = $('#info-consigned-date').val();
                if (data.isconsigned) {
                    if (data.consignedtime == '')
                        message += '- Giờ giao hàng không hợp lệ!<br/>';
                    if (data.consigneddate == '')
                        message += '- Ngày giao hàng không hợp lệ!<br/>';
                }

                data.isinformtranscomp = $('#info-isinformtranscomp').prop('checked');

                data.ispayedfortranscomp = $('#info-ispayedfortranscomp').prop('checked');

                data.id = jobs.currentobj.ID;

                if (message != '') {
                    jobs.alert(message);
                    return null;
                }

                return data;
            },

            doAdd: function () {
                var postdata = jobs.validateForm();
                if (postdata == null)
                    return;

                NProgress.start();
                $('#btn-do-save-info').addClass('disabled');
                $('#btn-do-save-info').html('Đang xử lý...');

                var xhr = new XMLHttpRequest();
                xhr.open('POST', jobs.ajaxPath + '?ts=' + new Date().getTime().toString());
                xhr.onload = function () {
                    NProgress.done();

                    var result = JSON.parse(xhr.responseText);
                    $('#btn-do-save-info').removeClass('disabled');
                    $('#btn-do-save-info').html(jobs.mode == 'create' ? 'Thêm' : 'Lưu');
                    alert(result.Message);

                    if (result.ErrorCode == 0) {
                        if (jobs.mode == 'create')
                            location.href = '/<%= CurrentSys_Module.Alias %>/?job=' + result.Data;
                }
                };

                var form = new FormData();
                form.append('mod', jobs.mode);
                form.append('data', JSON.stringify(postdata));

                xhr.send(form);
            },

            reloadpage: function () {
                location.href = location.href;
            },

            validateForm: function () {
                var message = '';
                var data = new Object();
                data.type = $('#info-types').val();

                data.jobid = $('#info-jobid').val();
                if (data.jobid == '')
                    message += '- JobID không hợp lệ!<br/>';

                data.invoiceno = $('#info-invoiceno').val();

                data.billladingno = $('#info-billladingno').val();

                data.tkhq = $('#info-tkhq').val();

                data.customer = Number($('#info-customers').val());

                data.usdrate = Number(globalhelpers.Convert_FromMoney($('#info-usdrate').val()));
                if (isNaN(data.usdrate))
                    message += '- Tỉ giá USD không hợp lệ!<br/>';

                data.id = jobs.mode == "create" ? 0 : jobs.currentobj.ID;

                if (message != '') {
                    jobs.alert(message);
                    return null;
                }

                return data;
            },

            startAdd: function () {
                jobs.mode = 'create';
                $('#btn-do-save-info').html('Thêm');

                $('#info-jobid').val(this.generateJobID());
            },

            generateJobID: function () {
                var type = Number($('#info-types').val());
                var id = this.currentjobID;

                if (this.currentobj == null) {
                    id = 'SM-' + (type == 0 ? 'IM' : 'EX') + '-' + id;
                }
                else {
                    if (type == 0)
                        id = id.replace('EX', 'IM');
                    else
                        id = id.replace('IM', 'EX');
                }

                $('#jobID').html('[' + id + ']');

                return id;
            },

            getobj: function (value, list, field) {
                if (field == undefined) field = "ID";
                if (list == undefined || list == null) return null;

                for (var i = 0; i < list.length; i++)
                    if (list[i][field] == value) return list[i];

                return null;
            },

            loadlist: function () {
                NProgress.start();

                $.post(jobs.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': "loadlist", 'page': jobs.currentpage },
                                function (data) {
                                    NProgress.done();
                                    var result = JSON.parse(data);

                                    var html =
                                        "<table id=\"tblList\" class=\"table table-vcenter table-striped table-condensed table-hover table-bordered\">" +
                                            "<thead>" +
                                                "<tr>" +
                                                    "<th class=\"text-center\">STT</th>" +
                                                    "<th class=\"text-center\">Tên</th>" +
                                                    "<th class=\"text-center\">Code</th>" +
                                                    "<th class=\"text-center\">Ghi chú</th>" +
                                                    "<th class=\"text-center\">#</th>" +
                                                "</tr>" +
                                            "</thead>" +
                                            "<tbody>";

                                    if (result.ErrorCode != 0) {
                                        html +=
                                            "<tr>" +
                                                "<td class=\"text-center\" colspan=\"5\">" +
                                                    result.Message +
                                                "</td>" +
                                            "</tr>";
                                    }
                                    else {
                                        jobs.all = JSON.parse(result.Data.List);
                                        jobs.currentpage = Number(result.Data.PageIndex);
                                        var pageSize = Number(result.Data.PageSize);
                                        var totalPages = Number(result.Data.TotalPages);

                                        for (var i = 0; i < jobs.all.length; i++) {
                                            var obj = jobs.all[i];

                                            html +=
                                                "<tr>" +
                                                    "<td class=\"text-center\">" +
                                                        (jobs.currentpage * pageSize + i + 1) +
                                                    "</td>" +
                                                    "<td class=\"text-center\">" + obj.Name + "</td>" +
                                                    "<td class=\"text-center\">" + obj.Code + "</td>" +
                                                    "<td class=\"text-center\">" + obj.Description + "</td>" +
                                                    "<td class=\"text-center\">" +
                                                        //"<div class=\"btn-group\">" +
                                                            "<a onclick=\"jobs.startedit('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Sửa\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-pencil\"></i></a>" +
                                                            "<a onclick=\"jobs.startdelete('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Xóa\" class=\"btn btn-xs btn-danger\"><i class=\"fa fa-times\"></i></a>" +
                                                        //"</div>" +
                                                    "</td>" +
                                                "</tr>";
                                        }
                                    }

                                    html += "</tbody></table>";

                                    $('#divTableList').html(html);
                                    globalhelpers.RenderPaging($('#divPaging'), '/<%= CurrentSys_Module.Alias %>', jobs.currentpage, pageSize, totalPages);

                                    $('[data-toggle="tooltip"]').tooltip();
                                });
            }
        }

                        jobs.init();
</script>
