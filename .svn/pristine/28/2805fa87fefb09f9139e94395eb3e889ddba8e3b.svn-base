<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/gzonei/layout/header.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/jsp/gzonei/layout/admintop.jsp" %>
<script language="javascript" src="<c:url value='/js/gzonei/member/member.js' />"></script>
<!-- header -->
<script>
$(document).ready(function(){
	checkAuth("adm003002", "menuAccesAt",""); 
	var code="${empty resultVO.gradCode}";
	if(code == "false"){
		$('#useBgnde').val('${resultVO.useBgnde}');
		$('#useEndde').val('${resultVO.useEndde}');
		$('#divSupDt').css('display', 'inline');
	}
	
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
	
	 $("#useEndde").datetimepicker({
	        timepicker : false,
	        format : 'Y-m-d',
	        scrollMonth : false,
	        scrollInput : false,
	        validateOnBlur: false,
	        onShow:function(){
	           // var end = $("#endDate").val();
	            var start = $("#useBgnde").val();
	            this.setOptions({
	              minDate: start? start : false,
	              dateFormat: 'Y-m-d'
	             
	            })
	          }
	    	
	    }).on('keydown', function(event){
	    	onlyNum(this,event);
		});
});
function dateFormat(el){
	el.value = el.value.replace(/(\d\d\d\d)(\d\d)(\d\d)/g, '$1-$2-$3');
}
function goList(){
	document.searchForm.action = "<c:url value='/admin/member/memberList.do'/>";
   	document.searchForm.submit();
}
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
	 
	$.each($("textarea"), function (key, item) {
		item.value = item.value.trim();
	});
	 
	//개인 회월일 경우만 체크하기(개인회원구분)
	if ($('#indvdlMberCode').val() == 'CM00210001') {	
		if ($('#clCode').val() == '') {
			Common.Dialog.alert({
	            content: '구분을 선택해주세요.'
	            ,ok : function(){
	            	$('#clCode').focus();
	            }
	        });
			return false;
		}
	}
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
            content: 'ID를 입력해주세요.'
            ,ok : function(){
				$('#emplyrId').focus();
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
	// 사업자회원일 경우 체크하기
	if ($('#indvdlMberCode').val() == 'CM00210002') {	
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
		/*
		
		if ($('#atchFile_1').val() == '') {
			Common.Dialog.alert({
	            content: '사업자등록증을 첨부해주세요.'
	            ,ok : function(){
	            	$('#atchFile_1').focus();
	            }
	        });
			return false;
		}
		*/
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
	}
	// 사업자회원일 경우 체크하기

	
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
	
	
	if ($('#roadAdres').val() == '') {
		Common.Dialog.alert({
            content: '주소를 입력해주세요.'
            ,ok : function(){
            	$('#roadAdres').focus();
            }
        });
		return false;
	 }
	
	$('#emailAdres').val($('#emailAdres1').val() + '@' + $('#emailAdres2').val());
	
	if ($('#indvdlMberCode').val() == 'CM00210002') {
		
		if ($('#rprsntvEmail1').val() != '' && $('#rprsntvEmail2').val() != '') {
			$('#rprsntvEmail').val($('#rprsntvEmail1').val() + '@' + $('#rprsntvEmail2').val());
		}
		if ($('#cmpnyEmail1').val() != '' && $('#cmpnyEmail2').val() != '') {
			$('#cmpnyEmail').val($('#cmpnyEmail1').val() + '@' + $('#cmpnyEmail2').val());
		}
		$('#bizrno').val($('#bizrno1').val() + '' + $('#bizrno2').val() + '' + $('#bizrno3').val());	
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
	
	return true;
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


function fn_update_mber(){
	if(checkAuth("adm003002", "infoUpdtAt","")){
		if(validate()){
			Common.Dialog.confirm({
		        title: '수정',
	            content: '수정하시겠습니까?'
	            ,ok: function(){
	            	document.mberForm.action = "<c:url value='/admin/member/memberActionUdt.do'/>";
	        		document.mberForm.submit();
	            }
				,cancel : function(){
		        	return false;
		        }
	        });    
		}
	}
	
}

//회원등급 변경시
function onChgMemGrdCd(obj) {
	
	if (obj.value != '') {
		$('#divSupDt').css('display', 'inline');
		if ($('#useBgnde').val() == '' || $('#mberGradCodeOrg').val() == '') {
			$('#useBgnde').val(getTimeStamp());
		}
		else {
			$('#useBgnde').val("${resultVO.useBgnde}");
		}
	}
	else {
		$('#divSupDt').css('display', 'none');
		$('#useBgnde').val('');
		$('#useEndde').val('');		
	}
}
function getTimeStamp() {

    var d = new Date();
    var s =
        leadingZeros(d.getFullYear(), 4) + '-' +
        leadingZeros(d.getMonth() + 1, 2) + '-' +
        leadingZeros(d.getDate(), 2);
    return s;
}

function leadingZeros(n, digits) {
    var zero = '';
    n = n.toString();

    if (n.length < digits) {
        for (i = 0; i < digits - n.length; i++)
            zero += '0';
    }
    return zero + n;
}
</script>
<!-- 구현부 : S -->

<div id="body_layout">	

    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
            <div id="location" class="title_wrap">
                <h2 class="page__title">회원 관리</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="<c:url value='/admin/member/memberList.do'/>">사용자관리</a></li>
                        <li class="n3"><a href="<c:url value='/admin/member/memberList.do'/>" class="navi_ov">회원 관리</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">
	            
<!-- 			<div class="nav-4th" id="tab_menu"> -->
<!-- 				<ul> -->
<%-- 					<c:forEach var="item" items="${indvdlMberCode }"> --%>
<%-- 						<c:if test="${resultVO.indvdlMberCode eq item.codeId}"><li class="active"><a href="#" >${item.codeIdNm }</a></li></c:if> --%>
<%--             		</c:forEach> --%>
<!-- 				</ul> -->
<!-- 			</div> -->
            <!-- content 영역입니다. -->
			<!-- view : S -->
			<form name="mberForm" id="mberForm"  action="<c:url value='/admin/member/memberActionUdt.do'/>" method="post" enctype="multipart/form-data" >
			<input type="hidden" name="indvdlMberCode" id="indvdlMberCode" value="${resultVO.indvdlMberCode}" >
			<input type="hidden" name="emailAdres" id="emailAdres">
			<input type="hidden" name="bizrno" id="bizrno">
			<input type="hidden" name="rprsntvEmail" id="rprsntvEmail">
			<input type="hidden" name="cmpnyEmail" id="cmpnyEmail">
			<input type="hidden" name="INTER_AREA_CD" id="INTER_AREA_CD">
			<input type="hidden" name="userId" id="userId" value="${sessionScope.loginVO.id}" >
			<input type="hidden" name="emplyrId" id="emplyrId" value="${resultVO.emplyrId}" >
			<input type="hidden" name="mberGradCodeOrg" id="mberGradCodeOrg" value="${resultVO.gradCode}">
			<c:if test="${resultVO.indvdlMberCode eq 'CM00210002'}">
			<div class="board_view_in" id="cmpnyInfo">
                <div class="form-horizontal bucket-form">
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label for="cmpnyNm">회사(상호)명<span class="star" style="vertical-align: unset;">*</span></label></div>
					    <div class="col-sm-4">
					    	<input type="text" name="cmpnyNm" id="cmpnyNm" title="회사(상호)명 입력" class="form-control" value="${resultVO.cmpnyNm}">
						</div>
					</div>
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label for="bizrno1">사업자번호 <span class="star" style="vertical-align: unset;">*</span></label></div>
					  		<div class="col-sm-9">
								<div class="form-inline">
									<input type="text"  name="bizrno1" id="bizrno1" size="3" maxlength="3" title="사업자번호 첫번째창 입력" class="form-control num" value="${fn:substring(resultVO.bizrno,0,3) }">
									<span>-</span>
										<input type="text"  name="bizrno2" id="bizrno2" size="2" maxlength="2" title="사업자번호 두번째창 입력" class="form-control num" value="${fn:substring(resultVO.bizrno,3,5) }">
									<span>-</span>
									<input type="text" name="bizrno3" id="bizrno3" size="5" maxlength="5" title="사업자번호 세번째창 입력" class="form-control num" value="${fn:substring(resultVO.bizrno,5,10) }">
								</div>
							</div>
					</div>
					
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label for="bizrno1">사업자등록증 <span class="star" style="vertical-align: unset;">*</span></label></div>
					    <div class="col-sm-4 form-upload">
					    	<c:choose>
					    		<c:when test="${ empty atchFileDetail or fn:length(atchFileDetail) == 0 }">
									<div class="file-form-group">
					    	 		<div class="form-group__upload">
					    	 			<input type="text" readonly="readonly" name="atchFileNm"  class="form-control disabled">
								    	 <input type="file" accept=".jpg, .pdf" name="atchFile_1" id="atchFile_1" class="form-upload__file--hidden">
					    	 		</div>
					    	 		<div class="form-input__addon">
					    	 			<label for="atchFile_1" class="btn btn-sm btn-primary" data-button="upload"><span class="skip"></span>파일선택</label>
		                           </div>
					    	 	</div>
								</c:when>
								<c:otherwise>
									<c:forEach items="${atchFileDetail}" var="atcFile" varStatus="status">
									<c:set var="atcNum" value="${atcNum+1}"/>
									<div class="file-form-group">
										<div class="form-group__upload">
											<a <c:if test="${sessionScope.authVO.adm003002.executAt eq 'Y'}">href="javascript:attUrlFileDown('<c:url value='/cmmn/downloadFile.do?orignlFileNm=${atcFile.orignlFileNm}&fileStreCours=${atcFile.fileStreCours}'/>')" </c:if> >
						    	 			<input type="text" readonly="readonly" name="atchFileNm" class="form-control bizFile" value="${atcFile.orignlFileNm}" title="사업자등록증 다운로드" style="cursor: pointer;">
						    	 			<input type="file" accept=".jpg, .pdf" id="atchFile_${atcNum}" name="atchFile_${atcNum}" class="form-upload__file--hidden bizFile">
						    	 			</a>
						    	 		</div>
						    	 		<div class="form-input__addon">
											<label for="atchFile_${atcNum}" class="btn btn-sm btn-secondary" data-button="upload">수정</label>
											<button type="button" class="btn btn-sm btn-primary file_del_btn">파일 삭제</button>
											<input type="hidden"  name="fileStreCours" value="<c:out value='${atcFile.fileStreCours }'/>"/>
											<input type="hidden"  name="orignlFileNm" value="<c:out value='${atcFile.orignlFileNm }'/>"/>
											<input type="hidden"  class="fileSn" name="fileSn" value="<c:out value='${atcFile.fileSn}'/>"/>
											<input type="hidden"  name="uploadDt" value="<c:out value='${atcFile.uploadDt}'/>"/>
											<input type="hidden"  name="atchFileId" value="<c:out value='${atcFile.atchFileId}'/>"/>	
										</div>
									</div>
									</c:forEach>
								</c:otherwise>
					    	</c:choose>
				    	</div>
					</div>
					<div class="form-group">
			            <div class="col-sm-2 control-label"><label for="offmTelno">회사 대표번호</label></div>
			            <div class="col-sm-4">
			            	<input type="text" value="${resultVO.offmTelno}" id="offmTelno" name="offmTelno" title="회사대표번호 입력" class="form-control" onkeyup="chgNumFormat(this.id);" placeholder="‘-’ 없이 숫자만 입력해주세요.">
			            </div>
			        </div>
			        <div class="form-group">
			            <div class="col-sm-2 control-label"><label for="cmpnyEmail1">회사 이메일 </label></div>
			            <div class="col-sm-9">
			                <div class="form-inline">
			                    <input type="text" id="cmpnyEmail1" name="cmpnyEmail1" title="이메일 주소 입력" class="form-control mail" value="${fn:split(resultVO.cmpnyEmail,'@')[0]}">
			                    <span>@</span>
			                    <input type="text" id="cmpnyEmail2" name="cmpnyEmail2" title="이메일 도메인 입력" class="form-control mail"  value="${fn:split(resultVO.cmpnyEmail,'@')[1]}">
			                    <select id="cmpnyEmail3" title="이메일 도메인 선택" class="form-control mail" onChange="onChgCmpnyEmail(this.value);">
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
			            	<input type="text" value="${resultVO.fxnum}" id="fxnum" name="fxnum" title="회사팩스번호 입력" class="form-control" onkeyup="chgNumFormat(this.id);" placeholder="‘-’ 없이 숫자만 입력해주세요.">
			            </div>
			        </div>
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label for="rprsntvNm">대표자명<span class="star" style="vertical-align: unset;">*</span> </label></div>
					    <div class="col-sm-4">
					    	<input type="text" name="rprsntvNm" id="rprsntvNm" title="대표자명 입력" class="form-control" value="${resultVO.rprsntvNm}">
						</div>
					</div>
					<div class="form-group">
			            <div class="col-sm-2 control-label"><label for="rprsntvCttpc">대표자 휴대폰<span class="star" style="vertical-align: unset;">*</span></label></div>
			            <div class="col-sm-4">
			            	<input type="text" value="${resultVO.rprsntvCttpc}" id="rprsntvCttpc" name="rprsntvCttpc" title="대표자 휴대폰번호 입력" class="form-control" onkeyup="chgNumFormat(this.id);" placeholder="‘-’ 없이 숫자만 입력해주세요.">
			            </div>
			        </div>
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label for="rprsntvEmail1">대표자 이메일<span class="star" style="vertical-align: unset;">*</span></label></div>
					    <div class="col-sm-9">
							<div class="form-inline">
								<input type="text" id="rprsntvEmail1" name="rprsntvEmail1" title="이메일 주소 입력" class="form-control mail" value="${fn:split(resultVO.rprsntvEmail,'@')[0]}">
							    <span>@</span>
							    <input type="text" id="rprsntvEmail2" name="rprsntvEmail2" title="이메일 도메인 입력" class="form-control mail" value="${fn:split(resultVO.rprsntvEmail,'@')[1]}">
								<select id="rprsntvEmail3" name="rprsntvEmail3" title="이메일 도메인 선택" class="form-control mail" onChange="onChgRepreEmail(this.value);">
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
					    <div class="col-sm-2 control-label"><label for="zip">도로명주소(지번주소)<span class="star" style="vertical-align: unset;">*</span></label></div>
					    <div class="col-sm-9">
								<div class="form-control-static">
									<div class="col-sm-4">
										<input type="text"  name="zip" id="zip"  maxlength="8" placeholder="우편번호" readonly="readonly" class="form-control" value="${resultVO.zip}">
									</div>
									<div class="col-sm-4">
									<button type="button" class="btn btn-primary btn-sm" onclick="javascript:goZipCodePopup();"><i class="fa fa-search" aria-hidden="true"></i> 주소검색</button>
									</div>				
								</div>
								<div class="col-sm-12">
								<input type="text" name="roadAdres" id="roadAdres" readonly="readonly" class="form-control" title="도로명주소 입력" value="${resultVO.roadAdres }"/>
								</div>
								<div class="col-sm-12">
									<input type="text" id="totAdres" name="totAdres" class="form-control" title="지번주소 입력" readonly="readonly" value="(${resultVO.houseAdres } , ${resultVO.detailAdres })"/>
									<input type="hidden" name="houseAdres" id="houseAdres" readonly="readonly" value="${resultVO.houseAdres }"/>
									<input type="hidden" name="detailAdres" id="detailAdres" readonly="readonly" value="${resultVO.detailAdres }"/>
								</div>
						</div>
				    </div>
				
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label for="bizcnd">업태 </label></div>
					    <div class="col-sm-4">
					    	<input type="text" name="bizcnd" id="bizcnd" title="업태 입력" class="form-control" value="${resultVO.bizcnd}">
						</div>
					</div>
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label for="induty">업종 </label></div>
					    <div class="col-sm-4">
					    	<input type="text" name="induty" id="induty" title="업종 입력" class="form-control" value="${resultVO.induty}">
						</div>
					</div>
                </div>
                <div class="board_btm">
	                <div class="btns_area fl_l mo_block">
	                </div>
	             </div>
			</div>
			</c:if>
			<div class="board_view_in">
                <div class="form-horizontal bucket-form">
                	<div class="form-group">
					    <div class="col-sm-2 control-label"><label>회원구분</label></div>
					    <div class="col-sm-4">
					    	${resultVO.mbergradcodenm}
						</div>
					</div>
					<c:if test="${resultVO.indvdlMberCode eq 'CM00210001'}">
                	<div class="form-group">
					    <div class="col-sm-2 control-label"><label>개인회원구분<span class="star" style="vertical-align: unset;">*</span></label></div>
					    <div class="col-sm-4">
		                <select id="clCode" name="clCode" class="form-control" title="개인회원분류 선택">
		                	<option value="">선택</option>
	                		<c:forEach var="item" items="${clCode }">
                 				<option value="${item.codeId}" <c:if test="${resultVO.clCode eq item.codeId}">selected</c:if>>${item.codeIdNm }</option>
                 			</c:forEach>
			                </select>
		            </div>
					</div>
					</c:if>
                    <div class="form-group">
					    <div class="col-sm-2 control-label"><label for="userNm">회원명<span class="star" style="vertical-align: unset;">*</span></label></div>
					    <div class="col-sm-4">
					    	${resultVO.userNm}
						</div>
					</div>
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label for="emplyrId">아이디<span class="star" style="vertical-align: unset;">*</span></label></div>
					    <div class="col-sm-4">
					    	${resultVO.emplyrId}
						</div>
					</div>
					<div class="form-group">
		        
		            <div class="col-sm-2 control-label"><label for="password">비밀번호<span class="star" style="vertical-align: unset;">*</span></label></div>
		            <div class="col-sm-4" style="display:none;">
		                <input type="password" value="" id="password" name="password" title="비밀번호 입력" class="form-control indispensable" placeholder="영문,숫자,특문(!@#$%^&+=)조합으로 6~10자로 입력해 주세요.">
		                <span style="color: #ee5d5d;">영문,숫자,특문(!@#$%^&+=)조합으로 6~10자로 입력해 주세요.</span>
		            </div>
		        	<div class="col-sm-4">	
		        		<button type="button" id="chgPwBtn" class="btn btn-primary btn-sm" onclick="javascript:fn_change_pw();">비밀번호변경</button>
		            </div>
		        </div>
		        <div class="form-group">
				<div style="display:none;" id= "pwDiv">		            
		            <div class="col-sm-2 control-label"><label for="re_password">비밀번호확인<span class="star" style="vertical-align: unset;">*</span></label></div>
		            <div class="col-sm-4">
		                <input type="password" value="" id="re_password" name="re_password" title="비밀번호 확인 입력" class="form-control indispensable" placeholder="비밀번호를 한번 더 입력해주세요.">
		            </div>
		        </div>
		        </div>
					<%-- <div class="form-group">
					    <div class="col-sm-2 control-label"><label for="invtInqireAuthorAt1">경매정보<br>조회권한</label></div>
					    <div class="col-sm-9">
							<label class="radio-inline" for="invtInqireAuthorAt1">
							    <input type="radio" id="invtInqireAuthorAt1" name="invtInqireAuthorAt" value="Y"  <c:if test="${resultVO.invtInqireAuthorAt eq 'Y'}">checked</c:if>>Y
							</label>
							<label class="radio-inline" for="invtInqireAuthorA2">
							    <input type="radio" id="invtInqireAuthorAt2" name="invtInqireAuthorAt" value="N"  <c:if test="${resultVO.invtInqireAuthorAt eq 'N'}">checked</c:if>>N
							</label>
					   	</div>
					</div> --%>
<%--					<c:if test="${(resultVO.emplyrId eq '지존+')}"> --%>
<!-- 						패스워드, 경매정보 조회권한 표출 -->
<%-- 					</c:if> --%>
<%-- 					<c:if test="${(resultVO.emplyrId ne '지존+')}"> --%>
<!-- 						<input type="hidden" id="password" name="password"> -->
<!-- 						<input type="hidden" id="invtInqireAuthorAt" name="invtInqireAuthorAt">		 -->
<%-- 					</c:if> --%>
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label for="agrde">연령대 <span class="star" style="vertical-align: unset;">*</span></label></div>
					    <div class="col-sm-4">
							<select name="agrde" id="agrde"class="form-control" title="연령대 선택" required="">
								<option value="">연령대 선택</option>
								<option value="20" <c:if test="${resultVO.agrde eq '20'}">selected</c:if>>20대</option>
								<option value="30" <c:if test="${resultVO.agrde eq '30'}">selected</c:if>>30대</option>
								<option value="40" <c:if test="${resultVO.agrde eq '40'}">selected</c:if>>40대</option>
								<option value="50" <c:if test="${resultVO.agrde eq '50'}">selected</c:if>>50대</option>
								<option value="60" <c:if test="${resultVO.agrde eq '60'}">selected</c:if>>60대이상</option>
							</select>
					    </div>
					</div>
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label for="sexdstnCode1">성별<span class="star" style="vertical-align: unset;">*</span></label></div>
					    <div class="col-sm-9">
							<label class="radio-inline" for="sexdstnCode1">
							    <input type="radio" id="sexdstnCode1" name="sexdstnCode" value="M" title="남성" <c:if test="${resultVO.sexdstnCode eq 'M'}">checked</c:if>>남성
							</label>
							<label class="radio-inline" for="sexdstnCode2">
							    <input type="radio" id="sexdstnCode2" name="sexdstnCode" value="F" title="여성" <c:if test="${resultVO.sexdstnCode eq 'F'}">checked</c:if>>여성
							</label>
					   	</div>
					</div>
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label>회원승인일</label></div>
					    <div class="col-sm-4">
					    	<fmt:parseDate  value="${resultVO.confmDe}" var="parsedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
     						<fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd"/>
						</div>
					</div>
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label>회원등록일</label></div>
					    <div class="col-sm-4">
					    	<fmt:parseDate  value="${resultVO.frstRegistPnttm}" var="parsedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
     						<fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd"/>
						</div>
					</div>
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label>회원등급</label></div>
					    <div class="col-sm-9">
					    	<div class="form-inline">
					    	<c:if test="${empty resultVO.gradCodeNm}">
								무료
							</c:if>
					    	<c:if test="${not empty resultVO.gradCodeNm}">
								${resultVO.gradCodeNm}
							</c:if>
							<c:if test="${sessionScope.loginVO.gradCode eq 'CM00200014'}">
					    	<select name="mberGradCode" id="mberGradCode" class="form-control mail" onChange="onChgMemGrdCd(this)" >
								<option <c:if test="${empty resultVO.gradCode}">selected</c:if> value="">무료</option>
								<c:forEach var="item" items="${mberGradCode }">
									<c:if test="${resultVO.indvdlMberCode eq 'CM00210003'}">
										<c:if test="${fn:contains(item.codeIdNm, '관리자')}">
											<option value="${item.codeId}" <c:if test="${resultVO.gradCode eq item.codeId}">selected</c:if>>${item.codeIdNm }</option>
										</c:if>
									</c:if>
									<c:if test="${resultVO.indvdlMberCode ne 'CM00210003'}">
										<c:if test="${!fn:contains(item.codeIdNm, '관리자')}">
											<option value="${item.codeId}" <c:if test="${resultVO.gradCode eq item.codeId}">selected</c:if>>${item.codeIdNm }</option>
										</c:if>
									</c:if>
	                 			</c:forEach>
							</select>
							<div id="divSupDt" style="display: none;">
								<input type="text" maxlength=8 id="useBgnde" name="useBgnde" class="form-control" readOnly value="${resultVO.useBgnde}"/> ~
<%-- 								<input type="text" maxlength=10 id="useEndde" name="useEndde" class="form-control"  value="${resultVO.useEndde}" onkeyup="dateFormat(this)" maxlength="10"/> --%>
								 <div class="search--calendar">
										<span>
											<input type="text" id="useEndde" name="useEndde" class="form-control" placeholder="종료일" value="${searchVO.useEndde}" title="종료일 입력">
											 <button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
										</span>
									</div>
							</div> 
							<font color="red"><b>*법인은 사용하지 않습니다.</b></font>
							</c:if>
							</div>
						</div>
					</div>
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label for="mbtlnum">휴대폰 <span class="star" style="vertical-align: unset;">*</span></label></div>
					  		<div class="col-sm-4">
								<input type="text" id="mbtlnum" name="mbtlnum" title="휴대폰번호 입력" class="form-control" value="${resultVO.mbtlnum}" onkeyup="chgNumFormat(this.id);" placeholder="‘-’ 없이 숫자만 입력해주세요.">
							</div>
					</div>
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label for="emailAdres1">이메일<span class="star" style="vertical-align: unset;">*</span></label></div>
					    <div class="col-sm-9">
							<div class="form-inline">
								<input type="text" id="emailAdres1" name="emailAdres1" title="이메일 주소 입력" class="form-control mail" value="${fn:split(resultVO.emailAdres,'@')[0]}"/>
							    <span>@</span>
							    <input type="text" id="emailAdres2" name="emailAdres2" title="이메일 도메인 입력" class="form-control mail" value="${fn:split(resultVO.emailAdres,'@')[1]}"/>
								<select id="emailAdres3" name="emailAdres3" title="이메일 도메인 선택" class="form-control mail" onChange="onChgEmail(this.value)">
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
					<%-- <div class="form-group">
					    <div class="col-sm-2 control-label"><label for="sntncRegistAuthorAt1">쓰기권한</label></div>
					    <div class="col-sm-9">
							<label class="radio-inline" for="sntncRegistAuthorAt1">
							    <input type="radio" id="sntncRegistAuthorAt1" name="sntncRegistAuthorAt" value="Y" <c:if test="${resultVO.sntncRegistAuthorAt eq 'Y'}">checked</c:if> /> 예
							</label>
							<label class="radio-inline" for="sntncRegistAuthorAt2">
							    <input type="radio" id="sntncRegistAuthorAt2" name="sntncRegistAuthorAt" value="N" <c:if test="${resultVO.sntncRegistAuthorAt eq 'N'}">checked</c:if>/> 아니오
							</label>
					   	</div>
					</div> --%>
					<%-- <div class="form-group">
					    <div class="col-sm-2 control-label"><label for="smtmConectAt2">동시접속여부</label></div>
					    <div class="col-sm-9">
							<label class="radio-inline" for="smtmConectAt1">
							    <input type="radio" id="smtmConectAt1" name="smtmConectAt" value="Y" <c:if test="${resultVO.smtmConectAt eq 'Y'}">checked</c:if> /> 예
							</label>
							<label class="radio-inline" for="smtmConectAt2">
							    <input type="radio" id="smtmConectAt2" name="smtmConectAt" value="N" title="아니오" <c:if test="${resultVO.smtmConectAt eq 'N'}">checked</c:if>/> 아니오
							</label>
					   	</div>
					</div> --%>
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label for="smsRecptnAt1">SMS 수신여부</label></div>
					    <div class="col-sm-9">
							<label class="radio-inline" for="smsRecptnAt1">
							    <input type="radio" id="smsRecptnAt1" name="smsRecptnAt" value="Y"  title="예"  <c:if test="${resultVO.smsRecptnAt eq 'Y'}">checked</c:if> /> 예
							</label>
							<label class="radio-inline" for="smsRecptnAt2">
							    <input type="radio"  id="smsRecptnAt2" name="smsRecptnAt" value="N" title="아니오"<c:if test="${resultVO.smsRecptnAt eq 'N'}">checked</c:if> /> 아니오
							</label>
					   	</div>
					</div>
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label for="emailRecptnAt1">이메일 수신여부</label></div>
					    <div class="col-sm-9">
							<label class="radio-inline" for="emailRecptnAt1">
							    <input type="radio" id="emailRecptnAt1" name="emailRecptnAt" value="Y"  title="예"  <c:if test="${resultVO.emailRecptnAt eq 'Y'}">checked</c:if>/> 예
							</label>
							<label class="radio-inline" for="emailRecptnAt2">
							    <input type="radio" id="emailRecptnAt2" name="emailRecptnAt" value="N" title="아니오" <c:if test="${resultVO.emailRecptnAt eq 'N'}">checked</c:if>/> 아니오
							</label>
					   	</div>
					</div>
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label for="emailRecptnAt1">광고 수신<span class="star" style="vertical-align: unset;">*</span></label></div>
					    <div class="col-sm-9">
							<label class="radio-inline" for="advrtsRecptnAt1">
							    <input type="radio" id="advrtsRecptnAt1" name="advrtsRecptnAt" title="동의" value="Y"  <c:if test="${resultVO.advrtsRecptnAt eq 'Y'}">checked</c:if>/> 동의
							</label>
							<label class="radio-inline" for="advrtsRecptnAt2">
							    <input type="radio" id="advrtsRecptnAt2" name="advrtsRecptnAt" title="동의하지 않음" value="N" <c:if test="${resultVO.advrtsRecptnAt eq 'N'}">checked</c:if>/> 동의하지 않음
							</label>
					   	</div>
					</div>
					<c:if test="${resultVO.indvdlMberCode ne 'CM00210002'}">
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label for="zip">도로명주소(지번주소)<span class="star" style="vertical-align: unset;">*</span></label></div>
					    <div class="col-sm-9">
								<div>
									<div class="col-sm-4">
										<input type="text"  name="zip" id="zip"  maxlength="8" placeholder="우편번호" readonly="readonly" class="form-control" value="${resultVO.zip}">
									</div>
									<div class="col-sm-4">
									<button type="button" class="btn btn-primary btn-sm" onclick="javascript:goZipCodePopup();"><i class="fa fa-search" aria-hidden="true"></i> 주소검색</button>
									</div>
								</div>
								<div class="col-sm-12">
								<input type="text" name="roadAdres" id="roadAdres" readonly="readonly" class="form-control" title="도로명주소 입력" value="${resultVO.roadAdres }"/>
								</div>
								<div class="col-sm-12">
									<input type="text" id="totAdres" name="totAdres" class="form-control" title="지번주소 입력" readonly="readonly" value="(${resultVO.houseAdres } , ${resultVO.detailAdres })"/>
									<input type="hidden" name="houseAdres" id="houseAdres" readonly="readonly" value="${resultVO.houseAdres }"/>
									<input type="hidden" name="detailAdres" id="detailAdres" readonly="readonly" value="${resultVO.detailAdres }"/>
								</div>
						</div>
				    </div>
				    </c:if>
                    <div class="form-group">
					    <div class="col-sm-2 control-label"><label for="intrstAreaCode1">관심지역</label></div>
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
					</div>
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label for="">관심분야</label></div>
					    <div class="col-sm-9">
							<label class="radio-inline" for="intrstRealm1">
							    <input type="radio" id="intrstRealm1" name="intrstRealm" value="A"  title="개발정보"  <c:if test="${resultVO.intrstRealm eq 'A'}">checked</c:if>/> 개발정보
							</label>
							<label class="radio-inline" for="intrstRealm2">
							    <input type="radio" id="intrstRealm2" name="intrstRealm" value="B" title="투자정보" <c:if test="${resultVO.intrstRealm eq 'B'}">checked</c:if>/> 투자정보
							</label>
					   	</div>
					</div>
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label>결제메모</label></div>
					    <div class="col-sm-9">
							<textarea name="setleMemo" id="setleMemo" cols="70" rows="7">${resultVO.setleMemo }</textarea>
					   	</div>
					</div>
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label>교육메모</label></div>
					    <div class="col-sm-9">
							<textarea name="edcMemo" id="edcMemo" cols="70" rows="7">${resultVO.edcMemo }</textarea>
					   	</div>
					</div>
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label>기타메모</label></div>
					    <div class="col-sm-9">
							<textarea name="etcMemo" id="etcMemo" cols="70" rows="7">${resultVO.etcMemo }</textarea>
					   	</div>
					</div>
               </div>
			</div>
                <div class="board_btm">
                   <div class="btns_area fl_r mo_block">
						<a href="javascript:fn_update_mber()"  class="btn btn-default">수정</a>
						<a href="javascript:goList()"  class="btn btn-default">목록</a>
                   </div>
                </div>
			</form>
			<!-- view : E -->
			<form name="searchForm" id="searchForm" method="post" >
			<input name="emplyrId" type="hidden" value="">
			<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
			<input name="startDate" type="hidden" value="<c:out value='${searchVO.startDate}'/>"/>
			<input name="endDate" type="hidden" value="<c:out value='${searchVO.endDate}'/>"/>
			<input name="grad_code_nm" type="hidden" value="<c:out value='${searchVO.gradCodeNm}'/>"/>
			<input name="mber_sttus_code" type="hidden" value="<c:out value='${searchVO.mberSttusCode}'/>"/>
			<input name="email_recptn_at" type="hidden" value="<c:out value='${searchVO.emailRecptnAt}'/>"/>
			<input name="sms_recptn_at" type="hidden" value="<c:out value='${searchVO.smsRecptnAt}'/>"/>
			<input name="order" type="hidden" value="<c:out value='${searchVO.order}'/>"/>
			<input name="type" type="hidden" value="<c:out value='${searchVO.type}'/>"/>
			<input name="searchSel" type="hidden" value="<c:out value='${searchVO.searchSel}'/>"/>
			<input name="searchKrwd" type="hidden" value="<c:out value='${searchVO.searchKrwd}'/>"/>
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
