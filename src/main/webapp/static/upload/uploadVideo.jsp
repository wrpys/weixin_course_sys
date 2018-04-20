<%@ page language="java"  pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <script type="text/javascript" language="javascript" src="${ctx}/static/jquery/jquery-1.4.js"></script>

    <style type="text/css">
        .btn { width:62px; height:24px; margin:0; position:relative; overflow:hidden; cursor:pointer; background:url(${ctx}/static/images/btn_upload.gif); }
        .btn input { width:62px; height:24px; border:0; position:absolute; right:0; top:0;  cursor:pointer; display:none; }

        .clear_btn { width:0px; height:0px; overflow:hidden; cursor:pointer; background:url(${ctx}/static/images/btn_del.gif);margin-left: 67px;margin-top: -24px;}
        .clear_btn input{ width:62px; height:24px; border:0; position:absolute; right:0; top:0;  cursor:pointer; display:none; }
    </style>

    <script type="text/javascript">
        function changeImg(path){
            //如果图片上传超出容量限制
            if(path=="error.file_size_beyond"){
                alert("1、视频太大，请确保上传的图片大小在${maxsize}KB以内．");
                return false;
            }

            <%--window.parent.fillImagesPic(path,"${picImg}","${picInput}","${picArea}","${upload_folder}","${width}","${height}");--%>

        }

        <c:if test="${r==1}">changeImg('${img_fileName}');</c:if>

        function mysubmit(){
            var pattern = new RegExp("^[ ]*$");
            if(pattern.test($("#picFile").val())){
                alert("请先选择视频然后上传");
                return ;
            }
            var imgpattern = new RegExp(".avi$|.rmvp$|.rm$|.asf$.wmv$|.mp4$");
            if(imgpattern.test($("#picFile").val())){
                $("#formUploadMorePic1").submit();
            }else{
                alert("请选择正确的视频格式(.avi,.rmvp,.rm,.asf,wmv,mp4)");
            }
        }

        //设置上传文件按钮透明
        function setFileOpacity(){
            $('#picFile').css('opacity',0).show();
        }

        //清除图片
        function clearPic(){
            window.parent.clearImagesPic("${param.picImg}","${param.picInput}","${param.picArea}");
        }
    </script>

</head>

<body style="margin:0px;background: #FFFFFF">
<form action="upload1.jsp?picImg=${param.picImg}&width=${param.width}&height=${param.height}&picInput=${param.picInput}&picArea=${param.picArea}&upload_folder=${param.upload_folder}&maxsize=${param.maxsize}"
      name="formUploadMorePic1" id="formUploadMorePic1" enctype="multipart/form-data" method="post" >
    <div class="btn"><input type="file" id="picFile" name="picFile" onchange="javascript:mysubmit();"/></div>
    <div class="clear_btn" onclick="clearPic();"><input type="button" value="" /></div>
</form>
<script>setFileOpacity();</script>

</body>
</html>