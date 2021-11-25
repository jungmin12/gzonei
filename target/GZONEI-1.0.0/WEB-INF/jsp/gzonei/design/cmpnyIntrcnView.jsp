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
    <div class="body_wrap">      
        <div id="contens" class="contents_wrap sub1001">
            <div id="location" class="title_wrap">
                <h2 class="page__title">회사소개</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="<c:url value='/design/cmpnyIntrcnView.do'/>">회사소개</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>  
            <div id="txt" class="sub1001_wrap">
            <!-- content 영역입니다. -->
               <div class="con0 layout"> 
                    <h2 class="hide_tx">국내유일의 토지보상 및 부동산 개발정보 플랫폼 지존</h2>
                    <p>지존은 국내 유일의 토지보상 및 부동산 개발정보 플랫폼입니다.</p>
                </div>
                <div class="sec_margin"></div>
                <div class="con1">
                    <div class="layout">
                        <p><b>GZONE의 G는 `Gold 와 地` </b> 즉 황금 땅을 의미함과 동시에<br>대한민국 토지보상 및 부동산 개발정보의 至尊임을 의미합니다.</p>
                        <span class="hide_tx">G</span>
                    </div>
                </div>
                <div class="con2">
                    <div class="layout">
                    <h2>토지와 금융의 만남</h2>
                    <p>토지 투자의 난제인 환가성에 대한 고민 끝에 탄생한 지존은` 토지와 금융의 성공적 만남`을 이끌어냄으로써 독보적으로 부동산 투자의 새로운 패러다임을 제시했습니다.</p>
                    <ul>
                        <li><span class="img1"></span>지존은 1만 건 이상의 방대한 전국의 부동산 개발사업지구에 대한 상세 정보와 해당 사업지구에 편입된 토지보상 경매·공매물건을  다량 보유하고 있으며 이러한 정보를 기반으로 수년간 쌓아온 지존만의 특별한 정보 수집 및 가공 노하우를 통해 최고급 정보를 서비스하고 있습니다.</li>
                        <li><span class="img2"></span>지존은 개발사업지구에 편입돼 토지보상이 진행 중 이거나 향후 토지보상이 예상되는 경매·공매 물건을 제공함으로써 환가성과 수익성에 대한 고민을 해결, 부동산 투자의 새로운 골드존(Gzone)을 제시합니다. </li>
                        <li><span class="img3"></span>지존은 각 개발사업지구 별 추진내역 및 향후 추진일정에 대한 평면적 정보를 제시하는 데 그치지 않고 지존이 직접 전담 취재를 통해 확인한 현장감 있는 입체적 정보를 제공하며 지속적인 정보 업데이트를 통해 그 누구도 따라올 수 없는 최신의 차별화된 서비스를 제공합니다. 지금 이 순간에도 지존의 개발정보와 투자정보는 업데이트 되고 있습니다.</li>
                        <li><span class="img4"></span>이 외에도 지존은 토지보상 투자 성공사례와 실패사례, 전문가 칼럼, 토지보상 판례, 각 개발정보 관련 언론기사, 지존의 시각으로 바라보는 지존 포커스, 토지보상 골든벨 地知GO(지지고) 등 다양하고 풍성한 개발 관련 정보를 제공하는 대한민국 유일의  토지보상 및 부동산 개발정보 플랫폼 입니다. </li>
                    </ul>
                    </div>
                </div>
                <div class="con3">
                    <div class="layout">
                        <div class="wrap">

                            <h2>주요정보</h2>
                            <h3>개발정보</h3>
                            <ul>
                                <li>현재 보상(환지 포함) 진행 중인 개발사업지구</li>
                                <li>향후 보상(환지 포함)을 앞두고 있는 개발사업지구</li>
                                <li>보상이 완료되어 실제 개발사업이 진행 중 이거나 준공이 임박해 주변 일대에 대한 수혜가 기대되는 사업지구</li>
                            </ul>
                            <div class="thum"></div>
                        </div>
                        <div class="wrap">
                            <h3>투자정보</h3>
                            <p>개발사업에 편입돼 현재 토지보상(환지 포함)이 진행 중 이거나 향후 토지 보상이 예정된 경매·공매 투자 물건을 선별 제공해  수익성은 물론 부동산 투자의 난제인 신속한 환가성(현금보상) 문제를 해결, 부동산투자를 금융투자화 할 수 있는 교차점 제시. </p>
                        </div>
                        <div class="wrap">
                            <h3>지존 스토어</h3>
                            <h4>토지보상 투자 성공·실패사례 e-book</h4>
                            <p> 실제 다양한 토지보상 투자 사례를 통해 이론서에서 배울 수 없는 각양각색의 다양한 케이스를 
                                 현장감 있는 생생한 표현으로 소개하는 테마 별 토지보상 투자이야기. <br>
                                 누구나 꿈꾸는 투자 성공사례를 통해 `대박 토지보상 투자` 노하우를 제시하는 것은 물론
                                 무모하고 섣부른 투자로 인한 `쪽박 토지보상 투자`까지 투자과정에서 간과하고 지나친 실패원인 분석.</p>
                        </div>
                        <div class="wrap">
                            <h3>지존포커스</h3>
                            <p>토지보상 및 부동산 개발정보의 다양한 이슈에 대해 지존 신태수 대표가 던지는 `Talk Talk` 메시지.
                            자타가 공인하는 토지보상 및 부동산 개발정보 1인자  지존 신태수 대표의 오랜 경험에서 나오는 예리한 메세지에서
                            포인트 정보를 캐치할 수 있습니다.  
                            </p>
                        </div>
                    </div>
                </div>
                <div class="con4">
                    <div class="layout">
                        <h2>地知GO</h2>
                        <h3>당신의 토지 실력은 어떻습니까? </h3>
                        <p> 부동산 각 분야의 최고 전문가들로 구성된 `지존 전문 위원단`이 초급부터 최상급까지 토지 지식에 대한 다양한 <br> 문제를 출제, 단계별로 자신의 토지 실력을 검증할 수 있는 토지 지식 문제은행 </p>
                    </div>
                </div>
            </div>


            <!-- content 영역입니다. -->	
        </div>
    </div>
</div>

<!-- 구현부 : E -->

<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>
</body>
</html>
