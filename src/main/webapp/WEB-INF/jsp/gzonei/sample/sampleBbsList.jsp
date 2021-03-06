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

<!-- 구현부 : S -->

<div id="body_layout">	

    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
            <div id="location" class="title_wrap">
                <h2 class="page__title">Today's 보상계획공고</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="/site/kr/">HOME</a></li>
                        <li class="n2"><a href="/kr/html/sub01/010101.html">지존스토어</a></li>
                        <li class="n3"><a href="/kr/html/sub01/010101.html" class="navi_ov">보상판례</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                    <!-- 프린트 시작 -->
                    <ul class="print_wrap setting-box__group">
                        <li id="sns_layout" class="n2">
                            <button data-target="ui-open">SNS공유</button>
                            <div class="sns_wrap" data-id="ui-open">
                                <button data-button="sns_share" data-service="naver" data-title="네이버 SNS공유" title="새창열림" target="_blank"><span class="sr-only">네이버 SNS</span>공유하기</button>
                                <button data-button="sns_share" data-service="facebook" data-title="페이스북 SNS공유" title="새창열림" target="_blank"><span class="sr-only">페이스북 SNS </span>공유하기</button>
                                <button data-target="ui-close">닫기</button>
                            </div>
                        </li>                    
                        <li class="n1" id="print"><button data-print="print">프린트</button></li>
                    </ul>
                    <!-- 프린트 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">
	            
			<div class="nav-4th">
				<ul>
					<li class="active"><a href="#">4차탭메뉴ov</a></li>
					<li><a href="#">4차탭메뉴</a></li>
					<li><a href="#">4차탭메뉴</a></li>
					<li><a href="#">4차탭메뉴</a></li>
				</ul>
			</div>
            <!-- content 영역입니다. -->
			<form name="bbsNttSearchForm" method="get" action="/">
				 <fieldset>
					 <legend>게시물 검색</legend>
					 <div class="search">
                        <div class="search-date">
                            <div class="inner">
	                            
	                            <div class="search--calendar">
									<span>
										<input type="text" class="form-control" name="startDate" id="startDate" placeholder="시작일" value="" title="시작일 입력">
										<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
									</span>
								</div>
								<span class="sym">~</span>
								<div class="search--calendar">
									<span>
										<input type="text" class="form-control" name="endDate" id="endDate" placeholder="종료일" value="" title="종료일 입력">
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
										 <select name="" title="검색 영역 선택">
										 	<option value="">제목</option>
											<option value="">작성자</option>
											<option value="">내용</option>
										 </select>
									 </span>
									 <!-- select추가시 -->
								 </div>
                                <div class="search--text">
									 <span><input type="text" name="searchKrwd" value="" title="검색어를 입력해주세요" placeholder="검색어를 입력해주세요" class="form-control"></span>
								</div>
								<div class="search--btn">
									 <span class="btn--submit"><input type="submit" value="검색"></span>
								 </div>
                            </div>
                        </div>			
                    </div>
				 </fieldset>
			 </form>
			
			<div class="program--search--index">
				<div class="program--control">
					<div class="sort">
						<div class="form">
							<select class="design-select gray-select small-select" id="orderType" onchange="goSearct_order()" title="검색조건">
								<option value="">최근 등록일순</option>
								<option value="">조회수</option>
								<option value="">추천수</option>
							</select>
						</div>	
		            </div>
				</div>
			</div>	
			<!-- List : S -->
				<div class="table-list">
					<table>
						<colgroup>
							<col style="width:15%">
							<col style="width:auto">
							<col style="width:15%">
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>등록일</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="atchFileId"><span class="td__num">10303</span></td>
								<td class="subject"><a href="#view">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<span class="ir bbs-new">새글</span></a></td>
								<!--<td class="writer">작성자</td>
								<td class="hit">161</td>-->
								<td class="regDate"> <span class="td__date">2021-03-15</span></td>
							</tr>
							<tr class="notr"><td class="none" colspan="3"></td></tr>
							<tr>
								<td class="atchFileId"><span class="td__num">10303</span></td>
								<td class="subject"><a href="#view">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<span class="ir bbs-new">새글</span></a> </td>
								<!--<td class="writer">작성자</td>
								<td class="hit">161</td>-->
								<td class="regDate"> <span class="td__date">2021-03-15</span></td>
							</tr>
							<tr class="notr"><td class="none" colspan="3"></td></tr>
							<tr>
								<td class="atchFileId"><span class="td__num">10303</span></td>
								<td class="subject"><a href="#view">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<span class="ir bbs-new">새글</span></a> </td>
								<!--<td class="writer">작성자</td>
								<td class="hit">161</td>-->
								<td class="regDate"> <span class="td__date">2021-03-15</span></td>
							</tr>
							<tr class="notr"><td class="none" colspan="3"></td></tr>
							<tr>
								<td class="atchFileId"><span class="td__num">10303</span></td>
								<td class="subject"><a href="#view">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<span class="ir bbs-new">새글</span></a> </td>
								<!--<td class="writer">작성자</td>
								<td class="hit">161</td>-->
								<td class="regDate"> <span class="td__date">2021-03-15</span></td>
							</tr>
							<tr class="notr"><td class="none" colspan="3"></td></tr>
							<tr>
								<td class="atchFileId"><span class="td__num">10303</span></td>
								<td class="subject"><a href="#view">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<span class="ir bbs-new">새글</span></a> </td>
								<!--<td class="writer">작성자</td>
								<td class="hit">161</td>-->
								<td class="regDate"> <span class="td__date">2021-03-15</span></td>
							</tr>
							<tr class="notr"><td class="none" colspan="3"></td></tr>
							<tr>
								<td class="atchFileId"><span class="td__num">10303</span></td>
								<td class="subject"><a href="#view">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<span class="ir bbs-new">새글</span></a> </td>
								<!--<td class="writer">작성자</td>
								<td class="hit">161</td>-->
								<td class="regDate"> <span class="td__date">2021-03-15</span></td>
							</tr>
							<tr class="notr"><td class="none" colspan="3"></td></tr>
							<tr>
								<td class="atchFileId"><span class="td__num">10303</span></td>
								<td class="subject"><a href="#view">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<span class="ir bbs-new">새글</span></a> </td>
								<!--<td class="writer">작성자</td>
								<td class="hit">161</td>-->
								<td class="regDate"> <span class="td__date">2021-03-15</span></td>
							</tr>
							<tr class="notr"><td class="none" colspan="3"></td></tr>
							<tr>
								<td class="atchFileId"><span class="td__num">10303</span></td>
								<td class="subject"><a href="#view">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<span class="ir bbs-new">새글</span></a> </td>
								<!--<td class="writer">작성자</td>
								<td class="hit">161</td>-->
								<td class="regDate"> <span class="td__date">2021-03-15</span></td>
							</tr>
							<tr class="notr"><td class="none" colspan="3"></td></tr>
							<tr>
								<td class="atchFileId"><span class="td__num">10303</span></td>
								<td class="subject"><a href="#view">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<span class="ir bbs-new">새글</span></a> </td>
								<!--<td class="writer">작성자</td>
								<td class="hit">161</td>-->
								<td class="regDate"> <span class="td__date">2021-03-15</span></td>
							</tr>
							<tr class="notr"><td class="none" colspan="3"></td></tr>
							<tr>
								<td class="atchFileId"><span class="td__num">10303</span></td>
								<td class="subject"><a href="#view">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<span class="ir bbs-new">새글</span></a> </td>
								<!--<td class="writer">작성자</td>
								<td class="hit">161</td>-->
								<td class="regDate"> <span class="td__date">2021-03-15</span></td>
							</tr>
							<tr class="notr"><td class="none" colspan="3"></td></tr>
							<tr>
								<td class="atchFileId"><span class="td__num">10303</span></td>
								<td class="subject"><a href="#view">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<span class="ir bbs-new">새글</span></a> </td>
								<!--<td class="writer">작성자</td>
								<td class="hit">161</td>-->
								<td class="regDate"> <span class="td__date">2021-03-15</span></td>
							</tr>
							<tr class="notr"><td class="none" colspan="3"></td></tr>
							<tr>
								<td class="atchFileId"><span class="td__num">10303</span></td>
								<td class="subject"><a href="#view">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<span class="ir bbs-new">새글</span></a> </td>
								<!--<td class="writer">작성자</td>
								<td class="hit">161</td>-->
								<td class="regDate"> <span class="td__date">2021-03-15</span></td>
							</tr>
							<tr class="notr"><td class="none" colspan="3"></td></tr>
						</tbody>
					</table>
					
				</div>
				<!-- List : E -->
				<!-- Paging : S -->
				<div class="pagination-inner">
					<ul class="pagination">
						<li class="page-item">
							<a class="page-link" aria-label="first" href="#">
								<span aria-hidden="true"><<</span>
								<span class="sr-only">첫번째페이지</span>
							</a>
						</li>
						<li class="page-item">
							<a class="page-link" aria-label="Previous" href="#">
								<span aria-hidden="true"><</span>
								<span class="sr-only">이전페이지</span>
							</a>
						</li>
						<li class="page-item active"><a class="page-link" href="#">1</a></li>
						<li class="page-item"><a class="page-link" href="#">2</a></li>
						<li class="page-item"><a class="page-link" href="#">3</a></li>
						<li class="page-item"><a class="page-link" href="#">4</a></li>
						<li class="page-item"><a class="page-link" href="#">5</a></li>
						<li class="page-item"><a class="page-link" href="#">6</a></li>
						<li class="page-item"><a class="page-link" href="#">7</a></li>
						<li class="page-item"><a class="page-link" href="#">8</a></li>
						<li class="page-item"><a class="page-link" href="#">9</a></li>
						<li class="page-item"><a class="page-link" href="#">10</a></li>
						<li class="page-item">
							<a class="page-link" aria-label="Next" href="#">
								<span aria-hidden="true">></span>
								<span class="sr-only">다음페이지</span>
							</a>
						</li>
						<li class="page-item">
							<a class="page-link" aria-label="last" href="#">
								<span aria-hidden="true">>></span>
								<span class="sr-only">마지막페이지</span>
							</a>
						</li>
					</ul>
					<div class="button-group">
						<a href="#" class="btn btn-default">등록</a>
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
