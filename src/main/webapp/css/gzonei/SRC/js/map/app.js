
jQuery.loadScript = function (url, callback) {
    jQuery.ajax({
        url: url,
        dataType: 'script',
        success: callback,
		error : function(err){
			console.log('스크립트 로드  실패');
		},
        async: true
    });
};

$(function(){
	var init,
		frontData,
		dataInfo = new Object(),
		dataItem = new Array(),
		dataSetup,
		mapSetup,
		navControl,
		manuscript;
	
	var mapType,
		mapContainer,
		mapOptions,
		map,
		locPosition,
		imageSrc,
		imageSize,
		markerImage,
		bounds;
	
	var tempDownControl,
		tempMoreControl,
		tempSideControl,

	
	init = function(){
		dataSetup();
		navControl();
		submitControl();
		tempSideControl();
		adminSideControl();
		modalPop();
		searchDetail();
		toolTip();
		fn_scroll_plugin();
		accordionControl();
		sideSearchControl();
		infoSideControl();
		sideMenu__mode();

	};
	dataSetup = function(){
		mapSetup("naver");
	};
	accordionControl = function(){
		var accordion = $(".mapAll"); 
		var list = accordion.find(".list");
		var accordion_button = accordion.find(".minus2");
		
		accordion_button.on('click', function(){
			if(!$(this).parent().parent().hasClass('open')){
			
				list.removeClass('open');
				$('.mapsCont').removeClass('open');
				$(this).parent().parent().addClass('open');
				$(this).next('.list').addClass('open');
				
			}
			
			
		
		});
		
	};
	submitControl = function(){
		var submit = $(".submit");
		var closeResult = $("#searchResult .close");
		submit.on('click', function(){
			var submitType = $(this).data('id');
			switch (submitType) {
				case 'area':	
				areaSetup();
				break;
				case 'biz':
				bizSetup();
				break;
				default:
					
				break;
			}
		});
		closeResult.on('click', function(){
			$("#searchResult").hide();
		});
	};
	areaSetup = function(){
		$("#searchResult").show();
		$(".searchResult__obj").mCustomScrollbar({
			theme:"dark-1",
 			autoHideScrollbar: "true",
			mouseWheelPixels : 300, // 마우스휠 속도
			scrollInertia : 400 // 부드러운 스크롤 효과 적용
		});
	};
	bizSetup = function(){
		$("#searchResult").show();
		$(".searchResult__obj").mCustomScrollbar({
			theme:"dark-1",
 			autoHideScrollbar: "true",
			mouseWheelPixels : 300, // 마우스휠 속도
			scrollInertia : 400 // 부드러운 스크롤 효과 적용
		});
	};
	navControl = function(){
		var tab = $(".link-tab a");
		tab.on("click", function(event){
			if (event.preventDefault) {
				event.preventDefault()
			} else {
				event.returnValue = false
			}
			var $this = $(this),
				$scope = $this.parents('.ui-tablist'),
				$tabButtons = $scope.find('.link-tab'),
				$ovTab = $tabButtons.filter('.on')
			if ($ovTab[0] !== $this[0]) {
				var $tabPanels = $scope.find('.obj'),
					$ovPanel = $tabPanels.filter('.on')
				$ovTab.removeClass('on');
				$ovTab.children('a').attr('aria-selected', 'false');
				$ovTab.children('a').attr("title","숨김");
	
				$this.parent('li').addClass('on');
				$this.attr('aria-selected', 'true');
				$this.attr("title","열림");
				var href = $this.attr("aria-controls");
				$ovPanel.removeClass('on');
				$("[id="+href+"]").addClass('on');
				fn_scroll_plugin();
				
	
			}
			event.preventDefault();
		});
	};
	
	fn_scroll_plugin = function(){
		
		$(".scrollbar").mCustomScrollbar({
			theme:"dark-1",
 			autoHideScrollbar: "true",
			mouseWheelPixels : 300, // 마우스휠 속도
			scrollInertia : 400 // 부드러운 스크롤 효과 적용
		});
		
	};
	
	mapSetup = function(mapType){
		//alert(mapType);
		var mapTabs = $('#mapTabs');
		var mapType;
		mapTabs.on('click', 'button', function(mapType){
			mapType = $(this).data('map');
			mapTabs.find('button').removeClass('on');
			$(this).addClass('on');
			switch (mapType) {
				case 'naver':
					navermapSetup();			
				break;
				case 'kakao':
					kakaomapSetup();
				break;
				case 'google':
					googlemapSetup();
				
				break;
				default:
					console.log('Undefined')
				break;
			}
		});
		
		$('#mapTabs > button').eq(0).click();
		
	}
	navermapSetup = function(){
		$("#map").html('');
		$("#map").append("<div id='naverMap' class='mapInner'></div>")
		
		
		
		var HOME_PATH = window.HOME_PATH || '.';
		    MARKER_SPRITE_POSITION = {
		        "A0": [0, 0],
		        "B0": [0, 0],
		        "C0": [0, 0],
		        "D0": [0, 0],
		        "E0": [0, 0],
		        "F0": [0, 0],
		        "G0": [0, 0],
		        "H0": [0, 0],
		        "I0": [0, 0]
		    };


				
		var map = new naver.maps.Map('naverMap', {
		    center: new naver.maps.LatLng(37.3595704, 127.105399),
		    zoom: 10,
		    mapTypeId: naver.maps.MapTypeId.NORMAL
		});
		
		
		var bounds = map.getBounds(),
		    southWest = bounds.getSW(),
		    northEast = bounds.getNE(),
		    lngSpan = northEast.lng() - southWest.lng(),
		    latSpan = northEast.lat() - southWest.lat();
		
		var markers = [],
		    infoWindows = [];

		for (var key in MARKER_SPRITE_POSITION) {

		    var position = new naver.maps.LatLng(
		        southWest.lat() + latSpan * Math.random(),
		        southWest.lng() + lngSpan * Math.random());
		
		    var marker = new naver.maps.Marker({
		        map: map,
		        position: position,
		        title: key,
		        icon: {
		            url: HOME_PATH +'/images/main/marker.png',
		            size: new naver.maps.Size(24, 34),
		            anchor: new naver.maps.Point(24, 34),
		            origin: new naver.maps.Point(0, 0)
		        },
		        zIndex: 100
		    });
		    
			var contentString = [
		        '<div class="gzone__overlay">',
		        '   <a href="#" class="link">',
		        '   <strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong>',
		        '   <span>71,808㎡(21,722평)</span>',
		        '   <span>SH공사</span>',
		        '   <i>자세히보기</i>',
		        '		<div class="thumbnail">',
		        '       <img src="" alt="서울시청" class="thumb" />',
		        '</div>',
		        '</a>',
		        '<img alt="close" class="btn_clear" width="14" height="13" src="http://t1.daumcdn.net/localimg/localimages/07/mapjsapi/bt_close.gif" style="position: absolute; right: 5px; top: 5px; cursor: pointer;">',
		        '</div>'
		    ].join('');
		
		    var infoWindow = new naver.maps.InfoWindow({
		        content:contentString,
		        removable : true

		    });
		    markers.push(marker);
		    infoWindows.push(infoWindow);
		};
		
		naver.maps.Event.addListener(map, 'idle', function() {
			updateMarkers(map, markers);
		});
		
		function updateMarkers(map, markers) {
		
		    var mapBounds = map.getBounds();
		    var marker, position;
		
		    for (var i = 0; i < markers.length; i++) {
		
		        marker = markers[i]
		        position = marker.getPosition();
		
		        if (mapBounds.hasLatLng(position)) {
		            showMarker(map, marker);
		        } else {
		            hideMarker(map, marker);
		        }
		    }
		}
		
		function showMarker(map, marker) {
		
		    if (marker.setMap()) return;
		    marker.setMap(map);
		}
		
		function hideMarker(map, marker) {
		
		    if (!marker.setMap()) return;
		    marker.setMap(null);
		}
		
		// 해당 마커의 인덱스를 seq라는 클로저 변수로 저장하는 이벤트 핸들러를 반환합니다.
		function getClickHandler(seq) {
			//alert(seq);
		    return function(e) {
		        var marker = markers[seq],
		            infoWindow = infoWindows[seq];
		
		        if (infoWindow.getMap()) {
		            infoWindow.close();
		        } else {
		            infoWindow.open(map, marker);
		        }
		        
		         $(infoWindow.getWrapElement()).find('.btn_clear').on('click', function(e) {
				    infoWindow.close();
				});
		    }
		    
		    
		}
		
		for (var i=0, ii=markers.length; i<ii; i++) {
		    naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i));  
		}
		
		function onSuccessGeolocation(position) {
		    var location = new naver.maps.LatLng(position.coords.latitude, position.coords.longitude);
		
		    map.setCenter(location); // 얻은 좌표를 지도의 중심으로 설정합니다.
		    map.setZoom(10); // 지도의 줌 레벨을 변경합니다.

		    console.log('Coordinates: ' + location.toString());
		}
		
		function onErrorGeolocation() {
		    var center = map.getCenter();
		}
		
		$(window).on("load", function() {
		    if (navigator.geolocation) {
		        /**
		         * navigator.geolocation 은 Chrome 50 버젼 이후로 HTTP 환경에서 사용이 Deprecate 되어 HTTPS 환경에서만 사용 가능 합니다.
		         * http://localhost 에서는 사용이 가능하며, 테스트 목적으로, Chrome 의 바로가기를 만들어서 아래와 같이 설정하면 접속은 가능합니다.
		         * chrome.exe --unsafely-treat-insecure-origin-as-secure="http://example.com"
		         */
		        navigator.geolocation.getCurrentPosition(onSuccessGeolocation, onErrorGeolocation);
		    } else {
		        var center = map.getCenter();
		        infowindow.setContent('<div style="padding:20px;"><h5 style="margin-bottom:5px;color:#f00;">Geolocation not supported</h5></div>');
		        infowindow.open(map, center);
		    }
		});	
		
		return false; 	
		
	};
	
	kakaomapSetup = function(){
		$("#map").html('');
		$("#map").append("<div id='kakaoMap' class='mapInner'></div>")
		mapContainer = document.getElementById('kakaoMap'), // 지도를 표시할 div 
		mapOption = { 
			center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level: 4 // 지도의 확대 레벨 
		}; 
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
			message = 'geolocation을 사용할수 없어요..'
			displayMarker(locPosition, message);
		function displayMarker(locPosition, message) {
			map.setCenter(locPosition);      
			
		}  

	// 마커를 표시할 위치와 title 객체 배열입니다 
	var positions = [
		{
			title: '카카오', 
			latlng: new kakao.maps.LatLng(33.450705, 126.570677)
		},
		{
			title: '생태연못', 
			latlng: new kakao.maps.LatLng(33.450936, 126.569477)
		},
		{
			title: '텃밭', 
			latlng: new kakao.maps.LatLng(33.450879, 126.569940)
		},
		{
			title: '근린공원',
			latlng: new kakao.maps.LatLng(33.451393, 126.570738)
		}
	];
	
	

	
	var imageSrc = "/images/main/marker.png";
	for (var i = 0; i < positions.length; i ++) {
		
		var imageSize = new kakao.maps.Size(27, 34); 
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
	    // 마커를 생성합니다
	    var marker = new kakao.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position: positions[i].latlng, // 마커의 위치
			image : markerImage // 마커 이미지 
	    });
		
		var iwContent = '<div class="gzone__overlay">' +
	    '  <a href="#"  class="link">' +
	    '<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong>' +
	    '<span>71,808㎡(21,722평)</span>' +
	    '<span>SH공사</span>' +
	    '<i>자세히보기</i>' +
	    '<div class="thumbnail">' +
		'<img src="/img/example/hi-seoul.jpg" width="55" height="55" alt="서울시청" class="thumb" />' +
		'</div>' +
	    '  </a>' +
	    '</div>';
	    iwRemoveable = true;
	
	    
	    
	    var infowindow = new kakao.maps.InfoWindow({
	        content: iwContent,
	        removable : iwRemoveable
	    });
	
	    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
	    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
	    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
	    kakao.maps.event.addListener(marker, 'click', makeOverListener(map, marker, infowindow));
	    
	    //kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
	} 
	function makeOverListener(map, marker, infowindow) {
	    return function() {
	        infowindow.open(map, marker);
	    };
	}
	
	// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
	function makeOutListener(infowindow) {
	    return function() {
	        infowindow.close();
	    };
	}
	
	};
	
	googlemapSetup = function(){
		$("#map").html('');
		$("#map").append("<div id='googleMap' class='mapInner'></div>");
		

		
		var json = [
		      {
		        "title" : "Store A",
		        "animal" : "fish",
		        "drink" : "coca",
		        "name" : "paul",
		        "geometry": {
		          "type": "Point",
		          "coordinates": [
		            0.48339843749999994,
		            46.89023157359399
		          ]
		        }
		      },
		      {
		        "title" : "Store B",
		        "animal" : "fish",
		        "drink" : "fanta",
		        "name" : "sandrine",
		        "geometry": {
		          "type": "Point",
		          "coordinates": [
		            2.7685546874999996,
		            47.76148371616669
		          ]
		        }
		      },
		      {
		        "title" : "Store C",
		        "animal" : "fish",
		        "drink" : "coca",
		        "name" : "paul",
		        "geometry": {
		          "type": "Point",
		          "coordinates": [
		            2.57080078125,
		            45.882360730184025
		          ]
		        }
		      },
		      {
		        "title" : "Store D",
		        "animal" : "cat",
		        "drink" : "fanta",
		        "name" : "sandrine",
		        "geometry": {
		          "type": "Point",
		          "coordinates": [
		            -0.098876953125,
		            44.52001001133986
		          ]
		        }
		      },
		      {
		        "title" : "Store E",
		        "animal" : "cat",
		        "drink" : "coca",
		        "name" : "lea",
		        "geometry": {
		          "type": "Point",
		          "coordinates": [
		            4.54833984375,
		            45.874712248904764
		          ]
		        }
		      },
		      {
		        "title" : "Store F",
		        "animal" : "dog",
		        "drink" : "fanta",
		        "name" : "lea",
		        "geometry": {
		          "type": "Point",
		          "coordinates": [
		            4.822998046875,
		            45.920587344733654
		          ]
		        }
		      },
		      {
		        "title" : "Store G",
		        "animal" : "dog",
		        "drink" : "fanta",
		        "name" : "sandrine",
		        "geometry": {
		          "type": "Point",
		          "coordinates": [
		            4.06494140625,
		            45.96642454131025
		          ]
		        }
		      }
		    ]
		var jsonStringify = JSON.stringify(json)
		var jsonParse = JSON.parse(jsonStringify); 
		
							
					
		function initMap() {
		    var map = new google.maps.Map(document.getElementById('googleMap'), {
		      zoom: 6,
		      center: new google.maps.LatLng(45.882360730184025, 2.57080078125)
		    });
		
		    for (var i = 0; i < json.length; i++){
		        setMarkers(json[i], map);
		    }
		
			markerCluster = new MarkerClusterer(map, markers, {ignoreHiddenMarkers: true, imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});
		}
		
		function setMarkers(marker, map) {
		    var markerMap = marker.geometry.coordinates;
		    var title = marker.title;
		    var animal = marker.animal;
		    var drink = marker.drink;
		    var name = marker.name;
		    var pos = new google.maps.LatLng(markerMap[1], markerMap[0]);
		    var content = marker;
		
		    markerMap = new google.maps.Marker({
		        position: pos,
		        title: title,
		        animal: animal,
		        drink: drink,
		        name: name,
		        map: map
		    });
		    
		    var iwContent = '<div class="gzone__overlay">' +
		    '  <a href="#"  class="link">' +
		    '<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong>' +
		    '<span>71,808㎡(21,722평)</span>' +
		    '<span>SH공사</span>' +
		    '<i>자세히보기</i>' +
		    '<div class="thumbnail">' +
			'<img src="/img/example/hi-seoul.jpg" width="55" height="55" alt="서울시청" class="thumb" />' +
			'</div>' +
		    '  </a>' +
		    '</div>';
		
		    markers.push(markerMap);
		
		    var infowindow = new google.maps.InfoWindow({
		        content: iwContent
		    });    
		
		    // Marker click listener
		    google.maps.event.addListener(markerMap, 'click', (function (marker1, content) {
		        return function () {
		            infowindow.setContent(content);
		            infowindow.open(map, markerMap);
		            map.panTo(this.getPosition());
		        }
		    })(markerMap, content));
		}
		
		function clusterManager(array) {
		    markerCluster.clearMarkers();
		    if (!array.length) {
		        jQuery('.alert').addClass('is-visible');
		    } else {
		        jQuery('.alert').removeClass('is-visible');
		        for (i=0; i < array.length; i++) {
		            markerCluster.addMarker(array[i]);
		        }
		    }
		}
	
	
		$(window).on("load", function() {
		    initMap();
		});
		
		
	};
	tempSideControl = function(){
		var info = $(".searchResult__obj");
		var infoSubmit = info.find(".link");
		infoSubmit.on('click', function(){
			$("#info").show();
			$(".searchResult__obj .scroll").mCustomScrollbar({
				theme:"dark-1",
	 			autoHideScrollbar: "true",
				mouseWheelPixels : 300, // 마우스휠 속도
				scrollInertia : 400 // 부드러운 스크롤 효과 적용
			});
			//$("#sideAdmin").hide();
		});
		var infoClose = $("#info_close");
		infoClose.on('click', function(){
			$("#info").hide();
		});
		var infoObject = $("#infoObject");
		infoObject.on('click', function(){
			
			var $href = $(this).attr('href');
			
			//alert($href);
			layer_popup($href);
		});
		
	    function layer_popup(el){
	
		
	
	        var $el = $(el);    //레이어의 id를 $el 변수에 저장
	        var isDim = $el.prev().hasClass('dimBg'); //dimmed 레이어를 감지하기 위한 boolean 변수
	
	         $el.fadeIn();
	         $('html,body').addClass("modal__open");
	
	        var $elWidth = ~~($el.outerWidth()),
	            $elHeight = ~~($el.outerHeight()),
	            docWidth = $(document).width(),
	            docHeight = $(document).height();
	
	        // 화면의 중앙에 레이어를 띄운다.
	        if ($elHeight < docHeight || $elWidth < docWidth) {
	            $el.css({
	                marginTop: -$elHeight /2,
	                marginLeft: -$elWidth/2
	            })
	        } else {
	            $el.css({top: 0, left: 0});
	        }
	
	        $el.find('.btn-layerClose').click(function(){
	            $el.fadeOut(); // 닫기 버튼을 클릭하면 레이어가 닫힌다.
				$('html,body').removeClass("modal__open");
	            return false;
	        });
	
	    }
		
		
	};
	sideSearchControl = function(){
		var sideSearch = $("#side");
		var searchToggle = sideSearch.find(".side_toggle");
		searchToggle.on('click', function(){
			$("#side").toggleClass('moveTo');
			$("#totalWrap").toggleClass('moveTo');
			
			$(window).resize(function() { 
				if($(window).width() < 1023) return false;
				if($(window).width() >1023) {
					if ($(this).parents("#side").hasClass('moveTo')) {
						$('html, body').animate({ scrollTop: $("#side").offset().top }, 2000);
					} else {
						$('html, body').animate({ scrollTop: 0 }, 2000);
					};
				 } 
			});
			
		});
	};	
	adminSideControl = function(){
		
		var sideAdmin = $("#sideAdmin");
		var sideToggle = sideAdmin.find(".side_toggle");
		sideToggle.on('click', function(){
			$("#sideAdmin").toggleClass('moveTo');
		});
		
		
		$(window).resize(function() { 
			if($(window).width() < 1023) return false;
			if($(window).width() >1023) {
				if ($(this).parents("#side").hasClass('moveTo')) {
					$('html, body').animate({ scrollTop: 0 }, 2000);
				} else {
					$('html, body').animate({ scrollTop: $("#side").offset().top }, 2000);
				};
			 } 
		});
		
	};
	
	infoSideControl = function(){
		
		var info = $("#info");
		var sideToggle = info.find(".side_toggle");
		sideToggle.on('click', function(){
			$("#info").toggleClass('moveTo');
		});
		
		$(window).resize(function() {
			if($(window).width() < 1023) return false;
			if($(window).width() >1023) {
				if ($(this).parents("#info").hasClass('moveTo')) {
					$('html, body').animate({ scrollTop: $("#info").offset().top }, 2000);
				} else {
					$('html, body').animate({ scrollTop: 0 }, 2000);
				};
			 } 
		});
		
	};
	
	
	searchDetail = function(){
		
		var detail = $(".obj");
		var detailBtn = detail.find(".btn--more button");
		
		detailBtn.on('click', function(){
		
		
			var $this = $(this),
				$scope = $this.parents().parent('.mapSearch__area').find('.mapSearch__biz')
				
			if($scope.css("display") == "none"){
				$scope.show();
				detailBtn.addClass('remore').text('간편검색')
			}else{
			
				$scope.hide();
				detailBtn.removeClass('remore').text('상세검색')
				
			}
			
		});
	}
	toolTip = function(){
				
		$('.td__knowhow').on({
			"mouseenter" : function(){
				var titleText = $(this).attr("title");
				$(this).data("tooltip", titleText).removeAttr("title");
				$('body').after('<div class="tooltipBox"><div class="tooltip-inner">' + titleText +'</div></div>').fadeIn("slow");
				//alert(titleText);
			},
			"mouseleave" : function(){
				$(this).attr("title", $(this).data("tooltip"));
				$(".tooltipBox").remove();
			},
			"mousemove" : function(e){
				var mouseX = e.pageX - 10;
				var mouseY = e.pageY + 20;
				$(".tooltipBox").css({
					"left" : mouseX,
					"top" : mouseY
				});
			}
		});
		
		$('.module .tooltip').on({
			"mouseenter" : function(){
				var titleText = $(this).attr("title");
				$(this).data("tooltip", titleText).removeAttr("title");
				$('body').after('<div class="tooltipBox"><div class="tooltip-inner">' + titleText +'</div></div>').fadeIn("slow");
				//alert(titleText);
			},
			"mouseleave" : function(){
				$(this).attr("title", $(this).data("tooltip"));
				$(".tooltipBox").remove();
			},
			"mousemove" : function(e){
				var mouseX = e.pageX - 10;
				var mouseY = e.pageY + 20;
				$(".tooltipBox").css({
					"left" : mouseX,
					"top" : mouseY
				});
			}
		});		
		
	}
	sideMenu__mode = function(){
		
		$('#quickGuide .item').on({
			"mouseenter" : function(){
				$(this).find('button').addClass('on');
				$(this).find('.dropbox').fadeIn(300);
			},
			"mouseleave" : function(){
				$(this).find('button').removeClass('on');
				$(this).find('.dropbox').fadeOut(300);
				
				
			}
		});
		
	};
	modalPop = function(){
		$(document).on('click', '[data-ly-btn]', function(){
	        var lyTarget = $(this).data('lyBtn');
	        $('[data-ly-target="'+lyTarget+'"]').modal({backdrop: 'static', keyboard: false});
	
	        var $deviceHeight = $(window).outerHeight();
	        setTimeout(function(){
	            var $popHeight = $('[data-ly-target="'+lyTarget+'"]').find('.modal-content').outerHeight();
	           
	            if($deviceHeight<=$popHeight){
	                $('[data-ly-target="'+lyTarget+'"]').closest('.modal').addClass('over');
	            }
	
	        },300)
	    });
	    
	    $(document).on('click', '[data-dismiss]', function(){
            if($(document).find('div.mask').length >= 1) {
                $('div.mask').remove();
            }
            $(document).find('[data-ly-target]').modal('hide');
        });
	};

	init();
	
});


function formAdd() {
		
	$("#form-map").show();
}
