<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TransportPlaces.ascx.cs" Inherits="SmileLogistics.Web.modules.functions.TransportPlaces" %>
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
            <h2>Danh sách <strong>Địa điểm</strong></h2>
            <div class="block-options pull-right">
                <a id="btn-controls-add" onclick="transportplaces.startAdd();" class="btn btn-sm btn-success" data-toggle="tooltip" title="Thêm mới"><i class="gi gi-plus"></i></a>
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
                <h3 class="modal-title">Xóa Địa điểm?</h3>
            </div>
            <div class="modal-body">
                Bạn chắc chắn muốn xóa Địa điểm <b id="bDeleteName"></b>?<br />
                <%--<i class="text-danger">(Điều này đồng nghĩa việc xóa kèm theo lịch sử hoạt động!!!)</i>--%>
            </div>
            <div class="modal-footer">
                <a id="btn-modal-delete-close" class="btn btn-sm btn-default" data-dismiss="modal">Hủy</a>
                <a id="btn-do-delete" onclick="transportplaces.dodelete();" class="btn btn-sm btn-danger">Xóa</a>
            </div>
        </div>
    </div>
</div>
<div id="modal-info" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Thêm mới Địa điểm</h3>
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
                <a id="btn-do-save" onclick="transportplaces.doAdd();" class="btn btn-sm btn-primary">Lưu</a>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var transportplaces =
        {
            ajaxPath: '/ajax/modules/functions/transportplaces.aspx',
            all: null,
            mode: 'create',
            currentpage: 0,
            currentobj: null,
            permissions: null,

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
                    transportplaces.currentpage = 0;
                else
                    transportplaces.currentpage = Number(page);

                var sPermissions = '<%= _RolePermissions %>';
                if (sPermissions != '')
                    this.permissions = JSON.parse(sPermissions);

                if (!globalhelpers.HasPermission("create", transportplaces.permissions))
                    $('#btn-controls-add').hide();
                else
                    $('#btn-controls-add').show();

                transportplaces.loadlist();
            },

            //-----------------------------------------------------------------------------------------------

            startdelete: function (id) {
                transportplaces.currentobj = transportplaces.getobj(id);
                if (transportplaces.currentobj == null) {
                    alert('Không tìm thấy Địa điểm!');
                    return;
                }

                $('#modal-delete #bDeleteName').html(transportplaces.currentobj.Name);
                $('#modal-delete').modal('show');
            },

            dodelete: function () {
                NProgress.start();
                $('#btn-do-delete').addClass('disabled');
                $('#btn-modal-delete-close').addClass('disabled');
                $('#btn-do-delete').html('Đang xử lý...');

                $.post(transportplaces.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': 'delete', 'id': transportplaces.currentobj.ID },
                                function (data) {
                                    NProgress.done();

                                    var result = JSON.parse(data);
                                    $('#btn-do-delete').removeClass('disabled');
                                    $('#btn-modal-delete-close').removeClass('disabled');
                                    $('#btn-do-delete').html('Xóa');
                                    alert(result.Message);

                                    if (result.ErrorCode == 0)
                                        transportplaces.reloadpage();
                                });
            },

            startedit: function (id) {
                transportplaces.mode = 'edit';
                transportplaces.currentobj = transportplaces.getobj(id);
                if (transportplaces.currentobj == null) {
                    alert('Không tìm thấy Địa điểm!');
                    return;
                }

                $('#modal-info #info-name').val(transportplaces.currentobj.Name);
                $('#modal-info #info-address').val(transportplaces.currentobj.Address);
                $('#modal-info #info-email').val(transportplaces.currentobj.Email);
                $('#modal-info #info-phone').val(transportplaces.currentobj.PhoneNumber);

                $('#modal-info .modal-header .modal-title').html('Cập nhật Địa điểm');
                $('#btn-do-save').html('Lưu');
                $('#modal-info').modal('show');
            },

            doAdd: function () {
                var postdata = transportplaces.validateForm();
                if (postdata == null)
                    return;

                NProgress.start();
                $('#btn-do-save').addClass('disabled');
                $('#btn-modal-add-close').addClass('disabled');
                $('#btn-do-save').html('Đang xử lý...');

                var xhr = new XMLHttpRequest();
                xhr.open('POST', transportplaces.ajaxPath + '?ts=' + new Date().getTime().toString());
                xhr.onload = function () {
                    NProgress.done();

                    var result = JSON.parse(xhr.responseText);
                    $('#btn-do-save').removeClass('disabled');
                    $('#btn-modal-add-close').removeClass('disabled');
                    $('#btn-do-save').html(transportplaces.mode == 'create' ? 'Thêm' : 'Lưu');
                    alert(result.Message);

                    if (result.ErrorCode == 0)
                        transportplaces.reloadpage();
                };

                var form = new FormData();
                form.append('mod', transportplaces.mode);
                form.append('data', JSON.stringify(postdata));

                xhr.send(form);
            },

            reloadpage: function () {
                location.href = '/<%= CurrentSys_Module.Alias %>/?page=' + transportplaces.currentpage;
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

                data.id = transportplaces.mode == "create" ? 0 : transportplaces.currentobj.ID;

                if (message != '') {
                    transportplaces.alert(message);
                    return null;
                }

                return data;
            },

            startAdd: function () {
                transportplaces.mode = 'create';
                $('#modal-info .modal-header .modal-title').html('Thêm mới Địa điểm');
                $('#btn-do-save').html('Thêm');
                $('#modal-info').modal('show');
            },

            getobj: function (id) {
                if (transportplaces.all == null) return null;
                for (var i = 0; i < transportplaces.all.length; i++)
                    if (transportplaces.all[i].ID == id) return transportplaces.all[i];

                return null;
            },

            loadlist: function () {
                NProgress.start();

                $.post(transportplaces.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': "loadlist", 'page': transportplaces.currentpage },
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
                                                    "<th class=\"text-center\">#</th>" +
                                                "</tr>" +
                                            "</thead>" +
                                            "<tbody>";

                                    if (result.ErrorCode != 0) {
                                        html +=
                                            "<tr>" +
                                                "<td class=\"text-center\" colspan=\"6\">" +
                                                    result.Message +
                                                "</td>" +
                                            "</tr>";
                                    }
                                    else {
                                        transportplaces.all = JSON.parse(result.Data.List);
                                        transportplaces.currentpage = Number(result.Data.PageIndex);
                                        var pageSize = Number(result.Data.PageSize);
                                        var totalPages = Number(result.Data.TotalPages);

                                        for (var i = 0; i < transportplaces.all.length; i++) {
                                            var obj = transportplaces.all[i];

                                            html +=
                                                "<tr>" +
                                                    "<td class=\"text-center\">" +
                                                        (transportplaces.currentpage * pageSize + i + 1) +
                                                    "</td>" +
                                                    "<td class=\"text-center\">" + obj.Name + "</td>" +
                                                    "<td class=\"text-center\">" + obj.Address + "</td>" +
                                                    "<td class=\"text-center\">" + obj.PhoneNumber + "</td>" +
                                                    "<td class=\"text-center\">" + obj.Email + "</td>" +
                                                    "<td class=\"text-center\">" +
                                                        //"<div class=\"btn-group\">" +
                                                            (!globalhelpers.HasPermission("edit", transportplaces.permissions) ? "" :"<a onclick=\"transportplaces.startedit('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Sửa\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-pencil\"></i></a>") +
                                                            (!globalhelpers.HasPermission("edit", transportplaces.permissions) ? "" :"<a onclick=\"transportplaces.startdelete('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Xóa\" class=\"btn btn-xs btn-danger\"><i class=\"fa fa-times\"></i></a>") +
                                                        //"</div>" +
                                                    "</td>" +
                                                "</tr>";
                                        }
                                    }

                                    html += "</tbody></table>";

                                    $('#divTableList').html(html);
                                    globalhelpers.RenderPaging($('#divPaging'), '/<%= CurrentSys_Module.Alias %>', transportplaces.currentpage, pageSize, totalPages);

                                    $('[data-toggle="tooltip"]').tooltip();
                                });
            }
        }

                        transportplaces.init();
</script>
