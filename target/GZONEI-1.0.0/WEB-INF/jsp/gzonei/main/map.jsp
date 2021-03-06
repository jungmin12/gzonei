<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html class="mapHtml" lang='ko'>
<head>
<%@ include file="/WEB-INF/jsp/gzonei/layout/headerMap.jsp"%>
</head>
<body class="mapBody">
	<%@ include file="/WEB-INF/jsp/gzonei/layout/top.jsp"%>
	<%@ include file="/WEB-INF/jsp/gzonei/devlopInfo/devDtlModal.jsp"%>
	<%@ include file="/WEB-INF/jsp/gzonei/invt/invtDtlModal.jsp"%>

	<script type="text/javascript"
		src="<c:url value='/js/gzonei/map/sweetalert.min.js' />"></script>
	<script type="text/javascript"
		src="<c:url value='/js/gzonei/map/mapMain.js' />"></script>
	<script type="text/javascript"
		src="<c:url value='/js/gzonei/devlopInfo/devlopInfo.js' />"></script>
	<script type="text/javascript"
		src="<c:url value='/js/gzonei/invt/invtDevlop.js' />"></script>
	<script type="text/javascript"
		src="<c:url value='/js/gzonei/invt/invtInfo.js' />"></script>
	<script type="text/javascript"
		src="<c:url value='/js/gzonei/reward/rewardInfo.js' />"></script>
	<script type="text/javascript"
		src="<c:url value='/js/gzonei/devlopInfo/twbsPagination.js' />"></script>
	<script src="<c:url value='/js/gzonei/devlopInfo/mapFileUtil.js' />"></script>
	<!-- 구현부 : S -->
	<div id="body_layout" class="map">
		<input type="hidden" id="loginVO" value="${loginVO}"/>
		<input type="hidden" id="lon" value="${searchVO.lon}"> <input
			type="hidden" id="lat" value="${searchVO.lat}">
		<!-- layout -->
		<div class="body_wrap layout">
			<div id="contens" class="contents_wrap">
				<div id="txt">
					<!-- content 영역입니다. -->
					<div id="app">
						<div id="totalWrap">
							<div id="map">
								<div id="realMap" class='mapInner'></div>
							</div>
							<div id="popup" class="ol-popup">
								<a href="#" id="popup-closer" class="ol-popup-closer"></a>
								<div id="popup-content"></div>
							</div>
							<div id="mapTabs">
								<button type="button" class="on mapir naver" data-map="Naver">
									<span>네이버맵</span>
								</button>
								<button type="button" class="mapir kakao" data-map="kakao">
									<span>카카오맵</span>
								</button>
								<button type="button" class="mapir google" data-map="google">
									<span>구글맵</span>
								</button>
							</div>
							<c:if test="${loginVO.get('indvdlMberCode') eq 'CM00210003' }">
								<div id="iconSort">
									<button type="button" class="on satelite" data-mode="Satellite">
										<span>위성지도</span>
									</button>
									<button type="button" class="street" data-mode="Street">
										<span>일반지도</span>
									</button>
								</div>
							</c:if>
							<div id="quickGuide">
								<c:if test="${loginVO.get('indvdlMberCode') eq 'CM00210003' }">
									<div class="item">
										<button type="button" class="mapir admin">admin</button>
										<div class="dropbox">
											<button type="button" class="text-button"
												onclick="javascript:sideShow('devInfoAdminList');"
												id="devInfoAdminListBtn">개발 정보</button>
											<button type="button" class="text-button"
												onclick="javascript:sideShow('invtAdminList');">투자 정보</button>
											<button type="button" class="text-button"
												onclick="javascript:sideShow('rewardAdminList');">보상 전례</button>
										</div>
									</div>
								</c:if>
								<button type="button" class="mapir icon3" title="줌 확대"
									id="btn_zoonin">01</button>
								<button type="button" class="mapir icon4" title="줌 축소"
									id="btn_zoonout">02</button>
								<button type="button" class="mapir icon8" title="길이 측정"
									onclick="mapMeasure('length');">03</button>
								<button type="button" class="mapir icon9" title="다각형 넓이 측정"
									onclick="mapMeasure('area');">04</button>
								<button type="button" class="mapir icon10" title="중심점 거리 측정"
									onclick="mapMeasure('circle');">05</button>
								<button type="button" class="mapir icon11" title="측정 초기화"
									onclick="removeInteraction();">11</button>
								<!-- <button type="button" class="mapir icon13">13</button>
								<button type="button" class="mapir icon14">14</button> -->
								<div class="dropbox">
									<button type="button" class="text-button"
										onclick="insrtLayer('gz_devlop_info')">등록</button>
									<button type="button" class="text-button"
										onclick="selectLayer()">선택</button>
									<button type="button" class="text-button"
										onclick="modifyLayer()">수정</button>
									<button type="button" class="text-button"
										onclick="deleteLayer()">삭제</button>
									<button type="button" class="text-button" onclick="moveLayer()">이동</button>
									<button type="button" class="text-button"
										onclick="saveLayer('gz_devlop_info')">저장</button>
								</div>
							</div>
							<div id="side">
								<!-- <a href="#" class="side_toggle">사이드토글</a> -->
								<div id="searchForm" style="padding-bottom: 50px;">
<!-- 								<div id="searchForm" style="padding: 80px 40px;"> -->
<!-- 									<strong class="mapir title">주소 검색</strong> -->
									<strong class="" style="color:#fff;font-size:25px;">개발사업명 검색</strong>
									<form onsubmit="return false;">
										<fieldset>
											<legend class="skip">주소 검색</legend>
											<label for="searchKeyword" class="skip">검색어 입력</label> <input
												type="text" v-model="searchKeyword" id="searchKeyword"
												value="${searchVO.address}" name="searchKeyword"
												placeholder="사업명을 검색해주세요." onkeypress="return enterkey()">
											<input type='hidden' id='keyPageIndex' value='' />
											<button type="button" id="searchSubmit" data-id="topArea"
												class="submit mapir" onclick="search()">검색하기</button>
											<!-- 											<button type="button" id="kakaoLocationApi" -->
											<!-- 												class="mapLocationApi mapir" onclick="localSearch()">현 -->
											<!-- 												지도 내 장소검색</button> -->
										</fieldset>
									</form>
									<!-- <div id="keyword">
										<em>추천검색어</em>
										<div class="grap">
											<a href="javascript:openModal(1);">개발정보 모달</a> <a
												href="javascript:openModal(2);">투자정보 모달</a> <a href="#">신안산선</a>
										</div>
									</div> -->
								</div>
								<!-- tab -->
								<div id="searchFormTab" class="ui-tablist" style="margin-top: 15px;">
									<ul class="tab-ul" role="tablist">
									<c:set var="gradCode" value="${loginVO.gradCode}" />
									<c:choose>
									    <c:when  test="${gradCode == 'CM00200016' || gradCode == 'CM00200015'|| gradCode == 'CM00200014'}">
								        <li role="presentation" class="link-tab on"><a role="tab"
											id="tab1" data-id="gz_devlop_info" aria-controls="tab-panel1"
											href="#tab-panel1" tabindex="0" aria-selected="true"
											title="열림">개발정보</a></li>
										<li role="presentation" class="link-tab"><a role="tab"
											id="tab2" data-id="gz_invt_info" aria-controls="tab-panel2"
											href="#tab-panel2">투자정보</a></li>
										<li role="presentation" class="link-tab"><a role="tab"
											id="tab3" aria-controls="tab-panel3" href="#tab-panel3">레이어목록</a></li>
									    </c:when>
									    <c:otherwise>
									    <li role="presentation" class="link-tab on" style="width: 50%;"><a role="tab"
											id="tab1" data-id="gz_devlop_info" aria-controls="tab-panel1"
											href="#tab-panel1" tabindex="0" aria-selected="true"
											title="열림">개발정보</a></li>
										<li role="presentation" class="link-tab" style="width: 50%;"><a role="tab"
											id="tab2" data-id="gz_invt_info" aria-controls="tab-panel2"
											href="#tab-panel2" >투자정보</a></li>
									    </c:otherwise>
									</c:choose>
									</ul>
									<div class="tabpanel_box">
										<div class="obj on" id="tab-panel1" role="tabpanel"
											aria-labelledby="tab1">
											<strong class="skip">개발정보</strong>
											<div class="scrollbar">
												<div class="mapSearch__area">
													<form id="devInfoInfoListForm" name="devInfoInfoListForm">
														<input type="hidden" name="pageIndex" value="" />
														<div class="form-group">
															<div class="control-label">
																<label class="mapTitle">지역</label>
															</div>
															<div class="col-sm-4">
																<select id="area1" name="area1"
																	class="area1 form-control" title="시도 선택" required="">
																	<option value="">전체</option>
																</select>
															</div>
															<div class="col-sm-4">
																<select id="area2" name="area2"
																	class="area2 form-control" title="시군구 선택">
																	<option value="">전체</option>
																</select>
															</div>
															<div class="col-sm-4">
																<select id="area3" name="area3"
																	class="area3 form-control" title="시군구 선택">
																	<option value="">전체</option>
																</select>
															</div>
															<c:if test="${authVO.dev001003.infoInqireAt eq 'Y'}">
																<div class="alarmTxt">전체 검색시 검색시간이 지연(3분이상)됩니다.</div>
															</c:if>
														</div>
														<!-- 상세검색 -->
														<div class="mapSearch__biz" >
															<c:if test="${loginVO.gradCode=='CM00200014'||loginVO.gradCode=='CM00200015'||loginVO.gradCode=='CM00200016'}">
																<div class="form-group">
																	<div class="control-label">
																		<label class="mapTitle">협의보상시점</label>
																	</div>
																	<div class="col-sm-6">
																		<span>보상시작년도</span> <select id="rwYr" name="rwYr"
																			class="rwYr form-control" title="보상시작년도 선택"
																			required="">
																			<option value="">전체</option>
																		</select>
																	</div>
																	<div class="col-sm-6">
																		<span>기간</span> <select id="rwYrRange" name="rwYrRange"
																			class="rwYrRange form-control" title="기간 선택">
																			<option value="1">1년 이내</option>
																			<option value="2">2년 이내</option>
																			<option value="3">3년 이내</option>
																			<option value="4">4년 이내</option>
																			<option value="5">5년 이내</option>
																		</select>
																	</div>
																</div>
																<div class="form-group">
																	<div class="control-label">
																		<label class="mapTitle">협의보상상태</label>
																	</div>
																	<div class="col-sm-6">
																		<select id="rw1" name="rw1" class="rw1 form-control"
																			title="협의보상상태 선택" required="">
																			<option value="">전체</option>
																		</select>
																	</div>
																</div>
															</c:if>
															<div class="form-group">
																<div class="control-label">
																	<label class="mapTitle">사업지구</label>
																</div>
																<div class="col-sm-12">
																	<select id="ds1" name="ds1" class="ds1 form-control"
																		title="사업지구 선택1" required="">
																		<option value="">전체</option>
																	</select> <select id="ds2" name="ds2" class="ds2 form-control"
																		title="사업지구 선택2" required="">
																		<option value="">전체</option>
																	</select> <select id="ds3" name="ds3" class="ds3 form-control"
																		title="사업지구 선택3" required="">
																		<option value="">전체</option>
																	</select> <select id="ds4" name="ds4" class="ds4 form-control"
																		title="사업지구 선택4" required="">
																		<option value="">전체</option>
																	</select>
																</div>
															</div>
															<div class="form-group">
																<div class="control-label">
																	<label class="mapTitle">시행사</label>
																</div>
																<div class="col-sm-6">
																	<select id="cp1" name="cp1" class="cp1 form-control"
																		title="시행사 선택" required="">
																		<option value="">전체</option>
																	</select>
																</div>
																<div class="col-sm-6">
																	<select id="cp2" name="cp2" class="cp2 form-control"
																		title="시행사 선택">
																		<option value="">전체</option>
																	</select>
																</div>
															</div>
														</div>
													</form>
													<!-- 상세검색 -->
													<div id="dev-search--btn" class="search--btn">
														<span class="btn--submit"><button type="button"
																id="devInfoUserBtn" data-id="area" class="submit">검색</button></span>
														<span class="btn--more" id="devInfoMore" style="display:none;" ><button
																type="button">상세검색</button></span>
													</div>
												</div>
											</div>
										</div>
										<div class="obj" id="tab-panel2" role="tabpanel"
											aria-labelledby="tab2">
											<strong class="skip">투자정보</strong>
											<form id="invtListForm" name="invtListForm">
												<input type="hidden" name="pageIndex" value="" />
												<div class="scrollbar">
													<div class="mapSearch__area">
														<div class="form-group">
																<div class="control-label">
																	<label class="mapTitle">구분</label>
																</div>
																<div class="col-sm-12">
																	<label><input type="radio"
																		name="aucPblsalSeCode" value="" id="bothShow" checked>
																		전체</label> <label><input type="radio"
																		name="aucPblsalSeCode" value="CM00110001" id="aucShow">
																		경매</label> <label><input type="radio"
																		name="aucPblsalSeCode" value="CM00110002"
																		id="paucShow"> 공매</label>
																</div>
															</div>
															<div class="form-group" id="auc" style="display: none">
																<div class="col-sm-6">
																	<span>법원</span><select name="userCourt" id="userCourt"
																		class="form-control userCourt">
																		<option value="">전체</option>
																	</select>
																</div>
																<div class="col-sm-6">
																	<span>사건번호</span><input type="text"
																		id="incdntManageNoDtl"
																		onkeypress="return fn_press(event, 'numbers');"
																		onkeydown="fn_press_han(this);"
																		name="incdntManageNoDtl" title="타경 입력"
																		class="form-control" value=""
																		placeholder="ex)2020-7562">
																</div>
															</div>
															<div id="pauc" class="form-group" style="display: none">
																<div class="col-sm-6">
																	<span>공매관리번호</span>
																</div>
																<div class="col-sm-12">
																	<input type="text" id="incdntManageNoThing"
																		onkeypress="return fn_press(event, 'numbers');"
																		onkeydown="fn_press_han(this);"
																		name="incdntManageNoThing" title="공매관리번호 입력"
																		class="form-control" value=""
																		placeholder="ex)2020-12254-001">
																</div>
															</div>
														<div class="form-group">
															<div class="control-label">
																<label class="mapTitle">지역</label>
															</div>
															<div class="col-sm-4">
																<select id="invArea1" name="invArea1"
																	class="invArea1 form-control" title="시도 선택" required="">
																	<option value="">전체</option>
																</select>
															</div>
															<div class="col-sm-4">
																<select id="invArea2" name="invArea2"
																	class="invArea2 form-control" title="시군구 선택">
																	<option value="">전체</option>
																</select>
															</div>
															<div class="col-sm-4">
																<select id="invArea3" name="invArea3"
																	class="invArea3 form-control" title="읍면동 선택">
																	<option value="">전체</option>
																</select>
															</div>
														</div>
														<!-- 상세검색 -->
														<div class="mapSearch__biz">
															<div class="form-group">
																<div class="control-label">
																	<label class="mapTitle">사업지구</label>
																</div>
																<div class="col-sm-12">
																	<select id="invDs1" name="invDs1"
																		class="invDs1 form-control" title="사업지구 선택1"
																		required="">
																		<option value="">전체</option>
																	</select> <select id="invDs2" name="invDs2"
																		class="invDs2 form-control" title="사업지구 선택2"
																		required="">
																		<option value="">전체</option>
																	</select> <select id="invDs3" name="invDs3"
																		class="invDs3 form-control" title="사업지구 선택3"
																		required="">
																		<option value="">전체</option>
																	</select> <select id="invDs4" name="invDs4"
																		class="invDs4 form-control" title="사업지구 선택4"
																		required="">
																		<option value="">전체</option>
																	</select>
																</div>
															</div>
															<div class="form-group">
																<div class="control-label">
																	<label class="mapTitle">입찰일</label>
																</div>
																<div class="col-sm-6">
																	<div class="search--calendar">
																		<span> <input type="text" class="form-control"
																			name="beginPnttm" id="startDate3" placeholder="시작일"
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
																			name="endPnttm" id="endDate3" placeholder="종료일"
																			value="" title="종료일 입력">
																			<button type="button" class="btn__calendar">
																				<span class="skip">달력선택</span>
																			</button>
																		</span>
																	</div>
																</div>
															</div>
															<div class="form-group">
																	<div class="control-label">
																		<label class="mapTitle">투자정보 진행상태</label>
																	</div>
																	<div class="col-sm-6">
																		<select name="condiAt" class="form-control"
																			title="투자상태 선택" required="">
																			<option value="Y">투자물건</option>
																			<option value="CM00130003">낙찰전례</option>
																			<option value="">전체</option>
																		</select>
																	</div>
																</div>
															<c:if test="${loginVO.get('indvdlMberCode') eq 'CM00210003' }">
																<div class="form-group">
																	<div class="control-label">
																		<label class="mapTitle">보상상태</label>
																	</div>
																	<div class="col-sm-6">
																		<select name="rewardAt" class="form-control"
																			title="협의보상상태 선택" required="">
																			<option value="">전체</option>
																			<option value="CM00160001">보상중</option>
																			<option value="CM00160002">보상예정</option>
																			<option value="CM00160003">보상완료</option>
																		</select>
																	</div>
																</div>
																<div class="form-group">
																	<div class="control-label">
																		<label class="mapTitle">사업방식</label>
																	</div>
																	<div class="col-sm-12">
																		<label><input type="checkbox"
																			name="bsnsMthdCode" value="CM00150001"> 수용 및
																			사용 </label> <label><input type="checkbox"
																			name="bsnsMthdCode" value="CM00150002"> 환지</label> <label><input
																			type="checkbox" name="bsnsMthdCode"
																			value="CM00150003"> 수용 및 사용 + 환지</label> <label><input
																			type="checkbox" name="bsnsMthdCode"
																			value="CM00150004"> 기타</label>
																	</div>
																</div>
															</c:if>
															<input type="hidden" id="gradCode" name="gradCode"
																value="${sessionScope.loginVO.gradCode}"> <input
																type="hidden" id="indvdlMberCode" name="indvdlMberCode"
																value="${sessionScope.loginVO.indvdlMberCode}">
														</div>
														<!-- 상세검색 -->
														<div class="search--btn">
															<span class="btn--submit"><button type="button"
																	id="invtListSearch" data-id="biz" class="submit">검색</button></span>
															<span class="btn--more" id="more1" style="display:none;"><button type="button">상세검색</button></span>
														</div>
													</div>
												</div>
											</form>
										</div>

										<div class="obj" id="tab-panel3" role="tabpanel"
											aria-labelledby="tab3">
											<strong class="skip">투자정보 검색</strong>
											<div class="scrollbar mCustomScrollbar _mCS_3 mCS-autoHide">
												<div id="mCSB_3"
													class="mCustomScrollBox mCS-dark-1 mCSB_vertical mCSB_inside"
													tabindex="0" style="max-height: none;">
													<div id="mCSB_3_container" class="mCSB_container"
														style="position: relative; top: 0; left: 0;" dir="ltr">

														<div class="mapAll">
															<ul>
																<li>
																	<div class="mapsCont open">
																		<div class="dv">
																			<div class="inner minus2">국토관리/지역개발</div>
																			<div class="list sub open">
																				<ul>
																					<li><div class="module">
																							<label class="lbl_list"><input
																								type="checkbox"
																								onclick='layer_box_chk(this.checked,"lt_c_upisuq153");'>도시계획(공간시설)<%-- <span class="tooltip" data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p><p style='width:20px;height:12px;border-width:1px;background:url(http://map.vworld.kr/images/symbol/pattern/vertical_red_3.png) repeat 0 0px;background-color: undefined;border-color: #434343; float:left; margin:5px 2px;border-style:solid;'></p>범례내용</p>">범례</span> --%></label>
																						</div></li>
																					<li><div class="module">
																							<label class="lbl_list"><input
																								type="checkbox"
																								onclick='layer_box_chk(this.checked,"lt_c_upisuq155");'>도시계획(공공문화체육시설)</label>
																						</div></li>
																					<li><div class="module">
																							<label class="lbl_list"><input
																								type="checkbox"
																								onclick='layer_box_chk(this.checked,"lt_c_upisuq156");'>도시계획(방재시설)</label>
																						</div></li>
																					<li><div class="module">
																							<label class="lbl_list"><input
																								type="checkbox"
																								onclick='layer_box_chk(this.checked,"lt_c_upisuq157");'>도시계획(보건위생시설)</label>
																						</div></li>
																					<li><div class="module">
																							<label class="lbl_list"><input
																								type="checkbox"
																								onclick='layer_box_chk(this.checked,"lt_c_upisuq161");'>지구단위계획</label>
																						</div></li>

																				</ul>
																			</div>
																		</div>
																	</div>
																</li>
																<li>
																	<div class="mapsCont">
																		<div class="dv">
																			<div class="inner minus2">산업단지</div>
																			<div class="list sub">
																				<ul>
																					<li><div class="module">
																							<label class="lbl_list"><input
																								type="checkbox"
																								onclick='layer_box_chk(this.checked,"lt_c_damdan");'>단지경계</label>
																						</div></li>
																					<li><div class="module">
																							<label class="lbl_list"><input
																								type="checkbox"
																								onclick='layer_box_chk(this.checked,"lt_c_damyoj");'>단지시설용지</label>
																						</div></li>
																				</ul>
																			</div>
																		</div>
																	</div>
																</li>
																<li>
																	<div class="mapsCont">
																		<div class="dv">
																			<div class="inner minus2">수자원</div>
																			<div class="list sub">
																				<ul>
																					<li><div class="module">
																							<label class="lbl_list"><input
																								type="checkbox"
																								onclick='layer_box_chk(this.checked,"lt_c_wkmstrm");'>하천망</label>
																						</div></li>
																				</ul>
																			</div>
																		</div>
																	</div>
																</li>
																<li>
																	<div class="mapsCont">
																		<div class="dv">
																			<div class="inner minus2">용도지역지구</div>
																			<div class="list sub">
																				<ul>
																					<li><div class="module">
																							<label class="lbl_list"><input
																								type="checkbox"
																								onclick='layer_box_chk(this.checked,"lt_c_uq129");'>개발진흥지구</label>
																						</div></li>
																					<li><div class="module">
																							<label class="lbl_list"><input
																								type="checkbox"
																								onclick='layer_box_chk(this.checked,"lt_c_uma100");'>국립공원용도지구</label>
																						</div></li>
																					<li><div class="module">
																							<label class="lbl_list"><input
																								type="checkbox"
																								onclick='layer_box_chk(this.checked,"lt_c_uq162");'>도시자연공원구역</label>
																						</div></li>
																				</ul>
																			</div>
																		</div>
																	</div>
																</li>

																<li>
																	<div class="mapsCont">
																		<div class="dv">
																			<div class="inner minus2">토지</div>
																			<div class="list sub">
																				<ul>
																					<li><div class="module">
																							<label class="lbl_list"><input
																								type="checkbox"
																								onclick='layer_box_chk(this.checked,"lt_c_adsigg");'>시군구경계도</label>
																						</div></li>
																					<li><div class="module">
																							<label class="lbl_list"><input
																								type="checkbox"
																								onclick='layer_box_chk(this.checked,"lt_c_lhzone");'>사업지구경계도</label>
																						</div></li>
																					<li><div class="module">
																							<label class="lbl_list"><input
																								type="checkbox"
																								onclick='layer_box_chk(this.checked,"lp_pa_cbnd_bonbun,lp_pa_cbnd_bubun");'>지적도</label>
																						</div></li>
																				</ul>
																			</div>
																		</div>
																	</div>
																</li>

																<li>
																	<div class="mapsCont">
																		<div class="dv">
																			<div class="inner minus2">자연공원</div>
																			<div class="list sub">
																				<ul>
																					<li><div class="module">
																							<label class="lbl_list"><input
																								type="checkbox"
																								onclick='layer_box_chk(this.checked,"lt_c_wgisnpgug");'>국립자연공원</label>
																						</div></li>
																					<li><div class="module">
																							<label class="lbl_list"><input
																								type="checkbox"
																								onclick='layer_box_chk(this.checked,"lt_c_wgisnpgun");'>군립자연공원</label>
																						</div></li>
																					<li><div class="module">
																							<label class="lbl_list"><input
																								type="checkbox"
																								onclick='layer_box_chk(this.checked,"lt_c_wgisnpdo");'>도립자연공원</label>
																						</div></li>
																				</ul>
																			</div>
																		</div>
																	</div>
																</li>

																<%-- <li>
												<div class="mapsCont">
													<div class="dv">
														<div class="inner minus2">지존 레이어</div>
														<div class="list sub">
															<ul>
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">개발정보 레이어 (폴리곤)</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">투자정보 레이어 (포인트)</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">보상전례 레이어 (포인트)</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
															</ul>
														</div>
													</div>
												</div>
											</li> --%>
															</ul>
														</div>
													</div>
													<div id="mCSB_3_scrollbar_vertical"
														class="mCSB_scrollTools mCSB_3_scrollbar mCS-dark-1 mCSB_scrollTools_vertical"
														style="display: block;">
														<div class="mCSB_draggerContainer">
															<div id="mCSB_3_dragger_vertical" class="mCSB_dragger"
																style="position: absolute; min-height: 30px; top: 0px; display: block; height: 423px; max-height: 555px;">
																<div class="mCSB_dragger_bar" style="line-height: 30px;"></div>
															</div>
															<div class="mCSB_draggerRail"></div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!-- tab -->
								<!-- <div id="notice">
									<strong>최근 열람사업</strong>
									<div id="recClickDevInfo" class="noticeList">
										<ul>
											<li class="notice-text"><a href="#">장기미집행 도시계획시설(노원
													중로1-391호선) </a></li>
											<li class="notice-text"><a href="#">[토지보상 완료]마곡
													도시개발사업</a></li>
											<li class="notice-text"><a href="#">남부순환로 - 봉오대로
													삼거리간 도로개설공사</a></li>
											<li class="notice-text"><a href="#">헌인마을 도시개발사업 </a></li>
										</ul>
									</div>
								</div> -->
								<!-- 검색결과 -->
								<div id="searchResult">
									<div class="searchResult__index">
										<strong>검색된 개발정보</strong>
										<div class="form">
											<!-- <select class="design-select gray-select small-select"
										id="numberType" onchange="goSearct_number()" title="검색조건">
									</select> -->
											<span id="devInfoTotalCount"></span>건
										</div>
										<button type="button" class="close">
											<span aria-hidden="true">닫기</span>
										</button>
									</div>
									<div class="searchResult__obj devInfoSR">
										<div id="devInfoCntList"></div>
										
									</div>
									<!-- <div id="devInfoListPagination"></div> -->
									<!-- Paging : S -->
									<!-- <div class="pagination-inner">
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
							</div> -->
									<!-- Paging : E -->
								</div>
								<!-- 검색결과 -->

								<!-- 투자 정보 검색결과 시작-->
								<div class="searchResult" id="invtSearchResult">
									<div class="searchResult__index">
										<strong>검색된 투자정보</strong>
										<div class="form">
											<select class="design-select gray-select small-select"
												id="numberType" onchange="goSearct_number()" title="검색조건">
												<option value="">00건</option>
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
									</div>
									<!-- Paging : S -->
									<!-- 							<div id="invt_pagination_div" ></div> -->
									<!-- Paging : E -->
								</div>
								<!-- 						<button type="button" id="sideClose"><span class="skip">개발정보(관리자)</span>닫기</button> -->
								<!-- 투자 정보 검색결과 끝-->
								<form name="hform"
									action="https://www.courtauction.go.kr/RetrieveRealEstDetailInqSaList.laf"
									method="post" accept-charset="euc-kr" target="_scourtSearch">
									<input type="hidden" name="jiwonNm" value=""> <input
										type="hidden" name="saNo" value=""> <input
										type="hidden" name="maemulSer" value=""> <input
										type="hidden" name="mokmulSer" value=""> <input
										type="hidden" name="_SRCH_SRNID" value="PNO102014"> <input
										type="hidden" name="_CUR_CMD" value="InitMulSrch.laf">
									<input type="hidden" name="_CUR_SRNID" value="PNO102014">
								</form>
								<!--  법원 홈페이지로 이동 -->
							</div>

							<!-- 개발정보(관리자) -->
							<div id="sideAdmin" style="display: none;">
								<div class="inner">
									<!-- 경/공매 -->
									<div class="scroll cu">
										<!-- 경/공매 상세보기 -->
										<%@ include
											file="/WEB-INF/jsp/gzonei/invt/invtAdminInsert.jsp"%>
										<%@ include file="/WEB-INF/jsp/gzonei/invt/invtAdminList.jsp"%>
										<%@ include
											file="/WEB-INF/jsp/gzonei/invt/invtAdminDetail.jsp"%>
										<!-- 경/공매 상세보기 -->
										<!-- 개발정보 -->
										<%@ include
											file="/WEB-INF/jsp/gzonei/devlopInfo/devInfoAdminList.jsp"%>
										<%@ include
											file="/WEB-INF/jsp/gzonei/devlopInfo/devInfoAdminDtl.jsp"%>
										<%@ include
											file="/WEB-INF/jsp/gzonei/devlopInfo/devInfoAdminInsert.jsp"%>
										<!-- 개발정보 -->
										<!-- 보상전례 -->
										<%@ include
											file="/WEB-INF/jsp/gzonei/reward/rewardAdminList.jsp"%>
										<%@ include
											file="/WEB-INF/jsp/gzonei/reward/rewardAdminInsert.jsp"%>
										<%@ include
											file="/WEB-INF/jsp/gzonei/reward/rewardAdminDtl.jsp"%>
										<!-- 보상전례 -->
										<!-- 경/공매 쓰기 -->
										<div class="modal__board" style="display: none;">
											<div class="board_btm" style="padding-bottom: 15px;">
												<div class="btns_area fl_r mo_block">
													<a href="#" class="btn btn-primary btn-sm">토지이용계획​
														바로가기​</a> <a href="#" class="btn btn-secondary btn-sm">개별공시지가​
														바로가기</a>
												</div>
											</div>

											<div class="form-horizontal bucket-form">
												<div class="form-group">
													<div class="col-sm-2 control-label col-lg-2">
														<label for="select">경/공매 구분​</label>
													</div>
													<div class="col-sm-4">
														<select name="" class="form-control">
															<option value="">-- 전체 --</option>
														</select>
													</div>
													<div class="col-sm-2 control-label col-lg-2">
														<label for="select">사건번호​</label>
													</div>
													<div class="col-sm-4">
														<input type="text" id="name" name="name" title="사건번호 입력"
															class="form-control" value="">
													</div>
												</div>
												<div class="form-group">
													<div class="col-sm-2 control-label col-lg-2">
														<label for="select">지도코드​</label>
													</div>
													<div class="col-sm-3">
														<select name="" class="form-control">
															<option value="">-- 전체 --</option>
														</select>
													</div>
													<div class="col-sm-3">
														<select name="" class="form-control">
															<option value="">-- 전체 --</option>
														</select>
													</div>
												</div>
												<div class="form-group">
													<div class="col-sm-2 control-label col-lg-2">
														<label for="select">위치​</label>
													</div>
													<div class="col-sm-6">
														<input type="text" id="name" name="name" title="이름 입력"
															class="form-control" value="">
														<div class="file-button">
															<button type="button">추가</button>
															<button type="button">삭제</button>
														</div>
													</div>
												</div>
												<div class="form-group">
													<div class="col-sm-2 control-label col-lg-2">
														<label for="select">지목용도​</label>
													</div>
													<div class="col-sm-4">
														<select name="" class="form-control">
															<option value="">-- 전체 --</option>
														</select>
													</div>
													<div class="col-sm-2 control-label col-lg-2">
														<label for="select">감정평가금액​</label>
													</div>
													<div class="col-sm-4">
														<input type="text" id="name" name="name" title="사건번호 입력"
															class="form-control" value="">
													</div>
												</div>
												<div class="form-group">
													<div class="col-sm-2 control-label col-lg-2">
														<label for="select">특기사항<br>프리미엄<br>전용서비스​
														</label>
													</div>
													<div class="col-sm-10">
														<textarea class="form-control" id="content" name="content"
															title="내용 입력" rows="20" style="height: 100px"> </textarea>
													</div>

												</div>
												<div class="form-group">
													<div class="col-sm-2 control-label">
														<label for="select">공개여부</label>
													</div>
													<div class="col-sm-4">
														<input class="radio-input" type="radio" id="radio1">
														<label class="radio-inline" for="radio1">예</label> <input
															class="radio-input" type="radio" id="radio2"> <label
															class="radio-inline" for="radio2">아니요</label>
													</div>
													<div class="col-sm-2 control-label">
														<label for="select">샘플보기여부</label>
													</div>
													<div class="col-sm-4">
														<input class="radio-input" type="radio" id="radio3">
														<label class="radio-inline" for="radio3">예</label> <input
															class="radio-input" type="radio" id="radio4"> <label
															class="radio-inline" for="radio4">아니요</label>
													</div>
												</div>
												<div class="form-group">
													<div class="col-sm-2 control-label">
														<label for="select">보상여부</label>
													</div>
													<div class="col-sm-10">
														<input class="radio-input" type="radio" id="radio1">
														<label class="radio-inline" for="radio1">보상중</label> <input
															class="radio-input" type="radio" id="radio2"> <label
															class="radio-inline" for="radio2">보상예정</label> <input
															class="radio-input" type="radio" id="radio3"> <label
															class="radio-inline" for="radio3">보상취소</label> <input
															class="radio-input" type="radio" id="radio4"> <label
															class="radio-inline" for="radio4">환지</label> <input
															class="radio-input" type="radio" id="radio5"> <label
															class="radio-inline" for="radio5">기타</label>
													</div>
												</div>
												<div class="form-group">
													<div class="col-sm-2 control-label col-lg-2">
														<label for="select">첨부파일</label>
													</div>
													<div class="col-sm-5">
														<div class="form-upload">
															<div class="file-form-group">
																<div class="form-group__upload">
																	<input type="text" readonly="readonly"
																		class="form-control disabled" title="1번째 파일명">
																	<input type="file" name="file_1" id="atchmn_1"
																		class="form-upload__file--hidden">
																</div>
																<div class="form-input__addon">
																	<label for="atchmn_1" class="btn btn-sm btn-secondary"
																		data-button="upload"><span class="skip">1번째
																	</span>파일첨부하기</label>
																</div>
															</div>
															<!--
						    	 	<div class="file-form-group">
						    	 		<div class="form-group__upload">
						    	 			<input type="text" readonly="readonly" class="form-control disabled" title="1번째 파일명">
						    	 			<input type="file" name="file_1" id="atchmn_1" class="form-upload__file--hidden">
						    	 		</div>
						    	 		<div class="form-input__addon">
			                                <label for="atchmn_1" class="btn btn-sm btn-secondary" data-button="upload"><span class="skip">2번째 </span>파일선택</label>
			                           </div>
						    	 	</div>
						    	 	-->
															<div class="file-button">
																<button type="button">추가</button>
																<button type="button">삭제</button>
															</div>
														</div>
													</div>
												</div>
												<div class="board_btm">
													<div class="btns_area fl_r mo_block">
														<a href="#" class="btn btn-default">등록</a>
													</div>
												</div>
											</div>
											<!-- 경/공매 쓰기 -->
											<!-- 경/공매 리스트 -->
											<form id="invtAdminSearchForm" name="bbsNttSearchForm"
												method="get" action="/">
												<fieldset>
													<legend>검색</legend>
													<div class="search">
														<!-- 01. item -->
														<div class="item form-item">
															<div class="form-group form-group1">
																<span class="tit">구분</span>
																<div class="search-inner text-left">
																	<div class="search--select">
																		<span> <select name="">
																				<option value="">-- 전체 --</option>
																		</select>
																		</span>
																	</div>
																</div>
															</div>
															<div class="form-group form-group2">
																<span class="tit">법원</span>
																<div class="search-inner text-left">
																	<div class="search--select">
																		<span> <select name="">
																				<option value="">-- 전체 --</option>
																		</select>
																		</span> <span> <select name="">
																				<option value="">-- 전체 --</option>
																		</select>
																		</span>
																	</div>
																</div>
															</div>
														</div>
														<!-- 01. item ::E -->
														<!-- 01. item -->
														<div class="item form-item">
															<div class="form-group form-group1">
																<span class="tit">입찰시작일</span>
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
																</div>
															</div>
															<div class="form-group form-group2">
																<span class="tit">입찰종료일</span>
																<div class="search-inner text-left">
																	<div class="search--calendar">
																		<span> <input type="text" class="form-control"
																			name="endDate" id="endDate" placeholder="종료일"
																			value="" title="종료일 입력">
																			<button type="button" class="btn__calendar">
																				<span class="skip">달력선택</span>
																			</button>
																		</span>
																	</div>
																</div>
															</div>
														</div>
														<!-- 01. item ::E -->
														<!-- 01. item -->
														<div class="item form-item">
															<div class="form-group form-group1">
																<span class="tit">경매사건번호</span>
																<div class="search-inner text-left">
																	<div class="search--select">
																		<span> <select name="">
																				<option value="">-- 전체 --</option>
																		</select>
																		</span>
																	</div>
																</div>
															</div>
															<div class="form-group form-group2">
																<span class="tit">지역</span>
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
																<span class="tit">구분</span>
																<div class="search-inner text-left">
																	<label class="checkbox-inline" for="id1"> <input
																		type="checkbox" id="id1" name="">전체
																	</label> <label class="checkbox-inline" for="id2"> <input
																		type="checkbox" id="id2" name="">주거시설
																	</label> <label class="checkbox-inline" for="id3"> <input
																		type="checkbox" id="id3" name="">업무및상업시설
																	</label> <label class="checkbox-inline" for="id4"> <input
																		type="checkbox" id="id4" name="">토지
																	</label> <label class="checkbox-inline" for="id5"> <input
																		type="checkbox" id="id5" name="">공업시설
																	</label> <label class="checkbox-inline" for="id6"> <input
																		type="checkbox" id="id6" name="">동산및권리권
																	</label>
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
											<link rel="stylesheet"
												href="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/jQueryDatepicker/jquery.datetimepicker.min.css' />">
											<script
												src="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/jQueryDatepicker/jquery.datetimepicker.full.min.js' />"></script>
											<script>
												$(document).ready(
																function() {
																	$.datetimepicker.setLocale('ko');
																	$("#startDate,#endDate,#startDate3,#endDate3,#startDateInvAd,#endDateInvAd")
																			.datetimepicker(
																					{
																						timepicker : false,
																						format : 'Y-m-d',
																						scrollMonth : false,
																						scrollInput : false,
																						validateOnBlur: false
																					}).on('keydown', function(event){
																						onlyNum(this,event);
																						});
																});
											</script>
											<!-- List : S -->
										</div>
										<div id="invtSrchList" class="board-list">
											<strong class="title">투자정보 리스트</strong>
											<button type="button" class="SideOff" id="invtSideOff">
												<span>닫기</span>
											</button>
											<label style="cursor: default">총 <span
												id="total-count"></span> 건
											</label>
											<div id="invtListItem" class="box-list all__list"></div>
											<div id="invInfoListPagination"></div>
											<!-- Paging : E -->
											<!-- 경/공매 리스트 -->


										</div>
										<!-- 보상전례 시작 -->
										<div class="scroll" style="display: none">
											<!-- 보상전례 쓰기 -->
											<strong class="title">보상전례</strong>
											<div class="modal__board">
												<div class="board_btm" style="padding-bottom: 15px">
													<div class="btns_area fl_r mo_block">
														<a href="#" class="btn btn-primary btn-sm">토지이용계획​
															바로가기​</a> <a href="#" class="btn btn-secondary btn-sm">개별공시지가​
															바로가기</a>
													</div>
												</div>

												<div class="form-horizontal bucket-form">
													<div class="form-group">
														<div class="col-sm-2 control-label col-lg-2">
															<label for="select">사업지구명​</label>
														</div>
														<div class="col-sm-4">
															<input type="text" id="name" name="name" title="이름 입력"
																class="form-control" value="">
														</div>
													</div>
													<div class="form-group">
														<div class="col-sm-2 control-label col-lg-2">
															<label for="select">주소​</label>
														</div>
														<div class="col-sm-10">
															<input type="text" id="name" name="name" title="이름 입력"
																class="form-control" value="">
														</div>
													</div>
													<div class="form-group">
														<div class="col-sm-2 control-label col-lg-2">
															<label for="select">협의)보상가(/㎡)​</label>
														</div>
														<div class="col-sm-4">
															<in put type="text" id="name" name="name" title="이름 입력"
																class="form-control" value="">
														</div>
														<div class="col-sm-2 control-label col-lg-2">
															<label for="select">지목​</label>
														</div>
														<div class="col-sm-4">
															<in put type="text" id="name" name="name" title="이름 입력"
																class="form-control" value="">
														</div>
													</div>
													<div class="form-group">
														<div class="col-sm-2 control-label col-lg-2">
															<label for="select">가격시점​​</label>
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
														<div class="col-sm-2 control-label col-lg-2">
															<label for="select">개별지가(/㎡)​​​</label>
														</div>
														<div class="col-sm-4">
															<input type="text" id="name" name="name" title="이름 입력"
																class="form-control" value="">
														</div>
													</div>
												</div>
												<div class="board_btm">
													<div class="btns_area fl_r mo_block">
														<a href="#" class="btn btn-default">등록</a>
													</div>
												</div>
											</div>
											<!-- 보상전례 쓰기 -->
											<!-- 보상전례 리스트 -->
											<form name="bbsNttSearchForm" method="get" action="/">
												<fieldset>
													<legend>검색</legend>
													<div class="search">
														<!-- 01. item -->
														<div class="item form-item">
															<div class="form-group form-group1">
																<span class="tit">입찰시작일</span>
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
																			name="endDate" id="endDate" placeholder="종료일"
																			value="" title="종료일 입력">
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
																		</span> <span> <select name="">
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
											<div class="board_btm"
												style="border-top: none; border-bottom: 1px solid #ddd; padding-bottom: 50px; margin-top: -50px;">
												<div class="btns_area fl_r mo_block">
													<a href="#" class="btn btn-primary">토지이용계획​ 바로가기​</a> <a
														href="#" class="btn btn-secondary">개별공시지가​ 바로가기</a>
												</div>
											</div>
											<div class="table-list">
												<table>
													<colgroup>
														<col style="width: 15%">
														<col style="width: auto">
														<col style="width: 15%">
														<col style="width: 15%">
														<col style="width: 15%">
														<col style="width: 15%">
													</colgroup>
													<thead>
														<th>사업지구명</th>
														<th>주소</th>
														<th>(협의)보상가(㎡)</th>
														<th>지목</th>
														<th>가격시점</th>
														<th>가격시점개별지가(㎡)</th>
													</thead>
													<tbody>
														<tr>
															<td class="atchFileId"><span class="td__num">사업지구명</span></td>
															<td class="subject"><a href="#view">고등 취락지구
																	정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)</a></td>
															<td class="writer">보상가</td>
															<td class="writer">보상가</td>
															<td class="regDate"><span class="td__date">2021-03-15</span></td>
															<td class="writer">가격시점개별지가</td>
														</tr>
														<tr class="notr">
															<td class="none" colspan="5"></td>
														</tr>
													</tbody>
												</table>
											</div>
											<!-- List : E -->
											<!-- Paging : S -->
											<div class="pagination-inner">
												<ul class="pagination">
													<li class="page-item"><a class="page-link"
														aria-label="first" href="#"> <span aria-hidden="true"><<</span>
															<span class="sr-only">첫번째페이지</span>
													</a></li>
													<li class="page-item"><a class="page-link"
														aria-label="Previous" href="#"> <span
															aria-hidden="true"><</span> <span class="sr-only">이전페이지</span>
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
														aria-label="Next" href="#"> <span aria-hidden="true">></span>
															<span class="sr-only">다음페이지</span>
													</a></li>
													<li class="page-item"><a class="page-link"
														aria-label="last" href="#"> <span aria-hidden="true">>></span>
															<span class="sr-only">마지막페이지</span>
													</a></li>
												</ul>
												<div class="button-group">
													<a href="#" class="btn btn-default">등록</a>
												</div>
											</div>
											<!-- Paging : E -->


										</div>
									</div>
									<!-- 보상전례 끝 -->
									<!-- 									<button type="button" id="sideClose"> -->
									<!-- 										<span class="skip">개발정보(관리자)</span>닫기 -->
									</button>
									<a id="sideAdminTg" class="side_toggle"
										style="cursor: pointer;">사이드토글</a>
								</div>
								<!-- 개발정보(관리자) -->
							</div>



						</div>
					</div>

					<!-- 경/공매 ::S -->

					<div class="modal fade" role="dialog" data-ly-type="content"
						data-ly-target="board__reward">
						<div>
							<!-- Modal content-->
							<div>

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
												<a href="#" class="btn btn-primary btn-sm">토지이용계획​ 바로가기​</a>
												<a href="#" class="btn btn-secondary btn-sm">개별공시지가​
													바로가기</a>
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
													aria-label="Previous" href="#"> <span
														aria-hidden="true">&lt;</span> <span class="sr-only">이전페이지</span>
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
						<div>
							<!-- Modal content-->
							<div>
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
					<form name="onbidMgrNoSearch_2021"
						action="https://www.onbid.co.kr/op/cta/cltrdtl/collateralDetailRealEstateList.do"
						target="_onbidSearch">
						<input type="hidden" value="" name="searchCltrMnmtNo">
					</form>



					<!-- 투자정보 물건보기 상세보기 ::E -->
					<%@ include file="/WEB-INF/jsp/gzonei/devlopInfo/devInfoDtl.jsp"%>
					<%@ include
						file="/WEB-INF/jsp/gzonei/invt/invDevlopInsertModal.jsp"%>
					<%@ include
						file="/WEB-INF/jsp/gzonei/reward/rewardDevlopInsertModal.jsp"%>

					<!-- 개발 완료시 삭제 ::S  -->
					<!-- 개발 완료시 삭제  ::E  -->
					<!-- content 영역입니다. -->
				</div>
			</div>
		</div>
		<!-- layout -->
	</div>

	<!-- 구현부 : E -->
</body>
<script>
	$(document).ready(
					function() {
						//관심정보에서 map.do 로 넘어올때 devlopInfoSn값이 있으면 devInfoDtl을 실행
						var devlopInfoSn = '${devlopInfoSn}';
						if (devlopInfoSn != '') {
							devInfoDtl(devlopInfoSn, 'from');
						}

						//메인에서 개발/투자 선택하면 해당 Tab을 활성화
						var tabId = '${tabId}';
						if (tabId != '') {
							//기존 on 클래스를 지우고
							$('#searchFormTab li[class="link-tab on"]')
									.removeClass('on');
							$('#searchFormTab div[class="obj on"]')
									.removeClass('on');
							;
							//해당 Tab에 on 클래스 추가
							switch (tabId) {
							//개발정보
							case 'dev':
								$('#searchFormTab a[id="tab1"]').parents(
										'.link-tab').addClass('on');
								$('#searchFormTab div[id="tab-panel1"]')
										.addClass('on');
								break;
							//투자정보
							case 'invt':
								$('#searchFormTab a[id="tab2"]').parents(
										'.link-tab').addClass('on');
								$('#searchFormTab div[id="tab-panel2"]')
										.addClass('on');
								document.getElementById("more1").getElementsByTagName('button')[0].click();
								$("#startDate3").val(getFormatDate(new Date()));
								$("#endDate3").val(getFormatDate2(new Date()));
								if(checkAuth("ivt001001", "infoInqireAt","")){ // 검색권환
									invListSearch();
								}
								break;
							//그 외
							default:
								break;
							}
						}
					});

	function enterkey() {
		if (window.event.keyCode == 13) { //javascript에서는 13이 enter키를 의미함 
			$("#searchSubmit").click();
			// 		$('#searchResult').css("display","block");
			// 		search();
		}
	}
	function adDevListEnterkey() {
		if (window.event.keyCode == 13) { //javascript에서는 13이 enter키를 의미함 
			$("#devInfoAdminSchBtn").click();
		}
	}
	function adInvListEnterkey() {
		if (window.event.keyCode == 13) { //javascript에서는 13이 enter키를 의미함 
			invAdmListSearch();
		}
	}
</script>
<div class="wrap-loading">
	<div>
		<%-- 		<img src="<c:url value='/css/gzonei/SRC/images/map/loadingBar.gif' />" alt=""> --%>
	</div>
</div>
</html>