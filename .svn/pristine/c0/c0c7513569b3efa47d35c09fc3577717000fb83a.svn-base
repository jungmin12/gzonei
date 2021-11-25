<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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


<div id="body_layout">	
    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
            <div id="txt">
            <!-- content 영역입니다. -->
			
			<ul class="step_list">
			    <li><span></span>회원선택</li>
			    <li><span></span>약관동의</li>
			    <li><span></span>정보입력</li>
			    <li class="on"><span></span>가입완료</li>
			</ul>
			<div class="out_wrap2">
			    <span></span>
			    
			    <strong><b>GZONE</b>회원가입이 완료되었습니다</strong>
			    <c:if test="${indvdlMberCode eq 'CM00210001'}">
			    <p>회원가입을 축하합니다.</p>
			    <p>로그인 후 서비스를 이용하실 수 있습니다.</p>
			    </c:if>
			    <c:if test="${indvdlMberCode eq 'CM00210002'}">
			    <p>회원가입을 축하합니다.</p>
			    <p>법인 회원은 별도의 회원관리를 위해 담당자가 제출하신 사업자등록증 확인 후 승인 여부를 결정하게 됩니다.</p>
			    <p>이와 관련하여 문의사항이 있으시면 아래 연락처로 문의 바랍니다.</p>
			    <p>팩스 : 02-322-3154 / 문의 : 02-322-3152</p>
			    </c:if>
			    <button type="button" class="btn btn-default" onclick="location.href='<c:url value='/'/>'">메인으로</button>
			    <button type="button" class="btn btn-primary" onclick="location.href='<c:url value='/cmmn/gzoneiLogin.do'/>'">로그인페이지가기</button>
<!-- 			    <button type="button" class="btn btn-primary" onclick="javascript:loginPage();">로그인페이지가기</button> -->
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
