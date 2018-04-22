<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <%@include file="../layouts/default.jsp"%>
</head>
<html>
<body>
<div class="container" style="height:auto;">
    
	<form id="uploadFile" action="${ctx}/course/uploadFile" method="post" enctype="multipart/form-data">
			    选择一个文件:
		    <input type="file" name="file" id="file" />
		    <input type="hidden" name="cId" id="cId" value="${cId}" />
		    <br/><br/>
		    <button type="submit" id="submit" class="button button-primary">上传</button>
	</form>
</div>
</body>
</html>
