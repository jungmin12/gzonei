<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang='ko'>
<head>
<%@ include file="/WEB-INF/jsp/gzonei/layout/header.jsp"%>
<%@ include file="/WEB-INF/jsp/gzonei/layout/headerMap.jsp"%>
<script src="<c:url value='/css/gzonei/SRC/js/map/app.js' />"></script>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/gzonei/layout/top.jsp"%>

	<!-- 구현부 : S -->
	<div id="body_layout" class="map">
		<!-- layout -->
		<div class="body_wrap layout">
			<div id="contens" class="contents_wrap">
				<!--             <div id="location" class="title_wrap"> -->
				<!--                 <h2 class="page__title">개발정보</h2> -->
				<!--                 유틸 시작 -->
				<!--                 <div class="utile_wrap"> -->
				<!--                     로케이션 시작 -->
				<!--                     <ul class="location_wrap"> -->
				<!--                         <li class="n1 navi_home"><a href="/site/kr/">HOME</a></li> -->
				<!--                         <li class="n2"><a href="/kr/html/sub01/010101.html">지존스토어</a></li> -->
				<!--                         <li class="n3"><a href="/kr/html/sub01/010101.html" class="navi_ov">보상판례</a></li> -->
				<!--                     </ul>                            -->
				<!--                     로케이션 끝 -->
				<!--                     프린트 시작 -->
				<!--                     <ul class="print_wrap setting-box__group"> -->
				<!--                         <li id="sns_layout" class="n2"> -->
				<!--                             <button data-target="ui-open">SNS공유</button> -->
				<!--                             <div class="sns_wrap" data-id="ui-open"> -->
				<!--                                 <a class="fa" href="#" onclick="facebookOpen('목록 > 신청 > 교육신청 > 교육프로그램 > 천안시직장맘지원센터','http://ca_momsworld.hdmotion.co.kr/kr/html/sub01/010101.html'); return false;" title="페이스북 공유하기, 새창열림">페이스북</a> -->
				<!--                                 <a class="bl" href="#" onclick="naverOpen('목록 > 신청 > 교육신청 > 교육프로그램 > 천안시직장맘지원센터','http://ca_momsworld.hdmotion.co.kr/kr/html/sub01/010101.html'); return false;" title="블로그 공유하기, 새창열림">블로그</a> -->
				<!--                                 <button data-target="ui-close">닫기</button> -->
				<!--                             </div> -->
				<!--                         </li>                     -->
				<!--                         <li class="n1" id="print"><button data-print="print">프린트</button></li> -->
				<!--                     </ul> -->
				<!--                     프린트 끝 -->
				<!--                 </div> -->
				<!--                 유틸 끝    -->
				<!--             </div>   -->

				<div id="txt">
					<!-- content 영역입니다. -->
					<div id="app">

						<div id="totalWrap">


							<div id="map"></div>
							<div id="mapTabs">
								<button type="button" class="on mapir naver" data-map="naver">
									<span>네이버맵</span>
								</button>
								<button type="button" class="mapir kakao" data-map="kakao">
									<span>카카오맵</span>
								</button>
								<button type="button" class="mapir google" data-map="google">
									<span>구글맵</span>
								</button>
							</div>
							<div id="iconSort">
								<button type="button" class="on all" data-sort="all">
									<span>전체</span>
								</button>
								<button type="button" class="sort1" data-sort="1">
									<span>보상전례</span>
								</button>
								<button type="button" class="sort2" data-sort="2">
									<span>투자정보</span>
								</button>
								<button type="button" class="sort3" data-sort="3">
									<span>개발정보</span>
								</button>
							</div>
							<div id="quickGuide">
								<button type="button" class="mapir icon1 on">01</button>
								<button type="button" class="mapir icon2">02</button>
								<button type="button" class="mapir icon3">03</button>
								<button type="button" class="mapir icon4">04</button>
								<button type="button" class="mapir icon5">05</button>
								<button type="button" class="mapir icon6">06</button>
								<button type="button" class="mapir icon7">07</button>
								<button type="button" class="mapir icon8">08</button>
								<button type="button" class="mapir icon9">09</button>
								<button type="button" class="mapir icon10">10</button>
								<button type="button" class="mapir icon11">11</button>
								<button type="button" class="mapir icon12">12</button>
								<button type="button" class="mapir icon13">13</button>
								<button type="button" class="mapir icon14">14</button>
								<div class="dropbox">
									<button type="button" class="text-button">등록</button>
									<button type="button" class="text-button">선택</button>
									<button type="button" class="text-button">수정</button>
									<button type="button" class="text-button">삭제</button>
									<button type="button" class="text-button">저장</button>
								</div>
							</div>
							<div id="side">
								<div id="searchForm">
									<strong class="mapir title">검색</strong>
									<form>
										<fieldset>
											<legend class="skip">검색</legend>
											<label for="searchKeyword" class="skip">검색어 입력</label> <input
												type="text" v-model="searchKeyword" id="searchKeyword"
												name="searchKeyword" paceholder="검색어를 입력하세요">
											<button id="searchSubmit" class="mapir">검색하기</button>
											<button id="naverLocationApi" class="mapLocationApi mapir">현
												지도 내 장소검색</button>
											<button id="kakaoLocationApi" class="mapLocationApi mapir">현
												지도 내 장소검색</button>
											<button id="googleLocationApi" class="mapLocationApi mapir">현
												지도 내 장소검색</button>
										</fieldset>
									</form>
									<div id="keyword">
										<em>추천검색어</em>
										<div class="grap">
											<a href="javascript:openModal(1);">개발정보 모달</a> <a
												href="javascript:openModal(2);">투자정보 모달</a> <a href="#">신안산선</a>
										</div>
									</div>
								</div>
								<!-- tab -->
								<div id="searchFormTab" class="ui-tablist">
									<ul class="tab-ul" role="tablist">
										<li role="presentation" class="link-tab"><a role="tab"
											id="tab1" aria-controls="tab-panel1" href="#tab-panel1"
											tabindex="0" aria-selected="true" title="열림">개발정보</a></li>
										<li role="presentation" class="link-tab on"><a role="tab"
											id="tab2" aria-controls="tab-panel2" href="#tab-panel2">투자정보</a></li>
									</ul>
									<div class="tabpanel_box">
										<div class="obj" id="tab-panel1" role="tabpanel"
											aria-labelledby="tab1">
											<strong class="skip">개발정보 검색</strong>
											<div class="scrollbar">
												<div class="mapSearch__area">
													<div class="form-group">
														<div class="control-label">
															<label for="">지역</label>
														</div>
														<div class="col-sm-4">
															<select id="gubun_a" name="gubun_a" class="form-control"
																title="시도 선택" required="">
																<option value="">시도</option>
																<option value="A">시도</option>
															</select>
														</div>
														<div class="col-sm-4">
															<select id="gubun_b" name="gubun_b" class="form-control"
																title="시군구 선택">
																<option value="">시군구</option>
																<option value="A">시군구</option>
															</select>
														</div>
														<div class="col-sm-4">
															<select id="gubun_c" name="gubun_c" class="form-control"
																title="읍면동 선택">
																<option value="">읍면동</option>
																<option value="A">읍면동</option>
															</select>
														</div>
													</div>

													<!-- 상세검색 -->
													<div class="mapSearch__biz" style="display: none;">
														<div class="form-group">
															<div class="control-label">
																<label for="">협의보상시점</label>
															</div>
															<div class="col-sm-6">
																<span>보상시작년도</span> <select id="gubun_a" name="gubun_a"
																	class="form-control" title="보상시작년도 선택" required="">
																	<option value="">보상시작년도</option>
																	<option value="A">보상시작년도</option>
																</select>
															</div>
															<div class="col-sm-6">
																<span>기간</span> <select id="gubun_b" name="gubun_b"
																	class="form-control" title="기간 선택">
																	<option value="">기간</option>
																	<option value="A">기간</option>
																</select>
															</div>
														</div>
														<div class="form-group">
															<div class="control-label">
																<label for="">협의보상상태</label>
															</div>
															<div class="col-sm-6">
																<select name="gubun_a" class="form-control"
																	title="협의보상상태 선택" required="">
																	<option value="">협의보상상태</option>
																	<option value="A">협의보상상태</option>
																</select>
															</div>
														</div>
														<div class="form-group">
															<div class="control-label">
																<label for="">사업지구</label>
															</div>
															<div class="col-sm-12">
																<select name="gubun_a" class="form-control"
																	title="사업지구 선택" required="">
																	<option value="">사업지구</option>
																	<option value="A">사업지구</option>
																</select>
															</div>
														</div>
														<div class="form-group">
															<div class="control-label">
																<label for="">개발사업명</label>
															</div>
															<div class="col-sm-12">
																<input type="text" id="" name="" title="개발사업명 입력"
																	class="form-control" value="">
															</div>
														</div>
														<div class="form-group">
															<div class="control-label">
																<label for="">시행사</label>
															</div>
															<div class="col-sm-6">
																<select id="gubun_a" name="gubun_a" class="form-control"
																	title="시행사 선택" required="">
																	<option value="">시행사</option>
																	<option value="A">시행사</option>
																</select>
															</div>
															<div class="col-sm-6">
																<select id="gubun_b" name="gubun_b" class="form-control"
																	title="시행사 선택">
																	<option value="">시행사</option>
																	<option value="A">시행사</option>
																</select>
															</div>
														</div>
													</div>
													<!-- 상세검색 -->

													<div class="search--btn">
														<span class="btn--submit"><button type="button"
																data-id="area" class="submit">검색</button></span> <span
															class="btn--more" id="more1"><button type="button">상세검색</button></span>
													</div>
												</div>

											</div>
										</div>
										<div class="obj on" id="tab-panel2" role="tabpanel"
											aria-labelledby="tab2">
											<strong class="skip">투자정보 검색</strong>
											<div class="scrollbar">
												<div class="mapSearch__area">
													<div class="form-group">
														<div class="control-label">
															<label for="">지역</label>
														</div>
														<div class="col-sm-4">
															<select id="gubun_a" name="gubun_a" class="form-control"
																title="시도 선택" required="">
																<option value="">시도</option>
																<option value="A">시도</option>
															</select>
														</div>
														<div class="col-sm-4">
															<select id="gubun_b" name="gubun_b" class="form-control"
																title="시군구 선택">
																<option value="">시군구</option>
																<option value="A">시군구</option>
															</select>
														</div>
														<div class="col-sm-4">
															<select id="gubun_c" name="gubun_c" class="form-control"
																title="읍면동 선택">
																<option value="">읍면동</option>
																<option value="A">읍면동</option>
															</select>
														</div>
													</div>

													<!-- 상세검색 -->
													<div class="mapSearch__biz" style="display: none;">

														<div class="form-group">
															<div class="control-label">
																<label for="">개발사업지구</label>
															</div>
															<div class="col-sm-3">
																<select id="gubun_a" name="gubun_a" class="form-control"
																	title="보상시작년도 선택" required="">
																	<option value="">보상시작년도</option>
																	<option value="A">보상시작년도</option>
																</select>
															</div>
															<div class="col-sm-3">
																<select id="gubun_b" name="gubun_b" class="form-control"
																	title="기간 선택">
																	<option value="">기간</option>
																	<option value="A">기간</option>
																</select>
															</div>
															<div class="col-sm-3">
																<select id="gubun_b" name="gubun_b" class="form-control"
																	title="기간 선택">
																	<option value="">기간</option>
																	<option value="A">기간</option>
																</select>
															</div>
															<div class="col-sm-3">
																<select id="gubun_b" name="gubun_b" class="form-control"
																	title="기간 선택">
																	<option value="">기간</option>
																	<option value="A">기간</option>
																</select>
															</div>
														</div>

														<div class="form-group">
															<div class="control-label">
																<label for="">입찰일</label>
															</div>
															<div class="col-sm-6">
																<div class="search--calendar">
																	<span> <input type="text" class="form-control"
																		name="startDate" id="startDate" placeholder="시작일"
																		value="" title="시작일 입력">
																		<button type="button" class="btn__calendar">
																			<span class="skip">달력선택</span>
																		</button>
																	</span>
																</div>
															</div>
															<div class="col-sm-6">
																<div class="search--calendar">
																	<span> <input type="text" class="form-control"
																		name="endDate" id="endDate" placeholder="종료일" value=""
																		title="종료일 입력">
																		<button type="button" class="btn__calendar">
																			<span class="skip">달력선택</span>
																		</button>
																	</span>
																</div>
															</div>
														</div>
														<div class="form-group">
															<div class="control-label">
																<label for="">구분</label>
															</div>
															<div class="col-sm-3">
																<span>카테고리</span> <select id="gubun_a" name="gubun_a"
																	class="form-control" title="시행사 선택" required="">
																	<option value="">경매</option>
																	<option value="A">공매</option>
																</select>
															</div>
															<div class="col-sm-4">
																<span>경매사건번호</span> <select id="gubun_a" name="gubun_a"
																	class="form-control" title="시행사 선택" required="">
																	<option value="">시행사</option>
																	<option value="A">시행사</option>
																</select>
															</div>
															<div class="col-sm-5">
																<span>타경</span> <input type="text" id="" name=""
																	title="개발사업명 입력" class="form-control" value="">
															</div>
														</div>
														<div class="form-group">
															<div class="control-label">
																<label for="">보상상태</label>
															</div>
															<div class="col-sm-12">
																<input class="checkbox-input" type="checkbox"
																	id="checkbox1" name="" title="경매" value="a"> <label
																	class="checkbox-inline" for="checkbox1">보상중</label> <input
																	class="checkbox-input" type="checkbox" id="checkbox2"
																	name="" title="공매" value="a"> <label
																	class="checkbox-inline" for="checkbox2">보상예정</label>
															</div>
														</div>
														<div class="form-group">
															<div class="control-label">
																<label for="">사업방식</label>
															</div>
															<div class="col-sm-12">
																<input class="checkbox-input" type="checkbox"
																	id="checkbox3" name="" title="경매" value="a"> <label
																	class="checkbox-inline" for="checkbox3">수용 및 사용</label>
																<input class="checkbox-input" type="checkbox"
																	id="checkbox4" name="" title="공매" value="a"> <label
																	class="checkbox-inline" for="checkbox4">환지</label> <input
																	class="checkbox-input" type="checkbox" id="checkbox5"
																	name="" title="경매" value="a"> <label
																	class="checkbox-inline" for="checkbox5">수용 및 사용
																	+ 환지</label> <input class="checkbox-input" type="checkbox"
																	id="checkbox6" name="" title="공매" value="a"> <label
																	class="checkbox-inline" for="checkbox6">기타</label>

															</div>
														</div>
													</div>
													<!-- 상세검색 -->
													<div class="search--btn">
														<span class="btn--submit"><button type="button"
																data-id="area" class="submit">검색</button></span> <span
															class="btn--more" id="more1"><button type="button">상세검색</button></span>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- tab -->
						<div id="notice">
							<strong>최근 열람사업</strong>
							<div class="noticeList">
								<ul>
									<li class="notice-text"><a href="#">장기미집행 도시계획시설(노원
											중로1-391호선) </a></li>
									<li class="notice-text"><a href="#">[토지보상 완료]마곡 도시개발사업</a></li>
									<li class="notice-text"><a href="#">남부순환로 - 봉오대로 삼거리간
											도로개설공사</a></li>
									<li class="notice-text"><a href="#">헌인마을 도시개발사업 </a></li>
								</ul>
							</div>
						</div>
						<!-- 검색결과 -->
						<div id="searchResult">
							<div class="searchResult__index">
								<strong><em>경기도</em>관련된 개발정보</strong>
								<div class="form">
									<select class="design-select gray-select small-select"
										id="numberType" onchange="goSearct_number()" title="검색조건">
										<option value="">15건</option>
									</select>
								</div>
								<button type="button" class="close">
									<span aria-hidden="true">닫기</span>
								</button>
							</div>

							<div class="searchResult__obj">
								<div class="item">
									<button class="link on">
										<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong> <span>71,808㎡(21,722평)</span>
										<span>SH공사</span> <i>자세히보기</i>
									</button>
								</div>
								<div class="item">
									<button class="link">
										<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong> <span>71,808㎡(21,722평)</span>
										<span>SH공사</span> <i>자세히보기</i>
									</button>
								</div>
								<div class="item">
									<button class="link">
										<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong> <span>71,808㎡(21,722평)</span>
										<span>SH공사</span> <i>자세히보기</i>
									</button>
								</div>
								<div class="item">
									<button class="link">
										<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong> <span>71,808㎡(21,722평)</span>
										<span>SH공사</span> <i>자세히보기</i>
									</button>
								</div>
								<div class="item">
									<button class="link">
										<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong> <span>71,808㎡(21,722평)</span>
										<span>SH공사</span> <i>자세히보기</i>
									</button>
								</div>
								<div class="item">
									<button class="link">
										<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong> <span>71,808㎡(21,722평)</span>
										<span>SH공사</span> <i>자세히보기</i>
									</button>
								</div>
								<div class="item">
									<button class="link">
										<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong> <span>71,808㎡(21,722평)</span>
										<span>SH공사</span> <i>자세히보기</i>
									</button>
								</div>
								<div class="item">
									<button class="link">
										<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong> <span>71,808㎡(21,722평)</span>
										<span>SH공사</span> <i>자세히보기</i>
									</button>
								</div>
								<div class="item">
									<button class="link">
										<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong> <span>71,808㎡(21,722평)</span>
										<span>SH공사</span> <i>자세히보기</i>
									</button>
								</div>
								<div class="item">
									<button class="link">
										<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong> <span>71,808㎡(21,722평)</span>
										<span>SH공사</span> <i>자세히보기</i>
									</button>
								</div>
								<div class="item">
									<button class="link">
										<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong> <span>71,808㎡(21,722평)</span>
										<span>SH공사</span> <i>자세히보기</i>
									</button>
								</div>
								<div class="item">
									<button class="link">
										<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong> <span>71,808㎡(21,722평)</span>
										<span>SH공사</span> <i>자세히보기</i>
									</button>
								</div>
								<div class="item">
									<button class="link">
										<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong> <span>71,808㎡(21,722평)</span>
										<span>SH공사</span> <i>자세히보기</i>
									</button>
								</div>
								<div class="item">
									<button class="link">
										<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong> <span>71,808㎡(21,722평)</span>
										<span>SH공사</span> <i>자세히보기</i>
									</button>
								</div>
								<div class="item">
									<button class="link">
										<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong> <span>71,808㎡(21,722평)</span>
										<span>SH공사</span> <i>자세히보기</i>
									</button>
								</div>
							</div>
							<!-- Paging : S -->
							<div class="pagination-inner">
								<ul class="pagination">
									<li class="page-item"><a class="page-link"
										aria-label="first" href="#"> <span aria-hidden="true"><<</span>
											<span class="sr-only">첫번째페이지</span>
									</a></li>
									<li class="page-item"><a class="page-link"
										aria-label="Previous" href="#"> <span aria-hidden="true"><</span>
											<span class="sr-only">이전페이지</span>
									</a></li>
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
									<li class="page-item"><a class="page-link"
										aria-label="Next" href="#"> <span aria-hidden="true">></span>
											<span class="sr-only">다음페이지</span>
									</a></li>
									<li class="page-item"><a class="page-link"
										aria-label="last" href="#"> <span aria-hidden="true">>></span>
											<span class="sr-only">마지막페이지</span>
									</a></li>
								</ul>
							</div>
							<!-- Paging : E -->
						</div>
						<!-- 검색결과 -->
					</div>
					<div id="info" style="display: none;">
						<div class="scroll">

							<strong class="title"><em>서울 영등포구</em>신안산선 복선전철 건설사업</strong>
							<div class="photoArea">
								<div class="thumbnail">
									<a href="#"><img src="" alt=""></a>
								</div>
								<div class="photoList">
									<ul>
										<li><strong>위치</strong>여의도~ 광명KTX역~시흥시청~중앙(4호선)</li>
										<li><strong>연장</strong>44.763㎞(44,763m)</li>
										<li><strong>시행</strong>xxxxxxxxxxxxxxx</li>
										<li><strong>적용법률</strong>철도의 건설 및 철도시설의 유지관리에 관한 법률</li>
										<li><strong>사업방식</strong>수용 및 사용</li>
										<li><strong>사업인정시점</strong>실시계획승인 고시일</li>
									</ul>
								</div>
							</div>


							<div class="map__header">
								<span class="map__title">사업주요내용</span>
							</div>
							<div class="map__content">
								<ul>
									<li>- 수도권X자 광역교통망 구축 및 서남부지역 대중교통수단 확충</li>
									<li>- 서남부지역 대중교통 불편의 근본적 해소 및 지역경제 활성화 기여</li>
									<li>- 장현/목감지구 등 택지개발사업에 따른 장래 교통수요 능동 대처</li>
									<li>- 사업비:33,895억원</li>
									<li>- 총연장:44.763km(정거장 15개소, 차량기지 1개소)</li>
								</ul>
							</div>

							<div class="map__header">
								<span class="map__title">추진내역</span>
							</div>
							<div class="map__content">
								<ul>
									<li><strong>2003. 07.00</strong>시안신선 예비타당성 조사(KDI)</li>
									<li><strong>2003. 07.00</strong>시안신선 예비타당성 조사(KDI)<a
										href="#" class="btn btn-default btn-sm btn-file"><i
											class="icon-file"></i>파일보기</a></li>
								</ul>
							</div>

							<div class="map__header">
								<span class="map__title">토지조사 및 보고서 다운로드</span>
							</div>
							<div class="map__content">
								<div class="ui-banner__box">
									<div class="banner__box down">
										<a href="#" class="down"> <strong class="ui-banner__title">환경영향평가
												항목 결정내용(본선2구간)</strong>
										</a>
									</div>
									<div class="banner__box down">
										<a href="#" class="down"> <strong class="ui-banner__title">환경영향평가
												항목 결정내용(본선2구간)</strong>
										</a>
									</div>
									<div class="banner__box down">
										<a href="#" class="down"> <strong class="ui-banner__title">환경영향평가
												항목 결정내용(본선2구간)</strong>
										</a>
									</div>
									<div class="banner__box down">
										<a href="#" class="down"> <strong class="ui-banner__title">환경영향평가
												항목 결정내용(본선2구간)</strong>
										</a>
									</div>
								</div>
							</div>

							<div class="map__header">
								<span class="map__title">향후 추진계획</span>
							</div>
							<div class="map__content">
								<div class="menteu">
									<ul>
										<li>용지보상비로 추경예산 50억원 편성(2013.06)</li>
										<li>2014년 예산 400억 확보</li>
										<li>2016년 토지보상 배정예산:399억원</li>
										<li>2017년 배정예산:350억원</li>
										<li>2017년 토지보상 배정예산:399억 8,000만원</li>
										<li>2018년 토지보상 배정예산:95억원</li>
									</ul>
								</div>
							</div>


							<div class="ui-tip__box">
								<p class="txt-tip txt-small">본 개발정보는 2021년 02월 08일까지 공개된 자료와
									Gzone 당사가 직접 취재한 내용을 바탕으로 최종 수정된 자료입니다. 금일 이후 사업시행자의 상황 또는
									경제여건의 변화 등에 따라 사업은 축소.획대.변경.취소 및 지연될수 있으니 이용자께서는 이점 유의하시길 바랍니다.</p>
								<p class="txt-tip txt-small">본개발정보는 참고사항이며 당사는 이에 대해 어떠한
									경우라도 법적인 책임을 지지 않습니다.</p>
								<p class="txt-tip txt-small">본 개발정보의 지적소유권은 당사에 있으며 당사의 사전
									허락없이 이를 무단으로 전제, 복제 할 경우 저작권법에 따라 처벌을 받게 됩니다.</p>
							</div>
							<p class="text-center print">
								<a href="#" class="btn btn-default"><i class="icon-print"></i>인쇄하기</a>
							</p>


						</div>
						<div class="button-map">
							<button type="button" id="infoAdd">관심정보등록</button>
							<button type="button" id="infoParagraph">관련기사</button>
							<button type="button" id="infoObject" data-ly-btn="objectInfo">투자정보
								물건보기</button>
						</div>
						<button type="button" id="info_close">
							<span class="skip">정보창</span>닫기
						</button>
					</div>
				</div>
			</div>

			<!-- 경/공매 ::S -->

			<div class="modal fade" role="dialog" data-ly-type="content"
				data-ly-target="board__reward">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal__body">

						<!-- 보상전레 리스트 -->
						<div class="modal__header">
							<h4 class="modal__title">보상전레 리스트</h4>
							<div class="modal__close-button">
								<button type="button" class="close" data-dismiss="modal">닫기</button>
							</div>
						</div>
						<div class="modal__content" style="word-break: break-all">
							<div class="cont_wrap">

								<form name="bbsNttSearchForm" method="get" action="/">
									<fieldset>
										<legend>검색</legend>
										<div class="search">
											<!-- 01. item -->
											<div class="item form-item">
												<div class="form-group form-group1">
													<span class="tit">등록기간</span>
													<div class="search-inner text-left">
														<div class="search--calendar">
															<span> <input type="text" class="form-control"
																name="startDate" id="startDate" placeholder="시작일"
																value="" title="시작일 입력">
																<button type="button" class="btn__calendar">
																	<span class="skip">달력선택</span>
																</button>
															</span>
														</div>
														<div class="search--calendar">
															<span> <input type="text" class="form-control"
																name="endDate" id="endDate" placeholder="종료일" value=""
																title="종료일 입력">
																<button type="button" class="btn__calendar">
																	<span class="skip">달력선택</span>
																</button>
															</span>
														</div>
													</div>
												</div>
												<div class="form-group form-group2">
													<span class="tit">사업지구명</span>
													<div class="search-inner text-left">
														<div class="search--select">
															<span> <select name="">
																	<option value="">-- 전체 --</option>
															</select>
															</span>
														</div>
													</div>
												</div>
											</div>
											<!-- 01. item ::E -->
											<!-- 01. item -->
											<div class="item">
												<div class="form-group full-group">
													<span class="tit">주소</span>
													<div class="search-inner text-left">
														<div class="search--select">
															<span> <select name="">
																	<option value="">-- 전체 --</option>
															</select>
															</span> <span> <select name="">
																	<option value="">-- 전체 --</option>
															</select>
															</span> <span> <select name="">
																	<option value="">-- 전체 --</option>
															</select>
															</span>
														</div>

														<div class="search--btn">
															<span class="btn--submit"><input type="submit"
																value="검색"></span>
														</div>
													</div>
												</div>
											</div>
											<!-- 01. item ::E -->

										</div>
									</fieldset>
								</form>


								<div class="board_btm" style="margin-bottom: 15px">
									<div class="btns_area fl_r mo_block">
										<a href="#" class="btn btn-primary btn-sm">토지이용계획​ 바로가기​</a> <a
											href="#" class="btn btn-secondary btn-sm">개별공시지가​ 바로가기</a>
									</div>
								</div>

								<div class="reward-wrap">
									<div class="box">
										<div class="label-box">
											<strong>도시개발사업</strong>
											<ul>
												<li>주소 : 도시개발사업도시개발사업도시개발사업</li>
												<li>보상가 : 00,000,000</li>
												<li>지목 : 지목</li>
												<li>가격시점개별지가 : 가격시점개별지가</li>
											</ul>
											<em>2021-03-09</em>
										</div>
									</div>
									<div class="box">
										<div class="label-box">
											<strong>도시개발사업</strong>
											<ul>
												<li>주소 : 도시개발사업도시개발사업도시개발사업</li>
												<li>보상가 : 00,000,000</li>
												<li>지목 : 지목</li>
												<li>가격시점개별지가 : 가격시점개별지가</li>
											</ul>
											<em>2021-03-09</em>
										</div>
									</div>
									<div class="box">
										<div class="label-box">
											<strong>도시개발사업</strong>
											<ul>
												<li>주소 : 도시개발사업도시개발사업도시개발사업</li>
												<li>보상가 : 00,000,000</li>
												<li>지목 : 지목</li>
												<li>가격시점개별지가 : 가격시점개별지가</li>
											</ul>
											<em>2021-03-09</em>
										</div>
									</div>
								</div>
								<div class="pagination-inner">
									<ul class="pagination">
										<li class="page-item"><a class="page-link"
											aria-label="first" href="#"> <span aria-hidden="true">&lt;&lt;</span>
												<span class="sr-only">첫번째페이지</span>
										</a></li>
										<li class="page-item"><a class="page-link"
											aria-label="Previous" href="#"> <span aria-hidden="true">&lt;</span>
												<span class="sr-only">이전페이지</span>
										</a></li>
										<li class="page-item active"><a class="page-link"
											href="#">1</a></li>
										<li class="page-item"><a class="page-link" href="#">2</a></li>
										<li class="page-item"><a class="page-link" href="#">3</a></li>
										<li class="page-item"><a class="page-link" href="#">4</a></li>
										<li class="page-item"><a class="page-link" href="#">5</a></li>
										<li class="page-item"><a class="page-link" href="#">6</a></li>
										<li class="page-item"><a class="page-link" href="#">7</a></li>
										<li class="page-item"><a class="page-link" href="#">8</a></li>
										<li class="page-item"><a class="page-link" href="#">9</a></li>
										<li class="page-item"><a class="page-link" href="#">10</a></li>
										<li class="page-item"><a class="page-link"
											aria-label="Next" href="#"> <span aria-hidden="true">&gt;</span>
												<span class="sr-only">다음페이지</span>
										</a></li>
										<li class="page-item"><a class="page-link"
											aria-label="last" href="#"> <span aria-hidden="true">&gt;&gt;</span>
												<span class="sr-only">마지막페이지</span>
										</a></li>
									</ul>
									<div class="button-group">
										<a href="#" class="btn btn-default">등록</a>
									</div>
								</div>


							</div>
						</div>
						<!-- 보상전레 리스트 -->

						<!-- 보상전레 등록  
				            <div class="modal__header">
				               <h4 class="modal__title">보상전레 등록</h4>
				               <div class="modal__close-button"><button type="button" class="close" data-dismiss="modal">닫기</button></div>
				            </div>
				            <div class="modal__content" style="word-break: break-all">
				                <div class="cont_wrap">
					               <div class="modal__board">
						               
						               <div class="board_btm" style="margin-bottom:15px">
					                        <div class="btns_area fl_r mo_block">
					                            <a href="#" class="btn btn-primary btn-sm">토지이용계획​ 바로가기​</a>
					                            <a href="#" class="btn btn-secondary btn-sm">개별공시지가​ 바로가기</a>
					                        </div>
					                    </div>
						               						               
					                    <div class="form-horizontal bucket-form">
						                   <div class="form-group">
											    <div class="col-sm-2 control-label col-lg-2"><label for="select">사업지구명​</label></div>
											    <div class="col-sm-4">
											    	<input type="text" id="name" name="name" title="이름 입력" class="form-control" value="">
												</div>
											</div> 
											<div class="form-group">
											    <div class="col-sm-2 control-label col-lg-2"><label for="select">주소​</label></div>
											    <div class="col-sm-10">
											    	<input type="text" id="name" name="name" title="이름 입력" class="form-control" value="">
												</div>
											</div> 
						                   <div class="form-group">
											    <div class="col-sm-2 control-label col-lg-2"><label for="select">협의)보상가(/㎡)​</label></div>
											    <div class="col-sm-4">
											    	<in	put type="text" id="name" name="name" title="이름 입력" class="form-control" value="">
												</div>
												<div class="col-sm-2 control-label col-lg-2"><label for="select">지목​</label></div>
											    <div class="col-sm-4">
											    	<in	put type="text" id="name" name="name" title="이름 입력" class="form-control" value="">
												</div>
											</div> 
											<div class="form-group">
											    <div class="col-sm-2 control-label col-lg-2"><label for="select">가격시점​​</label></div>
											    <div class="col-sm-4">
											    	<div class="search--calendar">
														<span>
															<input type="text" class="form-control" name="startDate" id="startDate" placeholder="시작일" value="" title="시작일 입력">
															<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
														</span>
													</div>
												</div>
											    <div class="col-sm-2 control-label col-lg-2"><label for="select">개별지가(/㎡)​​​</label></div>
											    <div class="col-sm-4">
											    	<input type="text" id="name" name="name" title="이름 입력" class="form-control" value="">
												</div>
											</div> 
											
						                    
					                    </div>
					                    
					                    
					                    <div class="board_btm">
					                        <div class="btns_area fl_r mo_block">
					                            <a href="#" class="btn btn-default">등록</a>
					                        </div>
					                    </div>
					                </div>
				                </div>
				            </div>
				            보상전레 등록 -->

					</div>
				</div>
			</div>
			<!-- 경/공매 ::S -->

			<!-- 경/공매 ::S -->

			<div class="modal fade" role="dialog" data-ly-type="content"
				data-ly-target="board__gongmae">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal__body">

						<!-- 경/공매 리스트 
				            <div class="modal__header">
				               <h4 class="modal__title">경/공매 리스트</h4>
				               <div class="modal__close-button"><button type="button" class="close" data-dismiss="modal">닫기</button></div>
				            </div>
				            <div class="modal__content" style="word-break: break-all">
				                <div class="cont_wrap">
					               
					                
					                
				                </div>
				            </div>
				             경/공매 리스트 -->

						<!-- 경/공매 등록  -->
						<div class="modal__header">
							<h4 class="modal__title">경/공매 등록</h4>
							<div class="modal__close-button">
								<button type="button" class="close" data-dismiss="modal">닫기</button>
							</div>
						</div>
						<div class="modal__content" style="word-break: break-all">
							<div class="cont_wrap"></div>
						</div>
						<!-- 경/공매 등록 -->

						<!-- 경/공매 상세보기 
				            <div class="modal__header">
				               <h4 class="modal__title">경/공매 상세보기</h4>
				               <div class="modal__close-button"><button type="button" class="close" data-dismiss="modal">닫기</button></div>
				            </div>
				            <div class="modal__content" style="word-break: break-all">
				                <div class="cont_wrap">
					               
					                
					                
				                </div>
				            </div>
				             경/공매 상세보기  -->
					</div>
				</div>
			</div>
			<!-- 경/공매 ::S -->


			<!-- 투자정보 물건보기 상세보기 ::S -->
			<div class="modal fade" role="dialog" data-ly-type="content"
				data-ly-target="objectInfo">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal__body">
						<div class="modal__header">
							<h4 class="modal__title">투자정보 물건보기</h4>
							<div class="modal__close-button">
								<button type="button" class="close" data-dismiss="modal">닫기</button>
							</div>
						</div>
						<div class="modal__content" style="word-break: break-all">
							<div class="cont_wrap">
								<!-- LIST -->

								<!-- LIST -->
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 투자정보 물건보기 상세보기 ::E -->

			<!-- 개발사업 정보 상세보기 ::S -->
			<div class="modal fade" role="dialog" data-ly-type="content"
				data-ly-target="modal-map1">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal__body">
						<div class="modal__header">
							<h4 class="modal__title">개발사업 정보 상세보기</h4>
							<div class="modal__close-button">
								<button type="button" class="close" data-dismiss="modal">닫기</button>
							</div>
						</div>
						<div class="modal__content" style="word-break: break-all">
							<div class="cont_wrap">

								<div class="modal_form">
									<div class="form-horizontal bucket-form">
										<div class="form-group">
											<div class="col-sm-2 control-label">
												<label for="birth">Gzonei 멘트</label>
											</div>
											<div class="col-sm-2">
												<select name="tel" class="form-control" title="연령대 선택">
													<option>국민은행</option>
												</select>
											</div>
											<div class="col-sm-8">
												<textarea title="Gzonei 멘트" placeholder="Gzonei 멘트를 입력하세요."
													class="form-control"></textarea>
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-2 control-label">
												<label for="birth">예상 보상 상태</label>
											</div>
											<div class="col-sm-4">
												<select id="tel1" name="tel" class="form-control"
													title="연령대 선택">
													<option value=""></option>
												</select>
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-2 control-label">
												<label for="brhs">예상 보상 시기</label>
											</div>
											<div class="col-sm-4">
												<div class="search--calendar">
													<span> <input type="text" class="form-control"
														name="startDate" id="startDate" placeholder="시작일" value=""
														title="시작일 입력">
														<button type="button" class="btn__calendar">
															<span class="skip">달력선택</span>
														</button>
													</span>
												</div>
											</div>
											<div class="col-sm-2 control-label">
												<label for="">관리자 수정일자</label>
											</div>
											<div class="col-sm-4">
												<div class="search--calendar">
													<span> <input type="text" class="form-control"
														name="endDate" id="endDate" placeholder="종료일" value=""
														title="종료일 입력">
														<button type="button" class="btn__calendar">
															<span class="skip">달력선택</span>
														</button>
													</span>
												</div>
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-2 control-label">
												<label for="brhs">공개 여부</label>
											</div>
											<div class="col-sm-4">
												<input class="radio-input" type="radio" id="radio1"
													name="ch_01_01" title="개발정보" value="a"> <label
													class="radio-inline" for="radio1">공개 여부2</label> <input
													class="radio-input" type="radio" id="radio2"
													name="ch_01_01" title="투자정보" value="b"> <label
													class="radio-inline" for="radio2">공개 여부1</label>
											</div>
											<div class="col-sm-2 control-label">
												<label for="">샘플 보기 여부</label>
											</div>
											<div class="col-sm-4">
												<input class="radio-input" type="radio" id="radio1"
													name="ch_01_01" title="개발정보" value="a"> <label
													class="radio-inline" for="radio1">샘플 보기 여부1</label> <input
													class="radio-input" type="radio" id="radio2"
													name="ch_01_01" title="투자정보" value="b"> <label
													class="radio-inline" for="radio2">샘플 보기 여부2</label>
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-2 control-label">
												<label for="birth">첨부 파일</label>
											</div>
											<div class="col-sm-10">
												<div class="form-upload">
													<div class="file-form-group">
														<div class="form-group__upload">
															<input type="text" readonly="readonly"
																class="form-control disabled" title="1번째 파일명"> <input
																type="file" name="file_1" id="atchmn_1"
																class="form-upload__file--hidden">
														</div>
														<div class="form-input__addon">
															<label for="atchmn_1" class="btn btn-sm btn-primary"
																data-button="upload"><span class="skip">1번째
															</span>파일선택</label>
														</div>
													</div>
													<div class="file-form-group">
														<div class="form-group__upload">
															<input type="text" readonly="readonly"
																class="form-control disabled" title="1번째 파일명"> <input
																type="file" name="file_1" id="atchmn_1"
																class="form-upload__file--hidden">
														</div>
														<div class="form-input__addon">
															<label for="atchmn_1" class="btn btn-sm btn-primary"
																data-button="upload"><span class="skip">1번째
															</span>파일선택</label>
														</div>
													</div>

													<div class="file-button">
														<button type="button">추가</button>
														<button type="button">삭제</button>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="text-center button_align">
										<button type="button" class="btn btn-default">취소</button>
										<button type="button" class="btn btn-default">삭제</button>
										<button type="button" class="btn btn-primary">수정</button>
									</div>
								</div>



								<div class="top_head">
									<h3 class="h_title_sub">개발사업 추진내역</h3>
									<button type="button" class="btn btn-primary btn-sm"
										onclick="formAdd()">추가</button>
								</div>

								<div class="table-scroll">
									<table class="table table-bordered text-center">
										<caption>테이블 안내 – 구분, 부서/직위, 성명, 연락처, 홈페이지 정보 제공</caption>
										<colgroup>
											<col style="width: 12%">
											<col style="width: 10%">
											<col style="width: 10%">

											<col style="width: auto">
											<col style="width: 10%">
											<col style="width: 10%">
											<col style="width: 10%">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">일련번호</th>
												<th scope="col">추진시작일</th>
												<th scope="col">추진종료일</th>
												<th scope="col">제목</th>
												<th scope="col">연관키워드1</th>
												<th scope="col">추진구분</th>
												<th scope="col">첨부파일명</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
										</tbody>
									</table>
								</div>
								<div id="form-map" style="display: none;">
									<div class="top_head">
										<h3 class="h_title_sub">추진내역 등록</h3>
									</div>
									<div class="modal_form">
										<div class="form-horizontal bucket-form">

											<div class="form-group">
												<div class="col-sm-2 control-label">
													<label for="birth">예상 보상 상태</label>
												</div>
												<div class="col-sm-4">
													<input type="text" class="form-control"
														placeholder="예상 보상 상태" value="" title="예상 보상 상태 입력">
												</div>
												<div class="col-sm-2 control-label">
													<label for="birth">추진구분</label>
												</div>
												<div class="col-sm-4">
													<select id="" name="" class="form-control" title="추진구분 선택">
														<option value=""></option>
													</select>
												</div>
											</div>

											<div class="form-group">
												<div class="col-sm-2 control-label">
													<label for="">제목</label>
												</div>
												<div class="col-sm-10">
													<input type="text" class="form-control" placeholder="제목"
														value="" title="제목 입력">
												</div>
											</div>
											<div class="form-group">
												<div class="col-sm-2 control-label">
													<label for="brhs">추진시작일</label>
												</div>
												<div class="col-sm-4">
													<div class="search--calendar">
														<span> <input type="text" class="form-control"
															name="startDate" id="startDate" placeholder="시작일"
															value="" title="시작일 입력">
															<button type="button" class="btn__calendar">
																<span class="skip">달력선택</span>
															</button>
														</span>
													</div>
												</div>
												<div class="col-sm-2 control-label">
													<label for="">추진종료일</label>
												</div>
												<div class="col-sm-4">
													<div class="search--calendar">
														<span> <input type="text" class="form-control"
															name="endDate" id="endDate" placeholder="종료일" value=""
															title="종료일 입력">
															<button type="button" class="btn__calendar">
																<span class="skip">달력선택</span>
															</button>
														</span>
													</div>
												</div>
											</div>
											<div class="form-group">
												<div class="col-sm-2 control-label">
													<label for="brhs">공개 여부</label>
												</div>
												<div class="col-sm-4">
													<input class="radio-input" type="radio" id="radio1"
														name="ch_01_01" title="개발정보" value="a"> <label
														class="radio-inline" for="radio1">공개 여부2</label> <input
														class="radio-input" type="radio" id="radio2"
														name="ch_01_01" title="투자정보" value="b"> <label
														class="radio-inline" for="radio2">공개 여부1</label>
												</div>
												<div class="col-sm-2 control-label">
													<label for="">샘플 보기 여부</label>
												</div>
												<div class="col-sm-4">
													<input class="radio-input" type="radio" id="radio1"
														name="ch_01_01" title="개발정보" value="a"> <label
														class="radio-inline" for="radio1">샘플 보기 여부1</label> <input
														class="radio-input" type="radio" id="radio2"
														name="ch_01_01" title="투자정보" value="b"> <label
														class="radio-inline" for="radio2">샘플 보기 여부2</label>
												</div>
											</div>
											<div class="form-group">
												<div class="col-sm-2 control-label">
													<label for="">연관키워드</label>
												</div>
												<div class="col-sm-10">
													<input type="text" class="form-control" placeholder="연관키워드"
														value="" title="연관키워드 입력">
												</div>
											</div>
											<div class="form-group">
												<div class="col-sm-2 control-label">
													<label for="birth">첨부 파일</label>
												</div>
												<div class="col-sm-2">
													<select name="tel" class="form-control" title="연령대 선택">
														<option>등급</option>
													</select>
												</div>
												<div class="col-sm-8">
													<div class="form-upload">
														<div class="file-form-group">
															<div class="form-group__upload">
																<input type="text" readonly="readonly"
																	class="form-control disabled" title="1번째 파일명">
																<input type="file" name="file_1" id="atchmn_1"
																	class="form-upload__file--hidden">
															</div>
															<div class="form-input__addon">
																<label for="atchmn_1" class="btn btn-sm btn-primary"
																	data-button="upload"><span class="skip">1번째
																</span>파일선택</label>
															</div>
														</div>
														<div class="file-form-group">
															<div class="form-group__upload">
																<input type="text" readonly="readonly"
																	class="form-control disabled" title="1번째 파일명">
																<input type="file" name="file_1" id="atchmn_1"
																	class="form-upload__file--hidden">
															</div>
															<div class="form-input__addon">
																<label for="atchmn_1" class="btn btn-sm btn-primary"
																	data-button="upload"><span class="skip">1번째
																</span>파일선택</label>
															</div>
														</div>

														<div class="file-button">
															<button type="button">추가</button>
															<button type="button">삭제</button>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="text-center button_align">
											<button type="button" class="btn btn-default">취소</button>
											<button type="button" class="btn btn-primary">등록</button>
										</div>
									</div>
								</div>

							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 개발사업 정보 상세보기 ::E -->


			<!-- 투자 정보 상세보기 ::S -->
			<div class="modal fade" role="dialog" data-ly-type="content"
				data-ly-target="modal-map2">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal__body">
						<div class="modal__header">
							<h4 class="modal__title">투자 정보 상세보기</h4>
							<div class="modal__close-button">
								<button type="button" class="close" data-dismiss="modal">닫기</button>
							</div>
						</div>
						<div class="modal__content" style="word-break: break-all">
							<div class="cont_wrap">

								<div class="modal_form">
									<div class="form-horizontal bucket-form">
										<div class="form-group">
											<div class="col-sm-2 control-label">
												<label for="birth">Gzonei 멘트</label>
											</div>
											<div class="col-sm-2">
												<select name="tel" class="form-control" title="연령대 선택">
													<option>국민은행</option>
												</select>
											</div>
											<div class="col-sm-8">
												<textarea title="Gzonei 멘트" placeholder="Gzonei 멘트를 입력하세요."
													class="form-control"></textarea>
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-2 control-label">
												<label for="birth">예상 보상 상태</label>
											</div>
											<div class="col-sm-4">
												<select id="tel1" name="tel" class="form-control"
													title="연령대 선택">
													<option value=""></option>
												</select>
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-2 control-label">
												<label for="brhs">예상 보상 시기</label>
											</div>
											<div class="col-sm-4">
												<div class="search--calendar">
													<span> <input type="text" class="form-control"
														name="startDate" id="startDate" placeholder="시작일" value=""
														title="시작일 입력">
														<button type="button" class="btn__calendar">
															<span class="skip">달력선택</span>
														</button>
													</span>
												</div>
											</div>
											<div class="col-sm-2 control-label">
												<label for="">관리자 수정일자</label>
											</div>
											<div class="col-sm-4">
												<div class="search--calendar">
													<span> <input type="text" class="form-control"
														name="endDate" id="endDate" placeholder="종료일" value=""
														title="종료일 입력">
														<button type="button" class="btn__calendar">
															<span class="skip">달력선택</span>
														</button>
													</span>
												</div>
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-2 control-label">
												<label for="brhs">공개 여부</label>
											</div>
											<div class="col-sm-4">
												<input class="radio-input" type="radio" id="radio1"
													name="ch_01_01" title="개발정보" value="a"> <label
													class="radio-inline" for="radio1">공개 여부2</label> <input
													class="radio-input" type="radio" id="radio2"
													name="ch_01_01" title="투자정보" value="b"> <label
													class="radio-inline" for="radio2">공개 여부1</label>
											</div>
											<div class="col-sm-2 control-label">
												<label for="">샘플 보기 여부</label>
											</div>
											<div class="col-sm-4">
												<input class="radio-input" type="radio" id="radio1"
													name="ch_01_01" title="개발정보" value="a"> <label
													class="radio-inline" for="radio1">샘플 보기 여부1</label> <input
													class="radio-input" type="radio" id="radio2"
													name="ch_01_01" title="투자정보" value="b"> <label
													class="radio-inline" for="radio2">샘플 보기 여부2</label>
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-2 control-label">
												<label for="birth">첨부 파일</label>
											</div>
											<div class="col-sm-10">
												<div class="form-upload">
													<div class="file-form-group">
														<div class="form-group__upload">
															<input type="text" readonly="readonly"
																class="form-control disabled" title="1번째 파일명"> <input
																type="file" name="file_1" id="atchmn_1"
																class="form-upload__file--hidden">
														</div>
														<div class="form-input__addon">
															<label for="atchmn_1" class="btn btn-sm btn-primary"
																data-button="upload"><span class="skip">1번째
															</span>파일선택</label>
														</div>
													</div>
													<div class="file-form-group">
														<div class="form-group__upload">
															<input type="text" readonly="readonly"
																class="form-control disabled" title="1번째 파일명"> <input
																type="file" name="file_1" id="atchmn_1"
																class="form-upload__file--hidden">
														</div>
														<div class="form-input__addon">
															<label for="atchmn_1" class="btn btn-sm btn-primary"
																data-button="upload"><span class="skip">1번째
															</span>파일선택</label>
														</div>
													</div>

													<div class="file-button">
														<button type="button">추가</button>
														<button type="button">삭제</button>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="text-center button_align">
										<button type="button" class="btn btn-default">취소</button>
										<button type="button" class="btn btn-default">삭제</button>
										<button type="button" class="btn btn-primary">수정</button>
									</div>
								</div>

								<div class="top_head">
									<h3 class="h_title_sub">개발사업 추진내역</h3>
									<button type="button" class="btn btn-primary btn-sm"
										onclick="formAdd()">추가</button>
								</div>
								<div class="table-scroll">
									<table class="table table-bordered text-center">
										<caption>테이블 안내 – 구분, 부서/직위, 성명, 연락처, 홈페이지 정보 제공</caption>
										<colgroup>
											<col style="width: 12%">
											<col style="width: 10%">
											<col style="width: 10%">

											<col style="width: auto">
											<col style="width: 10%">
											<col style="width: 10%">
											<col style="width: 10%">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">일련번호</th>
												<th scope="col">추진시작일</th>
												<th scope="col">추진종료일</th>
												<th scope="col">제목</th>
												<th scope="col">연관키워드1</th>
												<th scope="col">추진구분</th>
												<th scope="col">첨부파일명</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="top_head" style="margin-top: 20px;">
									<h3 class="h_title_sub">개발사업 추진내역</h3>
									<button type="button" class="btn btn-primary btn-sm"
										onclick="formAdd()">추가</button>
								</div>

								<div class="table-scroll">
									<table class="table table-bordered text-center">
										<caption>테이블 안내 – 구분, 부서/직위, 성명, 연락처, 홈페이지 정보 제공</caption>
										<colgroup>
											<col style="width: 12%">
											<col style="width: 10%">
											<col style="width: 10%">

											<col style="width: auto">
											<col style="width: 10%">
											<col style="width: 10%">
											<col style="width: 10%">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">일련번호</th>
												<th scope="col">추진시작일</th>
												<th scope="col">추진종료일</th>
												<th scope="col">제목</th>
												<th scope="col">연관키워드1</th>
												<th scope="col">추진구분</th>
												<th scope="col">첨부파일명</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
										</tbody>
									</table>
								</div>
								<div id="form-map" style="display: none;">
									<div class="top_head">
										<h3 class="h_title_sub">추진내역 등록</h3>
									</div>
									<div class="modal_form">
										<div class="form-horizontal bucket-form">

											<div class="form-group">
												<div class="col-sm-2 control-label">
													<label for="birth">예상 보상 상태</label>
												</div>
												<div class="col-sm-4">
													<input type="text" class="form-control"
														placeholder="예상 보상 상태" value="" title="예상 보상 상태 입력">
												</div>
												<div class="col-sm-2 control-label">
													<label for="birth">추진구분</label>
												</div>
												<div class="col-sm-4">
													<select id="" name="" class="form-control" title="추진구분 선택">
														<option value=""></option>
													</select>
												</div>
											</div>

											<div class="form-group">
												<div class="col-sm-2 control-label">
													<label for="">제목</label>
												</div>
												<div class="col-sm-10">
													<input type="text" class="form-control" placeholder="제목"
														value="" title="제목 입력">
												</div>
											</div>
											<div class="form-group">
												<div class="col-sm-2 control-label">
													<label for="brhs">추진시작일</label>
												</div>
												<div class="col-sm-4">
													<div class="search--calendar">
														<span> <input type="text" class="form-control"
															name="startDate" id="startDate" placeholder="시작일"
															value="" title="시작일 입력">
															<button type="button" class="btn__calendar">
																<span class="skip">달력선택</span>
															</button>
														</span>
													</div>
												</div>
												<div class="col-sm-2 control-label">
													<label for="">추진종료일</label>
												</div>
												<div class="col-sm-4">
													<div class="search--calendar">
														<span> <input type="text" class="form-control"
															name="endDate" id="endDate" placeholder="종료일" value=""
															title="종료일 입력">
															<button type="button" class="btn__calendar">
																<span class="skip">달력선택</span>
															</button>
														</span>
													</div>
												</div>
											</div>
											<div class="form-group">
												<div class="col-sm-2 control-label">
													<label for="brhs">공개 여부</label>
												</div>
												<div class="col-sm-4">
													<input class="radio-input" type="radio" id="radio1"
														name="ch_01_01" title="개발정보" value="a"> <label
														class="radio-inline" for="radio1">공개 여부2</label> <input
														class="radio-input" type="radio" id="radio2"
														name="ch_01_01" title="투자정보" value="b"> <label
														class="radio-inline" for="radio2">공개 여부1</label>
												</div>
												<div class="col-sm-2 control-label">
													<label for="">샘플 보기 여부</label>
												</div>
												<div class="col-sm-4">
													<input class="radio-input" type="radio" id="radio1"
														name="ch_01_01" title="개발정보" value="a"> <label
														class="radio-inline" for="radio1">샘플 보기 여부1</label> <input
														class="radio-input" type="radio" id="radio2"
														name="ch_01_01" title="투자정보" value="b"> <label
														class="radio-inline" for="radio2">샘플 보기 여부2</label>
												</div>
											</div>
											<div class="form-group">
												<div class="col-sm-2 control-label">
													<label for="">연관키워드</label>
												</div>
												<div class="col-sm-10">
													<input type="text" class="form-control" placeholder="연관키워드"
														value="" title="연관키워드 입력">
												</div>
											</div>
											<div class="form-group">
												<div class="col-sm-2 control-label">
													<label for="birth">첨부 파일</label>
												</div>
												<div class="col-sm-2">
													<select name="tel" class="form-control" title="연령대 선택">
														<option>등급</option>
													</select>
												</div>
												<div class="col-sm-8">
													<div class="form-upload">
														<div class="file-form-group">
															<div class="form-group__upload">
																<input type="text" readonly="readonly"
																	class="form-control disabled" title="1번째 파일명">
																<input type="file" name="file_1" id="atchmn_1"
																	class="form-upload__file--hidden">
															</div>
															<div class="form-input__addon">
																<label for="atchmn_1" class="btn btn-sm btn-primary"
																	data-button="upload"><span class="skip">1번째
																</span>파일선택</label>
															</div>
														</div>
														<div class="file-form-group">
															<div class="form-group__upload">
																<input type="text" readonly="readonly"
																	class="form-control disabled" title="1번째 파일명">
																<input type="file" name="file_1" id="atchmn_1"
																	class="form-upload__file--hidden">
															</div>
															<div class="form-input__addon">
																<label for="atchmn_1" class="btn btn-sm btn-primary"
																	data-button="upload"><span class="skip">1번째
																</span>파일선택</label>
															</div>
														</div>

														<div class="file-button">
															<button type="button">추가</button>
															<button type="button">삭제</button>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="text-center button_align">
											<button type="button" class="btn btn-default">취소</button>
											<button type="button" class="btn btn-primary">등록</button>
										</div>
									</div>
								</div>

							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 투자 정보 상세보기 ::E -->
			<!-- 개발 완료시 삭제 ::S  -->

			<!-- 개발 완료시 삭제  ::E  -->
			<!-- content 영역입니다. -->
		</div>
	</div>
	</div>
	<!-- layout -->
	</div>

	<!-- 구현부 : E -->

	<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp"%>
</body>
</html>
