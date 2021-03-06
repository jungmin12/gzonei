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
                <h2 class="page__title">서비스 전체보기</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="<c:url value='/design/useGuidanceView.do'/>">서비스 안내</a></li>
                        <li class="n3"><a href="<c:url value='/design/sitemapView.do'/>" class="navi_ov">서비스 전체보기</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">
            <!-- content 영역입니다. -->

                <div class="sub0903_wrap">
                    <div class="box_list">
                        <strong>개발정보</strong>
                        <ul>
                            <li><a href="<c:url value='/map.do?tabId=dev'/>">개발정보</a></li>
                        </ul>
                    </div>
                    <div class="box_list">
                        <strong>투자정보</strong>
                        <ul>
                            <li><a href="<c:url value='/map.do?tabId=invt'/>">투자정보</a></li>
                        </ul>
                    </div>
                    <div class="box_list">
                        <strong>샘플보기</strong>
                        <ul>
                            <li><a href="<c:url value='/free/devFreeView.do?smpleNo=1'/>">개발정보</a></li>
                            <li><a href="<c:url value='/design/invtFreeView.do'/>">투자정보</a></li>
                        </ul>
                    </div>
                    <div class="box_list">
                        <strong>지존스토어</strong>
                        <ul>
                            <li><a href="<c:url value='/str/strSuccesBbsList.do'/>">보상 투자 성공사례</a></li>
                            <li><a href="<c:url value='/str/strFailrBbsList.do'/>">보상 투자 실패사례</a></li>
<!--                             <li><a href="#">지존 출판도서</a></li> -->
<!--                             <li><a href="#">지존 추천도서</a></li> -->
                        </ul>
                    </div>
                    <div class="box_list">
                        <strong>커뮤니티</strong>
                        <ul>
                            <li><a href="<c:url value='/cmmnty/noticeBbsList.do'/>">공지사항</a></li>
                            <li><a href="<c:url value='/cmmnty/focusBbsList.do'/>">지존포커스</a></li>
                            <li><a href="<c:url value='/cmmnty/mmnwsBbsList.do'/>">토지보상뉴스</a></li>
                            <li><a href="<c:url value='/cmmnty/nwsBbsList.do'/>">보도자료</a></li>
                            <li><a href="<c:url value='/cmmnty/colmnBbsList.do'/>">칼럼</a></li>
                            <li><a href="<c:url value='/cmmnty/qnaBbsList.do'/>">Q&A게시판</a></li>
<!--                             <li><a href="#">카페</a></li> -->
                        </ul>
                    </div>
                    <!-- 
                    <div class="box_list">
                        <strong>地知GO</strong>
                        <ul>
                            <li><a href="#">토지 골든벨</a></li>
                            <li><a href="#">지존이 쏜다</a></li>
                        </ul>
                    </div>
                     -->
                    <div class="box_list">
                        <strong>부가서비스</strong>
                        <ul>
                            <li><a href="<c:url value='/adisvc/recsroomBbsList.do'/>">자료실</a></li>
                            <li><a href="<c:url value='/adisvc/rewardPrcdntBbsList.do'/>">보상판례</a></li>
                            <li><a href="<c:url value='/design/usfulSiteView.do'/>">유용한사이트</a></li>
                            <li><a href="<c:url value='/design/ladRewardView.do'/>">토지보상 검토의뢰</a></li>
                        </ul>
                    </div>
                    <div class="box_list">
                        <strong>마이페이지</strong>
                        <ul>
                            <li><a href="<c:url value='/mypage/modifyMyInfo.do'/>">회원정보 수정</a></li>
                            <li><a href="<c:url value='/mypage/secessionReqst.do'/>">회원탈퇴 신청</a></li>
                            <li><a href="<c:url value='/mypage/mypaymentList.do'/>">나의 결제내역</a></li>
                            <li><a href="<c:url value='/mypage/interestList.do'/>">나의 관심정보</a></li>
                            <li><a href="<c:url value='/mypage/payReqst.do'/>">결제/연장하기</a></li>
                        </ul>
                    </div>
                    <div class="box_list">
                        <strong>서비스 안내</strong>
                        <ul>
                            <li><a href="<c:url value='/design/useGuidanceView.do'/>">이용 안내</a></li>
                            <li><a href="<c:url value='/design/chrgeGuidanceView.do'/>">요금 안내</a></li>
                            <li><a href="<c:url value='/design/sitemapView.do'/>">서비스 전체보기</a></li>
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
