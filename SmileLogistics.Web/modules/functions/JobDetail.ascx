<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="JobDetail.ascx.cs" Inherits="SmileLogistics.Web.modules.functions.JobDetail" %>
<style type="text/css">
    .modal-body .nav-tabs {
        padding: 3px 1px 0 !important;
        margin: 0 !important;
        margin-bottom: -2px !important;
    }

    .block {
        padding-bottom: 0 !important;
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
        </div>
        <div class="col-md-7">
            <div class="block full block-related-edit">
                <div class="block-title">
                    <h2>Báo giá <strong>Vận chuyển</strong></h2>
                    <div class="block-options pull-right">
                        <a onclick="jobs.startAdd_quotation_route();" class="btn btn-sm btn-success" data-toggle="tooltip" title="Thêm mới"><i class="gi gi-plus"></i></a>
                    </div>
                </div>
                <div class="form-horizontal">
                    <div id="divQuotation_Routes" class="table-responsive">
                    </div>
                </div>
            </div>
            <div class="block full block-related-edit">
                <div class="block-title">
                    <h2>Báo giá <strong>TTHQ</strong></h2>
                    <div id="divQuotation-customs-settings" class="block-options pull-right">
                        <a onclick="jobs.startAdd_quotation_customs();" class="btn btn-sm btn-success" data-toggle="tooltip" title="Thiết lập báo giá"><i class="hi hi-cog"></i></a>
                    </div>
                </div>
                <div id="divQuotation-customs-details" class="form-horizontal">
                    <div id="divQuotationCustoms_Row_Customers" class="form-group">
                        <label class="col-md-3 control-label">Báo giá theo Khách hàng</label>
                        <div id="divQuotationCustoms_By_Customers" class="col-md-9">
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
                            <input type="text" id="info-quotation-customs-usdrate" class="form-control" placeholder="1 USD = ? VND">
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
                    <h2>Tạm ứng cho <strong>Nhân viên</strong></h2>
                    <div class="block-options pull-right">
                        <a onclick="vehicletypes.startAdd();" class="btn btn-sm btn-success" data-toggle="tooltip" title="Thêm mới"><i class="gi gi-plus"></i></a>
                    </div>
                </div>
                <div class="form-horizontal">
                    <div id="divAgentPrepaids" class="table-responsive">
                    </div>
                    <div id="divPaging_AgentPrepaids" class="form-group form-actions">
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
                        <div id="divCustomerPrepaids" class="table-responsive">
                        </div>
                    </div>
                    <div class="form-group form-actions text-right">
                        <a id="btn-do-save-customerpayment" class="btn btn-sm btn-primary">Lưu</a>
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
                                            <input type="text" id="info-quotationroute-value-price" class="form-control" placeholder="Giá" style="width: auto;">
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
                                            <input type="text" id="info-quotationroute-info-usdrate" class="form-control" placeholder="1 USD = ? VND" style="width: auto;" value="0">
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
                                            <input type="text" id="info-quotationroute-info-comppromotion" class="form-control" placeholder="Giảm giá từ Hãng" style="width: auto;" value="0">
                                        </div>
                                        <label class="col-md-3 control-label">Phí phụ thu</label>
                                        <div class="col-md-3">
                                            <input type="text" id="info-quotationroute-info-extrafee" class="form-control" placeholder="Phí phụ thu (nếu có)" style="width: auto;" value="0">
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
                                            <input type="text" id="info-quotationroute-info-loads" class="form-control" placeholder="Trọng lượng hàng" style="width: auto;" value="0">
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
<script type="text/javascript">
    var jobs =
        {
            ajaxPath: '/ajax/modules/functions/jobs.aspx',
            mode: 'create',
            mode_quotationroute: 'create',
            currentobj: null,
            currentobj_quotation_route: null,
            currentjobID: '',
            allComps: null,
            allQuotation_Comp: null,
            allQuotation_Customer: null,

            allCustomsFeeTypes: null,
            allQuotationCustoms_Customers: null,

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

            init: function () {
                var s = $("#clickable-wizard-quotation-infos");
                s.formwizard({ disableUIStyles: !0, inDuration: 0, outDuration: 0 });
                $(".clickable-steps a").on("click", function ()
                { var r = $(this).data("gotostep"); s.formwizard("show", r) });

                var sObj = '<%= _JobDetail %>';
                if (sObj == '')
                    this.currentobj = null;
                else
                    this.currentobj = JSON.parse(sObj);

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

                var sQuotationCustoms_Customers = '<%= _AllCustomerQuotation_Customs %>';
                if (sQuotationCustoms_Customers == '')
                    this.allQuotationCustoms_Customers = null;
                else
                    this.allQuotationCustoms_Customers = JSON.parse(sQuotationCustoms_Customers);

                this.generate_companies();
                this.generate_quotationcustoms_controls_customer();
            },

            //-----------------------------------------------------------------------------------------------

            startAdd_quotation_customs: function () {
                $('#divQuotation-customs-settings').hide();
                $('#divQuotation-customs-details').show();
                $('#divQuotation-customs-controls').show();
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

                data.usdrate = Number($('#info-quotation-customs-usdrate').val());
                if (data.isusd && (isNaN(data.usdrate) || data.usdrate <= 0))
                    message += '- Tỉ giá USD không hợp lệ!<br/>';

                data.feetypes = new Array();
                for (var i = 0; i < jobs.allCustomsFeeTypes.length; i++) {
                    var fee = jobs.allCustomsFeeTypes[i];
                    var detail = new Object();
                    detail.ID = fee.ID;
                    detail.Description = $('#info-quotationcustoms-description-' + detail.ID).val();
                    detail.Price = Number($('#info-quotationcustoms-price-' + detail.ID).val());
                    if (isNaN(detail.Price) || detail.Price < 0)
                        message += '- Phí ' + fee.Name + ' không hợp lệ!<br/>';

                    data.feetypes.push(detail);
                }

                if (message != '') {
                    jobs.alert_quotation_customs(message);
                    return null;
                }

                return data;
            },

            generate_quotationcustoms_values: function () {
                if (this.currentobj == null) {
                    $('#divQuotation-customs-settings').show();
                    $('#divQuotation-customs-details').hide();
                    $('#divQuotation-customs-controls').hide();
                    return;
                }

                if (this.currentobj.QuotationCustoms == null)
                {
                    $('#divQuotation-customs-settings').show();
                    $('#divQuotation-customs-details').hide();
                    $('#divQuotation-customs-controls').hide();
                }
                else
                {
                    $('#divQuotation-customs-settings').hide();
                    $('#divQuotation-customs-details').show();
                    $('#divQuotation-customs-controls').show();
                }

                var quotationcustoms_customerID = Number($('#info-quotation-customs-quotation-by-customers').val());
                if (isNaN(quotationcustoms_customerID)) return;

                var quotationcustoms_Customer = jobs.getobj(quotationcustoms_customerID, jobs.allQuotationCustoms_Customers);
                var quotation = jobs.currentobj.QuotationCustoms != null ? jobs.currentobj.QuotationCustoms : quotationcustoms_Customer != null ? quotationcustoms_Customer : null;
                if (quotation != null) {
                    //$('#info-quotation-customs-quotation-by-customers').attr('disabled', 'disabled');
                    $('#divQuotationCustoms_Row_Customers').hide();

                    $('#info-quotation-customs-description').val(quotation.Description);

                    $('#info-quotation-customs-isusd').prop('checked', quotation.IsUSD);

                    $('#info-quotation-customs-expire-start').val(quotation.sExpireStart);
                    $('#info-quotation-customs-expire-end').val(quotation.sExpireEnd);

                    $('#info-quotation-customs-usdrate').val(quotation.USDRate);
                }

                var feeDetails = quotation == null ? jobs.allCustomsFeeTypes : quotation.FeeDetails;

                if (feeDetails == null || feeDetails.length == 0) {
                    $('#divQuotation_Customs_FeeDetails').html('<label class="control-label label-quicklink"><a href="/loai-phi-tthq">Không tìm thấy Loại phí TTHQ! Chuyển sang trang Quản lý?</a></label>');
                }

                var html =
                    "<table id=\"tblList_Quotation_Customs_Fees\" class=\"table table-vcenter table-striped table-condensed table-hover table-bordered\">" +
                        "<thead>" +
                            "<tr>" +
                                "<th class=\"text-center\">Tên loại phí</th>" +
                                "<th class=\"text-center\">Tổng tiền</th>" +
                                "<th class=\"text-center\" style=\"width: 60%;\">Ghi chú</th>" +
                            "</tr>" +
                        "</thead>" +
                        "<tbody>";

                for (var i = 0; i < feeDetails.length; i++) {
                    var detail = feeDetails[i];
                    var id = quotation == null ? detail.ID : detail.FeeTypeID;
                    var name = quotation == null ? detail.Name : detail.sFeeTypeName;
                    var price = quotation == null ? 0 : detail.Price;
                    var description = quotation == null ? "" : detail.Description;

                    html +=
                        "<tr>" +
                            "<td class=\"text-center\">" +
                                (quotation == null ? detail.Name : detail.sFeeTypeName) +
                            "</td>" +
                            "<td class=\"text-center\">" +
                                "<input type=\"text\" id=\"info-quotationcustoms-price-" + id + "\" class=\"form-control\" placeholder=\"Phí " + name + "\" style=\"width: 100%;\" value=\"" + price + "\">" +
                            "</td>" +
                            "<td class=\"text-center\">" +
                                "<input type=\"text\" id=\"info-quotationcustoms-description-" + id + "\" class=\"form-control\" placeholder=\"Ghi chú\" style=\"width: 100%;\" value=\"" + description + "\">" +
                            "</td>" +
                        "</tr>";
                }

                html += "</tbody></table>";

                $('#divQuotation_Customs_FeeDetails').html(html);

                $('[data-toggle="tooltip"]').tooltip();
            },

            generate_quotationcustoms_controls_customer: function () {
                if (this.currentobj == null) return;

                var html = "";

                html =
                    "<select id=\"info-quotation-customs-quotation-by-customers\" onchange=\"jobs.generate_quotationcustoms_values();\" class=\"form-control\" style=\"width: auto;\">" +
                        "<option value=\"-1\">--- Tạo mới ---</option>";

                if (jobs.allQuotationCustoms_Customers != null && jobs.allQuotationCustoms_Customers.length > 0) {
                    for (var i = 0; i < jobs.allQuotationCustoms_Customers.length; i++) {
                        var quotation = jobs.allQuotationCustoms_Customers[i];

                        html += "<option value=\"" + quotation.ID + "\">Hiệu lực từ " + quotation.sExpireStart + " đến " + quotation.sExpireEnd + "</option>";
                    }
                }

                html += "</select>";

                $('#divQuotationCustoms_By_Customers').html(html);

                if (jobs.currentobj.QuotationCustoms != null)
                    $('#info-quotation-customs-quotation-by-customers').val(jobs.currentobj.QuotationCustoms.ID);

                jobs.generate_quotationcustoms_values();

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
                                    "<a onclick=\"jobs.startedit_quotation_route('" + route.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Sửa\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-pencil\"></i></a>" +
                                    "<a onclick=\"jobs.startdelete_quotation_route('" + route.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Xóa\" class=\"btn btn-xs btn-danger\"><i class=\"fa fa-times\"></i></a>" +
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

                $('#info-quotation-route-vehicletypes').val(jobs.currentobj_quotation_route.VehicleTypeID);
                $('#info-quotation-route-vehicleloads').val(jobs.currentobj_quotation_route.VehicleLoadID);

                jobs.load_quotations();

                $('#info-quotationroute-value-quantity').val(jobs.currentobj_quotation_route.Quantity);
                $('#info-quotationroute-value-isusd').prop('checked', jobs.currentobj_quotation_route.IsUSD);
                $('#info-quotationroute-value-expire-start').val(jobs.currentobj_quotation_route.sExpireStart);
                $('#info-quotationroute-value-expire-end').val(jobs.currentobj_quotation_route.sExpireEnd);
                $('#info-quotationroute-info-extrafee').val(jobs.currentobj_quotation_route.ExtraFee);
                $('#info-quotationroute-info-description').val(jobs.currentobj_quotation_route.Description);
                $('#info-quotationroute-info-vehicleno').val(jobs.currentobj_quotation_route.VehicleNO);
                $('#info-quotationroute-info-driverphone').val(jobs.currentobj_quotation_route.DriverPhoneNumber);
                $('#info-quotationroute-info-loads').val(jobs.currentobj_quotation_route.Loads);
                $('#info-quotationroute-info-comppromotion').val(jobs.currentobj_quotation_route.PromotionByTransComp);
                $('#info-quotationroute-info-usdrate').val(jobs.currentobj_quotation_route.USDRate);

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

                data.price = Number($('#info-quotationroute-value-price').val());
                if (isNaN(data.price))
                    message += '- Giá không hợp lệ!<br/>';

                data.quantity = Number($('#info-quotationroute-value-quantity').val());
                if (isNaN(data.quantity) || data.quantity <= 0)
                    message += '- Số lượng xe không hợp lệ!<br/>';

                data.isusd = $('#info-quotationroute-value-isusd').prop('checked');

                data.expirestart = $('#info-quotationroute-value-expire-start').val();
                data.expireend = $('#info-quotationroute-value-expire-end').val();

                data.extrafee = Number($('#info-quotationroute-info-extrafee').val());
                if (isNaN(data.extrafee))
                    message += '- Phí phụ thu không hợp lệ!<br/>';

                data.description = $('#info-quotationroute-info-description').val();

                data.vehicleno = $('#info-quotationroute-info-vehicleno').val();
                data.driverphone = $('#info-quotationroute-info-driverphone').val();

                data.loads = Number($('#info-quotationroute-info-loads').val());
                if (isNaN(data.loads))
                    message += '- Trọng lượng hàng không hợp lệ!<br/>';

                data.comppromotion = Number($('#info-quotationroute-info-comppromotion').val());
                if (isNaN(data.comppromotion))
                    message += '- Giảm giá từ Hãng không hợp lệ!<br/>';

                data.usdrate = Number($('#info-quotationroute-info-usdrate').val());
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
                    $('#info-quotationroute-value-price').val(quotationCustomer != null ? quotationCustomer.Price : priceFromComp);
                    $('#info-quotationroute-value-isusd').prop('checked', quotationCustomer != null ? quotationCustomer.IsUSD : quotationComp.IsUSD);
                    $('#info-quotationroute-value-expire-start').val(quotationCustomer != null ? quotationCustomer.sExpireStart : quotationComp.sExpireStart);
                    $('#info-quotationroute-value-expire-end').val(quotationCustomer != null ? quotationCustomer.sExpireEnd : quotationComp.sExpireEnd);
                }
                else {
                    $('#info-quotationroute-value-price').val(jobs.currentobj_quotation_route.Price);
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
                    var html = "<select id=\"info-quotation-route-transcomps\" onchange=\"jobs.generate_vehicletypes();\" class=\"select-select2 select2-hidden-accessible\" style=\"width: auto;\">";

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
