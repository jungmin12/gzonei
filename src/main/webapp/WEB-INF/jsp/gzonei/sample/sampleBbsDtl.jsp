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
                <h2 class="page__title">경·공매 사례</h2>
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
			<!-- view : S -->
			<div class="board_view_in">
                    <!-- board -->
                    <div class="board">
                        <div class="board_view">
                            <div class="view_header">
	                            <span class="view_tit_number">8880</span>
                                <div class="view_tit">
                                    <p class="tit_txt">
                                       고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)
                                    </p>
                                </div>
                                <span class="view_tit_aside">2020.11.24</span>
                                <div class="view_data">
	                               <span class="view-id">na9*****</span>  
	                               <span class="view-hit">34</span>     
                                </div>
                            </div>
                            
                            <div class="view_cont_box">
                                <div class="view_cont">
                                <!-- 게시글-->
								고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<br>
								고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<br><br>
								
								고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<br>
								고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<br><br>
								고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<br><br>
								고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<br><br>
								고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<br><br>
								
								* 단, 주문 건 당 30만원 초과 주문 건 발생 시 보증보험 가입 필수 
                                <!--// 게시글-->
                                </div>
                            </div>
                        </div>
                        <div class="fileArea">
						<p>
							<a href="#">2021년 융합의학기술원 연구과제 공모사업 시행 계획(안).hwp</a>
							<span class="file_vol">1.50KB </span>
						</p>
						<p>
							<a href="#">2021년 융합의학기술원 연구과제 공모사업 시행 계획(안).hwp</a>
							<span class="file_vol">1.50KB </span>
						</p>
						</div>
                    </div>
                    <!-- board -->

                    <div class="board_btm">
                        <div class="btns_area fl_r mo_block">
                            <a href="#" class="btn btn-default">수정</a>
                            <a href="#" class="btn btn-default">삭제</a>
                            <a href="#" class="btn btn-default">목록</a>
                        </div>
                    </div>
                    
                    
					                    
                    
                </div>
				<!-- view : E -->
			
			
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
