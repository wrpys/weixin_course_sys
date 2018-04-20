<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <%@include file="../layouts/default.jsp" %>
    <style>
        .work-info, .discuss-content {
            border: 1px solid #ccc;
        }
        .work-info h3, .discuss-content h3 {
            padding-top: 5px;
            padding-left: 10px;
        }
        .work-info hr, .discuss-content hr {
            margin: 5px 0;
        }
        .work-info ul, .discuss-content ul {
            margin-left: 50px;
        }
        .user-info {
            color: #4093c6;
        }
        .time-info {
            margin-left: 25px;
        }
        .reply-list li {
            margin-bottom: 25px;
        }
        .discuss-content ul a {
            margin-left: 25px;
        }
        #discuss-info {
            height: 400px;
            overflow-x: hidden;
            overflow-y: auto;
        }
    </style>
</head>
<body>
<div class="container" style="height:auto;padding: 10px 10px 0px 10px;">
    <div class="work-info">
        <h3>作业信息</h3>
        <hr>
        <ul>
            <li>
                <b>作业名称：</b><span class="work-title">${work.wWorkName}</span>&nbsp;&nbsp;&nbsp;&nbsp;
                <b>布置时间：</b><span class="work-title"><fmt:formatDate value="${work.wAddTime}"
                                                                     pattern="yyyy-MM-dd HH:mm:ss"/></span>
            </li>
            <li>
                <b>作业详情：</b>${work.wWorkRequirement}
            </li>
        </ul>
    </div>
    <div class="discuss-content">
        <h3>讨论列表&nbsp;&nbsp;<a onclick="loadMessage();">刷新</a></h3>
        <hr>
        <ul id="discuss-info">
        </ul>
    </div>

    <div id="content" class="hide">
        <form id="J_Form" class="form-horizontal">
            <input type="hidden" name="wId" value="${work.wId}">
            <input type="hidden" name="msgPid">
            <input type="hidden" name="operRole" value="2">
            <div class="row">
                <div class="control-group span8">
                    <label class="control-label"><s>*</s>回复：</label>
                    <div class="controls">
                        <textarea name="msgContent" class="input-large" type="text" data-rules="{required:true}"
                                  style="height: 100px;"></textarea>
                    </div>
                </div>
            </div>
        </form>
    </div>

</div>
<br><br><br><br>
<script type="text/javascript">
    var createReplyDiscussDialog;
    var replyDiscussDialog;
    var currentLiDom;
    BUI.use(['common/search', 'bui/list', 'bui/picker', 'bui/select', 'bui/overlay'], function (Search, List, Picker, Select, Overlay) {

        loadMessage();

        //创建弹出框
        createReplyDiscussDialog = function () {
            return new Overlay.Dialog({
                title: '回复',
                width: 350,
                height: 300,
                contentId: 'content',
                success: function () {
                    var me = this;
                    var wId = $("input[name='wId']").val();
                    var msgPid = $("input[name='msgPid']").val();
                    var operRole = $("input[name='operRole']").val();
                    var msgContent = $("textarea[name='msgContent']").val();
                    if (msgContent == null || msgContent == '') {
                        BUI.Message.Alert("请填写回复内容！");
                        return;
                    }
                    $.ajax({
                        url: '${ctx}/message/replyDiscuss',
                        type: 'post',
                        dataType: 'json',
                        data: {wId: wId, msgPid: msgPid, operRole: operRole, msgContent: msgContent},
                        success: function (data) {
                            console.log(data);
                            currentLiDom.find('a').remove();
                            currentLiDom.after(buildDiscuss(data));
                            me.close();
                        }
                    });
                }
            });
        }

    });//seajs end

    function loadMessage() {
        $.ajax({
            url: '${ctx}/message/getDiscuss?wId=${work.wId}',
            type: 'post',
            dataType: 'json',
            success: function (data) {
                var discussDom = $("#discuss-info");
                discussDom.empty();
                if (data && data.length > 0) {
                    for (var i = 0; i < data.length; i++) {
                        var mItem = data[i];
                        var _html = [];
                        _html.push('<li><p>');
                        _html.push('<span class="user-info">' + mItem.operName + '(' + mItem.operRoleName + ')' + '</span>');
                        _html.push('<span class="time-info">' + mItem.createTime + '</span>');
                        if (!mItem.messageExt) {
                            _html.push('<a id="' + messageExt.msgId + '" onclick="replyDiscuss(this);">回复</a>');
                        }
                        _html.push('<p>' + mItem.msgContent + '</p>');
                        _html.push('</li>');
                        if (mItem.messageExt) {
                            _html.push('<ul class="reply-list">');
                            _html.push(buildDiscuss(mItem.messageExt));
                            _html.push('</ul>');
                        }
                        discussDom.append(_html.join(""));
                    }
                } else {
                    discussDom.html("暂无讨论");
                }
            }
        });
    }

    function buildDiscuss(messageExt) {
        var _html = [];
        _html.push('<li><p>');
        _html.push('<span class="user-info">' + messageExt.operName + '(' + messageExt.operRoleName + ')' + '</span>');
        _html.push('<span class="time-info">' + messageExt.createTime + '</span>');
        if (!messageExt.messageExt) {
            _html.push('<a id="' + messageExt.msgId + '" onclick="replyDiscuss(this);">回复</a>');
        }
        _html.push('<p>' + messageExt.msgContent + '</p>');
        _html.push('</li>');
        if (messageExt.messageExt) {
            _html.push(buildDiscuss(messageExt.messageExt));
        }
        return _html.join("");
    }

    function replyDiscuss(obj) {
        var msgId = obj.id;
        currentLiDom = $(obj).parent().parent();
        if (!replyDiscussDialog) {
            replyDiscussDialog = createReplyDiscussDialog();
        }
        $("#J_Form").find("textarea[name='msgContent']").val("");
        $("#J_Form").find("input[name='msgPid']").val(msgId);
        replyDiscussDialog.show();
    }

</script>
<!-- script end -->
</body>
</html>