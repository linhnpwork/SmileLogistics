<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Modules.ascx.cs" Inherits="SmileLogistics.Web.modules.systems.Modules" %>
<style type="text/css">
    .modules-list-icons .btn {
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
            <h2>Danh sách <strong>Chức năng hệ thống</strong></h2>
            <div class="block-options pull-right">
                <a onclick="sysmodule.startAdd();" class="btn btn-sm btn-success" data-toggle="tooltip" title="Thêm mới"><i class="gi gi-plus"></i>&nbsp;</a>
            </div>
        </div>
        <div id="divTableList" class="table-responsive">
        </div>
    </div>
</div>
<div id="modal-delete" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-xs">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Xóa Chức năng hệ thống?</h3>
            </div>
            <div class="modal-body">
                Bạn chắc chắn muốn xóa Chức năng <b id="bDeleteName"></b>?<br />
                <i class="text-danger">(Điều này đồng nghĩa việc xóa kèm theo toàn bộ Chức năng con!!!)</i>
            </div>
            <div class="modal-footer">
                <a id="btn-modal-delete-close" class="btn btn-sm btn-default" data-dismiss="modal">Hủy</a>
                <a id="btn-do-delete" onclick="sysmodule.dodelete();" class="btn btn-sm btn-danger">Xóa</a>
            </div>
        </div>
    </div>
</div>
<div id="modal-info" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Thêm mới Chức năng hệ thống</h3>
            </div>
            <div class="modal-body">
                <div class="form-horizontal form-bordered">
                    <div class="form-group">
                        <label class="col-md-3 control-label">Tên</label>
                        <div class="col-md-9">
                            <input type="text" id="info-name" class="form-control" placeholder="Name" onkeyup="sysmodule.onchangename();">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Ghi chú</label>
                        <div class="col-md-9">
                            <input type="text" id="info-description" class="form-control" placeholder="Description">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Cấp cha</label>
                        <div id="divModuleParent" runat="server" class="col-md-9">
                            <select id="info-parent" class="form-control">
                                <option value="-1">--- ROOT ---</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Alias</label>
                        <div class="col-md-9">
                            <input type="text" id="info-alias" class="form-control" placeholder="Alias" onkeyup="sysmodule.onchangealias();">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Path</label>
                        <div class="col-md-9">
                            <input type="text" id="info-path" class="form-control" placeholder="Path">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label" for="example-chosen-multiple">Tính năng</label>
                        <div id="divModuleActions" runat="server" class="col-md-9">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Hiển thị ở Menu?</label>
                        <div class="col-md-9">
                            <label class='switch switch-success'>
                                <input id="info-showinmenu" type='checkbox' checked><span></span></label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label" for="example-select2">Icon</label>
                        <div class="col-md-9">
                            <a id="info-icon" href="#collapseExample" class="btn btn-sm btn-success collapsed" role="button" data-toggle="collapse" aria-expanded="false" aria-controls="collapseExample">Chọn ...</a>
                            <div class="collapse" id="collapseExample" aria-expanded="false" style="margin-top: 10px;">
                                <div class="block full">
                                    <!-- Block Tabs Title -->
                                    <div class="block-title">
                                        <ul class="nav nav-tabs" data-toggle="tabs">
                                            <li class="active"><a href="#example-tabs2-activity">Font Awesome</a></li>
                                            <li class=""><a href="#example-tabs2-profile">Glyphicon</a></li>
                                        </ul>
                                    </div>
                                    <!-- END Block Tabs Title -->

                                    <!-- Tabs Content -->
                                    <div class="tab-content">
                                        <div class="modules-list-icons tab-pane active">
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-adjust"><i class="fa fa-adjust fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-anchor"><i class="fa fa-anchor fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-archive"><i class="fa fa-archive fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-asterisk"><i class="fa fa-asterisk fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-automobile"><i class="fa fa-automobile fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-ban"><i class="fa fa-ban fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-bank"><i class="fa fa-bank fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-bar-chart-o"><i class="fa fa-bar-chart-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-barcode"><i class="fa fa-barcode fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-flask"><i class="fa fa-flask fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-beer"><i class="fa fa-beer fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-bell-o"><i class="fa fa-bell-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-bell"><i class="fa fa-bell fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-bolt"><i class="fa fa-bolt fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-bomb"><i class="fa fa-bomb fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-book"><i class="fa fa-book fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-bookmark"><i class="fa fa-bookmark fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-bookmark-o"><i class="fa fa-bookmark-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-briefcase"><i class="fa fa-briefcase fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-bug"><i class="fa fa-bug fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-building"><i class="fa fa-building fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-building-o"><i class="fa fa-building-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-bullhorn"><i class="fa fa-bullhorn fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-bullseye"><i class="fa fa-bullseye fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-cab"><i class="fa fa-cab fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-calendar"><i class="fa fa-calendar fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-calendar-o"><i class="fa fa-calendar-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-camera"><i class="fa fa-camera fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-camera-retro"><i class="fa fa-camera-retro fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-car"><i class="fa fa-car fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-certificate"><i class="fa fa-certificate fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-check-square-o"><i class="fa fa-check-square-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-square-o"><i class="fa fa-square-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-minus-square-o"><i class="fa fa-minus-square-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-check-square"><i class="fa fa-check-square fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-child"><i class="fa fa-child fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-circle"><i class="fa fa-circle fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-circle-o"><i class="fa fa-circle-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-circle-o-notch"><i class="fa fa-circle-o-notch fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-circle-thin"><i class="fa fa-circle-thin fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-cloud"><i class="fa fa-cloud fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-cloud-download"><i class="fa fa-cloud-download fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-cloud-upload"><i class="fa fa-cloud-upload fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-code"><i class="fa fa-code fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-code-fork"><i class="fa fa-code-fork fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-coffee"><i class="fa fa-coffee fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-cog"><i class="fa fa-cog fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-cogs"><i class="fa fa-cogs fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-caret-square-o-down"><i class="fa fa-caret-square-o-down fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-plus-square-o"><i class="fa fa-plus-square-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-caret-square-o-up"><i class="fa fa-caret-square-o-up fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-comment"><i class="fa fa-comment fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-comment-o"><i class="fa fa-comment-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-comments"><i class="fa fa-comments fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-comments-o"><i class="fa fa-comments-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-compass"><i class="fa fa-compass fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-credit-card"><i class="fa fa-credit-card fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-crop"><i class="fa fa-crop fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-tachometer"><i class="fa fa-tachometer fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-desktop"><i class="fa fa-desktop fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-dot-circle-o"><i class="fa fa-dot-circle-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-arrow-circle-o-down"><i class="fa fa-arrow-circle-o-down fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-arrow-circle-o-right"><i class="fa fa-arrow-circle-o-right fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-arrow-circle-o-left"><i class="fa fa-arrow-circle-o-left fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-download"><i class="fa fa-download fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-pencil-square-o"><i class="fa fa-pencil-square-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-pencil-square"><i class="fa fa-pencil-square fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-ellipsis-h"><i class="fa fa-ellipsis-h fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-ellipsis-v"><i class="fa fa-ellipsis-v fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-envelope"><i class="fa fa-envelope fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-envelope-o"><i class="fa fa-envelope-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-envelope-square"><i class="fa fa-envelope-square fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-eraser"><i class="fa fa-eraser fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-exchange"><i class="fa fa-exchange fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-exclamation"><i class="fa fa-exclamation fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-exclamation-circle"><i class="fa fa-exclamation-circle fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-caret-square-o-right"><i class="fa fa-caret-square-o-right fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-plus-square-o"><i class="fa fa-plus-square-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-external-link"><i class="fa fa-external-link fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-external-link-square"><i class="fa fa-external-link-square fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-eye"><i class="fa fa-eye fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-eye-slash"><i class="fa fa-eye-slash fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-fax"><i class="fa fa-fax fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-video-camera"><i class="fa fa-video-camera fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-female"><i class="fa fa-female fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-fighter-jet"><i class="fa fa-fighter-jet fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-file-archive-o"><i class="fa fa-file-archive-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-file-audio-o"><i class="fa fa-file-audio-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-file-code-o"><i class="fa fa-file-code-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-file-excel-o"><i class="fa fa-file-excel-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-file-image-o"><i class="fa fa-file-image-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-file-movie-o"><i class="fa fa-file-movie-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-file-pdf-o"><i class="fa fa-file-pdf-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-file-photo-o"><i class="fa fa-file-photo-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-file-picture-o"><i class="fa fa-file-picture-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-file-powerpoint-o"><i class="fa fa-file-powerpoint-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-file-sound-o"><i class="fa fa-file-sound-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-file-video-o"><i class="fa fa-file-video-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-file-word-o"><i class="fa fa-file-word-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-file-zip-o"><i class="fa fa-file-zip-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-film"><i class="fa fa-film fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-filter"><i class="fa fa-filter fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-fire"><i class="fa fa-fire fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-fire-extinguisher"><i class="fa fa-fire-extinguisher fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-flag"><i class="fa fa-flag fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-flag-o"><i class="fa fa-flag-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-flag-checkered"><i class="fa fa-flag-checkered fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-folder"><i class="fa fa-folder fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-folder-o"><i class="fa fa-folder-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-folder-open"><i class="fa fa-folder-open fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-folder-open-o"><i class="fa fa-folder-open-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-cutlery"><i class="fa fa-cutlery fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-dashboard"><i class="fa fa-dashboard fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-database"><i class="fa fa-database fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-frown-o"><i class="fa fa-frown-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-gamepad"><i class="fa fa-gamepad fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-gear"><i class="fa fa-gear fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-gears"><i class="fa fa-gears fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-gift"><i class="fa fa-gift fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-glass"><i class="fa fa-glass fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-globe"><i class="fa fa-globe fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-graduation-cap"><i class="fa fa-graduation-cap fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-users"><i class="fa fa-users fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-hdd-o"><i class="fa fa-hdd-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-headphones"><i class="fa fa-headphones fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-heart"><i class="fa fa-heart fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-heart-o"><i class="fa fa-heart-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-history"><i class="fa fa-history fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-home"><i class="fa fa-home fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-inbox"><i class="fa fa-inbox fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-info"><i class="fa fa-info fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-info-circle"><i class="fa fa-info-circle fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-institution"><i class="fa fa-institution fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-key"><i class="fa fa-key fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-keyboard-o"><i class="fa fa-keyboard-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-language"><i class="fa fa-language fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-laptop"><i class="fa fa-laptop fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-leaf"><i class="fa fa-leaf fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-gavel"><i class="fa fa-gavel fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-lemon-o"><i class="fa fa-lemon-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-level-down"><i class="fa fa-level-down fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-level-up"><i class="fa fa-level-up fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-life-bouy"><i class="fa fa-life-bouy fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-life-ring"><i class="fa fa-life-ring fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-life-saver"><i class="fa fa-life-saver fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-lightbulb-o"><i class="fa fa-lightbulb-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-location-arrow"><i class="fa fa-location-arrow fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-lock"><i class="fa fa-lock fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-magic"><i class="fa fa-magic fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-magnet"><i class="fa fa-magnet fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-share"><i class="fa fa-share fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-share-alt"><i class="fa fa-share-alt fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-share-alt-square"><i class="fa fa-share-alt-square fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-reply"><i class="fa fa-reply fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-mail-reply-all"><i class="fa fa-mail-reply-all fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-map-marker"><i class="fa fa-map-marker fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-meh-o"><i class="fa fa-meh-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-microphone"><i class="fa fa-microphone fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-microphone-slash"><i class="fa fa-microphone-slash fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-minus"><i class="fa fa-minus fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-minus-circle"><i class="fa fa-minus-circle fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-minus-square"><i class="fa fa-minus-square fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-mobile"><i class="fa fa-mobile fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-money"><i class="fa fa-money fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-moon-o"><i class="fa fa-moon-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-mortar-board"><i class="fa fa-mortar-board fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-arrows"><i class="fa fa-arrows fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-music"><i class="fa fa-music fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-navicon"><i class="fa fa-navicon fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-paper-plane"><i class="fa fa-paper-plane fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-paper-plane-o"><i class="fa fa-paper-plane-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-paw"><i class="fa fa-paw fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-power-off"><i class="fa fa-power-off fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-check"><i class="fa fa-check fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-check-circle-o"><i class="fa fa-check-circle-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-check-circle"><i class="fa fa-check-circle fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-pencil"><i class="fa fa-pencil fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-phone"><i class="fa fa-phone fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-phone-square"><i class="fa fa-phone-square fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-picture-o"><i class="fa fa-picture-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-plane"><i class="fa fa-plane fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-plus"><i class="fa fa-plus fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-plus-circle"><i class="fa fa-plus-circle fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-plus-square"><i class="fa fa-plus-square fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-power-off"><i class="fa fa-power-off fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-print"><i class="fa fa-print fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-thumb-tack"><i class="fa fa-thumb-tack fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-puzzle-piece"><i class="fa fa-puzzle-piece fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-qrcode"><i class="fa fa-qrcode fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-question"><i class="fa fa-question fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-question-circle"><i class="fa fa-question-circle fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-quote-left"><i class="fa fa-quote-left fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-quote-right"><i class="fa fa-quote-right fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-random"><i class="fa fa-random fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-recycle"><i class="fa fa-recycle fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-refresh"><i class="fa fa-refresh fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-times"><i class="fa fa-times fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-times-circle-o"><i class="fa fa-times-circle-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-times-circle"><i class="fa fa-times-circle fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-bars"><i class="fa fa-bars fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-reply"><i class="fa fa-reply fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-reply-all"><i class="fa fa-reply-all fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-arrows-h"><i class="fa fa-arrows-h fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-arrows-v"><i class="fa fa-arrows-v fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-retweet"><i class="fa fa-retweet fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-road"><i class="fa fa-road fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-rocket"><i class="fa fa-rocket fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-rss"><i class="fa fa-rss fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-rss-square"><i class="fa fa-rss-square fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-crosshairs"><i class="fa fa-crosshairs fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-cube"><i class="fa fa-cube fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-cubes"><i class="fa fa-cubes fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-search"><i class="fa fa-search fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-search-minus"><i class="fa fa-search-minus fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-search-plus"><i class="fa fa-search-plus fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-send"><i class="fa fa-send fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-send-o"><i class="fa fa-send-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-share-square-o"><i class="fa fa-share-square-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-share"><i class="fa fa-share fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-share-square"><i class="fa fa-share-square fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-shield"><i class="fa fa-shield fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-shopping-cart"><i class="fa fa-shopping-cart fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-square"><i class="fa fa-square fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-signal"><i class="fa fa-signal fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-sign-in"><i class="fa fa-sign-in fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-sign-out"><i class="fa fa-sign-out fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-sitemap"><i class="fa fa-sitemap fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-sliders"><i class="fa fa-sliders fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-smile-o"><i class="fa fa-smile-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-sort"><i class="fa fa-sort fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-sort-alpha-asc"><i class="fa fa-sort-alpha-asc fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-sort-alpha-desc"><i class="fa fa-sort-alpha-desc fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-sort-amount-asc"><i class="fa fa-sort-amount-asc fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-sort-amount-desc"><i class="fa fa-sort-amount-desc fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-sort-numeric-asc"><i class="fa fa-sort-numeric-asc fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-sort-numeric-desc"><i class="fa fa-sort-numeric-desc fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-sort-asc"><i class="fa fa-sort-asc fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-sort-desc"><i class="fa fa-sort-desc fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-spinner"><i class="fa fa-spinner fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-star"><i class="fa fa-star fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-star-o"><i class="fa fa-star-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-star-half"><i class="fa fa-star-half fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-star-half-o"><i class="fa fa-star-half-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-star-half-full"><i class="fa fa-star-half-full fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-subscript"><i class="fa fa-subscript fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-suitcase"><i class="fa fa-suitcase fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-sun-o"><i class="fa fa-sun-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-support"><i class="fa fa-support fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-superscript"><i class="fa fa-superscript fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-tablet"><i class="fa fa-tablet fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-tag"><i class="fa fa-tag fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-tags"><i class="fa fa-tags fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-tasks"><i class="fa fa-tasks fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-taxi"><i class="fa fa-taxi fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-terminal"><i class="fa fa-terminal fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-thumbs-down"><i class="fa fa-thumbs-down fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-thumbs-o-down"><i class="fa fa-thumbs-o-down fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-thumbs-up"><i class="fa fa-thumbs-up fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-thumbs-o-up"><i class="fa fa-thumbs-o-up fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-ticket"><i class="fa fa-ticket fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-clock-o"><i class="fa fa-clock-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-tint"><i class="fa fa-tint fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-trash-o"><i class="fa fa-trash-o fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-tree"><i class="fa fa-tree fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-trophy"><i class="fa fa-trophy fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-truck"><i class="fa fa-truck fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-umbrella"><i class="fa fa-umbrella fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-university"><i class="fa fa-university fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-unlock"><i class="fa fa-unlock fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-unlock-alt"><i class="fa fa-unlock-alt fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-arrow-circle-o-up"><i class="fa fa-arrow-circle-o-up fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-upload"><i class="fa fa-upload fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-user"><i class="fa fa-user fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-volume-down"><i class="fa fa-volume-down fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-volume-off"><i class="fa fa-volume-off fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-volume-up"><i class="fa fa-volume-up fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-exclamation-triangle"><i class="fa fa-exclamation-triangle fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-wrench"><i class="fa fa-wrench fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-adn"><i class="fa fa-adn fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-android"><i class="fa fa-android fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-apple"><i class="fa fa-apple fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-behance"><i class="fa fa-behance fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-behance-square"><i class="fa fa-behance-square fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-bitbucket"><i class="fa fa-bitbucket fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-bitbucket-square"><i class="fa fa-bitbucket-square fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-bitcoin"><i class="fa fa-bitcoin fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-btc"><i class="fa fa-btc fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-codepen"><i class="fa fa-codepen fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-css3"><i class="fa fa-css3 fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-delicious"><i class="fa fa-delicious fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-deviantart"><i class="fa fa-deviantart fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-digg"><i class="fa fa-digg fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-dribbble"><i class="fa fa-dribbble fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-dropbox"><i class="fa fa-dropbox fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-drupal"><i class="fa fa-drupal fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-empire"><i class="fa fa-empire fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-facebook"><i class="fa fa-facebook fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-facebook-square"><i class="fa fa-facebook-square fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-flickr"><i class="fa fa-flickr fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-foursquare"><i class="fa fa-foursquare fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-ge"><i class="fa fa-ge fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-git"><i class="fa fa-git fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-git-square"><i class="fa fa-git-square fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-github"><i class="fa fa-github fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-github-alt"><i class="fa fa-github-alt fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-github-square"><i class="fa fa-github-square fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-gittip"><i class="fa fa-gittip fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-google"><i class="fa fa-google fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-google-plus"><i class="fa fa-google-plus fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-google-plus-square"><i class="fa fa-google-plus-square fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-hacker-news"><i class="fa fa-hacker-news fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-html5"><i class="fa fa-html5 fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-instagram"><i class="fa fa-instagram fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-joomla"><i class="fa fa-joomla fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-jsfiddle"><i class="fa fa-jsfiddle fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-linkedin"><i class="fa fa-linkedin fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-linkedin-square"><i class="fa fa-linkedin-square fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-linux"><i class="fa fa-linux fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-maxcdn"><i class="fa fa-maxcdn fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-openid"><i class="fa fa-openid fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-pagelines"><i class="fa fa-pagelines fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-pied-piper"><i class="fa fa-pied-piper fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-pied-piper-alt"><i class="fa fa-pied-piper-alt fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-pied-piper-square"><i class="fa fa-pied-piper-square fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-pinterest"><i class="fa fa-pinterest fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-pinterest-square"><i class="fa fa-pinterest-square fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-qq"><i class="fa fa-qq fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-ra"><i class="fa fa-ra fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-rebel"><i class="fa fa-rebel fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-reddit"><i class="fa fa-reddit fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-reddit-square"><i class="fa fa-reddit-square fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-renren"><i class="fa fa-renren fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-skype"><i class="fa fa-skype fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-slack"><i class="fa fa-slack fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-soundcloud"><i class="fa fa-soundcloud fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-spotify"><i class="fa fa-spotify fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-stack-exchange"><i class="fa fa-stack-exchange fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-stack-overflow"><i class="fa fa-stack-overflow fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-steam"><i class="fa fa-steam fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-steam-square"><i class="fa fa-steam-square fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-stumbleupon"><i class="fa fa-stumbleupon fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-stumbleupon-circle"><i class="fa fa-stumbleupon-circle fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-tencent-weibo"><i class="fa fa-tencent-weibo fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-trello"><i class="fa fa-trello fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-tumblr"><i class="fa fa-tumblr fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-tumblr-square"><i class="fa fa-tumblr-square fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-twitter"><i class="fa fa-twitter fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-twitter-square"><i class="fa fa-twitter-square fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-vimeo-square"><i class="fa fa-vimeo-square fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-vk"><i class="fa fa-vk fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-wechat"><i class="fa fa-wechat fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-vine"><i class="fa fa-vine fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-weibo"><i class="fa fa-weibo fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-weixin"><i class="fa fa-weixin fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-windows"><i class="fa fa-windows fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-wordpress"><i class="fa fa-wordpress fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-xing"><i class="fa fa-xing fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-xing-square"><i class="fa fa-xing-square fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-yahoo"><i class="fa fa-yahoo fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-youtube"><i class="fa fa-youtube fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-youtube-play"><i class="fa fa-youtube-play fa-fw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="fa fa-youtube-square"><i class="fa fa-youtube-square fa-fw"></i></a>
                                        </div>
                                        <div class="Modules-list-icons tab-pane" id="example-tabs2-profile">
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-glass"><i class="gi gi-glass"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-leaf"><i class="gi gi-leaf"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-dog"><i class="gi gi-dog"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-user"><i class="gi gi-user"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-girl"><i class="gi gi-girl"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-car"><i class="gi gi-car"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-user_add"><i class="gi gi-user_add"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-user_remove"><i class="gi gi-user_remove"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-film"><i class="gi gi-film"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-magic"><i class="gi gi-magic"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-envelope"><i class="gi gi-envelope"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-camera"><i class="gi gi-camera"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-heart"><i class="gi gi-heart"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-beach_umbrella"><i class="gi gi-beach_umbrella"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-train"><i class="gi gi-train"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-print"><i class="gi gi-print"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-bin"><i class="gi gi-bin"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-music"><i class="gi gi-music"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-note"><i class="gi gi-note"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-heart_empty"><i class="gi gi-heart_empty"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-home"><i class="gi gi-home"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-snowflake"><i class="gi gi-snowflake"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-fire"><i class="gi gi-fire"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-magnet"><i class="gi gi-magnet"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-parents"><i class="gi gi-parents"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-binoculars"><i class="gi gi-binoculars"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-road"><i class="gi gi-road"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-search"><i class="gi gi-search"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-cars"><i class="gi gi-cars"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-notes_2"><i class="gi gi-notes_2"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-pencil"><i class="gi gi-pencil"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-bus"><i class="gi gi-bus"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-wifi_alt"><i class="gi gi-wifi_alt"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-luggage"><i class="gi gi-luggage"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-old_man"><i class="gi gi-old_man"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-woman"><i class="gi gi-woman"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-file"><i class="gi gi-file"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-coins"><i class="gi gi-coins"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-airplane"><i class="gi gi-airplane"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-notes"><i class="gi gi-notes"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-stats"><i class="gi gi-stats"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-charts"><i class="gi gi-charts"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-pie_chart"><i class="gi gi-pie_chart"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-group"><i class="gi gi-group"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-keys"><i class="gi gi-keys"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-calendar"><i class="gi gi-calendar"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-router"><i class="gi gi-router"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-camera_small"><i class="gi gi-camera_small"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-dislikes"><i class="gi gi-dislikes"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-star"><i class="gi gi-star"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-link"><i class="gi gi-link"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-eye_open"><i class="gi gi-eye_open"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-eye_close"><i class="gi gi-eye_close"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-alarm"><i class="gi gi-alarm"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-clock"><i class="gi gi-clock"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-stopwatch"><i class="gi gi-stopwatch"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-projector"><i class="gi gi-projector"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-history"><i class="gi gi-history"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-truck"><i class="gi gi-truck"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-cargo"><i class="gi gi-cargo"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-compass"><i class="gi gi-compass"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-keynote"><i class="gi gi-keynote"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-paperclip"><i class="gi gi-paperclip"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-power"><i class="gi gi-power"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-lightbulb"><i class="gi gi-lightbulb"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-tag"><i class="gi gi-tag"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-tags"><i class="gi gi-tags"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-cleaning"><i class="gi gi-cleaning"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-ruller"><i class="gi gi-ruller"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-gift"><i class="gi gi-gift"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-umbrella"><i class="gi gi-umbrella"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-book"><i class="gi gi-book"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-bookmark"><i class="gi gi-bookmark"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-wifi"><i class="gi gi-wifi"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-cup"><i class="gi gi-cup"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-stroller"><i class="gi gi-stroller"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-headphones"><i class="gi gi-headphones"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-headset"><i class="gi gi-headset"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-warning_sign"><i class="gi gi-warning_sign"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-signal"><i class="gi gi-signal"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-retweet"><i class="gi gi-retweet"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-refresh"><i class="gi gi-refresh"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-roundabout"><i class="gi gi-roundabout"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-random"><i class="gi gi-random"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-heat"><i class="gi gi-heat"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-repeat"><i class="gi gi-repeat"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-display"><i class="gi gi-display"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-log_book"><i class="gi gi-log_book"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-address_book"><i class="gi gi-address_book"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-building"><i class="gi gi-building"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-eyedropper"><i class="gi gi-eyedropper"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-adjust"><i class="gi gi-adjust"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-tint"><i class="gi gi-tint"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-crop"><i class="gi gi-crop"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-vector_path_square"><i class="gi gi-vector_path_square"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-vector_path_circle"><i class="gi gi-vector_path_circle"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-vector_path_polygon"><i class="gi gi-vector_path_polygon"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-vector_path_line"><i class="gi gi-vector_path_line"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-vector_path_curve"><i class="gi gi-vector_path_curve"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-vector_path_all"><i class="gi gi-vector_path_all"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-font"><i class="gi gi-font"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-italic"><i class="gi gi-italic"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-bold"><i class="gi gi-bold"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-text_underline"><i class="gi gi-text_underline"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-text_strike"><i class="gi gi-text_strike"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-text_height"><i class="gi gi-text_height"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-text_width"><i class="gi gi-text_width"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-text_resize"><i class="gi gi-text_resize"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-left_indent"><i class="gi gi-left_indent"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-right_indent"><i class="gi gi-right_indent"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-align_left"><i class="gi gi-align_left"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-align_center"><i class="gi gi-align_center"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-align_right"><i class="gi gi-align_right"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-justify"><i class="gi gi-justify"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-list"><i class="gi gi-list"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-text_smaller"><i class="gi gi-text_smaller"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-text_bigger"><i class="gi gi-text_bigger"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-embed"><i class="gi gi-embed"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-embed_close"><i class="gi gi-embed_close"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-table"><i class="gi gi-table"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-message_full"><i class="gi gi-message_full"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-message_empty"><i class="gi gi-message_empty"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-message_in"><i class="gi gi-message_in"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-message_out"><i class="gi gi-message_out"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-message_plus"><i class="gi gi-message_plus"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-message_minus"><i class="gi gi-message_minus"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-message_ban"><i class="gi gi-message_ban"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-message_flag"><i class="gi gi-message_flag"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-message_lock"><i class="gi gi-message_lock"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-message_new"><i class="gi gi-message_new"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-inbox"><i class="gi gi-inbox"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-inbox_plus"><i class="gi gi-inbox_plus"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-inbox_minus"><i class="gi gi-inbox_minus"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-inbox_lock"><i class="gi gi-inbox_lock"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-inbox_in"><i class="gi gi-inbox_in"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-inbox_out"><i class="gi gi-inbox_out"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-cogwheel"><i class="gi gi-cogwheel"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-cogwheels"><i class="gi gi-cogwheels"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-picture"><i class="gi gi-picture"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-adjust_alt"><i class="gi gi-adjust_alt"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-database_lock"><i class="gi gi-database_lock"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-database_plus"><i class="gi gi-database_plus"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-database_minus"><i class="gi gi-database_minus"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-database_ban"><i class="gi gi-database_ban"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-folder_open"><i class="gi gi-folder_open"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-folder_plus"><i class="gi gi-folder_plus"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-folder_minus"><i class="gi gi-folder_minus"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-folder_lock"><i class="gi gi-folder_lock"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-folder_flag"><i class="gi gi-folder_flag"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-folder_new"><i class="gi gi-folder_new"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-edit"><i class="gi gi-edit"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-new_window"><i class="gi gi-new_window"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-check"><i class="gi gi-check"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-unchecked"><i class="gi gi-unchecked"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-more_windows"><i class="gi gi-more_windows"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-show_big_thumbnails"><i class="gi gi-show_big_thumbnails"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-show_thumbnails"><i class="gi gi-show_thumbnails"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-show_thumbnails_with_lines"><i class="gi gi-show_thumbnails_with_lines"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-show_lines"><i class="gi gi-show_lines"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-playlist"><i class="gi gi-playlist"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-imac"><i class="gi gi-imac"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-macbook"><i class="gi gi-macbook"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-ipad"><i class="gi gi-ipad"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-iphone"><i class="gi gi-iphone"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-iphone_transfer"><i class="gi gi-iphone_transfer"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-iphone_exchange"><i class="gi gi-iphone_exchange"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-ipod"><i class="gi gi-ipod"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-ipod_shuffle"><i class="gi gi-ipod_shuffle"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-ear_plugs"><i class="gi gi-ear_plugs"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-record"><i class="gi gi-record"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-step_backward"><i class="gi gi-step_backward"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-fast_backward"><i class="gi gi-fast_backward"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-rewind"><i class="gi gi-rewind"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-play"><i class="gi gi-play"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-pause"><i class="gi gi-pause"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-stop"><i class="gi gi-stop"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-forward"><i class="gi gi-forward"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-fast_forward"><i class="gi gi-fast_forward"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-step_forward"><i class="gi gi-step_forward"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-eject"><i class="gi gi-eject"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-facetime_video"><i class="gi gi-facetime_video"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-download_alt"><i class="gi gi-download_alt"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-mute"><i class="gi gi-mute"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-volume_down"><i class="gi gi-volume_down"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-volume_up"><i class="gi gi-volume_up"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-screenshot"><i class="gi gi-screenshot"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-move"><i class="gi gi-move"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-more"><i class="gi gi-more"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-brightness_reduce"><i class="gi gi-brightness_reduce"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-brightness_increase"><i class="gi gi-brightness_increase"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-circle_plus"><i class="gi gi-circle_plus"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-circle_minus"><i class="gi gi-circle_minus"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-circle_remove"><i class="gi gi-circle_remove"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-circle_ok"><i class="gi gi-circle_ok"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-circle_question_mark"><i class="gi gi-circle_question_mark"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-circle_info"><i class="gi gi-circle_info"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-circle_exclamation_mark"><i class="gi gi-circle_exclamation_mark"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-remove"><i class="gi gi-remove"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-ok"><i class="gi gi-ok"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-ban"><i class="gi gi-ban"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-download"><i class="gi gi-download"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-upload"><i class="gi gi-upload"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-shopping_cart"><i class="gi gi-shopping_cart"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-lock"><i class="gi gi-lock"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-unlock"><i class="gi gi-unlock"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-electricity"><i class="gi gi-electricity"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-ok_2"><i class="gi gi-ok_2"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-remove_2"><i class="gi gi-remove_2"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-cart_out"><i class="gi gi-cart_out"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-cart_in"><i class="gi gi-cart_in"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-left_arrow"><i class="gi gi-left_arrow"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-right_arrow"><i class="gi gi-right_arrow"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-down_arrow"><i class="gi gi-down_arrow"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-up_arrow"><i class="gi gi-up_arrow"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-resize_small"><i class="gi gi-resize_small"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-resize_full"><i class="gi gi-resize_full"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-circle_arrow_left"><i class="gi gi-circle_arrow_left"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-circle_arrow_right"><i class="gi gi-circle_arrow_right"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-circle_arrow_top"><i class="gi gi-circle_arrow_top"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-circle_arrow_down"><i class="gi gi-circle_arrow_down"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-play_button"><i class="gi gi-play_button"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-unshare"><i class="gi gi-unshare"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-share"><i class="gi gi-share"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-chevron-right"><i class="gi gi-chevron-right"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-chevron-left"><i class="gi gi-chevron-left"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-bluetooth"><i class="gi gi-bluetooth"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-euro"><i class="gi gi-euro"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-usd"><i class="gi gi-usd"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-gbp"><i class="gi gi-gbp"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-retweet_2"><i class="gi gi-retweet_2"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-moon"><i class="gi gi-moon"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-sun"><i class="gi gi-sun"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-cloud"><i class="gi gi-cloud"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-direction"><i class="gi gi-direction"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-brush"><i class="gi gi-brush"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-pen"><i class="gi gi-pen"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-zoom_in"><i class="gi gi-zoom_in"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-zoom_out"><i class="gi gi-zoom_out"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-pin"><i class="gi gi-pin"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-albums"><i class="gi gi-albums"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-rotation_lock"><i class="gi gi-rotation_lock"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-flash"><i class="gi gi-flash"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-google_maps"><i class="gi gi-google_maps"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-anchor"><i class="gi gi-anchor"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-conversation"><i class="gi gi-conversation"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-chat"><i class="gi gi-chat"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-male"><i class="gi gi-male"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-female"><i class="gi gi-female"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-asterisk"><i class="gi gi-asterisk"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-divide"><i class="gi gi-divide"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-snorkel_diving"><i class="gi gi-snorkel_diving"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-scuba_diving"><i class="gi gi-scuba_diving"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-oxygen_bottle"><i class="gi gi-oxygen_bottle"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-fins"><i class="gi gi-fins"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-fishes"><i class="gi gi-fishes"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-boat"><i class="gi gi-boat"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-delete"><i class="gi gi-delete"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-sheriffs_star"><i class="gi gi-sheriffs_star"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-qrcode"><i class="gi gi-qrcode"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-barcode"><i class="gi gi-barcode"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-pool"><i class="gi gi-pool"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-buoy"><i class="gi gi-buoy"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-spade"><i class="gi gi-spade"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-bank"><i class="gi gi-bank"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-vcard"><i class="gi gi-vcard"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-electrical_plug"><i class="gi gi-electrical_plug"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-flag"><i class="gi gi-flag"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-credit_card"><i class="gi gi-credit_card"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-keyboard-wireless"><i class="gi gi-keyboard-wireless"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-keyboard-wired"><i class="gi gi-keyboard-wired"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-shield"><i class="gi gi-shield"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-ring"><i class="gi gi-ring"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-cake"><i class="gi gi-cake"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-drink"><i class="gi gi-drink"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-beer"><i class="gi gi-beer"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-fast_food"><i class="gi gi-fast_food"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-cutlery"><i class="gi gi-cutlery"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-pizza"><i class="gi gi-pizza"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-birthday_cake"><i class="gi gi-birthday_cake"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-tablet"><i class="gi gi-tablet"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-settings"><i class="gi gi-settings"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-bullets"><i class="gi gi-bullets"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-cardio"><i class="gi gi-cardio"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-t-shirt"><i class="gi gi-t-shirt"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-pants"><i class="gi gi-pants"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-sweater"><i class="gi gi-sweater"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-fabric"><i class="gi gi-fabric"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-leather"><i class="gi gi-leather"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-scissors"><i class="gi gi-scissors"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-bomb"><i class="gi gi-bomb"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-skull"><i class="gi gi-skull"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-celebration"><i class="gi gi-celebration"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-tea_kettle"><i class="gi gi-tea_kettle"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-french_press"><i class="gi gi-french_press"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-coffee_cup"><i class="gi gi-coffee_cup"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-pot"><i class="gi gi-pot"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-grater"><i class="gi gi-grater"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-kettle"><i class="gi gi-kettle"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-hospital"><i class="gi gi-hospital"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-hospital_h"><i class="gi gi-hospital_h"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-microphone"><i class="gi gi-microphone"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-webcam"><i class="gi gi-webcam"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-temple_christianity_church"><i class="gi gi-temple_christianity_church"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-temple_islam"><i class="gi gi-temple_islam"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-temple_hindu"><i class="gi gi-temple_hindu"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-temple_buddhist"><i class="gi gi-temple_buddhist"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-bicycle"><i class="gi gi-bicycle"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-life_preserver"><i class="gi gi-life_preserver"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-share_alt"><i class="gi gi-share_alt"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-comments"><i class="gi gi-comments"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-flower"><i class="gi gi-flower"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-baseball"><i class="gi gi-baseball"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-rugby"><i class="gi gi-rugby"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-ax"><i class="gi gi-ax"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-table_tennis"><i class="gi gi-table_tennis"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-bowling"><i class="gi gi-bowling"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-tree_conifer"><i class="gi gi-tree_conifer"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-tree_deciduous"><i class="gi gi-tree_deciduous"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-more_items"><i class="gi gi-more_items"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-sort"><i class="gi gi-sort"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-filter"><i class="gi gi-filter"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-gamepad"><i class="gi gi-gamepad"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-playing_dices"><i class="gi gi-playing_dices"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-calculator"><i class="gi gi-calculator"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-tie"><i class="gi gi-tie"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-wallet"><i class="gi gi-wallet"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-piano"><i class="gi gi-piano"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-sampler"><i class="gi gi-sampler"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-podium"><i class="gi gi-podium"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-soccer_ball"><i class="gi gi-soccer_ball"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-blog"><i class="gi gi-blog"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-dashboard"><i class="gi gi-dashboard"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-certificate"><i class="gi gi-certificate"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-bell"><i class="gi gi-bell"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-candle"><i class="gi gi-candle"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-pushpin"><i class="gi gi-pushpin"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-iphone_shake"><i class="gi gi-iphone_shake"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-pin_flag"><i class="gi gi-pin_flag"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-turtle"><i class="gi gi-turtle"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-rabbit"><i class="gi gi-rabbit"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-globe"><i class="gi gi-globe"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-briefcase"><i class="gi gi-briefcase"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-hdd"><i class="gi gi-hdd"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-thumbs_up"><i class="gi gi-thumbs_up"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-thumbs_down"><i class="gi gi-thumbs_down"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-hand_right"><i class="gi gi-hand_right"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-hand_left"><i class="gi gi-hand_left"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-hand_up"><i class="gi gi-hand_up"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-hand_down"><i class="gi gi-hand_down"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-fullscreen"><i class="gi gi-fullscreen"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-shopping_bag"><i class="gi gi-shopping_bag"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-book_open"><i class="gi gi-book_open"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-nameplate"><i class="gi gi-nameplate"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-nameplate_alt"><i class="gi gi-nameplate_alt"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-vases"><i class="gi gi-vases"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-bullhorn"><i class="gi gi-bullhorn"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-dumbbell"><i class="gi gi-dumbbell"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-suitcase"><i class="gi gi-suitcase"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-file_import"><i class="gi gi-file_import"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-file_export"><i class="gi gi-file_export"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-bug"><i class="gi gi-bug"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-crown"><i class="gi gi-crown"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-smoking"><i class="gi gi-smoking"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-cloud-upload"><i class="gi gi-cloud-upload"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-cloud-download"><i class="gi gi-cloud-download"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-restart"><i class="gi gi-restart"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-security_camera"><i class="gi gi-security_camera"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-expand"><i class="gi gi-expand"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-collapse"><i class="gi gi-collapse"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-collapse_top"><i class="gi gi-collapse_top"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-globe_af"><i class="gi gi-globe_af"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-global"><i class="gi gi-global"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-spray"><i class="gi gi-spray"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-nails"><i class="gi gi-nails"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-claw_hammer"><i class="gi gi-claw_hammer"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-classic_hammer"><i class="gi gi-classic_hammer"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-hand_saw"><i class="gi gi-hand_saw"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-riflescope"><i class="gi gi-riflescope"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-electrical_socket_eu"><i class="gi gi-electrical_socket_eu"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-electrical_socket_us"><i class="gi gi-electrical_socket_us"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-message_forward"><i class="gi gi-message_forward"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-coat_hanger"><i class="gi gi-coat_hanger"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-dress"><i class="gi gi-dress"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-bathrobe"><i class="gi gi-bathrobe"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-shirt"><i class="gi gi-shirt"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-underwear"><i class="gi gi-underwear"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-log_in"><i class="gi gi-log_in"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-log_out"><i class="gi gi-log_out"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-exit"><i class="gi gi-exit"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-new_window_alt"><i class="gi gi-new_window_alt"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-video_sd"><i class="gi gi-video_sd"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-video_hd"><i class="gi gi-video_hd"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-subtitles"><i class="gi gi-subtitles"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-sound_stereo"><i class="gi gi-sound_stereo"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-sound_dolby"><i class="gi gi-sound_dolby"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-sound_5_1"><i class="gi gi-sound_5_1"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-sound_6_1"><i class="gi gi-sound_6_1"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-sound_7_1"><i class="gi gi-sound_7_1"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-copyright_mark"><i class="gi gi-copyright_mark"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-registration_mark"><i class="gi gi-registration_mark"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-radar"><i class="gi gi-radar"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-skateboard"><i class="gi gi-skateboard"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-golf_course"><i class="gi gi-golf_course"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-sorting"><i class="gi gi-sorting"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-sort-by-alphabet"><i class="gi gi-sort-by-alphabet"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-sort-by-alphabet-alt"><i class="gi gi-sort-by-alphabet-alt"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-sort-by-order"><i class="gi gi-sort-by-order"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-sort-by-order-alt"><i class="gi gi-sort-by-order-alt"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-sort-by-attributes"><i class="gi gi-sort-by-attributes"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-sort-by-attributes-alt"><i class="gi gi-sort-by-attributes-alt"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-compressed"><i class="gi gi-compressed"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-package"><i class="gi gi-package"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-cloud_plus"><i class="gi gi-cloud_plus"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-cloud_minus"><i class="gi gi-cloud_minus"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-disk_save"><i class="gi gi-disk_save"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-disk_open"><i class="gi gi-disk_open"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-disk_saved"><i class="gi gi-disk_saved"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-disk_remove"><i class="gi gi-disk_remove"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-disk_import"><i class="gi gi-disk_import"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-disk_export"><i class="gi gi-disk_export"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-tower"><i class="gi gi-tower"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-send"><i class="gi gi-send"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-git_branch"><i class="gi gi-git_branch"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-git_create"><i class="gi gi-git_create"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-git_private"><i class="gi gi-git_private"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-git_delete"><i class="gi gi-git_delete"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-git_merge"><i class="gi gi-git_merge"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-git_pull_request"><i class="gi gi-git_pull_request"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-git_compare"><i class="gi gi-git_compare"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-git_commit"><i class="gi gi-git_commit"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-construction_cone"><i class="gi gi-construction_cone"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-shoe_steps"><i class="gi gi-shoe_steps"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-plus"><i class="gi gi-plus"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-minus"><i class="gi gi-minus"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-redo"><i class="gi gi-redo"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-undo"><i class="gi gi-undo"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-golf"><i class="gi gi-golf"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-hockey"><i class="gi gi-hockey"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-pipe"><i class="gi gi-pipe"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-wrench"><i class="gi gi-wrench"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-folder_closed"><i class="gi gi-folder_closed"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-phone_alt"><i class="gi gi-phone_alt"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-earphone"><i class="gi gi-earphone"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-floppy_disk"><i class="gi gi-floppy_disk"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-floppy_saved"><i class="gi gi-floppy_saved"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-floppy_remove"><i class="gi gi-floppy_remove"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-floppy_save"><i class="gi gi-floppy_save"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-floppy_open"><i class="gi gi-floppy_open"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-translate"><i class="gi gi-translate"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-fax"><i class="gi gi-fax"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-factory"><i class="gi gi-factory"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-shop_window"><i class="gi gi-shop_window"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-shop"><i class="gi gi-shop"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-kiosk"><i class="gi gi-kiosk"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-kiosk_wheels"><i class="gi gi-kiosk_wheels"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-kiosk_light"><i class="gi gi-kiosk_light"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-kiosk_food"><i class="gi gi-kiosk_food"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-transfer"><i class="gi gi-transfer"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-money"><i class="gi gi-money"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-header"><i class="gi gi-header"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-blacksmith"><i class="gi gi-blacksmith"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-saw_blade"><i class="gi gi-saw_blade"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-basketball"><i class="gi gi-basketball"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-server"><i class="gi gi-server"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-server_plus"><i class="gi gi-server_plus"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-server_minus"><i class="gi gi-server_minus"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-server_ban"><i class="gi gi-server_ban"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-server_flag"><i class="gi gi-server_flag"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-server_lock"><i class="gi gi-server_lock"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="gi gi-server_new"><i class="gi gi-server_new"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-glass"><i class="hi hi-glass"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-music"><i class="hi hi-music"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-search"><i class="hi hi-search"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-envelope"><i class="hi hi-envelope"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-heart"><i class="hi hi-heart"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-star"><i class="hi hi-star"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-star-empty"><i class="hi hi-star-empty"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-user"><i class="hi hi-user"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-film"><i class="hi hi-film"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-th-large"><i class="hi hi-th-large"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-th"><i class="hi hi-th"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-th-list"><i class="hi hi-th-list"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-ok"><i class="hi hi-ok"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-remove"><i class="hi hi-remove"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-zoom-in"><i class="hi hi-zoom-in"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-zoom-out"><i class="hi hi-zoom-out"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-off"><i class="hi hi-off"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-signal"><i class="hi hi-signal"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-cog"><i class="hi hi-cog"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-trash"><i class="hi hi-trash"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-home"><i class="hi hi-home"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-file"><i class="hi hi-file"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-time"><i class="hi hi-time"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-road"><i class="hi hi-road"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-download-alt"><i class="hi hi-download-alt"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-download"><i class="hi hi-download"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-upload"><i class="hi hi-upload"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-inbox"><i class="hi hi-inbox"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-play-circle"><i class="hi hi-play-circle"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-repeat"><i class="hi hi-repeat"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-refresh"><i class="hi hi-refresh"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-list-alt"><i class="hi hi-list-alt"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-lock"><i class="hi hi-lock"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-flag"><i class="hi hi-flag"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-headphones"><i class="hi hi-headphones"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-volume-off"><i class="hi hi-volume-off"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-volume-down"><i class="hi hi-volume-down"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-volume-up"><i class="hi hi-volume-up"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-qrcode"><i class="hi hi-qrcode"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-barcode"><i class="hi hi-barcode"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-tag"><i class="hi hi-tag"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-tags"><i class="hi hi-tags"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-book"><i class="hi hi-book"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-bookmark"><i class="hi hi-bookmark"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-print"><i class="hi hi-print"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-camera"><i class="hi hi-camera"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-font"><i class="hi hi-font"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-bold"><i class="hi hi-bold"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-italic"><i class="hi hi-italic"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-text-height"><i class="hi hi-text-height"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-text-width"><i class="hi hi-text-width"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-align-left"><i class="hi hi-align-left"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-align-center"><i class="hi hi-align-center"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-align-right"><i class="hi hi-align-right"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-align-justify"><i class="hi hi-align-justify"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-list"><i class="hi hi-list"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-indent-left"><i class="hi hi-indent-left"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-indent-right"><i class="hi hi-indent-right"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-facetime-video"><i class="hi hi-facetime-video"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-picture"><i class="hi hi-picture"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-pencil"><i class="hi hi-pencil"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-map-marker"><i class="hi hi-map-marker"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-adjust"><i class="hi hi-adjust"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-tint"><i class="hi hi-tint"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-edit"><i class="hi hi-edit"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-share"><i class="hi hi-share"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-check"><i class="hi hi-check"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-move"><i class="hi hi-move"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-step-backward"><i class="hi hi-step-backward"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-fast-backward"><i class="hi hi-fast-backward"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-backward"><i class="hi hi-backward"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-play"><i class="hi hi-play"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-pause"><i class="hi hi-pause"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-stop"><i class="hi hi-stop"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-forward"><i class="hi hi-forward"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-fast-forward"><i class="hi hi-fast-forward"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-step-forward"><i class="hi hi-step-forward"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-eject"><i class="hi hi-eject"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-chevron-left"><i class="hi hi-chevron-left"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-chevron-right"><i class="hi hi-chevron-right"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-plus-sign"><i class="hi hi-plus-sign"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-minus-sign"><i class="hi hi-minus-sign"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-remove-sign"><i class="hi hi-remove-sign"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-ok-sign"><i class="hi hi-ok-sign"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-question-sign"><i class="hi hi-question-sign"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-info-sign"><i class="hi hi-info-sign"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-screenshot"><i class="hi hi-screenshot"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-remove-circle"><i class="hi hi-remove-circle"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-ok-circle"><i class="hi hi-ok-circle"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-ban-circle"><i class="hi hi-ban-circle"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-arrow-left"><i class="hi hi-arrow-left"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-arrow-right"><i class="hi hi-arrow-right"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-arrow-up"><i class="hi hi-arrow-up"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-arrow-down"><i class="hi hi-arrow-down"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-share-alt"><i class="hi hi-share-alt"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-resize-full"><i class="hi hi-resize-full"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-resize-small"><i class="hi hi-resize-small"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-plus"><i class="hi hi-plus"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-minus"><i class="hi hi-minus"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-asterisk"><i class="hi hi-asterisk"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-exclamation-sign"><i class="hi hi-exclamation-sign"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-gift"><i class="hi hi-gift"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-leaf"><i class="hi hi-leaf"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-fire"><i class="hi hi-fire"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-eye-open"><i class="hi hi-eye-open"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-eye-close"><i class="hi hi-eye-close"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-warning-sign"><i class="hi hi-warning-sign"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-plane"><i class="hi hi-plane"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-calendar"><i class="hi hi-calendar"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-random"><i class="hi hi-random"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-comments"><i class="hi hi-comments"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-magnet"><i class="hi hi-magnet"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-chevron-up"><i class="hi hi-chevron-up"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-chevron-down"><i class="hi hi-chevron-down"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-retweet"><i class="hi hi-retweet"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-shopping-cart"><i class="hi hi-shopping-cart"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-folder-close"><i class="hi hi-folder-close"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-folder-open"><i class="hi hi-folder-open"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-resize-vertical"><i class="hi hi-resize-vertical"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-resize-horizontal"><i class="hi hi-resize-horizontal"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-hdd"><i class="hi hi-hdd"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-bullhorn"><i class="hi hi-bullhorn"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-bell"><i class="hi hi-bell"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-certificate"><i class="hi hi-certificate"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-thumbs-up"><i class="hi hi-thumbs-up"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-thumbs-down"><i class="hi hi-thumbs-down"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-hand-right"><i class="hi hi-hand-right"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-hand-left"><i class="hi hi-hand-left"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-hand-top"><i class="hi hi-hand-top"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-hand-down"><i class="hi hi-hand-down"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-circle-arrow-right"><i class="hi hi-circle-arrow-right"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-circle-arrow-left"><i class="hi hi-circle-arrow-left"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-circle-arrow-top"><i class="hi hi-circle-arrow-top"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-circle-arrow-down"><i class="hi hi-circle-arrow-down"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-globe"><i class="hi hi-globe"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-wrench"><i class="hi hi-wrench"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-tasks"><i class="hi hi-tasks"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-filter"><i class="hi hi-filter"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-briefcase"><i class="hi hi-briefcase"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-fullscreen"><i class="hi hi-fullscreen"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-dashboard"><i class="hi hi-dashboard"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-paperclip"><i class="hi hi-paperclip"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-heart-empty"><i class="hi hi-heart-empty"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-link"><i class="hi hi-link"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-phone"><i class="hi hi-phone"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-pushpin"><i class="hi hi-pushpin"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-euro"><i class="hi hi-euro"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-usd"><i class="hi hi-usd"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-gbp"><i class="hi hi-gbp"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-sort"><i class="hi hi-sort"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-sort-by-alphabet"><i class="hi hi-sort-by-alphabet"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-sort-by-alphabet-alt"><i class="hi hi-sort-by-alphabet-alt"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-sort-by-order"><i class="hi hi-sort-by-order"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-sort-by-order-alt"><i class="hi hi-sort-by-order-alt"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-sort-by-attributes"><i class="hi hi-sort-by-attributes"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-sort-by-attributes-alt"><i class="hi hi-sort-by-attributes-alt"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-unchecked"><i class="hi hi-unchecked"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-expand"><i class="hi hi-expand"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-collapse"><i class="hi hi-collapse"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-collapse-top"><i class="hi hi-collapse-top"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-log_in"><i class="hi hi-log_in"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-flash"><i class="hi hi-flash"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-log_out"><i class="hi hi-log_out"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-new_window"><i class="hi hi-new_window"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-record"><i class="hi hi-record"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-save"><i class="hi hi-save"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-open"><i class="hi hi-open"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-saved"><i class="hi hi-saved"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-import"><i class="hi hi-import"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-export"><i class="hi hi-export"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-send"><i class="hi hi-send"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-floppy_disk"><i class="hi hi-floppy_disk"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-floppy_saved"><i class="hi hi-floppy_saved"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-floppy_remove"><i class="hi hi-floppy_remove"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-floppy_save"><i class="hi hi-floppy_save"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-floppy_open"><i class="hi hi-floppy_open"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-credit_card"><i class="hi hi-credit_card"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-transfer"><i class="hi hi-transfer"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-cutlery"><i class="hi hi-cutlery"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-header"><i class="hi hi-header"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-compressed"><i class="hi hi-compressed"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-earphone"><i class="hi hi-earphone"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-phone_alt"><i class="hi hi-phone_alt"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-tower"><i class="hi hi-tower"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-stats"><i class="hi hi-stats"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-sd_video"><i class="hi hi-sd_video"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-hd_video"><i class="hi hi-hd_video"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-subtitles"><i class="hi hi-subtitles"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-sound_stereo"><i class="hi hi-sound_stereo"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-sound_dolby"><i class="hi hi-sound_dolby"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-sound_5_1"><i class="hi hi-sound_5_1"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-sound_6_1"><i class="hi hi-sound_6_1"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-sound_7_1"><i class="hi hi-sound_7_1"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-copyright_mark"><i class="hi hi-copyright_mark"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-registration_mark"><i class="hi hi-registration_mark"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-cloud"><i class="hi hi-cloud"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-cloud_download"><i class="hi hi-cloud_download"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-cloud_upload"><i class="hi hi-cloud_upload"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-tree_conifer"><i class="hi hi-tree_conifer"></i></a>
                                            <a onclick="sysmodule.selectIcon(this);" class="btn btn-sm btn-alt btn-default" data-toggle="tooltip" title="" data-original-title="hi hi-tree_deciduous"><i class="hi hi-tree_deciduous"></i></a>
                                        </div>
                                    </div>
                                    <!-- END Tabs Content -->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="divModalAlert" class="form-group" style="display: none;">
                        <div class="col-md-3">
                        </div>
                        <div id="divModalAlert-content" class="col-md-9">
                            <div class="alert alert-danger alert-dismissable">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                <h4><i class="fa fa-times-circle"></i>Error</h4>
                                Oh no! Update <a href="javascript:void(0)" class="alert-link">failed</a>!
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <div class="modal-footer">
                <a id="btn-modal-add-close" class="btn btn-sm btn-default" data-dismiss="modal">Hủy</a>
                <a id="btn-do-save" onclick="sysmodule.doAdd();" class="btn btn-sm btn-primary">Lưu</a>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var sysmodule =
        {
            ajaxPath: '/ajax/modules/systems/sysmodules.aspx',
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
            all: null,
            init: function () {
                sysmodule.loadlist();
                sysmodule.all = null;
                sysmodule.mode = 'create';
            },

            loadlist: function () {
                NProgress.start();

                $.post(sysmodule.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': "loadlist" },
                                function (data) {
                                    NProgress.done();
                                    var result = JSON.parse(data);

                                    var html =
                                        "<table class=\"table table-vcenter table-striped table-condensed table-hover table-bordered\">" +
                                            "<thead>" +
                                                "<tr>" +
                                                    "<th class=\"text-center\"><i class=\"gi gi-picture\"></i></th>" +
                                                    "<th class=\"text-center\">Tên</th>" +
                                                    "<th class=\"text-center\">Alias</th>" +
                                                    "<th class=\"text-center\">Path</th>" +
                                                    "<th class=\"text-center\">Tính năng</th>" +
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
                                        sysmodule.all = JSON.parse(result.Data);
                                        for (var i = 0; i < sysmodule.all.length; i++) {
                                            var obj = sysmodule.all[i];
                                            var levelSep = "";
                                            for (var j = 0; j < obj.Level; j++)
                                                levelSep += "---";

                                            html +=
                                                "<tr>" +
                                                    "<td class=\"text-center\">" +
                                                        "<i class=\"" + obj.IconClass + "\"></i>" +
                                                    "</td>" +
                                                    "<td>" + levelSep + " " + obj.Name + "</td>" +
                                                    "<td class=\"text-center\">" + obj.Alias + "</td>" +
                                                    "<td>" + obj.Path + "</td>" +
                                                    "<td class=\"text-center\">" +
                                                        //"<div class=\"btn-group\">" +
                                                            "<a onclick=\"sysmodule.startedit('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Sửa\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-pencil\"></i></a>" +
                                                            "<a onclick=\"sysmodule.startdelete('" + obj.ID + "');\" href=\"javascript:void(0)\" data-toggle=\"tooltip\" title=\"Xóa\" class=\"btn btn-xs btn-danger\"><i class=\"fa fa-times\"></i></a>" +
                                                        //"</div>" +
                                                    "</td>" +
                                                "</tr>";
                                        }
                                    }

                                    html += "</tbody></table>";

                                    $('#divTableList').html(html);

                                    $('[data-toggle="tooltip"]').tooltip();
                                });
            },

            reloadpage: function () {
                location.href = "/sysmodules";
            },

            //------------------------------------------------------------

            currentobj: null,
            startdelete: function (id) {
                sysmodule.currentobj = sysmodule.geteSys_Module(id);
                if (sysmodule.currentobj == null) {
                    alert('Không tìm thấy Chức năng!');
                    return;
                }

                $('#modal-delete #bDeleteName').html(sysmodule.currentobj.Title);
                $('#modal-delete').modal('show');
            },

            dodelete: function () {
                NProgress.start();
                $('#btn-do-delete').addClass('disabled');
                $('#btn-modal-delete-close').addClass('disabled');
                $('#btn-do-delete').html('Đang xử lý...');

                $.post(sysmodule.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': 'delete', 'id': sysmodule.currentobj.ID },
                                function (data) {
                                    NProgress.done();

                                    var result = JSON.parse(data);
                                    $('#btn-do-delete').removeClass('disabled');
                                    $('#btn-modal-delete-close').removeClass('disabled');
                                    $('#btn-do-delete').html('Xóa');
                                    alert(result.Message);

                                    if (result.ErrorCode == 0)
                                        sysmodule.reloadpage();
                                });
            },

            startedit: function (id) {
                sysmodule.mode = 'edit';
                sysmodule.currentobj = sysmodule.geteSys_Module(id);
                if (sysmodule.currentobj == null) {
                    alert('Không tìm thấy Chức năng!');
                    return;
                }

                $('#modal-info #info-name').val(sysmodule.currentobj.Name);
                $('#modal-info #info-description').val(sysmodule.currentobj.Description);
                $('#modal-info #info-parent').val(sysmodule.currentobj.ParentID);
                $('#modal-info #info-alias').val(sysmodule.currentobj.Alias);
                $('#modal-info #info-path').val(sysmodule.currentobj.Path);
                $('#modal-info #info-showinmenu').prop('checked', sysmodule.currentobj.ShowInMenu);
                $('#modal-info #info-icon').html('<i class="' + sysmodule.currentobj.IconClass + '"></i>&nbsp;[' + sysmodule.currentobj.IconClass + ']');

                sysmodule.clearactions();

                $('#<% = divModuleActions.ClientID %> .chosen-container').remove();
                var html = "<select id=\"dllActions\" name=\"dllActions\" class=\"select-chosen form-control\" data-placeholder=\"Các tính năng trong Chức năng...\" multiple=\"\" style=\"display: none;\">";

                var currentActions = sysmodule.currentobj.Actions;
                var actions = $('#dllActions').find('option');
                for (var i = 0; i < actions.length; i++) {
                    var value = $(actions[i]).val();
                    var hasAction = currentActions.indexOf('@' + value + ';') >= 0; //Có actions này
                    html += "<option " + (hasAction ? "selected" : "") + " value=\"" + $(actions[i]).val() + "\">" + $(actions[i]).html() + "</option>";
                }
                html += "</select>";

                $('#<% = divModuleActions.ClientID %>').html(html);
                $('#dllActions').chosen({ width: '100%' });

                $('#modal-info .modal-header .modal-title').html('Cập nhật Chức năng hệ thống');
                $('#btn-do-save').html('Lưu');
                $('#modal-info').modal('show');


            },

            clearactions: function () {
                $('#dllActions').find('option').removeAttr('selected');
            },

            geteSys_Module: function (id) {
                if (sysmodule.all == null) return null;
                for (var i = 0; i < sysmodule.all.length; i++)
                    if (sysmodule.all[i].ID == id) return sysmodule.all[i];

                return null;
            },

            startAdd: function () {
                sysmodule.mode = 'create';
                sysmodule.clearactions();
                $('#modal-info .modal-header .modal-title').html('Thêm mới Chức năng hệ thống');
                $('#btn-do-save').html('Thêm');
                $('#modal-info').modal('show');
            },

            doAdd: function () {
                var postdata = sysmodule.validateForm();
                if (postdata == null)
                    return;

                NProgress.start();
                $('#btn-do-save').addClass('disabled');
                $('#btn-modal-add-close').addClass('disabled');
                $('#btn-do-save').html('Đang xử lý...');

                $.post(sysmodule.ajaxPath + '?ts=' + new Date().getTime().toString(),
                    { 'mod': sysmodule.mode, 'data': JSON.stringify(postdata) },
                                function (data) {
                                    NProgress.done();

                                    var result = JSON.parse(data);
                                    $('#btn-do-save').removeClass('disabled');
                                    $('#btn-modal-add-close').removeClass('disabled');
                                    $('#btn-do-save').html(sysmodule.mode == 'create' ? 'Thêm' : 'Lưu');
                                    alert(result.Message);

                                    if (result.ErrorCode == 0)
                                        sysmodule.reloadpage();
                                });
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

                data.parent = Number($('#modal-info #info-parent').val());

                data.alias = $('#modal-info #info-alias').val();
                if (data.alias == '')
                    message += '- Alias không hợp lệ!<br/>';

                data.path = $('#modal-info #info-path').val();
                if (data.path == '')
                    message += '- Path không hợp lệ!<br/>';

                data.actions = sysmodule.getSelectedActions();
                if (data.actions == '')
                    message += '- Phải có ít nhất 1 Tính năng!<br/>';

                data.showinmenu = $('#modal-info #info-showinmenu').prop('checked');

                var icon = $('#modal-info #info-icon').html();
                if (icon == 'Chọn ...')
                    message += '- Icon không hợp lệ!<br/>';

                data.icon = $('#modal-info #info-icon i').attr('class');

                data.id = sysmodule.mode == "create" ? 0 : sysmodule.currentobj.ID;

                if (message != '') {
                    sysmodule.alert(message);
                    return null;
                }

                return data;
            },

            selectIcon: function (obj) {
                var icon = $(obj).attr('data-original-title');

                $('#modal-info #info-icon').html(icon == null || icon == '' ? 'Chọn...' : ('<i class="' + icon + '"></i>&nbsp;[' + icon + ']'));
            },

            getSelectedActions: function () {
                var selectedActions = '';
                var ulChosens = $('#<% = divModuleActions.ClientID %> #dllActions_chosen .chosen-choices').find('.search-choice');
                if (ulChosens.length == 0) return '';

                for (var i = 0; i < ulChosens.length; i++) {
                    var index = Number($(ulChosens[i]).find('.search-choice-close').attr('data-option-array-index'));
                    selectedActions +=
                        '@' + $($('#dllActions').find('option')[index]).attr('value') + ';';
                }

                return selectedActions;
            },

            onchangename: function () {
                $('#modal-info #info-alias').val(globalhelpers.RemoveUnicode($('#modal-info #info-name').val()));
            },

            onchangealias: function () {
                $('#modal-info #info-alias').val(globalhelpers.RemoveUnicode($('#modal-info #info-alias').val()));
            }
        }

        sysmodule.init();
</script>
