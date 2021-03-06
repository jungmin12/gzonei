/*********************************************************
 * 우편번호 검색
 ******************************************************** */
function goZipCodePopup(){
	// 주소검색을 수행할 팝업 페이지를 호출합니다.
	// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
	var pop = window.open(getContextPath() + "/popup/jusoPopup.do","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	
	// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
    //var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
} 
function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
	// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
	document.mberForm.zip.value = zipNo;//우편번호
	document.mberForm.roadAdres.value = roadFullAddr;//도로명주소
	if(addrDetail != ""){
		document.mberForm.totAdres.value = "(" + jibunAddr + ", " + addrDetail +")";//지번주소 + 상세주소
	}else{
		document.mberForm.totAdres.value = "(" + jibunAddr +")";//지번주소
	}
	document.mberForm.houseAdres.value = jibunAddr;//지번주소
	document.mberForm.detailAdres.value = addrDetail;//상세주소
}
//정규식 체크
function check(re, what, message) {
	var matchPart = re.exec(what.value);
	if(matchPart != null) {
        return true;
    } 
    Common.Dialog.alert({
        content: message
        ,ok : function(){
        }
    });
    what.value = "";
    what.focus();
    //return false;
}
/*********************************************************
 * 아이디 중복체크
 ******************************************************** */
function fn_check_id() {
	var checkId = $("#emplyrId").val().replace(/\s/g, "");
	var re_id = /^[a-z0-9]{6,10}$/; //id 정규식
	if(checkId == ''){
		Common.Dialog.alert({
            title: '중복확인'
            ,content: '중복체크할 회원 아이디가 없습니다.'
            ,ok : function(){
            	$('#emplyrId').focus();
        		return false;
            }
        });
	}else{
		if(!check(re_id,document.getElementById("emplyrId"),"아이디를 형식(영문,숫자로 6~10자)에 맞게 <br>입력해주세요.")){
			$('#emplyrId').focus();
			return false;
		}
		$.ajax({
			type:"POST",
			url:getContextPath() + "/admin/member/memberIdChk.do",
			data:{"checkId": checkId},
			dataType:'json',
			async:false,
			success:function(data){
				if (data.result > 0) {
					Common.Dialog.alert({
	                    title: '중복확인'
	                    ,content: '이미 사용중인 아이디 입니다.\n다른 아이디를 입력해주세요.'
	                    ,ok : function(){
	                    	ID_CHK_FLAG = false;
	    					$('#emplyrId').focus();
	    					$('#emplyrId').val("");
							return;
	                    }
	                }); 
				}else{
					Common.Dialog.confirm({
				        title: '중복확인',
				        content: "입력하신 "+checkId+"은(는) 사용가능한 아이디입니다.\n 사용하시겠습니까?"
				        ,ok: function(){
				        	$('#btnIdCheck').hide();
				        	ID_CHK_FLAG = true;
							$('#emplyrId').attr("disabled",true);
				        },cancel : function(){
				        	ID_CHK_FLAG = false;
							$('#emplyrId').focus();
							$('#emplyrId').val("");
							return;
				        }
				    });    
					
					
				}
			} 
			,error : function(e) {
				Common.Dialog.alert({
		            title: '중복확인'
		            ,content: '아이디 중복조회에 실패하였습니다.\n관리자에게 문의바랍니다.'
		        });
			}
			,beforeSend:function(){
				//전송 전
				$('.wrap-loading').removeClass('display-none');	
		    }
		    ,complete:function(){
		        //전송 후
		    	$('.wrap-loading').addClass('display-none');
		    }
			});
	}
}
//사업자번호 중복체크
function fn_check_bizrno() {

	
	$('#bizrno1').val(jQuery.trim($('#bizrno1').val()));
	$('#bizrno2').val(jQuery.trim($('#bizrno2').val()));
	$('#bizrno3').val(jQuery.trim($('#bizrno3').val()));
	var bizrno = $('#bizrno1').val() + '' + $('#bizrno2').val() + '' + $('#bizrno3').val();
	if ($('#bizrno1').val() == '' || $('#bizrno1').val().length != 3) {
		Common.Dialog.alert({
            content: '사업자번호를 입력해 주십시오.'
            ,ok : function(){
            	$('#bizrno1').focus();
            }
        });
		return;		
	}
	
	if ($('#bizrno2').val() == '' || $('#bizrno2').val().length != 2) {
		Common.Dialog.alert({
            content: '사업자번호를 입력해 주십시오.'
            ,ok : function(){
            	$('#bizrno2').focus();
            }
        });
		return;		
	}
	
	if ($('#bizrno3').val() == '' || $('#bizrno3').val().length != 5) {
		Common.Dialog.alert({
            content: '사업자번호를 입력해 주십시오.'
            ,ok : function(){
            	$('#bizrno3').focus();
            }
        });
		return;		
	}
	if(bizrno == ''){
		Common.Dialog.alert({
            title: '중복확인'
            ,content: '중복체크할 사업자번호가 없습니다.'
            ,ok : function(){
            	$('#bizrno1').focus();
        		return false;
            }
        });
	}else{
		$.ajax({
			type:"POST",
			url: getContextPath() + "/admin/member/bizNoChk.do",
			data:{"bizrno": bizrno},
			dataType:'json',
			async:false,
			success:function(data){
				if (data.result > 0) {
					Common.Dialog.alert({
	                    title: '중복확인'
	                    ,content: '사업자번호가 중복이거나 잘못입력되었습니다.\n다시 한번 확인해 주십시오.'
	                    ,ok : function(){
	                    	bizNoCheck = false;
	    					$('#bizrno1').focus();
	    					$('#bizrno1').val("");
	    					$('#bizrno2').val("");
	    					$('#bizrno3').val("");
							return;
	                    }
	                }); 
				}else{
					Common.Dialog.confirm({
				        title: '중복확인',
				        content: "사용가능한 사업자번호입니다. \n 사용하시겠습니까?"
				        ,ok: function(){
				        	bizNoCheck = true;
				        	$('#btnBizCheck').hide();
							$('#bizrno1').attr("disabled",true);
							$('#bizrno2').attr("disabled",true);
							$('#bizrno3').attr("disabled",true);
				        },cancel : function(){
				        	bizNoCheck = false;
							$('#bizrno1').focus();
							$('#bizrno1').val("");
							$('#bizrno2').val("");
							$('#bizrno3').val("");
							return;
				        }
				    });    
					
					
				}
			} 
			,error : function(e) {
				Common.Dialog.alert({
		            title: '중복확인'
		            ,content: '사업자번호 중복체크시 에러가 발생했습니다.\n관리자에게 문의바랍니다.'
		        });
			}
			,beforeSend:function(){
				//전송 전
				$('.wrap-loading').removeClass('display-none');	
		    }
		    ,complete:function(){
		        //전송 후
		    	$('.wrap-loading').addClass('display-none');
		    }
			});
	}
}
//메일
function onChgEmail(val) {
	$('#emailAdres2').val(val);

}
//대표자 이메일
function onChgRepreEmail(val) {
	$('#rprsntvEmail2').val(val);		
}

//회사 이메일
function onChgCmpnyEmail(val) {
	$('#cmpnyEmail2').val(val);		
}


function numHi(id){
    var inputId = $('#'+id);
    var value = inputId.val(),
          addValue = [];
    value = value.replace(/-/gi, '');

    if (value.length >= 3) { 
     if (value.substring(0, 2) == '02') { // 서울 번호를 체크하기 위한 조건
      addValue.push(value.substring(0, 2)); 
      if (value.length >= 3) { 
       var endKey = (value.length >= 10 ? 6 : 5); // 00-000-000, 00-0000-0000 처리
       addValue.push(value.substring(2, endKey)); 
       if (value.length >= 6) { 
        if (value.length >= 10) { // 10자리 이상 입력 방지
        value = value.substring(0, 10); 
       }
       addValue.push(value.substring(endKey, value.length)); 
      }
     }
    } else { 
    addValue.push(value.substring(0, 3)); 
     if (value.length >= 4) { 
      var endKey = (value.length >= 11 ? 7 : 6); // 000-000-0000, 000-0000-0000 처리
      addValue.push(value.substring(3, endKey)); 
       if (value.length >= 7) { 
        if (value.length >= 11) { // 11자리 이상 입력 방지
         value = value.substring(0, 11); 
        }
        addValue.push(value.substring(endKey, value.length)); 
       }
      }
     }
     inputId.val(addValue.join('-')); 
    }
   }
function makeOptionInterAreaCd2(data) {
	
	var select = document.getElementById("INTER_AREA_CD_2");
	select.innerHTML = null;
	
	var mapOptionArr = eval(data);
	for (var i = 0; i < mapOptionArr.length; i++) {
		select.options[i] =new Option(mapOptionArr[i][1], mapOptionArr[i][0]);//option 을 생성한다 
	}
}
/*********************************************************
 * 전화번호 형식 변경(00000000000 => xxx-xxxx-xxxx)
 ******************************************************** */
//<input type="text" class="form-control" id="loginId" name="id" value="" aria-required="true" onkeyup="chgNumFormat(this.id);">
function chgNumFormat(id){
    var inputId = $('#'+id);
    var value = inputId.val(),
          addValue = [];
    value = value.replace(/-/gi, '');

    if (value.length >= 3) { 
     if (value.substring(0, 2) == '02') { // 서울 번호를 체크하기 위한 조건
      addValue.push(value.substring(0, 2)); 
      if (value.length >= 3) { 
       var endKey = (value.length >= 10 ? 6 : 5); // 00-000-000, 00-0000-0000 처리
       addValue.push(value.substring(2, endKey)); 
       if (value.length >= 6) { 
        if (value.length >= 10) { // 10자리 이상 입력 방지
        value = value.substring(0, 10); 
       }
       addValue.push(value.substring(endKey, value.length)); 
      }
     }
    } else { 
    addValue.push(value.substring(0, 3)); 
     if (value.length >= 4) { 
      var endKey = (value.length >= 11 ? 7 : 6); // 000-000-0000, 000-0000-0000 처리
      addValue.push(value.substring(3, endKey)); 
       if (value.length >= 7) { 
        if (value.length >= 11) { // 11자리 이상 입력 방지
         value = value.substring(0, 11); 
        }
        addValue.push(value.substring(endKey, value.length)); 
       }
      }
     }
     inputId.val(addValue.join('-')); 
    }
   }
/*********************************************************
 * 시/도 변경시 군/구 변경
 ******************************************************** */
function getGuGunCodeAjax(sidoCode){
	var resultData;
	$.ajax({
        type : 'POST',
        url : getContextPath()+"/member/selectCodeList.do",
        async: false,
        datatype : 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        data: {'sidoCode':sidoCode},
        success:function(data){
        	resultData = JSON.parse(data);
		} 
		,error : function(e) {
			Common.Dialog.alert({
	            content: '지역선택시 에러가 발생했습니다.\n관리자에게 문의바랍니다.'
	        });
		}
		,beforeSend:function(){
			//전송 전
			$('.wrap-loading').removeClass('display-none');	
	    }
	    ,complete:function(){
	        //전송 후
	    	$('.wrap-loading').addClass('display-none');
	    }
	});
	return resultData;
}
function onlyNumber(obj){ 
	if(!checkNumber(obj.value)){  
		Common.Dialog.alert({
            content: '숫자만입력가능합니다.'
            ,ok : function(){
            }
        });
		var regExt = /\D/g; // except number regula express
		obj.value = obj.value.replace(regExt, ''); 
	}
}
var checkNumber = function(param){ if ( !isNaN( param ) ) return true; else return false; }

//콤마 추가 (addcomma)
function addComma(num) {
	var result = '';
	if(num!=null){
		var regexp = /\B(?=(\d{3})+(?!\d))/g;
		result = num.toString().replace(regexp, ',')
	}
	return result;
}
