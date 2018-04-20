<%@ page language="java"  pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<script type="text/javascript" language="javascript" src="${ctx}/static/fileUpload/js/jquery-1.4.js"></script>
	
	<style type="text/css">
		.btn-upload { width:62px; height:24px; margin:0 auto; position:relative; overflow:hidden; cursor:pointer; background: url(../img/select_file.png); }
		.btn-upload input { width:62px; height:24px; border:0; position:absolute; right:0; top:0;  cursor:pointer; display:none; cursor:pointer; }
	</style>
	<script type="text/javascript">
		
		function changeFile(path,realName,fileSize){
		
		  <%-- 
		  if(path=="error.file_size_beyond"){
		  	  alert("文件太大，请确保上传的文件大小在200KB以内．");
		  	  return false;
		  }
		  --%>
		  $('.btn-upload').css('background','url(../img/reselect_file.png)');
		  window.parent.displayFileName(path,realName,fileSize);

		}
		<c:if test="${r==1}">
			$(function(){
				changeFile('${upload_fileName}','${original_fileName}','${fileSize}');
			})
		</c:if>
		
		/*提交*/
		function mysubmit(){
			var pattern = new RegExp("^[ ]*$"); 
		 	if(pattern.test($("#file1").val())){
		  		alert("请先选择文件然后上传");
		  		return ;
		 	}
            window.parent.showProgress();
		 	$("#form_upload_file").submit();
		}
		
		//设置上传文件按钮透明
		function setFileOpacity(){  
			$('#file1').css('opacity',0).show();
		}	
	</script>
	
	 
  </head>
  
  <body style="margin:4px;background: #FFFFFF">
   <form action="upload.jsp"  id="form_upload_file" enctype="multipart/form-data" method="post" >
     <div class="btn-upload">
     	<input type="file" id="file1" name="file1" onchange="javascript:mysubmit();" value="${upload_fileName}"/>
     </div>
   </form>
   
   <script>setFileOpacity();</script>
  </body>
</html>

