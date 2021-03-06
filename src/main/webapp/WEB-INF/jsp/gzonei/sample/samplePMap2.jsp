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
</head>
<body>
	<%@ include file="/WEB-INF/jsp/gzonei/layout/top.jsp"%>

	<!-- 구현부 : S -->
<div id="body_layout" class="map">
    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
            <div id="txt">
            <!-- content 영역입니다. -->
			<div id="app">
			
		<div id="totalWrap">
			<div id="map"></div>
			<div id="mapTabs">
				<button type="button" class="on mapir naver" data-map="naver"><span>네이버맵</span></button>
				<button type="button" class="mapir kakao" data-map="kakao"><span>카카오맵</span></button>
				<button type="button" class="mapir google"  data-map="google"><span>구글맵</span></button>
			</div>
			<div id="iconSort">
				<button type="button" class="on all" data-sort="all"><span>전체</span></button>
				<button type="button" class="sort1" data-sort="1"><span>보상전례</span></button>
				<button type="button" class="sort2" data-sort="2"><span>투자정보</span></button>
				<button type="button" class="sort3"  data-sort="3"><span>개발정보</span></button>
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
							<label for="searchKeyword" class="skip">검색어 입력</label>
							<input type="text" v-model="searchKeyword" id="searchKeyword" name="searchKeyword" paceholder="검색어를 입력하세요">
							<button id="searchSubmit" class="mapir">검색하기</button>
							<button id="naverLocationApi" class="mapLocationApi mapir">현 지도 내 장소검색</button>
							<button id="kakaoLocationApi" class="mapLocationApi mapir">현 지도 내 장소검색</button>
							<button id="googleLocationApi" class="mapLocationApi mapir">현 지도 내 장소검색</button>
						</fieldset>
					</form>
					<div id="keyword">
						<em>추천검색어</em>
						<div class="grap">
							<a href="#">추천검색어</a>
							<a href="#">세종시반곡동</a>
							<a href="#">신안산선</a>
						</div>
					</div>
				</div>
				<!-- tab -->
				<div id="searchFormTab" class="ui-tablist">
					<ul class="tab-ul" role="tablist">
	                    <li role="presentation" class="link-tab"><a role="tab" id="tab1" aria-controls="tab-panel1" href="#tab-panel1" tabindex="0" aria-selected="true" title="열림">투자정보</a></li>
	                    <li role="presentation" class="link-tab on"><a role="tab" id="tab2" aria-controls="tab-panel2" href="#tab-panel2">보상편입</a></li>
	                </ul>
	                <div class="tabpanel_box">
		               <div class="obj" id="tab-panel1" role="tabpanel" aria-labelledby="tab1">
		                    <strong class="skip">투자정보 검색</strong>
		                    <div class="scrollbar">
				             	<div class="mapSearch__area">
				                     <div class="form-group">
					                     <div class="control-label"><label for="">지역</label></div>
									    <div class="col-sm-4">
										    <select id="gubun_a" name="gubun_a" class="form-control" title="시도 선택" required="">
										    	<option value="">시도</option>
										    	<option value="A">시도</option>
										    </select>
									    </div>
									    <div class="col-sm-4">
										    <select id="gubun_b" name="gubun_b" class="form-control" title="시군구 선택">
										    	<option value="">시군구</option>
										    	<option value="A">시군구</option>
										    </select>
									    </div>
									    <div class="col-sm-4">
										    <select id="gubun_c" name="gubun_c" class="form-control" title="읍면동 선택">
										    	<option value="">읍면동</option>
										    	<option value="A">읍면동</option>
										    </select>
									    </div>
									</div>
									
									<!-- 상세검색 -->
									<div class="mapSearch__biz" style="display:none;">
					                     <div class="form-group">
						                     <div class="control-label"><label for="">협의보상시점</label></div>
										    <div class="col-sm-6">
											    <span>보상시작년도</span>
											    <select id="gubun_a" name="gubun_a" class="form-control" title="보상시작년도 선택" required="">
											    	<option value="">보상시작년도</option>
											    	<option value="A">보상시작년도</option>
											    </select>
										    </div>
										    <div class="col-sm-6">
											    <span>기간</span>
											    <select id="gubun_b" name="gubun_b" class="form-control" title="기간 선택">
											    	<option value="">기간</option>
											    	<option value="A">기간</option>
											    </select>
										    </div>
										</div>
					                     <div class="form-group">
						                     <div class="control-label"><label for="">협의보상상태</label></div>
										    <div class="col-sm-6">
											    <select name="gubun_a" class="form-control" title="협의보상상태 선택" required="">
											    	<option value="">협의보상상태</option>
											    	<option value="A">협의보상상태</option>
											    </select>
										    </div>
										</div>
					                     <div class="form-group">
						                     <div class="control-label"><label for="">사업지구</label></div>
										    <div class="col-sm-12">
											    <select name="gubun_a" class="form-control" title="사업지구 선택" required="">
											    	<option value="">사업지구</option>
											    	<option value="A">사업지구</option>
											    </select>
										    </div>
										</div>
					                     <div class="form-group">
						                     <div class="control-label"><label for="">개발사업명</label></div>
										    <div class="col-sm-12">
											    <input type="text" id="" name="" title="개발사업명 입력" class="form-control" value="">
										    </div>
										</div>
					                     <div class="form-group">
						                     <div class="control-label"><label for="">시행사</label></div>
										    <div class="col-sm-6">
											    <select id="gubun_a" name="gubun_a" class="form-control" title="시행사 선택" required="">
											    	<option value="">시행사</option>
											    	<option value="A">시행사</option>
											    </select>
										    </div>
										    <div class="col-sm-6">
											    <select id="gubun_b" name="gubun_b" class="form-control" title="시행사 선택">
											    	<option value="">시행사</option>
											    	<option value="A">시행사</option>
											    </select>
										    </div>
										</div>
									</div>
									<!-- 상세검색 -->
									
									
									
									
								    <div class="search--btn">
										<span class="btn--submit"><button type="button" data-id="area" class="submit">검색</button></span>
										<span class="btn--more" id="more1"><button type="button">상세검색</button></span>
									</div>
									
									
									<div class="mapAll">
										<ul>
											<li>
												<div class="mapsCont open">
													<div class="dv">
														<div class="inner minus2">국토관리/지역개발</div>
														<div class="list sub open">
															<ul>
																<li>
																	<div class="module">
																		<label class="lbl_list"><input type="checkbox" value="" checked="">도시계획(공간시설)<span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></label>
																	</div>
																</li>
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">도시계획(공공문화체육시설)</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">도시계획(방재시설)</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">도시계획(보건위생시설)</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">지구단위계획</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
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
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">단지경계</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">단지시설용지</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
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
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">하천망</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
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
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">개발진흥지구</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">국립공원용도지구</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">도시자연공원구역</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
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
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">사업지구경계도</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">지적도</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
															</ul>
														</div>
													</div>
												</div>
											</li>
											
											<li>
												<div class="mapsCont">
													<div class="dv">
														<div class="inner minus2">체육</div>
														<div class="list sub">
															<ul>
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">국립자연공원</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">군립자연공원</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">도립자연공원</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
															</ul>
														</div>
													</div>
												</div>
											</li>
											
											<li>
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
											</li>
										</ul>
									</div>
									
								</div>
								
		                     </div> 
		                </div> 
		               <div class="obj on" id="tab-panel2" role="tabpanel" aria-labelledby="tab2">
		                    <strong class="skip">보상편입 검색</strong>
		                     <div class="scrollbar">
				             	<div class="mapSearch__area">
				                     <div class="form-group">
					                    <div class="control-label"><label for="">지역</label></div>
									    <div class="col-sm-4">
										    <select id="gubun_a" name="gubun_a" class="form-control" title="시도 선택" required="">
										    	<option value="">시도</option>
										    	<option value="A">시도</option>
										    </select>
									    </div>
									    <div class="col-sm-4">
										    <select id="gubun_b" name="gubun_b" class="form-control" title="시군구 선택">
										    	<option value="">시군구</option>
										    	<option value="A">시군구</option>
										    </select>
									    </div>
									    <div class="col-sm-4">
										    <select id="gubun_c" name="gubun_c" class="form-control" title="읍면동 선택">
										    	<option value="">읍면동</option>
										    	<option value="A">읍면동</option>
										    </select>
									    </div>
									</div>
									
									<!-- 상세검색 -->
									<div class="mapSearch__biz" style="display:none;">
										
										 <div class="form-group">
						                     <div class="control-label"><label for="">개발사업지구</label></div>
										    <div class="col-sm-3">
											    <select id="gubun_a" name="gubun_a" class="form-control" title="보상시작년도 선택" required="">
											    	<option value="">보상시작년도</option>
											    	<option value="A">보상시작년도</option>
											    </select>
										    </div>
										    <div class="col-sm-3">
											    <select id="gubun_b" name="gubun_b" class="form-control" title="기간 선택">
											    	<option value="">기간</option>
											    	<option value="A">기간</option>
											    </select>
										    </div>
										    <div class="col-sm-3">
											    <select id="gubun_b" name="gubun_b" class="form-control" title="기간 선택">
											    	<option value="">기간</option>
											    	<option value="A">기간</option>
											    </select>
										    </div>
										    <div class="col-sm-3">
											    <select id="gubun_b" name="gubun_b" class="form-control" title="기간 선택">
											    	<option value="">기간</option>
											    	<option value="A">기간</option>
											    </select>
										    </div>
										</div>
										
					                     <div class="form-group">
						                     <div class="control-label"><label for="">입찰일</label></div>
										    <div class="col-sm-6">
											    <div class="search--calendar">
													<span>
														<input type="text" class="form-control" name="startDate" id="startDate" placeholder="시작일" value="" title="시작일 입력">
														<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
													</span>
												</div>
										    </div>
										    <div class="col-sm-6">
											    <div class="search--calendar">
													<span>
														<input type="text" class="form-control" name="endDate" id="endDate" placeholder="종료일" value="" title="종료일 입력">
				                                    <button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
													</span>
												</div>
										    </div>
										</div>
										<div class="form-group">
						                     <div class="control-label"><label for="">구분</label></div>
						                     <div class="col-sm-3">
							                    <span>카테고리</span>
											    <select id="gubun_a" name="gubun_a" class="form-control" title="시행사 선택" required="">
											    	<option value="">경매</option>
											    	<option value="A">공매</option>
											    </select>
										    </div>
						                     <div class="col-sm-4">
							                     <span>경매사건번호</span>
											    <select id="gubun_a" name="gubun_a" class="form-control" title="시행사 선택" required="">
											    	<option value="">시행사</option>
											    	<option value="A">시행사</option>
											    </select>
										    </div>
										    <div class="col-sm-5">
							                     <span>타경</span>
											    <input type="text" id="" name="" title="개발사업명 입력" class="form-control" value="">
										    </div>
										</div>
					                     <div class="form-group">
						                    <div class="control-label"><label for="">보상상태</label></div>
										    <div class="col-sm-12">
											     <input class="checkbox-input" type="checkbox" id="checkbox1" name="" title="경매" value="a">
											     <label class="checkbox-inline" for="checkbox1">보상중</label>
											     <input class="checkbox-input" type="checkbox" id="checkbox2" name="" title="공매" value="a">
											     <label class="checkbox-inline" for="checkbox2">보상예정</label>
										    </div>
										</div>    
										  <div class="form-group"> 
											<div class="control-label"><label for="">사업방식</label></div>  
										    <div class="col-sm-12">
											     <input class="checkbox-input" type="checkbox" id="checkbox3" name="" title="경매" value="a">
											     <label class="checkbox-inline" for="checkbox3">수용 및 사용</label>
											     <input class="checkbox-input" type="checkbox" id="checkbox4" name="" title="공매" value="a">
											     <label class="checkbox-inline" for="checkbox4">환지</label>
											     <input class="checkbox-input" type="checkbox" id="checkbox5" name="" title="경매" value="a">
											     <label class="checkbox-inline" for="checkbox5">수용 및 사용 + 환지</label>
											     <input class="checkbox-input" type="checkbox" id="checkbox6" name="" title="공매" value="a">
											     <label class="checkbox-inline" for="checkbox6">기타</label>

										    </div>
										</div>
									</div>
									<!-- 상세검색 -->
								    <div class="search--btn">
										<span class="btn--submit"><button type="button" data-id="area" class="submit">검색</button></span>
										<span class="btn--more" id="more1"><button type="button">상세검색</button></span>
									</div>
									
									<div class="mapAll">
										<ul>
											<li>
												<div class="mapsCont open">
													<div class="dv">
														<div class="inner minus2">국토관리/지역개발</div>
														<div class="list sub open">
															<ul>
																<li>
																	<div class="module">
																		<label class="lbl_list"><input type="checkbox" value="" checked="">도시계획(공간시설)</label>
																	</div>
																</li>
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">도시계획(공공문화체육시설)</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">도시계획(방재시설)</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">도시계획(보건위생시설)</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">지구단위계획</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
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
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">단지경계</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">단지시설용지</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
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
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">하천망</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
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
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">개발진흥지구</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">국립공원용도지구</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">도시자연공원구역</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
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
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">사업지구경계도</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">지적도</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
															</ul>
														</div>
													</div>
												</div>
											</li>
											
											<li>
												<div class="mapsCont">
													<div class="dv">
														<div class="inner minus2">체육</div>
														<div class="list sub">
															<ul>
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">국립자연공원</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">군립자연공원</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
																<li><div class="module"><label class="lbl_list"><input type="checkbox" value="">도립자연공원</label><span class="tooltip"data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>범례내용</p>" >범례</span></div></li>
															</ul>
														</div>
													</div>
												</div>
											</li>
											
											<li>
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
											</li>
										</ul>
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
			                <li class="notice-text"><a href="#">장기미집행 도시계획시설(노원 중로1-391호선) </a></li>
			                <li class="notice-text"><a href="#">[토지보상 완료]마곡 도시개발사업</a></li>
			                <li class="notice-text"><a href="#">남부순환로 - 봉오대로 삼거리간 도로개설공사</a></li>
			                <li class="notice-text"><a href="#">헌인마을 도시개발사업 </a></li>
			            </ul>
			        </div>
			    </div>
				<!-- 검색결과 -->
				<div id="searchResult">
					<div class="searchResult__index">
						<strong><em>경기도</em>관련된 개발정보</strong>
						<div class="form">
							<select class="design-select gray-select small-select" id="numberType" onchange="goSearct_number()" title="검색조건">
								<option value="">15건</option>
							</select>
						</div>
						<button type="button" class="close"><span aria-hidden="true">닫기</span></button>
					</div>
					
					<div class="searchResult__obj">
						<div class="item">
							<button class="link on">
								<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong>
								<span>71,808㎡(21,722평)</span>
								<span>SH공사</span>
								<i>자세히보기</i>
							</button>
						</div>
						<div class="item">
							<button class="link">
								<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong>
								<span>71,808㎡(21,722평)</span>
								<span>SH공사</span>
								<i>자세히보기</i>
							</button>
						</div>
						<div class="item">
							<button class="link">
								<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong>
								<span>71,808㎡(21,722평)</span>
								<span>SH공사</span>
								<i>자세히보기</i>
							</button>
						</div>
						<div class="item">
							<button class="link">
								<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong>
								<span>71,808㎡(21,722평)</span>
								<span>SH공사</span>
								<i>자세히보기</i>
							</button>
						</div>
						<div class="item">
							<button class="link">
								<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong>
								<span>71,808㎡(21,722평)</span>
								<span>SH공사</span>
								<i>자세히보기</i>
							</button>
						</div>
						<div class="item">
							<button class="link">
								<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong>
								<span>71,808㎡(21,722평)</span>
								<span>SH공사</span>
								<i>자세히보기</i>
							</button>
						</div>
						<div class="item">
							<button class="link">
								<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong>
								<span>71,808㎡(21,722평)</span>
								<span>SH공사</span>
								<i>자세히보기</i>
							</button>
						</div>
						<div class="item">
							<button class="link">
								<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong>
								<span>71,808㎡(21,722평)</span>
								<span>SH공사</span>
								<i>자세히보기</i>
							</button>
						</div>
						<div class="item">
							<button class="link">
								<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong>
								<span>71,808㎡(21,722평)</span>
								<span>SH공사</span>
								<i>자세히보기</i>
							</button>
						</div>
						<div class="item">
							<button class="link">
								<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong>
								<span>71,808㎡(21,722평)</span>
								<span>SH공사</span>
								<i>자세히보기</i>
							</button>
						</div>
						<div class="item">
							<button class="link">
								<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong>
								<span>71,808㎡(21,722평)</span>
								<span>SH공사</span>
								<i>자세히보기</i>
							</button>
						</div>
						<div class="item">
							<button class="link">
								<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong>
								<span>71,808㎡(21,722평)</span>
								<span>SH공사</span>
								<i>자세히보기</i>
							</button>
						</div>
						<div class="item">
							<button class="link">
								<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong>
								<span>71,808㎡(21,722평)</span>
								<span>SH공사</span>
								<i>자세히보기</i>
							</button>
						</div>
						<div class="item">
							<button class="link">
								<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong>
								<span>71,808㎡(21,722평)</span>
								<span>SH공사</span>
								<i>자세히보기</i>
							</button>
						</div>
						<div class="item">
							<button class="link">
								<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong>
								<span>71,808㎡(21,722평)</span>
								<span>SH공사</span>
								<i>자세히보기</i>
							</button>
						</div>
					</div>
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
	                </div>
					<!-- Paging : E -->
				</div>
				<!-- 검색결과 -->
			</div>
			<!-- 개발정보(관리자) -->
			<div id="sideAdmin">
				<div class="inner">
					<!-- 경/공매 -->
					<div class="scroll">
				<strong class="title">경/공매</strong>
				<!-- 경/공매 상세보기 -->
				 <div class="fileArea" style="border-bottom:1px solid #ddd">
					<p>
						<a href="#">2021년 융합의학기술원 연구과제 공모사업 시행 계획(안).hwp</a>
						<span class="file_vol">1.50KB </span>
					</p>
					<p>
						<a href="#">2021년 융합의학기술원 연구과제 공모사업 시행 계획(안).hwp</a>
						<span class="file_vol">1.50KB </span>
					</p>
				</div>
				<div class="top_head">
				  	<h3 class="h3">지번별(용도) 목록</h3>
				  	<button type="button" class="btn btn-primary btn-sm" onclick="formAdd()">추가</button>
                 </div>
				<div class="table-scroll">
					<table class="table table-bordered text-center">
						<caption>테이블 안내 – 구분, 부서/직위, 성명, 연락처, 홈페이지 정보 제공</caption>
						<colgroup>
							<col style="width:12%">
							<col style="width:10%">
							<col style="width:10%">
							
							<col style="width:auto">
							<col style="width:10%">
							<col style="width:10%">
							<col style="width:10%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">일련번호</th>
								<th scope="col">구분</th>
								<th scope="col">지번</th>
								<th scope="col">지목</th>
								<th scope="col">이용현황</th>
								<th scope="col">용도지역</th>
								<th scope="col">면적</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th scope="row">일련번호</th>
								<td>구분</td>
								<td>지번</td>
								<td>지목</td>
								<td>이용현황</td>
								<td>용도지역</td>
								<td>면적</td>
							</tr>
							<tr>
								<th scope="row">일련번호</th>
								<td>구분</td>
								<td>지번</td>
								<td>지목</td>
								<td>이용현황</td>
								<td>용도지역</td>
								<td>면적</td>
							</tr>
							<tr>
								<th scope="row">일련번호</th>
								<td>구분</td>
								<td>지번</td>
								<td>지목</td>
								<td>이용현황</td>
								<td>용도지역</td>
								<td>면적</td>
							</tr>
							<tr>
								<th scope="row">일련번호</th>
								<td>구분</td>
								<td>지번</td>
								<td>지목</td>
								<td>이용현황</td>
								<td>용도지역</td>
								<td>면적</td>
							</tr>
							<tr>
								<th scope="row">일련번호</th>
								<td>구분</td>
								<td>지번</td>
								<td>지목</td>
								<td>이용현황</td>
								<td>용도지역</td>
								<td>면적</td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="top_head">
				  	<h3 class="h3">진행내역 목록</h3>
				  	<button type="button" class="btn btn-primary btn-sm" onclick="formAdd()">추가</button>
                </div>
				<div class="table-scroll">
					<table class="table table-bordered text-center">
						<caption>테이블 안내 – 구분, 부서/직위, 성명, 연락처, 홈페이지 정보 제공</caption>
						<colgroup>
							<col style="width:12%">
							<col style="width:10%">
							<col style="width:10%">
							
							<col style="width:auto">
							<col style="width:10%">
							<col style="width:10%">
							<col style="width:10%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">일련번호</th>
								<th scope="col">법원명</th>
								<th scope="col">입찰일자</th>
								<th scope="col">진행결과</th>
								<th scope="col">입찰금액</th>
								<th scope="col">낙찰금액</th>
								<th scope="col">등록자ID</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th scope="row">일련번호</th>
								<td>법원명</td>
								<td>입찰일자</td>
								<td>진행결과</td>
								<td>입찰금액</td>
								<td>낙찰금액</td>
								<td>등록자ID</td>
							</tr>
							<tr>
								<th scope="row">일련번호</th>
								<td>법원명</td>
								<td>입찰일자</td>
								<td>진행결과</td>
								<td>입찰금액</td>
								<td>낙찰금액</td>
								<td>등록자ID</td>
							</tr>
							<tr>
								<th scope="row">일련번호</th>
								<td>법원명</td>
								<td>입찰일자</td>
								<td>진행결과</td>
								<td>입찰금액</td>
								<td>낙찰금액</td>
								<td>등록자ID</td>
							</tr>
							<tr>
								<th scope="row">일련번호</th>
								<td>법원명</td>
								<td>입찰일자</td>
								<td>진행결과</td>
								<td>입찰금액</td>
								<td>낙찰금액</td>
								<td>등록자ID</td>
							</tr>
							<tr>
								<th scope="row">일련번호</th>
								<td>법원명</td>
								<td>입찰일자</td>
								<td>진행결과</td>
								<td>입찰금액</td>
								<td>낙찰금액</td>
								<td>등록자ID</td>
							</tr>
						</tbody>
					</table>
				</div>
				
				
				<div class="top_head">
				  	<h3 class="h3">진행내역 등록</h3>
                </div>
				<div class="modal__board">			               
                    <div class="form-horizontal bucket-form">
	                   <div class="form-group">
						    <div class="col-sm-2 control-label col-lg-2"><label for="select">법원코드​</label></div>
						    <div class="col-sm-4">
						    	<select name="" class="form-control">
									<option value="">-- 전체 --</option>
								</select>
							</div>
							
						</div> 
						<div class="form-group">
						    <div class="col-sm-2 control-label col-lg-2"><label for="select">진행결과​</label></div>
						    <div class="col-sm-4">
						    	<in	put type="text" id="name" name="name" title="이름 입력" class="form-control" value="">
							</div>	
							<div class="col-sm-2 control-label col-lg-2"><label for="select">계코드​</label></div>
						    <div class="col-sm-4">
						    	<in	put type="text" id="name" name="name" title="이름 입력" class="form-control" value="">
							</div>
						</div> 
						<div class="form-group">
						    <div class="col-sm-2 control-label col-lg-2"><label for="select">입찰금액​</label></div>
						    <div class="col-sm-4">
						    	<input type="text" id="name" name="name" title="이름 입력" class="form-control" value="">
							</div>
							<div class="col-sm-2 control-label col-lg-2"><label for="select">입찰일자​​</label></div>
						    <div class="col-sm-4">
						    	<div class="search--calendar">
									<span>
										<input type="text" class="form-control" name="startDate" id="startDate" placeholder="시작일" value="" title="시작일 입력">
										<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
									</span>
								</div>
							</div>
						</div> 
	                   <div class="form-group">
						    <div class="col-sm-2 control-label col-lg-2"><label for="select">낙찰금액​</label></div>
						    <div class="col-sm-4">
						    	<in	put type="text" id="name" name="name" title="이름 입력" class="form-control" value="">
							</div>
							<div class="col-sm-2 control-label col-lg-2"><label for="select">낙찰자 명​</label></div>
						    <div class="col-sm-4">
						    	<in	put type="text" id="name" name="name" title="이름 입력" class="form-control" value="">
							</div>
						</div> 
					</div>
                    <div class="board_btm">
                        <div class="btns_area fl_r mo_block">
                            <a href="#" class="btn btn-default">등록</a>
                        </div>
                    </div>
                </div>
                
				
				<!-- 경/공매 상세보기 -->
				<!-- 경/공매 쓰기 -->
				<div class="modal__board">
	               <div class="board_btm" style="padding-bottom:15px">
                        <div class="btns_area fl_r mo_block">
                            <a href="#" class="btn btn-primary btn-sm">토지이용계획​ 바로가기​</a>
                            <a href="#" class="btn btn-secondary btn-sm">개별공시지가​ 바로가기</a>
                        </div>
                    </div>
	               						               
                    <div class="form-horizontal bucket-form">
	                   <div class="form-group">
						    <div class="col-sm-2 control-label col-lg-2"><label for="select">경/공매 구분​</label></div>
						    <div class="col-sm-4">
						    	<select name="" class="form-control">
									<option value="">-- 전체 --</option>
								</select>
							</div>
							<div class="col-sm-2 control-label col-lg-2"><label for="select">사건번호​</label></div>
						    <div class="col-sm-4">
						    	<input type="text" id="name" name="name" title="사건번호 입력" class="form-control" value="">
							</div>
						</div> 
						<div class="form-group">
						    <div class="col-sm-2 control-label col-lg-2"><label for="select">지도코드​</label></div>
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
						    <div class="col-sm-2 control-label col-lg-2"><label for="select">위치​</label></div>
						    <div class="col-sm-6">
						    	<input type="text" id="name" name="name" title="이름 입력" class="form-control" value="">
						    	<div class="file-button">
						    	 	<button type="button">추가</button>
						    	 	<button type="button">삭제</button>
						    	</div>
							</div>
						</div> 
						<div class="form-group">
						    <div class="col-sm-2 control-label col-lg-2"><label for="select">지목용도​</label></div>
						    <div class="col-sm-4">
						    	<select name="" class="form-control">
									<option value="">-- 전체 --</option>
								</select>
							</div>
							<div class="col-sm-2 control-label col-lg-2"><label for="select">감정평가금액​</label></div>
						    <div class="col-sm-4">
						    	<input type="text" id="name" name="name" title="사건번호 입력" class="form-control" value="">
							</div>
						</div> 
	                   <div class="form-group">
						    <div class="col-sm-2 control-label col-lg-2"><label for="select">특기사항<br>프리미엄<br>전용서비스​</label></div>
						    <div class="col-sm-10">
						    	<textarea class="form-control" id="content" name="content" title="내용 입력" rows="20" style="height:100px"> </textarea>
							</div>
							
						</div> 
						<div class="form-group">
						    <div class="col-sm-2 control-label"><label for="select">공개여부</label></div>
						    <div class="col-sm-4">
				                <input class="radio-input" type="radio" id="radio1" >
				                <label class="radio-inline" for="radio1">예</label>
				                <input class="radio-input" type="radio" id="radio2" >
				                <label class="radio-inline" for="radio2">아니요</label>
				            </div>
				            <div class="col-sm-2 control-label"><label for="select">샘플보기여부</label></div>
						    <div class="col-sm-4">
				                <input class="radio-input" type="radio" id="radio3" >
				                <label class="radio-inline" for="radio3">예</label>
				                <input class="radio-input" type="radio" id="radio4" >
				                <label class="radio-inline" for="radio4">아니요</label>
				            </div>
						</div> 
						<div class="form-group">
						    <div class="col-sm-2 control-label"><label for="select">보상여부</label></div>
						    <div class="col-sm-10">
				                <input class="radio-input" type="radio" id="radio1" >
				                <label class="radio-inline" for="radio1">보상중</label>
				                <input class="radio-input" type="radio" id="radio2" >
				                <label class="radio-inline" for="radio2">보상예정</label>
				            
				                <input class="radio-input" type="radio" id="radio3" >
				                <label class="radio-inline" for="radio3">보상취소</label>
				                <input class="radio-input" type="radio" id="radio4" >
				                <label class="radio-inline" for="radio4">환지</label>
				                <input class="radio-input" type="radio" id="radio5" >
				                <label class="radio-inline" for="radio5">기타</label>
				            </div>
						</div> 
						<div class="form-group">
						    <div class="col-sm-2 control-label col-lg-2"><label for="select">첨부파일</label></div>
						    <div class="col-sm-5">
						    	<div class="form-upload">
						    	 	<div class="file-form-group">
						    	 		<div class="form-group__upload">
						    	 			<input type="text" readonly="readonly" class="form-control disabled" title="1번째 파일명">
						    	 			<input type="file" name="file_1" id="atchmn_1" class="form-upload__file--hidden">
						    	 		</div>
						    	 		<div class="form-input__addon">
			                                <label for="atchmn_1" class="btn btn-sm btn-secondary" data-button="upload"><span class="skip">1번째 </span>파일첨부하기</label>
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
				<form name="bbsNttSearchForm" method="get" action="/">
				 <fieldset>
					 <legend>검색</legend>
					 <div class="search">
                        <!-- 01. item -->
                        <div class="item form-item">
                            <div class="form-group form-group1">
								<span class="tit">구분</span>
								<div class="search-inner text-left">
									<div class="search--select">
							    		<span>
								    		<select name="">
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
							    		<span>
								    		<select name="">
												<option value="">-- 전체 --</option>
											</select>
									   </span>
									   <span>
								    		<select name="">
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
										<span>
											<input type="text" class="form-control" name="startDate" id="startDate" placeholder="시작일" value="" title="시작일 입력">
											<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
										</span>
									</div>
								</div>
							</div>
							<div class="form-group form-group2">
								<span class="tit">입찰종료일</span>
								<div class="search-inner text-left">
									<div class="search--calendar">
										<span>
											<input type="text" class="form-control" name="endDate" id="endDate" placeholder="종료일" value="" title="종료일 입력">
	                                    <button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
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
							    		<span>
								    		<select name="">
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
							    		<span>
								    		<select name="">
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
									<label class="checkbox-inline" for="id1">
									    <input type="checkbox" id="id1" name="">전체
									</label>
									<label class="checkbox-inline" for="id2">
									    <input type="checkbox" id="id2" name="">주거시설
									</label>
									<label class="checkbox-inline" for="id3">
									    <input type="checkbox" id="id3" name="">업무및상업시설
									</label>
									<label class="checkbox-inline" for="id4">
									    <input type="checkbox" id="id4" name="">토지
									</label>
									<label class="checkbox-inline" for="id5">
									    <input type="checkbox" id="id5" name="">공업시설
									</label>
									<label class="checkbox-inline" for="id6">
									    <input type="checkbox" id="id6" name="">동산및권리권
									</label>
									<div class="search--btn">
										 <span class="btn--submit"><input type="submit" value="검색"></span>
									</div>
								</div>
							</div>
						</div>	
						<!-- 01. item ::E -->
						
                    </div>
				 </fieldset>
			 </form>
			<!-- List : S -->
				<div class="board-list">
					<div class="box-list">
						<div class="item">
							<a href="#" class="link">
								<span class="td__category">경매</span>
								<div class="description">
									<strong class="title">
										<em>사건번호 1111-11345</em>
										<i class="txt_blt03 state01">진행중</i>
										<span>천안직산 공공지원민간임대주택 공급촉진지구</span>
										
									</strong>
									<ul>
										<li class="mid_td">용도 :  수용 및 사용</li>
										<li class="sma_td">감정가 / 최저가 : 0000000</li>
										<li class="mid_td">소재지 : 서북구 직산읍 모시리 1-1번지, 업성동 21-2번지 일원</li>
										<li class="sma_td">입찰일 : 2021 - 03 -12 </li>
										<li class="mid_td">편입면적 :</li>
										<li class="sma_td">상태 :</li>
										<li class="full_td">상태 :</li>
									</ul>
								</div>
								<span class="td__knowhow" data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><ul><li>- 2020년 6월 30일 실효된 구간 內 해당 물건임.</li>
<li>- 전체면적 1,785㎡ 中 입찰지분 1,723.1㎡</li></ul>">특급노하우</span>
							</a>
						</div>
						<div class="item">
							<a href="#" class="link">
								<span class="td__category">경매</span>
								<div class="description">
									<strong class="title">
										<em>사건번호 1111-11345</em>
										<i class="txt_blt03 state02">진행완료</i>
										<span>천안직산 공공지원민간임대주택 공급촉진지구</span>
										
									</strong>
									<ul>
										<li class="mid_td">용도 :  수용 및 사용</li>
										<li class="sma_td">감정가 / 최저가 : 0000000</li>
										<li class="mid_td">소재지 : 서북구 직산읍 모시리 1-1번지, 업성동 21-2번지 일원</li>
										<li class="sma_td">입찰일 : 2021 - 03 -12 </li>
										<li class="mid_td">편입면적 :</li>
										<li class="sma_td">상태 :</li>
									</ul>
								</div>
								<span class="td__knowhow" data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><ul><li>- 2020년 6월 30일 실효된 구간 內 해당 물건임.</li>
<li>- 전체면적 1,785㎡ 中 입찰지분 1,723.1㎡</li></ul>">특급노하우</span>
							</a>
						</div>
					</div>
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
				<!-- 경/공매 리스트 -->
						
						
					</div>
					<!-- 경/공매 -->
					<div class="scroll" style="display:none">
		                <!-- 보상전례 쓰기 -->
						<strong class="title">보상전례</strong>
						<div class="modal__board">
			               <div class="board_btm" style="padding-bottom:15px">
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
												<span>
													<input type="text" class="form-control" name="startDate" id="startDate" placeholder="시작일" value="" title="시작일 입력">
													<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
												</span>
											</div>
											<div class="search--calendar">
												<span>
													<input type="text" class="form-control" name="endDate" id="endDate" placeholder="종료일" value="" title="종료일 입력">
			                                    <button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
												</span>
											</div>
										</div>
									</div>
									<div class="form-group form-group2">
										<span class="tit">사업지구명</span>
										<div class="search-inner text-left">
											<div class="search--select">
									    		<span>
										    		<select name="">
														<option value="">-- 전체 --</option>
													</select>
											   </span>
											   <span>
										    		<select name="">
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
									    		<span>
										    		<select name="">
														<option value="">-- 전체 --</option>
													</select>
											   </span>
									    		<span>
										    		<select name="">
														<option value="">-- 전체 --</option>
													</select>
											   </span>
									    		<span>
										    		<select name="">
														<option value="">-- 전체 --</option>
													</select>
											   </span>
									    	</div>
											<div class="search--btn">
												 <span class="btn--submit"><input type="submit" value="검색"></span>
											</div>
										</div>
									</div>
								</div>	
								<!-- 01. item ::E -->
								
			                </div>
						 </fieldset>
					 	</form>
						<div class="board_btm" style="border-top: none;border-bottom: 1px solid #ddd;padding-bottom: 50px;margin-top: -50px;">
	                        <div class="btns_area fl_r mo_block">
	                            <a href="#" class="btn btn-primary">토지이용계획​ 바로가기​</a>
	                            <a href="#" class="btn btn-secondary">개별공시지가​ 바로가기</a>
	                        </div>
	                    </div>
						<div class="table-list">
							<table>
								<colgroup>
									<col style="width:15%">
									<col style="width:auto">
									<col style="width:15%">
									<col style="width:15%">
									<col style="width:15%">
									<col style="width:15%">
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
										<td class="subject"><a href="#view">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)</a></td>
										<td class="writer">보상가</td>
										<td class="writer">보상가</td>
										<td class="regDate"><span class="td__date">2021-03-15</span></td>
										<td class="writer">가격시점개별지가</td>
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
					
					
					</div>
				</div>
				<!-- 보상전례 -->
				<button type="button" id="sideClose"><span class="skip">개발정보(관리자)</span>닫기</button>
			</div>
			<!-- 개발정보(관리자) -->
			<div id="info" style="display:none;">
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
							<li><strong>2003. 07.00</strong>시안신선 예비타당성 조사(KDI)<a href="#" class="btn btn-default btn-sm btn-file"><i class="icon-file"></i>파일보기</a></li>	
						</ul>
					</div>
					
					<div class="map__header">
						<span class="map__title">토지조사 및  보고서 다운로드</span>
					</div>
					<div class="map__content">
						<div class="ui-banner__box">
							<div class="banner__box down">
								<a href="#" class="down">
									<strong class="ui-banner__title">환경영향평가 항목 결정내용(본선2구간)</strong>
								</a>
							</div>
							<div class="banner__box down">
								<a href="#" class="down">
									<strong class="ui-banner__title">환경영향평가 항목 결정내용(본선2구간)</strong>
								</a>
							</div>
							<div class="banner__box down">
								<a href="#" class="down">
									<strong class="ui-banner__title">환경영향평가 항목 결정내용(본선2구간)</strong>
								</a>
							</div>
							<div class="banner__box down">
								<a href="#" class="down">
									<strong class="ui-banner__title">환경영향평가 항목 결정내용(본선2구간)</strong>
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
								<li>2018년 토지보상 배정예산:95억원	</li>
							</ul>
						</div>
					</div>
					
					
					<div class="ui-tip__box">
						<p class="txt-tip txt-small">본 개발정보는 2021년 02월 08일까지 공개된 자료와 Gzone 당사가 직접 취재한 내용을 바탕으로 최종 수정된 자료입니다. 금일 이후 사업시행자의 상황 또는 경제여건의 변화 등에 따라 사업은 축소.획대.변경.취소 및 지연될수 있으니 이용자께서는 이점 유의하시길 바랍니다.</p>
						<p class="txt-tip txt-small">본개발정보는 참고사항이며 당사는 이에 대해 어떠한 경우라도 법적인 책임을 지지 않습니다.</p>
						<p class="txt-tip txt-small">본 개발정보의 지적소유권은 당사에 있으며 당사의 사전 허락없이 이를 무단으로 전제, 복제 할 경우 저작권법에 따라 처벌을 받게 됩니다.</p>
					</div>
					<p class="text-center print"><a href="#" class="btn btn-default"><i class="icon-print"></i>인쇄하기</a></p>
					
					
				</div>
				<div class="button-map">
					<button type="button" id="infoAdd">관심정보등록</button>
					<button type="button" id="infoParagraph">관련기사</button>
					<a type="button" id="infoObject" href="#layer1">투자정보 물건보기</a><!-- 수정0325 -->
				</div>
				<button type="button" id="info_close"><span class="skip">정보창</span>닫기</button>
			</div>
		</div>
				
				
				
			</div>
			
            <!-- content 영역입니다. -->		
            </div>
        </div>
    </div>
    <!-- layout -->
</div>
<div id="banner">
    <div class="layout">
        <ul>
            <li><a href="#">회사소개</a></li>
            <li><a href="#">이용약관</a></li>
            <li><a href="#">개인정보취급방침</a></li>
            <li><a href="#">광고업무제휴문의</a></li>
            <li><a href="#">고객센터</a></li>
            <li><a href="#">서비스전체보기</a></li>
        </ul>
    </div>
</div>
<footer id="foot_layout">
    <!-- 푸터틀 시작 -->
    <div class="layout">
        <a href="javascript:scrollMotionListener();" id="btnTop" title="컨텐츠 상단으로 이동">컨텐츠 상단으로 이동</a>
        <div class="footer-info">
            <strong class="logo">GZONE 전국개발정보</strong>
            <p><span>(주)전국개발정보 지존</span>  <span>서울특별시 영등포구 당산로 246 viewtiful tower 8층</span> <span>사업자등록번호743-88-00139</span></p>
            <p><span>대표이사 : 신태수</span><span>개인정보보호정책책임자 : 신태수</span><span>통신판매신고 제2020-서울영등포-1492호   </span></p>
            <p><span>문의 02-322-3152</span><span>팩스 02-322-3154</span></p>
            <p class="copy">copyright (c) Gzone Corp. All rights reserved.</p>
        </div>
        <div class="qna">
            <strong>무엇이든 물어보세요</strong>
            <div class="txt">
                <b>02-322-3152</b>
                <p><em>상담가능시간</em> 평일 09:00 ~ 18:00</p>
            </div>
        </div>    
    </div>
    <!-- 푸터틀 끝 -->
</footer>

<!-- 투자정보 물건보기 상세보기 ::S  수정0325 -->
<div id="layer1" class="pop-layer">
    <div class="modal__header">
       <h4 class="modal__title">투자정보 물건보기</h4>
       <div class="modal__close-button"><button type="button" class="close btn-layerClose">닫기</button></div>
    </div>
    <div class="modal__content" style="word-break: break-all">
        <div class="cont_wrap">
                     
			<div class="nav-4th">
				<ul>
					<li class="active"><a href="#">4차탭메뉴ov</a></li>
					<li><a href="#">4차탭메뉴</a></li>
				</ul>
			</div>
			
			<form name="bbsNttSearchForm" method="get" action="/">
			 <fieldset>
				 <legend>검색</legend>
				 <div class="search">
                    <!-- 01. item -->
                    <div class="item form-item">
                        <div class="form-group form-group1">
							<span class="tit">구분</span>
							<div class="search-inner text-left">
								<div class="search--select">
						    		<span>
							    		<select name="">
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
						    		<span>
							    		<select name="">
											<option value="">-- 전체 --</option>
										</select>
								   </span>
								   <span>
							    		<select name="">
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
									<span>
										<input type="text" class="form-control" name="startDate" id="startDate" placeholder="시작일" value="" title="시작일 입력">
										<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-group2">
							<span class="tit">입찰종료일</span>
							<div class="search-inner text-left">
								<div class="search--calendar">
									<span>
										<input type="text" class="form-control" name="endDate" id="endDate" placeholder="종료일" value="" title="종료일 입력">
                                    <button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
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
						    		<span>
							    		<select name="">
											<option value="">-- 전체 --</option>
										</select>
								   </span>
						    	</div>
							</div>
						</div>
						<div class="form-group form-group2">
							<span class="tit">타경</span>
							<div class="search-inner text-left">
								<div class="search--text">
									<span><input type="text" name="searchKrwd" value="" title="검색어를 입력해주세요" placeholder="검색어를 입력해주세요" class="form-control"></span>
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
								<label class="checkbox-inline" for="id1">
								    <input type="checkbox" id="id1" name="">전체
								</label>
								<label class="checkbox-inline" for="id2">
								    <input type="checkbox" id="id2" name="">주거시설
								</label>
								<label class="checkbox-inline" for="id3">
								    <input type="checkbox" id="id3" name="">업무및상업시설
								</label>
								<label class="checkbox-inline" for="id4">
								    <input type="checkbox" id="id4" name="">토지
								</label>
								<label class="checkbox-inline" for="id5">
								    <input type="checkbox" id="id5" name="">공업시설
								</label>
								<label class="checkbox-inline" for="id6">
								    <input type="checkbox" id="id6" name="">동산및권리권
								</label>
								<div class="search--btn">
									 <span class="btn--submit"><input type="submit" value="검색"></span>
								</div>
							</div>
						</div>
					</div>	
					<!-- 01. item ::E -->
					
                </div>
			 </fieldset>
		 </form>
		
		<!-- List : S -->
		<div class="board-list">
			<div class="box-list">
				<div class="item">
					<a href="#" class="link">
						<span class="td__category">경매</span>
						<div class="description">
							<strong class="title">
								<em>사건번호 1111-11345</em>
								<span>천안직산 공공지원민간임대주택 공급촉진지구</span>
							</strong>
							<ul>
								<li class="mid_td">용도 :  수용 및 사용</li>
								<li class="sma_td">감정가 / 최저가 : 0000000</li>
								<li class="mid_td">소재지 : 서북구 직산읍 모시리 1-1번지, 업성동 21-2번지 일원</li>
								<li class="sma_td">입찰일 : 2021 - 03 -12 </li>
								<li class="mid_td">편입면적 :</li>
								<li class="sma_td">상태 :</li>
								<li class="full_td">상태 :</li>
							</ul>
						</div>
						<span class="td__knowhow" data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>특급노하우특급노하우특급노하우특급노하우특급노하우</p>">특급노하우</span>
					</a>
				</div>
				<div class="item">
					<a href="#" class="link">
						<span class="td__category">경매</span>
						<div class="description">
							<strong class="title">
								<em>사건번호 1111-11345</em>
								천안직산 공공지원민간임대주택 공급촉진지구
							</strong>
							<ul>
								<li class="mid_td">용도 :  수용 및 사용</li>
								<li class="sma_td">감정가 / 최저가 : 0000000</li>
								<li class="mid_td">소재지 : 서북구 직산읍 모시리 1-1번지, 업성동 21-2번지 일원</li>
								<li class="sma_td">입찰일 : 2021 - 03 -12 </li>
								<li class="mid_td">편입면적 :</li>
								<li class="sma_td">상태 :</li>
							</ul>
						</div>
						<span class="td__knowhow" data-toggle="tooltip" data-container="body" data-html="true" title="<h5>특급노하우</h5><p>특급노하우특급노하우특급노하우특급노하우특급노하우</p>">특급노하우</span>
					</a>
				</div>
			</div>
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
		
			
			
			
        </div>
    </div>
</div>
<!-- 투자정보 물건보기 상세보기 ::E  수정0325 -->
	<!-- 구현부 : E -->

	<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp"%>
</body>
</html>
