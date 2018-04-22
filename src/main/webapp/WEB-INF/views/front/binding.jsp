<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
<title>绑定-课程系统</title>
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
    .td_value select {
        width: 21rem;
        height: 35px;
        border-radius: 4px;
        outline: 0px;
        border: 1px solid #ccc;
        padding-left: 10px;
    }
</style>
<body>
<section>
	<div class="order_from" style="margin: 0rem 0 1rem 0;padding-top: 8rem;">
        <div class="tips" style="font-size: 5rem;height: 6rem;">作业系统</div>
        <form id="form" method="post" style="padding: 4rem;" action="${ctx}/front/binding" onsubmit="return validateFun();">
            <input type="hidden" name="weixinId" value="${weixinId}">
            <p style="color: #FF0000;text-align: center;font-size: 1.8rem;">${msg}</p>
            <table>
                <tbody>
                    <tr>
                        <td class="td_name">角色:</td>
                        <td class="td_value">
                            <select name="operRole">
                                <option value="1">学生</option>
                                <option value="2">教师</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_name">账号:</td>
                        <td class="td_value">
                            <input type="text" class="" name="account" value="" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="td_sub">
                            <button class="btn_subimt" type="submit" onclick="">绑定</button>
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
        var operRole = $("#form select[name='sPassword']").val();
        var sNo = $("#form input[name='account']").val();
        if(sNo == null || sNo == '') {
            alert("请输入账号！");
            return false;
        }
    }
</script>
</body>
</html>