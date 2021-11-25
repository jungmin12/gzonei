function tour_stateScrollObj(param,obj,btn,speed,data,method){
	var param = $(param);
	var btn = $(btn);
	var obj = param.find(obj);
	var objNum = obj.size();
    var winWidth = $(window).width();
	
    controlBox(objNum,winWidth);
    
    $(window).resize(function(){
    var winWidth = $(window).width();
    controlBox(objNum,winWidth);// 화면 resize 될때 window size 값을 호출한다
    })
    
    function controlBox(objNum,winWidth){
    //console.log(">>> objNum:"+objNum);
    //console.log(">>> winWidth:"+winWidth);
        if(winWidth > 1484){
            if(objNum > 6){
                btn.show();
            }else{
                btn.hide()
            }
        }else{
	        btn.show()
		}
    }
    
	var elem = 0;
	var data = data; // 0:default, 1:prev

	var getOffset, getBreak;

    // 종단 너비 구함
    var perTargelen = obj.length;

    function setDefault() {

	    obj.parent().removeAttr('style').css({ 
	        'width' : function(){

	            var result = 0;

	            for(var i=0; i<perTargelen; i++) {
	                
	                result += obj.eq(i).removeAttr('style').css({ 
	                    'width': obj.eq(i).width()
	                }).outerWidth(true);

	            }

	            return result;

	        }()

	    });

		getOffset = function() {
			var result = [];

			for(var i=0; i<obj.length; i++) {
				result[i] = i != 0 ? result[i-1] + obj.eq(i).outerWidth(true) : 0;
			}

			return result;
		}();

		getBreak = function() {
			var result = false;

			var clientBlock = obj.parent().parent().outerWidth();

			for(var i=0; i<obj.length; i++) {
				result = ( Math.floor(obj.eq(i).position().left + obj.eq(i).outerWidth(true)) ) > clientBlock;

				if(result) {
					result = i;
					break;
				}

			}

			return result;

		}();

	}

	// init
	setDefault();

	function movement(){
		if(data == 0){
			// next
			if(elem < obj.length-1) {
				elem++;
			}
		}

		if(data == 1){
			// prev
			if(elem > 0) {
				elem--;
			}
		}

		// 종단에 도달하거나 아닐때
		if(elem > ( obj.length - getBreak )) {
			elem = ( obj.length ) - getBreak;

		}else{
			
			obj.parent().stop(1, 0).animate({ 'left': getOffset[elem]*-1 }, {duration:speed,easing:method});
		}

	}

	btn.find("[data-control=prev]").on("click",function(event){
		if(obj.parent().find(":animated").size()) return false;
		data = 1;
		movement();

		return false;
	});

	btn.find("[data-control=next]").on("click",function(event){
		if(obj.parent().find(":animated").size()) return false;
		data = 0;
		movement();
		return false;
	});

	// 터치 이벤트  플리킹 구현
	var xStartpoint,xEndpoint;

	function docSTART(event){
		if(event.originalEvent.changedTouches != undefined){
			xStartpoint = Math.floor(event.originalEvent.changedTouches[0].clientX - $(this).offset().left);
		}
	}

	function docEND(event){
		if(event.originalEvent.changedTouches != undefined){
			xEndpoint = Math.floor(event.originalEvent.changedTouches[0].clientX - $(this).offset().left) - xStartpoint;
		
			if(xEndpoint < -50){ 
				data = 0;
			}else if(xEndpoint > 50){
				data = 1;
			}else{
				return true;
			} 

			movement();

			event.preventDefault();
		}
	}

	param.on("touchstart",docSTART);
	param.on("touchend",docEND);

	var rw, rh, rtime;

	$(window).resize(function() {
		var t = $(this);

		if(rw != t.width() || rh != t.height()) {
			clearTimeout(rtime);
			rtime = setTimeout(function() {
				return setDefault();

			}, 100);

			rw = rw || t.width(), rh = rh || t.height();
		}

	});

}