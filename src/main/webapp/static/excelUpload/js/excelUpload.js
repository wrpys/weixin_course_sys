
  //�������ھ�������
  jQuery.fn.center = function(){
	this.css('position','absolute');
	this.css('top',($(window).height() - this.height())/2 + $(window).scrollTop() + 'px');
	this.css('left',($(window).width() - this.width())/2 + $(window).scrollLeft() + 'px');
	return this;
}
   
   //�ļ�ģ�浯��������ʾ
   function showMasterplate(){
   	$('#xlsMasterplate').center().show();
   	var _h = $(document).height();
   	$('#BackgroundDiv').css({'opacity':'0.6','heigeh':_h }).show();
   }
   
   //�رյ�������
   $(function(){
   	var _fly = $('#xlsMasterplate');
   	var _bg = $('#BackgroundDiv');
   	_fly.find('.btn-closed').click(function(){
   		_fly.hide();
   		_bg.hide();
   	});
   })
   