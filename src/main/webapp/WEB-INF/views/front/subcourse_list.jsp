<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
    <title>子课程列表-作业系统</title>
    <meta name="keywords" content="子课程列表-作业系统">
    <meta name="description" content="子课程列表-作业系统">
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
            子课程列表
        </div>
    </div>
</header>
<section id="packageList">
    <ul>
        <c:forEach items="${subCourseList}" var="course" varStatus="status">
            <li>
                    <%--<a href="${ctx}/front/toWorkDetial?wId=${course.wId}" class="packageListItem">/a>--%><
                    <label>${status.index}</label>
                    <p class="work_item">${course.cName}</p>
                    <label style="float: right;"><fmt:formatDate value="${course.cCreateTime}" pattern="yyyy-MM-dd HH:mm:ss" /></label>
                    <label>
                        下载量：${course.downloadNum}
                        热度：${course.heatNum}
                    </label>
                    <label>
                        <a href="${ctx}/front/downLoadFile?fId=${course.fId}&cId=${course.cId}" class="packageListItem">
                            <img src="${ctx}/static/images/download.png">
                        </a>
                    </label>
                    <label>
                        <a href="${ctx}/front/lookOver?weixinId=${weixinId}&cId=${course.cId}" class="packageListItem">
                            <img src="${ctx}/static/images/play.png"/>
                        </a>
                    </label>
            </li>
        </c:forEach>
    </ul>

</section>
<!--app下载 底部飘浮 -->
<div id="backTop"></div>
<%@include file="footer.jsp" %>
</body>
</html>