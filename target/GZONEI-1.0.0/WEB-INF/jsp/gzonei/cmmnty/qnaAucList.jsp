
<%
	/**
	 * @Class Name : fcsbbsArticleList.jsp
	 * @Description : bbsArticleList 화면
	 * @Modification Information
	 * @
	 * @  수정일             수정자                   수정내용
	 * @ -------    --------    ---------------------------
	 * 2021.03.04       안중원                 최초생성
	 *		
	 *  @author PODO 개발 3팀 안중원
	 *  @since 2021.03.04
	 *  @version 1.0
	 *  @see
	 *
	 */
%>
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

<script>
function search() {
    
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
    
       document.searchForm.action = "<c:url value='/cmmnty/qnaAucList.do'/>";
       document.searchForm.submit();
       document.searchForm.pageIndex.value = 1;
 }
 

function fn_egov_select_linkPage(pageNo){
	document.searchForm.pageIndex.value = pageNo;
	document.searchForm.action = "<c:url value='/cmmnty/qnaAucList.do'/>";
	document.searchForm.submit();
}

function viewAuthor(){
    Common.Dialog.alert({
        title: '열람 권한'
        ,content: '골드 이코노미 이상부터 열람이 가능합니다.'
      	,ok: function(){
             console.log('확인 클릭');
          }
    });    
}
function toDetail(url){
	const uri = getContextPath() + url;
	const encoded = encodeURI(uri);
	console.log(encoded);
	location.href = encoded;
}
</script>
<div id="body_layout">	
    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
            <div id="location" class="title_wrap">
                <h2 class="page__title">Q&A 게시판</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="<c:url value='/cmmnty/noticeBbsList.do'/>">커뮤니티</a></li>
                        <li class="n3"><a href="<c:url value='/cmmnty/qnaBbsList.do'/>" class="navi_ov">Q&A게시판</a></li>
                    </ul>                           
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">
	               
			<div class="nav-4th">
				<ul>
					<li><a href="<c:url value='/cmmnty/qnaBbsList.do'/>">전체보기</a></li>
					<li><a href="<c:url value='/cmmnty/qnaDevinfoList.do'/>">개발정보관련</a></li>
					<li class="active"><a href="<c:url value='/cmmnty/qnaAucList.do'/>">경매관련</a></li>
					<li><a href="<c:url value='/cmmnty/qnaPblsalList.do'/>">공매관련</a></li>
				</ul>
			</div>
			
            <!-- content 영역입니다. -->
      
            <!-- 검색창 -->
         <div class="guide_item" style="margin-top:0;">
              <!-- 검색 : S -->
           <form name="searchForm" method="post" onsubmit="return search();">
                <fieldset>
                   <legend>검색</legend>
                   <div class="search custom-search">
                     <div class="form-group p-row">
                        <span class="p-col-2 p-col-sm-6 tit">기간검색</span>
                             <div class="p-col-4 p-col-sm-9">
                              <input type="text" class="p-control" name="startDate" id="startDate" placeholder="시작일" value="${searchVO.startDate}" title="시작일 입력">
                              <button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
                        </div> 
                        <div class="p-col-4 p-col-sm-9">
                              <input type="text" class="p-control" name="endDate" id="endDate" placeholder="종료일" value="${searchVO.endDate}" title="종료일 입력">
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
   <%--                            <option value="rdcnt" <c:if test="${searchVO.orderType eq 'rdcnt'}">selected</c:if>>조회수</option> --%>
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
				<p>총 게시글 수 : <fmt:formatNumber value="${totCnt }" pattern="##,###"/></p>
						<table  class="bbsTableStyle">
							<c:choose>
								<c:when test="${sessionScope.loginVO.indvdlMberCode eq 'CM00210003'}">
								<colgroup>
									<col style="width:15%">
									<col style="width:auto">
									<col style="width:10%">
									<col style="width:10%">
									<col style="width:10%">
									<col style="width:10%">
								</colgroup>
								<thead>
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>전시여부</th>
									<th>삭제여부</th>
									<th>조회수</th>
									<th>작성일자</th>
								</tr>
								</thead>
								</c:when>
								<c:otherwise>
								<colgroup>
									<col style="width:15%">
									<col style="width:auto">
<%-- 									<col style="width:10%">								 --%>
									<col style="width:10%">								
									<col style="width:10%">								
									<col style="width:10%">
								</colgroup>
								<thead>
								<tr>
									<th>번호</th>
									<th>제목</th>
<!-- 									<th>구분</th> -->
									<th>조회수</th>
									<th>작성자</th>
									<th>작성 일자</th>
								</tr>
								</thead>
								</c:otherwise>
							</c:choose>
						<tbody>
							<c:choose>
								<c:when test="${sessionScope.loginVO.indvdlMberCode eq 'CM00210003'}">
									<c:choose>
										<c:when test="${empty resultList }">
											<tr>
												<td colspan="6" align="center">게시물이 없습니다.</td>
											</tr>
										</c:when>
										<c:when test="${!empty resultList}">
												<c:forEach var="list" items="${resultList}" varStatus="status">
												  <fmt:formatDate var="nowDate"  value="${now}" pattern="yyyy-MM-dd"/>
					                              <fmt:formatDate var="regDate"  value="${list.frstRegistPnttm}" pattern="yyyy-MM-dd"/>
												  <fmt:parseDate var="nowDate"  value="${nowDate}" pattern="yyyy-MM-dd"/>
												  <fmt:parseNumber var="strDate" value="${nowDate.time/( 24 * 60 * 60 * 1000)}" integerOnly="true" />
					                              <fmt:parseDate var="regDate"  value="${regDate}" pattern="yyyy-MM-dd"/>
					                              <fmt:parseNumber var="endDate" value="${regDate.time/( 24 * 60 * 60 * 1000)}" integerOnly="true" />
					                              <c:set var="diffDate" value="${strDate - endDate}"/>
													<tr>
														<td class="atchFileId"><span class="td__num"><c:out value="${paginationInfo.totalRecordCount-((paginationInfo.currentPageNo-1)*paginationInfo.pageSize + status.count-1)}"/></span></td>
														<td class="subject">
<%-- 															<a href="<c:url value='/cmmnty/qnaBbsDetail.do?pageIndex=${paginationInfo.currentPageNo}&nttId=${list.nttId}&articleNum=${paginationInfo.totalRecordCount-((paginationInfo.currentPageNo-1)*paginationInfo.pageSize + status.count-1)}&startDate=${searchVO.startDate}&endDate=${searchVO.endDate}&searchType=${searchVO.searchType}&keyword=${searchVO.keyword}&orderType=${searchVO.orderType}' />"> --%>
															<a href="javascript:toDetail('/cmmnty/qnaBbsDetail.do?pageIndex=${paginationInfo.currentPageNo}&nttId=${list.nttId}&articleNum=${paginationInfo.totalRecordCount-((paginationInfo.currentPageNo-1)*paginationInfo.pageSize + status.count-1)}&startDate=${searchVO.startDate}&endDate=${searchVO.endDate}&searchType=${searchVO.searchType}&keyword=${searchVO.keyword}&orderType=${searchVO.orderType}')" >
															<c:if test="${diffDate <= 3}"><span class="txt_blt02 bgc01">새글</span></c:if>
															<c:out value="${list.nttSj}"/>
															<c:if test="${list.cmtcnt ne '0' }"><span class="txt_blt02 bgc01">${list.cmtcnt}</span></c:if>
															</a>
														</td>
														<td class="mo-hide">
															<span class="td__date">
																<c:if test="${list.dspyAt eq  'Y'}">전시</c:if>
				                                            	<c:if test="${list.dspyAt eq  null or list.dspyAt eq '' or list.dspyAt eq 'N'}">미전시</c:if>
															</span>
														</td>
														<td class="mo-hide">
															<span class="td__date">
																<c:if test="${list.delAt eq  'N'}">미삭제</c:if>
				                                            	<c:if test="${list.delAt eq  null || list.delAt eq '' || list.delAt eq 'Y'}">삭제</c:if>
				                                            </span>
														</td>
														<td class="regDate">
															<span class="td__date">
																<c:out value="${list.rdcnt}"/>
															</span>
														</td>
														<td class="regDate"><span class="td__date"><fmt:formatDate pattern="yyyy-MM-dd" value="${list.frstRegistPnttm}"/></span></td>
													</tr>
													<tr class="notr"><td class="none" colspan="3"></td></tr>
											</c:forEach>
										</c:when>
									</c:choose>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${empty resultList }">
											<tr>
												<td colspan="5" align="center">게시물이 없습니다.</td>
											</tr>
										</c:when>
										<c:when test="${!empty resultList}">
												<c:forEach var="list" items="${resultList}" varStatus="status">
												  <fmt:formatDate var="nowDate"  value="${now}" pattern="yyyy-MM-dd"/>
					                              <fmt:formatDate var="regDate"  value="${list.frstRegistPnttm}" pattern="yyyy-MM-dd"/>
												  <fmt:parseDate var="nowDate"  value="${nowDate}" pattern="yyyy-MM-dd"/>
												  <fmt:parseNumber var="strDate" value="${nowDate.time/( 24 * 60 * 60 * 1000)}" integerOnly="true" />
					                              <fmt:parseDate var="regDate"  value="${regDate}" pattern="yyyy-MM-dd"/>
					                              <fmt:parseNumber var="endDate" value="${regDate.time/( 24 * 60 * 60 * 1000)}" integerOnly="true" />
					                              <c:set var="diffDate" value="${strDate - endDate}"/>
													<tr>
														<td class="atchFileId"><span class="td__num"><c:out value="${paginationInfo.totalRecordCount-((paginationInfo.currentPageNo-1)*paginationInfo.pageSize + status.count-1)}"/></span></td>
														<td class="subject">
															<a
															<c:if test="${sessionScope.authVO.bbs008002.infoInqireAt eq  'N'}"> onclick='viewAuthor();'</c:if>
															<c:if test="${sessionScope.authVO.bbs008002.infoInqireAt eq  'Y'}">
<%-- 															href="<c:url value='/cmmnty/qnaBbsDetail.do?pageIndex=${paginationInfo.currentPageNo}&nttId=${list.nttId}&articleNum=${paginationInfo.totalRecordCount-((paginationInfo.currentPageNo-1)*paginationInfo.pageSize + status.count-1)}&startDate=${searchVO.startDate}&endDate=${searchVO.endDate}&searchType=${searchVO.searchType}&keyword=${searchVO.keyword}&orderType=${searchVO.orderType}' />" --%>
															href="javascript:toDetail('/cmmnty/qnaBbsDetail.do?pageIndex=${paginationInfo.currentPageNo}&nttId=${list.nttId}&articleNum=${paginationInfo.totalRecordCount-((paginationInfo.currentPageNo-1)*paginationInfo.pageSize + status.count-1)}&startDate=${searchVO.startDate}&endDate=${searchVO.endDate}&searchType=${searchVO.searchType}&keyword=${searchVO.keyword}&orderType=${searchVO.orderType}')" 
															</c:if>
															>
															<c:if test="${diffDate <= 3}"><span class="txt_blt02 bgc01">새글</span></c:if>
															<c:out value="${list.nttSj}"/>
															<c:if test="${list.cmtcnt ne '0' }"><span class="txt_blt02 bgc01">${list.cmtcnt}</span></c:if>
<%-- 															<c:if test="${list.answerAt eq 'Y' }"><span class="txt_blt03">답변완료</span></c:if> --%>
<%-- 															<c:if test="${list.secretAt eq 'Y' }"><span class="txt_blt03">비밀글</span></c:if> --%>
															</a>
														</td>
<%-- 														<td class="mo-hide"><span class="td__date"><c:if test="${list.seCode eq '001'}">개발정보</c:if> --%>
<%-- 																									<c:if test="${list.seCode eq '002'}">경매</c:if> --%>
<%-- 																									<c:if test="${list.seCode eq '003'}">공매</c:if></span></td> --%>
														<td class="regDate">
															<span class="td__date">
																<c:out value="${list.rdcnt}"/>
															</span>
														</td>
														<td class="mo-hide"><span class="td__date"><c:out value="${fn:substring(list.frstRegisterId,0,fn:length(list.frstRegisterId)-3)}"/>***</span></td>
														
														<td class="regDate"><span class="td__date"><fmt:formatDate pattern="yyyy-MM-dd" value="${list.frstRegistPnttm}"/></span></td>
													</tr>
													<tr class="notr"><td class="none" colspan="3"></td></tr>
											</c:forEach>
										</c:when>
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
					<c:if test="${sessionScope.authVO.bbs008001.infoRegistAt eq 'Y'}">
					<div class="button-group">
						<a href="<c:url value='/cmmnty/qnaBbsRegist.do?menuType=${menuType}'/>" class="btn btn-default">등록</a>
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
</html>
