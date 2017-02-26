<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TransportCompanies.ascx.cs" Inherits="SmileLogistics.Web.modules.functions.TransportCompanies" %>
<style type="text/css">
    #divVehicleTypes .load-name {
        height: 30px;
        line-height: 30px;
    }

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
    <div class="block full">
        <div class="block-title">
            <h2>Danh sách <strong>Hãng vận chuyển</strong></h2>
            <div class="block-options pull-right">
                <a onclick="transportcompanies.startAdd();" class="btn btn-sm btn-success" data-toggle="tooltip" title="Thêm mới"><i class="gi gi-plus"></i></a>
            </div>
        </div>
        <div class="form-horizontal">
            <div id="divTableList" class="table-responsive">
            </div>
            <div id="divPaging" class="form-group form-actions">
            </div>
        </div>
    </div>
</div>
<div id="modal-delete" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-xs">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Xóa Hãng vận chuyển?</h3>
            </div>
            <div class="modal-body">
                Bạn chắc chắn muốn xóa Hãng vận chuyển <b id="bDeleteName"></b>?<br />
                <%--<i class="text-danger">(Điều này đồng nghĩa việc xóa kèm theo lịch sử hoạt động!!!)</i>--%>
            </div>
            <div class="modal-footer">
                <a id="btn-modal-delete-close" class="btn btn-sm btn-default" data-dismiss="modal">Hủy</a>
                <a id="btn-do-delete" onclick="transportcompanies.dodelete();" class="btn btn-sm btn-danger">Xóa</a>
            </div>
        </div>
    </div>
</div>
<div id="modal-info" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Thêm mới Hãng vận chuyển</h3>
            </div>
            <div class="modal-body">
                <div id="clickable-wizard-vehiclecompany" class="form-horizontal form-bordered ui-formwizard">
                    <div id="tab-info" class="step ui-formwizard-content">
                        <div class="form-group">
                            <div class="col-xs-12">
                                <ul class="nav nav-pills nav-justified clickable-steps">
                                    <li class="active"><a href="javascript:void(0)" data-gotostep="tab-info"><strong>1. Thông tin</strong></a></li>
                                    <li><a href="javascript:void(0)" data-gotostep="tab-vehicletypes"><strong>2. Thiết lập Loại xe</strong></a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">Tên</label>
                            <div class="col-md-9">
                                <input type="text" id="info-name" class="form-control" placeholder="Tên">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">Địa chỉ</label>
                            <div class="col-md-9">
                                <input type="text" id="info-address" class="form-control" placeholder="Địa chỉ">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">Email</label>
                            <div class="col-md-9">
                                <input type="text" id="info-email" class="form-control" placeholder="Email">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">Số điện thoại</label>
                            <div class="col-md-9">
                                <input type="text" id="info-phone" class="form-control" placeholder="Số điện thoại">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">% giảm giá cho các lô hàng thứ 2 trở đi</label>
                            <div class="col-md-9">
                                <input type="text" id="info-percentsecondpackage" class="form-control" placeholder="% giảm giá" value="0">
                                <span class="help-block">(Dùng dấm chấm '.' để xác định số thập phân!)</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">Trạng thái</label>
                            <div id="divStatuses" runat="server" class="col-md-9">
                            </div>
                        </div>
                    </div>
                    <div id="tab-vehicletypes" class="step ui-formwizard-content">
                        <div class="form-group">
                            <div class="col-xs-12">
                                <ul class="nav nav-pills nav-justified clickable-steps">
                                    <li><a href="javascript:void(0)" data-gotostep="tab-info"><strong>1. Thông tin</strong></a></li>
                                    <li class="active"><a href="javascript:void(0)" data-gotostep="tab-vehicletypes"><strong>2. Thiết lập Loại xe</strong></a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-12">
                                <div id="divVehicleTypes" class="table-responsive">
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
                <a id="btn-do-save" onclick="transportcompanies.doAdd();" class="btn btn-sm btn-primary">Lưu</a>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var transportcompanies =
        {
            ajaxPath: '/ajax/modules/functions/transportcompanies.aspx',
            all: null,
            allTypes: null,
            mode: 'create',
            currentpage: 0,
            currentobj: null,

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
                var page = globalhelpers.GetRequestQueryString('page');
                if (!page || page == '')
                    transportcompanies.currentpage = 0;
                else
                    transportcompanies.currentpage = Number(page);

                var sTypes = '<%= _VehicleTypes %>';
                transportcompanies.allTypes = sTypes == '' ? null : JSON.parse(sTypes);

                transportcompanies.initvehicletypes();

                transportcompanies.loadlist();

                var s = $("#clickable-wizard-vehiclecompany");
                s.formwizard({ disableUIStyles: !0, inDuration: 0, outDuration: 0 });
                $(".clickable-steps a").on("click", function ()
                { var r = $(this).data("gotostep"); s.formwizard("show", r) });
            },

            initvehicletypes: function () {
                var html =
                    "<table id=\"tblList_VehicleTypes\" class=\"table table-vcenter table-striped table-condensed table-hover table-bordered\">" +
                        "<thead>" +
                            "<tr>" +
                                "<th class=\"text-center\">#</th>" +
                                "<th class=\"text-center\">Loại xe</th>" +
                                "<th class=\"text-center\">Tải trọng khả dụng</th>" +
                            "</tr>" +
                        "</thead>" +
                        "<tbody>";

                if (this.allTypes == null || this.allTypes.length == 0) {
                    html +=
                        "<tr>" +
                            "<td class=\"text-center\" colspan=\"3\">" +
                                "<label class='control-label label-quicklink'><a href='/loai-xe'>Chưa có dữ liệu Loại xe! Nhấp chọn chuyển sang trang Quản lý!</a></label>" +
                            "</td>" +
                        "</tr>";
                }
                else {
                    for (var i = 0; i < this.allTypes.length; i++) {
                        var obj = this.allTypes[i];

                        var htmlLoads = "";
                        if (obj.VehicleLoads != null && obj.VehicleLoads.length > 0) {
                            for (var j = 0; j < obj.VehicleLoads.length; j++) {
                                var load = obj.VehicleLoads[j];

                                htmlLoads +=
                                    "<div class=\"form-group\">" +
                                        "<label class=\"col-sm-3\"><label class='switch switch-success'><input id=\"row-vehicleload-" + load.ID + "\" class='inputswitch switch-vehicleload' type='checkbox' checked><span></span></label></label>" +
                                        "<div class=\"col-sm-9 load-name\">" +
                                            load.Name +
                                        "</div>" +
                                    "</div>";
                            }
                        }

                        html +=
                            "<tr id=\"row-vehicletype-" + obj.ID + "\" class=\"row-vehicletype\" dat-id=\"" + obj.ID + "\">" +
                                "<td class=\"text-center\">" +
                                    "<label class='switch switch-success'><input id=\"vehicletype-select-" + obj.ID + "\" class='inputswitch switch-vehicletype' type='checkbox' checked><span></span></label>" +
                                "</td>" +
                                "<td class=\"text-center\">" + obj.Name + "</td>" +
                                "<td class=\"text-left\">" +
                                    htmlLoads +
                                "</td>" +
                            "</tr>";
                    }
                }

                html += "</tbody></table>";

                $('#divVehicleTypes').html(html);
            },

            //-----------------------------------------------------------------------------------------------

            startdelete: function (id) {
                transportcompanies.currentobj = transportcompanies.getobj(id);
                if (transportcompanies.currentobj == null) {
                    alert('Không tìm thấy Hãng vận chuyển!');
                    return;
                }

                $('#modal-delete #bDeleteName').html(transportcompanies.currentobj.Name);
                $('#modal-delete').modal('show');
            },

            dodelete: function () {
                NProgress.start();
                $('#btn-do-delete').addClass('disabled');
                $('#btn-modal-delete-close').addClass('disabled');
                $('#btn-do-delete').html('Đang xử lý...');

                $.post(transportcompanies.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': 'delete', 'id': transportcompanies.currentobj.ID },
                                function (data) {
                                    NProgress.done();

                                    var result = JSON.parse(data);
                                    $('#btn-do-delete').removeClass('disabled');
                                    $('#btn-modal-delete-close').removeClass('disabled');
                                    $('#btn-do-delete').html('Xóa');
                                    alert(result.Message);

                                    if (result.ErrorCode == 0)
                                        transportcompanies.reloadpage();
                                });
            },

            startedit: function (id) {
                transportcompanies.mode = 'edit';
                transportcompanies.currentobj = transportcompanies.getobj(id);
                if (transportcompanies.currentobj == null) {
                    alert('Không tìm thấy Hãng vận chuyển!');
                    return;
                }

                $('#modal-info #info-name').val(transportcompanies.currentobj.Name);
                $('#modal-info #info-address').val(transportcompanies.currentobj.Address);
                $('#modal-info #info-email').val(transportcompanies.currentobj.Email);
                $('#modal-info #info-phone').val(transportcompanies.currentobj.PhoneNumber);
                $('#modal-info #info-statuses').val(transportcompanies.currentobj.Status);
                $('#modal-info #info-percentsecondpackage').val(transportcompanies.currentobj.PercentSecondPackage);

                this.generateobjdata_types();

                $('#modal-info .modal-header .modal-title').html('Cập nhật Hãng vận chuyển');
                $('#btn-do-save').html('Lưu');
                $('#modal-info').modal('show');
            },

            generateobjdata_types: function () {
                if (this.allTypes == null || this.allTypes.length == 0) return;
                if (this.currentobj.VehicleTypes == null || this.currentobj.VehicleTypes.length == 0) {
                    $('.inputswitch').prop('checked', false);
                    return;
                }

                for (var i = 0; i < this.allTypes.length; i++) {
                    var type = this.allTypes[i];
                    var rowType = $('#row-vehicletype-' + type.ID);

                    var eType = this.getobjVType(this.currentobj.VehicleTypes, type.ID);
                    $('#vehicletype-select-' + type.ID).prop('checked', eType != null);

                    if (eType == null) {
                        $(rowType).find('.switch-vehicleload').prop('checked', false);
                        continue;
                    }
                    else {
                        if (eType.Loads == null || eType.Loads.length == 0) {
                            $(rowType).find('.switch-vehicleload').prop('checked', false);
                            continue;
                        }

                        for (var j = 0; j < type.VehicleLoads.length; j++) {
                            var load = type.VehicleLoads[j];
                            var switchLoad = $('#row-vehicleload-' + load.ID);

                            var eLoad = this.getobjVLoad(eType.Loads, load.ID);
                            $(switchLoad).prop('checked', eLoad != null);
                        }
                    }
                }
            },

            doAdd: function () {
                var postdata = transportcompanies.validateForm();
                if (postdata == null)
                    return;

                NProgress.start();
                $('#btn-do-save').addClass('disabled');
                $('#btn-modal-add-close').addClass('disabled');
                $('#btn-do-save').html('Đang xử lý...');

                var xhr = new XMLHttpRequest();
                xhr.open('POST', transportcompanies.ajaxPath + '?ts=' + new Date().getTime().toString());
                xhr.onload = function () {
                    NProgress.done();

                    var result = JSON.parse(xhr.responseText);
                    $('#btn-do-save').removeClass('disabled');
                    $('#btn-modal-add-close').removeClass('disabled');
                    $('#btn-do-save').html(transportcompanies.mode == 'create' ? 'Thêm' : 'Lưu');
                    alert(result.Message);

                    if (result.ErrorCode == 0)
                        transportcompanies.reloadpage();
                };

                var form = new FormData();
                form.append('mod', transportcompanies.mode);
                form.append('data', JSON.stringify(postdata));

                xhr.send(form);
            },

            reloadpage: function () {
                location.href = '/<%= CurrentSys_Module.Alias %>/?page=' + transportcompanies.currentpage;
            },

            validateForm: function () {
                var message = '';
                var data = new Object();
                data.name = $('#modal-info #info-name').val();
                if (data.name == '')
                    message += '- Tên không hợp lệ!<br/>';

                data.address = $('#modal-info #info-address').val();
                data.email = $('#modal-info #info-email').val();
                data.phone = $('#modal-info #info-phone').val();
                data.percentsecondpackage = Number($('#modal-info #info-percentsecondpackage').val());
                if (isNaN(data.percentsecondpackage))
                    message += '- % giảm giá không hợp lệ!<br/>';

                data.status = Number($('#modal-info #info-statuses').val());

                data.vehicletypes = new Array();

                var types = $('#divVehicleTypes .row-vehicletype');
                for (var i = 0; i < types.length; i++) {
                    var typeDOM = types[i];
                    var typeId = Number($(typeDOM).attr('dat-id'));
                    var type = this.getobjType(typeId);
                    if (type != null) {
                        var checked = $('#vehicletype-select-' + type.ID).prop('checked');
                        var typeObj = new Object();
                        typeObj.ID = typeId;
                        typeObj.Loads = null;
                        if (checked) {
                            typeObj.Loads = new Array();
                            for (var j = 0; j < type.VehicleLoads.length; j++) {
                                var load = type.VehicleLoads[j];
                                var loadDOM = $('#row-vehicleload-' + load.ID);
                                if (loadDOM.prop('checked')) {
                                    var loadObj = new Object();
                                    loadObj.ID = load.ID;
                                    typeObj.Loads.push(loadObj);
                                }
                            }

                            data.vehicletypes.push(typeObj);
                        }
                    }
                }

                data.id = transportcompanies.mode == "create" ? 0 : transportcompanies.currentobj.ID;

                if (message != '') {
                    transportcompanies.alert(message);
                    return null;
                }

                return data;
            },

            startAdd: function () {
                transportcompanies.mode = 'create';
                $('#modal-info .modal-header .modal-title').html('Thêm mới Hãng vận chuyển');
                $('#btn-do-save').html('Thêm');
                $('#modal-info').modal('show');
            },

            getobj: function (id) {
                if (transportcompanies.all == null) return null;
                for (var i = 0; i < transportcompanies.all.length; i++)
                    if (transportcompanies.all[i].ID == id) return transportcompanies.all[i];

                return null;
            },

            getobjType: function (id) {
                if (this.allTypes == null) return null;
                for (var i = 0; i < this.allTypes.length; i++)
                    if (this.allTypes[i].ID == id) return this.allTypes[i];

                return null;
            },

            getobjVType: function (list, id) {
                if (list == null) return null;
                for (var i = 0; i < list.length; i++)
                    if (list[i].VehicleTypeID == id) return list[i];

                return null;
            },

            getobjVLoad: function (list, id) {
                if (list == null) return null;
                for (var i = 0; i < list.length; i++)
                    if (list[i].VehicleLoadID == id) return list[i];

                return null;
            },

            loadlist: function () {
                NProgress.start();

                $.post(transportcompanies.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': "loadlist", 'page': transportcompanies.currentpage },
                                function (data) {
                                    NProgress.done();
                                    var result = JSON.parse(data);

                                    var html =
                                        "<table id=\"tblList\" class=\"table table-vcenter table-striped table-condensed table-hover table-bordered\">" +
                                            "<thead>" +
                                                "<tr>" +
                                                    "<th class=\"text-center\">STT</th>" +
                                                    "<th class=\"text-center\">Tên</th>" +
                                                    "<th class=\"text-center\">Địa chỉ</th>" +
                                                    "<th class=\"text-center\">Số điện thoại</th>" +
                                                    "<th class=\"text-center\">Email</th>" +
                                                    "<th class=\"text-center\">% giảm giá</th>" +
                                                    "<th class=\"text-center\">Trạng thái</th>" +
                                                    "<th class=\"text-center\">#</th>" +
                                                "</tr>" +
                                            "</thead>" +
                                            "<tbody>";

                                    if (result.ErrorCode != 0) {
                                        html +=
                                            "<tr>" +
                                                "<td class=\"text-center\" colspan=\"8\">" +
                                                    result.Message +
                                                "</td>" +
                                            "</tr>";
                                    }
                                    else {
                                        transportcompanies.all = JSON.parse(result.Data.List);
                                        transportcompanies.currentpage = Number(result.Data.PageIndex);
                                        var pageSize = Number(result.Data.PageSize);
                                        var totalPages = Number(result.Data.TotalPages);

                                        for (var i = 0; i < transportcompanies.all.length; i++) {
                                            var obj = transportcompanies.all[i];

                                            html +=
                                                "<tr>" +
                                                    "<td class=\"text-center\">" +
                                                        (transportcompanies.currentpage * pageSize + i + 1) +
                                                    "</td>" +
                                                    "<td class=\"text-center\">" + obj.Name + "</td>" +
                                                    "<td class=\"text-center\">" + obj.Address + "</td>" +
                                                    "<td class=\"text-center\">" + obj.PhoneNumber + "</td>" +
                                                    "<td class=\"text-center\">" + obj.Email + "</td>" +
                                                    "<td class=\"text-center\">" + obj.PercentSecondPackage.toFixed(2) + "</td>" +
                                                    "<td class=\"text-center\">" + obj.StatusName + "</td>" +
                                                    "<td class=\"text-center\">" +
                                                        //"<div class=\"btn-group\">" +
                                                            "<a onclick=\"transportcompanies.startedit('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Sửa\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-pencil\"></i></a>" +
                                                            "<a onclick=\"transportcompanies.startdelete('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Xóa\" class=\"btn btn-xs btn-danger\"><i class=\"fa fa-times\"></i></a>" +
                                                        //"</div>" +
                                                    "</td>" +
                                                "</tr>";
                                        }
                                    }

                                    html += "</tbody></table>";

                                    $('#divTableList').html(html);
                                    globalhelpers.RenderPaging($('#divPaging'), '/<%= CurrentSys_Module.Alias %>', transportcompanies.currentpage, pageSize, totalPages);

                                    $('[data-toggle="tooltip"]').tooltip();
                                });
            }
        }

                        transportcompanies.init();
</script>
