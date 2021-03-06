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
<script type="text/javascript"
		src="<c:url value='/js/gzonei/locFiledownload.js' />"></script>

<%@ include file="/WEB-INF/jsp/gzonei/layout/top.jsp" %>

<!-- 구현부 : S -->
<script>
$( document ).ready(function() {
	$("#docDown").on("click", function(e) {
		var url = e.currentTarget.dataset.url;
		$.fileDownload(url,{
		  httpMethod: "POST"
		});
	});
});
</script>
<div id="body_layout">	

    <!-- layout -->
    <div class="body_wrap">      
        <div id="contens" class="contents_wrap  sub0704">
            <div id="location" class="title_wrap">
                <h2 class="page__title">토지보상 검토의뢰</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="<c:url value='/adisvc/recsroomBbsList.do'/> ">부가서비스</a></li>
                        <li class="n3"><a href="<c:url value='/design/ladRewardView.do'/> " class="navi_ov">토지보상 검토의뢰</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">
            <!-- content 영역입니다. -->

                <div class="sub0704_wrap">
                    <div class="bg"></div>
                    <div class="inner layout">
                        <strong class="tit">본 서비스의 이용요금은 무료이며 <span>(주)지존이 부설한 <em>지존토지보상지원센터</em>에서 </span>해당 업무를 수행합니다.</strong>
                        <div class="intro">
                            <div class="top">
                                <img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0704_img01.png'/>" alt="김영우 센터장 사진">
                                <em>지존토지보상지원센터 센터장</em>
                                <strong>김영우 박사</strong>
                            </div>
                            <div class="bottom">
                                <ul>
                                    <li>명지대학교 부동산대학원 겸임교수</li>
                                    <li>대한행정사협회 토지보상법 교수</li>
                                    <li>한국부동산개발협회 부동산개발전문인력 교수</li>
                                    <li>前 한국도로협회 상근부회장</li>
                                    <li>前 국토교통부 부이사관(중앙토지수용위원회등 재직)</li>
                                    <li>前 국토교육인재개발원 토지보상법 강사</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="con">
                    <div class="layout">
                    <ul class="guide_list">
                            <li>
                                <span class="ir ico1"></span>
                                <div class="txt">
                                    <p>지존토지보상지원센터는 의뢰서 접수 후 <span>원칙적으로 2주 이내에 그 처리 결과를 의뢰인에게 </span>메일로 통지합니다.</p>
                                </div>
                            </li>
                            <li>
                                <span class="ir ico2"></span>
                                <div class="txt">
                                    <p>단, 의뢰서가 접수된 후 업무 수행에 필요하다고 인정될 경우, <span>지존 토지 보상지원센터는 추가 서류(감정평가서) 등을 요청할 수 있으며 </span>이 기간은 처리 기간에 산입되지 않습니다.</p>
                                </div>
                            </li>
                            <li>
                                <span class="ir ico3"></span>
                                <div class="txt">
                                    <p>토지보상금 적정성 검토 컨설팅이 종료된 후 <span>신청인이 토지보상금 증액 컨설팅을 추가로 요청할 경우, </span>서비스 이용요금 할인 혜택을 드립니다.</p>
                                </div>
                            </li>
                            <li>
                                <span class="ir ico4"></span>
                                <div class="txt">
                                    <p>(주)지존(지존토지보상지원센터)은 토지보상금 정보 <span>이외에는 어떠한 경우에도 신청인의 개인정보를 수집, 보관 및 </span>활용하지 않습니다.</p>
                                </div>
                            </li>
                            <li>
                                <span class="ir ico5"></span>
                                <div class="txt">
                                    <p>신청서 접수는 지존 홈페이지 전용코너를 통해 신청서를 다운받아 작성한 후  이메일 <a href="mailto:gzonetop@naver.com"><em>gzonetop@naver.com</em> </a>또는 fax(팩스) 02-322-3154번으로 신청서와 필지별 협의 보상금 통지서를 보내시면 됩니다.</p>
                                    <a id='docDown' data-url="<c:url value='/css/gzonei/SRC/images/contents/sub07/downfile.hwp'/>" class="btn btn-primary">신청서 다운로드</a>
                                </div>
                            </li>
                            <li>
                                <span class="ir ico6"></span>
                                <div class="txt">
                                    <p>기타문의 사항은 (주)지존 02-322-3152(대표) 또는 <span>지존토지보상지원센터 02-534-8393번으로 문의하시길 바랍니다.</span></p>
                                </div>
                            </li>
                        </ul>
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
