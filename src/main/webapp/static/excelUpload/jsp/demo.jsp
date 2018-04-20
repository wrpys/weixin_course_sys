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

	//�ϴ��ļ��Ļ���,��ʾ���밴ť
    function displayExcelName(excel_fileName,excel_realName){
    	$('#excel_realName').html("�ļ��� "+excel_realName);
    	$('#excel_fileName').val(excel_fileName);
    	$('#btn_masterplate').hide();
    	//$('#btn_import').show(); �����xls����Ĺ���
    }
	
	
	//����xls���ݵ����ݿ� (�����Ҫ��xls���ݵ��뵽���ݿ�)
	function xlsImport(){
		//0: ����ɹ�, 1:����ʧ�ܻ��ѵ����, 2: �ļ�������, 3: �ļ�������
		var map = {
			excel_fileName : $('#excel_fileName').val()
		};
		$.post("xxxXlsImport.do",map,function(data){
			if(data == 0){
				alert('����ɹ�');
			}else if(data == 1){
				alert('����ʧ�ܻ��ѵ����');
			}else if(data == 2){
				alert('�ļ�������');
			}else if(data == 3){
				alert('�ļ�������');
			}
			//$('#form_search').submit();  ��xls������ݵ���󣬸����Լ�����Ҫ���Ƿ�ˢ�µ�ǰҳ��
		});
	}
</script>

<body>
	<!-- �����ļ�ģ�浯���� -->
	<div class="xls-master-plate" id="xlsMasterplate" >
		<span style="color: red; font-size: 20px">�����xls�ļ�����ģ��:</span>
		<table border="1px;" cellpadding="0" cellspacing="0"  width="100%" >
			<tr class="_tr" style="font-weight: bold">
				<td width="25%" >����</td>
				<td width="15%">��������</td>
				<td width="23%">ÿ����۸���ͼ�</td>
				<td width="23%">ÿ����۸���߼�</td>
				<td width="14%">�𲽼�</td>
			</tr>
			<tr class="_tr">
				<td>���� ���</td>
				<td>������</td>
				<td>10.00</td>
				<td>20.00</td>
				<td>5.00</td>
			</tr>
			<tr class="_tr">
				<td>�й����� ˹̫����</td>
				<td>������</td>
				<td>10.0</td>
				<td>20.0</td>
				<td>5.0</td>
			</tr>
			<tr class="_tr">
				<td>������EQ4243G��</td>
				<td>��������</td>
				<td>10</td>
				<td>20</td>
				<td>5</td>
			</tr>
		</table>
		<p class="p-btn">
			<a class="btn btn-closed" href="javascript:;"><span>�ر�</span></a>
		</p>
	</div>
	<div id="BackgroundDiv"></div>
	<!-- �����ļ�ģ�浯����end -->

	<div class="excel-upload-area">
		<input type="hidden" id="excel_fileName" value="" />
	    <span id="excel_realName" >ͨ��xls�ļ�����:</span>
		<iframe frameborder="0" scrolling="no" class="iframe-excel-upload" src="uploadExcel.jsp"></iframe>
	    <input type="button" id="btn_masterplate" value="�ļ�ģ��" onclick="showMasterplate();" />
	    <!-- <input type="button" id="btn_import" value="�����ļ�" onclick="xlsImport();"/>  -->
	    
    </div>
</body>
</html>