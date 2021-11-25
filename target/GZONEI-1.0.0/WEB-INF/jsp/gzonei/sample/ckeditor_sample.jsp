<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ckeditor" uri="http://ckeditor.com"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>샘플 페이지</title><!-- 행정안전부 공통서비스 테스트 사이트 -->

<script type="text/javascript" src="<c:url value='/js/gzonei/jquery-3.5.1.js' />"></script>
<script type="text/javascript" src="<c:url value='/html/egovframework/com/cmm/utl/ckeditor/ckeditor.js'/>"></script>
<script type="text/javascript" src="<c:url value='/html/egovframework/com/cmm/utl/ckeditor/adapters/jquery.js'/>"></script>

</head>

<body topmargin="0" leftmargin="0">

<!-- header -->
<script>
function search(){
	document.sampleForm.action = "<c:url value='/sample/selectSamplePage.do'/>";
	document.sampleForm.submit();
}
</script>
<!-- contents -->
<div>
	
	<!-- 상단 -->
	<div class="mp_top">
		<div class="l"><!-- left layout -->
			<h3 class="m_tit01 mt15">샘플페이지</h3>
			<div style="height:150px">
				<form name="sampleForm" method="post">
				<input type="text" name="codeIdNm" style="width:500px;" value="${searchVO.codeIdNm }"/>
				<button onclick="search();">검색</button>
				</form>				
			</div>
			
		</div>
		
		
		<div class="r"><!-- right layout -->
			Ckeditor 샘플
			<!-- CKEditor Sample <START> -->
			<textarea id='nttCn' name='nttCn' title="타이틀" cols="70" rows="15"></textarea>
           	<script type="text/javascript" src="<c:url value='/js/gzonei/ckeditor_custom_config.js'/>"></script>
			<!-- CKEditor Sample <END>-->
			
		</div>
	</div>
	
	<!-- 배너 -->
	<h3 class="m_tit01 mt15">배너 위치</h3><!-- 배너 -->
	<div class="mp_bn">
		
	</div>

<!-- bottom -->

</div><!-- contents -->

</body>
</html>
