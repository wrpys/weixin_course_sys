<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
<title>提问详情-作业系统</title>
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
        	提问详情
        </div>
    </div>
</header>

<section>
	<div class="mome">
		<h2>基本信息</h2>
		<p class="work_item"><a style="color: #0f0f0f;" href="<%=request.getContextPath()%>/front/toWorkDetial?wId=${work.wId}">${fn:substring(work.wWorkName, 0, 15)}</a></p>
	</div>
	<div class="oper">
		<a class="btn" style="margin-left: auto; margin-right: auto; width: 70%;display: block;" href="<%=request.getContextPath()%>/front/toQuestionsPage?wId=${work.wId}">提问</a>
	</div>
	<div class="mome">
		<h2>提问列表</h2>
		<div>
			<ul class="reply_list">
				<c:forEach items="${qms}" var="qm" >
					<li>
						<p class="wen">问：${qm.studentContent}</p>
						<c:if test="${qm.teacherName != null}">
							<p class="da">(${qm.teacherName})答：${qm.teacherContent}</p>
						</c:if>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>
</section>
<!--app下载 底部飘浮 -->
<div id="backTop"></div>
<%@include file="footer.jsp" %>
</body>
</html>