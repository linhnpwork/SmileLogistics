<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Roles.ascx.cs" Inherits="SmileLogistics.Web.modules.systems.Roles" %>
<style type="text/css">
    .eSys_Module-list-icons .btn {
        margin-bottom: 2px !important;
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
            <h2>Danh sách <strong>Nhóm quyền</strong></h2>
            <div class="block-options pull-right">
                <a onclick="sysrole.startAdd();" class="btn btn-sm btn-success" data-toggle="tooltip" title="Thêm mới"><i class="gi gi-plus"></i></a>
            </div>
        </div>
        <div class="form-horizontal form-bordered">
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
                <h3 class="modal-title">Xóa Nhóm quyền?</h3>
            </div>
            <div class="modal-body">
                Bạn chắc chắn muốn xóa Nhóm quyền <b id="bDeleteName"></b>?<br />
                <i class="text-danger">(Điều này đồng nghĩa việc xóa kèm theo các Người dùng có trong nhóm!!!)</i>
            </div>
            <div class="modal-footer">
                <a id="btn-modal-delete-close" class="btn btn-sm btn-default" data-dismiss="modal">Hủy</a>
                <a id="btn-do-delete" onclick="sysrole.dodelete();" class="btn btn-sm btn-danger">Xóa</a>
            </div>
        </div>
    </div>
</div>
<div id="modal-info" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Thêm mới Nhóm quyền</h3>
            </div>
            <div class="modal-body">
                <div class="form-horizontal form-bordered">
                    <div class="form-group">
                        <label class="col-md-3 control-label">Tên</label>
                        <div class="col-md-9">
                            <input type="text" id="info-name" class="form-control" placeholder="Name">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Ghi chú</label>
                        <div class="col-md-9">
                            <input type="text" id="info-description" class="form-control" placeholder="Description">
                        </div>
                    </div>
                    <%--<div class="form-group">
                        <label class="col-md-3 control-label">Status</label>
                        <div id="divStatuses" runat="server" class="col-md-9">
                            <select id="info-status" class="form-control">
                                <option value="-1">--- ROOT ---</option>
                            </select>
                        </div>
                    </div>--%>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Cho phép truy cập danh mục Hệ thống?</label>
                        <div class="col-md-9">
                            <label class="switch switch-success">
                                <input id="info-accessmenusystem" type="checkbox" checked><span></span></label>
                        </div>
                    </div>
                    <div id="divModalAlert" class="form-group" style="display: none;">
                        <div class="col-md-3">
                        </div>
                        <div id="divModalAlert-content" class="col-md-9">
                            <%--<div class="alert alert-danger alert-dismissable">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                <h4><i class="fa fa-times-circle"></i>Error</h4>
                                Oh no! Update <a href="javascript:void(0)" class="alert-link">failed</a>!
                            </div>--%>
                        </div>
                    </div>

                </div>
            </div>
            <div class="modal-footer">
                <a id="btn-modal-add-close" class="btn btn-sm btn-default" data-dismiss="modal">Đóng</a>
                <a id="btn-do-save" onclick="sysrole.doAdd();" class="btn btn-sm btn-primary">Lưu</a>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var sysrole =
        {
            ajaxPath: '/ajax/modules/systems/sysroles.aspx',
            all: null,
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
                    sysrole.currentpage = 0;
                else
                    sysrole.currentpage = Number(page);

                sysrole.loadlist();
            },

            loadlist: function () {
                NProgress.start();

                $.post(sysrole.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': "loadlist", 'page': sysrole.currentpage },
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
                                                    "<th class=\"text-center\">Danh mục hệ thống?</th>" +
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
                                        sysrole.all = JSON.parse(result.Data.List);
                                        sysrole.currentpage = Number(result.Data.PageIndex);
                                        var pageSize = Number(result.Data.PageSize);
                                        var totalPages = Number(result.Data.TotalPages);

                                        for (var i = 0; i < sysrole.all.length; i++) {
                                            var obj = sysrole.all[i];

                                            html +=
                                                "<tr>" +
                                                    "<td class=\"text-center\">" +
                                                        (sysrole.currentpage * pageSize + i + 1) +
                                                    "</td>" +
                                                    "<td class=\"text-center\">" + obj.Name + "</td>" +
                                                    "<td class=\"text-center\">" + obj.Description + "</td>" +
                                                    "<td class=\"text-center\">" + (obj.CanAccessSystemMenu ? "<i class=\"gi gi-ok_2\"></i>" : "") + "</td>" +
                                                    "<td class=\"text-center\">" +
                                                        //"<div class=\"btn-group\">" +
                                                            "<a onclick=\"sysrole.startedit('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Sửa\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-pencil\"></i></a>" +
                                                            "<a onclick=\"sysrole.startdelete('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Xóa\" class=\"btn btn-xs btn-danger\"><i class=\"fa fa-times\"></i></a>" +
                                                            "<a href=\"/sysrole-permission/?id=" + obj.ID + "\" data-toggle=\"tooltip\" title=\"Phân quyền\" class=\"btn btn-xs btn-warning\"><i class=\"gi gi-warning_sign\"></i></a>" +
                                                        //"</div>" +
                                                    "</td>" +
                                                "</tr>";
                                        }
                                    }

                                    html += "</tbody></table>";

                                    $('#divTableList').html(html);
                                    globalhelpers.RenderPaging($('#divPaging'), '/sysroles', sysrole.currentpage, pageSize, totalPages);


                                    $('[data-toggle="tooltip"]').tooltip();
                                });
            },

            //------------------------------------------------------------

            startdelete: function (id) {
                sysrole.currentobj = sysrole.getobj(id);
                if (sysrole.currentobj == null) {
                    alert('Không tìm thấy Nhóm quyền này!');
                    return;
                }

                $('#modal-delete #bDeleteName').html(sysrole.currentobj.Name);
                $('#modal-delete').modal('show');
            },

            dodelete: function () {
                NProgress.start();
                $('#btn-do-delete').addClass('disabled');
                $('#btn-modal-delete-close').addClass('disabled');
                $('#btn-do-delete').html('Đang xử lý...');

                $.post(sysrole.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': 'delete', 'id': sysrole.currentobj.ID },
                                function (data) {
                                    NProgress.done();

                                    var result = JSON.parse(data);
                                    $('#btn-do-delete').removeClass('disabled');
                                    $('#btn-modal-delete-close').removeClass('disabled');
                                    $('#btn-do-delete').html('Xóa');
                                    alert(result.Message);

                                    if (result.ErrorCode == 0)
                                        sysrole.reloadpage();
                                });
            },

            getobj: function (id) {
                if (sysrole.all == null) return null;
                for (var i = 0; i < sysrole.all.length; i++)
                    if (sysrole.all[i].ID == id) return sysrole.all[i];

                return null;
            },

            startedit: function (id) {
                sysrole.mode = 'edit';
                sysrole.currentobj = sysrole.getobj(id);
                if (sysrole.currentobj == null) {
                    alert('Không tìm thấy Nhóm quyền này!');
                    return;
                }

                $('#modal-info #info-name').val(sysrole.currentobj.Name);
                $('#modal-info #info-description').val(sysrole.currentobj.Description);
                $('#modal-info #info-statuses').val(sysrole.currentobj.Status);
                $('#modal-info #info-accessmenusystem').prop('checked', sysrole.currentobj.CanAccessSystemMenu);

                $('#modal-info .modal-header .modal-title').html('Edit Role');
                $('#btn-do-save').html('Save changes');
                $('#modal-info').modal('show');
            },

            startAdd: function () {
                sysrole.mode = 'create';
                $('#modal-info .modal-header .modal-title').html('Thêm mới');
                $('#btn-do-save').html('Thêm');
                $('#modal-info').modal('show');
            },

            doAdd: function () {
                var postdata = sysrole.validateForm();
                if (postdata == null)
                    return;

                NProgress.start();
                $('#btn-do-save').addClass('disabled');
                $('#btn-modal-add-close').addClass('disabled');
                $('#btn-do-save').html('Đang xử lý...');

                $.post(sysrole.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': sysrole.mode, 'data': JSON.stringify(postdata) },
                                function (data) {
                                    NProgress.done();

                                    var result = JSON.parse(data);
                                    $('#btn-do-save').removeClass('disabled');
                                    $('#btn-modal-add-close').removeClass('disabled');
                                    $('#btn-do-save').html(sysrole.mode == 'create' ? 'Thêm' : 'Lưu thay đổi');
                                    alert(result.Message);

                                    if (result.ErrorCode == 0)
                                        sysrole.reloadpage();
                                });
            },

            reloadpage: function () {
                location.href = "/sysroles/?page=" + sysrole.currentpage;
            },

            validateForm: function () {
                var message = '';
                var data = new Object();
                data.name = $('#modal-info #info-name').val();
                if (data.name == '')
                    message += '- Tên không hợp lệ!<br/>';

                data.description = $('#modal-info #info-description').val();
                if (data.description == '')
                    message += '- Ghi chú không hợp lệ!<br/>';

                //data.status = Number($('#modal-info #info-statuses').val());

                data.accesssystemmenu = $('#modal-info #info-accessmenusystem').prop('checked');

                data.id = sysrole.mode == "create" ? 0 : sysrole.currentobj.ID;

                if (message != '') {
                    sysrole.alert(message);
                    return null;
                }

                return data;
            }
        }

    sysrole.init();
</script>
