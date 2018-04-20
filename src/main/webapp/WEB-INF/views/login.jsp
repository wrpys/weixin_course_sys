<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>作业系统-登录</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <meta http-equiv="Cache-Control" content="no-store"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="Expires" content="0"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <script type="text/javascript" language="javascript" src="${ctx}/static/jquery/jquery-1.11.0.min.js" ></script>

    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/static/images/favicon.ico">
    <link href="${ctx}/static/styles/com.css" rel="stylesheet" type="text/css" />

    <script>
        if (top.location != self.location) {
            top.location = self.location;
        }
        $(function(){
            var _height = $(window).height();
            $('.login-l').height(_height);

            $("#login-btn").click(function(){
                $("form").submit();
            });
        })

        function setInputFocus(_obj){
            $.each($(_obj),function(i,e){
                var _this = $(e);

                if(_this.val() == ''){
                    _this.css('color','#a3abbe').val(_this.attr('prompt'));
                }else{
                    _this.css('color','#a3abbe');
                }

                _this.focus(function(){
                    _this.css('color','#8b93a5');
                    if(_this.val() == _this.attr('prompt')){
                        _this.val('');
                    }
                }).blur(function(){
                            _this.css('color','#8b93a5');
                            if(_this.val() == '' || _this.val() == _this.attr('prompt')){
                                _this.css('color','#a3abbe').val(_this.attr('prompt'));
                            }
                        });
            })
        }
    </script>
</head>

<body>
<form action="${ctx}/login" method="post" class="form-horizontal">

    <div class="login">
        <div class="login-l">
            <img src="${ctx}/static/images/loginbg.jpg"/>
        </div>
        <div class="login-r" id="login">
            <h1><img src="${ctx}/static/images/j2ee_logo.jpg"  style="width:270px;height:150px;"/></h1>
            <div class="alert alert-error controls input-large">
                ${msg}
            </div>
            <p><input type="text" value="" prompt="登录账号" name="username"/></p>
            <p><input type="password" value="" name="password"/></p>
            <div class="clr"></div>

            <button class="a-login" id="login-btn" >登录</button>
        </div>
    </div>
</form>
<script type="text/javascript">setInputFocus('#login input')</script>
</body>
</html>
