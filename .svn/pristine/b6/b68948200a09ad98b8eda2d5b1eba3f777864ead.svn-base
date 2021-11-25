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
	checkAuth("adm006002", "menuAccesAt",""); 

});
function fn_search(){
	if(checkAuth("adm006002", "infoInqireAt","")){
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
		document.searchForm.action = "<c:url value='/admin/payment/nbkkCnfirmList.do'/>";
	   	document.searchForm.submit();
	}
}
/*********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_select_linkPage(pageNo){
	if(checkAuth("adm006002", "infoInqireAt","")){
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
		document.searchForm.action = "<c:url value='/admin/payment/nbkkCnfirmList.do'/>";
	   	document.searchForm.submit();
	}
}
/*********************************************************
 * 입금 승인
 ******************************************************** */
 function fn_doPayment(setleSn,id,goodsDetailCode,useMonthCo,goodsCode)	{
	 if(checkAuth("adm006002", "infoRegistAt","")){
		Common.Dialog.confirm({
	        title: '무통장 입금 확인',
	        content: '입금 여부를 확인하였습니까?'
	        ,ok: function(){
	        	Common.Dialog.confirm({
	                title: '무통장 입금 확인',
	                content:id+'회원의 서비스 이용등록을 하시겠습니까?'
	                ,ok: function(){
	                	$.ajax({
	                		type:"POST",
	                		url:"<c:url value='/admin/member/confirmPayment.do' />",
	                		data:{ "userId" : id , "setleSn" : setleSn, "goodsDetailCode":goodsDetailCode, "useMonthCo":useMonthCo, "goodsCode":goodsCode 	},
	                		dataType:'json',
	                		async:false,
	                		success:function(data){
	                			if (data.result > 0) {
	                				Common.Dialog.alert({
	        		                    title: '무통장 입금 확인'
	        		                    ,content: '서비스 이용 등록 되었습니다.'
	        		                    ,ok : function(){
	        		                    	document.searchForm.pageIndex.value = 1;
	        		                		document.searchForm.action = "<c:url value='/admin/payment/nbkkCnfirmList.do'/>";
	        		                	   	document.searchForm.submit();
	        		                    }
	        		                }); 
	                			}
	                			else {
	                				Common.Dialog.alert({
	        		                    title: '무통장 입금 확인'
	        		                    ,content: '이용 등록 처리에 실패했습니다.'
	        		                }); 
	                			}
	                		}
	                		,error : function(e) {alert("관리자에게 문의바랍니다.");}
	                		,beforeSend:function(){
	            				//전송 전
	            				$('.wrap-loading').removeClass('display-none');	
	            		    }
	            		    ,complete:function(){
	            		        //전송 후
	            		    	$('.wrap-loading').addClass('display-none');
	            		    }
	                	});
	                }
	         });
	       }
		});
	 }
}
</script>
<!-- 구현부 : S -->

<div id="body_layout">	

    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
            <div id="location" class="title_wrap">
                <h2 class="page__title">무통장 승인</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="<c:url value='/admin/payment/excclcList.do'/>" >결제 관리</a></li>
                        <li class="n3"><a href="<c:url value='/admin/payment/nbkkCnfirmList.do'/>" class="navi_ov">무통장 승인</a></li>
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
							<span class="p-col-3 p-col-sm-6 tit">검색조건</span>
							<div class="p-col-4 p-col-sm-18">
							<select name="searchSel" class="p-control" >
								<option value="">-- 전체 --</option>
								<option value="emplyr_id" <c:if test="${searchVO.searchSel eq 'emplyr_id' }">selected</c:if>>아이디</option>
								<option value="user_nm"  <c:if test="${searchVO.searchSel eq 'user_nm' }">selected</c:if>>이름</option>
							</select>
							</div>
							<div class="p-col-4 p-col-sm-18">
	                       	 <input type="text" name="searchKrwd" value="${searchVO.searchKrwd}" title="검색어를 입력해주세요" placeholder="검색어를 입력해주세요" class="p-control">
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
								<col style="width:10%">
								<col style="width:10%">
								<col style="width:10%">
								<col style="width:18%">
								<col style="width:7%">
								<col style="width:10%">
								<col style="width:10%">
								<col style="width:10%">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">아이디</th>
	                                <th scope="col">이름</th>
	                                <th scope="col">신청일</th>
	                                <th scope="col">결제내역</th>
                                    <th scope="col">기간(월/일)</th>
                                    <th scope="col">결제금액</th>
                                    <th scope="col">결제방법</th>
                                    <th scope="col">무통장입금확인</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
								<c:when test="${resultList == null or fn:length(resultList) == 0 }">
									<tr><td colspan="8">조회하신 내역이 없습니다.</td></tr>
								</c:when>
								<c:otherwise>
	                        	<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
								<tr>
									<td>${resultInfo.userId}</td>
									<td>${resultInfo.userNm}</td>
									<td>${resultInfo.frstRegistPnttm}</td>
									<td>${resultInfo.setleDtls}</td>
									<td>${resultInfo.useMonthCo}개월</td>
									<td><fmt:formatNumber value="${resultInfo.amount}" pattern="#,###" /></td>
									<td>${resultInfo.codeIdNm}</td>
									<td>
										<button class='txt_blt03 state01' style='padding-left:10px; padding-right:10px;' onclick='javascript:fn_doPayment("${resultInfo.setleSn}","${resultInfo.userId}","${resultInfo.goodsDetailCode}","${resultInfo.useMonthCo}","${resultInfo.goodsCode}");'>
										무통장입금확인
										</button>
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
