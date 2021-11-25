<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>샘플 로그인 페이지</title><!-- 행정안전부 공통서비스 테스트 사이트 -->
<script language="javascript" src="<c:url value='/js/gzonei/jquery-3.5.1.js' />"></script>
</head>

<body topmargin="0" leftmargin="0">

<!-- header -->
<script>
function login(){
	
	document.loginForm.action = "<c:url value='/cmmn/gzoneiActionLogin.do'/>";
	
	document.loginForm.submit();
}
</script>
<!-- contents -->
<div>
	
	<!-- 상단 -->
	<div class="mp_top">
		<div class="l"><!-- left layout -->
			<h3 class="m_tit01 mt15">샘플페이지</h3>
			<div style="height:150px">
			<form name="loginForm" method="post">
				<ul>
					<li>
					로그인
					</li>
					<li>
						아이디 : <input type="text" name="id" style="width:500px;"/>
					</li>
					<li>
						비밀번호 : <input type="text" name="password" style="width:500px;"/>
					</li>
					<li>
						<button onclick="login();" style="width:500px;">로그인</button>
					</li>
				</ul>
				</form>				
			</div>
			
		</div>
	</div>
	
	<!-- 배너 -->
	<h3 class="m_tit01 mt15">배너 위치</h3><!-- 배너 -->
	<div class="mp_bn">
		${sessionScope.loginVO}
	</div>

<!-- bottom -->

</div><!-- contents -->

</body>
</html>
