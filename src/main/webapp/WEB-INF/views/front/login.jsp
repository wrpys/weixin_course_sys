<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
<title>登录-作业系统</title>
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
	<div class="order_from" style="margin: 0rem 0 1rem 0;padding-top: 8rem;">
        <div class="tips" style="font-size: 5rem;height: 6rem;">作业系统</div>
        <form id="form" method="post" style="padding: 4rem;" action="${ctx}/front/login" onsubmit="return validateFun();">
            <p style="color: #FF0000;">${msg}</p>
            <table>
                <tbody>
                    <tr>
                        <td class="td_name">学号:</td>
                        <td class="td_value">
                            <input type="text" class="" name="sNo" value="" />
                        </td>
                    </tr>
                    <tr>
                        <td class="td_name">密码:</td>
                        <td class="td_value">
                            <input type="password" class="" value="" name="sPassword">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="td_sub">
                            <button class="btn_subimt" type="submit" onclick="">登录</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
    </div>
</section>
<%@include file="footer.jsp" %>
<script type="text/javascript">
    function validateFun() {
        var sNo = $("#form input[name='sNo']").val();
        var sPassword = $("#form input[name='sPassword']").val();
        if(sNo == null || sNo == '') {
            alert("请输入学号！");
            return false;
        }
        if(sPassword == null || sPassword == '') {
            alert("请输入密码！");
            return false;
        }
    }
</script>
</body>
</html>