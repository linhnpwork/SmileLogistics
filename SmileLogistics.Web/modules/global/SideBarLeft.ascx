<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SideBarLeft.ascx.cs" Inherits="SmileLogistics.Web.modules.global.SideBarLeft" %>
<div id="sidebar">
    <div class="sidebar-scroll">
        <div class="sidebar-content">
            <a href="/" class="sidebar-brand">
                <i class="gi gi-flash"></i><strong>Smile</strong>
            </a>
            <div class="sidebar-section sidebar-user clearfix">
                <div class="sidebar-user-avatar">
                    <a href="/profile">
                        <img id="imgAvatar" runat="server" src="/img/logo.jpg" alt="avatar">
                    </a>
                </div>
                <div id="divFullname" runat="server" class="sidebar-user-name">God Administrator</div>
                <div class="sidebar-user-links">
                    <a href="/profile" data-toggle="tooltip" data-placement="bottom" title="Profile"><i class="gi gi-user"></i></a>
                    <a href="/logout" data-toggle="tooltip" data-placement="bottom" title="Logout"><i class="gi gi-exit"></i></a>
                </div>
            </div>            
            <ul id="ulMenu" runat="server" class="sidebar-nav">
            </ul>            
        </div>
    </div>
</div>
