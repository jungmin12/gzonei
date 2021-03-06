<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date" %>
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

function search_invit(){
	document.invForm.action = "<c:url value='/invt/selectInvList.do'/>";
	document.invForm.submit();
}
</script>
<!-- contents -->
<div>
	
	<!-- 상단 -->
	<div class="mp_top">
		<div class="l"><!-- left layout -->
			<h3 class="m_tit01 mt15">경공매페이지</h3>
			<div style="height:150px">
				<form name="sampleForm" method="post">
				<input type="text" name="codeIdNm" style="width:500px;" value="${searchVO.codeIdNm }"/>
				<button onclick="search();">검색</button>
				</form>				
			</div>
			
		</div>
		
		
		<div class="r"><!-- right layout -->
			경공매 샘플 
			<% Date now = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy년 MM월 dd일");
			String today = sf.format(now); %>
		</div>
		<div class="l"><!-- left layout -->
			<form name="invForm" method="post">
			<table>
			<th colspan="2"> <c:out value="${today}"/> <%=today %> 현재 진행 예정 보상 경공매 물건수 153건	</th>
			<tr>
				<td class="gubun">지역</td>
				<td>
					<select name="adr1"><option value="서울">서울</option><option value="경기">경기</option></select>
					<select name="adr2"><option value="none">-구/군-</option><option value="성동구">성동구</option></select>
				<td>
			</tr>
			<tr>
				<td class="gubun">사업지구</td>
				<td>
					<select name="jigu"><option value="11">개발사업지구1</option><option value="22">개발사업지구2</option></select>
				<td>
			</tr>
			<tr>
				<td class="gubun">입찰일</td>
				<td>
					데이트피커 ~ 데이트피커
				<td>
			</tr>
			<tr>
				<td rowspan="2" class="gubun">구분</td>
				<td>
					<label><input type="radio" name="color" value="aucShow" id="aucShow" checked> 경매</label>
	  			    <label><input type="radio" name="color" value="paucShow" id="paucShow"> 공매</label>
  			    </td>
			</tr>
			<tr>
			<td>
				<div id="auc">경매사건번호 : <select name="경매"><option value="11">선택</option><option value="22">선택2</option></select> 타경 : <input type="text" id="name" name="name"  size="10"></div>
				<div id="pauc" style="display:none">공매관리번호: <input type="text" id="name2" name="name2"  size="10"></div>
			</td>
			</tr>
			<tr>
				<td class="gubun">보상상태</td>
				<td>
					<label><input type="checkbox" name="보상" value="보상중" > 보상중</label>
	  			    <label><input type="checkbox" name="보상" value="보상예정"> 보상예정</label>
  			    </td>
			</tr>
			<tr>
				<td class="gubun">사업방식</td>
				<td>
					<label><input type="checkbox" name="사업방식" value="수용"> 수용 및 사용 </label>
	  			    <label><input type="checkbox" name="사업방식" value="환지"> 환지</label>
	  			    <label><input type="checkbox" name="사업방식" value="both"> 수용 및 사용 + 환지</label>
	  			    <label><input type="checkbox" name="사업방식" value="etc"> 기타</label>
  			    </td>
			</tr>
			<tr><td colspan="2"><button onclick="search_invit();">경공매 검색</button></td></tr>
			</table>
			</form>
		</div>
		<div class="r"><!-- right layout -->
			결과
			<ul>
			<li>
			컬럼 / 컬럼 /컬럼 / 컬럼 /컬럼 / 컬럼 /컬럼 / 컬럼 /컬럼 / 컬럼 
			</li>
			<c:choose>
				<c:when test="${resultList == null or fn:length(resultList) == 0 }">
					없음
				</c:when>
				<c:otherwise>
					<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
					<li>
					${resultInfo.courtCode } / ${resultInfo.smCode } / ${resultInfo.thingNo } / ${resultInfo.upperMapCode } / ${resultInfo.mapCode } / ${resultInfo.frstRegisterId } / ${resultInfo.lastUpdusrId }
					</li>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			</ul>
		</div>
	</div>
	
	<!-- 배너 -->
	<h3 class="m_tit01 mt15">배너 위치</h3><!-- 배너 -->
	<div class="mp_bn">
		
	</div>

<!-- bottom -->

</div><!-- contents -->
<script>
$("#aucShow").click(function(){
    $("#auc").show();
    $("#pauc").hide();
    $("input:radio[name='color'][value='aucShow']").prop("checked", true);
});

$("#paucShow").click(function(){
    $("#pauc").show();
    $("#auc").hide();
    $("input:radio[name='color'][value='paucShow']").prop("checked", true);
});

</script>
</body>
</html>
