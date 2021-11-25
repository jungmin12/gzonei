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
<script>
sessionStorage.setItem("contextpath", "${pageContext.request.contextPath}");

function getContextPath() {
    return sessionStorage.getItem("contextpath");
}

function fncGoAfterErrorPage(){
    history.back(-2);
}

$(document).ready(function(){
	
	$('.login_util').css("display","none");
	$('#top_layout').removeClass("login");
	
});
</script>
<body>
<header id="top_layout">
    <div class="fix">
        <!-- 로그인시 나타납니다 로그아웃시 출력 X start -->
        <div class="layout login_util" style="display:none;">
            <ul>
                <li class="infor1"><em>${sessionScope.loginVO.gradCodeNm}</em><b><a href="#">${sessionScope.loginVO.userNm}</a></b>님</li>
                <li class="infor2">잔여기간 <b>${sessionScope.loginVO.remindDay}일</b></li>
                <li class="infor3">30:00 남음</li>
                <li class="infor4"><a href="javascript:extendLogin();">연장</a></li>
                <li class="today">
                    <a href="#"><b>Today's</b> 보상계획공고 <em>유료존</em></a>   
                </li>
            </ul>
        </div>
        <!-- 로그인시 나타납니다 로그아웃시 출력 X end -->
        <div class="layout top_wrap">
            <h1 class="logo_wrap" id="logo"><a href="<c:url value='/main.do' />" class="ir ir-tmpl">GZONE</a></h1>
            <ul class="utile_wrap">
            </ul>
        </div> 
        <nav id="gnb_layout">
            <div id="gnb">
                <!-- 공통메뉴틀 시작 -->
                <div class="gnb_wrap layout">
                    
                    <!-- 메뉴 시작 -->
                    <ul class="depth1_ul n6">
                        <li class="th1 n1">
                        </li>
                        <li class="th1 n2">
                        </li>
                        <li class="th1 n3">
                        </li>
                        <li class="th1 n4">
                        </li>

                        <li class="th1 n5">
                        </li>
                        <li class="th1 n6">
                        </li>
                    </ul>
                    <!-- 메뉴 끝 -->

                </div>
                <span class="line"></span>
                <!-- 공통메뉴틀 끝 -->
           </div>
        </nav>
    </div>
    <!-- 모바일 메뉴 -->
    <div class="modal fade" id="mobile-menu" role="dialog" aria-hidden="true" style="display:none;">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="topUtile">
                    <ul class="top">
                        
                    </ul>
                    <ul class="bottom">
                        
                    </ul>
                </div>
                <div class="modal-body accordion">
                    <ul class="depth1_ul n3">
                        <li class="n1">
                         
                         </li>
                         <li class="n2">
                         
                        </li>
                        <li class="n3">
                        
                        </li>
                        <li class="n4">
                        
                        
                        </li>
                        <li class="n5">
                        
                        </li>
                        <li class="n6">
                        
                        </li>
                    </ul>       
                </div>
                    <button type="button" class="mobile-close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">닫기</span></button>
            </div>
        </div>
    </div>
   
</header>

<!-- 구현부 : S -->

<div id="body_layout">	
    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
        
            <div id="txt">
            <!-- content 영역입니다. -->

				<div class="agree_wrap">
				    <div class="header">
				        <h4 class="modal__title">시스템 에러</h4>
				        <br/>
				        <p>알 수 없는 오류가 발생했습니다!</p>
				        <p> 관리자에게 문의해주세요.</p>
				    </div>
				</div>
				<div class="agree">
				    <div class="text-center">
				        <button type="button" class="btn btn-primary" onclick="fncGoAfterErrorPage();">돌아가기</button>
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
