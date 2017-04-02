<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomerPrepaids.ascx.cs" Inherits="SmileLogistics.Web.modules.functions.CustomerPrepaids" %>
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
            <h2>Danh sách <strong>Nhận tạm ứng</strong></h2>
            <div class="block-options pull-right">
                <a onclick="customerprepaids.startAdd();" class="btn btn-sm btn-success" data-toggle="tooltip" title="Thêm mới"><i class="gi gi-plus"></i></a>
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
                <h3 class="modal-title">Xóa Nhận tạm ứng?</h3>
            </div>
            <div class="modal-body">
                Bạn chắc chắn muốn xóa Nhận tạm ứng <b id="bDeleteName"></b>?<br />
                <%--<i class="text-danger">(Điều này đồng nghĩa việc xóa kèm theo lịch sử hoạt động!!!)</i>--%>
            </div>
            <div class="modal-footer">
                <a id="btn-modal-delete-close" class="btn btn-sm btn-default" data-dismiss="modal">Hủy</a>
                <a id="btn-do-delete" onclick="customerprepaids.dodelete();" class="btn btn-sm btn-danger">Xóa</a>
            </div>
        </div>
    </div>
</div>
<div id="modal-info" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Thêm mới Nhận tạm ứng</h3>
            </div>
            <div class="modal-body">
                <div class="form-horizontal form-bordered">
                    <div class="form-group">
                        <label class="col-md-3 control-label">Khách hàng</label>
                        <div id="divCustomers" runat="server" class="col-md-9">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Số tiền</label>
                        <div class="col-md-9">
                            <input type="text" id="info-money" class="form-control" placeholder="Số tiền tạm ứng" onkeyup="globalhelpers.On_InputMoney_KeyPress(this);">
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
                <a id="btn-do-save" onclick="customerprepaids.doAdd();" class="btn btn-sm btn-primary">Lưu</a>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var customerprepaids =
        {
            ajaxPath: '/ajax/modules/functions/customerprepaids.aspx',
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
                    customerprepaids.currentpage = 0;
                else
                    customerprepaids.currentpage = Number(page);

                customerprepaids.loadlist();
            },

            //-----------------------------------------------------------------------------------------------

            startdelete: function (id) {
                customerprepaids.currentobj = customerprepaids.getobj(id);
                if (customerprepaids.currentobj == null) {
                    alert('Không tìm thấy Nhận tạm ứng!');
                    return;
                }

                $('#modal-delete #bDeleteName').html(customerprepaids.currentobj.Name);
                $('#modal-delete').modal('show');
            },

            dodelete: function () {
                NProgress.start();
                $('#btn-do-delete').addClass('disabled');
                $('#btn-modal-delete-close').addClass('disabled');
                $('#btn-do-delete').html('Đang xử lý...');

                $.post(customerprepaids.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': 'delete', 'id': customerprepaids.currentobj.ID },
                                function (data) {
                                    NProgress.done();

                                    var result = JSON.parse(data);
                                    $('#btn-do-delete').removeClass('disabled');
                                    $('#btn-modal-delete-close').removeClass('disabled');
                                    $('#btn-do-delete').html('Xóa');
                                    alert(result.Message);

                                    if (result.ErrorCode == 0)
                                        customerprepaids.reloadpage();
                                });
            },

            startedit: function (id) {
                customerprepaids.mode = 'edit';
                customerprepaids.currentobj = customerprepaids.getobj(id);
                if (customerprepaids.currentobj == null) {
                    alert('Không tìm thấy Nhận tạm ứng!');
                    return;
                }

                $('#modal-info #info-customers').val(customerprepaids.currentobj.CustomerID);
                $('#modal-info #info-money').val(customerprepaids.currentobj.Money);
                $('#modal-info #info-description').val(customerprepaids.currentobj.Description);

                $('#modal-info .modal-header .modal-title').html('Cập nhật Nhận tạm ứng');
                $('#btn-do-save').html('Lưu');
                $('#modal-info').modal('show');
            },

            doAdd: function () {
                var postdata = customerprepaids.validateForm();
                if (postdata == null)
                    return;

                NProgress.start();
                $('#btn-do-save').addClass('disabled');
                $('#btn-modal-add-close').addClass('disabled');
                $('#btn-do-save').html('Đang xử lý...');

                var xhr = new XMLHttpRequest();
                xhr.open('POST', customerprepaids.ajaxPath + '?ts=' + new Date().getTime().toString());
                xhr.onload = function () {
                    NProgress.done();

                    var result = JSON.parse(xhr.responseText);
                    $('#btn-do-save').removeClass('disabled');
                    $('#btn-modal-add-close').removeClass('disabled');
                    $('#btn-do-save').html(customerprepaids.mode == 'create' ? 'Thêm' : 'Lưu');
                    alert(result.Message);

                    if (result.ErrorCode == 0)
                        customerprepaids.reloadpage();
                };

                var form = new FormData();
                form.append('mod', customerprepaids.mode);
                form.append('data', JSON.stringify(postdata));

                xhr.send(form);
            },

            reloadpage: function () {
                location.href = '/<%= CurrentSys_Module.Alias %>/?page=' + customerprepaids.currentpage;
            },

            validateForm: function () {
                var message = '';
                var data = new Object();

                data.customer = Number($('#modal-info #info-customers').val());
                if (isNaN(data.customer))
                    message += '- Khách hàng không hợp lệ!';

                data.money = Number(globalhelpers.Convert_FromMoney($('#modal-info #info-money').val()));
                if (isNaN(data.money))
                    message += '- Số tiền không hợp lệ!<br/>';

                data.description = $('#modal-info #info-description').val();

                data.id = customerprepaids.mode == "create" ? 0 : customerprepaids.currentobj.ID;

                if (message != '') {
                    customerprepaids.alert(message);
                    return null;
                }

                return data;
            },

            startAdd: function () {
                customerprepaids.mode = 'create';
                $('#modal-info .modal-header .modal-title').html('Thêm mới Nhận tạm ứng');
                $('#btn-do-save').html('Thêm');
                $('#modal-info').modal('show');
            },

            getobj: function (id) {
                if (customerprepaids.all == null) return null;
                for (var i = 0; i < customerprepaids.all.length; i++)
                    if (customerprepaids.all[i].ID == id) return customerprepaids.all[i];

                return null;
            },

            loadlist: function () {
                NProgress.start();

                $.post(customerprepaids.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': "loadlist", 'page': customerprepaids.currentpage },
                                function (data) {
                                    NProgress.done();
                                    var result = JSON.parse(data);

                                    var html =
                                        "<table id=\"tblList\" class=\"table table-vcenter table-striped table-condensed table-hover table-bordered\">" +
                                            "<thead>" +
                                                "<tr>" +
                                                    "<th class=\"text-center\">STT</th>" +
                                                    "<th class=\"text-center\">Khách hàng</th>" +
                                                    "<th class=\"text-center\">Số tiền</th>" +
                                                    "<th class=\"text-center\">Ghi chú</th>" +
                                                    "<th class=\"text-center\">Ngày nhận</th>" +
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
                                        customerprepaids.all = JSON.parse(result.Data.List);
                                        customerprepaids.currentpage = Number(result.Data.PageIndex);
                                        var pageSize = Number(result.Data.PageSize);
                                        var totalPages = Number(result.Data.TotalPages);

                                        for (var i = 0; i < customerprepaids.all.length; i++) {
                                            var obj = customerprepaids.all[i];

                                            html +=
                                                "<tr>" +
                                                    "<td class=\"text-center\">" +
                                                        (customerprepaids.currentpage * pageSize + i + 1) +
                                                    "</td>" +
                                                    "<td class=\"text-center\">" + obj.CustomerName + "</td>" +
                                                    "<td class=\"text-center\">" + globalhelpers.Format_Money(obj.Money.toFixed(2)) + "</td>" +
                                                    "<td class=\"text-center\">" + obj.Description + "</td>" +
                                                    "<td class=\"text-center\">" + obj.sPrepaidDate + "</td>" +
                                                    "<td class=\"text-center\">" +
                                                        //"<div class=\"btn-group btn-group-xs\">" +
                                                            "<a onclick=\"customerprepaids.startedit('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Sửa\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-pencil\"></i></a>" +
                                                            "<a onclick=\"customerprepaids.startdelete('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Xóa\" class=\"btn btn-xs btn-danger\"><i class=\"fa fa-times\"></i></a>" +
                                                        //"</div>" +
                                                    "</td>" +
                                                "</tr>";
                                        }
                                    }

                                    html += "</tbody></table>";

                                    $('#divTableList').html(html);
                                    globalhelpers.RenderPaging($('#divPaging'), '/<%= CurrentSys_Module.Alias %>', customerprepaids.currentpage, pageSize, totalPages);

                                    $('[data-toggle="tooltip"]').tooltip();
                                });
            }
        }

                        customerprepaids.init();
</script>
