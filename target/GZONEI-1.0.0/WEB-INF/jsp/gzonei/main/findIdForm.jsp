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

<!-- 구현부 : S -->
<script>
/*********************************************************
 * 아이디 찾기
 ******************************************************** */
function findUserId() {
	
	if("" == document.loginForm.name.value){
		//이름(사업자명) 입력 필요
		$('#tooltips').css("display","block");
		$('#tooltips').html("이름을 입력해주세요.");
		$('#name').focus();
	} else if(("" == document.loginForm.mbtlnum1.value) || ("" == document.loginForm.mbtlnum2.value) || ("" == document.loginForm.mbtlnum3.value)){
		//연락처 입력 필요
		$('#tooltips').css("display","block");
		$('#tooltips').html("휴대폰번호를 입력해주세요.");
		$('#mbtlnum1').focus();
	}else{
		$('#mbtlnum').val($('#mbtlnum1').val() + '-' + $('#mbtlnum2').val() + '-' + $('#mbtlnum3').val());
		var mbtlnum = $('#mbtlnum').val();
		$.ajax({
			type:"POST",
			url: "<c:url value='/cmmn/GzoneiSearchId.do'/>",
			data:$("#loginForm").serializeArray(),
			dataType:'json',
			async:false,
			success:function(data){
				var html = '';
				if (data.result != "") {
					html = "<strong>회원님의 <b>GZONE</b> 아이디를 알려드립니다.</strong><p>"+data.result+"</p>";
					$('#findIdBtn').text("로그인화면");
					$('#findIdBtn').attr("onClick", "javascript:moveLogin();");
				}else{   
					html = "<strong>입력하신 정보와 일치하는 아이디가 없습니다.<br/> 다시한번 확인해주시기 바랍니다.</strong>";
				}
					$('#resultDiv').css("display","block");
					$('#resultDiv').html(html);
			} 
			,error : function(e) {
				var html = "<strong>회원정보 조회에 실패하였습니다.</strong><p>관리자에게 문의바랍니다.</p><p>문의 02-322-3152</p>";
				$('#resultDiv').css("display","block");
				$('#resultDiv').html(html);
				
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
function enterkeyInv() {
	if (window.event.keyCode == 13) { //javascript에서는 13이 enter키를 의미함 
		event.preventDefault();
		findUserId();
	}
}
</script>
<div id="body_layout">	
    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
            
        
            <div id="txt">
            <!-- content 영역입니다. -->
            

				<div class="login_wrap2">
					<div class="header">
						<h4 class="modal__title"><b>GZONE</b>아이디가 기억나지 않으세요?</h4>
						<p>정보를 입력하시면 아이디를 안내해드립니다.</p>
					</div>
					<div class="content">
						<form id="loginForm" name="loginForm" autocomplete="off" method="post">
				            <fieldset>  
				                <legend>로그인</legend>
				                <div class="form-horizontal bucket-form">
				                	<div class="form-group">
					                    <label for="name" class="flow">개인/사업자</label>
						                    <select id="indvdlMberCode" name="indvdlMberCode" class="form-control" style="width:100%;">
						                    	<option value="CM00210001">개인</option>
						                    	<option value="CM00210002">사업자</option>
						                    </select>
					                </div>
				                	<div class="form-group">
					                    <label for="name" class="flow">이름</label>
						                    <input type="text" class="form-control" id="name" name="name" value="" placeholder="이름 입력" aria-required="true">
					                </div>
					                <div class="form-group">
										<label for="tel">휴대폰번호</label>
										<div class="form-inline">
											<select id="mbtlnum1" name="mbtlnum1" class="form-control" title="연락처 첫번째창 선택">
												<option value="010">010</option>
												<option value="011">011</option>
												<option value="016">016</option>
												<option value="017">017</option>
												<option value="018">018</option>
												<option value="019">019</option>
											</select>
											<span>-</span>
											<input type="text" id="mbtlnum2" name="mbtlnum2" title="연락처 두번째창 입력" class="form-control" value="" maxlength="4">
										<span>-</span>
										<input type="text" id="mbtlnum3" name="mbtlnum3" title="연락처 세번째창 입력" class="form-control" value="" maxlength="4" onkeypress="return enterkeyInv();">
										<input type="hidden" name="mbtlnum" id="mbtlnum" value="" >
										</div>
									</div>
					                <!-- 툴팁 필요시 노출 -->
						            <p class="txt-tip" id="tooltips" style="display:none;"></p>
				                </div>
								<div class="result_txt" style="margin-top: 36px;display:none;" id="resultDiv">
									<strong>회원님의 <b>GZONE</b> 아이디를 알려드립니다.</strong>
									<p id="idResult"> </p>
								</div>
				            </fieldset>
				        </form>
					</div>
					<div class="footer">
						<button type="button" id="findIdBtn" class="btn btn-primary" onclick="javascript:findUserId()">아이디 찾기</button>
					</div>
				</div>    

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
