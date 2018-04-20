<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
	var contextPath = "${ctx}";
</script>
<script type="text/javascript">
	//var hostRoot = "http://localhost:8099/WeddingPhoto";
	var hostRoot = "http://hebengg.com";
	//var mHostRoot = "http://localhost:8099/WeddingPhoto_mobile";
	var mHostRoot = "http://mobile.hebengg.com";
	var contextPath = "<%=request.getContextPath()%>";

	//pc访问移动端网站自动跳转到pc网站
	function mobile_device_detect(url){
		var flag = false;//移动端。否
		var thisOS=navigator.platform;
		var os=new Array("iPhone","iPod","iPad","android","Nokia","SymbianOS","Symbian","Windows Phone","Phone","Linux armv71","MAUI","UNTRUSTED/1.0","Windows CE","BlackBerry","IEMobile");
		for(var i=0;i<os.length;i++){
			if(thisOS.match(os[i])){  
				flag = true;
			}
		}
		//因为相当部分的手机系统不知道信息,这里是做临时性特殊辨认
		if(navigator.platform.indexOf('iPad') != -1){
			flag = true;
	 	}
	 	//做这一部分是因为Android手机的内核也是Linux
	 	//但是navigator.platform显示信息不尽相同情况繁多,因此从浏览器下手，即用navigator.appVersion信息做判断
	  	var check = navigator.appVersion;
	  	if(check.match(/linux/i) ){
	   		//X11是UC浏览器的平台 ，如果有其他特殊浏览器也可以附加上条件
	   		if(check.match(/mobile/i) || check.match(/X11/i))
	   			flag = true;
	   	}
	  	if(!flag){
	  		window.location=url;
	  	}
	 }
	
</script>
<link href="<%=request.getContextPath()%>/static/front/css/application.css" rel="stylesheet">
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/front/work/index.css" />