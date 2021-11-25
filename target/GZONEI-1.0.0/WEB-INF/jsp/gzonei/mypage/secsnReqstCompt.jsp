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
<script>
function fn_main(){
	location.href="<c:url value='/main.do' />";
}

</script> 
<!-- 구현부 : S -->

<div id="body_layout">	
    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
			<div id="txt">
				<div class="out_wrap2">
				    <span></span>
				    <strong><b>GZONE</b>회원탈퇴 신청이 완료되었습니다</strong>
				    <p>그동안 지존서비스를 이용해 주셔서 감사합니다.</p>
				    <button type="button" class="btn btn-default" onclick="javascript:fn_main();">메인으로</button>
				</div>
			</div>
		</div>
    </div>
</div>
<!-- 구현부 : E -->

<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>
</body>
</html>