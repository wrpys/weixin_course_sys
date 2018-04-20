
  //弹出窗口居中设置
  jQuery.fn.center = function(){
	this.css('position','absolute');
	this.css('top',($(window).height() - this.height())/2 + $(window).scrollTop() + 'px');
	this.css('left',($(window).width() - this.width())/2 + $(window).scrollLeft() + 'px');
	return this;
}
   
   //文件模版弹出窗口显示
   function showMasterplate(){
   	$('#xlsMasterplate').center().show();
   	var _h = $(document).height();
   	$('#BackgroundDiv').css({'opacity':'0.6','heigeh':_h }).show();
   }
   
   //关闭弹出窗口
   $(function(){
   	var _fly = $('#xlsMasterplate');
   	var _bg = $('#BackgroundDiv');
   	_fly.find('.btn-closed').click(function(){
   		_fly.hide();
   		_bg.hide();
   	});
   })
   