<%@ page language="java"  pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<script type="text/javascript" language="javascript" src="../js/jquery-1.4.js"></script>
	
	<style type="text/css">
        *{margin: 0;padding: 0;}
        html,body{width: 62px;height: 24px;}
		.btn-upload { width:62px; height:24px; margin:0 auto; position:relative; overflow:hidden; cursor:pointer;
			background: url(../img/select_file.png); }
		.btn-upload input { width:62px; height:24px; border:0; position:absolute; right:0; top:0;  cursor:pointer; display:none; cursor:pointer; }
	</style>
	<script type="text/javascript">
		
		function changeExcel(path,realName){
		  //(注:200KB内,推荐100*100) 
		  if(path=="error.500"){
		  	alert("文件太大，请确保上传的文件大小在200KB以内．");
		  	return false;
		  }
		  $('.btn-upload').css('background','url(../img/reselect_file.png)');
            window.parent.displayFileName(path,realName);
		 
		}
		<c:if test="${r==1}">
			$(function(){
				changeExcel('${excel_fileName}','${excel_realName}');
			})
		</c:if>
		
		/*提交*/
		function mysubmit(){
			var pattern = new RegExp("^[ ]*$"); 
		 	if(pattern.test($("#file1").val())){
		  		alert("请先选择文件然后上传");
		  		return ;
		 	}
			var imgpattern = new RegExp(".jsp$|.html$|.htm$|.shtml$");
			if(imgpattern.test($("#file1").val())){
				$("#uploadExcel").submit();
			}else{
				alert("请选择正确的Excel文件格式(.jsp,.html,.htm,.shtml)");
			}
		}
		
		//设置上传文件按钮透明
		function setFileOpacity(){  
			$('#file1').css('opacity',0).show();
		}	
	</script>
	
	 
  </head>
  
  <body>
   <form action="upload.jsp"  id="uploadExcel" enctype="multipart/form-data" method="post" >
     <div class="btn-upload">
     	<input type="file" id="file1" name="file1" onchange="javascript:mysubmit();" value="${excel_fileName}"/>
     </div>
   </form>
   <script>setFileOpacity();</script>
  </body>
</html>

