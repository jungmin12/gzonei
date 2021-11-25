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
                <h2 class="page__title">배너관리​</h2>
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
            <!-- content 영역입니다. -->
			<form name="bbsNttSearchForm" method="get" action="/">
				 <fieldset>
					 <legend>게시물 검색</legend>
					 <div class="search">
                        <div class="search-text full-width">
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
			<!-- List : S -->
				<div class="table-list">
					<table>
						<colgroup>
							<col style="width:15%">
							<col style="width:auto">
							<col style="width:20%">
							<col style="width:20%">
						</colgroup>
						<thead>
						</thead>
						<tbody>
							<tr>
								<td class="writer">0380472705</td>
								<td class="subject"><a href="#view">남양주 왕숙1 공공주택지구</a></td>
								<td class="writer">경기 광명시</td>
								<td class="regDate"><button type="button" class="btn btn-default btn-sm  btn-writs">등록</button></td>
							</tr>
							<tr class="notr"><td class="none" colspan="4"></td></tr>
							<tr>
								<td class="writer">0380472705</td>
								<td class="subject"><a href="#view">남양주 왕숙1 공공주택지구</a></td>
								<td class="writer">경기 광명시</td>
								<td class="regDate"><button type="button" class="btn btn-default btn-sm  btn-writs">등록</button></td>
							</tr>
							<tr class="notr"><td class="none" colspan="4"></td></tr>
							<tr>
								<td class="writer">0380472705</td>
								<td class="subject"><a href="#view">남양주 왕숙1 공공주택지구</a></td>
								<td class="writer">경기 광명시</td>
								<td class="regDate"><button type="button" class="btn btn-default btn-sm  btn-writs">등록</button></td>
							</tr>
							<tr class="notr"><td class="none" colspan="4"></td></tr>
							<tr>
								<td class="writer">0380472705</td>
								<td class="subject"><a href="#view">남양주 왕숙1 공공주택지구</a></td>
								<td class="writer">경기 광명시</td>
								<td class="regDate"><button type="button" class="btn btn-default btn-sm  btn-writs">등록</button></td>
							</tr>
							<tr class="notr"><td class="none" colspan="4"></td></tr>
							<tr>
								<td class="writer">0380472705</td>
								<td class="subject"><a href="#view">남양주 왕숙1 공공주택지구</a></td>
								<td class="writer">경기 광명시</td>
								<td class="regDate"><button type="button" class="btn btn-default btn-sm  btn-writs">등록</button></td>
							</tr>
							<tr class="notr"><td class="none" colspan="4"></td></tr>
							<tr>
								<td class="writer">0380472705</td>
								<td class="subject"><a href="#view">남양주 왕숙1 공공주택지구</a></td>
								<td class="writer">경기 광명시</td>
								<td class="regDate"><button type="button" class="btn btn-default btn-sm  btn-writs">등록</button></td>
							</tr>
							<tr class="notr"><td class="none" colspan="4"></td></tr>
							<tr>
								<td class="writer">0380472705</td>
								<td class="subject"><a href="#view">남양주 왕숙1 공공주택지구</a></td>
								<td class="writer">경기 광명시</td>
								<td class="regDate"><button type="button" class="btn btn-default btn-sm btn-writs">등록</button></td>
							</tr>
							<tr class="notr"><td class="none" colspan="4"></td></tr>
							<tr>
								<td class="writer">0380472705</td>
								<td class="subject"><a href="#view">남양주 왕숙1 공공주택지구</a></td>
								<td class="writer">경기 광명시</td>
								<td class="regDate"><button type="button" class="btn btn-default btn-sm  btn-writs">등록</button></td>
							</tr>
							<tr class="notr"><td class="none" colspan="4"></td></tr>
							<tr>
								<td class="writer">0380472705</td>
								<td class="subject"><a href="#view">남양주 왕숙1 공공주택지구</a></td>
								<td class="writer">경기 광명시</td>
								<td class="regDate"><button type="button" class="btn btn-default btn-sm btn-writs">등록</button></td>
							</tr>
							<tr class="notr"><td class="none" colspan="4"></td></tr>
							<tr>
								<td class="writer">0380472705</td>
								<td class="subject"><a href="#view">남양주 왕숙1 공공주택지구</a></td>
								<td class="writer">경기 광명시</td>
								<td class="regDate"><button type="button" class="btn btn-default btn-sm btn-writs">등록</button></td>
							</tr>
							<tr class="notr"><td class="none" colspan="4"></td></tr>
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
            
            <div id="txt">
            <!-- content 영역입니다. -->
            <div class="board__banner">
				<div class="item">
					<div class="form-horizontal bucket-form">
				        <div class="form-group">
				            <div class="col-sm-2 control-label"><label for="">개발사업번호</label></div>
				            <div class="col-sm-4">
				                <input type="text" value="" id="" name="" title="회원명 입력" class="form-control">
				            </div>
				            <div class="col-sm-2 control-label"><label for="">지역명</label></div>
				            <div class="col-sm-4">
				                <input type="text" value="" id="" name="" title="아이디" class="form-control">
				            </div>
				        </div>
				        <div class="form-group">
				            <div class="col-sm-2 control-label"><label for="">사업명</label></div>
				            <div class="col-sm-10">
				                <input type="text" value="" id="" name="" title="회원명 입력" class="form-control">
				            </div>
				        </div>
				        <div class="form-group">
				            <div class="col-sm-2 control-label"><label for="">파일등록</label></div>
				            <div class="col-sm-4">
				                <div class="form-upload">
						              <div class="file-form-group"> 
						               <div class="form-group__upload">
						                   <input type="file" id="" name="file_2" class="form-upload__file--hidden" multiple="">
						                   <span id="atchFileId_name2" class="form-control"></span>
						               </div>
						               <div class="form-input__addon">
						                   <label for="atchFileId_2" class="btn btn btn-primary" data-button="upload" data-parent=".form-upload" data-original="#atchFileId_2" data-showfilename="atchFileId_name2"><span class="skip">1번째 </span>파일선택</label>
						               </div>
						          </div>
				                </div>
				            </div>
				             <div class="col-sm-2 control-label"><label for="">파일명</label></div>
				            <div class="col-sm-4">
					            <input type="text" value="" id="" name="" title="파일명 입력" class="form-control">
				            </div>
				        </div>
				    </div>
				</div>
				<div class="board_btm" style="">
                    <div class="btns_area fl_r mo_block">
                        <a href="#" class="btn btn-default">등록</a>
                    </div>
                </div>
				
			</div>
			
            <!-- content 영역입니다. -->	
            </div>
            
            <div id="txt">
            <!-- content 영역입니다. -->
			<form name="bbsNttSearchForm" method="get" action="/">
				 <fieldset>
					 <legend>게시물 검색</legend>
					 <div class="search">
                        <div class="search-text full-width">
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
			<!-- List : S -->
				<div class="table-list">
					<table>
						<colgroup>
							<col style="width:15%">
							<col style="width:12%">
							<col style="width:auto">
							<col style="width:20%">
							<col style="width:15%">
						</colgroup>
						</thead>
						<tbody>
							<tr>
								<td class="writer">2013-9072</td>
								<td class="writer">전</td>
								<td class="writer">경기 광명시</td>
								<td class="writer">2264500000</td>
								<td class="regDate"><button type="button" class="btn btn-default btn-sm btn-writs">등록</button></td>
							</tr>
							<tr class="notr"><td class="none" colspan="5"></td></tr>
							<tr>
								<td class="writer">2013-9072</td>
								<td class="writer">근린상가</td>
								<td class="writer">경기 광명시</td>
								<td class="writer">2264500000</td>
								<td class="regDate"><button type="button" class="btn btn-default btn-sm btn-writs">등록</button></td>
							</tr>
							<tr class="notr"><td class="none" colspan="5"></td></tr>
							<tr>
								<td class="writer">2013-9072</td>
								<td class="writer">답</td>
								<td class="writer">경기 광명시</td>
								<td class="writer">2264500000</td>
								<td class="regDate"><button type="button" class="btn btn-default btn-sm btn-writs">등록</button></td>
							</tr>
							<tr class="notr"><td class="none" colspan="5"></td></tr>
							<tr>
								<td class="writer">2013-9072</td>
								<td class="writer">전</td>
								<td class="writer">경기 광명시</td>
								<td class="writer">2264500000</td>
								<td class="regDate"><button type="button" class="btn btn-default btn-sm btn-writs">등록</button></td>
							</tr>
							<tr class="notr"><td class="none" colspan="5"></td></tr>
							<tr>
								<td class="writer">2013-9072</td>
								<td class="writer">전</td>
								<td class="writer">경기 광명시</td>
								<td class="writer">2264500000</td>
								<td class="regDate"><button type="button" class="btn btn-default btn-sm btn-writs">등록</button></td>
							</tr>
							<tr class="notr"><td class="none" colspan="5"></td></tr>
							<tr>
								<td class="writer">2013-9072</td>
								<td class="writer">전</td>
								<td class="writer">경기 광명시</td>
								<td class="writer">2264500000</td>
								<td class="regDate"><button type="button" class="btn btn-default btn-sm btn-writs">등록</button></td>
							</tr>
							<tr class="notr"><td class="none" colspan="5"></td></tr>
							<tr>
								<td class="writer">2013-9072</td>
								<td class="writer">전</td>
								<td class="writer">경기 광명시</td>
								<td class="writer">2264500000</td>
								<td class="regDate"><button type="button" class="btn btn-default btn-sm btn-writs">등록</button></td>
							</tr>
							<tr class="notr"><td class="none" colspan="5"></td></tr>
							<tr>
								<td class="writer">2013-9072</td>
								<td class="writer">전</td>
								<td class="writer">경기 광명시</td>
								<td class="writer">2264500000</td>
								<td class="regDate"><button type="button" class="btn btn-default btn-sm btn-writs">등록</button></td>
							</tr>
							<tr class="notr"><td class="none" colspan="5"></td></tr>
							<tr>
								<td class="writer">2013-9072</td>
								<td class="writer">전</td>
								<td class="writer">경기 광명시</td>
								<td class="writer">2264500000</td>
								<td class="regDate"><button type="button" class="btn btn-default btn-sm btn-writs">등록</button></td>
							</tr>
							<tr class="notr"><td class="none" colspan="5"></td></tr>
							<tr>
								<td class="writer">2013-9072</td>
								<td class="writer">전</td>
								<td class="writer">경기 광명시</td>
								<td class="writer">2264500000</td>
								<td class="regDate"><button type="button" class="btn btn-default btn-sm btn-writs">등록</button></td>
							</tr>
							<tr class="notr"><td class="none" colspan="5"></td></tr>
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
            
            
            <div id="txt">
            <!-- content 영역입니다. -->
            <div class="board__banner">
				<div class="item">
					<div class="form-horizontal bucket-form">
				        <div class="form-group">
				            <div class="col-sm-2 control-label"><label for="">사건/물건번호</label></div>
				            <div class="col-sm-4">
				                <input type="text" value="" id="" name="" title="사건/물건번호 입력" class="form-control">
				            </div>
				            <div class="col-sm-2 control-label"><label for="">사업번호</label></div>
				            <div class="col-sm-4">
				                <input type="text" value="" id="" name="" title="사업번호" class="form-control">
				            </div>
				        </div>
				        <div class="form-group">
				            <div class="col-sm-2 control-label"><label for="">지역</label></div>
				            <div class="col-sm-4">
				                <input type="text" value="" id="" name="" title="지역" class="form-control">
				            </div>
				            <div class="col-sm-2 control-label"><label for="">용도</label></div>
				            <div class="col-sm-4">
				                <input type="text" value="" id="" name="" title="용도 입력" class="form-control">
				            </div>
				        </div>
				        <div class="form-group">
				            <div class="col-sm-2 control-label"><label for="">감정가</label></div>
				            <div class="col-sm-4">
				                <input type="text" value="" id="" name="" title="감정가" class="form-control">
				            </div>
				            <div class="col-sm-2 control-label"><label for="">최저가</label></div>
				            <div class="col-sm-4">
				                <input type="text" value="" id="" name="" title="최저가" class="form-control">
				            </div>
				        </div>
				        
				    </div>
				</div>
				<div class="board_btm" style="">
                    <div class="btns_area fl_r mo_block">
                        <a href="#" class="btn btn-default">등록</a>
                    </div>
                </div>
			</div>
			
			
            <div class="board__popup">
	            <h2 class="h2">POPUP</h2>
				<!-- 팝업01 -->
				<div class="item">
					<div class="form-horizontal bucket-form">
				        <div class="form-group">
				            <div class="col-sm-2 control-label"><label for="">만료일자</label></div>
				            <div class="col-sm-3">
				                <div class="search--calendar">
									<span>
										<input type="text" class="form-control" name="endDate" id="endDate" placeholder="만료일자" value="" title="만료일자 입력">
                                    <button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
									</span>
								</div>
				            </div>
				            <div class="col-sm-2 control-label"><label for="">사업번호</label></div>
				            <div class="col-sm-4">
				                <div class="form-upload">
						              <div class="file-form-group"> 
						               <div class="form-group__upload">
						                   <input type="file" id="" name="file_2" class="form-upload__file--hidden" multiple="">
						                   <span id="atchFileId_name2" class="form-control"></span>
						               </div>
						               <div class="form-input__addon">
						                   <label for="atchFileId_2" class="btn btn btn-primary" data-button="upload" data-parent=".form-upload" data-original="#atchFileId_2" data-showfilename="atchFileId_name2"><span class="skip">1번째 </span>파일선택</label>
						               </div>
						          </div>
				                </div>
				            </div>
				             <div class="col-sm-1"><button type="button" class="btn btn-writs">등록</button></div>
				        </div>
				        
				    </div>
				</div>
				<!-- 팝업01 -->
				<!-- 팝업02 -->
				<div class="item">
					<div class="form-horizontal bucket-form">
				        <div class="form-group">
				            <div class="col-sm-2 control-label"><label for="">만료일자</label></div>
				            <div class="col-sm-3">
				                <div class="search--calendar">
									<span>
										<input type="text" class="form-control" name="endDate" id="endDate" placeholder="만료일자" value="" title="만료일자 입력">
                                    <button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
									</span>
								</div>
				            </div>
				            <div class="col-sm-2 control-label"><label for="">사업번호</label></div>
				            <div class="col-sm-4">
				                <div class="form-upload">
						              <div class="file-form-group"> 
						               <div class="form-group__upload">
						                   <input type="file" id="" name="file_2" class="form-upload__file--hidden" multiple="">
						                   <span id="atchFileId_name2" class="form-control"></span>
						               </div>
						               <div class="form-input__addon">
						                   <label for="atchFileId_2" class="btn btn btn-primary" data-button="upload" data-parent=".form-upload" data-original="#atchFileId_2" data-showfilename="atchFileId_name2"><span class="skip">1번째 </span>파일선택</label>
						               </div>
						          </div>
				                </div>
				            </div>
				             <div class="col-sm-1"><button type="button" class="btn btn-writs">등록</button></div>
				        </div>
				        
				    </div>
				</div>
				<!-- 팝업02 -->
			</div>
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
