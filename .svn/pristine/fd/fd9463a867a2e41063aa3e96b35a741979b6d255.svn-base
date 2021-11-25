<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- 행정안전부 공통서비스 테스트 사이트 -->
<script language="javascript" src="<c:url value='/js/gzonei/jquery-3.5.1.js' />"></script>
<%@ include file="/WEB-INF/jsp/gzonei/layout/header.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="/WEB-INF/jsp/gzonei/layout/admintop.jsp" %>



	<!-- header -->
	<script>
		function search() {
			var startDate = bbsNttSearchForm.startDate.value;
			var endDate = bbsNttSearchForm.endDate.value;
			
			if(startDate != null || endDate != null){
				if("${nowDate}" < startDate ){
					Common.Dialog.alert({content: '시작일이 현재날짜보다 클수 없습니다.'});
					return false;
				}
				if("${nowDate}" < endDate ){
					Common.Dialog.alert({content: '종료일이 현재날짜보다 클수 없습니다.'});
					return false;
				}
				if(startDate > endDate){
					Common.Dialog.alert({content: '시작일이 종료일보다 클수 없습니다.'});
					return false;
				}
				document.bbsNttSearchForm.action = "<c:url value='/oper/viewBbsList.do'/>";
				document.bbsNttSearchForm.submit();
				document.bbsNttSearchForm.pageIndex.value = 1;
			}
		}
		
		function fn_egov_select_linkPage(pageNo){
			document.bbsNttSearchForm.pageIndex.value = pageNo;
			document.bbsNttSearchForm.action = "<c:url value='/oper/viewBbsList.do'/>";
			document.bbsNttSearchForm.submit();
		}
	</script>
	
	

<div id="body_layout">	

    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
            <div id="location" class="title_wrap">
                <h2 class="page__title">서비스목록</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do' />">HOME</a></li>
                        <li class="n2"><a href="#">운영관리</a></li>
                        <li class="n3"><a href="<c:url value='/oper/viewService.do'/>" class="navi_ov">서비스목록</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                    
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">
	               
			<!-- <div class="nav-4th">
				<ul>
					<li class="active"><a href="#">4차탭메뉴ov</a></li>
					<li><a href="#">4차탭메뉴</a></li>
					<li><a href="#">4차탭메뉴</a></li>
					<li><a href="#">4차탭메뉴</a></li>
				</ul>
			</div> -->
			
            <!-- content 영역입니다. -->
            <div class="search">
				<form method="post">
					<div class="search-text">
						<label><strong>서비스 구분 : </strong></label> 
						<span> 
							<select name="searchType" id="searchType" title="검색 영역 선택">
								<option value="all"
									<c:if test="${searchVO.searchType eq 'all'}">selected</c:if>>전체</option>
								<option value="country"
									<c:if test="${searchVO.searchType eq 'country'}">selected</c:if>>전국</option>
								<option value="area"
									<c:if test="${searchVO.searchType eq 'area'}">selected</c:if>>지역권</option>
								<option value="singleArea"
									<c:if test="${searchVO.searchType eq 'singleArea'}">selected</c:if>>단일지역</option>
							</select>
						</span> 
						<input type="checkbox" name="servAt" value="실시간 서비스"><label>실시간서비스만 조회</label> 
						<input type="hidden" name="searchTypeVal" value="${searchVO.searchType}" />
						<div class="search--btn" style="float: right;">
							<span class="btn--submit"><input type="submit"
								value="검색" onclick="search();"></span>
						</div>
					</div>
				</form>
            </div>

			<div class="search">
				<form>
						<label>서비스정보: </label> <select>
							<option value="title"
								<c:if test="${searchVO.searchType eq'title'}">selected</c:if>>전국</option>
							<option value="reg_id"
								<c:if test="${searchVO.searchType eq 'reg_id'}">selected</c:if>>지역권</option>
							<option value="content"
								<c:if test="${searchVO.searchType eq 'content'}">selected</c:if>>단일지역</option>
						</select> <input type="text"> <label>정렬순서:</label><input
							type="text"> <input type="checkbox" value="실시여부"><label>실시여부</label>
						<input type="checkbox" value="실시여부"><label>서비스추가</label>
						<button type="submit">등록</button>
				</form>
			</div>


			<!-- 			<div class="program--search--index"> -->
<!-- 				<div class="program--control"> -->
<!-- 					<div class="sort"> -->
<!-- 						<div class="form"> -->
<!-- 							<select class="design-select gray-select small-select" id="orderType" onchange="goSearct_order()" title="검색조건"> -->
<!-- 								<option value="">최근 등록일순</option> -->
<!-- 								<option value="">조회수</option> -->
<!-- 								<option value="">추천수</option> -->
<!-- 							</select> -->
<!-- 							<select class="design-select gray-select small-select" id="displayType" onchange="goSearct_display()" title="검색조건"> -->
<!-- 								<option value="">전시여부</option> -->
<!-- 							</select> -->

<!-- 							<select class="design-select gray-select small-select" id="delectType" onchange="goSearct_delect()" title="검색조건"> -->
<!-- 								<option value="">삭제여부</option> -->
<!-- 							</select> -->
<!-- 						</div>	 -->
<!-- 		            </div> -->
<!-- 				</div> -->
<!-- 			</div>	 -->
			
			
			
            <!-- content 영역입니다. -->	
            </div>
        </div>
    </div>
    <!-- layout -->
		


	</div>
	<!-- contents -->
	
<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>



</body>
</html>