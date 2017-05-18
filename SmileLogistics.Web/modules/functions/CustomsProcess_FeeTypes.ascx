<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomsProcess_FeeTypes.ascx.cs" Inherits="SmileLogistics.Web.modules.functions.CustomsProcess_FeeTypes" %>
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
    <div class="block full">
        <div class="block-title">
            <h2>Danh sách <strong>Loại phí TTHQ</strong></h2>
            <div class="block-options pull-right">
                <a id="btn-controls-add" onclick="tthqfeetypes.startAdd();" class="btn btn-sm btn-success" data-toggle="tooltip" title="Thêm mới"><i class="gi gi-plus"></i></a>
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
                <h3 class="modal-title">Xóa Loại phí TTHQ?</h3>
            </div>
            <div class="modal-body">
                Bạn chắc chắn muốn xóa Loại phí TTHQ <b id="bDeleteName"></b>?<br />
                <%--<i class="text-danger">(Điều này đồng nghĩa việc xóa kèm theo lịch sử hoạt động!!!)</i>--%>
            </div>
            <div class="modal-footer">
                <a id="btn-modal-delete-close" class="btn btn-sm btn-default" data-dismiss="modal">Hủy</a>
                <a id="btn-do-delete" onclick="tthqfeetypes.dodelete();" class="btn btn-sm btn-danger">Xóa</a>
            </div>
        </div>
    </div>
</div>
<div id="modal-info" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Thêm mới Loại phí TTHQ</h3>
            </div>
            <div class="modal-body">
                <div class="form-horizontal form-bordered">
                    <div class="form-group">
                        <label class="col-md-3 control-label">Tên</label>
                        <div class="col-md-9">
                            <input type="text" id="info-name" class="form-control" placeholder="Tên">
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
                <a id="btn-do-save" onclick="tthqfeetypes.doAdd();" class="btn btn-sm btn-primary">Lưu</a>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var tthqfeetypes =
        {
            ajaxPath: '/ajax/modules/functions/tthqfeetypes.aspx',
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
                    tthqfeetypes.currentpage = 0;
                else
                    tthqfeetypes.currentpage = Number(page);

                var sPermissions = '<%= _RolePermissions %>';
                if (sPermissions != '')
                    this.permissions = JSON.parse(sPermissions);

                if (!globalhelpers.HasPermission("create", tthqfeetypes.permissions))
                    $('#btn-controls-add').hide();
                else
                    $('#btn-controls-add').show();

                var sTypes = '<%= _VehicleTypes %>';
                tthqfeetypes.allTypes = sTypes == '' ? null : JSON.parse(sTypes);

                //tthqfeetypes.initvehicletypes();

                tthqfeetypes.loadlist();
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
                                        "<label class=\"col-sm-3\"><label class='switch switch-success'><input id=\"row-vehicleload-" + load.ID + "\" class='inputswitch switch-vehicleload' type='checkbox'><span></span></label></label>" +
                                        "<div class=\"col-sm-9 load-name\">" +
                                            load.Name +
                                        "</div>" +
                                    "</div>";
                            }
                        }

                        html +=
                            "<tr id=\"row-vehicletype-" + obj.ID + "\" class=\"row-vehicletype\" dat-id=\"" + obj.ID + "\">" +
                                "<td class=\"text-center\">" +
                                    "<label class='switch switch-success'><input id=\"vehicletype-select-" + obj.ID + "\" class='inputswitch switch-vehicletype' type='checkbox'><span></span></label>" +
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
                tthqfeetypes.currentobj = tthqfeetypes.getobj(id);
                if (tthqfeetypes.currentobj == null) {
                    alert('Không tìm thấy Loại phí TTHQ!');
                    return;
                }

                $('#modal-delete #bDeleteName').html(tthqfeetypes.currentobj.Name);
                $('#modal-delete').modal('show');
            },

            dodelete: function () {
                NProgress.start();
                $('#btn-do-delete').addClass('disabled');
                $('#btn-modal-delete-close').addClass('disabled');
                $('#btn-do-delete').html('Đang xử lý...');

                $.post(tthqfeetypes.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': 'delete', 'id': tthqfeetypes.currentobj.ID },
                                function (data) {
                                    NProgress.done();

                                    var result = JSON.parse(data);
                                    $('#btn-do-delete').removeClass('disabled');
                                    $('#btn-modal-delete-close').removeClass('disabled');
                                    $('#btn-do-delete').html('Xóa');
                                    alert(result.Message);

                                    if (result.ErrorCode == 0)
                                        tthqfeetypes.reloadpage();
                                });
            },

            startedit: function (id) {
                tthqfeetypes.mode = 'edit';
                tthqfeetypes.currentobj = tthqfeetypes.getobj(id);
                if (tthqfeetypes.currentobj == null) {
                    alert('Không tìm thấy Loại phí TTHQ!');
                    return;
                }

                $('#modal-info #info-name').val(tthqfeetypes.currentobj.Name);
                $('#modal-info #info-description').val(tthqfeetypes.currentobj.Description);
                //$('#modal-info #info-isapplybyquantity').prop('checked', tthqfeetypes.currentobj.IsApplyByQuantity);

                this.generateobjdata_types();

                $('#modal-info .modal-header .modal-title').html('Cập nhật Loại phí TTHQ');
                $('#btn-do-save').html('Lưu');
                $('#modal-info').modal('show');
            },

            generateobjdata_types: function () {
                if (this.allTypes == null || this.allTypes.length == 0) return;
                if (this.currentobj.VehicleLoads == null || this.currentobj.VehicleLoads.length == 0) {
                    $('.inputswitch').prop('checked', false);
                    return;
                }

                for (var i = 0; i < this.allTypes.length; i++) {
                    var type = this.allTypes[i];
                    var rowType = $('#row-vehicletype-' + type.ID);

                    var loads = globalhelpers.GetListInList(type.ID, this.currentobj.VehicleLoads, "VehicleTypeID");

                    $('#vehicletype-select-' + type.ID).prop('checked', loads != null);

                    if (loads == null) {
                        $(rowType).find('.switch-vehicleload').prop('checked', false);
                        continue;
                    }
                    else {
                        for (var j = 0; j < type.VehicleLoads.length; j++) {
                            var load = type.VehicleLoads[j];
                            var switchLoad = $('#row-vehicleload-' + load.ID);

                            var eLoad = this.getobj(load.ID, loads, "VehicleLoadID");
                            $(switchLoad).prop('checked', eLoad != null);
                        }
                    }
                }
            },

            doAdd: function () {
                var postdata = tthqfeetypes.validateForm();
                if (postdata == null)
                    return;

                NProgress.start();
                $('#btn-do-save').addClass('disabled');
                $('#btn-modal-add-close').addClass('disabled');
                $('#btn-do-save').html('Đang xử lý...');

                var xhr = new XMLHttpRequest();
                xhr.open('POST', tthqfeetypes.ajaxPath + '?ts=' + new Date().getTime().toString());
                xhr.onload = function () {
                    NProgress.done();

                    var result = JSON.parse(xhr.responseText);
                    $('#btn-do-save').removeClass('disabled');
                    $('#btn-modal-add-close').removeClass('disabled');
                    $('#btn-do-save').html(tthqfeetypes.mode == 'create' ? 'Thêm' : 'Lưu');
                    alert(result.Message);

                    if (result.ErrorCode == 0)
                        tthqfeetypes.reloadpage();
                };

                var form = new FormData();
                form.append('mod', tthqfeetypes.mode);
                form.append('data', JSON.stringify(postdata));

                xhr.send(form);
            },

            reloadpage: function () {
                location.href = '/<%= CurrentSys_Module.Alias %>/?page=' + tthqfeetypes.currentpage;
            },

            validateForm: function () {
                var message = '';
                var data = new Object();
                data.name = $('#modal-info #info-name').val();
                if (data.name == '')
                    message += '- Tên không hợp lệ!<br/>';

                data.description = $('#modal-info #info-description').val();
                //data.isapplybyquantity = $('#modal-info #info-isapplybyquantity').prop('checked');

                //data.vehicleloads = new Array();

                //var types = $('#divVehicleTypes .row-vehicletype');
                //for (var i = 0; i < types.length; i++) {
                //    var typeDOM = types[i];
                //    var typeId = Number($(typeDOM).attr('dat-id'));
                //    var type = this.getobj(typeId, this.allTypes);
                //    if (type != null) {
                //        var checked = $('#vehicletype-select-' + type.ID).prop('checked');
                //        if (!checked) continue;

                //        for (var j = 0; j < type.VehicleLoads.length; j++) {
                //            var load = type.VehicleLoads[j];
                //            var loadDOM = $('#row-vehicleload-' + load.ID);
                //            if (loadDOM.prop('checked')) {
                //                var loadObj = new Object();
                //                loadObj.ID = load.ID;
                //                loadObj.TypeID = type.ID;
                //                data.vehicleloads.push(loadObj);
                //            }
                //        }
                //    }
                //}

                data.id = tthqfeetypes.mode == "create" ? 0 : tthqfeetypes.currentobj.ID;

                if (message != '') {
                    tthqfeetypes.alert(message);
                    return null;
                }

                return data;
            },

            startAdd: function () {
                tthqfeetypes.mode = 'create';
                $('#modal-info .modal-header .modal-title').html('Thêm mới Loại phí TTHQ');
                $('#btn-do-save').html('Thêm');
                $('#modal-info').modal('show');
            },

            getobj: function (value, list, field) {
                if (field == undefined) field = "ID";
                if (list == undefined) list = this.all;
                if (value == undefined) return null;

                if (list == null) return null;
                for (var i = 0; i < list.length; i++)
                    if (list[i][field] == value) return list[i];

                return null;
            },

            loadlist: function () {
                NProgress.start();

                $.post(tthqfeetypes.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': "loadlist", 'page': tthqfeetypes.currentpage },
                                function (data) {
                                    NProgress.done();
                                    var result = JSON.parse(data);

                                    var html =
                                        "<table id=\"tblList\" class=\"table table-vcenter table-striped table-condensed table-hover table-bordered\">" +
                                            "<thead>" +
                                                "<tr>" +
                                                    "<th class=\"text-center\">STT</th>" +
                                                    "<th class=\"text-center\">Tên</th>" +
                                                    "<th class=\"text-center\">Ghi chú</th>" +
                                                    //"<th class=\"text-center\">Tính theo số lượng?</th>" +
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
                                        tthqfeetypes.all = JSON.parse(result.Data.List);
                                        tthqfeetypes.currentpage = Number(result.Data.PageIndex);
                                        var pageSize = Number(result.Data.PageSize);
                                        var totalPages = Number(result.Data.TotalPages);

                                        for (var i = 0; i < tthqfeetypes.all.length; i++) {
                                            var obj = tthqfeetypes.all[i];

                                            html +=
                                                "<tr>" +
                                                    "<td class=\"text-center\">" +
                                                        (tthqfeetypes.currentpage * pageSize + i + 1) +
                                                    "</td>" +
                                                    "<td class=\"text-center\">" + obj.Name + "</td>" +
                                                    "<td class=\"text-center\">" + obj.Description + "</td>" +
                                                    //"<td class=\"text-center\">" + (obj.IsApplyByQuantity ? "<i class=\"gi gi-ok_2\"></i>" : "") + "</td>" +
                                                    "<td class=\"text-center\">" +
                                                        //"<div class=\"btn-group\">" +
                                                            (!globalhelpers.HasPermission("edit", tthqfeetypes.permissions) ? "" :"<a onclick=\"tthqfeetypes.startedit('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Sửa\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-pencil\"></i></a>") +
                                                            (!globalhelpers.HasPermission("edit", tthqfeetypes.permissions) ? "" :"<a onclick=\"tthqfeetypes.startdelete('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Xóa\" class=\"btn btn-xs btn-danger\"><i class=\"fa fa-times\"></i></a>") +
                                                        //"</div>" +
                                                    "</td>" +
                                                "</tr>";
                                        }
                                    }

                                    html += "</tbody></table>";

                                    $('#divTableList').html(html);
                                    globalhelpers.RenderPaging($('#divPaging'), '/<%= CurrentSys_Module.Alias %>', tthqfeetypes.currentpage, pageSize, totalPages);

                                    $('[data-toggle="tooltip"]').tooltip();
                                });
            }
        }

                        tthqfeetypes.init();
</script>
