
function gnb(param,obj,btn,wrap,dur,meth){
	var param = $(param);
	var btn = param.find(btn);
	var obj = param.find(obj);
	var wrap = $(wrap);
	var data = false;
	var th2 = obj.find("> li");
	var new_h = 0;
	var elem = 0;
	
	
	
	function _open(){
		$.each(obj,function(){if(new_h < $(this).parent().outerHeight()) new_h = $(this).parent().outerHeight(); });	
		obj.height(new_h); 
	}
	
	_open();


	
	btn.on('mouseover focusin', function(){
		elem = $(this).parent().index();
		$(this).addClass('on').siblings().removeClass('on');
		param.addClass('open');
		wrap.addClass('on');
// 		param.css({"height":new_h});
	});

	btn.on('mouseleave focusout', function(){
		btn.removeClass('on');
		param.removeClass('open');
		param.removeAttr("style");
		wrap.removeClass('on');
	});


	param.on('mouseleave focusout', function(){
		param.removeClass('open');
		param.removeAttr("style");
		wrap.removeClass('on');
	});


	$.each(th2,function(k){
		$(this).addClass("no"+(k+1));
	});

}

function gnb_open(){
	var param = $('#mobile-menu');
	var str = location.href;
	var n = 0;
	var dur = 300; // 애니메이션 진행 속도
	var meth = "easeOutExpo"; // 애니메이션 진행 타입


	param.find(".depth2_ul").hide();
	$("#mobile-menu .modal-dialog .modal-content .modal-body .depth1_ul .n1 .depth2_ul").show();

	param.find("a").on("click",function(event){
		if(param.is(":animated") && param.find(":animated").length){ return false; }
	});

	function hideMenu() {
		param.find('.collapse').hide().removeClass('ov');
	}
	param.find(".depth1_ul>li>a").on("click",function(event){
		n = $(this).parent().index();
		if($(this).next().attr("class").match("depth2_ul")){
			if($(this).next().css("display") == "none"){
				param.find(".depth1_ul>li>a").not(n).removeClass("ov").next().stop(true,true).delay(150).slideUp(150);
				param.find(".depth1_ul>li>a").eq(n).addClass("ov").next().stop(true,true).slideDown(150);
			}
		}
		event.preventDefault();
	});
	
	param.find(".depth2_ul>li>a").on("click",function(event){
		var t = $(this);
	
		if(t.next().attr("class").match("depth3_ul")){
			if(t.next().css("display") != "block"){
				t.addClass("ov");
				t.next().slideDown(150);
			}else{
				t.removeClass("ov");
				t.next().slideUp(150);
			}
	
			event.preventDefault();
		}
	});

	$(window).on('resize', function () {
		$('.mobile-close').click();

	});

}
