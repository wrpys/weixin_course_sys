<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
    <title>${course.cPName}-${course.cName}</title>
    <meta name="mobile-agent" content="format=xhtml;">
    <meta name="applicable-devive" content="mobile">
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="telephone=no" name="format-detection">
    <%@include file="inc.jsp" %>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/static/front/css/swiper-3.3.1.min.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/static/front/work/work_detial.css"/>
<style>
body {
    background: #E3F0F0;
}
.mome div {
    text-align: left;
    padding: 0;
}
#discuss-content{
    padding:0;
}
.discuss-li{
    float: left;
    border-top: 1px dashed #C6C7DB;
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
    font-size: 1.3rem;
 }
.time {
    color: #72788B;
    display: inline-block;
    float: left;
    margin-left: 1rem;
    font-size: 1.2rem;
}
.replay {
    display: inline-block;
    float: right;
    color: #2C313E;
    font-size: 1.2rem;
    margin-right: 1rem;
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
    float: left;
    display: block;
    border: 0;
    margin-top: 1.2rem;
    margin-left: 1rem;;
    width: 16%;
}
.bottom_menu label{
    width: 15%;
    font-size: 1.5rem;
    height: 5rem;
    line-height: 5rem;
    float: left;
    margin-left: 1rem;
    color: #010715;
}
.bottom_menu input{
    width: 55%;
    /*width: 20rem;*/
    height: 3rem;
    margin-top: 1rem;
    outline: 0px;
    border: 1px solid #ccc;
    float: left;
}
.refresh{
    float: right;
    font-size: 1.5rem;
    color: #0F75E2;;
}
.load {
    margin-left: auto;
    margin-right: auto;
    width: 5rem;
    height: 5rem;
    display: block;
}
.load-content{
    display: none;
    width: 100%;
    height: 5rem;
}

.replay_content {
    font-size: 1.2rem;
    color: #3E4B6A;
}

.base-info{
    height: 2.8rem;
    width: 100%;
}
.base-info label{
    height: 2.8rem;
    line-height: 2.8rem;
    color: #808E9F;
    font-size: 1.3rem;
    margin-left: 2rem;
}
.base-info a {
    width: 2rem;
    height: 2rem;
    display: block;
    float: right;
    margin-right: 2rem;
    margin-top: 0.8rem;
}
.base-info img {
    width: 2rem;
    height: 2rem;
}

.order {
    height: 3rem;
    line-height: 3rem;
    text-align: center;
    font-size: 2rem;
}
.order .line {
    display: inline-block;
    width: 40%;
    border-top: 1px solid #6C7791 ;
    margin-bottom: 0.28rem;
}
.order .txt {
    color: #323A51;
    vertical-align: middle;
}
</style>
</head>
<body>
<header style="background: #E3F0F0;">
    <div class="top_title">
        <a class="back"></a>
        <div class="title">
            课程详情
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
    <div class="base-info">
        <label>${course.userName}</label>
        <label><fmt:formatDate value="${course.cCreateTime}" pattern="yyyy.MM.dd" /></label>
        <%--<a>--%>
            <%--<img src="${ctx}/static/front/images/icons/liked.png">--%>
        <%--</a>--%>
        <%--<a>--%>
            <%--<img src="${ctx}/static/front/images/icons/unlike.png">--%>
        <%--</a>--%>
    </div>
    <div class="order" onclick="refreshMessage();">
        <span class="line"></span>
        <span class="txt">讨论区</span>
        <span class="line"></span>
    </div>
    <div class="load-content">
        <img class="load" src="${ctx}/static/images/load.gif">
    </div>
    <div class="mome" style="background: #E3F0F0;border-top: 0;padding: 0 0.5rem;margin-bottom: 7rem;">
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
        $('#msgContent').bind('input propertychange', function() {
            if(!$(this).val()) {
                $("#msgType").val(1);
                $("#msgPid").val(0);
            }
        });
//        setInterval(refreshMessage, 10000)
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
        var icon = msg.chatHeadAddr;
        if(!icon) {
            if(2==msg.operRole) {
                icon = "/static/front/images/icons/tea.png";
            } else {
                icon = "/static/front/images/icons/stu.png";
            }
        }
        _html.push('<div class="content"><div class="user-info"><img src="${ctx}' + icon + '"></div>');
        _html.push('<div class="msg-content"><p class="info">');
        _html.push('<label class="username">' + msg.operName + '(' + msg.operRoleName + ')</label><label class="time">' + msg.createTime + '</label>');
        _html.push('<a class="replay" msg_id="'+msg.msgId+'" oper_name="' + msg.operName +'" onclick="toSubmitReply(this);">回复</a></p>');
        if (parentMsg) {
            _html.push('<p class="replay_content">@' + parentMsg.operName + '：' + msg.msgContent +  '</p></div></div>');
        } else {
            _html.push('<p class="replay_content">'+ msg.msgContent +  '</p></div></div>');
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
        $(".load-content").show();
        $.ajax({
            url : "${ctx}/front/getMessage",
            type : 'GET',
            dataType : "json",
            data : {cId: cId},
            success : function(data) {
                buildDiscussContent(data);
                $(".load-content").hide();
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
        if(!data.msgContent) {
            alert("请输入内容！");
            return ;
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
                refreshMessage();
            }
        });
    }

</script>
</body>
</html>