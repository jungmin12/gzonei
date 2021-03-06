
/*var closer =  document.getElementById('popup-closer');
			
			//팝업닫기
			closer.onclick = function() {
				  overlay.setPosition(undefined);
				  closer.blur();
				  setFeatureStyle(select.getFeatures().array_[0], "deselect");
				  return false;
				};*/


var map,clusterer;
var infoWindows= [];
var adjVal = 0.015;

$(document).ready(function(){
//전국개발정보 지도
	var zoomLevel1 = checkAuthValue('map001001','menuAccesAt');
	var zoomLevel2 = checkAuthValue('map001002','menuAccesAt');
	var zoomLevel3 = checkAuthValue('map001003','menuAccesAt');
	var moveCt = checkAuthValue('map002001','menuAccesAt');
	
	var maxLevel;
	if(zoomLevel3 =='Y'){
		maxLevel = '12';
	}else if(zoomLevel2 =='Y'){
		maxLevel = '10'
	}else {
		maxLevel = '7';
	}
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = { 
			center: new kakao.maps.LatLng(37.53318931874236, 126.99703117892415), // 지도의 중심좌표
			level: maxLevel, // 지도의 확대 레벨
			maxLevel: maxLevel,
			mapTypeId:  kakao.maps.MapTypeId.SKYVIEW
		}; 
	map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	/*clusterer = new kakao.maps.MarkerClusterer({
	    map: map,
	    averageCenter: true,
	    minLevel: maxLevel
	   
	});*/
	if(moveCt =='N'){
		map.setDraggable(false);
	}
	var lat,lon;
//	lat = '37.53590630313938',
//	lon = '126.90244355428192'; // 경도
//	mapInit(lat,lon);
	if (navigator.geolocation) {
		 navigator.geolocation.getCurrentPosition(showPosition,errorCallback);
		// GeoLocation을 이용해서 접속 위치를 얻어옵니다
		navigator.geolocation.watchPosition(function(position) {
			
		});
	} else { // HTML5의 GeoLocation을 사용할 수 없을때
		lat = '37.53590630313938',
		lon = '126.90244355428192'; // 경도
		mapInit(lat,lon);
	}
	
	function showPosition(position) {
		lat = position.coords.latitude, // 위도
		lon = position.coords.longitude; // 경도
		mapInit(lat,lon);
	}
	function errorCallback() {
		lat = '37.53590630313938',
		lon = '126.90244355428192'; // 경도
		mapInit(lat,lon);
	}

    var noticeTxt = $("#mcont4 .info ul li:first-child").html();
    $("#mcont4 .info .board_txt").empty();
    $("#mcont4 .info .board_txt").append(noticeTxt);

    $("#mcont4 .info ul li a").on('mouseover focus',function(){
        var noticeTxt = $(this).parent().html();
        $("#mcont4 .info ul li").removeClass("on");
        $(this).parent().addClass("on");
        $("#mcont4 .info .board_txt").empty();
        $("#mcont4 .info .board_txt").append(noticeTxt);
    });

    //상단 팝업존
    opOpen();
    opSlide();

    setInterval(function()
    {
       var text1 = $("#mvisual .search_box input").hasClass("text1");
       if(text1 == true){
           $("#mvisual .search_box input").attr("placeholder","도로명주소(지번) 또는 읍면동을 입력하세요");
           $("#mvisual .search_box input").removeClass("text1");
           $("#mvisual .search_box input").addClass("text2");
            
       }else{
		   $("#mvisual .search_box input").attr("placeholder","우리동네 개발사업이 궁금하세요?");
		   $("#mvisual .search_box input").removeClass("text2");
           $("#mvisual .search_box input").addClass("text1");
       }
       
    },2000);


    //메인비주얼 롤링스크립트
    mvisual();
    //샘플보기 롤링스크립트
    mcont4();


    //전국 개발 & 투자 스크롤 이벤트
	var container1 = $('#scroll_wrap1');
	var container2 = $('#scroll_wrap2');
	var container3 = $('#scroll_wrap3');
	var container4 = $('#scroll_wrap4');
	var container5 = $('#scroll_wrap5');
	var container6 = $('#scroll_wrap6');
	var container7 = $('#scroll_wrap7');
	var container8 = $('#scroll_wrap8');
	var windowWidth = $(window).width();

    if (windowWidth > 1023){
    	container1.mCustomScrollbar({ 
		    theme:"dark-1",
			autoHideScrollbar: "true"
		});
		container2.mCustomScrollbar({ 
			theme:"dark-1",
			autoHideScrollbar: "true"        
		});
		container3.mCustomScrollbar({ 
			theme:"dark-1",
			autoHideScrollbar: "true"        
		});
		container4.mCustomScrollbar({ 
			theme:"dark-1",
			autoHideScrollbar: "true"        
		});    
		container5.mCustomScrollbar({ 
			theme:"dark-1",
			autoHideScrollbar: "true"        
		});    
		container6.mCustomScrollbar({ 
			theme:"dark-1",
			autoHideScrollbar: "true"        
		});    
		container7.mCustomScrollbar({ 
			theme:"dark-1",
			autoHideScrollbar: "true"        
		});    
		container8.mCustomScrollbar({ 
			theme:"dark-1",
			autoHideScrollbar: "true"        
		});    
    }
	


  // 팝업존
    var param = "#popupzone",
        btn = ".controlBox",
        obj = ".item",
        auto = true,
        f = 1000,
        s = 5000,
        p = {use:true,type:null,path:".controlBox .number"},
        h = true;
    popzone(param,btn,obj,auto,f,s,p,h);



	var param = "#img_slide",
	obj = ".item",
	btn = "#img_slide .control",
	interval = 3000,
	speed = 300,
	viewSize = 0,
	moreSize = 0,
	dir = "x",
	data = 0,
	auto = true,
	hover = false,
	method = "easeInOutCubic",
	op1 = false;

	stateScrollObj(param,obj,btn,interval,speed,viewSize,moreSize,dir,data,auto,hover,method,op1);

	// 2021-05 menu animation add
	menu_animation_setup();
	$("#top_layout .open_info").addClass("none");
});

//지도배경 변경
function setMapType(maptype) { 
    var roadmapControl = document.getElementById('btnRoadmap');
    var skyviewControl = document.getElementById('btnSkyview'); 
    if (maptype === 'roadmap') {
        map.setMapTypeId(kakao.maps.MapTypeId.ROADMAP);    
        roadmapControl.className = 'selected_kakao_btn';
        skyviewControl.className = 'kakao_btn';
    } else {
        map.setMapTypeId(kakao.maps.MapTypeId.SKYVIEW);    
        skyviewControl.className = 'selected_kakao_btn';
        roadmapControl.className = 'kakao_btn';
    }
}


function mvisual()  { 
	var $mvisual = $("#mvisual_slide");	
    var $mainslider = $mvisual.find('.photo_list--slider');
  
	  $mainslider.slick({
		className: "center",
		centerMode: true,
		infinite: true,
		fade: true,
		autoplay:true,
		slidesToShow: 1,
        centerPadding: "0px",
        vertical: false,
		speed: 500
	  });
}  
$(window).scroll(function(){

    var offsetBottom = $("#mvisual").offset().top;
    var scrollTop = $(window).scrollTop();
    var wHeight = $(window).height() - $("#top_layout .fix").height();
//    console.log("scrollTop"+scrollTop);
//     console.log("wHeight"+wHeight);
    if(scrollTop>=wHeight){
    	$("#top_layout").addClass("fix");
		// 2021-05 menu class add
		$("#top_layout .open_info").addClass("isrunning");
		$("#top_layout .open_info").removeClass("bounce");
		$("#top_layout .open_info").removeClass("none");

    }else{
    	$("#top_layout").removeClass("fix");
		// 2021-05 menu class add
		if($("#top_layout .open_info").hasClass("isrunning")) {
			$("#top_layout .open_info").addClass("bounce");
			$("#top_layout .open_info").removeClass("gone");
		}
    }

    var mcont4Top = $("#mcont4").offset().top - 300;
//     console.log("mcont4Top"+mcont4Top);
    if(scrollTop>=mcont4Top){
    	$("#mcont4").addClass("on");
    }else{
    	$("#mcont4").removeClass("on");
    }

});
 $(window).resize(function(){

 	var container1 = $('#scroll_wrap1');
 	var container2 = $('#scroll_wrap2');
 	var container3 = $('#scroll_wrap3');
 	var container4 = $('#scroll_wrap4');
 	var container5 = $('#scroll_wrap5');
 	var container6 = $('#scroll_wrap6');
 	var container7 = $('#scroll_wrap7');
 	var container8 = $('#scroll_wrap8');
 	var windowWidth = $(window).width();


     if (windowWidth > 1023){
     	container1.mCustomScrollbar({ 
 		    theme:"dark-1",
 			autoHideScrollbar: "true"
 		});
 		container2.mCustomScrollbar({ 
 			theme:"dark-1",
 			autoHideScrollbar: "true"        
 		});
 		container3.mCustomScrollbar({ 
 			theme:"dark-1",
 			autoHideScrollbar: "true"        
 		});
 		container4.mCustomScrollbar({ 
 			theme:"dark-1",
 			autoHideScrollbar: "true"        
 		});    
 		container5.mCustomScrollbar({ 
 			theme:"dark-1",
 			autoHideScrollbar: "true"        
 		});    
 		container6.mCustomScrollbar({ 
 			theme:"dark-1",
 			autoHideScrollbar: "true"        
 		});    
 		container7.mCustomScrollbar({ 
 			theme:"dark-1",
 			autoHideScrollbar: "true"        
 		});    
 		container8.mCustomScrollbar({ 
 			theme:"dark-1",
 			autoHideScrollbar: "true"        
 		});    
     }

 });

function mcont4()  { 
	var $mcont4 = $("#mcont4_slide");	
    var $mainslider = $mcont4.find('.photo_list--slider');

    $mainslider.on('init', function(event, slick) {
			$mainslider.append('<div class="slick-counter"><span class="current"></span>/<span class="total"></span></div>');
			$mainslider.find('.current').text(slick.currentSlide + 1);
			$mainslider.find('.total').text(slick.slideCount);
		  })
	  $mainslider.on('beforeChange', function(event, slick, currentSlide, nextSlide) {
		$mainslider.find('.current').text(nextSlide + 1);
	  });



    var $mainslider_pause = $mcont4.find(".pause");
    var $mainslider_play = $mcont4.find(".play");
    $mainslider_play.hide();
    $mainslider_pause.on('click', function() {
        $mainslider_pause.hide();
        $mainslider_play.show().focus();
        $mainslider
            .slick('slickPause')
            .slick('slickSetOption', true);
    });
    $mainslider_play.on('click', function() {
        $mainslider_pause.show().focus();
        $mainslider_play.hide();
        $mainslider
            .slick('slickPlay')
            .slick('slickSetOption', true);
    });
  
	  $mainslider.slick({
		className: "center",
		centerMode: true,
		infinite: true,
		fade: true,
		autoplay:true,
		slidesToShow: 1,
        centerPadding: "0px",
        vertical: false,
		speed: 500,
		prevArrow : $mcont4.find('.prev'),
        nextArrow : $mcont4.find('.next')
	  });
	  $mainslider.slick('slickPlay').slick('slickSetOption', true);
}  


//op 오픈팝업 시작
function opOpen(){
	var _target = $("#op_layout");
	var _opBtn_open = _target.find(".opBtn_open");
	var _opBtn_close = _target.find(".opBtn_close a");

	_opClose();
	if(_target.find(".photo_list--item").length > 0){
		_opOpen();
	}
	
	_opBtn_open.click(function(){
		if(_target.find(".photo_list--item").length > 0){
			_opOpen();
		}
	});
	_opBtn_close.click(function(){
		_opClose();
	});
	function _opOpen(){
		if(!getCookie(document.todayChk_form.todayChk.name)){
			_target.removeClass("on").addClass("on");
			$("#mvisual").removeAttr("style");
			$("body").removeClass("open");
			
		}else{
			$('.opBtn_open').attr('style','display:none;');
		}
	}
	function _opClose(){
		if (document.todayChk_form.todayChk.checked) {
			setCookie(document.todayChk_form.todayChk.name,"done",1);
		}
		_target.removeClass("on");
		$("body").addClass("open");
		$("#mvisual").css("margin-top",0);
	}
	
	
	//쿠키 시작
	function setCookie( name, value, expiredays ){
		var todayDate = new Date();
	
		todayDate.setDate( todayDate.getDate() + expiredays );
		document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
	}
	
	function getCookie(name){ 
		var arg = name + "="; 
		var alen = arg.length; 
		var clen = document.cookie.length; 
		var i = 0; while(i< clen) 
		{ 
			var j = i + alen; 
			if(document.cookie.substring(i,j)==arg)
				{ 
				var end = document.cookie.indexOf(";",j); 
				if(end == -1) end = document.cookie.length;
				return unescape(document.cookie.substring(j,end)); 
				} 
			i=document.cookie.indexOf(" ",i)+1; 
			if (i==0) break; 
		} 
		return null; 
	}
	//쿠키 끝
}
//op 오픈팝업 끝




function opSlide()  { 
	var $opSlide = $("#op_slide");	
    var $mainslider = $opSlide.find('.photo_list--slider');
		$mainslider.on('init', function(event, slick) {
			$mainslider.append('<div class="slick-counter"><span class="current"></span>/<span class="total"></span></div>');
			$mainslider.find('.current').text(slick.currentSlide + 1);
			$mainslider.find('.total').text(slick.slideCount);
		  })
	  $mainslider.on('beforeChange', function(event, slick, currentSlide, nextSlide) {
		$mainslider.find('.current').text(nextSlide + 1);
	  });



    var $mainslider_pause = $opSlide.find(".pause");
    var $mainslider_play = $opSlide.find(".play");
    $mainslider_play.hide();
    $mainslider_pause.on('click', function() {
        $mainslider_pause.hide();
        $mainslider_play.show().focus();
        $mainslider
            .slick('slickPause')
            .slick('slickSetOption', true);
    });
    $mainslider_play.on('click', function() {
        $mainslider_pause.show().focus();
        $mainslider_play.hide();
        $mainslider
            .slick('slickPlay')
            .slick('slickSetOption', true);
    });
  
	  $mainslider.slick({
		className: "center",
		centerMode: true,
		infinite: true,
		autoplay:false,
		slidesToShow: 1,
        centerPadding: "0px",
        vertical: false,
		speed: 500,
		prevArrow : $opSlide.find('.prev'),
		nextArrow : $opSlide.find('.next'),
	  });
	  $mainslider.slick('slickPlay').slick('slickSetOption', true);
}

function mapInit(lat,lon){
	var resultList = [];
	var geocoder = new kakao.maps.services.Geocoder();
	//좌표 주소 위치 표출
 	var callback = function(result, status) {
	    if (status === kakao.maps.services.Status.OK) {
	    	var viewAddr = result[0].address.region_1depth_name + " " + result[0].address.region_2depth_name +" "+ result[0].address.region_3depth_name;
	    	$('#viewAddr').html(viewAddr);
	    }
	};
    $.ajax({
        type : 'POST',
        url : getContextPath()+"/selectLayer.do",
        async: false,
        datatype : 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        data: [{name:'lat',value:lat},{name:'lon',value:lon}],
        success : function(data){
        	//좌표 값에 해당하는 구 주소와 도로명 주소 정보를 요청합니다.
        	geocoder.coord2Address(lon, lat, callback);
        	
        	resultList = JSON.parse(data);
        	// 마커 이미지의 이미지 주소입니다
        	makeMaker(resultList,lat,lon);
        }
    });
}
	
function makeMaker(resultList,lat,lon) {
	var positions = resultList.LayerList;
	var dsCdList = resultList.dsCodeList;
	/*clusterer.clear();*/
	var imageSrc = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2)) + "/css/gzonei/SRC" + "/images/main/marker.png"; 
	// 썸네일 이미지 변경
	
	var bounds = new kakao.maps.LatLngBounds(); 
	for (var i = 0; i < positions.length; i ++) {

		// 마커 이미지의 이미지 크기 입니다
		var imageSize = new kakao.maps.Size(27, 34); 

		// 마커 이미지를 생성합니다    
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
		var position = new kakao.maps.LatLng(positions[i].lat, positions[i].lon);
		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
			map: map, // 마커를 표시할 지도
			position: position, // 마커를 표시할 위치
			title : positions[i].dwkNm, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
			image : markerImage,
			clickable: true  // 마커 이미지 
		});
		//인포윈도우
		
		/*infowindow = new kakao.maps.InfoWindow({
		    //position: new kakao.maps.LatLng(positions[i].lat, positions[i].lon),
			content: 
	    	//title : positions[i].dwkNm
		});*/
		
		
		
		kakao.maps.event.addListener(marker, 'click',(function(marker,i){
	        return function() {
				closeIw(i);
				var infowindow = new daum.maps.InfoWindow({
					content : createIwContent(positions[i], dsCdList),
					 zIndex: 1,
					removable : true
				});
				infowindow.open(map, marker);
				infoWindows.push(infowindow);
				
				var devlopInfoSn = positions[i].devlopInfoSn;
				var resData = getAjaxResult(devlopInfoSn, getContextPath()+"/devlopInfo/selectOldImgFileList.do");
				if(resData.oldFileMap){
					createMainImgFileMap(resData);
				}else{
					//대표이미지 썸네일 첨부파일 -- 05.25
					if(positions[i].thumbFileId){
						var thumbFileResult = getThumbFilesAjax("gz_devlop_info",positions[i].thumbFileId);
						if(thumbFileResult.atchFiles!=null &&thumbFileResult.atchFiles.length !=0){
							$('#iwThumbnailImgMap').attr('src','/file/displayFile.do?filePath=/upload/gzone/'+thumbFileResult.atchFiles[0].fileStreCours+'&fileName='+thumbFileResult.atchFiles[0].streFileNm);
						}
					}
				}
				
				
				// 마커에css 추가 적용
				var iwParentDiv = $('#mainIwPopup').parent().parent();
				iwParentDiv.css('width', '0');
				iwParentDiv.css('height', '0');
				iwParentDiv.children('div')[0].style.width = '0px';
				iwParentDiv.children('div')[0].style.height = '0px';
				var center = marker.getPosition();
				//조정값
				var moveLatLon = new kakao.maps.LatLng(center.Ma + adjVal, center.La);
				map.setCenter(moveLatLon);
			}
    	})(marker, i));
		//clusterer.addMarker(marker);
		bounds.extend(position);

	}
	var locPosition = new kakao.maps.LatLng(lat,lon)   
	displayMarker(locPosition);
	// 지도에 마커와 인포윈도우를 표시하는 함수입니다
	function displayMarker(locPosition, message) {
		// 지도 중심좌표를 접속위치로 변경합니다
		map.setCenter(locPosition)
	}
	map.setLevel(7);
	
}

function search(id){
	if(id=="address"){
		var geocoder = new kakao.maps.services.Geocoder();
		var searchKeyword = $('#address').val();
		//api 사용 자제 지오코딩 테스트
		if(searchKeyword != null){
			geocoder.addressSearch(searchKeyword, function(result, status) {
				if(status == "OK"){
					var lat = result[0].y;
					var lon = result[0].x;
			        mapInit(lat,lon);
			        var offset = $("#map").offset();
			        var winH = $(window).height();
			        $('html, body').animate({scrollTop : (offset.top - winH/4)}, 400);
			        
				}else{
					swal("정보가 없습니다.", "주소를 확인해 주세요!", "error");
				}
			});
		}
        
	}else{
		if (navigator.geolocation) {
		    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
		    navigator.geolocation.getCurrentPosition(function(position) {
		        
		        var lat = position.coords.latitude; // 위도
		        var lon = position.coords.longitude; // 경도
		        
		        var geocoder = new kakao.maps.services.Geocoder();
		        
		        var callback = function(result, status) {
		            if (status == kakao.maps.services.Status.OK) {
		            	$('#address').val(result[0].address.address_name);
		            }
		        };
		        
		        geocoder.coord2Address(lon,lat, callback);
		      });
		    
		} else { // HTML5의 GeoLocation을 사용할 수 없을때
			swal("현재위치를 찾을수 없습니다.", "현재위치 허용을 확인해 주세요!", "error");
		}
	}
}

function searchDevTop(id){
	console.log(id);
	//form 생성
	var form = document.createElement("form");
    form.setAttribute("charset", "UTF-8");
    form.setAttribute("method", "Post");  //Post 방식
    form.setAttribute("action", getContextPath()+"/map.do"); //요청 보낼 주소
    
    //input 생성 및 아이디값 입력
    var hiddenField = document.createElement("input");
    hiddenField.setAttribute("type", "hidden");
    hiddenField.setAttribute("name", "devlopInfoSn");
    hiddenField.setAttribute("value", id);
    form.appendChild(hiddenField);
    document.body.appendChild(form);
    
    form.submit();
}
function createIwContent(dataList,dsTrcList){
	//var devlopInfoSn = dataList.devlopInfoSn;
	//이미지 추가
	//면적 콤마 추가 (addcomma)
	var bsnsAr ="";
	if(dataList.bsnsArMeter) {
		bsnsAr +='		<tr class="mainMapTxt">                             ';
		bsnsAr +='			<td class="txtJust">                              ';
		switch(dataList.unitTy){
			case"길이":
				bsnsAr +='				길 이&nbsp:&nbsp                                ';
				bsnsAr +='			</td>                                             ';
				bsnsAr +='			<td>                                              ';
				bsnsAr += addComma(dataList.bsnsArMeter)+'km('+addComma(dataList.bsnsArPyeong)+'m)';
				break;
			default:
				bsnsAr +='				면 적&nbsp:&nbsp                                ';
				bsnsAr +='			</td>                                             ';
				bsnsAr +='			<td>                                              ';
				bsnsAr += addComma(dataList.bsnsArMeter)+'m<sup>2</sup> ('+addComma(dataList.bsnsArPyeong)+'평)';
				break;
		}
		bsnsAr +='			</td>                                             ';
		bsnsAr +='		</tr>                                                 ';
	}
	//사업기간
	var bsnsDe = "";
	if(null!=dataList.bsnsBgnde && ""!=dataList.bsnsBgnde && "undefined"!=dataList.bsnsBgnde){
		bsnsDe +='		<tr class="mainMapTxt">                             ';
		bsnsDe +='			<td class="txtJust">                              ';
		bsnsDe +='				사업기간&nbsp:&nbsp                              ';
		bsnsDe +='			</td>                                             ';
		bsnsDe +='			<td>                                              ';
		if(dataList.bsnsEndde!="undefined" && dataList.bsnsEndde!="" && dataList.bsnsEndde!=null){
			bsnsDe += strToDate(dataList.bsnsBgnde)+" ~ "+strToDate(dataList.bsnsEndde);
		}else{
			bsnsDe += strToDate(dataList.bsnsBgnde);
		}
		bsnsDe +='			</td>                                             ';
		bsnsDe +='		</tr>                                                 ';
	}
	//사업비
	var wct = "";
	if(null!=dataList.wct && ""!=dataList.wct && "undefined"!=dataList.wct){
		wct +='		<tr class="mainMapTxt">                             ';
		wct +='			<td class="txtJust">                              ';
		wct +='				사업비&nbsp:&nbsp                               ';
		wct +='			</td>                                             ';
		wct +='			<td>                                              ';
		wct += 				numberToKorean(dataList.wct);
		wct +='			</td>                                             ';
		wct +='		</tr>                                                 ';
	}
	
	//시행사
	/*var resultAjax = mainGetCodeAjax('CMMN','CP01000000');
	var opertnCmpny ="";
	if(null!=dataList.opertnCmpny && ""!=dataList.opertnCmpny && "undefined"!=dataList.opertnCmpny){
		
		opertnCmpny +='		<tr class="mainMapTxt">                                                  ';
		opertnCmpny +='			<td class="txtJust">                              ';
		opertnCmpny +='				시행사:                                         ';
		opertnCmpny +='			</td>                                             ';
		opertnCmpny +='			<td>                                              ';
		opertnCmpny += 			dataList.opertnCmpny;
		opertnCmpny +='			</td>			                                  ';
		opertnCmpny +='		</tr>                                                 ';
	}else if(null!=dataList.opertnCmpnyCode && ""!=dataList.opertnCmpnyCode && "undefined"!=dataList.opertnCmpnyCode){
		opertnCmpny +='		<tr class="mainMapTxt">                                                  ';
		opertnCmpny +='			<td class="txtJust">                              ';
		opertnCmpny +='				시행사:                                         ';
		opertnCmpny +='			</td>                                             ';
		opertnCmpny +='			<td>                                              ';
		opertnCmpny += 			mainCodeSet(resultAjax.codeList,dataList.opertnCmpnyCode);
		opertnCmpny +='			</td>			                                  ';
		opertnCmpny +='		</tr>                                                 ';
	}*/
	
	var iwContent =
	'<div id="mainIwPopup" class="ol-popup">'+
		'<div id="popup-content">'+
			'<div class="gzone__overlay">' +
				'<a href="javascript:void(0);"onclick="askMoreInfo();" class="link">' +
				'<table>                                                      '+
				'	<tbody>                                                   '+
				'		<tr>                                                  '+
				'			<td colspan="2">                                  '+
				'				<div class="thumbnail">' +
				'					<img class=\'thumbnailMainImgMap\' src=\''+getContextPath()+'/images/develop/noImage.png\'/>'+
				'				</div>' +
				'			</td>                                             '+
				'		</tr>                                                 '+
				'		<tr>                                                  '+
				'			<td colspan="2">                                  '+
				'				<strong>'+
									'<em>									  '+
									mainMapCodeSet(dsTrcList,dataList.bsnsDstrcCode)+
									'</em>									  '+
									dataList.dwkNm+
								'</strong>' +
				'			</td>                                             '+
				'		</tr>                                             	  '+
						bsnsAr 	+
						bsnsDe 	+
						wct 	+
				//		opertnCmpny +
				'		<tr><td colspan="2">                              	  '+
				'				<i>상세정보 보기</i>                                '+
				'			</td>                                             '+
				
				'		</tr>                                                 '+
				'	</tbody>	                                              '+
				'</table>                                                     '+
				'		</a>' +
				'				<a href="javascript:closeIw();" id="popup-closer" class="ol-popup-closer">닫기</a>' +
				/*'<div class="thumbnail">						  			  '+
				'	<img class=\'thumbnailMainImgMap\' src=\''+getContextPath()+'/images/develop/noImage.png\'/>'+
				'</div>										                  '+*/
		    '</div>' +
		'</div>'+
	'</div>';
	
	return iwContent;
}
function closeIw(){
	for ( var i = 0; i < infoWindows.length; i++ ) {
		infoWindows[i].setMap(null);
    }
	infoWindows = [];
	//infoWindows[this].setMap(null);
}
function askMoreInfo(){
	swal({
		  title: "정보를 더 원하십니까?",
		  text: "개발정보 페이지를 통해 다양한 정보를 제공받을 수 있습니다.",
		  icon: "info",
		  buttons: ["취소", "이동"]
		})
		.then(function(result) {
		  if (result) {
			  location.href= getContextPath()+"/map.do";
		  }
		});
}
function createMainImgFileMap(resData){
	var tumbnailHtml= '';
	var fileMap = resData.oldFileMap;
	if(fileMap!=null){
		if(!fileMap.fileDisNm){
			fileMap.fileDisNm = 'titleImg';
		}
		var ImgTag = $('.thumbnailMainImgMap');
		if(fileMap.fileNm){
			if(fileMap.fileNm.substring(0,3) == "BBS"){
				ImgTag.attr('src','/file/displayFile.do?filePath=/upload/gzone/'+fileMap.filePath+'&fileName='+fileMap.fileNm);
			}else{
				ImgTag.attr('src','/file/displayFile.do?filePath=/upload/gzone/images/develop/'+fileMap.filePath+'/'+fileMap.fileNm+'&fileName='+fileMap.fileNm);
			}
		}
		//ImgTag.attr('src','/sts_docs/images/develop/'+fileMap.filePath+'/'+fileMap.fileNm);
	}
}
function mainMapCodeSet(inputParam , dataParam){
	var result;
	inputParam.forEach(function(data, index){
		if(data.legaldongCode){
			if(data.legaldongCode == dataParam){
				result = data.lowestAreaNm;
			}
		}
		if(data.codeId){
			if(data.codeId == dataParam){
				result = data.codeIdNm;
			}
		}
	});
	return result;
}

function getAjaxResult(param, url){
	var resData
	$.ajax({
        type : 'POST',
        url : url,
        async: false,
        datatype : 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        data: {devlopInfoSn:param},
        success : function(data){
        	resData = JSON.parse(data);
	    },
	    error:function(e){
	    	console.log(e);
	    	alert(param+'조회 실패' + e);
		}
	});
	return resData;
}

//콤마 추가 (addcomma)
function addComma(num) {
	var result = '';
	if(num!=null){
		var regexp = /\B(?=(\d{3})+(?!\d))/g;
		result = num.toString().replace(regexp, ',')
	}
	return result;
}

function mainGetCodeAjax(codeKey,codeVal){
	var resultData;
	$.ajax({
        type : 'POST',
        url : getContextPath()+"/devlopInfo/selectCodeList.do",
        async: false,
        datatype : 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        data: {'codeKey':codeKey ,'codeVal':codeVal},
        success : function(data){
        	resultData = JSON.parse(data);
        },
        error:function(e){
        	console.log(e);
        	alert('select_CodeList_조회 실패' + e);
    	},complete:function(){
    	}
	});
	return resultData;
}

function mainCodeSet(inputParam , dataParam){
	var result;
	inputParam.forEach(function(data, index){
		if(data.legaldongCode){
			if(data.legaldongCode == dataParam){
				result = data.lowestAreaNm;
			}
		}
		if(data.codeId){
			if(data.codeId == dataParam){
				result = data.codeIdNm;
			}
		}
	});
	return result;
}

// 2021-05 menu animation listener add
function menu_animation_setup() {
	$(".open_info").on("animationend", function() {
		if($(this).hasClass('bounce')) {
			$(this).removeClass("bounce");
			$(this).addClass("gone");
		} else {
			$(this).removeClass("gone");
			$(this).addClass("none");
		}
	});
}

function strToDate(date_str)
{
	if(date_str){
		var totalDate = '';
		var sYear = date_str.substring(0,4);
		var sMonth = date_str.substring(4,6);
		var sDate = date_str.substring(6,8);
		if(sDate == '00' ){
			sDate = '00';
		}
		totalDate += sYear;
		if(sMonth!=""){
			totalDate += '.'+sMonth;
		}
		if(sDate!=""){
			totalDate += '.'+sDate;
		}
		return totalDate;
	}else{
		return null;
	}
}

function numberToKorean(number){
    var inputNumber  = number < 0 ? false : number;
    var unitWords    = ['', '만', '억', '조', '경'];
    var splitUnit    = 10000;
    var splitCount   = unitWords.length;
    var resultArray  = [];
    var resultString = '';

    for (var i = 0; i < splitCount; i++){
         var unitResult = (inputNumber % Math.pow(splitUnit, i + 1)) / Math.pow(splitUnit, i);
        unitResult = Math.floor(unitResult);
        if (unitResult > 0){
            resultArray[i] = unitResult;
        }
    }

    for (var i = 0; i < resultArray.length; i++){
        if(!resultArray[i]) continue;
        resultString = String(addComma(resultArray[i])) + unitWords[i] + ' ' +resultString;
    }
    resultString += '원';
    return resultString.replace(" 원","원");
}