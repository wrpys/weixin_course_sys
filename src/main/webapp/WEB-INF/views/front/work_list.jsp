<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
<title>作业列表-作业系统</title>
<meta name="keywords" content="作业列表-作业系统">
<meta name="description" content="作业列表-作业系统">
<meta name="mobile-agent" content="format=xhtml;">
<meta name="applicable-devive" content="mobile">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="telephone=no" name="format-detection">
<%@include file="inc.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/static/front/work/work_list.css"/>
</head>
<body>
<header>
	<div class="top_title">
        <a href="/" class="back"></a>
        <div class="title">
        	作业列表
        </div>
    </div>
</header>
<section id="packageList">
	<ul>
		<c:forEach items="${page.rows}" var="work" varStatus="status">
			<li>
				<a href="${ctx}/front/toWorkDetial?wId=${work.wId}" class="packageListItem">
					<p class="work_item">${fn:substring(work.wWorkName, 0, 15)}</p>
					<label>老师：${work.teacherName}</label>
					<label style="float: right;">布置时间：<fmt:formatDate  value="${work.wAddTime}"  pattern="yyyy-MM-dd HH:mm:ss" /></label>
				</a>
			</li>
		</c:forEach>
	</ul>
	<p class="work_page">
		<c:if test="${isPre}">
			<a class="pre" href="${ctx}/front/toWorkList?pageIndex=${page.pageIndex-2}">上一页</a>
		</c:if>
		<c:if test="${isNext}">
			<a class="next" href="${ctx}/front/toWorkList?pageIndex=${page.pageIndex}">下一页</a>
		</c:if>
	</p>

</section>
<!--app下载 底部飘浮 -->
<div id="backTop"></div>
<%@include file="footer.jsp" %>
</body>
</html>