<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
<title>成绩详情-作业系统</title>
<meta name="keywords" content="成绩详情-作业系统">
<meta name="description" content="成绩详情-作业系统">
<meta name="mobile-agent" content="format=xhtml;">
<meta name="applicable-devive" content="mobile">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="telephone=no" name="format-detection">
<%@include file="inc.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/static/front/work/work_detial.css"/>
	<style>
		.btn {
			display: inline-block;
			border-radius: 2rem;
			width: 4rem;
			height: 4rem;
			line-height: 4rem;
			background-color: #f98600;
			color: #fff;
			font-size: 1.8rem;
			text-align: center;
			vertical-align: middle;
			margin-right: 1rem;
		}
	</style>
</head>
<body>
<header>
	<div class="top_title">
        <a class="back"></a>
        <div class="title">
			成绩详情
        </div>
    </div>
</header>

<section>
	<div class="mome">
		<h2>分数</h2>
		<label class="btn" >${workInfo.wIScore}</label>
		<label class="work_item">${work.wWorkName}</label>
	</div>
	<div class="mome">
		<h2>答题详情</h2>
		<div style="text-align: left;font-size: 1.1rem;">
			<ul class="reply_list">
				<c:forEach items="${questionList}" var="question" varStatus="status" >
					<li>
						<p class="wen">${status.index + 1}、${question.qTitle}</p>
						<c:if test="${question.qType == 1}">
							<c:forEach items="${question.answerList}" var="answer">
								<c:if test="${question.qAnswer == answer.aAnswer}">
									<c:if test="${answer.aCorrect == 1}">
										<p style="font-size: 1.2rem;color: #00B83F;padding-left: 1.8rem;">${answer.aAnswer}</p>
									</c:if>
									<c:if test="${answer.aCorrect == 0}">
										<p style="font-size: 1.2rem;color: #FF0000;padding-left: 1.8rem;">${answer.aAnswer}</p>
									</c:if>
								</c:if>
								<c:if test="${question.qAnswer != answer.aAnswer}">
									<c:if test="${answer.aCorrect == 1}">
										<p style="font-size: 1.2rem;color: #00B83F;padding-left: 1.8rem;">${answer.aAnswer}</p>
									</c:if>
									<c:if test="${answer.aCorrect == 0}">
										<p style="font-size: 1.2rem;padding-left: 1.8rem;">${answer.aAnswer}</p>
									</c:if>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${question.qType == 2}">
							<c:forEach items="${question.answerList}" var="answer">
								<p name="qAnswer" class="msg_content" style="border: 1px solid #00B83F;height: auto;padding: 0.5rem;margin-bottom: 0.5rem;">${answer.aAnswer}</p>
							</c:forEach>
							<p name="qAnswer" class="msg_content" style="height: auto;padding: 0.5rem;">${question.qAnswer}</p>
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