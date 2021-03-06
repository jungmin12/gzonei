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
                <h2 class="page__title">결제/연장하기</h2>
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

			<h1 style="margin-bottom: 50px;font-size: 40px;color: #000;">결제/연장하기 화면 (화면정의서 118p)</h1> <!--페이지 안내 텍스트 입니다 개발 시 지워주세요-->
				<div class="augment_wrap">
					<h2 class="h2">이용요금 안내</h2>
					<div class="payInfo n3">
						<div class="price_info exception n2">
							<strong class="title">실버회원</strong>
							<div class="inner">
								<div class="item">
									<div class="obj">
										<em>이코노미</em>
										<ul>
											<li>3개월<strong>77,000</strong></li>
											<li>6개월<strong>139,000</strong></li>
											<li>12개월<strong>250,000</strong></li>
										</ul>
									</div>
								</div>
								<div class="item">
									<div class="obj">
										<em>스페셜</em>
										<ul>
											<li>3개월<strong>110,000</strong></li>
											<li>6개월<strong>198,000</strong></li>
											<li>12개월<strong>356,000</strong></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
						
						<div class="price_info gold n2">
							<strong class="title">골드회원</strong>
							<div class="inner">
								<div class="item">
									<div class="obj">
										<em>이코노미</em>
										<ul>
											<li>3개월<strong>770,000</strong></li>
											<li>6개월<strong>1,386,000</strong></li>
											<li>12개월<strong>2,495,000</strong></li>
										</ul>
									</div>
								</div>
								
								<div class="item">
									<div class="obj">
										<em>스페셜</em>
										<ul>
											<li>3개월<strong>1,100,000</strong></li>
											<li>6개월<strong>1,980,000</strong></li>
											<li>12개월<strong>3,564,000</strong></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
						<div class="price_info premium n2">
							<strong class="title">프리미엄회원</strong>
							<div class="inner">
								<div class="item">
									<div class="obj">
										<em>이코노미</em>
										<ul>
											<li>6개월<strong>13,200,000</strong></li>
											<li>12개월<strong>23,760,000</strong></li>
										</ul>
									</div>
								</div>
								<div class="item">
									<div class="obj">
										<em>스페셜</em>
										<ul>
											<li>6개월<strong>22,000,000</strong></li>
											<li>12개월<strong>39,600,000</strong></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
					<span class="time">기준일 : 2020년 04월 20일</span>
				
					<h2 class="h2">이용요금 안내(구버전)</h2>
					<span class="time">기준일 : 2020년 04월 20일</span>
					<div class="payInfo">
						<div class="price_info gold">
							<strong class="title">골드회원</strong>
							<div class="item">
								<em>일반</em>
								<ul class="n3">
									<li>3개월<strong>480,000</strong></li>
									<li>6개월<strong>480,000</strong></li>
									<li>12개월<strong>480,000</strong></li>
								</ul>
							</div>
							<div class="item">
								<em>법인</em>
								<ul>
									<li>6개월<strong>3,740,000</strong></li>
									<li>12개월<strong>6,730,000</strong></li>
								</ul>
							</div>
						</div>
						<div class="price_info premium">
							<strong class="title">프리미엄회원</strong>
							<div class="item">
								<em>일반</em>
								<ul>
									<li>6개월<strong>3,800,000</strong></li>
									<li>12개월<strong>6,840,000</strong></li>
								</ul>
							</div>
							<div class="item">
								<em>법인</em>
								<ul>
									<li>6개월<strong>5,130,000</strong></li>
									<li>12개월<strong>8,730,000</strong></li>
								</ul>
							</div>
						</div>
						<div class="price_info exception full-width">
							<strong class="title">특별회원</strong>
							
							<div class="item">
								<ul>
									<li>6개월<strong>16,200,000</strong></li>
									<li>12개월<strong>27,500,000</strong></li>
								</ul>
							</div>
						</div>
					</div>
					<h2 class="h2">나의 이용요금 확인</h2>
					<div class="mypay-box">
					<div class="mypay">
						<div class="item">
							<div class="inner">
								<strong>회원등급선택</strong>
								<ul>
									<li>
										<input class="radio-input" type="radio" id="radio1" title="" value="">
										<label class="radio-inline" for="radio1">골드</label>
									</li>
									<li>
										<input class="radio-input" type="radio" id="radio2" title="" value="">
										<label class="radio-inline" for="radio2">프리미엄</label>
									</li>
									<li>
										<input class="radio-input" type="radio" id="radio3" title="" value="">
										<label class="radio-inline" for="radio3">법인 골드</label>
									</li>
									<li>
										<input class="radio-input" type="radio" id="radio4" title="" value="">
										<label class="radio-inline" for="radio4">법인 프리미엄</label>
									</li>
									<li>
										<input class="radio-input" type="radio" id="radio5" title="" value="">
										<label class="radio-inline" for="radio5">특별</label>
									</li>
								</ul>
							</div>
						</div>
						<div class="item">
							<div class="inner">
								<strong>서비스 선택</strong>
								<ul>
									<li>
										<input class="checkbox-input" type="checkbox" id="checkbox1" name="" title="" value="a">
										<label class="checkbox-inline" for="checkbox1">수신동의</label>
									</li>
								</ul>
							</div>
						</div>
						<div class="item">
							<div class="inner">
								<strong>기간 선택</strong>
								<ul>
									<li>
										<input class="radio-input" type="radio" id="radio6" title="" value="">
										<label class="radio-inline" for="radio6">3개월</label>
									</li>
									<li>
										<input class="radio-input" type="radio" id="radio7" title="" value="">
										<label class="radio-inline" for="radio7">6개월</label>
									</li>
									<li>
										<input class="radio-input" type="radio" id="radio8" title="" value="">
										<label class="radio-inline" for="radio8">12개월</label>
									</li>
								</ul>
							</div>
						</div>
						<div class="item payfiner">
							<div class="inner">
								<div class="order_title">
									<h4 class="title">전국 12개월<span class="txt_blt03 state01">골드</span></h4>
									<!-- <h4 class="title">전국 12개월<span class="txt_blt03 state02">프리미엄</span></h4> -->
									<!-- <h4 class="title">전국 12개월<span class="txt_blt03 state03">특별</span></h4> -->
									
									<div class="price_field">
										<dl>
											<dt>이용요금</dt>
											<dd><em class="number">66,000,000</em></dd>
										</dl>
									</div>
									<div class="price_field">
										<dl>
											<dt>결제금액</dt>
											<dd><em class="number"> 0</em></dd>
										</dl>
									</div>
								</div>
								<div class="order_content">
									<div class="order_total_price">
										<h4 class="txt_price">결제 할 요금</h4>
										<span class="price"><em class="number" id="CalcAmountInDsc">66,000</em></span>
									</div>
									<div class="order_total_price">
										<h4 class="txt_price">결제방법</h4>
										<span class="price">
											<input class="radio-input" type="radio" id="radio9" title="" value="">
											<label class="radio-inline" for="radio9">무통장입금</label>
											<input class="radio-input" type="radio" id="radio10" title="" value="">
											<label class="radio-inline" for="radio10">신용카드</label>
										</span>
									</div>
								</div>
							</div>
						</div>
					</div>
					</div>
					<p class="text-right">※ 신용카드 결제서비스는 사이트 개편에 따라 잠정 중단합니다.</p>
					
					<strong class="s-title txt-tip">서비스 이용요금 선택 시 꼭 확인해주세요!</strong>
					<ul>
						<li>- 한번 결제된 요금은 이용 중에 환불이 불가합니다.</li>
						<li>- 서비스가 만료되기 전 연장결제를 하실 경우, 이용중인 서비스가 끝나는 익일부터 새롭게 결제하신 내역으로 서비스가 시작됩니다.</li>
						
					</ul>
					<strong class="s-title txt-tip">무통장 입금안내</strong>
					<p>무통장 입금인 경우 즉시 정보이용이 불가능 하며 <em>입금 후 반드시 유선으로 요청</em>을 하셔야 정보를  이용하실 수 있습니다.  <em>입금 후 연락처 : 02-322-3152 </em>(평일 09:00 ~ 18:00)</p>
					<p>※ 서비스 기간은 요청을 받은 날로 부터 시작 합니다.</p>
					
					<div class="bank">
						<div class="item">
							<strong>입금계좌안내</strong>
							<em>예금주 : (주)지존</em>
						</div>
						<div class="item woori">
							<strong>우리은행</strong>
							<em>1005-002-840924</em>
						</div>
						<div class="item hana">
							<strong>하나은행</strong>
							<em>1005-002-840924</em>
						</div>
					</div>
					
					<div class="ui_radio--custom">
				        <input type="checkbox" name="" id="agree_confirm_3">
				        <label for="agree_confirm_3"><span class="chk_ball"></span>서비스 이용안내 내용을 확인하였으며 상기 내용에 동의합니다.</label>
				    </div>
					
					<div class="text-center">
				        <button type="button" class="btn btn-default">취소</button>
				        <button type="button" class="btn btn-primary">다음</button>
				    </div>
					
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
