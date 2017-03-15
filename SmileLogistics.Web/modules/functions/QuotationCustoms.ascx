<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="QuotationCustoms.ascx.cs" Inherits="SmileLogistics.Web.modules.functions.QuotationCustoms" %>
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
            <h2>Danh sách <strong>Báo giá TTHQ</strong></h2>
            <div class="block-options pull-right">
                <a onclick="quotationcustoms.startAdd();" class="btn btn-sm btn-success" data-toggle="tooltip" title="Thêm mới"><i class="gi gi-plus"></i></a>
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
                <h3 class="modal-title">Xóa Báo giá TTHQ?</h3>
            </div>
            <div class="modal-body">
                Bạn chắc chắn muốn xóa Báo giá TTHQ <b id="bDeleteName"></b>?<br />
                <%--<i class="text-danger">(Điều này đồng nghĩa việc xóa kèm theo lịch sử hoạt động!!!)</i>--%>
            </div>
            <div class="modal-footer">
                <a id="btn-modal-delete-close" class="btn btn-sm btn-default" data-dismiss="modal">Hủy</a>
                <a id="btn-do-delete" onclick="quotationcustoms.dodelete();" class="btn btn-sm btn-danger">Xóa</a>
            </div>
        </div>
    </div>
</div>
<div id="modal-info" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Thêm mới Báo giá TTHQ</h3>
            </div>
            <div class="modal-body">
                <div id="clickable-wizard-feetypes" class="form-horizontal form-bordered ui-formwizard">
                    <div id="tab-info" class="step ui-formwizard-content">
                        <div class="form-group">
                            <div class="col-xs-12">
                                <ul class="nav nav-pills nav-justified clickable-steps">
                                    <li class="active"><a href="javascript:void(0)" data-gotostep="tab-info"><strong>1. Thông tin</strong></a></li>
                                    <li><a href="javascript:void(0)" data-gotostep="tab-feetypes"><strong>2. Thiết lập Danh sách loại phí</strong></a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">Sử dụng đồng USD?</label>
                            <div class="col-md-9">
                                <label class='switch switch-success'>
                                    <input id="info-isusd" type='checkbox' checked><span></span></label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">Ngày bắt đầu hiệu lực</label>
                            <div class="col-md-9">
                                <input type="text" id="info-expirefrom" name="info-dateofbirth" class="form-control input-datepicker" data-date-format="dd/mm/yyyy" placeholder="dd/mm/yyyy">
                            </div>
                        </div>
                    </div>
                    <div id="tab-feetypes" class="step ui-formwizard-content">
                        <div class="form-group">
                            <div class="col-xs-12">
                                <ul class="nav nav-pills nav-justified clickable-steps">
                                    <li><a href="javascript:void(0)" data-gotostep="tab-info"><strong>1. Thông tin</strong></a></li>
                                    <li class="active"><a href="javascript:void(0)" data-gotostep="tab-feetypes"><strong>2. Thiết lập Danh sách loại phí</strong></a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-12">
                                <div id="divFeeTypes" class="table-responsive">
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
                <a id="btn-do-save" onclick="quotationcustoms.doAdd();" class="btn btn-sm btn-primary">Lưu</a>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var quotationcustoms =
        {
            ajaxPath: '/ajax/modules/functions/quotationcustoms.aspx',
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
                    quotationcustoms.currentpage = 0;
                else
                    quotationcustoms.currentpage = Number(page);

                var sTypes = '<%= _FeeTypes %>';
                quotationcustoms.allTypes = sTypes == '' ? null : JSON.parse(sTypes);

                quotationcustoms.initfeetypes();

                quotationcustoms.loadlist();

                var s = $("#clickable-wizard-feetypes");
                s.formwizard({ disableUIStyles: !0, inDuration: 0, outDuration: 0 });
                $(".clickable-steps a").on("click", function ()
                { var r = $(this).data("gotostep"); s.formwizard("show", r) });
            },

            initfeetypes: function () {
                var html =
                    "<table id=\"tblList_FeeTypes\" class=\"table table-vcenter table-striped table-condensed table-hover table-bordered\">" +
                        "<thead>" +
                            "<tr>" +
                                "<th class=\"text-center\" width=\"60%\">Loại phí</th>" +
                                "<th class=\"text-center\">Phí</th>" +
                            "</tr>" +
                        "</thead>" +
                        "<tbody>";

                if (this.allTypes == null || this.allTypes.length == 0) {
                    html +=
                        "<tr>" +
                            "<td class=\"text-center\" colspan=\"2\">" +
                                "<label class='control-label label-quicklink'><a href='/loai-phi-tthq'>Chưa có dữ liệu Loại phí! Nhấp chọn chuyển sang trang Quản lý!</a></label>" +
                            "</td>" +
                        "</tr>";
                }
                else {
                    for (var i = 0; i < this.allTypes.length; i++) {
                        var type = this.allTypes[i];
                        var detail = this.currentobj == null ? null : globalhelpers.GetObjInList(type.ID, this.currentobj.FeeDetails, "FeeTypeID");

                        html +=
                            "<tr>" +
                                "<td class=\"text-left\">" + type.Name + "</td>" +
                                "<td class=\"text-left\">" +
                                        "<input type=\"text\" id=\"info-price-" + type.ID + "\" class=\"form-control\" placeholder=\"Phí\" value=\"" + (detail == null ? "0" : detail.Price) + "\">" +
                                    "</td>" +
                            "</tr>";
                    }
                }

                html += "</tbody></table>";

                $('#divFeeTypes').html(html);
            },

            //-----------------------------------------------------------------------------------------------

            startdelete: function (id) {
                quotationcustoms.currentobj = quotationcustoms.getobj(id);
                if (quotationcustoms.currentobj == null) {
                    alert('Không tìm thấy Báo giá TTHQ!');
                    return;
                }

                $('#modal-delete #bDeleteName').html(quotationcustoms.currentobj.Name);
                $('#modal-delete').modal('show');
            },

            dodelete: function () {
                NProgress.start();
                $('#btn-do-delete').addClass('disabled');
                $('#btn-modal-delete-close').addClass('disabled');
                $('#btn-do-delete').html('Đang xử lý...');

                $.post(quotationcustoms.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': 'delete', 'id': quotationcustoms.currentobj.ID },
                                function (data) {
                                    NProgress.done();

                                    var result = JSON.parse(data);
                                    $('#btn-do-delete').removeClass('disabled');
                                    $('#btn-modal-delete-close').removeClass('disabled');
                                    $('#btn-do-delete').html('Xóa');
                                    alert(result.Message);

                                    if (result.ErrorCode == 0)
                                        quotationcustoms.reloadpage();
                                });
            },

            startedit: function (id) {
                quotationcustoms.mode = 'edit';
                quotationcustoms.currentobj = quotationcustoms.getobj(id);
                if (quotationcustoms.currentobj == null) {
                    alert('Không tìm thấy Báo giá TTHQ!');
                    return;
                }

                $('#modal-info #info-isusd').prop('checked', quotationcustoms.currentobj.IsUSD);
                $('#modal-info #info-expirefrom').val(quotationcustoms.currentobj.sExpireFrom);

                this.initfeetypes();

                $('#modal-info .modal-header .modal-title').html('Cập nhật Báo giá TTHQ');
                $('#btn-do-save').html('Lưu');
                $('#modal-info').modal('show');
            },

            doAdd: function () {
                var postdata = quotationcustoms.validateForm();
                if (postdata == null)
                    return;

                NProgress.start();
                $('#btn-do-save').addClass('disabled');
                $('#btn-modal-add-close').addClass('disabled');
                $('#btn-do-save').html('Đang xử lý...');

                var xhr = new XMLHttpRequest();
                xhr.open('POST', quotationcustoms.ajaxPath + '?ts=' + new Date().getTime().toString());
                xhr.onload = function () {
                    NProgress.done();

                    var result = JSON.parse(xhr.responseText);
                    $('#btn-do-save').removeClass('disabled');
                    $('#btn-modal-add-close').removeClass('disabled');
                    $('#btn-do-save').html(quotationcustoms.mode == 'create' ? 'Thêm' : 'Lưu');
                    alert(result.Message);

                    if (result.ErrorCode == 0)
                        quotationcustoms.reloadpage();
                };

                var form = new FormData();
                form.append('mod', quotationcustoms.mode);
                form.append('data', JSON.stringify(postdata));

                xhr.send(form);
            },

            reloadpage: function () {
                location.href = '/<%= CurrentSys_Module.Alias %>/?page=' + quotationcustoms.currentpage;
            },

            validateForm: function () {
                var message = '';
                var data = new Object();
                data.isusd = $('#modal-info #info-isusd').prop('checked');
                data.expirefrom = $('#modal-info #info-expirefrom').val();
                if (data.expirefrom == '')
                    message += '- Ngày bắt đầu hiệu lực không hợp lệ!<br/>';

                data.feetypes = new Array();

                for (var i = 0; i < this.allTypes.length; i++) {
                    var type = this.allTypes[i];
                    var price = Number($('#info-price-' + type.ID).val());
                    var objType = new Object();
                    objType.FeeTypeID = type.ID;
                    objType.Price = price;
                    data.feetypes.push(objType);
                }

                data.id = quotationcustoms.mode == "create" ? 0 : quotationcustoms.currentobj.ID;

                if (message != '') {
                    quotationcustoms.alert(message);
                    return null;
                }

                return data;
            },

            startAdd: function () {
                quotationcustoms.mode = 'create';
                $('#modal-info .modal-header .modal-title').html('Thêm mới Báo giá TTHQ');
                $('#btn-do-save').html('Thêm');
                $('#modal-info').modal('show');
            },

            getobj: function (value, list, field) {
                if (field == undefined) field = "ID";
                if (list == undefined) list = quotationcustoms.all;

                if (list == null) return null;
                for (var i = 0; i < list.length; i++)
                    if (list[i][field] == value) return list[i];

                return null;
            },

            loadlist: function () {
                NProgress.start();

                $.post(quotationcustoms.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': "loadlist", 'page': quotationcustoms.currentpage },
                                function (data) {
                                    NProgress.done();
                                    var result = JSON.parse(data);

                                    var html =
                                        "<table id=\"tblList\" class=\"table table-vcenter table-striped table-condensed table-hover table-bordered\">" +
                                            "<thead>" +
                                                "<tr>" +
                                                    "<th class=\"text-center\">STT</th>" +
                                                    "<th class=\"text-center\">Ngày bắt đầu hiệu lực</th>" +
                                                    "<th class=\"text-center\">Sử dụng USD</th>" +
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
                                        quotationcustoms.all = JSON.parse(result.Data.List);
                                        quotationcustoms.currentpage = Number(result.Data.PageIndex);
                                        var pageSize = Number(result.Data.PageSize);
                                        var totalPages = Number(result.Data.TotalPages);

                                        for (var i = 0; i < quotationcustoms.all.length; i++) {
                                            var obj = quotationcustoms.all[i];
                                            //var htmlFees = "";
                                            //if (obj.FeeDetails != null && obj.FeeDetails.length > 0) {
                                            //    for (var j = 0; j < obj.FeeDetails.length; j++) {
                                            //        var fee = obj.FeeDetails[j];
                                            //        htmlFees +=
                                            //            "<div class=\"form-group\">" +
                                            //                "<label class=\"col-md-4 control-label\">" + fee.FeeType.Name + "</label>" +
                                            //                "<div class=\"col-md-8 text-left\">" +
                                            //                    "<p class=\"form-control-static\">" + globalhelpers.Format_Money(fee.Price.toFixed(2)) + "</p>" +
                                            //                "</div>" +
                                            //            "</div>";
                                            //    }
                                            //}

                                            html +=
                                                "<tr>" +
                                                    "<td class=\"text-center\">" +
                                                        (quotationcustoms.currentpage * pageSize + i + 1) +
                                                    "</td>" +
                                                    "<td class=\"text-center\">" + obj.sExpireFrom + "</td>" +
                                                    "<td class=\"text-center\">" + (obj.IsUSD ? "<i class=\"gi gi-ok_2\"></i>" : "") + "</td>" +
                                                    //"<td class=\"text-center\">" + htmlFees + "</td>" +
                                                    "<td class=\"text-center\">" +
                                                        //"<div class=\"btn-group\">" +
                                                            "<a onclick=\"quotationcustoms.startedit('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Sửa\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-pencil\"></i></a>" +
                                                            "<a onclick=\"quotationcustoms.startdelete('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Xóa\" class=\"btn btn-xs btn-danger\"><i class=\"fa fa-times\"></i></a>" +
                                                        //"</div>" +
                                                    "</td>" +
                                                "</tr>";
                                        }
                                    }

                                    html += "</tbody></table>";

                                    $('#divTableList').html(html);
                                    globalhelpers.RenderPaging($('#divPaging'), '/<%= CurrentSys_Module.Alias %>', quotationcustoms.currentpage, pageSize, totalPages);

                                    $('[data-toggle="tooltip"]').tooltip();
                                });
            }
        }

                        quotationcustoms.init();
</script>
