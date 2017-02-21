<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Administrators.ascx.cs" Inherits="SmileLogistics.Web.modules.systems.Administrators" %>
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
            <h2>Danh sách <strong>Người dùng</strong></h2>
            <div class="block-options pull-right">
                <a onclick="sysadmin.startAdd();" class="btn btn-sm btn-success" data-toggle="tooltip" title="Thêm mới"><i class="gi gi-plus"></i></a>
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
                <h3 class="modal-title">Xóa Người dùng?</h3>
            </div>
            <div class="modal-body">
                Bạn chắc chắn muốn xóa Người dùng <b id="bDeleteName"></b>?<br />
                <i class="text-danger">(Điều này đồng nghĩa việc xóa kèm theo lịch sử hoạt động!!!)</i>
            </div>
            <div class="modal-footer">
                <a id="btn-modal-delete-close" class="btn btn-sm btn-default" data-dismiss="modal">Hủy</a>
                <a id="btn-do-delete" onclick="sysadmin.dodelete();" class="btn btn-sm btn-danger">Xóa</a>
            </div>
        </div>
    </div>
</div>
<div id="modal-info" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Thêm mới Người dùng</h3>
            </div>
            <div class="modal-body">
                <div class="form-horizontal form-bordered">
                    <div class="form-group">
                        <label class="col-md-3 control-label">Tên</label>
                        <div class="col-md-9">
                            <input type="text" id="info-firstname" class="form-control" placeholder="Tên">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Họ</label>
                        <div class="col-md-9">
                            <input type="text" id="info-lastname" class="form-control" placeholder="Họ">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Nhóm quyền</label>
                        <div id="divRoles" runat="server" class="col-md-9">
                            <select id="info-role" class="form-control">
                                <option value="-1">--- ROOT ---</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Email</label>
                        <div class="col-md-9">
                            <input type="text" id="info-email" class="form-control" placeholder="Email">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Tài khoản</label>
                        <div class="col-md-9">
                            <input type="text" id="info-username" class="form-control" placeholder="Tên tài khoản">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Mật khẩu</label>
                        <div class="col-md-9">
                            <input type="password" id="info-password" class="form-control" placeholder="Mật khẩu">
                            <span class="help-block help-for-password">(Chỉ điền ô nếu muốn thay đổi Mật khẩu mới!)</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Ngày sinh</label>
                        <div class="col-md-9">
                            <input type="text" id="info-dateofbirth" name="info-dateofbirth" class="form-control input-datepicker" data-date-format="dd/mm/yyyy" placeholder="dd/mm/yyyy">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Ảnh đại diện</label>
                        <div class="col-md-9">
                            <img id="info-avatar-thumb" alt="Avatar preview" class="img-circle" style="width: 100px; height: 100px;">
                            <input type="file" id="info-avatar" onchange="sysadmin.readAvatarUrl(this);">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Địa chỉ</label>
                        <div class="col-md-9">
                            <input type="text" id="info-address" class="form-control" placeholder="Địa chỉ">
                        </div>
                    </div>
                    <%--<div class="form-group">
                        <label class="col-md-3 control-label">City</label>
                        <div class="col-md-9">
                            <input type="text" id="info-city" class="form-control" placeholder="City">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">State/Province</label>
                        <div class="col-md-9">
                            <input type="text" id="info-state" class="form-control" placeholder="State or Province">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Country</label>
                        <div id="divCountries" runat="server" class="col-md-9">
                        </div>
                    </div>--%>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Số điện thoại</label>
                        <div class="col-md-9">
                            <input type="text" id="info-phone" class="form-control" placeholder="Số điện thoại">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Trạng thái</label>
                        <div id="divStatuses" runat="server" class="col-md-9">
                        </div>
                    </div>
                    <div id="divModalAlert" class="form-group" style="display: none;">
                        <div class="col-md-3">
                        </div>
                        <div id="divModalAlert-content" class="col-md-9">
                            <%--<div class="alert alert-danger alert-dismissable">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                <h4><i class="fa fa-times-circle"></i>Lo</h4>
                                Oh no! Update <a href="javascript:void(0)" class="alert-link">failed</a>!
                            </div>--%>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <a id="btn-modal-add-close" class="btn btn-sm btn-default" data-dismiss="modal">Hủy</a>
                <a id="btn-do-save" onclick="sysadmin.doAdd();" class="btn btn-sm btn-primary">Lưu</a>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var sysadmin =
        {
            ajaxPath: '/ajax/modules/systems/sysadmins.aspx',
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
                    sysadmin.currentpage = 0;
                else
                    sysadmin.currentpage = Number(page);

                sysadmin.loadlist();
            },

            //-----------------------------------------------------------------------------------------------

            startdelete: function (id) {
                sysadmin.currentobj = sysadmin.getobj(id);
                if (sysadmin.currentobj == null) {
                    alert('Không tìm thấy Người dùng!');
                    return;
                }

                $('#modal-delete #bDeleteName').html(sysadmin.currentobj.Firstname + ', ' + sysadmin.currentobj.Lastname);
                $('#modal-delete').modal('show');
            },

            dodelete: function () {
                NProgress.start();
                $('#btn-do-delete').addClass('disabled');
                $('#btn-modal-delete-close').addClass('disabled');
                $('#btn-do-delete').html('Đang xử lý...');

                $.post(sysadmin.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': 'delete', 'id': sysadmin.currentobj.ID },
                                function (data) {
                                    NProgress.done();

                                    var result = JSON.parse(data);
                                    $('#btn-do-delete').removeClass('disabled');
                                    $('#btn-modal-delete-close').removeClass('disabled');
                                    $('#btn-do-delete').html('Xóa');
                                    alert(result.Message);

                                    if (result.ErrorCode == 0)
                                        sysadmin.reloadpage();
                                });
            },

            startedit: function (id) {
                sysadmin.mode = 'edit';
                sysadmin.currentobj = sysadmin.getobj(id);
                if (sysadmin.currentobj == null) {
                    alert('Không tìm thấy Người dùng!');
                    return;
                }

                $('#modal-info #info-firstname').val(sysadmin.currentobj.Firstname);
                $('#modal-info #info-lastname').val(sysadmin.currentobj.Lastname);
                $('#modal-info #info-role').val(sysadmin.currentobj.RoleID);
                $('#modal-info #info-email').val(sysadmin.currentobj.Email);
                $('#modal-info #info-password').val('');
                $('#modal-info #info-username').val(sysadmin.currentobj.Username);
                $('#modal-info #info-dateofbirth').val(sysadmin.currentobj.DateOfBirth);
                $('#modal-info #info-address').val(sysadmin.currentobj.Address);
                $('#modal-info #info-phone').val(sysadmin.currentobj.PhoneNumber);
                $('#modal-info #info-avatar-thumb').attr('src', sysadmin.currentobj.Avatar.replace('~/', '/'));
                $('#modal-info #info-statuses').val(sysadmin.currentobj.Status);

                $('.help-block.help-for-password').show();
                $('#modal-info .modal-header .modal-title').html('Cập nhật Người dùng');
                $('#btn-do-save').html('Lưu');
                $('#modal-info').modal('show');
            },

            clearcountry: function () {
                $('#info-countries').find('option').removeAttr('selected');
            },

            readAvatarUrl: function (input) {

                if (input.files && input.files[0]) {
                    var reader = new FileReader();

                    reader.onload = function (e) {
                        $('#info-avatar-thumb').attr('src', e.target.result);
                    }

                    reader.readAsDataURL(input.files[0]);
                }
            },

            doAdd: function () {
                var postdata = sysadmin.validateForm();
                if (postdata == null)
                    return;

                NProgress.start();
                $('#btn-do-save').addClass('disabled');
                $('#btn-modal-add-close').addClass('disabled');
                $('#btn-do-save').html('Đang xử lý...');

                var xhr = new XMLHttpRequest();
                xhr.open('POST', sysadmin.ajaxPath + '?ts=' + new Date().getTime().toString());
                xhr.onload = function () {
                    NProgress.done();

                    var result = JSON.parse(xhr.responseText);
                    $('#btn-do-save').removeClass('disabled');
                    $('#btn-modal-add-close').removeClass('disabled');
                    $('#btn-do-save').html(sysadmin.mode == 'create' ? 'Thêm' : 'Lưu');
                    alert(result.Message);

                    if (result.ErrorCode == 0)
                        sysadmin.reloadpage();
                };

                var form = new FormData();
                form.append('mod', sysadmin.mode);
                form.append('avatar', $('#info-avatar')[0].files[0]);
                form.append('data', JSON.stringify(postdata));

                xhr.send(form);
            },

            reloadpage: function () {
                location.href = "/sysadmins/?page=" + sysadmin.currentpage;
            },

            validateForm: function () {
                var message = '';
                var data = new Object();
                data.firstname = $('#modal-info #info-firstname').val();
                if (data.firstname == '')
                    message += '- Tên không hợp lệ!<br/>';

                data.lastname = $('#modal-info #info-lastname').val();
                if (data.lastname == '')
                    message += '- Họ không hợp lệ!<br/>';

                data.roleid = Number($('#modal-info #info-role').val());

                data.email = $('#modal-info #info-email').val();
                if (data.email == '')
                    message += '- Email không hợp lệ!<br/>';

                data.username = $('#modal-info #info-username').val();
                if (data.username == '')
                    message += '- Tài khoản không hợp lệ!<br/>';

                data.password = $('#modal-info #info-password').val();
                if (sysadmin.mode == 'create' && data.password == '')
                    message += '- Mật khẩu không hợp lệ!<br/>';

                data.dateofbirth = $('#modal-info #info-dateofbirth').val();
                data.address = $('#modal-info #info-address').val();
                //data.city = $('#modal-info #info-city').val();
                //data.state = $('#modal-info #info-state').val();
                //data.country = Number($('#modal-info #info-countries').val());
                data.phone = $('#modal-info #info-phone').val();

                data.status = Number($('#modal-info #info-statuses').val());

                data.id = sysadmin.mode == "create" ? 0 : sysadmin.currentobj.ID;

                if (message != '') {
                    sysadmin.alert(message);
                    return null;
                }

                return data;
            },

            startAdd: function () {
                sysadmin.mode = 'create';
                $('.help-block.help-for-password').hide();
                $('#modal-info .modal-header .modal-title').html('Thêm mới Người dùng');
                $('#btn-do-save').html('Thêm');
                $('#modal-info').modal('show');
            },

            getobj: function (id) {
                if (sysadmin.all == null) return null;
                for (var i = 0; i < sysadmin.all.length; i++)
                    if (sysadmin.all[i].ID == id) return sysadmin.all[i];

                return null;
            },

            loadlist: function () {
                NProgress.start();

                $.post(sysadmin.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': "loadlist", 'page': sysadmin.currentpage },
                                function (data) {
                                    NProgress.done();
                                    var result = JSON.parse(data);

                                    var html =
                                        "<table id=\"tblList\" class=\"table table-vcenter table-striped table-condensed table-hover table-bordered\">" +
                                            "<thead>" +
                                                "<tr>" +
                                                    "<th class=\"text-center\">STT</th>" +
                                                    "<th class=\"text-center\">Ảnh đại diện</th>" +
                                                    "<th class=\"text-center\">Tài khoản</th>" +
                                                    "<th class=\"text-center\">Thông tin</th>" +
                                                    //"<th class=\"text-center\">Joined date</th>" +
                                                    "<th class=\"text-center\">Nhóm quyền</th>" +
                                                    "<th class=\"text-center\">Trạng thái</th>" +
                                                    "<th class=\"text-center\">#</th>" +
                                                "</tr>" +
                                            "</thead>" +
                                            "<tbody>";

                                    if (result.ErrorCode != 0) {
                                        html +=
                                            "<tr>" +
                                                "<td class=\"text-center\" colspan=\"7\">" +
                                                    result.Message +
                                                "</td>" +
                                            "</tr>";
                                    }
                                    else {
                                        sysadmin.all = JSON.parse(result.Data.List);
                                        sysadmin.currentpage = Number(result.Data.PageIndex);
                                        var pageSize = Number(result.Data.PageSize);
                                        var totalPages = Number(result.Data.TotalPages);

                                        for (var i = 0; i < sysadmin.all.length; i++) {
                                            var obj = sysadmin.all[i];

                                            html +=
                                                "<tr>" +
                                                    "<td class=\"text-center\">" +
                                                        (sysadmin.currentpage * pageSize + i + 1) +
                                                    "</td>" +
                                                    "<td class=\"text-center\">" +
                                                        "<img style=\"width: 100px; height: 100px;\" class=\"img-admin-avatar\" src=\"/" + obj.Avatar.replace('~/', '') + "\" />" +
                                                    "</td>" +
                                                    "<td>" +
                                                        "<div class=\"form-group\">" +
                                                            "<label class=\"col-md-3 control-label\">Họ tên</label>" +
                                                            "<div class=\"col-md-9\">" +
                                                                "<p class=\"form-control-static\">" + obj.Firstname + ", " + obj.Lastname + "</p>" +
                                                            "</div>" +
                                                        "</div>" +
                                                        "<div class=\"form-group\">" +
                                                            "<label class=\"col-md-3 control-label\">Tài khoản</label>" +
                                                            "<div class=\"col-md-9\">" +
                                                                "<p class=\"form-control-static\">" + obj.Username + "</p>" +
                                                            "</div>" +
                                                        "</div>" +
                                                        "<div class=\"form-group\">" +
                                                            "<label class=\"col-md-3 control-label\">Email</label>" +
                                                            "<div class=\"col-md-9\">" +
                                                                "<p class=\"form-control-static\">" + obj.Email + "</p>" +
                                                            "</div>" +
                                                        "</div>" +
                                                    "</td>" +
                                                    "<td>" +
                                                        "<div class=\"form-group\">" +
                                                            "<label class=\"col-md-3 control-label\">Ngày sinh</label>" +
                                                            "<div class=\"col-md-9\">" +
                                                                "<p class=\"form-control-static\">" + obj.sDateOfBirth + "</p>" +
                                                            "</div>" +
                                                        "</div>" +
                                                        "<div class=\"form-group\">" +
                                                            "<label class=\"col-md-3 control-label\">Địa chỉ</label>" +
                                                            "<div class=\"col-md-9\">" +
                                                                "<p class=\"form-control-static\">" + obj.Address + "</p>" +
                                                            "</div>" +
                                                        "</div>" +
                                                        "<div class=\"form-group\">" +
                                                            "<label class=\"col-md-3 control-label\">Số điện thoại</label>" +
                                                            "<div class=\"col-md-9\">" +
                                                                "<p class=\"form-control-static\">" + obj.PhoneNumber + "</p>" +
                                                            "</div>" +
                                                        "</div>" +
                                                    "</td>" +
                                                    //"<td class=\"text-center\">" + obj.CreatedDate + "</td>" +
                                                    "<td class=\"text-center\">" + obj.RoleName + "</td>" +
                                                    "<td class=\"text-center\">" + obj.StatusName + "</td>" +
                                                    "<td class=\"text-center\">" +
                                                        //"<div class=\"btn-group\">" +
                                                            "<a onclick=\"sysadmin.startedit('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Sửa\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-pencil\"></i></a>" +
                                                            "<a onclick=\"sysadmin.startdelete('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Xóa\" class=\"btn btn-xs btn-danger\"><i class=\"fa fa-times\"></i></a>" +
                                                        //"</div>" +
                                                    "</td>" +
                                                "</tr>";
                                        }
                                    }

                                    html += "</tbody></table>";

                                    $('#divTableList').html(html);
                                    globalhelpers.RenderPaging($('#divPaging'), '/sysadmins', sysadmin.currentpage, pageSize, totalPages);

                                    $('[data-toggle="tooltip"]').tooltip();
                                });
            }
        }

        sysadmin.init();
</script>
