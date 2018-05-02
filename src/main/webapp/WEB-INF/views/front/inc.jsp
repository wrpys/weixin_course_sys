<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
	var contextPath = "${ctx}";
</script>
<link href="<%=request.getContextPath()%>/static/front/css/application.css" rel="stylesheet">
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/front/work/index.css" />