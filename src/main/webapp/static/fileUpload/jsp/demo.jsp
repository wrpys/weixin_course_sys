<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>upload file demo</title>
<link href="../css/fileUpload.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" language="javascript" src="../js/jquery-1.4.js"></script>
<script>

	//文件上传后名称的回显
    function displayFileName(upload_fileName,original_fileName){
    	$('#original_fileName').html("文件： "+original_fileName);
    	$('#upload_fileName').val(upload_fileName);
    }
	
</script>

<body>
	<div class="file-upload-area">
		<input type="hidden" id="upload_fileName" value="" />
	    <span id="original_fileName" >上传文件:</span>
		<iframe frameborder="0" scrolling="no" class="iframe-file-upload" src="uploadFile.jsp"></iframe>
    </div>
</body>
</html>