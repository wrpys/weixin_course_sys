<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<footer>
	<nav class="bottom_menu" style="background: #B7D2E7;height: 4rem;">
		<label>发言：</label><input type="text" name="msgContent" id="msgContent" > <button class="btn" id="submitBtn">发送</button>
	</nav>
	<h3>经营许可证：闽ICP备XXXXXXXXXXXXXXXXX号</h3>
	<h3 class="gongsi login_hide">
		<a href="${ctx}/front/toCourse?cId=${cId}weixinId=${weixinId}" style="line-height: 2.5rem; color: rgb(178, 178, 178);">课程列表</a>
	</h3>
</footer>
<script charset="utf-8" src="<%=request.getContextPath()%>/static/front/js/jquery-2.2.3.min.js"></script>
<script charset="utf-8" src="<%=request.getContextPath()%>/static/front/js/mobile_extend.js"></script>
<script charset="utf-8" src="<%=request.getContextPath()%>/static/front/js/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/static/front/js/swiper-3.3.1.jquery.min.js" ></script>