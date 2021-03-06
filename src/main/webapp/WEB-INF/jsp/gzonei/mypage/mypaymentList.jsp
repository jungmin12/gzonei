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
// $(document).ready(function(){
// 	var num = $(".amount").html();
//  	num = num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
// 	$(".amount").html(num);
// });
function fn_search(){
	document.subForm.pageIndex.value = 1;
	document.subForm.action = "<c:url value='/mypage/mypamentList.do'/>";
   	document.subForm.submit();
}


</script>
<!-- 구현부 : S -->

<div id="body_layout">	
<!-- layout -->
    <div class="body_wrap layout">  
<!-- contents -->
 	<div id="contens" class="contents_wrap">
 		<div id="location" class="title_wrap">
                <h2 class="page__title">나의결제내역</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="<c:url value='/mypage/modifyMyInfo.do'/>">마이페이지</a></li>
                        <li class="n3"><a href="<c:url value='/mypage/mypaymentList.do'/>" class="navi_ov">나의결제내역</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div> 
	
	    <div id="txt">
            <!-- content 영역입니다. -->

			

			<p>회원님께서 결제하신 내역을 최근일 순으로 확인할 수 있습니다. <br>결제방법이 무통장입금인 경우 입금확인된 날을 기준으로 결제일, 시작일, 만료일이 계산됩니다.</p>
<!-- 			<h2 class="h2">결제 조회 내역</h2> -->
			<div class="pay_wrap">
			<c:choose>
				<c:when test="${resultList == null or fn:length(resultList) == 0 }">
					<div class="inner">
						<em>00</em>
				        <strong>조회된 결제 내역이 없습니다.</strong>
			    	</div>
				</c:when>
				<c:otherwise>
				
				<c:forEach  items="${resultList}" var="resultInfo" varStatus="status">
				    <div class="inner">
				        <em>${resultInfo.rownum }</em>
				        <strong>${resultInfo.setleDtls }</strong>
				        <ul>
				            <li>기간 : ${resultInfo.useMonthCo }개월</li>
				            <c:choose>
				            <c:when test="${resultInfo.rcpmnyCnfirmAt =='N'}">
				            <li>입금확인중</li>
				            </c:when>
				            <c:otherwise>
				            <li>시작일 ~ 만료일 : ${resultInfo.useBgnde } ~ ${resultInfo.useEndde }</li>
				            </c:otherwise>
				            </c:choose>
				        </ul>
				        <div class="right">
				            <span>결제정보</span>
				            <ul>
				                <li id="${resultInfo.rownum }"><em>결제금액</em></li>
				                <c:choose>
				                <c:when test="${resultInfo.rcpmnyCnfirmAt =='N'}">
				                	<li><em>결제방법</em>무통장입금</li>
				                	<li><em>결제일</em>&nbsp;&nbsp;&nbsp;입금확인중</li>
				                </c:when>
				                <c:otherwise>
					                <li><em>결제방법</em>${resultInfo.codeIdNm }</li>
					                <li><em>결제일 </em>${resultInfo.setlede }</li>
				                </c:otherwise>
				                </c:choose>
				            </ul>
			                <script>
 			                	$('#<c:out value="${resultInfo.rownum}"/>').append(("<c:out value='${resultInfo.amount }'/>").replace(/\B(?=(\d{3})+(?!\d))/g, ","));
 			                </script>
				        </div>
				    </div>
			    </c:forEach>
			    
			    </c:otherwise>
			</c:choose>
			</div>
			<div class="pagination-inner">
				<ul class="pagination">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_linkPage"/>
				</ul>
				<form name="subForm" method="post" >
					<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
   				</form>
				</div>
    		
            <!-- content 영역입니다. -->	
            </div>
            
			
 	</div>
	<!-- contents -->
 </div>   
 <!-- layout -->
</div>
<!-- 구현부 : E -->

<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>
</body>
</html>