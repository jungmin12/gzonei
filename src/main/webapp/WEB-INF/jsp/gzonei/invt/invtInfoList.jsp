<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>샘플 페이지</title><!-- 행정안전부 공통서비스 테스트 사이트 -->
<script type="text/javascript" src="<c:url value='/js/gzonei/jquery-3.5.1.js' />"></script>
<script type="text/javascript"  src="<c:url value='/js/gzonei/invt/invtInfo.js' />"></script>
<script type="text/javascript"  src="<c:url value='/js/gzonei/invt/invtDevlop.js' />"></script>
<script type="text/javascript"  src="<c:url value='/js/gzonei/devlopInfo/twbsPagination.js' />"></script>

<!-- JQuery Modal -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" herf="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css"/>
<!-- 임시CSS -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="<c:url value='/css/gzonei/SRC/css/acego.prog.css'/>">

</head>
<body topmargin="0" leftmargin="0">

<!-- header -->
<script>
function fn_egov_select_linkPage (pageNo) {
	/* $('#listForm[name="pageIndex"]').val(pageNo); */
	document.listForm.pageIndex.value = pageNo;
	listSearch();
};
</script>

<!-- contents -->
			<% Date now = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy년 MM월 dd일");
			String today = sf.format(now); %>
<div>
	<!-- 상단 -->
	
	
	<div class="mp_top">
		<div class="l"><!-- left layout -->
			<h3 class="m_tit01 mt15">투자정보 목록</h3>
			<form id="listForm" name="listForm" method="post">
			<input type="hidden" name="pageIndex" value=""/>
			<table>
			<th colspan="2"> <c:out value="${today}"/> <%=today %> 현재 진행 예정 보상 경공매 물건수 <span id="total-count2"></span>건	</th>
			<tr>
				<td class="gubun">지역</td>
				<td>
					<select class='area1' id='area1' name='area1'>
					<option value='all'>전체</option>
				</select>
					<select class='area2' id='area2' name='area2'>
					<option value='all'>전체</option>
				</select>
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
					<label><input type="radio" name="paucgubun" value="bothShow" id="bothShow" checked> 전체</label>
					<label><input type="radio" name="paucgubun" value="aucShow" id="aucShow" > 경매</label>
	  			    <label><input type="radio" name="paucgubun" value="paucShow" id="paucShow"> 공매</label>
  			    </td>
			</tr>
			<tr>
			<td>
				<div id="auc" style="display:none">경매사건번호 : <select name="경매"><option value="11">선택</option><option value="22">선택2</option></select> 타경 : <input type="text" id="name" name="name"  size="10"></div>
				<div id="pauc" style="display:none">공매관리번호: <input type="text" id="name2" name="name2"  size="10"></div>
			</td>
			</tr>
			<tr>
				<td class="gubun">보상상태</td>
				<td>
					<label><input type="radio" name="rewardgubun" value="rewardShow" id="rewardShow" checked> 전체</label>
					<label><input type="radio" name="rewardgubun" value="rewardIng" id="rewardIng" > 보상중</label>
	  			    <label><input type="radio" name="rewardgubun" value="rewardEx" id="rewardEx"> 보상예정</label>
  			    </td>
			</tr>
			<tr>
				<td class="gubun">사업방식</td>
				<td>
					<label><input type="checkbox" name="buMtd" value="buMtdUse" checked> 수용 및 사용 </label>
	  			    <label><input type="checkbox" name="buMtd" value="buMtdWhan"> 환지</label>
	  			    <label><input type="checkbox" name="buMtd" value="buMtdUse"> 수용 및 사용 + 환지</label>
	  			    <label><input type="checkbox" name="buMtd" value="buMtdEtc"> 기타</label>
  			    </td>
			</tr>
			</table>
			</form>
		<button id="listSearch">경공매 검색</button>
		</div>
		
		
		<div id="pop_tbl_div" class="pop_tbl tbl_list scroll">
			투자정보 리스트
			<br>
			<label>총 <span id="total-count"></span> 건</label>
			
			<table class="paginated">
				<thead>
					<tr>
						<th>번호</th>
						<th>물건명</th>
						<th>지역1</th>
						<th>지역2</th>
						<th>감정평가금액</th>
						<th>공개여부</th>
						<th>등록자ID</th>
						<th>등록일</th>
					</tr>
				</thead>
				<tbody id="tbodyContents">
				</tbody>
			</table>
		</div>
	</div>
	<div id="invt_pagination_div" ></div>
	
	<button id="invtInsertShow">등록</button>
	<!-- 배너 -->
	<h3 class="m_tit01 mt15">배너 위치</h3><!-- 배너 -->
	<div class="mp_bn">
		
	</div>
	<jsp:include page="/WEB-INF/jsp/gzonei/invt/invtInfoDetail.jsp"/>
	<jsp:include page="/WEB-INF/jsp/gzonei/invt/invtInfoInsert.jsp"/>
<!-- bottom -->

</div><!-- contents -->

</body>
</html>
