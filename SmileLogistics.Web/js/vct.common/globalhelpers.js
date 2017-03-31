var globalhelpers =
    {
        LoadingImage:
            '<svg width="20" height="20" viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">' +
                '<g>' +
                    '<circle class="spinner__circle" r="15" cx="16" cy="16" fill="none" stroke="#3accfa" stroke-width="2" stroke-dasharray="45" />' +
                    '<animateTransform attributeType="xml" attributeName="transform" type="rotate" from="0 16 16" to="360 16 16" dur="700ms" repeatCount="indefinite" />' +
                '</g>' +
            '</svg>',

        StatusColors: [
            { ID: 0, Class: 'warning' }
        ],
        GetStatusClass: function (status) {
            var statusColor = this.GetObjInList(Number(status), this.StatusColors);
            if (statusColor == null) return "";

            return statusColor.Class;
        },

        GetIndexInList: function (value, list, field) {
            if (field == undefined) field = "ID";
            if (list == undefined || list == null || list.length == 0) return -1;
            if (value == undefined || value == null) return -1;

            for (var i = 0; i < list.length; i++) {
                if (list[i][field] == value) return i;
            }

            return -1;
        },

        GetObjInList: function (value, list, field) {
            if (field == undefined) field = "ID";
            if (list == undefined || list == null || list.length == 0) return null;
            if (value == undefined || value == null) return null;

            for (var i = 0; i < list.length; i++) {
                if (list[i][field] == value) return list[i];
            }

            return null;
        },

        GetListInList: function (value, list, field) {
            if (field == undefined) return null;
            if (list == undefined || list == null || list.length == 0) return null;
            if (value == undefined || value == null) return null;

            var result = new Array();

            for (var i = 0; i < list.length; i++) {
                if (list[i][field] == value) result.push(list[i]);
            }

            return result.length == 0 ? null : result;
        },

        Format_Money: function (nStr) {
            nStr += '';
            x = nStr.split('.');
            x1 = x[0];
            x2 = x.length > 1 ? '.' + x[1] : '';
            var rgx = /(\d+)(\d{3})/;
            while (rgx.test(x1)) {
                x1 = x1.replace(rgx, '$1' + ',' + '$2');
            }
            return x1 + x2;
        },

        Convert_FromMoney: function (nStr) {
            nStr += '';

            while (nStr.indexOf(',') >= 0)
                nStr = nStr.replace(',', '');

            return nStr;
        },

        On_InputMoney_KeyPress: function (ctrl) {
            if (ctrl === undefined) return;
            var position = ctrl.selectionEnd;

            var origin = $(ctrl).val();
            var origins = origin.split('.');
            var after = origins.length > 1 ? ('.' + origins[1]) : '';

            var str = this.Convert_FromMoney(origins[0]);
            var money = Number(str);

            if (!isNaN(money)) {
                str = this.Format_Money(money);

                $(ctrl).val(str + after);

                if (str.length == origin.length)
                    ctrl.selectionEnd = position;
            }
        },

        ShowOverlay: function (isShow, text) {
            if (!isShow) {
                $('.vct-overlay').hide();
                return;
            }

            if (!text || text == undefined || text == null || text == '')
                text = 'Vui lòng đợi';

            if ($('body').find('.vct-overlay').length > 0) {
                $('body').find('.vct-overlay .vct-loading span').html(text + " ...");
                $('body').find('.vct-overlay').show();
                return;
            }

            var html =
                "<div class=\"vct-overlay\">" +
                    "<div class=\"vct-loading\" style=\"\">" +
                        "<div class=\"vct-loading-animation\" style=\"\">" +
                        "</div>" +
                        "<span>" + text + " ...</span>" +
                    "</div>" +
                "</div>";
            $('body').append(html);
        },

        RemoveUnicode: function (str) {
            str = str.toLowerCase();
            str = str.replace(/à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ/g, "a");
            str = str.replace(/è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ/g, "e");
            str = str.replace(/ì|í|ị|ỉ|ĩ/g, "i");
            str = str.replace(/ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ/g, "o");
            str = str.replace(/ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ/g, "u");
            str = str.replace(/ỳ|ý|ỵ|ỷ|ỹ/g, "y");
            str = str.replace(/đ/g, "d");
            str = str.replace(/!|@|%|\^|\*|\(|\)|\+|\=|\<|\>|\?|\/|,|\.|\:|\;|\'| |\"|\&|\#|\[|\]|~|$|_/g, "-");

            str = str.replace(/-+-/g, "-"); //thay thế 2- thành 1- 
            str = str.replace(/^\-+|\-+$/g, "");

            return str;
        },

        GetRequestQueryString: function (name) {
            var results = new RegExp('[\?&amp;]' + name + '=([^&amp;#]*)').exec(window.location.href);
            return results == null ? "" : results[1] || "";
        },

        RenderPaging: function (container, url, pageindex, pagesize, totalpages) {
            var maxpage = 5;

            if (!totalpages || totalpages == undefined || totalpages <= 1) {
                $(container).hide();
                return;
            }

            $(container).show();

            var range = (maxpage - 1) / 2;
            var startIndex = pageindex - range > 0 ? pageindex - range : 0;
            var endIndex = startIndex + maxpage - 1 > totalpages - 1 ? totalpages - 1 : startIndex + maxpage - 1;

            var html =
                "<div class=\"col-md-9 col-md-offset-3\">" +
                    "<div class=\"dataTables_paginate paging_bootstrap\">" +
                        "<ul id=\"ulPaging\" class=\"pagination pagination-sm remove-margin\">" +
                            "<li class=\"prev " + (pageindex == startIndex ? "disabled" : "") + "\"><a href=\"" + url + "/?page=" + (pageindex == startIndex ? "0" : (pageindex - 1)) + "\"><i class=\"fa fa-chevron-left\"></i></a></li>";

            for (var i = 0; i < endIndex - startIndex + 1; i++) {
                var currentIndex = startIndex + i;
                html += "<li class=\"" + (pageindex == currentIndex ? "active" : "") + "\"><a href=\"" + (url + "/?page=" + currentIndex) + "\">" + (currentIndex + 1) + "</a></li>";
            }

            html +=
                             "<li class=\"next " + (pageindex == totalpages - 1 ? "disabled" : "") + "\"><a href=\"" + (url + "/?page=" + (pageindex == totalpages - 1 ? (totalpages - 1) : pageindex + 1)) + "\"><i class=\"fa fa-chevron-right\"></i></a></li>" +
                         "</ul>" +
                     "</div>" +
                 "</div>";

            $(container).html(html);
        }
    }