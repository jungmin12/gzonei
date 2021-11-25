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
        <div id="contens" class="contents_wrap sub1002">
            <div id="location" class="title_wrap">
                <h2 class="page__title">연혁</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="<c:url value='/design/cmpnyHistView.do'/>">연혁</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>  
            <div id="txt" class="sub1002_wrap">
            <!-- content 영역입니다. -->
                <div>
					<div class="item layout">
						<h2 class="h2">2021<span>~ing</span></h2>
						<ul>
							<li><b>12월</b>자회사 (가칭)지존 감정평가법인 설립(예정)</li>
                            <li><b>11월</b>미래전략실 신설(예정)</li>
                            <li><b>07월</b>그룹 CI(예정)</li>
                            <li><b>04월</b>사이트(www.gzonei.com) 전면 개편</li>
                            <li><b>03월</b>상표등록 출원(변경)</li>
                            <li><b>01월</b>
                                <ul class="s_list">
                                    <li>출판업 등록</li>
                                    <li>그룹 홍보실 신설</li>
                                </ul>
                            </li>
						</ul>
						<div class="his_photo">
                            <img src="<c:url value='/css/gzonei/SRC/images/contents/sub10/1002_img01.jpg'/>" alt="" class="line">                  
                        </div>
					</div>
                    <div class="item layout">
                        <h2 class="h2">2020</h2>
                        <ul>
                            <li><b>12월</b>토지보상가 적정성 검토 컨설팅 서비스 개시</li>
                            <li><b>07월</b>공식 블로그「지존 스토리」순방문자 수 100만명 돌파</li>
                            <li><b>05월</b>사무실 확장 이전(現 영등포구 당산동 ‘뷰티풀 타워‘)</li>
                            <li><b>01월</b>자회사 (주)지존미다스 영업개시</li>
                        </ul>
                        <div class="his_photo">
                            <img src="<c:url value='/css/gzonei/SRC/images/contents/sub10/1002_img02.jpg'/>" alt="">                  
                        </div>
                    </div>
                    <div class="item layout">
                        <h2 class="h2">2019</h2>
                        <ul>
                            <li><b>12월</b>한국부동산 금융대상 수상</li>
                            <li><b>11월</b>gzone 특허청 상표등록(제 40-1540688호)</li>
                            <li><b>10월</b>
                                <ul class="s_list">
                                    <li>상표 출원 등록(출원번호:40-2019-0010384)</li>
                                    <li>부동산 개발정보 1만건(첨부자료 50만건) 돌파</li>
                                </ul>
                            </li>
                            <li><b>07월</b>지존 토지보상지원센터 개소(센터장:김영우 박사)</li>
                            <li><b>06월</b>(주)포도 ․ (주)감정평가법인 태백과 업무제휴</li>
                            <li><b>05월</b>대한민국 우수기업대상(大賞)  `서비스혁신大賞`</li>
                            <li><b>01월</b>매경미디어 그룹 ‘(주)매경비즈’ 와 전국개발정보 업무제휴</li>
                        </ul>
                        <div class="his_photo">
                            <img src="<c:url value='/css/gzonei/SRC/images/contents/sub10/1002_img03.jpg'/>" alt="">                  
                        </div>
                    </div>
                    <div class="item layout">
                        <h2 class="h2">2018</h2>
                        <ul>
                            <li><b>10월</b>‘(주)감정평가법인 태백’ 과 업무제휴</li>
                            <li><b>09월</b>부동산 미디어 플랫폼, ‘땅집고’ 와 전략적 업무제휴</li>
                            <li><b>05월</b>
                                <ul class="s_list">
                                    <li>대한민국 우수기업대상(大賞)  `서비스혁신大賞`</li>
                                    <li>자회사 ‘(주)지존미다스’ 설립</li>
                                </ul>
                            </li>
                        </ul>
                        <div class="his_photo">
                            <img src="<c:url value='/css/gzonei/SRC/images/contents/sub10/1002_img04.jpg'/>" alt="">                  
                        </div>
                    </div>
                    <div class="item layout">
                        <h2 class="h2">2017<span class="right">~16</span></h2>
                        <ul>
                            <li><b>2017.05월</b>대한민국 우수기업대상(大賞)  `서비스혁신大賞`</li>
                            <li><b>2016.05월</b>대한민국 우수기업대상(大賞)  `서비스혁신大賞`</li>
                        </ul>
                        <div class="his_photo">
                            <img src="<c:url value='/css/gzonei/SRC/images/contents/sub10/1002_img05.jpg'/>" alt="">                  
                        </div>
                    </div>
                    <div class="item layout">
                        <h2 class="h2">2015</h2>
                        <ul>
                            <li><b>10월</b>
                                <ul class="s_list">
                                    <li>공식 블로그 「지존 스토리」오픈</li>
                                    <li>주식회사 ‘(주)전국개발정보 지존’ 법인 설립</li>
                                </ul>
                            </li>
                        </ul>
                        <div class="his_photo">
                            <img src="<c:url value='/css/gzonei/SRC/images/contents/sub10/1002_img06.jpg'/>" alt="">                  
                        </div>
                    </div>

                                      
                </div>

                <div class="old">
                    <div class="item layout">
                        <h2 class="h2">2014<span class="right">~12</span></h2>
                        <ul>
                            <li><b>2014.06월</b>‘토지보상아카데미’ 개원</li>
                            <li><b>2012.09월</b>
                                <ul class="s_list">
                                    <li>국내최초 토지보상 및 부동산개발정보 플랫폼, <br>지존 사이트 오픈(www.gzonei.com)</li>
                                    <li>‘전국개발정보 지존’으로 상호변경</li>
                                </ul>
                            </li>
                            <li><b>2012.08월</b>통신판매업 신고(마포구청)</li>
                        </ul>
                        <div class="his_photo">
                            <img src="<c:url value='/css/gzonei/SRC/images/contents/sub10/1002_img07.jpg'/>" alt="">                  
                        </div>
                    </div>
                    <div class="item layout">
                        <h2 class="h2">2009</h2>
                        <ul>
                            <li><b>03월</b>부동산투자자문회사 ‘에스티에스 투자자문’ 창립</li>
                        </ul> 
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
