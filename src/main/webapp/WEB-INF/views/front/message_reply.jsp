<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
<title>作业提问-作业系统</title>
<meta name="keywords" content="作业详情-作业系统">
<meta name="description" content="作业详情-作业系统">
<meta name="mobile-agent" content="format=xhtml;">
<meta name="applicable-devive" content="mobile">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="telephone=no" name="format-detection">
<%@include file="inc.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/static/front/work/work_detial.css"/>
</head>
<body>
<header>
	<div class="top_title">
        <a class="back"></a>
        <div class="title">
			回复
        </div>
    </div>
</header>

<section>
	<div class="mome">
		<p class="work_item">回复问题：${msgContent}</p>
	</div>
	<div class="mome">
		<form action="${ctx}/front/submitReply" method="post">
			<input type="hidden" name="wId" value="${wId}">
			<input type="hidden" name="msgPid" value="${msgId}">
			<textarea name="msgContent" class="msg_content"></textarea>
			<div class="oper" style="background: #FFFFFF; margin-top: 1rem;">
				<a class="btn" style="margin-left: auto; margin-right: auto; width: 70%;display: block;" onclick="submitForm();">回复</a>
			</div>
		</form>
	</div>
</section>
<!--app下载 底部飘浮 -->
<div id="backTop"></div>
<%@include file="footer.jsp" %>
<script>
	function submitForm() {
		$("form").submit();
	}
</script>
</body>
</html>