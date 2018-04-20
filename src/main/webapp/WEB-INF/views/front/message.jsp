<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
<title>讨论详情-作业系统</title>
<meta name="keywords" content="作业详情-作业系统">
<meta name="description" content="作业详情-作业系统">
<meta name="mobile-agent" content="format=xhtml;">
<meta name="applicable-devive" content="mobile">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="telephone=no" name="format-detection">
<%@include file="inc.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/static/front/work/work_detial.css"/>
<style>
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
	<div class="mome">
		<h2>基本信息</h2>
		<p class="work_item"><a style="color: #0f0f0f;" href="<%=request.getContextPath()%>/front/toWorkDetial?wId=${work.wId}">${fn:substring(work.wWorkName, 0, 15)}</a></p>
		<label>老师：${work.teacherName}</label>
		<label style="float: right;">布置时间：<fmt:formatDate  value="${work.wAddTime}"  pattern="yyyy-MM-dd HH:mm:ss" /></label>
	</div>
	<div class="mome">
		<h2>讨论列表</h2>
		<div>
			<c:if test="${isDis == false}">
				<p style="font-size: 1.5rem;">暂无讨论，
					<a href="<%=request.getContextPath()%>/front/toDiscussQuestionPage?wId=${work.wId}" style="color: #f98600;">点击这里发起讨论</a>
				</p>
			</c:if>
			<c:if test="${isDis == true}">
				<a href="<%=request.getContextPath()%>/front/toDiscussQuestionPage?wId=${work.wId}" style="font-size: 1.5rem;color: #f98600;">点击这里发起讨论</a>
				<ul class="reply_list">
					<c:forEach items="${messageExts}" var="message" >
						<li>
							<p class="wen">(${message.operName})问：${message.msgContent}</p>
							<c:if test="${message.messageExts == null}">
								<p style="height: 3rem;">
									<a class="btn" href="<%=request.getContextPath()%>/front/toReplyPage?wId=${work.wId}&msgId=${message.msgId}&msgContent=${message.msgContent}">回复</a>
								</p>
							</c:if>
							<c:if test="${message.messageExts != null}">
								<c:forEach items="${message.messageExts}" var="m" varStatus="status">
									<p class="da">(${m.operName}${m.operRoleName})答：${m.msgContent}</p>
									<c:if test="${fn:length(message.messageExts) == status.index + 1}">
									<p style="height: 3rem;">
										<a class="btn" href="<%=request.getContextPath()%>/front/toReplyPage?wId=${work.wId}&msgId=${m.msgId}&msgContent=${m.msgContent}">回复</a>
									</p>
									</c:if>
								</c:forEach>
							</c:if>
						</li>
					</c:forEach>
				</ul>
			</c:if>
		</div>
	</div>
</section>
<!--app下载 底部飘浮 -->
<div id="backTop"></div>
<%@include file="footer.jsp" %>
</body>
</html>