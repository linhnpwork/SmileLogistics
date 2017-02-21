﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Authentication.aspx.cs" Inherits="SmileLogistics.Web.Authentication" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />

    <title>Smile Logistics - Management</title>

    <meta name="description" content="VirtualCardTrading - Administration authentication" />
    <meta name="author" content="VirtualCardTrading" />
    <meta name="robots" content="noindex, nofollow" />

    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1.0" />

    <!-- Icons -->
    <!-- The following icons can be replaced with your own, they are used by desktop and mobile browsers -->
    <link rel="shortcut icon" href="/img/favicon.ico" />
    <link rel="apple-touch-icon" href="/img/icon57.png" sizes="57x57" />
    <link rel="apple-touch-icon" href="/img/icon72.png" sizes="72x72" />
    <link rel="apple-touch-icon" href="/img/icon76.png" sizes="76x76" />
    <link rel="apple-touch-icon" href="/img/icon114.png" sizes="114x114" />
    <link rel="apple-touch-icon" href="/img/icon120.png" sizes="120x120" />
    <link rel="apple-touch-icon" href="/img/icon144.png" sizes="144x144" />
    <link rel="apple-touch-icon" href="/img/icon152.png" sizes="152x152" />
    <!-- END Icons -->

    <!-- Stylesheets -->
    <!-- Bootstrap is included in its original form, unaltered -->
    <link rel="stylesheet" href="/css/bootstrap.min.css" />

    <!-- Related styles of various icon packs and plugins -->
    <link rel="stylesheet" href="/css/plugins.css" />

    <!-- The main stylesheet of this template. All Bootstrap overwrites are defined in here -->
    <link rel="stylesheet" href="/css/main.css" />

    <!-- The globalhelpers stylesheet of this template. All Bootstrap overwrites are defined in here -->
    <link rel="stylesheet" href="/css/globalhelpers.css?ver=1.0.1" />

    <!-- Include a specific file here from css/themes/ folder to alter the default theme of the template -->

    <!-- The themes stylesheet of this template (for using specific theme color in individual elements - must included last) -->
    <link rel="stylesheet" href="/css/themes.css" />
    <!-- END Stylesheets -->

    <!-- Modernizr (browser feature detection library) & Respond.js (Enable responsive CSS code on browsers that don't support it, eg IE8) -->
    <script src="/js/vendor/modernizr-2.7.1-respond-1.4.2.min.js"></script>

    <!-- Include Jquery library from Google's CDN but if something goes wrong get Jquery from local file (Remove 'http:' if you have SSL) -->
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script>!window.jQuery && document.write(decodeURI('%3Cscript src="js/vendor/jquery-1.11.1.min.js"%3E%3C/script%3E'));</script>

    <!-- Bootstrap.js, Jquery plugins and Custom JS code -->
    <script src="/js/vendor/bootstrap.min.js"></script>
    <script src="/js/plugins.js"></script>
    <script src="/js/app.js"></script>
    <script src="/js/vct.common/globalhelpers.js"></script>
    <script src="/js/jquery.cookie.js"></script>

    <!-- Load and execute javascript code used only in this page -->
    <script src="/js/pages/login.js"></script>
    <script>$(function () { Login.init(); authentication.init(); });</script>
</head>
<body>
    <%--<form id="form1" runat="server">--%>
    <!-- Login Full Background -->
    <!-- For best results use an image with a resolution of 1280x1280 pixels (prefer a blurred image for smaller file size) -->
    <img src="/img/placeholders/backgrounds/login_full_bg.jpg" alt="Login Full Background" class="full-bg animation-pulseSlow">
    <!-- END Login Full Background -->

    <!-- Login Container -->
    <div id="login-container" class="animation-fadeIn">
        <!-- Login Title -->
        <div class="login-title text-center">
            <h1><i class="gi gi-flash"></i><strong>Smile Logistics - Management</strong><br />
                <small>Please <strong>Login</strong> or <strong>Register</strong></small></h1>
        </div>
        <!-- END Login Title -->

        <!-- Login Block -->
        <div class="block push-bit">
            <!-- Login Form -->
            <form id="form-login" class="form-horizontal form-bordered form-control-borderless">
                <div class="form-group">
                    <div class="col-xs-12">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="gi gi-envelope"></i></span>
                            <input type="text" id="login-email" name="login-email" class="form-control input-lg" placeholder="Email" />
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-xs-12">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="gi gi-asterisk"></i></span>
                            <input type="password" id="login-password" name="login-password" class="form-control input-lg" placeholder="Password" />
                        </div>
                    </div>
                </div>
                <div class="form-group form-actions">
                    <div class="col-xs-4">
                        <label class="switch switch-primary" data-toggle="tooltip" title="Remember Me?">
                            <input type="checkbox" id="login-remember-me" name="login-remember-me" checked />
                            <span></span>
                        </label>
                    </div>
                    <div class="col-xs-8 text-right">
                        <a class="btn btn-sm btn-primary" onclick="authentication.tryLogin();"><i class="fa fa-angle-right"></i>Login to Dashboard</a>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-xs-12 text-center">
                        <a href="javascript:void(0)" id="link-reminder-login"><small>Forgot password?</small></a> -
                            <a href="javascript:void(0)" id="link-register-login"><small>Create a new account</small></a>
                    </div>
                </div>
            </form>
            <!-- END Login Form -->

            <!-- Reminder Form -->
            <div id="form-reminder" class="form-horizontal form-bordered form-control-borderless display-none">
                <div class="form-group">
                    <div class="col-xs-12">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="gi gi-envelope"></i></span>
                            <input type="text" id="reminder-email" name="reminder-email" class="form-control input-lg" placeholder="Email">
                        </div>
                    </div>
                </div>
                <div class="form-group form-actions">
                    <div class="col-xs-12 text-right">
                        <button type="submit" class="btn btn-sm btn-primary"><i class="fa fa-angle-right"></i>Reset Password</button>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-xs-12 text-center">
                        <small>Did you remember your password?</small> <a href="javascript:void(0)" id="link-reminder"><small>Login</small></a>
                    </div>
                </div>
            </div>
            <!-- END Reminder Form -->

            <!-- Register Form -->
            <div id="form-register" class="form-horizontal form-bordered form-control-borderless display-none">
                <div class="form-group">
                    <div class="col-xs-6">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="gi gi-user"></i></span>
                            <input type="text" id="register-firstname" name="register-firstname" class="form-control input-lg" placeholder="Firstname">
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <input type="text" id="register-lastname" name="register-lastname" class="form-control input-lg" placeholder="Lastname">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-xs-12">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="gi gi-envelope"></i></span>
                            <input type="text" id="register-email" name="register-email" class="form-control input-lg" placeholder="Email">
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-xs-12">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="gi gi-asterisk"></i></span>
                            <input type="password" id="register-password" name="register-password" class="form-control input-lg" placeholder="Password">
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-xs-12">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="gi gi-asterisk"></i></span>
                            <input type="password" id="register-password-verify" name="register-password-verify" class="form-control input-lg" placeholder="Verify Password">
                        </div>
                    </div>
                </div>
                <div class="form-group form-actions">
                    <div class="col-xs-6">
                        <a href="#modal-terms" data-toggle="modal" class="register-terms">Terms</a>
                        <label class="switch switch-primary" data-toggle="tooltip" title="Agree to the terms">
                            <input type="checkbox" id="register-terms" name="register-terms">
                            <span></span>
                        </label>
                    </div>
                    <div class="col-xs-6 text-right">
                        <button type="submit" class="btn btn-sm btn-success"><i class="fa fa-plus"></i>Register Account</button>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-xs-12 text-center">
                        <small>Do you have an account?</small> <a href="javascript:void(0)" id="link-register"><small>Login</small></a>
                    </div>
                </div>
            </div>
            <!-- END Register Form -->
        </div>
        <!-- END Login Block -->
    </div>
    <!-- END Login Container -->

    <!-- Modal Terms -->
    <div id="modal-terms" class="modal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Terms &amp; Conditions</h4>
                </div>
                <div class="modal-body">
                    <h4>Title</h4>
                    <p>Donec lacinia venenatis metus at bibendum? In hac habitasse platea dictumst. Proin ac nibh rutrum lectus rhoncus eleifend. Sed porttitor pretium venenatis. Suspendisse potenti. Aliquam quis ligula elit. Aliquam at orci ac neque semper dictum. Sed tincidunt scelerisque ligula, et facilisis nulla hendrerit non. Suspendisse potenti. Pellentesque non accumsan orci. Praesent at lacinia dolor. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                    <p>Donec lacinia venenatis metus at bibendum? In hac habitasse platea dictumst. Proin ac nibh rutrum lectus rhoncus eleifend. Sed porttitor pretium venenatis. Suspendisse potenti. Aliquam quis ligula elit. Aliquam at orci ac neque semper dictum. Sed tincidunt scelerisque ligula, et facilisis nulla hendrerit non. Suspendisse potenti. Pellentesque non accumsan orci. Praesent at lacinia dolor. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                    <h4>Title</h4>
                    <p>Donec lacinia venenatis metus at bibendum? In hac habitasse platea dictumst. Proin ac nibh rutrum lectus rhoncus eleifend. Sed porttitor pretium venenatis. Suspendisse potenti. Aliquam quis ligula elit. Aliquam at orci ac neque semper dictum. Sed tincidunt scelerisque ligula, et facilisis nulla hendrerit non. Suspendisse potenti. Pellentesque non accumsan orci. Praesent at lacinia dolor. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                    <p>Donec lacinia venenatis metus at bibendum? In hac habitasse platea dictumst. Proin ac nibh rutrum lectus rhoncus eleifend. Sed porttitor pretium venenatis. Suspendisse potenti. Aliquam quis ligula elit. Aliquam at orci ac neque semper dictum. Sed tincidunt scelerisque ligula, et facilisis nulla hendrerit non. Suspendisse potenti. Pellentesque non accumsan orci. Praesent at lacinia dolor. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                    <h4>Title</h4>
                    <p>Donec lacinia venenatis metus at bibendum? In hac habitasse platea dictumst. Proin ac nibh rutrum lectus rhoncus eleifend. Sed porttitor pretium venenatis. Suspendisse potenti. Aliquam quis ligula elit. Aliquam at orci ac neque semper dictum. Sed tincidunt scelerisque ligula, et facilisis nulla hendrerit non. Suspendisse potenti. Pellentesque non accumsan orci. Praesent at lacinia dolor. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                    <p>Donec lacinia venenatis metus at bibendum? In hac habitasse platea dictumst. Proin ac nibh rutrum lectus rhoncus eleifend. Sed porttitor pretium venenatis. Suspendisse potenti. Aliquam quis ligula elit. Aliquam at orci ac neque semper dictum. Sed tincidunt scelerisque ligula, et facilisis nulla hendrerit non. Suspendisse potenti. Pellentesque non accumsan orci. Praesent at lacinia dolor. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                </div>
            </div>
        </div>
    </div>
    <!-- END Modal Terms -->
    <%--</form>--%>

    <script>
        var authentication =
            {
                ajaxPath: '/ajax/AjaxAuthentication.aspx',

                init: function () {
                    $("#login-email").keypress(function (event) {
                        if (event.which == 13) {
                            event.preventDefault();
                            authentication.tryLogin();
                        }
                    });
                    $("#login-password").keypress(function (event) {
                        if (event.which == 13) {
                            event.preventDefault();
                            authentication.tryLogin();
                        }
                    });
                },

                tryLogin: function () {
                    if (authentication.isValidatedLogin()) {
                        globalhelpers.ShowOverlay(true);

                        var email = $('#login-email').val();
                        var password = $('#login-password').val();
                        var isRemember = $('#login-remember-me').prop('checked');

                        $.post(authentication.ajaxPath + '?ts=' + new Date().getTime().toString(),
                            { 'mod': "login", 'email': email, 'password': password },
                                function (data) {
                                    globalhelpers.ShowOverlay(false);
                                    var obj = JSON.parse(data);

                                    if (obj.ErrorCode == 0)
                                    {
                                        globalhelpers.ShowOverlay(true, 'Login successfull, redirecting');
                                        //var isRemember = $('#login-remember-me').prop('checked');
                                        $.cookie('.sl.membership', obj.Data, { expires: (isRemember ? 7 : 1) });
                                        location.href = '/';// (jsLogin.PostbackUrl != null && jsLogin.PostbackUrl != undefined && jsLogin.PostbackUrl != "" ? jsLogin.PostbackUrl : '/');
                                    }
                                    else
                                    {
                                        alert(obj.Message);
                                    }
                                });
                    }
                },

                isValidatedLogin: function () {
                    if ($('#login-email').val() == '' || $('#login-password').val() == '') return false;

                    if ($('#form-login').find('.has-error').length > 0) return false;
                    else return true;
                }
            }
    </script>
</body>
</html>