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
            content: '담당자명을 입력해주세요.'
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
	debugger;
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
	if ($('#mbtlnum').val() == '') {
		Common.Dialog.alert({
            content: '휴대폰번호를 입력해주세요.'
            ,ok : function(){
            	$('#mbtlnum').focus();
            }
        });
		return false;
	}
	var re_mbtlnum = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;//핸드폰번호 정규식
	if(!check(re_mbtlnum,document.getElementById("mbtlnum"),"휴대폰번호 형식에 맞게 입력해주세요.")){
		$('#mbtlnum').focus();
		$('#mbtlnum').val("");
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
	// 사업자회원일 경우 체크하기
	if ($('#cmpnyNm').val() == '') {
		Common.Dialog.alert({
            content: '회사(상호)명을 입력해주세요.'
            ,ok : function(){
            	$('#cmpnyNm').focus();
            }
        });
		return false;
	}
	
	if ($('#bizrno1').val() == '') {
		Common.Dialog.alert({
            content: '사업자번호를 입력해주세요.'
            ,ok : function(){
            	$('#bizrno1').focus();
            }
        });
		return false;
	}else if($('#bizrno1').val().length != 3){
		Common.Dialog.alert({
            content: '사업자번호를 확인해주세요.'
            ,ok : function(){
            	$('#bizrno1').focus();
            }
        });
		return false;
	}
	
	if ($('#bizrno2').val() == '') {
		Common.Dialog.alert({
            content: '사업자번호를 입력해주세요.'
            ,ok : function(){
            	$('#bizrno2').focus();
            }
        });
		return false;
	}else if($('#bizrno2').val().length != 2){
		Common.Dialog.alert({
            content: '사업자번호를 확인해주세요.'
            ,ok : function(){
            	$('#bizrno2').focus();
            }
        });
		return false;
	}
	
	if ($('#bizrno3').val() == '') {
		Common.Dialog.alert({
            content: '사업자번호를 입력해주세요.'
            ,ok : function(){
            	$('#bizrno3').focus();
            }
        });
		return false;
	}else if($('#bizrno3').val().length != 5){
		Common.Dialog.alert({
            content: '사업자번호를 확인해주세요.'
            ,ok : function(){
            	$('#bizrno3').focus();
            }
        });
		return false;
	}
	
	if (!bizNoCheck) {
		Common.Dialog.alert({
            content: '사업자번호 중복확인을 해 주십시오.'
            ,ok : function(){
            	$('#bizrno1').focus();
            }
        });
		return false;
	}
	
	if ($('#atchFile_1').val() == '') {
		Common.Dialog.alert({
            content: '사업자등록증을 첨부해주세요.'
            ,ok : function(){
            	$('#atchFile_1').focus();
            }
        });
		return false;
	}
	
	
	if ($('#rprsntvNm').val() == '') {
		Common.Dialog.alert({
            content: '대표자명을 입력해주세요.'
            ,ok : function(){
            	$('#rprsntvNm').focus();
            }
        });
		return false;
	}
	
	if ($('#rprsntvCttpc').val() == '') {
		Common.Dialog.alert({
            content: '대표자 휴대폰번호를 입력해주세요.'
            ,ok : function(){
            	$('#rprsntvCttpc').focus();
            }
        });
		return false;
	}
	if ($('#rprsntvEmail1').val() == '') {
		Common.Dialog.alert({
            content: '대표자 이메일주소를 입력해주세요.'
            ,ok : function(){
            	$('#rprsntvEmail1').focus();
            }
        });
		return false;
	}		

	if ($('#rprsntvEmail2').val() == '') {
		Common.Dialog.alert({
            content: '대표자 이메일주소를 선택해주세요.'
            ,ok : function(){
            	$('#rprsntvEmail2').focus();
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

	if ($('#rprsntvEmail1').val() != '' && $('#rprsntvEmail2').val() != '') {
		$('#rprsntvEmail').val($('#rprsntvEmail1').val() + '@' + $('#rprsntvEmail2').val());
	}
	if ($('#cmpnyEmail1').val() != '' && $('#cmpnyEmail2').val() != '') {
		$('#cmpnyEmail').val($('#cmpnyEmail1').val() + '@' + $('#cmpnyEmail2').val());
	}
	$('#bizrno').val($('#bizrno1').val() + '' + $('#bizrno2').val() + '' + $('#bizrno3').val());	
	
	return true;
}

function fn_insert_member(type){
	debugger;
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
			<form name="mberForm" id="mberForm" action="<c:url value='/memberActionReg.do'/>" method="post"enctype="multipart/form-data" >
			<input type="hidden" name="indvdlMberCode" id="indvdlMberCode" value="CM00210002">
			<input type="hidden" name="emailAdres" id="emailAdres">
			<input type="hidden" name="bizrno" id="bizrno">
			<input type="hidden" name="rprsntvEmail" id="rprsntvEmail">
			<input type="hidden" name="cmpnyEmail" id="cmpnyEmail">
			<input type="hidden" name="INTER_AREA_CD" id="INTER_AREA_CD">
			<div class="join_wrap">
			            
			    <h2 class="h2">담당자 정보</h2>
			    <p class="point">* 표시된 항목은 필수 항목이므로 꼭 입력하셔야 합니다. </p>
			    <div class="form-horizontal bucket-form">
			        <div class="form-group">
			            <div class="col-sm-2 control-label"><label for="userNm"><span class="pilsu">필수입력</span>담당자명</label></div>
			            <div class="col-sm-4">
			                <input type="text" value="" id="userNm" name="userNm" title="회원명 입력" class="form-control indispensable">
			            </div>
			        </div>
			        <div class="form-group">
			            <div class="col-sm-2 control-label"><label for="emplyrId"><span class="pilsu">필수입력</span>아이디</label></div>
			            <div class="col-sm-10">
			                <div class="form-inline">
			                    <input type="text" value="" id="emplyrId" name="emplyrId" title="아이디" onChange="ID_CHK_FLAG = false;" class="form-control indispensable" >
			                    <button type="button"  id="btnIdCheck" class="btn btn-default" onclick="javascript:fn_check_id();">중복검사</button>
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
			            <div class="col-sm-2 control-label"><label for="mbtlnum"><span class="pilsu">필수입력</span>휴대폰</label></div>
			            <div class="col-sm-4">
			            	<input type="text" value="" id="mbtlnum" name="mbtlnum" title="휴대폰번호 입력" class="form-control indispensable" onkeyup="chgNumFormat(this.id);" placeholder="‘-’ 없이 숫자만 입력해주세요.">
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
			    
			    <h2 class="h2">사업자 정보</h2>
			    <p class="point">* 표시된 항목은 필수 항목이므로 꼭 입력하셔야 합니다. </p>
			    <div class="form-horizontal bucket-form">
			        <div class="form-group">
			            <div class="col-sm-2 control-label"><label for="cmpnyNm"><span class="pilsu">필수입력</span>회사(상호)명</label></div>
			            <div class="col-sm-4">
			                <input type="text" value="" id="cmpnyNm" name="cmpnyNm" title="회원명 입력" class="form-control indispensable">
			            </div>
			        </div>
			        
			        <div class="form-group">
			            <div class="col-sm-2 control-label"><label for="bizrno1"><span class="pilsu">필수입력</span>사업자번호</label></div>
			            <div class="col-sm-10">
			                <div class="form-inline">
				            <input type="text" id="bizrno1" name="bizrno1" size="3" maxlength="3"  title="사업자번호 첫번째창 입력" class="form-control" value="" onkeypress="onlyNumber(this)" onChange="bizNoCheck = false;">
							<span>-</span>
			                <input type="text" id="bizrno2" name="bizrno2" size="2" maxlength="2" title="사업자번호 두번째창 입력" class="form-control" value="" onkeypress="onlyNumber(this)" onChange="bizNoCheck = false;">
			                <span>-</span>
			                <input type="text" id="bizrno3" name="bizrno3" size="5" maxlength="5" title="사업자번호 세번째창 입력" class="form-control" value="" onkeypress="onlyNumber(this)" onChange="bizNoCheck = false;">
			                <button type="button" class="btn btn-default" id="btnBizCheck"  onclick="javascript:fn_check_bizrno();">중복검사</button>
			                </div>
			            </div>
			        </div>
			         <div class="form-group">
			            <div class="col-sm-2 control-label"><label for="biz_1"><span class="pilsu">필수입력</span>사업자 등록증</label></div>
			            <div class="col-sm-10">
			                <div class="form-upload">
					              <div class="file-form-group"> 
					               <div class="form-group__upload">
					                   <input type="text" readonly="readonly" name="atchFileNm" id="file_1" class="form-control disabled">
							    	 <input type="file" accept=".jpg, .pdf" name="atchFile_1" id="atchFile_1" class="form-upload__file--hidden">
					               </div>
					               <div class="form-input__addon">
					                   <label for="atchFile_1" class="btn btn btn-primary" data-button="upload">파일선택</label>
					               </div>
					          </div>
			                </div>
			            </div>
			        </div>
			        <div class="form-group">
			            <div class="col-sm-2 control-label"><label for="offmTelno">회사 대표번호</label></div>
			            <div class="col-sm-4">
			            	<input type="text" value="" id="offmTelno" name="offmTelno" title="회사대표번호 입력" class="form-control indispensable" onkeyup="chgNumFormat(this.id);"placeholder="‘-’ 없이 숫자만 입력해주세요.">
			            </div>
			        </div>
			        <div class="form-group">
			            <div class="col-sm-2 control-label"><label for="cmpnyEmail1">회사 이메일 </label></div>
			            <div class="col-sm-10">
			                <div class="form-inline">
			                    <input type="text" id="cmpnyEmail1" name="cmpnyEmail1" title="이메일 주소 입력" class="form-control indispensable" value="">
			                    <span>@</span>
			                    <input type="text" id="cmpnyEmail2" name="cmpnyEmail2" title="이메일 도메인 입력" class="form-control indispensable">
			                    <select id="cmpnyEmail3" title="이메일 도메인 선택" class="form-control" onChange="onChgCmpnyEmail(this.value);">
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
			            <div class="col-sm-2 control-label"><label for="fxnum">회사 팩스번호</label></div>
			            <div class="col-sm-4">
			            	<input type="text" value="" id="fxnum" name="fxnum" title="회사팩스번호 입력" class="form-control indispensable" onkeyup="chgNumFormat(this.id);" placeholder="‘-’ 없이 숫자만 입력해주세요.">
			            </div>
			        </div>
			        <div class="form-group">
			            <div class="col-sm-2 control-label"><label for="rprsntvNm"><span class="pilsu">필수입력</span>대표자명</label></div>
			            <div class="col-sm-4">
		                    <input type="text" value="" id="rprsntvNm" name="rprsntvNm" title="대표자명" class="form-control">
			            </div>
			        </div>
			        <div class="form-group">
			            <div class="col-sm-2 control-label"><label for="rprsntvCttpc"><span class="pilsu">필수입력</span>대표자 휴대폰</label></div>
			            <div class="col-sm-4">
			            	<input type="text" value="" id="rprsntvCttpc" name="rprsntvCttpc" title="대표자 휴대폰번호 입력" class="form-control indispensable" onkeyup="chgNumFormat(this.id);" placeholder="‘-’ 없이 숫자만 입력해주세요.">
			            </div>
			        </div>
			        <div class="form-group">
			            <div class="col-sm-2 control-label"><label for="rprsntvEmail1"><span class="pilsu">필수입력</span>대표자 이메일 </label></div>
			            <div class="col-sm-10">
			                <div class="form-inline">
			                    <input type="text" id="rprsntvEmail1" name="rprsntvEmail1" title="이메일 주소 입력" class="form-control indispensable" value="">
			                    <span>@</span>
			                    <input type="text" id="rprsntvEmail2" name="rprsntvEmail2" title="이메일 도메인 입력" class="form-control indispensable">
			                    <select id="rprsntvEmail3" title="이메일 도메인 선택" class="form-control" onChange="onChgRepreEmail(this.value);">
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
			            <div class="col-sm-2 control-label"><label for="bizcnd">업태</label></div>
			            <div class="col-sm-10">
		                    <input type="text" value="" id="bizcnd" name="bizcnd" title="업태" class="form-control">
			            </div>
			        </div>
			        <div class="form-group">
			            <div class="col-sm-2 control-label"><label for="induty">업종</label></div>
			            <div class="col-sm-10">
		                    <input type="text" value="" id="induty" name="induty" title="업종" class="form-control">
			            </div>
			        </div>
			        
			        
			    </div>
			
				<h2 class="h2">알림 정보 수신동의(선택)</h2>
<!-- 			    <div class="example-box"> -->
<!-- 			        <p>내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.</p> -->
<!-- 			    </div> -->
			    <div class="ui_radio--custom">
			        <input class="checkbox" type="checkbox" id="smsRecptnAt" name="smsRecptnAt" title="수신동의" value="Y">
			        <label for="smsRecptnAt"><span class="chk_ball"></span>SMS 문자메세지</label>
			        <input class="checkbox" type="checkbox" id="emailRecptnAt" name="emailRecptnAt" title="수신동의" value="Y">
			        <label for="emailRecptnAt"><span class="chk_ball"></span>E-mail</label>
			    </div>
			
			
			
			    <h2 class="h2">광고 수신동의</h2>
<!-- 			    <div class="example-box"> -->
<!-- 			        <p>내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.</p> -->
<!-- 			    </div> -->
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
