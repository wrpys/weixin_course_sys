<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
<title>操作成功-课程系统</title>
<meta name="mobile-agent" content="format=xhtml;">
<meta name="applicable-devive" content="mobile">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="telephone=no" name="format-detection">
<%@include file="inc.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/static/front/work/main.css"/>
<style>
    .login_hide{
        display: none;
    }
</style>
<body>
<section>
	<div class="order_from" style="margin: 0rem 0 1rem 0;padding-top: 8rem;padding-bottom: 8rem;">
        <p style="color: #00B83F;text-align: center;font-size: 2rem;">${msg}</p>
    </div>
</section>
<%@include file="footer.jsp" %>
</body>
</html>