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
function login(){
	if("" == document.loginForm.id.value){
		//아이디 입력 필요
		$('#tooltips').css("display","block");
		$('#tooltips').html("아이디를 입력해주세요.");
		$('#loginId').focus();
	} else if("" == document.loginForm.password.value){
		//패스워드 입력 필요
		$('#tooltips').css("display","block");
		$('#tooltips').html("비밀번호를 입력해주세요.");
		$('#loginPwd').focus();
	}else{
		document.loginForm.action = "<c:url value='/cmmn/gzoneiActionLogin.do'/>";
		document.loginForm.submit();	
	}
	
}

function viewPw(){
	if($('#todayChk:checked').length > 0){
		//비밀번호 표시
		$('#loginPwd').attr("type","text");
	}else{
		//비밀번호 미표시
		$('#loginPwd').attr("type","password");
	}
}

function press(f){ 
	if(f.keyCode == 13){ //javascript에서는 13이 enter키를 의미함 
	document.loginForm.action = "<c:url value='/cmmn/gzoneiActionLogin.do'/>";
	loginForm.submit();	
	} 
}

</script>
<div id="body_layout">	
    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
            
        
            <div id="txt">
            <!-- content 영역입니다. -->
            
				<div class="login_wrap">
					<div class="header">
						<h4 class="modal__title"><b>GZONE</b>회원로그인</h4>
						<p>회원로그인을 하시면 다양한 서비스를  이용할 수 있습니다!</p>
					</div>
					<div class="content">
						<form id="loginForm" name="loginForm" autocomplete="off" method="post">
				            <fieldset>  
				                <legend>로그인</legend>
				                <div class="form-horizontal bucket-form">
				                	<div class="form-group">
					                    <label for="loginId" class="flow">아이디</label>
					                    <input type="text" class="form-control" id="loginId" name="id" value="" aria-required="true">
					                </div>
					                <div class="form-group">
					                    <label for="loginPwd" class="flow">비밀번호</label>
				                    	<input type="password" class="form-control" id="loginPwd" name="password" value="" aria-required="true" onkeydown="javascipt:if(event.keyCode == 13)login();" />
					                </div>
				                </div>
				                <div class="bottom">
				                	<span class="show_pass">
						                <input type="checkbox" name="" id="todayChk" onclick="viewPw();">
										<label for="todayChk">비밀번호 표시</label>
						            </span>
						            <ul>
						            	<li><a href="<c:url value='/joinStep1.do'/>">회원가입</a></li>
						            	<li><a href="<c:url value='/cmmn/gzoneiFindId.do'/>">아이디찾기</a></li>
						            	<li><a href="<c:url value='/cmmn/gzoneiFindPw.do'/>">비밀번호찾기</a></li>
						            </ul>
				                </div>
					            <!-- 툴팁 필요시 노출 -->
					            <p class="txt-tip" id="tooltips" style="display:none;">아이디/패스워드를 입력해주세요.</p>
				            </fieldset>
				        </form>
					</div>
					<div class="footer">
						<button type="button" class="btn btn-primary" onclick="login();">로그인</button>
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
