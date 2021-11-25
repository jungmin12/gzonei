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
	checkAuth("adm006001", "menuAccesAt",""); 

});
function fn_search(){
	if(checkAuth("adm006001", "infoInqireAt","")){
		var startDate = $("#startDate").val();
		var endDate = $("#endDate").val();
		let today = new Date();   

		let year = today.getFullYear(); // 년도
		let month = today.getMonth() + 1;  // 월
		let date = today.getDate();  // 날짜
		
		var nowDate = year + '-' + month + '-' + date;
		
		if(startDate != "" || endDate != ""){
			if( nowDate < startDate ){
				swal("날짜확인필요", "시작일이 현재날짜보다 클수 없습니다.","warning");
				return false;
			}
			if( nowDate < endDate ){
				swal("날짜확인필요", "종료일이 현재날짜보다 클수 없습니다.","warning");
				return false;
			}
			if(endDate != ""){
				if(startDate > endDate){
					swal("날짜확인필요", "시작일이 종료일보다 클수 없습니다.","warning");
					return false;
				}
			}
		}
		document.searchForm.pageIndex.value = 1;
		document.searchForm.action = "<c:url value='/admin/payment/excclcList.do'/>";
	   	document.searchForm.submit();
	}
}
/*********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_select_linkPage(pageNo){
	if(checkAuth("adm006001", "infoInqireAt","")){
		var startDate = $("#startDate").val();
		var endDate = $("#endDate").val();
		let today = new Date();   

		let year = today.getFullYear(); // 년도
		let month = today.getMonth() + 1;  // 월
		let date = today.getDate();  // 날짜
		
		var nowDate = year + '-' + month + '-' + date;
		
		if(startDate != "" || endDate != ""){
			if( nowDate < startDate ){
				swal("날짜확인필요", "시작일이 현재날짜보다 클수 없습니다.","warning");
				return false;
			}
			if( nowDate < endDate ){
				swal("날짜확인필요", "종료일이 현재날짜보다 클수 없습니다.","warning");
				return false;
			}
			if(endDate != ""){
				if(startDate > endDate){
					swal("날짜확인필요", "시작일이 종료일보다 클수 없습니다.","warning");
					return false;
				}
			}
		}
		document.searchForm.pageIndex.value = pageNo;
		document.searchForm.action = "<c:url value='/admin/payment/excclcList.do'/>";
	   	document.searchForm.submit();
	}
}
/*********************************************************
 * 사용자 상세 조회 처리 함수
 ******************************************************** */
function fn_excclcDetail(id){
	if(checkAuth("adm006001", "infoInqireAt","")){
		document.searchForm.excclcManageSn.value = id;
		document.searchForm.action = "<c:url value='/admin/payment/excclcView.do'/>";
		document.searchForm.submit();
	}
}
function fn_reg(){
	if(checkAuth("adm006001", "infoRegistAt","")){
		location.href = "<c:url value='/admin/payment/excclcReg.do'/>";
	}
}
</script>
<!-- 구현부 : S -->

<div id="body_layout">	

    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
            <div id="location" class="title_wrap">
                <h2 class="page__title">정산 관리</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="<c:url value='/admin/payment/excclcList.do'/>" >결제 관리</a></li>
                        <li class="n3"><a href="<c:url value='/admin/payment/excclcList.do'/>" class="navi_ov">정산 관리</a></li>
                    </ul>  
                    <!-- 로케이션 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">
	               
            <!-- content 영역입니다. -->
            <form name="searchForm" id="searchForm" method="post" action="javascript:fn_search()">
			<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
			<input name="userId" type="hidden" value="${sessionScope.loginVO.id}">
			<input type="hidden" name="excclcManageSn" value=""/>
				 <fieldset>
					 <legend>검색</legend>
					 <div class="search custom-search">
						<div class="form-group p-row">
							<span class="p-col-2 p-col-sm-6 tit">기간검색</span>
	                       <div class="p-col-4 p-col-sm-9">
									<input type="text" class="p-control" name="startDate" id="startDate" placeholder="시작일" value="${searchVO.startDate}" title="시작일 입력" autocomplete="off">
									<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
							</div> 
							<div class="p-col-4 p-col-sm-9">
									<input type="text" class="p-control" name="endDate" id="endDate" placeholder="종료일" value="${searchVO.endDate}" title="종료일 입력" autocomplete="off">
	                                  <button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
							</div>
							<span class="p-col-1 p-col-sm-6 tit"></span>
							<span class="p-col-3 p-col-sm-6 tit">입금 구분</span>
							<div class="p-col-8  p-col-sm-18">
								<select name="excclcTyCode"class="p-control" >
								<option value="">-- 전체 --</option>
								<option value="CM00250004" <c:if test="${searchVO.excclcTyCode eq 'CM00250004'}">selected</c:if>>현금</option>
								<option value="CM00250001" <c:if test="${searchVO.excclcTyCode eq 'CM00250001'}">selected</c:if>>카드</option>
							</select>
	                       </div>
	                       <div class="p-col-2  p-col-sm-24">
	                       	 <input type="submit" value="검색" class="submit">
	                       </div>
						</div>
						
                    </div>
				 </fieldset>
			 </form>
			<!-- Table : S -->
				<div class="table-responsive mt_20">
				<p>총 : <fmt:formatNumber value="${paginationInfo.totalRecordCount}" pattern="#,###" /></p>
						<table class="table table-bordered text-center">
							<caption>정산관리 내역</caption>
							<colgroup>
								<col style="width:8%">
								<col style="width:8%">
								<col style="width:10%">
								<col style="width:10%">
								<col style="width:30%">
								<col style="width:30%">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">입금일자</th>
	                                <th scope="col">입금구분</th>
	                                <th scope="col">입금액</th>
	                                <th scope="col">입금자</th>
	                                <th scope="col">입금내역</th>
	                                <th scope="col">특이사항</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
								<c:when test="${resultList == null or fn:length(resultList) == 0 }">
									<tr><td colspan="6">조회된 정보가 없습니다.</td></tr>
								</c:when>
								<c:otherwise>
	                        	<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
								<tr style="cursor: pointer;" onClick="javascript:fn_excclcDetail('${resultInfo.excclcManageSn }')">
									<td>
									<fmt:parseDate  value="${resultInfo.excclcPnttm}" var="parsedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
	     							<fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd"/>
									</td>
									<td>
									<c:if test="${resultInfo.excclcTyCode eq 'CM00250004'}">
									현금
									</c:if>
									<c:if test="${resultInfo.excclcTyCode eq 'CM00250001'}">
									카드
									</c:if>
									</td>
									<td><fmt:formatNumber value="${resultInfo.excclcAmount }" pattern="#,###" /></td>
									<td>${resultInfo.excclcNm }</td>
									<td>${resultInfo.excclcCn }</td>
									<td>${resultInfo.excclcEtcCn }</td>
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
					<div class="button-group">
						<a class="btn btn-default" href="javascript:fn_reg()" >등록</a>
					</div>
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
