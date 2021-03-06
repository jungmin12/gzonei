<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ckeditor" uri="http://ckeditor.com"%>
<jsp:useBean id="now" class="java.util.Date" />
<!DOCTYPE html>
<html lang='ko'>
<head>
<%@ include file="/WEB-INF/jsp/gzonei/layout/header.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/jsp/gzonei/layout/top.jsp" %>

<!-- 구현부 : S -->

 <div id="body_layout">	

    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
            <div id="location" class="title_wrap">
                <h2 class="page__title">보상판례</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="<c:url value='/adisvc/rewardPrcdntBbsList.do'/>" >부가서비스</a></li>
                        <li class="n3"><a href="<c:url value='/adisvc/rewardPrcdntBbsList.do'/>" class="navi_ov">보상판례</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                    <!-- 프린트 시작 -->
                    <!-- <ul class="print_wrap setting-box__group">
                        <li id="sns_layout" class="n2">
                            <button data-target="ui-open">SNS공유</button>
                            <div class="sns_wrap" data-id="ui-open">
                                <button data-button="sns_share" data-service="naver" data-title="네이버 SNS공유" title="새창열림" target="_blank"><span class="sr-only">네이버 SNS</span>공유하기</button>
                                <button data-button="sns_share" data-service="facebook" data-title="페이스북 SNS공유" title="새창열림" target="_blank"><span class="sr-only">페이스북 SNS </span>공유하기</button>
                                <button data-target="ui-close">닫기</button>
                            </div>
                        </li>                    
                        <li class="n1" id="print"><button data-print="print">프린트</button></li>
                    </ul> -->
                    <!-- 프린트 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">
	            
			<div class="nav-4th">
				<ul>
					<li <c:if test="${searchVO.seCode eq null}"> class="active"</c:if>><a href="<c:url value='/adisvc/rewardPrcdntBbsList.do'/>">전체보기 </a></li>
					<li <c:if test="${searchVO.seCode eq 'prcdnt'}"> class="active"</c:if>><a href="<c:url value='/adisvc/rewardPrcdntList.do'/>">보상판례 </a></li>
					<li <c:if test="${searchVO.seCode eq 'instrc'}"> class="active"</c:if>><a href="<c:url value='/adisvc/rewardInstructionList.do'/>">지침 </a></li>
					<li <c:if test="${searchVO.seCode eq 'reg'}"> class="active"</c:if>><a href="<c:url value='/adisvc/rewardRegList.do'/>">규정 </a></li>
				</ul>
			</div>
			
			
			
			
							<!-- 검색창 -->
         <div class="guide_item" style="margin-top:0;">
	           <!-- 검색 : S -->
			  <form name="searchForm" method="post" onsubmit="return search();">
	  		  		<fmt:formatDate var="nowDate"  value="${now}" pattern="yyyy-MM-dd"/>
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
								
								<div class="p-col-4 p-col-sm-6 ">
									<select class="p-control" name="searchType" title="검색 영역 선택">
										 	<option value="title"<c:if test="${searchVO.searchType eq 'title' }">selected</c:if>>제목</option>
											<option value="contents"<c:if test="${searchVO.searchType eq 'contents' }">selected</c:if>>내용</option>
									 </select>
								</div>
								<div class="p-col-8  p-col-sm-18">
									<input type="text" name="keyword" value="${searchVO.keyword}" title="검색어를 입력해주세요" placeholder="검색어를 입력해주세요" class="p-control">
									<input type="hidden" name="searchTypeval" value="${searchVO.searchType}" /> 
									<input type="hidden" name="pageIndex" />
									<input type="hidden" name="bbsId" value="${searchVO.bbsId}" />
		                       </div>
		                       <div class="p-col-2  p-col-sm-24">
		                       	 <input type="submit" value="검색" class="submit">
		                       </div>
							</div>
	                    </div>
					 </fieldset>
					 
					 <div class="program--search--index">
						<div class="program--control">
							<div class="sort">
								<div class="form">
									<select class="design-select gray-select small-select" id="orderType" name="orderType" onchange="search()" title="검색조건">
										<option value="frst_regist_pnttm" <c:if test="${searchVO.orderType eq 'frstRegistPnttm'}">selected</c:if>>최근 등록일순</option>
	<%-- 									<option value="rdcnt" <c:if test="${searchVO.orderType eq 'rdcnt'}">selected</c:if>>조회수</option> --%>
									</select>
									
									<c:if test="${loginVO.get('indvdlMberCode') eq 'CM00210003'}">
										<select class="design-select gray-select small-select" id="dspyAt" name="dspyAt" onchange="search()" title="검색조건">
											<option value="">전시여부</option>
											<option value="Y" <c:if test="${searchVO.dspyAt eq 'Y'}">selected</c:if>>Y</option>
											<option value="N" <c:if test="${searchVO.dspyAt eq 'N'}">selected</c:if>>N</option>
										</select>
			
										<select class="design-select gray-select small-select" id="delAt" name="delAt" onchange="search()" title="검색조건">
											<option value="">삭제여부</option>
											<option value="Y" <c:if test="${searchVO.delAt eq 'Y'}">selected</c:if>>Y</option>
											<option value="N" <c:if test="${searchVO.delAt eq 'N'}">selected</c:if>>N</option>
									</select>
									</c:if>
								</div>	
				            </div>
						</div>
					</div>	
				 </form>
				 
			 <script>
				$(document).ready(function(){
				    
				    $.datetimepicker.setLocale('ko');
				    $("#startDate,#endDate").datetimepicker({
				        timepicker : false,
				        format : 'Y-m-d',
				        scrollMonth : false,
				        scrollInput : false
				    });
				    
				    
				}); 
			</script>
    	</div>
		<!-- 검색창끝 -->
		
			
			
			
			
			<!-- List : S -->
				<div class="table-list bbsTS">
				<p>총 게시글 수 : <c:out value="${totCnt}" /></p>
					<table>
						<c:choose>
								<c:when test="${sessionScope.loginVO.indvdlMberCode eq 'CM00210003'}">
									<colgroup>
										<col style="width:7%">
										<col style="width:8%">
										<col style="width:auto">
										<col style="width:10%">
										<col style="width:10%">
	<%-- 									<col style="width:10%"> --%>
										<col style="width:6%">
										<col style="width:9%">
										<col style="width:10%">
									</colgroup>
									<thead>
									<tr>
										<th>번호</th>
										<th>등급</th>
										<th>제목</th>
	<!-- 									<th>구분</th> -->
										<th>전시여부</th>
										<th>삭제여부</th>
										<th>조회수</th>
										<th>작성자</th>
										<th>작성일</th>
									</tr>
									</thead>
								</c:when>
								<c:otherwise>
									<colgroup>
										<col style="width:7%">
										<col style="width:8%">
										<col style="width:auto">
	<%-- 									<col style="width:10%"> --%>
	<%-- 									<col style="width:10%"> --%>
	<%-- 									<col style="width:10%"> --%>
										<col style="width:15%">
									</colgroup>
									<thead>
									<tr>
										<th>번호</th>
										<th>등급</th>
										<th>제목</th>
	<!-- 									<th>구분</th> -->
	<!-- 									<th>작성자</th> -->
	<!-- 									<th>조회수</th> -->
										<th>작성일</th>
									</tr>
									</thead>
								</c:otherwise>
							</c:choose>
						<tbody>
						<c:choose>
							<c:when test="${sessionScope.loginVO.indvdlMberCode eq 'CM00210003'}">
								<c:choose>
									<c:when test="${empty resultList }">
									<fmt:formatDate var="nowDate"  value="${now}" pattern="yyyyMMdd"/>
										<tr>
											<td colspan="6" align="center">게시물이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${resultList}" var="list" varStatus="status">
											<c:set var="articleNum" value="${paginationInfo.totalRecordCount-((paginationInfo.currentPageNo-1)*paginationInfo.pageSize + status.count-1)}"/>
											   	 <fmt:formatDate var="nowDate"  value="${now}" pattern="yyyy-MM-dd"/>
	                                             <fmt:formatDate var="regDate"  value="${list.frstRegistPnttm}" pattern="yyyy-MM-dd"/>
	                                    		 <fmt:parseDate var="nowDate"  value="${nowDate}" pattern="yyyy-MM-dd"/>
	                                     		 <fmt:parseNumber var="strDate" value="${nowDate.time/( 24 * 60 * 60 * 1000)}" integerOnly="true" />
	                                             <fmt:parseDate var="regDate"  value="${regDate}" pattern="yyyy-MM-dd"/>
	                                             <fmt:parseNumber var="endDate" value="${regDate.time/( 24 * 60 * 60 * 1000)}" integerOnly="true" />
	                                             <c:set var="diffDate" value="${strDate - endDate}"/>		
											<c:set var="loginGrade" value="${sessionScope.loginVO.gradCode}"/>
						    				<c:set var="listGrade" value="${list.readngAuthorCode}"/>
											<tr>
												<td class="atchFileId"><span class="td__num"><c:out value="${articleNum}"/></span></td>
												<td class="subject">
													<c:choose>
														<c:when test = "${listGrade eq 'bbs010002'}"><span class="txt_blt03 state03">실버</span></c:when>
														<c:when test = "${listGrade eq 'bbs010003'}"><span class="txt_blt03 state01">골드</span></c:when>
														<c:when test = "${listGrade eq 'bbs010004'}"><span class="txt_blt03 state02">프리미엄</span></c:when>
													</c:choose>
													
												</td>
												<td class="subject">
													<a href="<c:url value='/adisvc/rewardPrcdntBbsDetail.do?nttId=${list.nttId}&pageIndex=${paginationInfo.currentPageNo}&articleNum=${articleNum}&listGrade=${listGrade}&seCode=reg&startDate=${searchVO.startDate}&endDate=${searchVO.endDate}&searchType=${searchVO.searchType}&keyword=${searchVO.keyword}&orderType=${searchVO.orderType}'/>">
														<c:if test="${diffDate <= 3}"><span class="txt_blt02 bgc01">새글</span></c:if>
														<c:out value="${list.nttSj}"/>
													</a>
												</td>
<%-- 												<td class="mo-hide"><span class="td__date"><c:out value="${list.seCode}"/></span></td> --%>
												<td class="mo-hide">
													<span class="td__date">
														<c:if test="${list.dspyAt eq  'Y'}">전시</c:if>
		                                            	<c:if test="${list.dspyAt eq  null or list.dspyAt eq '' or list.dspyAt eq 'N'}">미전시</c:if>
		                                            </span>
												</td>
												<td class="mo-hide">
													<span class="td__date">
														<c:if test="${list.delAt eq  'Y'}">삭제</c:if>
		                                            	<c:if test="${list.delAt eq  null || list.delAt eq '' || list.delAt eq 'N'}">미삭제</c:if>
													
													</span>
												</td>
												<td class="regDate">
													<span class="td__date"><c:out value="${list.rdcnt}"/></span>
												</td>
												<td class="mo-hide"><span class="td__date"><c:out value="${list.frstRegisterId}" /></span></td>
												<td class="regDate"> <span class="td__date"><fmt:formatDate pattern="yyyy-MM-dd" value="${list.frstRegistPnttm}"/></span></td>
											</tr>
											<tr class="notr"><td class="none" colspan="3"></td></tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${empty resultList }">
									<fmt:formatDate var="nowDate"  value="${now}" pattern="yyyyMMdd"/>
										<tr>
											<td colspan="4" align="center">게시물이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${resultList}" var="list" varStatus="status">
										<c:set var="articleNum" value="${paginationInfo.totalRecordCount-((paginationInfo.currentPageNo-1)*paginationInfo.pageSize + status.count-1)}"/>
										   	 	<fmt:formatDate var="nowDate"  value="${now}" pattern="yyyy-MM-dd"/>
	                                             <fmt:formatDate var="regDate"  value="${list.frstRegistPnttm}" pattern="yyyy-MM-dd"/>
	                                    		 <fmt:parseDate var="nowDate"  value="${nowDate}" pattern="yyyy-MM-dd"/>
	                                     		 <fmt:parseNumber var="strDate" value="${nowDate.time/( 24 * 60 * 60 * 1000)}" integerOnly="true" />
	                                             <fmt:parseDate var="regDate"  value="${regDate}" pattern="yyyy-MM-dd"/>
	                                             <fmt:parseNumber var="endDate" value="${regDate.time/( 24 * 60 * 60 * 1000)}" integerOnly="true" />
	                                             <c:set var="diffDate" value="${strDate - endDate}"/>		
										<c:set var="loginGrade" value="${sessionScope.loginVO.gradCode}"/>
						    			<c:set var="listGrade" value="${list.readngAuthorCode}"/>
										<tr>
											<td class="atchFileId"><span class="td__num"><c:out value="${articleNum}"/></span></td>
											<td class="subject">
												<c:choose>
													<c:when test = "${listGrade eq 'bbs010002'}"><span class="txt_blt03 state03">실버</span></c:when>
													<c:when test = "${listGrade eq 'bbs010003'}"><span class="txt_blt03 state01">골드</span></c:when>
													<c:when test = "${listGrade eq 'bbs010004'}"><span class="txt_blt03 state02">프리미엄</span></c:when>
												</c:choose>
											</td>
											<td class="subject">
												<a href="javascript:readngAuthorCheck('${list.nttId}','${articleNum}','${listGrade}');">
													<c:if test="${diffDate <= 3}"><span class="txt_blt02 bgc01">새글</span></c:if>
													<c:out value="${list.nttSj}"/>
												</a>
											</td>
<%-- 											<td class="mo-hide"><span class="td__date"><c:out value="${list.seCode}"/></span></td> --%>
											
<!-- 											<td class="regDate"> -->
<%-- 												<span class="td__date"><c:out value="${list.rdcnt}"/></span> --%>
<!-- 											</td> -->
<%-- 											<td class="mo-hide"><span class="td__date"><c:out value="${list.frstRegisterId}" /></span></td> --%>
											<td class="regDate"> <span class="td__date"><fmt:formatDate pattern="yyyy-MM-dd" value="${list.frstRegistPnttm}"/></span></td>
										</tr>
										<tr class="notr"><td class="none" colspan="3"></td></tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
						</tbody>
					</table>
				</div>
				<!-- List : E -->
				<!-- Paging : S -->
				<div class="pagination-inner">
					<div class="pagination">
						<ul>
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_linkPage"/>													
						</ul>
					</div>
					<c:if test="${sessionScope.loginVO.indvdlMberCode eq 'CM00210003'}">
						<div class="button-group">
							<a href="<c:url value='/adisvc/rewardPrcdntBbsRegist.do?seCode=reg'/>" class="btn btn-default">등록</a>
						</div>
					</c:if>
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
<script>
	function search() {
		debugger;
	    var startDate = searchForm.startDate.value;
	    var endDate = searchForm.endDate.value;
	    var nowDate = "${now}";
	   
	    if(startDate != "" || endDate != ""){
	       if( nowDate < startDate ){
	          Common.Dialog.alert({content: '시작일이 현재날짜보다 클수 없습니다.'});
	          return false;
	       }
	       if( nowDate < endDate ){
	          Common.Dialog.alert({content: '종료일이 현재날짜보다 클수 없습니다.'});
	          return false;
	       }
	       if(endDate != ""){
	          if(startDate > endDate){
	             Common.Dialog.alert({content: '시작일이 종료일보다 클수 없습니다.'});
	             return false;
	          }
	       }
	    }
	       document.searchForm.action = "<c:url value='/adisvc/rewardRegList.do'/>";
	       document.searchForm.submit();
	       document.searchForm.pageIndex.value = 1;
	}
	function fn_egov_select_linkPage(pageNo){
		document.searchForm.pageIndex.value = pageNo;
		document.searchForm.action = "<c:url value='/adisvc/rewardRegList.do'/>";
		document.searchForm.submit();
	}
	
	function readngAuthorCheck(nttId, articleNum, listGrade){
		var loginGrade = parseInt("${loginGrade}".substring("${loginGrade}".length-2));
		var listGradeCd = parseInt(listGrade.substring(listGrade.length-2));
		var loginGradeNm;
		
		// 최근 페이징 수정 4-22
		var pageIndex = '${paginationInfo.currentPageNo}';
		var startDate = '${searchVO.startDate}';
		var endDate = '${searchVO.endDate}';
		var searchType = '${searchVO.searchType}';
		var keyword = '${searchVO.keyword}';
		var orderType = '${searchVO.orderType}';
		
		
		if(loginGrade == 5 || loginGrade == 6){
			loginGradeNm = "실버";
		}else if(loginGrade == 7 || loginGrade == 8 || loginGrade == 9){
			loginGradeNm = "곧드";
		}else if(loginGrade == 10 || loginGrade == 11){
			loginGradeNm = "프리미엄";
		}else{
			loginGradeNm = "무료";
		}
		console.log('loginGrade : '+loginGrade);
		console.log('readngAuthor : '+listGradeCd);
		if(isNaN(loginGrade)){
			Common.Dialog.alert({content: '로그인을 해주세요.'});
		}else if(listGradeCd == 98 || listGrade == "" || listGrade == null){
			location.href= "<c:url value='/adisvc/rewardPrcdntBbsDetail.do?pageIndex="+pageIndex+"&nttId="+nttId+"&articleNum="+articleNum+"&listGrade="+listGrade+"&seCode=reg&startDate="+startDate+"&endDate="+endDate+"&searchType="+searchType+"&keyword="+keyword+"&orderType="+orderType+"'/>";
		}else if(loginGrade == 1 || loginGrade == 3){
			if(listGradeCd < 10){
				location.href= "<c:url value='/adisvc/rewardPrcdntBbsDetail.do?pageIndex="+pageIndex+"&nttId="+nttId+"&articleNum="+articleNum+"&listGrade="+listGrade+"&seCode=reg&startDate="+startDate+"&endDate="+endDate+"&searchType="+searchType+"&keyword="+keyword+"&orderType="+orderType+"'/>";
			}else{
				Common.Dialog.alert({content: '권한이 부족하여 게시물을 열람할 수 없습니다. <br /> 현재 회원님의 등급은 골드등급입니다.'});
			}
		}else if(loginGrade == 2 || loginGrade == 4){
			location.href= "<c:url value='/adisvc/rewardPrcdntBbsDetail.do?pageIndex="+pageIndex+"&nttId="+nttId+"&articleNum="+articleNum+"&listGrade="+listGrade+"&seCode=reg&startDate="+startDate+"&endDate="+endDate+"&searchType="+searchType+"&keyword="+keyword+"&orderType="+orderType+"'/>";
		}else if(loginGrade > listGradeCd || loginGrade == listGradeCd){
			location.href= "<c:url value='/adisvc/rewardPrcdntBbsDetail.do?pageIndex="+pageIndex+"&nttId="+nttId+"&articleNum="+articleNum+"&listGrade="+listGrade+"&seCode=reg&startDate="+startDate+"&endDate="+endDate+"&searchType="+searchType+"&keyword="+keyword+"&orderType="+orderType+"'/>";
		}else{
			Common.Dialog.alert({content: '권한이 부족하여 게시물을 열람할 수 없습니다. <br /> 현재 회원님의 등급은 '+loginGradeNm+'등급입니다.'});
		}
	}
</script>
</html>
 