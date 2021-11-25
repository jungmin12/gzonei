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
<%@ include file="/WEB-INF/jsp/gzonei/layout/admintop.jsp" %>
<!-- header -->
<script>
$(document).ready(function(){
	//권한 --접근
	checkAuth("adm002002", "menuAccesAt",""); 
	$("#btnSearch").click(function(){
		fn_search();
	});

});
function fn_search(){
	if(checkAuth("adm002002", "infoInqireAt","")){
		document.searchForm.pageIndex.value = 1;
		document.searchForm.action = "<c:url value='/admin/today/developGosi.do'/>";
		document.searchForm.target = "";
	   	document.searchForm.submit();
	}
}
/*********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_select_linkPage(pageNo){
	if(checkAuth("adm002002", "infoInqireAt","")){
		document.searchForm.pageIndex.value = pageNo;
		document.searchForm.action = "<c:url value='/admin/today/developGosi.do'/>";
		document.searchForm.target = "";
	   	document.searchForm.submit();
	}
}
function fn_toDevBtn(sn){
	if(checkAuth("adm002002", "infoInqireAt","")){
		document.searchForm.devlopInfoSn.value = sn;
		document.searchForm.type.value = "admin";//관리자페이지로 이동
		document.searchForm.action = "<c:url value='/map.do'/>";
		document.searchForm.target = "_blank";
	   	document.searchForm.submit();
	}
}
</script>
<!-- 구현부 : S -->

<div id="body_layout">	

    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
            <div id="location" class="title_wrap">
                <h2 class="page__title">개발정보 필수고시</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="<c:url value='/admin/today/prtnSttus.do'/>">오늘의 정보</a></li>
                        <li class="n3"><a href="<c:url value='/admin/today/developGosi.do'/>" class="navi_ov">개발정보 필수고시</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">
	               
            <!-- content 영역입니다. -->
            <form name="searchForm" id="searchForm" method="post" action="javascript:fn_search();">
			<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
			<input name="userId" type="hidden" value="${sessionScope.loginVO.id}">
			<input type="hidden" name="devlopInfoSn" value=""/>
			<input type="hidden" name="type" value=""/>
				 <fieldset>
					 <legend>검색</legend>
					 <div class="search custom-search">
						<div class="form-group p-row">
							<%-- <span class="p-col-2 p-col-sm-6 tit">기간검색</span>
	                       <div class="p-col-4 p-col-sm-9">
									<input type="text" class="p-control" name="startDate" id="startDate" placeholder="시작일" value="${searchVO.startDate}" title="시작일 입력">
									<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
							</div> 
							<div class="p-col-4 p-col-sm-9">
									<input type="text" class="p-control" name="endDate" id="endDate" placeholder="종료일" value="${searchVO.endDate}" title="종료일 입력">
	                                  <button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
							</div>
							<span class="p-col-1 p-col-sm-6 tit"></span> --%>
							<span class="p-col-3 p-col-sm-6 tit">개발 사업명</span>
							<div class="p-col-18  p-col-sm-18">
								<input type="text" name="searchKrwd" value="${searchVO.searchKrwd}" title="검색어를 입력해주세요" placeholder="검색어를 입력해주세요" class="p-control">
	                       </div>
	                       <div class="p-col-2  p-col-sm-24">
	                       	 <input type="submit" value="검색" class="submit" id="btnSearch">
	                       </div>
						</div>
						
                    </div>
				 </fieldset>
			 </form>
			<!-- Table : S -->
				<div class="table-responsive mt_20">
				<p>총 : <fmt:formatNumber value="${paginationInfo.totalRecordCount}" pattern="#,###" />건</p>
						<table class="table table-bordered text-center">
							<caption>오늘의 취재: 개발사업명, 추진일, 향후 추진계획 내역</caption>
							<colgroup>
								<col style="width:55%">
								<col style="width:15%">
								<col style="width:15%">
								<col style="width:15%">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">개발 사업명</th>
	                                <th scope="col">지구지정 고시</th>
	                                <th scope="col">개발계획 고시</th>
	                                <th scope="col">실시계획 고시</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
								<c:when test="${resultList == null or fn:length(resultList) == 0 }">
									<tr><td colspan="4">조회된 정보가 없습니다.</td></tr>
								</c:when>
								<c:otherwise>
	                        	<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
								<tr>
									<td>
									<a id="${resultInfo.devlopInfoSn}" class="bt toDevBtn" href="javascript:fn_toDevBtn('${resultInfo.devlopInfoSn}')">
									${resultInfo.dwkNm }
									</a>
									</td>
									<td>
									<c:if test="${resultInfo.jigu > 0 }">
									유
									</c:if> 
									<c:if test="${resultInfo.jigu <= 0 }">
									무
									</c:if> 
									</td>
									<td>
									<c:if test="${resultInfo.dev > 0 }">
									유
									</c:if> 
									<c:if test="${resultInfo.dev <= 0 }">
									무
									</c:if> 
									</td>
									<td>
									<c:if test="${resultInfo.sil > 0 }">
									유
									</c:if> 
									<c:if test="${resultInfo.sil <= 0 }">
									무
									</c:if> 
									</td>
	                        	</tr>
	                       		</c:forEach>
	                       		</c:otherwise>
							</c:choose>
	                        </tbody>
						</table>
				</div>
							
				<!-- Table : E -->
				<!-- Paging : S -->
				<div class="pagination-inner">
					<ul class="pagination">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_linkPage"/>
					</ul>
                </div>
				<!-- Paging : E -->
			
			
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
