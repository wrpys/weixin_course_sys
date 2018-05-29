<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
    <title>${parentCourseName}</title>
    <meta name="mobile-agent" content="format=xhtml;">
    <meta name="applicable-devive" content="mobile">
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="telephone=no" name="format-detection">
    <%@include file="inc.jsp" %>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/static/front/work/work_list.css"/>
    <style>
        body {
            background: #E3F0F0;
        }
        .item{
            height: 4.5rem;
            width: 99%;
            border-top: 1.5px solid #A9C4D6;
            border-bottom: 1.5px solid #A9C4D6;
            border-right: 1.5px dashed #AECADF;
            border-left: 1.5px dashed #AECADF;
            background: #C1DCED;
            margin-top: 1rem;
        }
        .li{
            float: left;
            border-right: 1.5px dashed #AECADF;
            height: 4.5rem;
            line-height: 4.5rem;
            text-align: center;
            font-size: 1.5rem;
            font-weight: 500;
        }
        a{
            display: inline-block;
        }
        .ul-content img{
            height: 2.2rem;
            width:  2.2rem;
        }
        .no_course {
            width: 30%;
            margin-left: auto;
            margin-right: auto;
            display: block;
            margin-top: 40%;
        }
        .no_course_title {
            width: 100%;
            text-align: center;
            font-size: 1.5rem;
        }
    </style>
</head>
<body>
<section>
    <c:if test="${not empty subCourseList}">
    <ul class="ul-content">
        <c:forEach items="${subCourseList}" var="course" varStatus="status">
            <li class="item">
                <ul>
                    <li class="li" style="width: 10%;">
                        ${status.index + 1}
                    </li>
                    <li class="li" style="width: 27%;">
                        ${course.cName}
                    </li>
                    <li class="li" style="width: 20%;">
                        <p style="height: 2.25rem;line-height: 2.25rem;font-size: 1.1rem;">${course.userName}</p>
                        <p style="height: 2.25rem;line-height: 2.25rem;font-size: 1.1rem;"><fmt:formatDate value="${course.cCreateTime}" pattern="yyyy.MM.dd" /></p>
                    </li>
                    <li class="li" style="width: 20%;">
                        <p style="height: 2.25rem;line-height: 2.25rem;font-size: 1.1rem;">下载量：${course.downloadNum}</p>
                        <p style="height: 2.25rem;line-height: 2.25rem;font-size: 1.1rem;">热度：${course.heatNum}</p>
                    </li>
                    <li class="li" style="width: 10%;">
                        <c:if test="${not empty course.fId}">
                        <a style="height: 4rem;padding-top: 0.65rem;" href="${ctx}/front/downLoadFile?fId=${course.fId}&cId=${course.cId}&weixinId=${weixinId}">
                            <img src="${ctx}/static/front/images/icons/down.png"/>
                        </a>
                        </c:if>
                        <c:if test="${empty course.fId}">
                            <p style="font-size: 1.1rem;">暂无</p>
                        </c:if>
                    </li>
                    <li class="li" style="width: 10%;border: 0;">
                        <a style="height: 4rem;padding-top: 0.65rem;" href="${ctx}/front/lookOver?weixinId=${weixinId}&cId=${course.cId}">
                            <img src="${ctx}/static/front/images/icons/look.png"/>
                        </a>
                    </li>
                </ul>
            </li>
        </c:forEach>
    </ul>
    </c:if>
    <c:if test="${empty subCourseList}">
        <img class="no_course" src="${ctx}/static/front/images/no_course.png">
        <p class="no_course_title">暂无课程</p>
    </c:if>

</section>
<!--app下载 底部飘浮 -->
<div id="backTop"></div>
<%@include file="footer.jsp" %>
</body>
</html>