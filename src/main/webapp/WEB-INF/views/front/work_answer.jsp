<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
<title>答题-作业系统</title>
<meta name="keywords" content="答题-作业系统">
<meta name="description" content="答题-作业系统">
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
        	答题
        </div>
    </div>
</header>

<section>
	<div class="mome">
		<p class="work_item"><a style="color: #0f0f0f;" href="<%=request.getContextPath()%>/front/toWorkDetial?wId=${work.wId}">${fn:substring(work.wWorkName, 0, 15)}</a></p>
	</div>
	<div class="mome">
		<c:if test="${question == null}">
			<p style="text-align: center; font-size: 2rem;">答题结束，<a href="${ctx}/front/toWorkDetial?wId=${work.wId}" style="color: #f98600;">点击这里返回作业详情</a></p>
		</c:if>
		<c:if test="${question != null}">
		<form action="${ctx}/front/toAnswer" method="post" class="reply_list">
			<input type="hidden" name="wqId" value="${question.wqId}">
			<input type="hidden" name="wId" value="${work.wId}">
			<input type="hidden" name="qId" value="${question.qId}">
			<p class="wen" style="font-size: 2rem">${questionIndex}、${question.qTitle}</p>
			<c:if test="${question.qType == 1}">
				<ul>
					<c:forEach items="${question.answers}" var="answer">
						<li style="font-size: 1.8rem">
							<input type="radio" name="qAnswer" value="${answer.aAnswer}">${answer.aAnswer}
						</li>
					</c:forEach>
				</ul>
			</c:if>
			<c:if test="${question.qType == 2}">
				<textarea name="qAnswer" class="msg_content"></textarea>
			</c:if>
			<div class="oper" style="background: #FFFFFF; margin-top: 1rem;">
				<a class="btn" style="margin-left: auto; margin-right: auto; width: 70%;display: block;" onclick="submitForm();">确认</a>
			</div>
		</form>
		</c:if>
	</div>
</section>
<!--app下载 底部飘浮 -->
<div id="backTop"></div>
<%@include file="footer.jsp" %>
<script>
	var qType = "${question.qType}";
	function submitForm() {
		if (qType == "1") {
			var as = $("input[name='qAnswer']");
			var count = 0;
			for (var i=0;i<as.length;i++){
				if (!as[i].checked) {
					count++;
				}
			}
			if (count == as.length) {
				alert("请答题！");
				return ;
			}
		} else {
			var qAnswer = $("textarea[name='qAnswer']").val();
			if(qAnswer == null || qAnswer == "") {
				alert("请答题！");
				return ;
			}
		}
		$("form").submit();
	}
</script>
</body>
</html>