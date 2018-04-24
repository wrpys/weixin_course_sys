<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
    <title>${course.cPName}-${course.cName}</title>
    <meta name="keywords" content="讨论详情">
    <meta name="description" content="讨论详情">
    <meta name="mobile-agent" content="format=xhtml;">
    <meta name="applicable-devive" content="mobile">
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="telephone=no" name="format-detection">
    <%@include file="inc.jsp" %>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/static/front/css/swiper-3.3.1.min.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/static/front/work/work_detial.css"/>
<style>
.mome div {
    text-align: left;
    padding: 0;
}
#discuss-content{
    padding:0;
}
.discuss-li{
    float: left;
    border-top: 1px solid #DDD;
    margin-bottom: 0.5rem;
    padding-top: 0.5rem;
    width: 100%;
}
.content{
    float: left;
    width: 100%;
}
.user-info {
    float: left;
    width: 15%;
}
.user-info img {
    width: 4rem;
    height: 4rem;
    border-radius: 2rem;
}
.msg-content {
    float: left;
    width: 85%;
}
.info{
    height: 2rem;
    display: block;
}
.username{
    font-weight: bold;
    display: inline-block;
    float: left;
 }
.time {
    color: #cccccc;
    display: inline-block;
    float: left;
    margin-left: 1rem;
}
.replay {
    display: inline-block;
    float: right;
    color: #0F75E2;
}
.sub-discuss-ul{
    float: left;
    margin-top: 1rem;
    width: 100%;
}
/*.sub-discuss-ul ul {*/
    /*padding-left: 4rem;*/
/*}*/
.padding4rem {
    padding-left: 4rem;
}
.no_dis {
    font-size: 1.5rem;
    text-align: center;
    color: #0F75E2;
}
.btn {
    border-radius: 2px;
    width: 6rem;
    line-height: 2.8rem;
    background-color: #f98600;
    color: #fff;
    font-size: 1.7rem;
    text-align: center;
    vertical-align: middle;
    float: right;
    display: block;
    border: 0;
    margin-top: 0.6rem;
    margin-right: 1rem;;
    width: 16%;
}
.bottom_menu label{
    width: 16%;
    font-size: 2rem;
    line-height: 4rem;
    float: left;
    margin-left: 1rem;
}
.bottom_menu input{
    width: 60%;
    /*width: 20rem;*/
    height: 3rem;
    margin-top: 0.5rem;
    outline: 0px;
    border: 1px solid #ccc;
    float: left;
}
.refresh{
    float: right;
    font-size: 1.5rem;
    color: #0F75E2;;
}
</style>
</head>
<body>
<header>
    <div class="top_title">
        <a class="back"></a>
        <div class="title">
            讨论详情
        </div>
    </div>
</header>

<section>
    <!--图片轮播-->
    <div class="swiper-container">
        <div class="swiper-wrapper">
            <c:forEach items="${course.fileImageList}" var="fi">
                <div class="swiper-slide">
                    <img src="<%=request.getContextPath()%>${fi}" />
                </div>
            </c:forEach>
        </div>
        <!-- 如果需要分页器 -->
        <div class="swiper-pagination"></div>
    </div>
    <div class="mome">
        <h2>讨论区<a class="refresh" onclick="refreshMessage();">刷新</a></h2>
        <div id="discuss-content">

        </div>
    </div>
</section>
<!--app下载 底部飘浮 -->
<div id="backTop" style="bottom: 6.7rem;"></div>
<input type="hidden" name="msgType" id="msgType" value="1">
<input type="hidden" name="msgPid" id="msgPid" value="0">
<input type="hidden" name="weixinId" id="weixinId" value="${weixinId}">
<input type="hidden" name="cId" id="cId" value="${course.cId}">
<%@include file="course_details_footer.jsp" %>
<script type="text/javascript">
    var cId = "${course.cId}";
    $(function () {
        //图片轮播
        var mySwiper = new Swiper('.swiper-container', {
            loop: true,
            // 如果需要分页器
            pagination: '.swiper-pagination'
        });
    })
    
    var messageList = eval('(${messageList})');
    buildDiscussContent(messageList);

    function buildDiscussContent(messageList) {
        var discussContent = $("#discuss-content");
        discussContent.empty();
        if (messageList && messageList.length > 0) {
            discussContent.append('<ul id="discuss-ul" class="discuss-ul"></ul>');
            var ulDom = $("#discuss-ul");
            for (var i = 0; i < messageList.length; i++) {
                var _html = [];
                var msg = messageList[i];
                _html.push('<li class="discuss-li">');
                _html.push(buildDiscussLi(null, msg));
                if (msg.messageExts && msg.messageExts.length > 0) {
                    _html.push('<div class="sub-discuss-ul">');
                    _html.push(buildSubDiscussContent(msg, msg.messageExts, "padding4rem"));
                    _html.push('</div>');
                }
                _html.push('</li>');
                ulDom.append(_html.join(""));
            }
        } else {
            discussContent.html('<p class="no_dis">暂无讨论</p>')
        }
    }

    // 构造li
    function buildDiscussLi(parentMsg, msg) {
        var _html = [];
        _html.push('<div class="content"><div class="user-info"><img src="${ctx}/static/touxiang/user.jpg"></div>');
        _html.push('<div class="msg-content"><p class="info">');
        _html.push('<label class="username">' + msg.operName + '(' + msg.operRoleName + ')</label><label class="time">' + msg.createTime + '</label>');
        _html.push('<a class="replay" msg_id="'+msg.msgId+'" oper_name="' + msg.operName +'" onclick="toSubmitReply(this);">回复</a></p>');
        if (parentMsg) {
            _html.push('<p>@' + parentMsg.operName + '：' + msg.msgContent +  '</p></div></div>');
        } else {
            _html.push('<p>'+ msg.msgContent +  '</p></div></div>');
        }
        return _html.join("");
    }

    function buildSubDiscussContent(parentMsg, messages, isFirst) {
        var _html = [];
        _html.push('<ul class="discuss-ul ' + isFirst + '">');
        for (var i=0; i<messages.length; i++) {
            var msg = messages[i];
            _html.push('<li class="discuss-li">');
            _html.push(buildDiscussLi(parentMsg, msg));
            if (msg.messageExts && msg.messageExts.length > 0) {
                _html.push('<div class="sub-discuss-ul">');
                _html.push(buildSubDiscussContent(msg, msg.messageExts, ""));
                _html.push('</div>');
            }
            _html.push('</li>');
        }
        _html.push('</ul>');
        return _html.join("");
    }

    // 点击回复
    function toSubmitReply(obj) {
        $("#msgType").val(2);
        var msgId = $(obj).attr("msg_id");
        $("#msgPid").val(msgId);
        var operName = $(obj).attr("oper_name");
        $("#msgContent").val("@" + operName + "：");
    }

    // 点击发送
    $("#submitBtn").click(function () {
        var msgType = $("#msgType").val();
        var data = {
            msgPid: $("#msgPid").val(),
            weixinId: $("#weixinId").val(),
            cId: $("#cId").val(),
            msgContent: $("#msgContent").val()
        };
        submit(msgType, data);
    });

    // 刷新讨论区
    function refreshMessage() {
        $.ajax({
            url : "${ctx}/front/getMessage",
            type : 'GET',
            dataType : "json",
            data : {cId: cId},
            success : function(data) {
                buildDiscussContent(data);
            }
        });
    }

    // 提交
    function submit(type, data) {
        if (type == "2") {
            var msgContent = data.msgContent;
            var ms = msgContent.split("：");
            if (ms.length != 2) {
                alert("请重新点击回复的消息！");
                return ;
            } else {
                data.msgContent = ms[1];
            }
        }
        $.ajax({
            url : "${ctx}/front/submitReply",
            async : false,
            type : 'POST',
            dataType : "json",
            data : data,
            success : function(data) {
                $("#msgType").val(1);
                $("#msgPid").val(0);
                $("#msgContent").val("");
                console.log(data);
                refreshMessage();
                if (type == "1") {

                } else if (type == "2") {

                }
            }
        });
    }

</script>
</body>
</html>