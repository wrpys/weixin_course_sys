$(function(){
	//返回顶部
	var backTop = $("#backTop");
	$(window).on("scroll", function() {
		if (parseFloat($(window).scrollTop()) > 10) {
			backTop.show();
		} else {
			backTop.hide();
		}
	})

	backTop.touchClick(function(event) {
		event.stopPropagation();
		event.preventDefault();
		$('body,html').animate({
			scrollTop: 0
		}, 100);
	});
	
	$(document).touchClick("header .back",function(e){  //返回 history 上一步
		e.preventDefault();
		e.stopPropagation();
		window.history.back();
	});
	
})