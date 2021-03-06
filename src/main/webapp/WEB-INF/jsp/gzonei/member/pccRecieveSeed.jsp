<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<title>본인실명확인 서비스 Sample 화면</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script language="javascript" src="<c:url value='/js/gzonei/jquery-3.5.1.js' />"></script>
</head>
<script>
function end() {
<%-- 	window.opener.location.href = '<%= certVO.getAddVar() %><%=param%>'; --%>
	document.resultForm.target = "agreement";
	document.resultForm.action = "<c:url value='/joinStep3.do'/>";
   	document.resultForm.submit();
	self.close();
}
</script>

<body onload="javascript:end()">
<form name="resultForm" method="post" action="<c:url value='/joinStep3.do'/>">
	<input type="hidden" name="retInfo" id="retInfo" value="${fn:replace(fn:replace(param,'{retInfo=',''),'}','')}">
	<input type="hidden" name="psnMemCd" id="psnMemCd" value="01">
</form>
<%-- param :${fn:replace(fn:replace(param,'{',''),'}','')}<br> --%>
<%-- param :${fn:replace(fn:replace(param,'{retInfo=',''),'}','')}<br> --%>
<%-- retInfo :${certVO.retInfo}<br> --%>
<%-- retInfo3 :${retInfo}<br> --%>
<!-- <a href="javaScript:end()">클릭</a> -->
</body>
</html>
