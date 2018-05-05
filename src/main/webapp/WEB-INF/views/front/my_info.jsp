<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
    <title>个人信息</title>
    <meta name="mobile-agent" content="format=xhtml;">
    <meta name="applicable-devive" content="mobile">
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="telephone=no" name="format-detection">
    <%@include file="inc.jsp" %>
    <style>
        body {
            background: #EAEAEA;
        }
        .clearfloat {
            clear:both;
        }
        .my-info {
            width: 100%;
            height: 9rem;
        }
        .my-info li {
            float: left;
            height: 7rem;
            margin-top: 1rem;
            margin-bottom: 1rem;
        }
        .my-info li img {
            height: 7rem;
            width: 7rem;
            border-radius: 3.5rem;
        }
        .user-name {
            display: block;
            color: #010101;
            font-size: 2rem;
            margin-top: 0.5rem;
        }
        .account {
            display: block;
            color: #40517B;
            margin-top: 0.5rem;
        }
        .bingding {
            height: 3.5rem;
            line-height: 3.5rem;
            font-size: 1.7rem;
            color: #3A4D78;
            background: #779AB7;
            display: inline-block;
            padding-left: 1rem;
            padding-right: 1rem;
            border-radius: 1.5rem;
        }
        .msg-content li {
            background: #F9F9F9;
        }
        .msg-item {
            margin-bottom: 1rem;
        }
        .replay-user-info {

        }
        .msg-content li img {
            border-radius: 2rem;
            height: 4rem;
            width: 4rem;
            margin: 1rem;
        }
        .replay-info1 {
            width: 6rem;
            height: 6rem;
            float: left;
        }
        .replay-info2 {
            width: 12rem;
            height: 6rem;
            float: left;
        }
        .name {
            color: #4F4F4F;
            font-size: 1.6rem;
            display: block;
            height: 2rem;
            margin-top: 0.8rem;
        }
        .time {
            display: block;
            color: #AFAFAF;
            font-size: 1.2rem;
            height: 2rem;
            margin-top: 0.5rem;
        }
        .replay-title {
            padding-left: 6rem;
            color: #404040;
            font-size: 1.4rem;
        }
        .replay-msg {
            margin-left: 6rem;
            margin-right: 1.5rem;
            margin-top: 1rem;
            background: #EAEAEA;
            padding: 0.8rem;
            border-radius: 0.4rem;
            font-size: 1.4rem;
            color: #727070;
        }


        .upload{
            position: relative;
        }
        .upload form{width:100%;height: 100%;position:absolute; left:0; top:0;opacity:0; filter:alpha(opacity=0);}
        .upload form input{width: 100%;height: 100%;}

    </style>
</head>
<body>
<header style="padding-left: 1.5rem;padding-right: 1.5rem;">
    <ul class="my-info">
        <li class="upload">
            <img src="${ctx}${myInfo.chatHeadAddr}">
            <form enctype="multipart/form-data" method="post" action="${ctx}/front/uploadFile">
                <input type="file" name="chatHeadAddr" onchange="fileSelected()">
                <input type="hidden" name="weixinId" value="${myInfo.weixinId}">
                <input type="hidden" name="role" value="${myInfo.role}">
                <input type="hidden" name="userId" value="${myInfo.userId}">
                <input type="hidden" name="account" value="${myInfo.account}">
            </form>
        </li>
        <li style="margin-left: 2rem;">
            <label class="user-name"> ${myInfo.userName}(
                <c:if test="${myInfo.role==1}">学生</c:if>
                <c:if test="${myInfo.role==2}">教师</c:if>
                )</label>
            <label class="account">账号：${myInfo.account}</label>
        </li>
        <li style="float: right;">
            <label class="bingding">
                已绑定
            </label>
        </li>
    </ul>
</header>
<section>
    <ul class="msg-content">

        <c:forEach items="${messages}" var="msg">
            <li class="msg-item">
                <ul class="replay-user-info">
                    <li>
                        <div class="replay-info1">
                            <img src="${ctx}${msg.chatHeadAddr}">
                        </div>
                        <div class="replay-info2">
                            <label class="name"> ${msg.operName}(${msg.operRoleName})</label>
                            <label class="time"><fmt:formatDate value="${msg.createTime}" pattern="MM-dd HH:mm:ss" /></label>
                        </div>
                        <div class="clearfloat"></div>
                    </li>
                    <li>
                        <p class="replay-title">回复了您的消息</p>
                    </li>
                    <li style="padding-bottom: 1rem;">
                        <a href="${ctx}/front/lookOver?cId=${msg.cId}&weixinId=${myInfo.weixinId}"><p class="replay-msg">${msg.msgContent}</p></a>
                    </li>
                </ul>
            </li>
        </c:forEach>
    </ul>
</section>
<!--app下载 底部飘浮 -->
<div id="backTop"></div>
<%@include file="footer.jsp" %>
<script>
    function fileSelected() {
        $("form").submit();
    }
</script>
</body>
</html>