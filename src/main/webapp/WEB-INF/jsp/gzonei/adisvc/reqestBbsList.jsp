<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<jsp:useBean id="now" class="java.util.Date" /> 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- 행정안전부 공통서비스 테스트 사이트 -->
<script language="javascript" src="<c:url value='/js/gzonei/jquery-3.5.1.js' />"></script>
<%@ include file="/WEB-INF/jsp/gzonei/layout/header.jsp" %>
</head>




<body topmargin="0" leftmargin="0">
	<%@ include file="/WEB-INF/jsp/gzonei/layout/top.jsp" %>
		


	
	
<div id="body_layout">	

    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
            <div id="location" class="title_wrap">
                <h2 class="page__title">토지보상 검토의뢰</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do' />">HOME</a></li>
                        <li class="n2"><a href="#">부가서비스</a></li>
                        <li class="n3"><a href="<c:url value='/adisvc/reqestBbsList.do'/>" class="navi_ov">토지보상 검토의뢰</a></li>
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
			<form name="bbsNttSearchForm" method="post" onsubmit="return search();">
				 <fieldset>
					 <legend>게시물 검색</legend>
					 
					 
					 <div class="search custom-search">
						<div class="form-group p-row">
							<div class="p-col-22 p-col-sm-18">
								<div class="p-col-8 p-col-sm-18">
		                            <div class="search--calendar">
										<span>
											<input type="text" class="form-control" name="startDate" id="startDate" placeholder="시작일" value="${searchVO.startDate }" title="시작일 입력">
											<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
										</span>
									</div>
									<span class="sym">~</span>
									<div class="search--calendar">
										<span>
											<input type="text" class="form-control" name="endDate" id="endDate" placeholder="종료일" value="${searchVO.endDate }" title="종료일 입력">
	                                    <button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
										</span>
									</div>
	                            </div>

								<div class="search-text">
									<div class="inner">
										<div class="search--select">
											<!-- select추가시 -->
											<span> <select id="searchType" name="searchType"
												title="검색 영역 선택">
													<option value="title"
														<c:if test="${searchVO.searchType eq 'title'}">selected</c:if>>제목</option>
													<option value="contents"
														<c:if test="${searchVO.searchType eq 'contents'}">selected</c:if>>내용</option>
											</select>
											</span> <input type="hidden" name="searchTypeval"
												value="${searchVO.searchType}" /> <input type="hidden"
												name="pageIndex" /> <input type="hidden" name="bbsId"
												value="${searchVO.bbsId}" />
											<!-- select추가시 -->
										</div>
										<div class="search--text">
											<span><input type="text" name="keyword"
												value="${searchVO.keyword}" title="검색어를 입력해주세요"
												placeholder="검색어를 입력해주세요" class="form-control"></span>
										</div>
									</div>
								</div>
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
			
			
			
            <!-- content 영역입니다. -->
			<form name="bbsNttSearchForm" method="post" onsubmit="return search();">
				 <fieldset>
					 <legend>게시물 검색</legend>
					 <div class="search">
                        <div class="search-date">
                            <div class="inner">
	                            
	                            <div class="search--calendar">
									<span>
										<input type="text" class="form-control" name="startDate" id="startDate" placeholder="시작일" value="${searchVO.startDate }" title="시작일 입력">
										<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
									</span>
								</div>
								<span class="sym">~</span>
								<div class="search--calendar">
									<span>
										<input type="text" class="form-control" name="endDate" id="endDate" placeholder="종료일" value="${searchVO.endDate }" title="종료일 입력">
                                    <button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
									</span>
								</div>
                            </div>
                        </div>
                        <div class="search-text">
                            <div class="inner">
                                <div class="search--select">
									 <!-- select추가시 -->
									 <span> 
										 <select name="searchType" id="searchType" title="검색 영역 선택">
										 	<option value="title" <c:if test="${searchVO.searchType eq'title'}">selected</c:if>>제목</option>
											<option value="reg_id" <c:if test="${searchVO.searchType eq 'reg_id'}">selected</c:if>>작성자</option>
											<option value="content" <c:if test="${searchVO.searchType eq 'content'}">selected</c:if>>내용</option>
										 </select>
									</span>
			 						<input type="hidden" name="searchTypeVal" value="${searchVO.searchType}"/> 
			 						<input type="hidden" name="pageIndex" /> 
									<!-- select추가시 -->
								</div>
                                <div class="search--text">
									 <span><input type="text" name="keyword" id="keyword" value="${searchVO.keyword}" title="검색어를 입력해주세요" placeholder="검색어를 입력해주세요" class="form-control"></span>
								</div>
								<div class="search--btn">
									 <span class="btn--submit"><input type="submit" value="검색" onclick="search();"></span>
								 </div>
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
									<option value="rdcnt" <c:if test="${searchVO.orderType eq 'rdcnt'}">selected</c:if>>조회수</option>
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
			
			
			<!-- List : S -->
			<!-- 게시글 리스트 -->
				<div class="table-list bbsTS">
				<p>총 게시글 수 :<fmt:formatNumber value="${totCnt }" pattern="##,###"/></p>
					<table>
						<colgroup>
							<col style="width:7%">
							<col style="width:8%">
							<col style="width:auto">
<%-- 							<col style="width:9%"> --%>
							<c:if test="${ loginVO.get('indvdlMberCode') eq 'CM00210003' }">
								<col style="width:7%">
								<col style="width:7%">
							</c:if>
<%-- 							<col style="width:6%"> --%>
							<col style="width:8%">
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>권한</th>
								<th>제목</th>
<!-- 								<th>작성자</th> -->
								<c:if test="${ loginVO.get('indvdlMberCode') eq 'CM00210003' }">
									<th>전시여부</th>
									<th>삭제여부</th>
								</c:if>
<!-- 								<th>조회수</th> -->
								<th>작성일</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty resultList }">
									<tr>
										<fmt:formatDate var="nowDate"  value="${now}" pattern="yyyyMMdd"/>
										<c:choose>
											<c:when test="${ loginVO.get('indvdlMberCode') eq 'CM00210003' }">
												<td colspan="6" align="center">데이터가 없습니다.</td>
											</c:when>
											<c:otherwise>
												<td colspan="4" align="center">데이터가 없습니다.</td>
											</c:otherwise>
										</c:choose>
									</tr>
								</c:when>
								<c:when test="${!empty resultList}">
									<c:set var="num" value="${totCnt - ((paginationInfo.currentPageNo-1) * 10) }"/>
									<c:forEach var="list" items="${resultList}" varStatus="status">
										<c:choose>
											<c:when test="${list.noticeAt eq 'Y' or list.noticeAt eq 'y'}">
												<tr class="notice">
   											
   												 <fmt:formatDate var="nowDate"  value="${now}" pattern="yyyy-MM-dd"/>
	                                             <fmt:formatDate var="regDate"  value="${list.frstRegistPnttm}" pattern="yyyy-MM-dd"/>
	                                    		 <fmt:parseDate var="nowDate"  value="${nowDate}" pattern="yyyy-MM-dd"/>
	                                     		 <fmt:parseNumber var="strDate" value="${nowDate.time/( 24 * 60 * 60 * 1000)}" integerOnly="true" />
	                                             <fmt:parseDate var="regDate"  value="${regDate}" pattern="yyyy-MM-dd"/>
	                                             <fmt:parseNumber var="endDate" value="${regDate.time/( 24 * 60 * 60 * 1000)}" integerOnly="true" />
	                                             <c:set var="diffDate" value="${strDate - endDate}"/>															


													<td class="atchFileId"><span class="td__num">공지</span></td>
													<td class="subject">
													<c:choose>
														<c:when test = "${list.readngAuthorCode eq 'CM00200005' or list.readngAuthorCode eq 'CM00200006'}"><span class="txt_blt03 state03">실버</span></c:when>
														<c:when test = "${list.readngAuthorCode eq 'CM00200007' or list.readngAuthorCode eq 'CM00200008' or list.readngAuthorCode eq 'CM00200009'}"><span class="txt_blt03 state01">골드</span></c:when>
														<c:when test = "${list.readngAuthorCode eq 'CM00200010' or list.readngAuthorCode eq 'CM00200011'}"><span class="txt_blt03 state02">프리미엄</span></c:when>
														<c:otherwise><span class="txt_blt03">무료</span></c:otherwise>
													</c:choose>
													</td>
													<td class="subject">
														<a href="<c:url value='/adisvc/reqestBbsDetail.do?nttId=${list.nttId}&readngAuthorCode=${list.readngAuthorCode }'/>">
														 <c:if test="${diffDate <= 3}"><span class="txt_blt02 bgc01">새글</span></c:if>
														<c:out value="${list.nttSj}"/></a>
													</td>
													
													<c:if test="${ loginVO.get('indvdlMberCode') eq 'CM00210003' }">
														<td><span class="td__date"><c:out value="${list.dspyAt}" /></span></td>
														<td><span class="td__date"><c:out value="${list.delAt}" /></span></td>
													</c:if>
													
<%-- 													<td><span class="td__date"><c:out value="${list.frstRegisterId}" /></span></td> --%>
<%-- 													<td><span class="td__date"><c:out value="${list.rdcnt}" /></span></td> --%>
													<td class="regDate"><span class="td__date"><fmt:formatDate pattern="yyyy-MM-dd" value="${list.frstRegistPnttm }"/></span></td>
												</tr>
											</c:when>
											
											<c:otherwise>
												<tr class="bbsList" style="margin:1px;">

		                                     	 <fmt:formatDate var="nowDate"  value="${now}" pattern="yyyy-MM-dd"/>
	                                             <fmt:formatDate var="regDate"  value="${list.frstRegistPnttm}" pattern="yyyy-MM-dd"/>
	                                    		 <fmt:parseDate var="nowDate"  value="${nowDate}" pattern="yyyy-MM-dd"/>
	                                     		 <fmt:parseNumber var="strDate" value="${nowDate.time/( 24 * 60 * 60 * 1000)}" integerOnly="true" />
	                                             <fmt:parseDate var="regDate"  value="${regDate}" pattern="yyyy-MM-dd"/>
	                                             <fmt:parseNumber var="endDate" value="${regDate.time/( 24 * 60 * 60 * 1000)}" integerOnly="true" />
	                                             <c:set var="diffDate" value="${strDate - endDate}"/>													


													<td><span class="td__num">${num-status.index}</span></td>
													<td class="subject">
													<c:choose>
														<c:when test = "${list.readngAuthorCode eq 'CM00200005' or list.readngAuthorCode eq 'CM00200006'}"><span class="txt_blt03 state03">실버</span></c:when>
														<c:when test = "${list.readngAuthorCode eq 'CM00200007' or list.readngAuthorCode eq 'CM00200008' or list.readngAuthorCode eq 'CM00200009'}"><span class="txt_blt03 state01">골드</span></c:when>
														<c:when test = "${list.readngAuthorCode eq 'CM00200010' or list.readngAuthorCode eq 'CM00200011'}"><span class="txt_blt03 state02">프리미엄</span></c:when>
														<c:otherwise><span class="txt_blt03">무료</span></c:otherwise>
													</c:choose>
													</td>
													<td class="subject">
														<a href="<c:url value='/adisvc/reqestBbsDetail.do?nttId=${list.nttId}&readngAuthorCode=${list.readngAuthorCode }'/>">
														<c:if test="${diffDate <= 3}"><span class="txt_blt02 bgc01">새글</span></c:if>
														<c:out value="${list.nttSj}"/></a>
<%-- 														<c:out value="${fn:substring(list.nttSj,0,9)}"/>...      --%>
													</td>
													
<!-- 													<td> -->
<%-- 														<c:choose> --%>
<%-- 															<c:when test="${list.frstRegisterId ne '' && !empty list.frstRegisterId }"><span class="td__date"><c:out value="${list.frstRegisterId}" /></span></c:when> --%>
<%-- 															<c:otherwise><span class="td__date">관리자</span></c:otherwise> --%>
<%-- 														</c:choose> --%>
<!-- 													</td> -->
													
													<c:if test="${ loginVO.get('indvdlMberCode') eq 'CM00210003' }">
														<td><span class="td__date"><c:out value="${list.dspyAt}" /></span></td>
														<td><span class="td__date"><c:out value="${list.delAt}" /></span></td>
													</c:if>
													
<%-- 													<td><span class="td__date"><c:out value="${list.rdcnt}" /></span></td> --%>
													<td class="regDate"><span class="td__date"><fmt:formatDate pattern="yyyy-MM-dd" value="${list.frstRegistPnttm }"/></span></td>
												</tr>
											</c:otherwise>
										</c:choose>
										<tr class="notr"><td class="none" colspan="3"></td></tr>
									</c:forEach>
								</c:when>
							</c:choose>
						</tbody>
					</table>
				</div>
				<!-- List : E -->
				<!-- Paging : S -->
					<div class="pagination-inner">
						<ul class="pagination">
							<ui:pagination paginationInfo="${paginationInfo}" type="image"
								jsFunction="fn_egov_select_linkPage" />
						</ul>
						<c:if test="${ loginVO.get('indvdlMberCode') eq 'CM00210003' or loginVO.get('id') ne null }">
							<div class="button-group">
								<a href="<c:url value='/adisvc/reqestWriteBbs.do'/>" class="btn btn-default" id="insert">등록</a>	
							</div>
						</c:if>
					</div>
				<!-- Paging : E -->
			
			
            <!-- content 영역입니다. -->	
            </div>
        </div>
    </div>
    <!-- layout -->

	<script>
		function search() {
			
			var startDate = bbsNttSearchForm.startDate.value;
			var endDate = bbsNttSearchForm.endDate.value;
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
				document.bbsNttSearchForm.action = "<c:url value='/adisvc/reqestBbsList.do'/>";
				document.bbsNttSearchForm.submit();
				document.bbsNttSearchForm.pageIndex.value = 1;
			}
		}
			
		
		function fn_egov_select_linkPage(pageNo){
			document.bbsNttSearchForm.pageIndex.value = pageNo;
			document.bbsNttSearchForm.action = "<c:url value='/adisvc/reqestBbsList.do'/>";
			document.bbsNttSearchForm.submit();
		}
		
		$(document).ready(function(){
			var result = "";
			result = '${msg}';

			if( result == "1"){
				 Common.Dialog.alert({
	                title: '열람 권한'
	                ,content: '열람 권한이 없습니다.'
	               	,ok: function(){
				            console.log('확인 클릭');
				 			result = "";
				          }
		            });    
				}else if(result == "2"){
					Common.Dialog.alert({
		                title: '열람 권한'
		                ,content: '로그인을 해주세요.'
		               	,ok: function(){
					            console.log('확인 클릭');
					 			result = "";
					          }
			            });    
				}
		});
	</script>




		<!-- bottom -->

	</div>
	<!-- contents -->
	
<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>
</body>
</html>