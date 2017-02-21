<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RolePermission.ascx.cs" Inherits="SmileLogistics.Web.modules.systems.RolePermission" %>
<style type="text/css">
    .sysmodule-list-icons .btn {
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
            <h2>Phân quyền cho Nhóm quyền <strong id="strRoleName" runat="server">Nhóm quyền</strong></h2>
            <div class="block-options pull-right">
                <a href="/sysroles" class="btn btn-sm btn-danger btn-goback" data-toggle="tooltip" title="Quay về danh sách"><i class="gi gi-unshare"></i></a>
                <a onclick="sysrolepermission.dosave();" href="javascript:void(0);" class="btn btn-sm btn-success btn-dosave" data-toggle="tooltip" title="Lưu thay đổi"><i class="gi gi-floppy_save"></i></a>
            </div>
        </div>
        <div class="form-horizontal form-bordered">
            <div id="divTableList" class="table-responsive">
            </div>
            <div class="form-group form-actions">
                <div class="col-md-9 col-md-offset-3">
                    <a href="/sysroles" class="btn btn-sm btn-danger btn-goback"><i class="gi gi-unshare"></i>&nbsp;Quay về danh sách</a>
                    <a onclick="sysrolepermission.dosave();" href="javascript:void(0);" class="btn btn-sm btn-success btn-dosave"><i class="gi gi-floppy_save"></i>&nbsp;Lưu thay đổi</a>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var sysrolepermission =
        {
            ajaxPath: '/ajax/modules/systems/sysroles.aspx',
            roleid: null,
            init: function () {
                var sid = globalhelpers.GetRequestQueryString('id');
                if (!sid || sid == '') {
                    location.href = "/sysroles";
                    return;
                }

                sysrolepermission.roleid = Number(sid);
                if (isNaN(sysrolepermission.roleid)) {
                    location.href = "/sysroles";
                    return;
                }

                sysrolepermission.loadlist();
            },

            dosave: function () {
                var postData = sysrolepermission.builddata();
                if (postData == null) {
                    alert('Không thể truy xuất dữ liệu phân quyền!');
                    return;
                }

                NProgress.start();
                $('#btn-goback').addClass('disabled');
                $('#btn-dosave').addClass('disabled');
                $('#btn-dosave').html('Đang xử lý...');

                $.post(sysrolepermission.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': "permission-save", 'data': JSON.stringify(postData) },
                                function (data) {
                                    NProgress.done();
                                    var result = JSON.parse(data);

                                    alert(result.Message);

                                    $('#btn-goback').removeClass('disabled');
                                    $('#btn-dosave').removeClass('disabled');
                                    $('#btn-dosave').html('Lưu thay đổi');
                                });
            },

            builddata: function () {
                var data = new Object();
                data.roleid = sysrolepermission.roleid;

                var trs = $('#tbleSys_Modules tr.tr-rowdata');
                if (trs.length == 0) return null;

                data.eSys_Modules = new Array();
                for (var i = 0; i < trs.length; i++) {
                    data.eSys_Modules[i] = new Object();
                    data.eSys_Modules[i].eSys_Moduleid = Number($(trs[i]).attr('dat-id'));
                    data.eSys_Modules[i].permissions = '';

                    var cbxActions = $(trs[i]).find('.cbxAction');
                    if (cbxActions.length == 0) continue;

                    for (var j = 0; j < cbxActions.length; j++) {
                        var checked = $(cbxActions[j]).prop('checked');
                        if (checked)
                            data.eSys_Modules[i].permissions += '@' + $(cbxActions[j]).val() + ';';
                    }
                }

                if (data.eSys_Modules.length == 0) return null;

                return data;
            },

            oncheckrow: function (obj, propRow) {
                var checked = $(obj).prop('checked');
                var tr = $(obj).parent().parent();

                if (propRow == undefined || propRow)
                    $(tr).find('.cbxAction').prop('checked', checked);

                var allRowChecked = true;
                var trs = $('#tbleSys_Modules').find('.cbxRow');
                for (var i = 0; i < trs.length; i++) {
                    if (!$(trs[i]).prop('checked'))
                        allRowChecked = false;
                }

                $('#tbleSys_Modules .cbxAll').prop('checked', allRowChecked);

            },

            oncheckall: function (obj) {
                var checked = $(obj).prop('checked');
                $('#tbleSys_Modules .cbxRow').prop('checked', checked);
                $('#tbleSys_Modules .cbxAction').prop('checked', checked);
            },

            oncheckaction: function (obj) {
                var checked = $(obj).prop('checked');
                var td = $(obj).parent().parent();
                var tr = $(td).parent();
                var cbxRow = $(tr).find('.cbxRow');

                var allActionChecked = true;
                var tds = $(td).find('.cbxAction');
                for (var i = 0; i < tds.length; i++) {
                    if (!$(tds[i]).prop('checked'))
                        allActionChecked = false;
                }

                $(cbxRow).prop('checked', allActionChecked);

                sysrolepermission.oncheckrow(cbxRow, false);
            },

            loadlist: function () {
                NProgress.start();

                $.post(sysrolepermission.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': "permission-loadlist", 'id': sysrolepermission.roleid },
                                function (data) {
                                    NProgress.done();
                                    var result = JSON.parse(data);

                                    $('#divTableList').html(result.Data);

                                    $('[data-toggle="tooltip"]').tooltip();
                                });
            }
        }

    sysrolepermission.init();
</script>
