<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang='ko'>
<head>
<%@ include file="/WEB-INF/jsp/gzonei/layout/header.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/jsp/gzonei/layout/top.jsp" %>
<script language="javascript" src="<c:url value='/js/gzonei/member/member.js' />"></script>
<script>
var ID_CHK_FLAG = false;
var bizNoCheck = false;
$(document).ready(function(){
	$('#intrstAreaCode1').on('change',function(e){
		//시/도에 대한 군/구 리스트 생성
		var sidoCode = $(this).val();
		$('#intrstAreaCode').html("");
		var optionHtml = '';
		if(sidoCode == ''){
			optionHtml += '<option value="">구/군</option>';
		}else{
			var resultData = getGuGunCodeAjax(sidoCode);
			optionHtml += '<option value="'+sidoCode+'">전체</option>';
        	$.each(resultData.result, function (key, item) {
        		optionHtml += '<option value="'+item.legaldongCode+'">'+item.lowestAreaNm+'</option>';
        	});
		}
		$('#intrstAreaCode').append(optionHtml);
	});
});
/*********************************************************
 * 입력폼 검증
 ******************************************************** */
function validate(){
	 
	$.each($("input"), function (key, item) {
		if(item.id == "houseAdres" || item.id == "detailAdres" ||item.id == "roadAdres" || item.id == "totAdres" || item.id =="cmpnyNm" ){
			item.value = item.value.trim();
		}else if(item.id != "atchFile_1"){
			item.value = item.value.replace(/\s/g, "");
		}
	});
	
	if ($('#userNm').val() == '') {
		Common.Dialog.alert({
            content: '회원명을 입력해주세요.'
            ,ok : function(){
            	$('#userNm').focus();
            }
        });
		return false;
	}
	
	if ($('#emplyrId').val() == '') {
		Common.Dialog.alert({
            content: '아이디를 입력해주세요.'
            ,ok : function(){
				$('#emplyrId').focus();
            }
        });
     	return false;
	}
	
	if(ID_CHK_FLAG == false){
		Common.Dialog.alert({
            content: '아이디 중복확인을 해주세요.'
            ,ok : function(){
				$('#emplyrId').focus();
            }
        });
		return false;
	}
	if ($('#password').val() == '') {
		Common.Dialog.alert({
            content: '비밀번호를 입력해주세요.'
            ,ok : function(){
				$('#password').focus();
            }
        });
		return false;
	}
	
// 	var re_pw = /^.*(?=^.{6,10}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/; //pw 정규식
	var re_pw = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&+=])[A-Za-z\d!@#$%^&+=]{6,10}$/;
	if(!check(re_pw,document.getElementById("password"),"비밀번호를 형식에 맞게 입력해주세요.<br>영문,숫자,특문(!@#$%^&+=)조합으로<br> 6~10자로 입력해 주세요.")){
		$('#password').focus();
		$('#password').val("");
		$('#re_password').val("");
		return false;
	}
	
	
	if ($('#re_password').val() == '') {
		Common.Dialog.alert({
            content: '비밀번호 확인을 입력해주세요.'
            ,ok : function(){
				$('#re_password').focus();
            }
        });
		return false;
	}
	
	if ($('#password').val() != $('#re_password').val()) {
		Common.Dialog.alert({
            content: '비밀번호가 일치하지 않습니다.'
            ,ok : function(){
            	$('#password').val("");
        		$('#re_password').val("");
        		$('#re_password').focus();
            }
        });
		return false;
	}
	
	if ($('#agrde').val() == '') {
		Common.Dialog.alert({
            content: '연령대를 선택해주세요.'
            ,ok : function(){
            	$('#agrde').focus();
            }
        });
		return false;
	}

	if ($("[name=sexdstnCode]:checked").val() == '' || $("[name=sexdstnCode]:checked").val() == undefined) {
		Common.Dialog.alert({
            content: '성별을 선택해주세요.'
            ,ok : function(){
            	$('#sexdstnCode').focus();
            }
        });
		return false;
	}
	if ($('#mbtlnum1').val() == '') {
		Common.Dialog.alert({
            content: '휴대폰번호를 입력해주세요.'
            ,ok : function(){
            	$('#mbtlnum1').focus();
            }
        });
		return false;
	}
	
	if ($('#mbtlnum2').val() == '') {
		Common.Dialog.alert({
            content: '휴대폰번호를 입력해주세요.'
            ,ok : function(){
            	$('#mbtlnum2').focus();
            }
        });
		return false;
	}	
	
	if ($('#mbtlnum3').val() == '') {
		Common.Dialog.alert({
            content: '휴대폰번호를 입력해주세요.'
            ,ok : function(){
            	$('#mbtlnum3').focus();
            }
        });
		return false;
	}	
	
	if ($('#emailAdres1').val() == '') {
		Common.Dialog.alert({
            content: '이메일주소를 입력해주세요.'
            ,ok : function(){
            	$('#emailAdres1').focus();
            }
        });
		return false;
	}		

	if ($('#emailAdres2').val() == '') {
		Common.Dialog.alert({
            content: '이메일주소를 선택해주세요.'
            ,ok : function(){
            	$('#emailAdres2').focus();
            }
        });
		return false;
	}		
	
	if ($('#roadAdres').val() == '') {
		Common.Dialog.alert({
            content: '주소를 입력해주세요.'
            ,ok : function(){
            	$('#roadAdres').focus();
            }
        });
		return false;
	 }	 
	
	
	var agreeYn = false;
	$('input[name=advrtsRecptnAt]').each(function(){
		if($(this).is(":checked")){
			agreeYn = $(this).is(":checked");
		}
		
	});
	if (!agreeYn) {
		Common.Dialog.alert({
            content: '광고 수신동의를 선택해주세요.'
        });
		return;
	}
	$('#emailAdres').val($('#emailAdres1').val() + '@' + $('#emailAdres2').val());
	$('#mbtlnum').val($('#mbtlnum1').val() + '-' + $('#mbtlnum2').val() + '-' + $('#mbtlnum3').val());
	
	return true;
}

function fn_insert_member(){
	
	if(validate()){
		Common.Dialog.confirm({
	        title: '회원가입',
            content: '가입하시겠습니까?'
            ,ok: function(){
            	$('#emplyrId').removeAttr("disabled");
        		document.mberForm.action = "<c:url value='/memberActionReg.do'/>";
        		document.mberForm.submit();
            }
	        ,cancel : function(){
	        	return false;
	        }
        });
	}
}
</script>


<!-- 구현부 : S -->

<div id="body_layout">	
    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
        
            <div id="txt">
            <!-- content 영역입니다. -->
			<ul class="step_list">
			    <li><span></span>회원선택</li>
			    <li><span></span>약관동의</li>
			    <li class="on"><span></span>정보입력</li>
			    <li><span></span>가입완료</li>
			</ul>
			<form name="mberForm" id="mberForm" action="<c:url value='/memberActionReg.do'/>" method="post" enctype="multipart/form-data" >
			<input type="hidden" name="indvdlMberCode" id="indvdlMberCode" value="CM00210001">
			<input type="hidden" name="mbtlnum" id="mbtlnum">
			<input type="hidden" name="emailAdres" id="emailAdres">
			<input type="hidden" name="INTER_AREA_CD" id="INTER_AREA_CD">
			<div class="join_wrap">
            
		    <h2 class="h2">14세 이상의 일반회원</h2>
		    <p class="point">* 표시된 항목은 필수 항목이므로 꼭 입력하셔야 합니다. </p>
		    <div class="form-horizontal bucket-form">
		        <div class="form-group">
		            <div class="col-sm-2 control-label"><label for="userNm"><span class="pilsu">필수입력</span>회원명</label></div>
		            <div class="col-sm-4">
		            	<input type="text" value="${certVO.name}" id="userNm" name="userNm" title="회원명 입력" class="form-control indispensable" readonly="readonly">
		            </div>
		        </div>
		        <div class="form-group">
		            <div class="col-sm-2 control-label"><label for="clCode"><span class="pilsu">필수입력</span>구분</label></div>
		            <div class="col-sm-4">
		                <select id="clCode" name="clCode" class="form-control" title="연령대 선택">
	                		<c:forEach var="item" items="${clCode }">
                 				<option value="${item.codeId}">${item.codeIdNm }</option>
                 			</c:forEach>
			                </select>
		            </div>
		        </div>
		        <div class="form-group">
		            <div class="col-sm-2 control-label"><label for="emplyrId"><span class="pilsu">필수입력</span>아이디</label></div>
		            <div class="col-sm-10">
		                <div class="form-inline">
		                    <input type="text" value="" id="emplyrId" name="emplyrId" title="아이디" class="form-control indispensable">
		                    <button type="button" id="btnIdCheck" class="btn btn-default" onclick="javascript:fn_check_id();">중복검사</button>
		                    <span style="color: #ee5d5d;">영문,숫자로 6~10자로 입력해 주세요.</span>
		                </div>
		            </div>
		        </div>
		        <div class="form-group">
		            <div class="col-sm-2 control-label"><label for="password"><span class="pilsu">필수입력</span>비밀번호</label></div>
		            <div class="col-sm-4">
		                <input type="password" value="" id="password" name="password" title="비밀번호 입력" class="form-control indispensable" placeholder="영문,숫자,특문(!@#$%^&+=)조합으로 6~10자로 입력해 주세요.">
		                <span style="color: #ee5d5d;">영문,숫자,특문(!@#$%^&+=)조합으로 6~10자로 입력해 주세요.</span>
		            </div>  
		            <div class="col-sm-2 control-label"><label for="re_password"><span class="pilsu">필수입력</span>비밀번호확인</label></div>
		            <div class="col-sm-4">
		                <input type="password" value="" id="re_password" name="re_password" title="비밀번호 확인 입력" class="form-control indispensable" placeholder="비밀번호를 한번 더 입력해주세요.">
		            </div>
		        
		        </div>
		        <div class="form-group">
		            <div class="col-sm-2 control-label"><label for="agrde"><span class="pilsu">필수입력</span>연령대/성별</label></div>
		            <div class="col-sm-4">
		                <select id="agrde" name="agrde" class="form-control" title="연령대 선택">
			                    <option value="">연령대 선택</option>
								<option value="20">20대</option>
								<option value="30">30대</option>
								<option value="40">40대</option>
								<option value="50">50대</option>
								<option value="60">60대이상</option>
			                </select>
		            </div>
		            <div class="col-sm-4">
		               <input class="radio-input" type="radio" id="sexdstnCode1" name="sexdstnCode" title="남성" value="M">
		               <label class="radio-inline" for="sexdstnCode1">남성</label>
		               <input class="radio-input" type="radio" id="sexdstnCode2" name="sexdstnCode" title="여성" value="F">
		               <label class="radio-inline" for="sexdstnCode2">여성</label>
	           		</div>
		        </div>
		        <div class="form-group">
		            <div class="col-sm-2 control-label"><label for="mbtlnum1"><span class="pilsu">필수입력</span>휴대폰</label></div>
		            <div class="col-sm-10">
		                <div class="form-inline">
		                	<c:set var="length" value="${fn:length(certVO.cellNo)}"/>
		                    <input type="text" id="mbtlnum1" name="mbtlnum1" title="연락처 첫번째창 입력" class="form-control" value="${fn:substring(certVO.cellNo,0,3)}" onkeydown="onlyNumber(this)" readonly="readonly">
		                    <span>-</span>
		                    <c:if test="${fn:length(certVO.cellNo) == 10}">
			                    <input type="text" id="mbtlnum2" name="mbtlnum2" title="연락처 두번째창 입력" class="form-control" value="${fn:substring(certVO.cellNo,3,6)}" maxlength="4" onkeydown="onlyNumber(this)" readonly="readonly">
		                    </c:if>
		                    <c:if test="${fn:length(certVO.cellNo) != 10}">
			                    <input type="text" id=mbtlnum2 name="mbtlnum2" title="연락처 두번째창 입력" class="form-control" value="${fn:substring(certVO.cellNo,3,7)}" maxlength="4" onkeydown="onlyNumber(this)" readonly="readonly">
		                    </c:if>
		                <span>-</span>
		                <c:if test="${fn:length(certVO.cellNo) == 10}">
			                <input type="text" id="mbtlnum3" name="mbtlnum3" title="연락처 세번째창 입력" class="form-control" value="${fn:substring(certVO.cellNo,6,length)}" maxlength="4" onkeydown="onlyNumber(this)" readonly="readonly">
		                </c:if>
		                <c:if test="${fn:length(certVO.cellNo) != 10}">
			                <input type="text" id="mbtlnum3" name="mbtlnum3" title="연락처 세번째창 입력" class="form-control" value="${fn:substring(certVO.cellNo,7,length)}" maxlength="4" onkeydown="onlyNumber(this)" readonly="readonly">
		                </c:if>
		                </div>
		            </div>
		        </div>
		        <div class="form-group">
		            <div class="col-sm-2 control-label"><label for="emailAdres1"><span class="pilsu">필수입력</span>이메일 </label></div>
		            <div class="col-sm-10">
		                <div class="form-inline">
		                    <input type="text" id="emailAdres1" name="emailAdres1" title="이메일 주소 입력" class="form-control indispensable" value="">
		                    <span>@</span>
		                    <input type="text" id="emailAdres2" name="emailAdres2" title="이메일 도메인 입력" class="form-control indispensable">
		                    <select id="emailAdres3" name="emailAdres3" title="이메일 도메인 선택" class="form-control" onChange="onChgEmail(this.value)">
		                        <option value="" selected="selected">직접입력</option>
								<option value="naver.com" >naver.com</option>
								<option value="chol.com" >chol.com</option>
								<option value="dreamwiz.com" >dreamwiz.com</option>
								<option value="empal.com" >empal.com</option>
								<option value="freechal.com" >freechal.com</option>
								<option value="gmail.com" >gmail.com</option>
								<option value="hanafos.com" >hanafos.com</option>
								<option value="hanmail.net" >hanmail.net</option>
								<option value="hanmir.com" >hanmir.com</option>
								<option value="hitel.net" >hitel.net</option>
								<option value="hotmail.com" >hotmail.com</option>
								<option value="korea.com" >korea.com</option>
								<option value="lycos.co.kr" >lycos.co.kr</option>
								<option value="nate.com" >nate.com</option>
								<option value="netian.com" >netian.com</option>
								<option value="paran.com" >paran.com</option>
								<option value="yahoo.com" >yahoo.com</option>
								<option value="yahoo.co.kr" >yahoo.co.kr</option>
		                    </select>
		                </div>
		            </div>
		        </div>
		        <div class="form-group">
			           <div class="col-sm-2 control-label"><label for="zip"><span class="pilsu">필수입력</span>도로명주소(지번주소) </label></div>
			           <div class="col-sm-10">
			                <div class="form-control-static">
			                    <div class="col-md-4 form-group">
			                    	<input type="text"  name="zip" id="zip"  maxlength="8" placeholder="우편번호" readonly="readonly" class="form-control">
			                    </div>
			                    <button type="button" onclick="javascript:goZipCodePopup();" class="btn btn-default">주소검색</button>
			        
			                </div>
			                <div class="form-control-static">
			              		<input type="text" name="roadAdres" id="roadAdres" readonly="readonly" class="form-control" title="도로명주소 입력">
			                </div>
			                <div class="form-control-static">
									<input type="text" id="totAdres" name="totAdres" class="form-control" title="지번주소 입력" readonly="readonly"/>
									<input type="hidden" name="houseAdres" id="houseAdres" readonly="readonly" />
									<input type="hidden" name="detailAdres" id="detailAdres" readonly="readonly"/>
								</div>
			            </div>
			        </div>
		        <div class="form-group">
		            <div class="col-sm-2 control-label"><label for="brhs">관심지역</label></div>
		            <div class="col-sm-4">
		                <div class="form-inline">
		                    <select id="intrstAreaCode1" name="intrstAreaCode1" class="form-control" title="시/도 선택">
			                    		<option value="">시/도</option>
			                    	<c:forEach var="item" items="${sidoCode }">
		                 				<option value="${item.legaldongCode}">${item.legaldongNm }</option>
		                 			</c:forEach>
			                    </select>
			                    <select id="intrstAreaCode" name="intrstAreaCode" class="form-control" title="구/군 선택">
			                        <option value="">구/군</option>
			                    </select>
		                </div>
		            </div>
		            <div class="col-sm-2 control-label"><label for="">관심분야</label></div>
		            <div class="col-sm-4">
		                <input class="radio-input" type="radio" id="intrstRealm1" name="intrstRealm" title="개발정보" value="A">
		                <label class="radio-inline" for="intrstRealm1">개발정보</label>
		                <input class="radio-input" type="radio" id="intrstRealm2" name="intrstRealm" title="투자정보" value="B">
		                <label class="radio-inline" for="intrstRealm2">투자정보</label>
		            </div>
		        </div>
		    </div>
		
		
		    <h2 class="h2">알림 정보 수신동의(선택)</h2>
<!-- 		    <div class="example-box"> -->
<!-- 		        <p>내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.</p> -->
<!-- 		    </div> -->
		    <div class="ui_radio--custom">
		        <input class="checkbox" type="checkbox" id="smsRecptnAt" name="smsRecptnAt" title="수신동의" value="Y">
		        <label for="smsRecptnAt"><span class="chk_ball"></span>SMS 문자메세지</label>
		        <input class="checkbox" type="checkbox" id="emailRecptnAt" name="emailRecptnAt" title="수신동의" value="Y">
		        <label for="emailRecptnAt"><span class="chk_ball"></span>E-mail</label>
		    </div>
		
		
		
		    <h2 class="h2">광고 수신동의</h2>
<!-- 		    <div class="example-box"> -->
<!-- 		        <p>내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.</p> -->
<!-- 		    </div> -->
		    <div class="ui_radio--custom">
		        <input class="radio" type="radio" id="advrtsRecptnAt1" name="advrtsRecptnAt" title="동의" value="Y" checked="checked">
                <label class="radio--custom" for="advrtsRecptnAt1"><span class="chk_ball">동의</span></label>
                <input class="radio" type="radio" id="advrtsRecptnAt2" name="advrtsRecptnAt" title="동의하지 않음" value="N">
                <label class="radio--custom" for="advrtsRecptnAt2"><span class="chk_ball">동의하지 않음</span></label>
		    </div>
		
		
		       
		    <div class="text-center">
		        <button type="button" class="btn btn-default" onclick="location.href='<c:url value='/joinStep1.do'/>'">취소</button>
			    <button type="button" class="btn btn-primary" onclick="javascript:fn_insert_member()">회원가입</button>
		    </div>
		                
		</div>
    		</form>
            <!-- content 영역입니다. -->	
            </div>
        </div>
    </div>
    <!-- layout -->
</div>


<!-- 구현부 : E -->

<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>
</body>
</html>
