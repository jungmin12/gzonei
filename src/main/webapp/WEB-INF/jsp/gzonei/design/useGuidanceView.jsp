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
        <div id="contens" class="contents_wrap sub0901">
            <div id="location" class="title_wrap">
                <h2 class="page__title">이용 안내</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="<c:url value='/design/useGuidanceView.do'/>">서비스 안내</a></li>
                        <li class="n3"><a href="<c:url value='/design/useGuidanceView.do'/>" class="navi_ov">이용 안내</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt" class="layout">
            <!-- content 영역입니다. -->





               <div class="sub0901_wrap">
                    <h2 class="title_0901">알고보면 더욱 알차고 <b>다양한 Gzone 서비스,</b><br>지금 만나보세요!</h2>
					<div class="ui ui-tablist">
					<ul class="tab-ul type3 col2" role="tablist">
					<li role="presentation" class="js-tab on"><a role="tab" id="tab1" aria-controls="tab-panel1" href="#tab-panel1" tabindex="0" aria-selected="true" title="열림"><span class="ir ir-icon ir-icon__line icon1"></span>
					<span>개발정보</span></a></li>
					<li role="presentation" class="js-tab"><a role="tab" id="tab2" aria-controls="tab-panel2" href="#tab-panel2" aria-selected="false" title="숨김"><span class="ir ir-icon ir-icon__line icon2"></span><span>투자정보</span></a></li>
					<li role="presentation" class="js-tab"><a role="tab" id="tab3" aria-controls="tab-panel3" href="#tab-panel3" aria-selected="false" title="숨김"><span class="ir ir-icon ir-icon__line icon3"></span><span>지존스토어</span></a></li>
					<li role="presentation" class="js-tab"><a role="tab" id="tab4" aria-controls="tab-panel4" href="#tab-panel4" aria-selected="false" title="숨김"><span class="ir ir-icon ir-icon__line icon4"></span><span>커뮤니티</span></a></li>
					<li role="presentation" class="js-tab"><a role="tab" id="tab5" aria-controls="tab-panel5" href="#tab-panel5" aria-selected="false" title="숨김"><span class="ir ir-icon ir-icon__line icon5"></span><span>부가서비스</span></a></li>
					<li role="presentation" class="js-tab"><a role="tab" id="tab6" aria-controls="tab-panel6" href="#tab-panel6" aria-selected="false"><span class="ir ir-icon ir-icon__line icon6"></span><span>마이페이지</span></a></li>
					</ul>

						<div class="tabpanel on" id="tab-panel1" role="tabpanel" aria-labelledby="tab1" tabindex="0">
							    <div class="tit">01 개발정보<p></p></div>
							<div class="tab_tit">국내유일! 전국의 주요 개발정보를 한 눈에</div>
							<div class="tab_txt"><p>현재 보상(환지포함)진행 중인 개발사업지구부터 개발예정지역에 편입되어 향후 보상을 앞둔 사업지구, 보상이 완료되어 주변 일대에 수혜가 기대되는 사업지구까지- 전국의 주요 개발사업지구의 추진내역 및 향후 추진일정, 각종 고시공고 파일은 물론 지존이 직접 취재해 누구도 따라올 수 없는 차별화된 생생한 정보를 제시합니다.</p></div>
							<button type="button" class="btn btn-primary"  onclick="location.href='<c:url value='/free/devFreeView.do?smpleNo=1'/>' "><a href="<c:url value='/free/devFreeView.do?smpleNo=1'/>" title="새창열기" rel="noopener noreferrer">개발정보 샘플보기</a></button>
							<div class="box"><div class="box_txt"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub09/sub0901_1.jpg' />"></div></div>  
						</div>
						<div class="tabpanel" id="tab-panel2" role="tabpanel" aria-labelledby="tab2" tabindex="0">
							<div class="tit">02 투자정보<p></p></div>
							<div class="tab_tit">국내최초! 개발지역 편입 경매·공매 사건정보 제공​</div>
							<div class="tab_txt"><p>국내 최초로 현재 보상이 진행중이거나 개발예정지역에 편입되어 향후 수용 보상 (환지포함)이 예상되는 경·공매 물건의 사건번호를 제공하고 특이 사항이 있는 물건에 대해서는 `특급 노하우’에 대한 코멘트를 제시합니다. 대법원경매정보 및 온비드의 공매정보로 해당 사건을 바로 연결 시키는 서비스를 통해 바로  상세정보를 확인 할 수 있도록 합니다.​</p></div>
							<button type="button" class="btn btn-primary"onclick="location.href='<c:url value='/design/invtFreeView.do'/>' "><a href="<c:url value='/design/invtFreeView.do'/>" title="새창열기" rel="noopener noreferrer">투자정보 샘플보기</a></button>
							<div class="box"><div class="box_txt"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub09/sub0901_2.jpg'/> "></div></div> 
						</div>
						<div class="tabpanel" id="tab-panel3" role="tabpanel" aria-labelledby="tab3" tabindex="0">
							<div class="tit">03 지존스토어<p></p></div>
							<div class="tab_tit">토지보상 경·공매 투자 성공/실패 실화​</div>
							<div class="tab_txt"><p>실제 토지보상 투자 사례를 통해 이론서에서 배울 수 없는 다양한 케이스를 생생함 100%로 소개하는 한 테마별 보상투자이야기. 투자 성공사례를 통해 `대박 토지보상 투자` 노하우를 제시하는 것은 물론 섣부른 투자로 인한 `쪽박 토지보상 투자`까지 투자과정에서 간과하고 지나친 실패 원인을 쉽고 재미있게 분석합니다.​</p></div>
							<div class="box"><div class="box_txt"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub09/sub0901_3.jpg'/>" ></div></div> 
						</div>
						<div class="tabpanel" id="tab-panel4" role="tabpanel" aria-labelledby="tab4" tabindex="0">
							<div class="tit">04 커뮤니티​<p></p></div>
							<div class="tab_tit">개발정보 및 토지보상 관련 다양한 정보 소통의 장​</div>
							<div class="tab_txt"><p>공지사항, 칼럼, 토지보상 기사 , 보도자료, Q&A게시판, ​카페(준비중) 등 부동산 개발정보 및 토지보상관련 다양하고 ​폭넓은 정보를 접하고 소통할 수 있는 유익한 공간을 제공합니다.​</p></div>
							<div class="box"><div class="box_txt"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub09/sub0901_4.jpg'/>"></div></div> 
						</div>
						<div class="tabpanel" id="tab-panel5" role="tabpanel" aria-labelledby="tab5" tabindex="0">
							<div class="tit">05 부가서비스<p></p></div>
							<div class="tab_tit">각종 유용한 자료와 사이트를 원한다면​</div>
							<div class="tab_txt"><p>토지 수용 및 부동산 관련 유익한 정보를 담은 자료실, 토지보상 주요 법원 판례, 부동산 정보에 필요한 유용한 사이트를 제공합니다. </p></div>
							<button type="button" class="btn btn-primary" onclick="location.href='<%=request.getContextPath()%>/adisvc/recsroomBbsList.do'">자료실 가기</button>
							<button type="button" class="btn btn-primary" onclick="location.href='<%=request.getContextPath()%>/design/usfulSiteView.do'">유용한 사이트 가기</button>
							<div class="box"><div class="box_txt"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub09/sub0901_5.jpg'/>"></div></div> 
						</div>
						<div class="tabpanel" id="tab-panel6" role="tabpanel" aria-labelledby="tab6" tabindex="0">
							<div class="tit">06 마이페이지<p></p></div>
							<div class="tab_tit">회원정보 수정, 회원탈퇴, 나의 결제내역, 관심정보, 결제/연장 등<br> ​회원님의 각종 정보 내역을 확인할 수 있습니다.​</div>
							<div class="tab_txt">
								<h3 class="h3">[ID 동시접속] 동시접속 사용자 제한 </h3>
								<ul class="list-1st">
									<li>- 사이트 보안을 위해 1개 ID로 다수의 사용자가 동시에 로그인하여 사용할 경우 (동일PC도 적용) 해당 ID에 대해 모두 자동 로그아웃 되며 24시간 동안 로그인 할 수 없도록 제한합니다.​</li>
									<li>- 법인 회원의 경우 허용 동시접속자까지 동시 접속이 가능하며 ​초과하는 경우 24시간 동안 로그인 할 수 없도록 제한합니다.​</li>
								</ul>
							</div>
							<div class="point">※ 서비스 기간은 요청을 받은 날로 부터 시작 합니다.</div>
							<div class="box"><div class="box_txt"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub09/sub0901_6.jpg'/>"></div></div> 
						</div>
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
