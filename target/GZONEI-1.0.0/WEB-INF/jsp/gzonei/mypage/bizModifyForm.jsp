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
$(document).ready(function(){
	var sMsg = "${sMsg}";
	if(sMsg == "SUCCESS"){
		Common.Dialog.alert({
	        title: '수정',
            content: '회원정보를 수정했습니다.'
            ,ok: function(){
            }
        });    
	}else if(sMsg == "FAIL"){
		Common.Dialog.alert({
	        title: '수정',
            content: '회원정보 수정 중 에러가 발생했습니다.\n관리자에게 문의바랍니다.'
            ,ok: function(){
            }
        }); 
	}
	
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
	
	if($('#password').val() != ''){
// 		var re_pw = /^.*(?=^.{6,10}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/; //pw 정규식
		var re_pw = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&+=])[A-Za-z\d!@#$%^&+=]{6,10}$/;
		if(!check(re_pw,document.getElementById("password"),"비밀번호를 형식에 맞게 입력해주세요.<br>영문,숫자,특문(!@#$%^&+=)조합으로<br> 6~10자로 입력해 주세요.")){
			$('#password').focus();
			$('#password').val("");
    		$('#re_password').val("");
			return false;
		}
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
	
	return true;
}


function fn_update_mber(){
	if(validate()){
		Common.Dialog.confirm({
	        title: '수정',
            content: '수정하시겠습니까?'
            ,ok: function(){
            	document.mberForm.action = "<c:url value='/mypage/memberActionUdt.do'/>";
        		document.mberForm.submit();
            }
			,cancel : function(){
	        	return false;
	        }
        });    
	}
	
}

function fn_change_pw() {
	$('#chgPwBtn').text("닫기");
	$('#chgPwBtn').attr("onClick", "javascript:fn_close();");
	
	$("#pwDiv").css("display","block");
	$("#password").parent().css("display","block");
}
function fn_close() {
	$('#password').val("");
	$('#re_password').val("");
	$('#chgPwBtn').text("비밀번호변경");
	$('#chgPwBtn').attr("onClick", "javascript:fn_change_pw();");
	
	$("#pwDiv").css("display","none");
	$("#password").parent().css("display","none");
}
</script>


<!-- 구현부 : S -->

<div id="body_layout">	
    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
        	<div id="location" class="title_wrap">
                <h2 class="page__title">회원정보 수정</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="<c:url value='/mypage/modifyMyInfo.do'/>">마이페이지</a></li>
                        <li class="n3"><a href="<c:url value='/mypage/modifyMyInfo.do'/>" class="navi_ov">회원정보 수정</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>  
            <div id="txt">
            <!-- content 영역입니다. -->
			<form name="mberForm" id="mberForm"  action="<c:url value='/mypage/memberActionUdt.do'/>" method="post" enctype="multipart/form-data" >
			<input type="hidden" name="indvdlMberCode" id="indvdlMberCode" value="CM00210002">
			<input type="hidden" name="emailAdres" id="emailAdres">
			<input type="hidden" name="rprsntvEmail" id="rprsntvEmail">
			<input type="hidden" name="cmpnyEmail" id="cmpnyEmail">
			<div class="join_wrap">
			            
			    <h2 class="h2">담당자 정보</h2>
			    <p class="mb_20">Gzone은 회원님의 동의없이 기재하신 개인정보를 누출하지 않으며, 안전하게 보호하고 있습니다.</p>
		  		<p class="mb_20" style="color: #ee5d5d;">* 표시된 항목은 필수 항목이므로 꼭 입력하셔야 합니다. </p>
			    <div class="form-horizontal bucket-form">
			        <div class="form-group">
			            <div class="col-sm-2 control-label"><label for="userNm"><span class="pilsu">필수입력</span>담당자명</label></div>
			            <div class="col-sm-4">
		            		<input type="text" value="${resultVO.userNm}" id="userNm" name="userNm" title="회원명 입력" class="form-control indispensable" >
			            </div>
			        </div>
			        <div class="form-group">
			            <div class="col-sm-2 control-label"><label for="emplyrId"><span class="pilsu">필수입력</span>아이디</label></div>
			            <div class="col-sm-4">
			            	<div class="input">${resultVO.emplyrId}</div>
			                <input type="hidden" value="${resultVO.emplyrId}" id="emplyrId" name="emplyrId" title="아이디" class="form-control indispensable">
			            </div>
			        </div>
			        <div class="form-group">
			        
			            <div class="col-sm-2 control-label"><label for="password"><span class="pilsu">필수입력</span>비밀번호</label></div>
			            <div class="col-sm-4" style="display:none;">
			                <input type="password" value="" id="password" name="password" title="비밀번호 입력" class="form-control indispensable" placeholder="영문,숫자,특문(!@#$%^&+=)조합으로 6~10자로 입력해 주세요.">
			                <span style="color: #ee5d5d;">영문,숫자,특문(!@#$%^&+=)조합으로 6~10자로 입력해 주세요.</span>
			            </div>
			        	<div class="col-sm-4">	
			        		<button type="button" id="chgPwBtn" class="btn btn-default" onclick="javascript:fn_change_pw();">비밀번호변경</button>
			            </div>
			        </div>
			        <div class="form-group">
					<div style="display:none;" id= "pwDiv">		            
			            <div class="col-sm-2 control-label"><label for="re_password"><span class="pilsu">필수입력</span>비밀번호확인</label></div>
			            <div class="col-sm-4">
			                <input type="password" value="" id="re_password" name="re_password" title="비밀번호 확인 입력" class="form-control indispensable" placeholder="비밀번호를 한번 더 입력해주세요.">
			            </div>
			        </div>
			        </div>
			        <div class="form-group">
			            <div class="col-sm-2 control-label"><label for="agrde"><span class="pilsu">필수입력</span>연령대/성별</label></div>
			            <div class="col-sm-4">
			                <select id="agrde" name="agrde" class="form-control" title="연령대 선택">
			                    <option value="">연령대 선택</option>
								<option value="20" <c:if test="${resultVO.agrde eq '20'}">selected</c:if>>20대</option>
								<option value="30" <c:if test="${resultVO.agrde eq '30'}">selected</c:if>>30대</option>
								<option value="40" <c:if test="${resultVO.agrde eq '40'}">selected</c:if>>40대</option>
								<option value="50" <c:if test="${resultVO.agrde eq '50'}">selected</c:if>>50대</option>
								<option value="60" <c:if test="${resultVO.agrde eq '60'}">selected</c:if>>60대이상</option>
								<option value="60">60대이상</option>
			                </select>
			            </div>
		                <div class="col-sm-4">
			               <input class="radio-input" type="radio" id="sexdstnCode1" name="sexdstnCode" title="남성" value="M" <c:if test="${resultVO.sexdstnCode eq 'M'}">checked</c:if>>
			               <label class="radio-inline" for="sexdstnCode1">남성</label>
			               <input class="radio-input" type="radio" id="sexdstnCode2" name="sexdstnCode" title="여성" value="F" <c:if test="${resultVO.sexdstnCode eq 'F'}">checked</c:if>>
			               <label class="radio-inline" for="sexdstnCode2">여성</label>
		           		</div>
			        </div>
			        <div class="form-group">
			            <div class="col-sm-2 control-label"><label for="mbtlnum"><span class="pilsu">필수입력</span>휴대폰</label></div>
			            <div class="col-sm-4">
			                <input type="text" id="mbtlnum" name="mbtlnum" title="휴대폰번호 입력" class="form-control" value="${resultVO.mbtlnum}" onkeyup="chgNumFormat(this.id);" placeholder="‘-’ 없이 숫자만 입력해주세요.">
			            </div>
			        </div>
			        <div class="form-group">
			            <div class="col-sm-2 control-label"><label for="emailAdres1"><span class="pilsu">필수입력</span>이메일 </label></div>
			            <div class="col-sm-10">
			                <div class="form-inline">
			                    <input type="text" id="emailAdres1" name="emailAdres1" title="이메일 주소 입력" class="form-control indispensable"  value="${fn:split(resultVO.emailAdres,'@')[0]}">
			                    <span>@</span>
			                    <input type="text" id="emailAdres2" name="emailAdres2" title="이메일 도메인 입력" class="form-control indispensable" value="${fn:split(resultVO.emailAdres,'@')[1]}">
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
	                 				<option value="${item.legaldongCode}" <c:if test="${(resultVO.intrstAreaCode1 eq item.legaldongCode) || (resultVO.intrstAreaCode eq item.legaldongCode)}">selected</c:if>>${item.legaldongNm }</option>
	                 			</c:forEach>
		                    </select>
		                    <select id="intrstAreaCode" name="intrstAreaCode" class="form-control" title="구/군 선택">
		                    	<c:if test="${resultVO.intrstAreaCode1 eq null}">
			                        <option value="">구/군</option>
		                    	</c:if>
		                    	<c:if test="${resultVO.intrstAreaCode1 ne null}">
			                        <option value="${resultVO.intrstAreaCode1}" <c:if test="${resultVO.intrstAreaCode1 eq resultVO.intrstAreaCode}">selected</c:if>>전체</option>
		                    	<c:forEach var="item" items="${gunGuCode }">
	                 				<option value="${item.legaldongCode}" <c:if test="${resultVO.intrstAreaCode eq item.legaldongCode}">selected</c:if>>${item.lowestAreaNm }</option>
	                 			</c:forEach>
		                    	</c:if>
		                    </select>
		                </div>
			            </div>
			            <div class="col-sm-2 control-label"><label for="">관심분야</label></div>
			            <div class="col-sm-4">
			                <input class="radio-input" type="radio" id="intrstRealm1" name="intrstRealm" title="개발정보" value="A" <c:if test="${resultVO.intrstRealm eq 'A'}">checked</c:if>/>
			                <label class="radio-inline" for="intrstRealm1">개발정보</label>
			                <input class="radio-input" type="radio" id="intrstRealm2" name="intrstRealm" title="투자정보" value="B" <c:if test="${resultVO.intrstRealm eq 'B'}">checked</c:if>/>
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
			            	<div class="input">${resultVO.cmpnyNm}</div>
			            </div>
			        </div>
			        
			        <div class="form-group">
			            <div class="col-sm-2 control-label"><label for="bizrno"><span class="pilsu">필수입력</span>사업자번호</label></div>
			            <div class="col-sm-4">
			            	<div class="input">${fn:substring(resultVO.bizrno,0,3) }-${fn:substring(resultVO.bizrno,3,5) }-${fn:substring(resultVO.bizrno,5,10) }
			            	</div>
			            </div>
			        </div>
			         <div class="form-group">
			            <div class="col-sm-2 control-label"><label for="biz_1"><span class="pilsu">필수입력</span>사업자 등록증</label></div>
			            <div class="col-sm-4">
			                <div class="form-upload">
					              <c:choose>
						    		<c:when test="${ empty atchFileDetail or fn:length(atchFileDetail) == 0 }">
										<div class="file-form-group">
						    	 		<div class="form-group__upload">
						    	 			<input type="text" readonly="readonly" name="atchFileNm"  class="form-control disabled">
									    	 <input type="file" accept=".jpg, .pdf" name="atchFile_1" id="atchFile_1" class="form-upload__file--hidden">
									    	 
						    	 		</div>
						    	 		<div class="form-input__addon">
						    	 			<label for="atchFile_1" class="btn btn-default" data-button="upload"><span class="skip"></span>파일선택</label>
			                           </div>
						    	 	</div>
									</c:when>
									<c:otherwise>
										<c:forEach items="${atchFileDetail}" var="atcFile" varStatus="status">
										<c:set var="atcNum" value="${atcNum+1}"/>
										<div>
											<div>
							    	 			<a href="javascript:attUrlFileDown('<c:url value='/cmmn/downloadFile.do?orignlFileNm=${atcFile.orignlFileNm}&fileStreCours=${atcFile.fileStreCours}'/>')" >
								    	 			<input type="text" readonly="readonly" name="atchFileNm" class="form-control bizFile" value="${atcFile.orignlFileNm}" title="사업자등록증 다운로드" style="cursor: pointer;">
								    	 			<input type="file" accept=".jpg, .pdf"  id="atchFile_${atcNum}" name="atchFile_${atcNum}" class="form-upload__file--hidden bizFile">
							    	 			</a>
							    	 		</div>
										</div>
										</c:forEach>
									</c:otherwise>
						    	</c:choose>
			                </div>
			            </div>
			        </div>
			        <div class="form-group">
			            <div class="col-sm-2 control-label"><label for="offmTelno">회사 대표번호</label></div>
			            <div class="col-sm-4">
			            	<input type="text" value="${resultVO.offmTelno}" id="offmTelno" name="offmTelno" title="회사대표번호 입력" class="form-control indispensable" onkeyup="chgNumFormat(this.id);"placeholder="‘-’ 없이 숫자만 입력해주세요.">
			            </div>
			        </div>
			        <div class="form-group">
			            <div class="col-sm-2 control-label"><label for="cmpnyEmail1">회사 이메일 </label></div>
			            <div class="col-sm-10">
			                <div class="form-inline">
			                    <input type="text" id="cmpnyEmail1" name="cmpnyEmail1" title="이메일 주소 입력" class="form-control indispensable" value="${fn:split(resultVO.cmpnyEmail,'@')[0]}">
			                    <span>@</span>
			                    <input type="text" id="cmpnyEmail2" name="cmpnyEmail2" title="이메일 도메인 입력" class="form-control indispensable"  value="${fn:split(resultVO.cmpnyEmail,'@')[1]}">
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
			            	<input type="text" value="${resultVO.fxnum}" id="fxnum" name="fxnum" title="회사팩스번호 입력" class="form-control indispensable" onkeyup="chgNumFormat(this.id);" placeholder="‘-’ 없이 숫자만 입력해주세요.">
			            </div>
			        </div>
			        <div class="form-group">
			            <div class="col-sm-2 control-label"><label for="rprsntvNm"><span class="pilsu">필수입력</span>대표자명</label></div>
			            <div class="col-sm-4">
		                    <input type="text" value="${resultVO.rprsntvNm}" id="rprsntvNm" name="rprsntvNm" title="대표자명" class="form-control">
			            </div>
			        </div>
			        <div class="form-group">
			            <div class="col-sm-2 control-label"><label for="rprsntvCttpc"><span class="pilsu">필수입력</span>대표자 휴대폰</label></div>
			            <div class="col-sm-4">
			            	<input type="text" value="${resultVO.rprsntvCttpc}" id="rprsntvCttpc" name="rprsntvCttpc" title="대표자 휴대폰번호 입력" class="form-control indispensable" onkeyup="chgNumFormat(this.id);" placeholder="‘-’ 없이 숫자만 입력해주세요.">
			            </div>
			        </div>
			        <div class="form-group">
			            <div class="col-sm-2 control-label"><label for="rprsntvEmail1"><span class="pilsu">필수입력</span>대표자 이메일 </label></div>
			            <div class="col-sm-10">
			                <div class="form-inline">
			                    <input type="text" id="rprsntvEmail1" name="rprsntvEmail1" title="이메일 주소 입력" class="form-control indispensable" value="${fn:split(resultVO.rprsntvEmail,'@')[0]}">
			                    <span>@</span>
			                    <input type="text" id="rprsntvEmail2" name="rprsntvEmail2" title="이메일 도메인 입력" class="form-control indispensable" value="${fn:split(resultVO.rprsntvEmail,'@')[1]}">
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
			                    	<input type="text"  name="zip" id="zip"  maxlength="8" placeholder="우편번호" readonly="readonly" class="form-control" value="${resultVO.zip}">
			                    </div>
			                    <button type="button" onclick="javascript:goZipCodePopup();" class="btn btn-default">주소검색</button>
			        
			                </div>
			                <div class="form-control-static">
			              		<input type="text" name="roadAdres" id="roadAdres" readonly="readonly" class="form-control" title="도로명주소 입력" value="${resultVO.roadAdres }"/>
			                </div>
			                <div class="form-control-static">
									<input type="text" id="totAdres" name="totAdres" class="form-control" title="지번주소 입력" readonly="readonly" value="(${resultVO.houseAdres } , ${resultVO.detailAdres })"/>
									<input type="hidden" name="houseAdres" id="houseAdres" readonly="readonly" value="${resultVO.houseAdres }"/>
									<input type="hidden" name="detailAdres" id="detailAdres" readonly="readonly"value="${resultVO.detailAdres }"/>
								</div>
			            </div>
			        </div>
			        <div class="form-group">
			            <div class="col-sm-2 control-label"><label for="bizcnd">업태</label></div>
			            <div class="col-sm-10">
		                    <input type="text" value="${resultVO.bizcnd}" id="bizcnd" name="bizcnd" title="업태" class="form-control">
			            </div>
			        </div>
			        <div class="form-group">
			            <div class="col-sm-2 control-label"><label for="induty">업종</label></div>
			            <div class="col-sm-10">
		                    <input type="text" value="${resultVO.induty}" id="induty" name="induty" title="업종" class="form-control">
			            </div>
			        </div>
			        
			        
			    </div>
			
				<h2 class="h2">알림 정보 수신동의(선택)</h2>
<!-- 			    <div class="example-box"> -->
<!-- 			        <p>내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.</p> -->
<!-- 			    </div> -->
			    <div class="ui_radio--custom">
			        <input class="checkbox" type="checkbox" id="smsRecptnAt" name="smsRecptnAt" title="수신동의" value="Y" <c:if test="${resultVO.smsRecptnAt eq 'Y'}">checked</c:if>>
			        <label for="smsRecptnAt"><span class="chk_ball"></span>SMS 문자메세지</label>
			        <input class="checkbox" type="checkbox" id="emailRecptnAt" name="emailRecptnAt" title="수신동의" value="Y" <c:if test="${resultVO.emailRecptnAt eq 'Y'}">checked</c:if>>
			        <label for="emailRecptnAt"><span class="chk_ball"></span>E-mail</label>
			    </div>
			
			
			
			    <h2 class="h2">광고 수신동의</h2>
<!-- 			    <div class="example-box"> -->
<!-- 			        <p>내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.</p> -->
<!-- 			    </div> -->
			    <div class="ui_radio--custom">
			        <input class="radio" type="radio" id="advrtsRecptnAt1" name="advrtsRecptnAt" title="동의" value="Y" <c:if test="${resultVO.advrtsRecptnAt eq 'Y'}">checked</c:if>>
	                <label class="radio--custom" for="advrtsRecptnAt1"><span class="chk_ball">동의</span></label>
	                <input class="radio" type="radio" id="advrtsRecptnAt2" name="advrtsRecptnAt" title="동의하지 않음" value="N" <c:if test="${resultVO.advrtsRecptnAt eq 'N'}">checked</c:if>>
	                <label class="radio--custom" for="advrtsRecptnAt2"><span class="chk_ball">동의하지 않음</span></label>
		   		</div>
			       
			    <div class="text-center">
			        <button type="button" class="btn btn-primary" onclick="javascript:fn_update_mber()">정보수정</button>
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
