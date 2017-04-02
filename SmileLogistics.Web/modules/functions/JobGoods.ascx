<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="JobGoods.ascx.cs" Inherits="SmileLogistics.Web.modules.functions.JobGoods" %>
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
            <h2>Danh sách <strong>Danh mục Hàng hóa</strong></h2>
            <%--<div class="block-options pull-right">
                <a onclick="jobgoods.startAdd();" class="btn btn-sm btn-success" data-toggle="tooltip" title="Thêm mới"><i class="gi gi-plus"></i></a>
            </div>--%>
        </div>
        <div class="form-horizontal">
            <div id="divTableList" class="table-responsive">
                <table id="tblList" class="table table-vcenter table-striped table-condensed table-hover table-bordered">
                    <thead>
                        <tr class="row-header-filter">
                            <th class="text-center"></th>
                            <th class="text-center">
                                <input id="filter-code" type="text" class="form-control" placeholder="Lọc theo Mã hàng"></th>
                            <th class="text-center">
                                <input id="filter-name" type="text" class="form-control" placeholder="Lọc theo Tên"></th>
                            <th class="text-center"><a onclick="jobgoods.filter();" class="btn btn-sm btn-success" data-toggle="tooltip" title="Lọc"><i class="hi hi-search"></i></a></th>
                        </tr>
                        <tr>
                            <th class="text-center">STT</th>
                            <th class="text-center">Code</th>
                            <th class="text-center">Tên</th>
                            <th class="text-center">JOB</th>
                        </tr>
                    </thead>
                    <tbody id="tbodyList">
                    </tbody>
                </table>
            </div>
            <div id="divPaging" class="form-group form-actions">
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var jobgoods =
        {
            ajaxPath: '/ajax/modules/functions/jobgoods.aspx',
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
                    jobgoods.currentpage = 0;
                else
                    jobgoods.currentpage = Number(page);

                jobgoods.loadlist();
            },

            //-----------------------------------------------------------------------------------------------

            reloadpage: function () {
                location.href = '/<%= CurrentSys_Module.Alias %>/?page=' + jobgoods.currentpage;
            },

            getobj: function (id) {
                if (jobgoods.all == null) return null;
                for (var i = 0; i < jobgoods.all.length; i++)
                    if (jobgoods.all[i].ID == id) return jobgoods.all[i];

                return null;
            },

            getfilter: function () {
                var filter = new Object();
                filter.code = $('#filter-code').val();
                filter.name = $('#filter-name').val();
                return filter;
            },

            filter: function () {
                this.currentpage = 0;
                this.loadlist();
            },

            loadlist: function () {
                NProgress.start();
                var filter = this.getfilter();
                var filterString = JSON.stringify(filter);
                $.post(jobgoods.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': "loadlist", 'page': jobgoods.currentpage, 'filter': filterString },
                                function (data) {
                                    NProgress.done();
                                    var result = JSON.parse(data);

                                    var html = "";

                                    if (result.ErrorCode != 0) {
                                        html +=
                                            "<tr>" +
                                                "<td class=\"text-center\" colspan=\"4\">" +
                                                    result.Message +
                                                "</td>" +
                                            "</tr>";
                                    }
                                    else {
                                        jobgoods.all = JSON.parse(result.Data.List);
                                        jobgoods.currentpage = Number(result.Data.PageIndex);
                                        var pageSize = Number(result.Data.PageSize);
                                        var totalPages = Number(result.Data.TotalPages);

                                        for (var i = 0; i < jobgoods.all.length; i++) {
                                            var obj = jobgoods.all[i];

                                            html +=
                                                "<tr>" +
                                                    "<td class=\"text-center\">" +
                                                        (jobgoods.currentpage * pageSize + i + 1) +
                                                    "</td>" +
                                                    "<td class=\"text-center\">" + obj.Code + "</td>" +
                                                    "<td class=\"text-center\">" + obj.Name + "</td>" +
                                                    "<td class=\"text-center\"><a href=\"/job-detail?job=" + obj.JobID + "\" target=\"_blank\">" + obj.JobCODE + "</a></td>" +
                                                "</tr>";
                                        }
                                    }

                                    //html += "</tbody></table>";

                                    $('#tbodyList').html(html);
                                    globalhelpers.RenderPaging($('#divPaging'), '/<%= CurrentSys_Module.Alias %>', jobgoods.currentpage, pageSize, totalPages);

                                    $('[data-toggle="tooltip"]').tooltip();
                                });
            }
        }

                        jobgoods.init();
</script>
