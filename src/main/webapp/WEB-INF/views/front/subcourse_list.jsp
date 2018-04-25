<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
    <title>${parentCourseName}-作业系统</title>
    <meta name="keywords" content="子课程列表-作业系统">
    <meta name="description" content="子课程列表-作业系统">
    <meta name="mobile-agent" content="format=xhtml;">
    <meta name="applicable-devive" content="mobile">
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="telephone=no" name="format-detection">
    <%@include file="inc.jsp" %>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/static/front/work/work_list.css"/>
    <style>
        .item{
            height: 4rem;
            width: 100%;
            border-bottom: 1px solid #ddd;
            background: #ffffff;
            margin-top: 0.5rem;
        }

        .li{
            float: left;
            border-right: 1px solid #DDD;
            height: 4rem;
            line-height: 4rem;
            text-align: center;
            font-size: 1.5rem;
            font-weight: 500;
        }
        a{
            display: inline-block;
        }
        img{
            height: 2rem;
            width:  2rem;
        }
    </style>
</head>
<body>
<header>
    <div class="top_title">
        <div class="title">
            子课程列表
        </div>
    </div>
</header>
<section>
    <ul>
        <c:forEach items="${subCourseList}" var="course" varStatus="status">
            <li class="item">
                <ul>
                    <li class="li" style="width: 8%;">
                        ${status.index}
                    </li>
                    <li class="li" style="width: 25%;">
                        ${course.cName}
                    </li>
                    <li class="li" style="width: 25%;">
                        <fmt:formatDate value="${course.cCreateTime}" pattern="yyyy-MM-dd" />
                    </li>
                    <li class="li" style="width: 20%;">
                        <p style="height: 2rem;line-height: 2rem;font-size: 1rem;">下载量：${course.downloadNum}</p>
                        <p style="height: 2rem;line-height: 2rem;font-size: 1rem;">热度：${course.heatNum}</p>
                    </li>
                    <li class="li" style="width: 18%;border: 0;">
                        <a style="height: 4rem;padding-top: 0.5rem;margin-right: 0.5rem;" href="${ctx}/front/downLoadFile?fId=${course.fId}&cId=${course.cId}">
                            <img src="${ctx}/static/images/download.png"/>
                        </a>
                        <a style="height: 4rem;padding-top: 0.5rem;" href="${ctx}/front/lookOver?weixinId=${weixinId}&cId=${course.cId}">
                            <img src="${ctx}/static/images/play.png"/>
                        </a>
                    </li>
                </ul>
                    <%--<a href="${ctx}/front/toWorkDetial?wId=${course.wId}" class="packageListItem">/a>--%>
                    <%--<label class="firstStyle">${status.index}</label>--%>
                    <%--<label class="firstStyle" style="width: 5rem;">${course.cName}</label>--%>
                    <%--<label class="firstStyle" style="width: 6rem;"><fmt:formatDate value="${course.cCreateTime}" pattern="yyyy-MM-dd" /></label>--%>
                    <%--<label style="width: 5rem;display: inline-block;">--%>
                        <%--<p style="height: 2rem;line-height: 2rem">下载量：${course.downloadNum}</p>--%>
                        <%--<p style="height: 2rem;line-height: 2rem">热度：${course.heatNum}</p>--%>
                    <%--</label>--%>
                    <%--<label style="width: 6rem;float: right;padding-top: 0.5rem;">--%>
                        <%--<a href="${ctx}/front/downLoadFile?fId=${course.fId}&cId=${course.cId}">--%>
                            <%--<img src="${ctx}/static/images/download.png"/>--%>
                        <%--</a>--%>
                        <%--<a href="${ctx}/front/lookOver?weixinId=${weixinId}&cId=${course.cId}">--%>
                            <%--<img src="${ctx}/static/images/play.png"/>--%>
                        <%--</a>--%>
                    <%--</label>--%>
            </li>
        </c:forEach>
    </ul>

</section>
<!--app下载 底部飘浮 -->
<div id="backTop"></div>
<%@include file="footer.jsp" %>
</body>
</html>