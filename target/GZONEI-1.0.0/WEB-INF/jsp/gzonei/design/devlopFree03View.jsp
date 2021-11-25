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
                <h2 class="page__title">개발정보 샘플보기</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="#">개발정보</a></li>
                        <li class="n3"><a href="<c:url value='/design/devlopFree03View.do'/>" class="navi_ov">개발정보 샘플보기</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">
	            
			<div class="nav-4th">
				<ul>
					<li><a href="<c:url value='/design/devlopFree01View.do'/>">개발정보 1</a></li>
					<li><a href="<c:url value='/design/devlopFree02View.do'/>">개발정보 2</a></li>
					<li class="active"><a href="<c:url value='/design/devlopFree03View.do'/>">개발정보 3</a></li>
					<li><a href="<c:url value='/design/devlopFree04View.do'/>">개발정보 4</a></li>
				</ul>
			</div>
            <!-- content 영역입니다. -->
			<!-- 개발정보(관리자) -->
			<div id="info" class="sample">
					
					<strong class="title"><em>부산 강서구</em>부산연구개발특구 첨단복합지구 조성사업</strong>
					<div class="photoArea">
						<div class="thumbnail">
							<a href="#"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub01/sample_0103.jpg'/>" alt=""></a>
						</div>
						<div class="photoList">
							<ul>
								<li><strong>위치</strong>대저1동, 대저2동 일원​</li>
								<li><strong>면적</strong>5,704,792㎡(1,725,700평)​</li>
								<li><strong>시행</strong>LH공사 & 부산도시공사​</li>
								<li><strong>적용법률</strong>연구개발특구의 육성에 관한 특별법​</li>
								<li><strong>사업방식</strong>수용 및 사용</li>
								<li><strong>사업인정시점</strong>실시계획 승인 고시일</li>
							</ul>
						</div>
					</div>
					
					
					<div class="map__header">
						<span class="map__title">사업주요내용</span>
					</div>
					<div class="map__content">
						<ul>
							<li> - 첨단산업단지와 호텔·컨벤션센터가 포함된 공항복합도시 건설​</li>
							<li> - 1단계(핵심기능/53만평),2단계(주거기능/74만평) 등으로 단계별로 추진할 계획​</li>
							<li> - 사업기간:2016년~2027년12월​</li>
							<li> - 사업비:4조원​</li>
						</ul>
					</div>
					
					<div class="map__header">
						<span class="map__title">추진내역</span>
					</div>
					<div class="map__content">
						<ul>
							<li><strong>2016.11.00</strong>사업 계획 발표</li>	
							<li><strong>2017.01.00</strong>조사설계용역 착수</li>	
							<li><strong>2017.02.08</strong>토지거래계약 허가구역 지정 및 재지정(해제) 공고<a href="#" class="btn btn-default btn-sm btn-file"><i class="icon-file"></i>파일보기</a></li>	
							<li><strong>2017.02.08</strong>개발행위허가 제한 결정 및 지형도면 고시<a href="#" class="btn btn-default btn-sm btn-file"><i class="icon-file"></i>파일보기</a></li>	
							<li><strong>2017.07.27</strong>GB해제 및 개발계획&실시계획 수립 용역 착수</li>	
							<li><strong>2018.05.09</strong>토지거래계약허가구역 재지정 공고<a href="#" class="btn btn-default btn-sm btn-file"><i class="icon-file"></i>파일보기</a></li>	
							<li><strong>2019.01.00</strong>예비타당성 검토 신청 - 기재부</li>	
							<li><strong>2019.03.00</strong>예타대상 사업으로 선정</li>	
							<li><strong>2020.01.29</strong>개발행위허가 제한(변경) 고시<a href="#" class="btn btn-default btn-sm btn-file"><i class="icon-file"></i>파일보기</a></li>	
							<li><strong>2020.04.03</strong>관리계획(변경) 지형도면(변경) 고시<a href="#" class="btn btn-default btn-sm btn-file"><i class="icon-file"></i>파일보기</a></li>	
							<li><strong>2020.05.00</strong>KDI 예비타당성 조사 진행 중</li>	
							<li><strong>2020.08.00</strong>KDI 예비타당성 조사 완료</li>	
							<li><strong>2020.11.17</strong>관리계획(변경) 및 지형도면(변경) 고시<a href="#" class="btn btn-default btn-sm btn-file"><i class="icon-file"></i>파일보기</a></li>	
							<li><strong>2021.02.00</strong>KDI(한국개발연구원) 예비타당성조사 최종 통과</li>	
						</ul>
					</div>
					
					<div class="map__header">
						<span class="map__title">토지조사 및  보고서 다운로드</span>
					</div>
					<div class="map__content">
						<div class="ui-banner__box">
							<div class="banner__box down">
								<a href="#" class="down">
									<strong class="ui-banner__title">개발행위허가제한지역 지형도면 고시 총괄도</strong>
								</a>
							</div>
							<div class="banner__box down">
								<a href="#" class="down">
									<strong class="ui-banner__title">토지조서(18.05)</strong>
								</a>
							</div>
							<div class="banner__box down">
								<a href="#" class="down">
									<strong class="ui-banner__title">토지거래허가구역도(18.05)</strong>
								</a>
							</div>
						</div>
					</div>
					
					<div class="map__header">
						<span class="map__title">향후 추진계획</span>
					</div>
					<div class="map__content">
						<ul>
							<li><strong>2022.00.00~2023.00.00</strong>개발제한구역 해제(예정)</li>
							<li><strong>2022.00.00~2023.00.00</strong>실시계획 승인 고시(예정)	</li>	
							<li><strong>2027.00.00</strong>준공(예정)</li>		
						</ul>
						<div class="menteu">
							<ul>
								<li> - 추정용지비:2조원​</li>
							</ul>
						</div>
					</div>
					
					
					<div class="ui-tip__box">
						<p class="txt-tip txt-small">본 개발정보는 2021년 02월 27일까지 공개된 자료와 Gzone 당사가 직접 취재한 내용을 바탕으로 최종 수정된 자료입니다. 금일 이후 사업시행자의 상황 또는 경제여건의 변화 등에 따라 사업은 축소.획대.변경.취소 및 지연될수 있으니 이용자께서는 이점 유의하시길 바랍니다.</p>
						<p class="txt-tip txt-small">본개발정보는 참고사항이며 당사는 이에 대해 어떠한 경우라도 법적인 책임을 지지 않습니다.</p>
						<p class="txt-tip txt-small">본 개발정보의 지적소유권은 당사에 있으며 당사의 사전 허락없이 이를 무단으로 전제, 복제 할 경우 저작권법에 따라 처벌을 받게 됩니다.</p>
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
