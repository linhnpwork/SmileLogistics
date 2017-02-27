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
        <div class="col-md-6">
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
        <div class="col-md-6">
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
                    <div id="divPaging_Routes" class="form-group form-actions">
                    </div>
                </div>
            </div>
            <div class="block full block-related-edit">
                <div class="block-title">
                    <h2>Báo giá <strong>TTHQ</strong></h2>
                </div>
                <div class="form-horizontal form-bordered">
                    <div class="form-group form-actions text-right">
                        <a id="btn-do-save-tthq" class="btn btn-sm btn-primary">Lưu</a>
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
                        <label class="col-md-3 control-label">Ghi chú</label>
                        <div class="col-md-9">
                            <input type="text" id="info-description" class="form-control" placeholder="Ghi chú">
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
                <a id="btn-do-save" onclick="jobs.doAdd();" class="btn btn-sm btn-primary">Lưu</a>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var jobs =
        {
            ajaxPath: '/ajax/modules/functions/jobs.aspx',
            mode: 'create',
            currentobj: null,
            currentjobID: '',
            allComps: null,

            alert: function (content) {
                $('#divModalAlert').show();
                $('#divModalAlert-content').html(
                    '<div class="alert alert-danger alert-dismissable">' +
                        '<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>' +
                        '<h4><i class="fa fa-times-circle"></i>&nbsp;Lỗi</h4>' +
                        content +
                    '</div>'
                    );
            },

            init: function () {
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

                this.generate_companies();
            },

            //-----------------------------------------------------------------------------------------------

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
                    var html = "<select id=\"info-quotation-route-vehicleloads\" class=\"form-control\" style=\"width: auto;\">";

                    for (var i = 0; i < type.Loads.length; i++) {
                        var load = type.Loads[i];
                        html += "<option value=\"" + load.ID + "\">" + load.VehicleLoad.Name + "</option>";
                    }

                    html += "</select>";

                    $('#divQuotationRoute_Vehicle_Loads').html(html);
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
