<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>upload excel demo</title>
<link href="../css/excelUpload.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" language="javascript" src="../js/jquery-1.4.js"></script>
<script type="text/javascript" src="../js/excelUpload.js"></script>
<script>

	//上传文件的回显,显示导入按钮
    function displayExcelName(excel_fileName,excel_realName){
    	$('#excel_realName').html("文件： "+excel_realName);
    	$('#excel_fileName').val(excel_fileName);
    	$('#btn_masterplate').hide();
    	//$('#btn_import').show(); 如果有xls导入的功能
    }
	
	
	//导入xls数据到数据库 (如果需要将xls数据导入到数据库)
	function xlsImport(){
		//0: 导入成功, 1:导入失败或已导入过, 2: 文件不存在, 3: 文件无数据
		var map = {
			excel_fileName : $('#excel_fileName').val()
		};
		$.post("xxxXlsImport.do",map,function(data){
			if(data == 0){
				alert('导入成功');
			}else if(data == 1){
				alert('导入失败或已导入过');
			}else if(data == 2){
				alert('文件不存在');
			}else if(data == 3){
				alert('文件无数据');
			}
			//$('#form_search').submit();  将xls里的数据导入后，根据自己的需要，是否刷新当前页面
		});
	}
</script>

<body>
	<!-- 导入文件模版弹出框 -->
	<div class="xls-master-plate" id="xlsMasterplate" >
		<span style="color: red; font-size: 20px">导入的xls文件内容模版:</span>
		<table border="1px;" cellpadding="0" cellspacing="0"  width="100%" >
			<tr class="_tr" style="font-weight: bold">
				<td width="25%" >车型</td>
				<td width="15%">出发城市</td>
				<td width="23%">每公里价格最低价</td>
				<td width="23%">每公里价格最高价</td>
				<td width="14%">起步价</td>
			</tr>
			<tr class="_tr">
				<td>东风 天锦</td>
				<td>福州市</td>
				<td>10.00</td>
				<td>20.00</td>
				<td>5.00</td>
			</tr>
			<tr class="_tr">
				<td>中国重汽 斯太尔王</td>
				<td>杭州市</td>
				<td>10.0</td>
				<td>20.0</td>
				<td>5.0</td>
			</tr>
			<tr class="_tr">
				<td>东风牌EQ4243G型</td>
				<td>哈尔滨市</td>
				<td>10</td>
				<td>20</td>
				<td>5</td>
			</tr>
		</table>
		<p class="p-btn">
			<a class="btn btn-closed" href="javascript:;"><span>关闭</span></a>
		</p>
	</div>
	<div id="BackgroundDiv"></div>
	<!-- 导入文件模版弹出框end -->

	<div class="excel-upload-area">
		<input type="hidden" id="excel_fileName" value="" />
	    <span id="excel_realName" >通过xls文件导入:</span>
		<iframe frameborder="0" scrolling="no" class="iframe-excel-upload" src="uploadExcel.jsp"></iframe>
	    <input type="button" id="btn_masterplate" value="文件模版" onclick="showMasterplate();" />
	    <!-- <input type="button" id="btn_import" value="导入文件" onclick="xlsImport();"/>  -->
	    
    </div>
</body>
</html>