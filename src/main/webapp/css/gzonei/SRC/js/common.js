$(document).ready(function(){
    $("#btnTop").bind('click',pageTopClickHandler);
    $(document,window).bind("scroll",scrollMotionListener);
});

function pageTopClickHandler(e){
    e.preventDefault()
    $("html, body").animate({"scrollTop":0},500);
}

function scrollMotionListener(){
    var scTop = $(window).scrollTop();

    if(scTop>300){
        $("#btnTop").attr("style","opacity:1");
    }else{
        $("#btnTop").attr("style","opacity:0");
    }
}


function gnbFix(){
    var scTop = $(window).scrollTop();
//    console.log("scTop"+scTop);

    
    var topOffset = $("#top_layout").offset().top;
//    console.log("topOffset"+topOffset);

    if(scTop>topOffset){
        $("#top_layout").addClass("fix");
    }else{
        $("#top_layout").removeClass("fix");
    }
}



//op 오픈팝업 시작
function opOpen(){
    var _target = $("#op_layout");
    var _opBtn_open = _target.find(".opBtn_open");
    var _opBtn_close = _target.find(".opBtn_close a");

    _opClose();
    if(_target.find(".item").length > 0){
        _opOpen();
    }
    
    _opBtn_open.click(function(){
        if(_target.find(".item").length > 0){
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
        }else{
			$('.opBtn_open').attr('style','display:none;');
		}
    }
    function _opClose(){
        if (document.todayChk_form.todayChk.checked) {
            setCookie(document.todayChk_form.todayChk.name,"done",1);
        }
        _target.removeClass("on");
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
//권한 value 가져오기
function checkAuthValue(authorCode, menu){
	var authValue;
	var reqData = sessionStorage.getItem("authVO");
	if(reqData!= ""){
		var auth = JSON.parse(reqData);
		auth.filter(function(object){
			if(object["authorCode"] == authorCode){
				authValue = object[menu];
				return authValue;
			}
		});
	}else{
		authValue = "N";
	}
	return authValue;
	
}
//권한 value 가져오기 끝

//권한체크
function checkAuth(authorCode, menu, msg){
	var authValue;
	var reqData = sessionStorage.getItem("authVO");
	var title = "";
	var func = "";
	switch(menu){
	case "menuAccesAt" :
		if(""==msg){
			title = "메뉴접근권한이 없는 등급입니다.";
		}else if(""!=msg){
			title = msg;	
		}
		func = "back";
		break;
	case "infoInqireAt" :
		if(""==msg){
			title = "정보조회권한이 없는 등급입니다."
		}else if(""!=msg){
			title = msg;	
		}
		break;
	case "infoRegistAt" :
		if(""==msg){
			title = "정보등록권한이 없는 등급입니다.";
		}else if(""!=msg){
			title = msg;	
		}
		break;
	case "infoUpdtAt" :
		if(""==msg){
			title = "정보수정권한이 없는 등급입니다.";
		}else if(""!=msg){
			title = msg;	
		}
		
		break;
	case "infoDelAt" :
		if(""==msg){
			title = "정보삭제권한이 없는 등급입니다.";
		}else if(""!=msg){
			title = msg;	
		}
		
		break;
	case "infoDspyAt" :
		if(""==msg){
			title = "정보전시권한이 없는 등급입니다.";
		}else if(""!=msg){
			title = msg;	
		}
		
		break;
	case "executAt" :
		if(""==msg){
			title = "실행&다운권한이 없는 등급입니다.";
		}else if(""!=msg){
			title = msg;	
		}
		break;
	}
	if(reqData!= ""){
		var auth = JSON.parse(reqData);
		auth.filter(function(object){
			if(object["authorCode"] == authorCode){
				authValue = object[menu];
				return authValue;
			}
		});
	}else{
		authValue = "N";
	}
	
	if(authValue == "N"){
		swal({
			title: title,
			text: "권한이 부족합니다.",
			icon: "warning",
			buttons: "확인"
		}).then(function(result) {
			if("back"==func){
				history.back(-2);
			}else{
				
			}
		});
		return false;
	}else{
		return true;
	}
}
//권한체크 끝

function onlyNum(temp,event){
	 var v = temp.value.replace("--", "-");
	 var key = event.keyCode;
	 if(!(key==8||key==9||key==13||key==39||key==37||key==189||key==109||key==46||key==144||(key>=48&&key<=57)||(key>=96&&key<=105)||key==110||key==190)){
			event.preventDefault();
			Common.Dialog.alert({content: '숫자만 입력가능합니다.'});
			temp.value = "";
			return false;
      }
	    if (v.match(/^\d{4}$/) !== null && key!=8) {
	        v = v + '-';
	    } else if (v.match(/^\d{4}\-\d{2}$/) !== null && key!=8) {
	        v = v + '-';
	    }
	    if(v.length < 10 || key==8|| key==37|| key==39){
	    	temp.value = v;
	    }
	    else{
	    	event.preventDefault();
			return false;
	    }
}

function checkDataTime(temp){
	if(temp.value.length == 10 &&((key>=48&&key<=57)||(key>=96&&key<=105))){
    	var datatimeRegexp = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/;
        if ( !datatimeRegexp.test(v) ) {
            alert("날짜는 yyyy-mm-dd 형식으로 입력해주세요.");
        }
    }
}

//브라우저별 첨부파일 다운로드
function attUrlFileDown(url){
	var browserName = undefined;
	var userAgent = navigator.userAgent;

	switch (true) {
	    case /Trident|MSIE/.test(userAgent):
	        browserName = 'ie';
	        break;

	    case /Edge/.test(userAgent):
	        browserName = 'edge';
	        break;

	    case /Chrome/.test(userAgent):
	        browserName = 'chrome';
	        break;

	    case /Safari/.test(userAgent):
	        browserName = 'safari';
	        break;

	    case /Firefox/.test(userAgent):
	        browserName = 'firefox';
	        break;

	    case /Opera/.test(userAgent):
	        browserName = 'opera';
	        break;

	    default:
	        browserName = 'unknown';
	}


	//ie 브라우저 및 EDGE 브라우저 
	if (browserName == 'ie' || browserName == 'edge') {
		const encoded = encodeURI(url);
	    //ie11
	    var _window = window.open(encoded, "_blank");
	    /*_window.document.close();
	    _window.document.execCommand('SaveAs', true, "file.hwp" || url);
	    _window.close();*/
	} else {
	    //chrome
//	    var filename = url.substring(url.lastIndexOf("/") + 1).split("?")[0];
	    var filename = url.substring(url.indexOf("orignlFileNm") + "orignlFileNm".length +1, url.indexOf("&"));
		var a = document.createElement('a');
        a.href = getContextPath()+url // xhr.response is a blob
        a.download = filename; // Set the file name.
        a.style.display = 'none';
        document.body.appendChild(a);
        a.click();
        delete a;
	}
}
