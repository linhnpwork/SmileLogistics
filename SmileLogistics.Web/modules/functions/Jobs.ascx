<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Jobs.ascx.cs" Inherits="SmileLogistics.Web.modules.functions.Jobs" %>
<style type="text/css">
    .modal-body .nav-tabs {
        padding: 3px 1px 0 !important;
        margin: 0 !important;
        margin-bottom: -2px !important;
    }

    .block {
        padding-bottom: 0 !important;
    }

    .row-header-filter {
        background-color: #f9fafc !important;
        font-size: 11px !important;
        font-weight: normal !important;
    }

        .row-header-filter th {
            border: none !important;
            font-size: 11px !important;
            font-weight: normal !important;
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
            <h2>Danh sách <strong>JOB</strong></h2>
            <div class="block-options pull-right">
                <a onclick="jobs.godetail();" class="btn btn-sm btn-success" data-toggle="tooltip" title="Thêm mới"><i class="gi gi-plus"></i></a>
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
                <h3 class="modal-title">Xóa JOB?</h3>
            </div>
            <div class="modal-body">
                Bạn chắc chắn muốn xóa JOB <b id="bDeleteName"></b>?<br />
                <%--<i class="text-danger">(Điều này đồng nghĩa việc xóa kèm theo lịch sử hoạt động!!!)</i>--%>
            </div>
            <div class="modal-footer">
                <a id="btn-modal-delete-close" class="btn btn-sm btn-default" data-dismiss="modal">Hủy</a>
                <a id="btn-do-delete" onclick="jobs.dodelete();" class="btn btn-sm btn-danger">Xóa</a>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var jobs =
        {
            ajaxPath: '/ajax/modules/functions/jobs.aspx',
            all: null,
            mode: 'normal',
            currentpage: 0,
            currentobj: null,
            detaillink: '/job-detail',

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
                    jobs.currentpage = 0;
                else
                    jobs.currentpage = Number(page);

                jobs.loadlist();
            },

            //-----------------------------------------------------------------------------------------------

            startdelete: function (id) {
                jobs.currentobj = jobs.getobj(id);
                if (jobs.currentobj == null) {
                    alert('Không tìm thấy JOB!');
                    return;
                }

                $('#modal-delete #bDeleteName').html(jobs.currentobj.JobID);
                $('#modal-delete').modal('show');
            },

            dodelete: function () {
                NProgress.start();
                $('#btn-do-delete').addClass('disabled');
                $('#btn-modal-delete-close').addClass('disabled');
                $('#btn-do-delete').html('Đang xử lý...');

                $.post(jobs.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': 'delete', 'id': jobs.currentobj.ID },
                                function (data) {
                                    NProgress.done();

                                    var result = JSON.parse(data);
                                    $('#btn-do-delete').removeClass('disabled');
                                    $('#btn-modal-delete-close').removeClass('disabled');
                                    $('#btn-do-delete').html('Xóa');
                                    alert(result.Message);

                                    if (result.ErrorCode == 0)
                                        jobs.reloadpage();
                                });
            },

            godetail: function (id) {
                location.href = jobs.detaillink + (id == undefined ? "" : ("?job=" + id));
            },

            reloadpage: function () {
                location.href = '/<%= CurrentSys_Module.Alias %>/?page=' + jobs.currentpage;
            },

            getobj: function (value, list, field) {
                if (field == undefined) field = "ID";
                if (list == undefined) list = jobs.all;

                if (list == null) return null;
                for (var i = 0; i < list.length; i++)
                    if (list[i][field] == value) return list[i];

                return null;
            },

            loadlist: function () {
                NProgress.start();

                $.post(jobs.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': "loadlist", 'page': jobs.currentpage },
                                function (data) {
                                    NProgress.done();
                                    var result = JSON.parse(data);

                                    var html =
                                        "<table id=\"tblList\" class=\"table table-vcenter table-striped table-condensed table-hover table-bordered\">" +
                                            "<thead>" +
                                                "<tr class=\"row-header-filter\">" +
                                                    "<th class=\"text-center\"></th>" +
                                                    "<th class=\"text-center\"><select class=\"select-select2 select2-hidden-accessible\"><option value=\"0\">--- Loại ---</option></select></th>" +
                                                    "<th class=\"text-center\"><input type=\"text\" class=\"form-control\" placeholder=\"Job ID\"></th>" +
                                                    "<th class=\"text-center\"><input type=\"text\" class=\"form-control\" placeholder=\"Invoice NO\"></th>" +
                                                    "<th class=\"text-center\"><input type=\"text\" class=\"form-control\" placeholder=\"BillLading ID\"></th>" +
                                                    "<th class=\"text-center\"><input type=\"text\" class=\"form-control\" placeholder=\"TKHQ\"></th>" +
                                                    "<th class=\"text-center\"><select class=\"select-select2 select2-hidden-accessible\"><option value=\"0\">--- Khách hàng ---</option></select></th>" +
                                                    "<th class=\"text-center\"></th>" +
                                                    "<th class=\"text-center\"><select class=\"select-select2 select2-hidden-accessible\"><option value=\"0\">--- Tình trạng thanh toán ---</option></select></th>" +
                                                    "<th class=\"text-center\"><select class=\"select-select2 select2-hidden-accessible\"><option value=\"0\">--- Báo nhà xe ---</option></select></th>" +
                                                    "<th class=\"text-center\"><select class=\"select-select2 select2-hidden-accessible\"><option value=\"0\">--- Tình trạng thanh toán ---</option></select></th>" +
                                                    "<th class=\"text-center\"><select class=\"select-select2 select2-hidden-accessible\"><option value=\"0\">--- Trạng thái ---</option></select></th>" +
                                                    "<th class=\"text-center\"></th>" +
                                                    "<th class=\"text-center\"></th>" +
                                                    "<th class=\"text-center\"><a class=\"btn btn-sm btn-success\" data-toggle=\"tooltip\" title=\"Lọc\"><i class=\"hi hi-search\"></i></a></th>" +
                                                "</tr>" +
                                                "<tr>" +
                                                    "<th rowspan=\"2\" class=\"text-center\">STT</th>" +
                                                    "<th rowspan=\"2\" class=\"text-center\">Loại</th>" +
                                                    "<th colspan=\"4\" class=\"text-center\">Thông tin JOB</th>" +
                                                    "<th colspan=\"3\" class=\"text-center\">Khách hàng</th>" +
                                                    "<th colspan=\"2\" class=\"text-center\">Nhà xe</th>" +
                                                    "<th rowspan=\"2\" class=\"text-center\">Ngày giao hàng</th>" +
                                                    "<th rowspan=\"2\" class=\"text-center\">Trạng thái</th>" +
                                                    "<th rowspan=\"2\" class=\"text-center\">#</th>" +
                                                "</tr>" +
                                                "<tr>" +
                                                    "<th class=\"text-center\">JobID</th>" +
                                                    "<th class=\"text-center\">Invoice NO</th>" +
                                                    "<th class=\"text-center\">BillLading NO</th>" +
                                                    "<th class=\"text-center\">TKHQ</th>" +

                                                    "<th class=\"text-center\">Tên KH</th>" +
                                                    "<th class=\"text-center\">Đã chi tạm ứng</th>" +
                                                    "<th class=\"text-center\">Thanh toán</th>" +

                                                    "<th class=\"text-center\">Đã báo</th>" +
                                                    "<th class=\"text-center\">Thanh toán</th>" +
                                                "</tr>" +
                                            "</thead>" +
                                            "<tbody>";

                                    if (result.ErrorCode != 0) {
                                        html +=
                                            "<tr>" +
                                                "<td class=\"text-center\" colspan=\"14\">" +
                                                    result.Message +
                                                "</td>" +
                                            "</tr>";
                                    }
                                    else {
                                        jobs.all = JSON.parse(result.Data.List);
                                        jobs.currentpage = Number(result.Data.PageIndex);
                                        var pageSize = Number(result.Data.PageSize);
                                        var totalPages = Number(result.Data.TotalPages);

                                        for (var i = 0; i < jobs.all.length; i++) {
                                            var obj = jobs.all[i];
                                            var statusClassName = globalhelpers.GetStatusClass(obj.Status);

                                            html +=
                                                "<tr>" +
                                                    "<td class=\"text-center\">" +
                                                        (jobs.currentpage * pageSize + i + 1) +
                                                    "</td>" +
                                                    "<td class=\"text-center\">" + obj.sType + "</td>" +
                                                    "<td class=\"text-center\">" + obj.JobID + "</td>" +
                                                    "<td class=\"text-center\">" + obj.InvoiceNO + "</td>" +
                                                    "<td class=\"text-center\">" + obj.BillLadingNO + "</td>" +
                                                    "<td class=\"text-center\">" + obj.TKHQNO + "</td>" +
                                                    "<td class=\"text-center\">" + obj.Customer.Name + "</td>" +
                                                    "<td class=\"text-center\">" + globalhelpers.Format_Money(obj.CustomerPrepaids.toFixed(2)) + "</td>" +
                                                    "<td class=\"text-center\">" + (obj.IsPaidFromCustomer ? "<i class=\"gi gi-ok_2\"></i>" : "") + "</td>" +
                                                    "<td class=\"text-center\">" + (obj.IsInformTransportComp ? "<i class=\"gi gi-ok_2\"></i>" : "") + "</td>" +
                                                    "<td class=\"text-center\">" + (obj.IsPayedForTransportComp ? "<i class=\"gi gi-ok_2\"></i>" : "") + "</td>" +
                                                    "<td class=\"text-center\">" + (obj.IsConsigned ? (obj.sConsignedTime + " " + sConsignedDate) : "---") + "</td>" +
                                                    "<td class=\"text-center\"><span class=\"" + (statusClassName == "" ? "" : ("text-" + statusClassName)) + "\">" + obj.sStatus + "</span></td>" +
                                                    "<td class=\"text-center\">" +
                                                        //"<div class=\"btn-group\">" +
                                                            "<a onclick=\"jobs.godetail('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Sửa\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-pencil\"></i></a>" +
                                                            "<a onclick=\"jobs.startdelete('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Xóa\" class=\"btn btn-xs btn-danger\"><i class=\"fa fa-times\"></i></a>" +
                                                        //"</div>" +
                                                    "</td>" +
                                                "</tr>";
                                        }
                                    }

                                    html += "</tbody></table>";

                                    $('#divTableList').html(html);
                                    globalhelpers.RenderPaging($('#divPaging'), '/<%= CurrentSys_Module.Alias %>', jobs.currentpage, pageSize, totalPages);

                                    $('[data-toggle="tooltip"]').tooltip();
                                });
            }
        }

                        jobs.init();
</script>
