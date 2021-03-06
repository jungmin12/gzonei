<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<div id="banner">
    <div class="layout">
        <ul>
            <li><a href="<c:url value='/design/cmpnyIntrcnView.do'/>">회사소개</a></li>
            <li><a href="<c:url value='/design/cmpnyHistView.do'/>">연혁</a></li>
            <li><a href="<c:url value='/design/useStplatView.do'/>">이용약관</a></li>
            <li><a href="<c:url value='/design/indvdlinfoPolcyView.do'/>">개인정보취급방침</a></li>
            <li><a href="<c:url value='/design/advrtsCoprtnView.do'/>">광고업무제휴문의</a></li>
            <li><a href="<c:url value='/design/chrgeGuidanceView.do'/>">요금안내</a></li>
            <li><a href="<c:url value='/design/sitemapView.do'/>">서비스전체보기</a></li>
        </ul>
    </div>
</div>
<div class="wrap-loading display-none">
	<div>
<%-- 		<img src="<c:url value='/css/gzonei/SRC/images/map/loadingBar.gif' />" --%>
			
	</div>
</div>
<footer id="foot_layout">
    <!-- 푸터틀 시작 -->
    <div class="layout">
        <a href="javascript:scrollMotionListener();" id="btnTop" title="컨텐츠 상단으로 이동">컨텐츠 상단으로 이동</a>
        <div class="footer-info">
            <strong class="logo">GZONE 전국개발정보</strong>
            <p><span>(주)지존</span>  <span>서울특별시 영등포구 당산로 246 viewtiful tower 6F, 8F</span> <span>사업자등록번호 743-88-00139</span></p>
            <p><span>대표이사 : 신태수</span><span>개인정보보호정책책임자 : 이호간</span><span>통신판매신고 제2020-서울영등포-1492호   </span></p>
            <p><span>문의 02-322-3152 (代) FAX. 02-322-3154</span><span>홍보실 02-2678-7451 (代) FAX. 02-2678-7454</span></p>
            <p class="copy">copyright (c) Gzone Corp. All rights reserved.</p>
        </div>
        <div class="qna">
            <strong>회원가입문의</strong>
            <div class="txt">
                <b>02-322-3152</b>
                <p><em>상담가능시간</em> 평일 09:00 ~ 18:00</p>
            </div>
        </div>    
    </div>
    <!-- 푸터틀 끝 -->
</footer>



