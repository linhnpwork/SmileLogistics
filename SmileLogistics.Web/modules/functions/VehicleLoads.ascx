<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VehicleLoads.ascx.cs" Inherits="SmileLogistics.Web.modules.functions.VehicleLoads" %>
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
            <h2>Danh sách <strong>Tải trọng xe</strong></h2>
            <div class="block-options pull-right">
                <a onclick="vehicleloads.startAdd();" class="btn btn-sm btn-success" data-toggle="tooltip" title="Thêm mới"><i class="gi gi-plus"></i></a>
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
                <h3 class="modal-title">Xóa Tải trọng xe?</h3>
            </div>
            <div class="modal-body">
                Bạn chắc chắn muốn xóa Tải trọng xe <b id="bDeleteName"></b>?<br />
                <%--<i class="text-danger">(Điều này đồng nghĩa việc xóa kèm theo lịch sử hoạt động!!!)</i>--%>
            </div>
            <div class="modal-footer">
                <a id="btn-modal-delete-close" class="btn btn-sm btn-default" data-dismiss="modal">Hủy</a>
                <a id="btn-do-delete" onclick="vehicleloads.dodelete();" class="btn btn-sm btn-danger">Xóa</a>
            </div>
        </div>
    </div>
</div>
<div id="modal-info" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Thêm mới Tải trọng xe</h3>
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
                        <label class="col-md-3 control-label">Mã</label>
                        <div class="col-md-9">
                            <input type="text" id="info-code" class="form-control" placeholder="Code">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Ghi chú</label>
                        <div class="col-md-9">
                            <input type="text" id="info-description" class="form-control" placeholder="Ghi chú">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Trọng tải tối đa (tấn)</label>
                        <div class="col-md-9">
                            <input type="text" id="info-fullload" class="form-control" placeholder="Trọng tải tối đa">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Loại xe</label>
                        <div id="divVehicleTypes" runat="server" class="col-md-9">
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
                <a id="btn-do-save" onclick="vehicleloads.doAdd();" class="btn btn-sm btn-primary">Lưu</a>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var vehicleloads =
        {
            ajaxPath: '/ajax/modules/functions/vehicleloads.aspx',
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
                    vehicleloads.currentpage = 0;
                else
                    vehicleloads.currentpage = Number(page);

                vehicleloads.loadlist();
            },

            //-----------------------------------------------------------------------------------------------

            startdelete: function (id) {
                vehicleloads.currentobj = vehicleloads.getobj(id);
                if (vehicleloads.currentobj == null) {
                    alert('Không tìm thấy Tải trọng xe!');
                    return;
                }

                $('#modal-delete #bDeleteName').html(vehicleloads.currentobj.Name);
                $('#modal-delete').modal('show');
            },

            dodelete: function () {
                NProgress.start();
                $('#btn-do-delete').addClass('disabled');
                $('#btn-modal-delete-close').addClass('disabled');
                $('#btn-do-delete').html('Đang xử lý...');

                $.post(vehicleloads.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': 'delete', 'id': vehicleloads.currentobj.ID },
                                function (data) {
                                    NProgress.done();

                                    var result = JSON.parse(data);
                                    $('#btn-do-delete').removeClass('disabled');
                                    $('#btn-modal-delete-close').removeClass('disabled');
                                    $('#btn-do-delete').html('Xóa');
                                    alert(result.Message);

                                    if (result.ErrorCode == 0)
                                        vehicleloads.reloadpage();
                                });
            },

            startedit: function (id) {
                vehicleloads.mode = 'edit';
                vehicleloads.currentobj = vehicleloads.getobj(id);
                if (vehicleloads.currentobj == null) {
                    alert('Không tìm thấy Tải trọng xe!');
                    return;
                }

                $('#modal-info #info-name').val(vehicleloads.currentobj.Name);
                $('#modal-info #info-code').val(vehicleloads.currentobj.Code);
                $('#modal-info #info-description').val(vehicleloads.currentobj.Description);
                $('#modal-info #info-fullload').val(vehicleloads.currentobj.FullLoad);
                $('#modal-info #info-vehicletypes').val(vehicleloads.currentobj.VehicleType.ID);

                $('#modal-info .modal-header .modal-title').html('Cập nhật Tải trọng xe');
                $('#btn-do-save').html('Lưu');
                $('#modal-info').modal('show');
            },

            doAdd: function () {
                var postdata = vehicleloads.validateForm();
                if (postdata == null)
                    return;

                NProgress.start();
                $('#btn-do-save').addClass('disabled');
                $('#btn-modal-add-close').addClass('disabled');
                $('#btn-do-save').html('Đang xử lý...');

                var xhr = new XMLHttpRequest();
                xhr.open('POST', vehicleloads.ajaxPath + '?ts=' + new Date().getTime().toString());
                xhr.onload = function () {
                    NProgress.done();

                    var result = JSON.parse(xhr.responseText);
                    $('#btn-do-save').removeClass('disabled');
                    $('#btn-modal-add-close').removeClass('disabled');
                    $('#btn-do-save').html(vehicleloads.mode == 'create' ? 'Thêm' : 'Lưu');
                    alert(result.Message);

                    if (result.ErrorCode == 0)
                        vehicleloads.reloadpage();
                };

                var form = new FormData();
                form.append('mod', vehicleloads.mode);
                form.append('data', JSON.stringify(postdata));

                xhr.send(form);
            },

            reloadpage: function () {
                location.href = '/<%= CurrentSys_Module.Alias %>/?page=' + vehicleloads.currentpage;
            },

            validateForm: function () {
                var message = '';
                var data = new Object();
                data.name = $('#modal-info #info-name').val();
                if (data.name == '')
                    message += '- Tên không hợp lệ!<br/>';

                data.code = $('#modal-info #info-code').val();
                if (data.code == '')
                    message += '- Code không hợp lệ!<br/>';

                data.description = $('#modal-info #info-description').val();
                if (data.description == '')
                    message += '- Ghi chú không hợp lệ!<br/>';

                data.fullload = $('#modal-info #info-fullload').val();
                if (data.fullload == '')
                    message += '- Trọng tải tối đa không hợp lệ!<br/>';
                if (isNaN(Number(data.fullload)))
                    message += '- Trọng tải tối đa không hợp lệ!<br/>';

                data.vehicletypeid = Number($('#modal-info #info-vehicletypes').val());

                data.id = vehicleloads.mode == "create" ? 0 : vehicleloads.currentobj.ID;

                if (message != '') {
                    vehicleloads.alert(message);
                    return null;
                }

                return data;
            },

            startAdd: function () {
                vehicleloads.mode = 'create';
                $('#modal-info .modal-header .modal-title').html('Thêm mới Tải trọng xe');
                $('#btn-do-save').html('Thêm');
                $('#modal-info').modal('show');
            },

            getobj: function (id) {
                if (vehicleloads.all == null) return null;
                for (var i = 0; i < vehicleloads.all.length; i++)
                    if (vehicleloads.all[i].ID == id) return vehicleloads.all[i];

                return null;
            },

            loadlist: function () {
                NProgress.start();

                $.post(vehicleloads.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': "loadlist", 'page': vehicleloads.currentpage },
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
                                                    "<th class=\"text-center\">Loại xe</th>" +
                                                    "<th class=\"text-center\">Trọng tải tối đa (tấn)</th>" +
                                                    "<th class=\"text-center\">Ghi chú</th>" +
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
                                        vehicleloads.all = JSON.parse(result.Data.List);
                                        vehicleloads.currentpage = Number(result.Data.PageIndex);
                                        var pageSize = Number(result.Data.PageSize);
                                        var totalPages = Number(result.Data.TotalPages);

                                        for (var i = 0; i < vehicleloads.all.length; i++) {
                                            var obj = vehicleloads.all[i];

                                            html +=
                                                "<tr>" +
                                                    "<td class=\"text-center\">" +
                                                        (vehicleloads.currentpage * pageSize + i + 1) +
                                                    "</td>" +
                                                    "<td class=\"text-center\">" + obj.Name + "</td>" +
                                                    "<td class=\"text-center\">" + obj.Code + "</td>" +
                                                    "<td class=\"text-center\">" + obj.VehicleType.Name + "</td>" +
                                                    "<td class=\"text-center\">" + obj.FullLoad + "</td>" +
                                                    "<td class=\"text-center\">" + obj.Description + "</td>" +
                                                    "<td class=\"text-center\">" +
                                                        //"<div class=\"btn-group\">" +
                                                            "<a onclick=\"vehicleloads.startedit('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Sửa\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-pencil\"></i></a>" +
                                                            "<a onclick=\"vehicleloads.startdelete('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Xóa\" class=\"btn btn-xs btn-danger\"><i class=\"fa fa-times\"></i></a>" +
                                                        //"</div>" +
                                                    "</td>" +
                                                "</tr>";
                                        }
                                    }

                                    html += "</tbody></table>";

                                    $('#divTableList').html(html);
                                    globalhelpers.RenderPaging($('#divPaging'), '/<%= CurrentSys_Module.Alias %>', vehicleloads.currentpage, pageSize, totalPages);

                                    $('[data-toggle="tooltip"]').tooltip();
                                });
            }
        }

                        vehicleloads.init();
</script>
