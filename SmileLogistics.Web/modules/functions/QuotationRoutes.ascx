<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="QuotationRoutes.ascx.cs" Inherits="SmileLogistics.Web.modules.functions.QuotationRoutes" %>
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
            <h2>Danh sách <strong>Báo giá Vận chuyển</strong></h2>
            <div class="block-options pull-right">
                <a onclick="quotationroutes.startAdd();" class="btn btn-sm btn-success" data-toggle="tooltip" title="Thêm mới"><i class="gi gi-plus"></i></a>
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
                <h3 class="modal-title">Xóa Báo giá Vận chuyển?</h3>
            </div>
            <div class="modal-body">
                Bạn chắc chắn muốn xóa Báo giá Vận chuyển <b id="bDeleteName"></b>?<br />
                <%--<i class="text-danger">(Điều này đồng nghĩa việc xóa kèm theo lịch sử hoạt động!!!)</i>--%>
            </div>
            <div class="modal-footer">
                <a id="btn-modal-delete-close" class="btn btn-sm btn-default" data-dismiss="modal">Hủy</a>
                <a id="btn-do-delete" onclick="quotationroutes.dodelete();" class="btn btn-sm btn-danger">Xóa</a>
            </div>
        </div>
    </div>
</div>
<div id="modal-info" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Thêm mới Báo giá Vận chuyển</h3>
            </div>
            <div class="modal-body">
                <div class="form-horizontal form-bordered">
                    <div class="form-group">
                        <label class="col-md-3 control-label">Hãng vận chuyển</label>
                        <div id="divTransportCompanies" runat="server" class="col-md-9">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Tuyến đường</label>
                        <div id="divTransportRoutes" runat="server" class="col-md-9">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Loại tải trọng</label>
                        <div id="divVehicleLoads" runat="server" class="col-md-9">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Giá</label>
                        <div class="col-md-9">
                            <input type="text" id="info-price" class="form-control" placeholder="Giá">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Đồng giá 2 chiều?</label>
                        <div class="col-md-9">
                            <label class='switch switch-success'>
                                <input id="info-issameprice" type='checkbox' checked><span></span></label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Giá chiều về</label>
                        <div class="col-md-9">
                            <input type="text" id="info-price-roundedtrip" class="form-control" placeholder="Giá chiều về">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Hiệu lực báo giá</label>
                        <div class="col-md-9">
                            <%--<input type="text" id="example-datepicker2" name="example-datepicker2" class="form-control input-datepicker" data-date-format="dd/mm/yy" placeholder="dd/mm/yy">--%>
                            <div class="input-group input-daterange" data-date-format="dd/mm/yyyy">
                                <input type="text" id="info-expire-start" class="form-control text-center" placeholder="From">
                                <span class="input-group-addon"><i class="fa fa-angle-right"></i></span>
                                <input type="text" id="info-expire-end" class="form-control text-center" placeholder="To">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Sử dụng đồng USD?</label>
                        <div class="col-md-9">
                            <label class='switch switch-success'>
                                <input id="info-isusd" type='checkbox' checked><span></span></label>
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
                <a id="btn-do-save" onclick="quotationroutes.doAdd();" class="btn btn-sm btn-primary">Lưu</a>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var quotationroutes =
        {
            ajaxPath: '/ajax/modules/functions/quotationroutes.aspx',
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
                    quotationroutes.currentpage = 0;
                else
                    quotationroutes.currentpage = Number(page);

                quotationroutes.loadlist();
            },

            //-----------------------------------------------------------------------------------------------

            startdelete: function (id) {
                quotationroutes.currentobj = quotationroutes.getobj(id);
                if (quotationroutes.currentobj == null) {
                    alert('Không tìm thấy Báo giá Vận chuyển!');
                    return;
                }

                $('#modal-delete #bDeleteName').html(quotationroutes.currentobj.Name);
                $('#modal-delete').modal('show');
            },

            dodelete: function () {
                NProgress.start();
                $('#btn-do-delete').addClass('disabled');
                $('#btn-modal-delete-close').addClass('disabled');
                $('#btn-do-delete').html('Đang xử lý...');

                $.post(quotationroutes.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': 'delete', 'id': quotationroutes.currentobj.ID },
                                function (data) {
                                    NProgress.done();

                                    var result = JSON.parse(data);
                                    $('#btn-do-delete').removeClass('disabled');
                                    $('#btn-modal-delete-close').removeClass('disabled');
                                    $('#btn-do-delete').html('Xóa');
                                    alert(result.Message);

                                    if (result.ErrorCode == 0)
                                        quotationroutes.reloadpage();
                                });
            },

            startedit: function (id) {
                quotationroutes.mode = 'edit';
                quotationroutes.currentobj = quotationroutes.getobj(id);
                if (quotationroutes.currentobj == null) {
                    alert('Không tìm thấy Báo giá Vận chuyển!');
                    return;
                }

                $('#modal-info #info-transcomp').val(quotationroutes.currentobj.TransCompID);
                $('#modal-info #info-transplace-1').val(quotationroutes.currentobj.StartPoint);
                $('#modal-info #info-transplace-2').val(quotationroutes.currentobj.EndPoint);

                $('#modal-info .modal-header .modal-title').html('Cập nhật Báo giá Vận chuyển');
                $('#btn-do-save').html('Lưu');
                $('#modal-info').modal('show');
            },

            doAdd: function () {
                var postdata = quotationroutes.validateForm();
                if (postdata == null)
                    return;

                NProgress.start();
                $('#btn-do-save').addClass('disabled');
                $('#btn-modal-add-close').addClass('disabled');
                $('#btn-do-save').html('Đang xử lý...');

                var xhr = new XMLHttpRequest();
                xhr.open('POST', quotationroutes.ajaxPath + '?ts=' + new Date().getTime().toString());
                xhr.onload = function () {
                    NProgress.done();

                    var result = JSON.parse(xhr.responseText);
                    $('#btn-do-save').removeClass('disabled');
                    $('#btn-modal-add-close').removeClass('disabled');
                    $('#btn-do-save').html(quotationroutes.mode == 'create' ? 'Thêm' : 'Lưu');
                    alert(result.Message);

                    if (result.ErrorCode == 0)
                        quotationroutes.reloadpage();
                };

                var form = new FormData();
                form.append('mod', quotationroutes.mode);
                form.append('data', JSON.stringify(postdata));

                xhr.send(form);
            },

            reloadpage: function () {
                location.href = '/<%= CurrentSys_Module.Alias %>/?page=' + quotationroutes.currentpage;
            },

            validateForm: function () {
                var message = '';
                var data = new Object();

                data.transcomp = Number($('#modal-info #info-transcomp').val());
                data.startpoint = Number($('#modal-info #info-transplace-1').val());
                data.endpoint = Number($('#modal-info #info-transplace-2').val());

                if (data.startpoint == data.endpoint)
                    message += '- Trùng điểm vận chuyển!<br/>';

                data.id = quotationroutes.mode == "create" ? 0 : quotationroutes.currentobj.ID;

                if (message != '') {
                    quotationroutes.alert(message);
                    return null;
                }

                return data;
            },

            startAdd: function () {
                quotationroutes.mode = 'create';
                $('#modal-info .modal-header .modal-title').html('Thêm mới Báo giá Vận chuyển');
                $('#btn-do-save').html('Thêm');
                $('#modal-info').modal('show');
            },

            getobj: function (id) {
                if (quotationroutes.all == null) return null;
                for (var i = 0; i < quotationroutes.all.length; i++)
                    if (quotationroutes.all[i].ID == id) return quotationroutes.all[i];

                return null;
            },

            loadlist: function () {
                NProgress.start();

                $.post(quotationroutes.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': "loadlist", 'page': quotationroutes.currentpage },
                                function (data) {
                                    NProgress.done();
                                    var result = JSON.parse(data);

                                    var html =
                                        "<table id=\"tblList\" class=\"table table-vcenter table-striped table-condensed table-hover table-bordered\">" +
                                            "<thead>" +
                                                "<tr>" +
                                                    "<th class=\"text-center\">STT</th>" +
                                                    "<th class=\"text-center\">Hãng vận chuyển</th>" +
                                                    "<th class=\"text-center\">Chi tiết</th>" +
                                                    "<th class=\"text-center\">#</th>" +
                                                "</tr>" +
                                            "</thead>" +
                                            "<tbody>";

                                    if (result.ErrorCode != 0) {
                                        html +=
                                            "<tr>" +
                                                "<td class=\"text-center\" colspan=\"4\">" +
                                                    result.Message +
                                                "</td>" +
                                            "</tr>";
                                    }
                                    else {
                                        quotationroutes.all = JSON.parse(result.Data.List);
                                        quotationroutes.currentpage = Number(result.Data.PageIndex);
                                        var pageSize = Number(result.Data.PageSize);
                                        var totalPages = Number(result.Data.TotalPages);

                                        for (var i = 0; i < quotationroutes.all.length; i++) {
                                            var obj = quotationroutes.all[i];

                                            html +=
                                                "<tr>" +
                                                    "<td class=\"text-center\">" +
                                                        (quotationroutes.currentpage * pageSize + i + 1) +
                                                    "</td>" +
                                                    "<td class=\"text-center\">" + obj.TransportCompany.Name + "</td>" +
                                                    "<td class=\"text-center\">" + obj.PointStart.Name + " <i class='gi gi-transfer'></i> " + obj.PointEnd.Name + "</td>" +
                                                    "<td class=\"text-center\">" +
                                                        //"<div class=\"btn-group\">" +
                                                            "<a onclick=\"quotationroutes.startedit('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Sửa\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-pencil\"></i></a>" +
                                                            "<a onclick=\"quotationroutes.startdelete('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Xóa\" class=\"btn btn-xs btn-danger\"><i class=\"fa fa-times\"></i></a>" +
                                                        //"</div>" +
                                                    "</td>" +
                                                "</tr>";
                                        }
                                    }

                                    html += "</tbody></table>";

                                    $('#divTableList').html(html);
                                    globalhelpers.RenderPaging($('#divPaging'), '/<%= CurrentSys_Module.Alias %>', quotationroutes.currentpage, pageSize, totalPages);

                                    $('[data-toggle="tooltip"]').tooltip();
                                });
            }
        }

                        quotationroutes.init();
</script>
