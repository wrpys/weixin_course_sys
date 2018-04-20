<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
<title>作业详情-作业系统</title>
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
        	作业详情
        </div>
    </div>
</header>

<section>
	<div class="mome">
		<h2>基本信息</h2>
		<p class="work_item">${fn:substring(work.wWorkName, 0, 15)}</p>
		<label>老师：${work.teacherName}</label>
		<label style="float: right;">布置时间：<fmt:formatDate  value="${work.wAddTime}"  pattern="yyyy-MM-dd HH:mm:ss" /></label>
	</div>
	<div class="oper">
		<c:if test="${isComplete == true}">
			<a class="btn" style="float: left;width: 30%;margin-right: 3%;" href="<%=request.getContextPath()%>/front/toScore?wId=${work.wId}">查看成绩</a>
			<a class="btn" style="float: left;width: 30%;margin-right: 3%;" href="<%=request.getContextPath()%>/front/toMessage?wId=${work.wId}">参与讨论</a>
			<a class="btn" style="float: left;width: 30%;" href="<%=request.getContextPath()%>/front/toQuestions?wId=${work.wId}">提问列表</a>
		</c:if>
		<c:if test="${isComplete == false}">
			<a class="btn" style="float: left;" href="<%=request.getContextPath()%>/front/toAnswer?wId=${work.wId}">答题</a>
			<a class="btn" style="float: right;" href="<%=request.getContextPath()%>/front/toQuestions?wId=${work.wId}">提问</a>
		</c:if>
	</div>
	<div class="mome">
		<h2>作业描述</h2>
		<div style="text-align: left;font-size: 1.1rem;">
			${work.wWorkRequirement}
		</div>
	</div>
</section>
<!--app下载 底部飘浮 -->
<div id="backTop"></div>
<%@include file="footer.jsp" %>
</body>
</html>