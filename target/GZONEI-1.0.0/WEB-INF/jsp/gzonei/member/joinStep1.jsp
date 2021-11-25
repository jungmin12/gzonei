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
<%@ include file="/WEB-INF/jsp/gzonei/layout/top.jsp" %>

<!-- header -->
<script>
function join(mberGradCode) {
	document.subForm.mberGradCode.value = mberGradCode;
	document.subForm.action = "<c:url value='/joinStep2.do'/>";
	document.subForm.submit();
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
				    <li class="on"><span></span>회원선택</li>
				    <li><span></span>약관동의</li>
				    <li><span></span>정보입력</li>
				    <li><span></span>가입완료</li>
				</ul>
				<div class="agree_wrap">
				    <div class="header">
				        <h4 class="modal__title"><b>GZONE</b>회원가입을 환영합니다.</h4>
				        <p>회원 유형에 따라 가입 절차에 차이가 있으니 개인회원 또는 법인 회원을 선택해주세요.</p>
				    </div>
				    <div class="wrap">
				        <div class="box">
				            <span class="icon1"></span>
				            <strong>개인회원</strong>
				            <p>만 14세 이상 개인회원 가입을 원하시면 선택해주세요.</p>
				            <a href="#" onclick="join('01');return false;">회원가입</a>
				        </div>
				        <div class="box">
				            <span class="icon2"></span>
				            <strong>법인회원</strong>
				            <p>법인회원 가입을 원하시면 선택해주세요</p>
				            <a href="#" onclick="join('02');return false;">회원가입</a>
				        </div>
				    </div>
				</div>
				
            <!-- content 영역입니다. -->	
            </div>
        </div>
        <form name="subForm" method="post" action="<c:url value='/joinStep2.do'/>">
			<input name="mberGradCode" type="hidden" value="">
		</form>
    </div>
    <!-- layout -->
</div>

<!-- 구현부 : E -->

<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>
</body>
</html>