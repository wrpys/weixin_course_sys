$.fn.extend({
	"touchClick":function(select,callback){   //移动端 点击事件 单击
		var se = (select != "" && !$.isFunction(select)) ? select : "";
		var cb = $.isFunction(select) ? select : callback;
		$(this).each(function(index, element) {
			var tc = false;
			$(this).on({
				"touchstart":function(){tc = true;},
				"touchmove":function(){tc = false;},
				"touchend":function(event){
					event.index = index;
					tc ? $.isFunction(cb) ? cb.call(element, event) : "" : "";
				}
			},se);
		});
	},
    "dbTouchClick": function(callback) { //移动端 点击事件 双击击
        $(this).each(function(index, element) {
            var startPoint = {};
            var startTime, endTime;
            var _X, _Y;
            $(this).on("touchstart", function () {
                var event = arguments[0].originalEvent;
                startTime = event.timeStamp;
                if (endTime && (startTime - endTime < 200)) {
                    _X = Math.abs(event.touches[0].clientX - startPoint.X);
                    _Y = Math.abs(event.touches[0].clientY - startPoint.Y);
                    if(17 > _X && _Y < 17 && (typeof callback === "function")) {
                        callback(event);
                    }
                }
                startPoint.X = event.touches[0].clientX;
                startPoint.Y = event.touches[0].clientY;
            });
			$(this).on("touchmove", function () {
				endTime = 0;
			});
            $(this).on("touchend", function () {
                var event = arguments[0].originalEvent;
                if(event.touches.length === 0) {
                    endTime = event.timeStamp;
                }
            });
        });
    }
});