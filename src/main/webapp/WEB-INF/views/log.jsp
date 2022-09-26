<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/common/backend_common.jsp"/>
    <jsp:include page="/common/page.jsp"/>
</head>
<body class="no-skin" youdao="bind" style="background: white">
<input id="gritter-light" checked="" type="checkbox" class="ace ace-switch ace-switch-5"/>

<div class="page-header">
    <h1>
        Permission operation records
        <small>
            <i class="ace-icon fa fa-angle-double-right"></i>
            Manage permissions related module update history
        </small>
    </h1>
</div>
<div class="main-content-inner">
    <div class="col-sm-12">
        <div class="col-xs-12">
            <div class="table-header">
                Operation lists
            </div>
            <div>
                <div id="dynamic-table_wrapper" class="dataTables_wrapper form-inline no-footer">
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="dataTables_length" id="dynamic-table_length"><label>
                                shows
                                <select id="pageSize" name="dynamic-table_length" aria-controls="dynamic-table" class="form-control input-sm">
                                    <option value="10">10</option>
                                    <option value="25">25</option>
                                    <option value="50">50</option>
                                    <option value="100">100</option>
                                </select> records </label>
                                <label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;type
                                    <select id="search-type" name="dynamic-table_length" aria-controls="dynamic-table" class="form-control input-sm">
                                        <option value="">all</option>
                                        <option value="1">department</option>
                                        <option value="2">user</option>
                                        <option value="3">aclModule</option>
                                        <option value="4">acl</option>
                                        <option value="5">role</option>
                                        <option value="6">role_acl</option>
                                        <option value="7">role_user</option>
                                    </select></label>

                                <input id="search-operator" type="search" name="operator" class="form-control input-sm" placeholder="operator" aria-controls="dynamic-table">
                                <input id="search-before" type="search" name="beforeSeg" class="form-control input-sm" placeholder="value before operation" aria-controls="dynamic-table">
                                <input id="search-after" type="search" name="afterSeg" class="form-control input-sm" placeholder="value after operation" aria-controls="dynamic-table">
                                <input id="search-from"type="search" name="fromTime" class="form-control input-sm" placeholder="start time" aria-controls="dynamic-table"> ~
                                <input id="search-to" type="search" name="toTime" class="form-control input-sm" placeholder="end time" aria-controls="dynamic-table">
                                &nbsp;&nbsp;&nbsp;&nbsp;
                                <button class="btn btn-info fa fa-check research" style="margin-bottom: 6px;" type="button">
                                    refresh
                                </button>
                            </div>
                        </div>
                        <table id="dynamic-table" class="table table-striped table-bordered table-hover dataTable no-footer" role="grid"
                               aria-describedby="dynamic-table_info" style="font-size:14px">
                            <thead>
                            <tr role="row">
                                <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                    operator
                                </th>
                                <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                    operation type
                                </th>
                                <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                    operation time
                                </th>
                                <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                    value before operation
                                </th>
                                <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                    value after operation
                                </th>
                                <th class="sorting_disabled" rowspan="1" colspan="1" aria-label=""></th>
                            </tr>
                            </thead>
                            <tbody id="logList"></tbody>
                        </table>
                        <div class="row" id="logPage">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
    <script id="logListTemplate" type="x-tmpl-mustache">
{{#logList}}
<tr role="row" class="config odd" data-id="{{id}}"><!--even -->
    <td>{{operator}}</td>
    <td>{{#showType}}{{/showType}}</td>
    <td>{{#showDate}}{{/showDate}}</td>
    <td><pre>{{#showOldValue}}{{/showOldValue}}</pre></td>
    <td><pre>{{#showNewValue}}{{/showNewValue}}</pre></td>
    <td>
        <div class="hidden-sm hidden-xs action-buttons">
            <a class="green log-edit" href="#" data-id="{{id}}">
                <i class="ace-icon fa fa-pencil bigger-100"></i>
            </a>
        </div>
    </td>
</tr>
{{/logList}}
</script>

    <script type="text/javascript">
        $(function () {
            var logListTemplate = $('#logListTemplate').html();
            Mustache.parse(logListTemplate);
            var logMap = {};

            loadLogList();

            $(".research").click(function (e) {
                e.preventDefault();
                loadLogList();
            });

            function loadLogList() {
                var pageSize = $("#pageSize").val();
                var pageNo = $("#logPage .pageNo").val() || 1;
                var url = "/sys/log/page.json";
                var beforeSeg = $("#search-before").val();
                var afterSeg = $("#search-after").val();
                var operator = $("#search-operator").val();
                var fromTime = $("#search-from").val();
                var toTime = $("#search-to").val();
                var type = $("#search-type").val();
                $.ajax({
                    url: url,
                    data: {
                        pageNo: pageNo,
                        pageSize: pageSize,
                        beforeSeg: beforeSeg,
                        afterSeg : afterSeg,
                        operator : operator,
                        fromTime: fromTime,
                        toTime: toTime,
                        type: type
                    },
                    type: 'POST',
                    success: function (result) {
                        renderLogListAndPage(result, url);
                    }
                });
            }

            function renderLogListAndPage(result, url) {
                if (result.ret) {
                    if (result.data.total > 0) {
                        var rendered = Mustache.render(logListTemplate, {
                            "logList": result.data.data,
                            "showType": function () {
                                return function (text, render) {
                                    var typeStr = "";
                                    switch (this.type) {
                                        case 1: typeStr = "department";break;
                                        case 2: typeStr = "user";break;
                                        case 3: typeStr = "aclModule";break;
                                        case 4: typeStr = "acl";break;
                                        case 5: typeStr = "role";break;
                                        case 6: typeStr = "role_acl";break;
                                        case 7: typeStr = "role_user";break;
                                        default: typeStr = "unknown";
                                    }
                                    return typeStr;
                                }
                            },
                            "showDate" :function () {
                                return function (text, render) {
                                    return new Date(this.operateTime).Format("yyyy-MM-dd hh:mm:ss");
                                }
                            },
                            "showOldValue": function () {
                                return function (text, render) {
                                    return this.oldValue ? ((this.type == 6 || this.type == 7) ? this.oldValue : formatJson(this.oldValue)) : 'void';
                                }
                            },
                            "showNewValue": function () {
                                return function (text, render) {
                                    return this.newValue ? ((this.type == 6 || this.type == 7) ? this.newValue : formatJson(this.newValue)) : 'void';
                                }
                            }
                        });
                        $('#logList').html(rendered);
                        $.each(result.data.data, function (i, log) {
                            logMap[log.id] = log;
                        });
                    } else {
                        $('#logList').html('');
                    }
                    bindLogClick();
                    var pageSize = $("#pageSize").val();
                    var pageNo = $("#logPage .pageNo").val() || 1;
                    renderPage(url, result.data.total, pageNo, pageSize, result.data.total > 0 ? result.data.data.length : 0, "logPage", renderLogListAndPage);
                } else {
                    showMessage("Get permission operation history list", result.msg, false);
                }
            }

            function bindLogClick() {
                $(".log-edit").click(function (e) {
                    e.preventDefault();
                    var logId = $(this).attr("data-id"); // 选中的log id
                    console.log(logId);
                    if (confirm("Ok to recover?")) {
                        $.ajax({
                            url: "/sys/log/recover.json",
                            data: {
                                id: logId
                            },
                            success: function (result) {
                                if (result.ret) {
                                    showMessage("recover history", "success", true);
                                    loadLogList();
                                } else {
                                    showMessage("recover history", result.msg, false);
                                }
                            }
                        });
                    }
                });
            }
            Date.prototype.Format = function (fmt) { //author: meizz
                var o = {
                    "M+": this.getMonth() + 1, //月份
                    "d+": this.getDate(), //日
                    "h+": this.getHours(), //小时
                    "m+": this.getMinutes(), //分
                    "s+": this.getSeconds(), //秒
                    "q+": Math.floor((this.getMonth() + 3) / 3), //季度
                    "S": this.getMilliseconds() //毫秒
                };
                if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
                for (var k in o)
                    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
                return fmt;
            };
            var formatJson = function(json, options) {
                if(json == '') return '';
                var reg = null,
                    formatted = '',
                    pad = 0,
                    PADDING = '    '; // one can also use '\t' or a different number of spaces

                // optional settings
                options = options || {};
                // remove newline where '{' or '[' follows ':'
                options.newlineAfterColonIfBeforeBraceOrBracket = (options.newlineAfterColonIfBeforeBraceOrBracket === true) ? true : false;
                // use a space after a colon
                options.spaceAfterColon = (options.spaceAfterColon === false) ? false : true;

                // begin formatting...
                if (typeof json !== 'string') {
                    // make sure we start with the JSON as a string
                    json = JSON.stringify(json);
                } else {
                    // is already a string, so parse and re-stringify in order to remove extra whitespace
                    json = JSON.parse(json);
                    json = JSON.stringify(json);
                }

                // add newline before and after curly braces
                reg = /([\{\}])/g;
                json = json.replace(reg, '\r\n$1\r\n');

                // add newline before and after square brackets
                reg = /([\[\]])/g;
                json = json.replace(reg, '\r\n$1\r\n');

                // add newline after comma
                reg = /(\,)/g;
                json = json.replace(reg, '$1\r\n');

                // remove multiple newlines
                reg = /(\r\n\r\n)/g;
                json = json.replace(reg, '\r\n');

                // remove newlines before commas
                reg = /\r\n\,/g;
                json = json.replace(reg, ',');

                // optional formatting...
                if (!options.newlineAfterColonIfBeforeBraceOrBracket) {
                    reg = /\:\r\n\{/g;
                    json = json.replace(reg, ':{');
                    reg = /\:\r\n\[/g;
                    json = json.replace(reg, ':[');
                }
                if (options.spaceAfterColon) {
                    reg = /\:/g;
                    json = json.replace(reg, ': ');
                }

                $.each(json.split('\r\n'), function(index, node) {
                    var i = 0,
                        indent = 0,
                        padding = '';

                    if (node.match(/\{$/) || node.match(/\[$/)) {
                        indent = 1;
                    } else if (node.match(/\}/) || node.match(/\]/)) {
                        if (pad !== 0) {
                            pad -= 1;
                        }
                    } else {
                        indent = 0;
                    }

                    for (i = 0; i < pad; i++) {
                        padding += PADDING;
                    }

                    formatted += padding + node + '\r\n';
                    pad += indent;
                });
                return formatted;
            };

        });
    </script>
</body>
</html>