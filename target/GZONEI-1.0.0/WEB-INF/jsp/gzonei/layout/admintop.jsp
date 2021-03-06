<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script>
sessionStorage.setItem("contextpath", "${pageContext.request.contextPath}");
sessionStorage.setItem("authVO",'${sessionScope.authVO2}');
function getContextPath() {
    return sessionStorage.getItem("contextpath");
}

var RemainDate = 1800;
var tid = null;
$(document).ready(function(){
	var message = '<c:out value="${redircetResult.message}"/>';
	if("" != message){
		swal({
			  title: message,
			  text: message,
			  icon: "warning",
			  buttons: "확인"
		}).then(function(){
			
		});
// 		alert(message);
	}else{
		//alert("no message");
	}
	LoginChk();
	
});

function LoginChk(){
	var loginVO = '<c:out value="${sessionScope.loginVO}"/>';
	if("" != loginVO){
		//로그인
// 		console.log("로그인 함");
		tid = setInterval('msg_time()',1000);
		$('#top_layout').addClass("login");
		$('#body').addClass("login");
		$('.utile_wrap .login').html("<a href='#'>LogOut</a>");
		$('.utile_wrap .login a').attr("href",'javascript:moveLogout();');
		$('.topUtile .login').html("<a href='#'>LogOut</a>");
		$('.topUtile .login a').attr("href",'javascript:moveLogout();');
	}else{
		//로그아웃
// 		console.log("로그아웃 함");
		$('#top_layout').removeClass("login");
		$('#body').removeClass("login");
		$('.utile_wrap .login').html("<a href='#'>LogIn</a>");
		$('.utile_wrap .login a').attr("href",'javascript:moveLogin();');
		$('.topUtile .login').html("<a href='#'>LogIn</a>");
		$('.topUtile .login a').attr("href",'javascript:moveLogin();');
		$('.login_util').css("display","none");
		$('.top .infor3').css("display","none");
		$('.top .infor4').css("display","none");
		$('.topUtile .bottom').css("display","none");
	}
};

function moveLogin(){
	window.location.href = '<c:url value="/cmmn/gzoneiLogin.do"/>'; 
}

function moveLogout(){
	sessionStorage.removeItem("authVO");
	window.location.href = '<c:url value="/cmmn/gzoneiActionLogout.do"/>';
}


function msg_time() {

  var min = Math.floor(RemainDate / 60) ;
  var sec = RemainDate % 60;
  if(sec == 0){
	  sec = "00";
  }else if(10>sec){
	  sec = "0"+sec;
  }
  
  m = min + ":" + sec + " 남음" ; // 남은 시간 text형태로 변경
  
  $('.infor3').html(m);			//영역에 보여줌
  
  if(RemainDate < 300){
	  $('.infor3').attr("style","color:#ff0000");
  }else{
	  $('.infor3').attr("style","color:#494949");
  }
  
  if (RemainDate <= 0) {      
    // 시간이 종료 되었으면..
    moveLogout();
    clearInterval(tid);   // 타이머 해제
  }else{
    //RemainDate = RemainDate - 1000; // 남은시간 -1초
    RemainDate = RemainDate - 1; // 남은시간 -1초
  }
}

function extendLogin(){
	//clearInterval(tid);
	RemainDate = 1800;
	//tid = setInterval('msg_time()',1000);
}
</script>
<header id="top_layout">
    <div class="fix">
        <!-- 로그인시 나타납니다 로그아웃시 출력 X start -->
        <div class="layout login_util">
            <ul>
                <li class="infor1"><em>${sessionScope.loginVO.gradCodeNm}</em><b><a href="<c:url value='/mypage/modifyMyInfo.do' />">${sessionScope.loginVO.userNm}</a></b>님</li>
                <li class="infor2">잔여기간 <b>
                        <c:choose>
		                <c:when test ="${sessionScope.loginVO.remindDay+0 eq 0+0} ">
		                	∞일
		                </c:when>
		                <c:when test ="${sessionScope.loginVO.remindDay+0 < 999+0} ">
		                	${sessionScope.loginVO.remindDay}일
		                </c:when>
		                <c:otherwise>
		                	999일
		                </c:otherwise>
		                </c:choose>
		                </b></li>
                <li class="infor3">30:00 남음</li>
                <li class="infor4"><a href="javascript:extendLogin();">연장</a></li>
                <li class="today">
                    <a href="<c:url value='/cmmnty/todayBbsList.do' />"><b>Today's</b> 보상계획공고 <em>유료존</em></a>   
                </li>
            </ul>
        </div>
        <!-- 로그인시 나타납니다 로그아웃시 출력 X end -->
        <div class="layout top_wrap">
            <h1 class="logo_wrap" id="logo"><a href="<c:url value='/main.do' />" class="ir ir-tmpl">GZONE</a></h1>
            <ul class="utile_wrap">
                <li class="login">
                    <!-- 로그아웃시 시 Login 텍스트로 교체 -->
                    <a href="#">Logout</a>
                </li>
                <li class="box pc" style="display:none; width:35px; height:35px;margin-left:10px;margin-top: 3px;">
                    <a id="btnAllmenu" href="<c:url value='/admin/member/memberList.do'/>" style="background:url(<%=request.getContextPath()%>/css/gzonei/SRC/images/main/system2.png) no-repeat;background-size:35px;"><span>관리자메뉴</span><i class="ir ir-tmpl"></i></a>
                </li>
                 <li class="box mo">
                    <button type="button" class="btn-allmenu " data-toggle="modal" data-target="#mobile-menu"><span class="sr-only">전체메뉴</span><i class="ir ir-tmpl"></i></button>
                </li>
            </ul>
        </div> 
        <nav id="gnb_layout">
            <div id="gnb">
                <!-- 공통메뉴틀 시작 -->
                <div class="gnb_wrap layout">
                    
                    <!-- 메뉴 시작 -->
                    <ul class="depth1_ul n7">
                    	 <li class="th1 n1">
                            <a href="<c:url value='/oper/viewBbsList.do ' />" class="th1_lnk"><span>결재 업무 게시판</span></a>
                            <ul class="depth2_ul">
                                <li><a href="<c:url value='/oper/viewBbsList.do ' />" target="_self">결재 업무 게시판</a></li>
                            </ul>
                        </li>
                        <li class="th1 n2">
                            <a href="<c:url value='/admin/today/prtnSttus.do' />" class="th1_lnk"><span>오늘의 정보</span></a>
                            <ul class="depth2_ul">
                            	<li><a href="<c:url value='/admin/today/prtnSttus.do' />" target="_self">오늘의 취재</a></li>
                            	<li><a href="<c:url value='/admin/today/developGosi.do' />" target="_self">개발정보 필수고시</a></li>
                            	<li><a href="<c:url value='/admin/today/reqDevelopInfo.do'/>" target="_self">개발정보 필수정보</a></li>
                            </ul>
                        </li>
                        <li class="th1 n3">
                            <a href="<c:url value='/admin/member/memberList.do' />" class="th1_lnk"><span>사용자관리</span></a>
                            <ul class="depth2_ul">
                            	<li><a href="<c:url value='/admin/member/memberList.do' />" target="_self">회원 관리</a></li>
                            	<li><a href="<c:url value='/admin/member/connectList.do' />" target="_self">접속 이력</a></li>
                            	<li><a href="<c:url value='/admin/member/penaltyList.do' />" target="_self">패널티</a></li>
                            	<li><a href="<c:url value='/admin/member/secessionList.do' />" target="_self">탈퇴 신청</a></li>
                            </ul>
                        </li>
                        <li class="th1 n4">
                            <a href="<c:url value='/oper/groupManage.do' />" class="th1_lnk"><span>운영관리</span></a>
                            <ul class="depth2_ul">
                                <li><a href="<c:url value='/oper/groupManage.do' />" target="_self">그룹관리</a></li>
                            	<li><a href="<c:url value='/oper/codeManage.do' />" target="_self">코드관리</a></li>
<!--                             	<li><a href="javascript:alert('준비중입니다.');" target="_self">통계관리</a></li> -->
                            	<li><a href="<c:url value='/oper/selectDevBestList.do' />" target="_self">샘플관리</a></li>
                            	<li><a href="<c:url value='/admin/bannerRegist.do' />" target="_self">배너관리</a></li>
                            </ul>
                        </li>
                        <li class="th1 n5">
                            <a href="<c:url value='/admin/gradAuth/gradAuthManage.do' />" class="th1_lnk"><span>등급권한관리</span></a>
                            <ul class="depth2_ul">
                            	<li><a href="<c:url value='/admin/gradAuth/gradAuthManage.do' />" target="_self">등급권한관리</a></li>
                            	<li><a href="<c:url value='/admin/bsnsDstrc/selectBsnsDstrc.do' />" target="_self">사업지구관리</a></li>
                            </ul>
                        </li>
                        <li class="th1 n6">
                            <a href="<c:url value='/admin/payment/excclcList.do' />" class="th1_lnk"><span>결제 관리</span></a>
                            <ul class="depth2_ul">
                            	<li><a href="<c:url value='/admin/payment/excclcList.do' />" target="_self">정산 관리</a></li>
                            	<li><a href="<c:url value='/admin/payment/nbkkCnfirmList.do' />" target="_self">무통장 승인</a></li>
                            </ul>
                        </li> 
                    </ul>
                </div>
                <span class="line"></span>
                <!-- 공통메뉴틀 끝 -->
           </div>
        </nav>
    </div>
    <!-- 모바일 메뉴 -->
    <div class="modal fade" id="mobile-menu" role="dialog" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="topUtile">
                    <ul class="top">
                        <li class="infor3">30:00 남음</li>
                        <li class="infor4"><a href="javascript:extendLogin();">연장</a></li>
                        <li class="login">
                            <!-- 로그아웃시 시 Login 텍스트로 교체 -->
                            <a href="#">Logout</a>
                        </li>
                    </ul>
                    <ul class="bottom">
                        <li class="infor1"><em>${sessionScope.loginVO.gradCodeNm}</em><b>${sessionScope.loginVO.userNm}</b>님</li>
                        <li class="infor2">잔여기간 <b>
                        <c:choose>
		                <c:when test ="${sessionScope.loginVO.remindDay < 999} ">
		                	${sessionScope.loginVO.remindDay}일
		                </c:when>
		                <c:otherwise>
		                	999일
		                </c:otherwise>
		                </c:choose>
		                	</b></li>
                        <li class="today">
                            <a href="<c:url value='/cmmnty/todayBbsList.do' />"><b>Today's</b> 보상계획공고 <em>유료존</em></a>   
                        </li>
                    </ul>
                </div>
                <div class="modal-body accordion">
                    <ul class="depth1_ul n3">
                        <li class="n1">
                            <a data-target="#mMenu_modal1" href="<c:url value='/oper/viewBbsList.do ' />" class="ov"><span>결재 업무 게시판</span></a>
                             <ul class="depth2_ul" id="mMenu_modal1" data-parent="#mobile-menu" style="display: none;">
                                <li class=""><a href="<c:url value='/oper/viewBbsList.do ' />" class="" data-menu="depth2"><span>결재 업무 게시판</span></a></li>
                            </ul>
                         </li>
                        <li class="n2">
                            <a data-target="#mMenu_modal2" href="<c:url value='/admin/today/prtnSttus.do' />" class="ov"><span>오늘의 정보</span></a>
                             <ul class="depth2_ul" id="mMenu_modal2" data-parent="#mobile-menu" style="display: none;">
                                <li class=""><a href="<c:url value='/admin/today/prtnSttus.do' />" class="" data-menu="depth2"><span>오늘의 취재</span></a></li>
                                <li class=""><a href="<c:url value='/admin/today/developGosi.do' />" class="" data-menu="depth2"><span>개발정보 필수고시</span></a></li>
                                <li class=""><a href="<c:url value='/admin/today/reqDevelopInfo.do'/>" class="" data-menu="depth2"><span>개발정보 필수정보</span></a></li>
                            </ul>
                         </li>
                         <li class="n3">
                            <a data-target="#mMenu_modal3" href="<c:url value='/admin/member/memberList.do' />" class=""><span>사용자관리</span></a>
                            <ul class="depth2_ul" id="mMenu_modal3" data-parent="#mobile-menu" style="display: none;">
                                <li class=""><a href="<c:url value='/admin/member/memberList.do' />" class="" data-menu="depth2"><span>회원 관리</span></a></li>
                                <li class=""><a href="<c:url value='/admin/member/connectList.do' />" class="" data-menu="depth2"><span>접속 이력</span></a></li>
                                <li class=""><a href="<c:url value='/admin/member/penaltyList.do' />" class="" data-menu="depth2"><span>패널티</span></a></li>
                                <li class=""><a href="<c:url value='/admin/member/secessionList.do' />" class="" data-menu="depth2"><span>탈퇴 신청</span></a></li>
                            </ul>
                        </li>
                        <li class="n4">
                            <a data-target="#mMenu_modal4" href="<c:url value='/oper/viewBbsList.do ' />" class=""><span>운영관리</span></a>
                            <ul class="depth2_ul" id="mMenu_modal4" data-parent="#mobile-menu" style="display: none;">
                                <li class=""><a href="javascript:alert('준비중입니다.');" class="" data-menu="depth2"><span>그룹관리</span></a></li>
                                <li class=""><a href="<c:url value='/oper/codeManage.do ' />" class="" data-menu="depth2"><span>코드관리</span></a></li>
                                <li class=""><a href="javascript:alert('준비중입니다.');" class="" data-menu="depth2"><span>통계관리</span></a></li>
                                <li class=""><a href="javascript:alert('준비중입니다.');" class="" data-menu="depth2"><span>샘플관리</span></a></li>
                                <li class=""><a href="javascript:alert('준비중입니다.');" class="" data-menu="depth2"><span>배너관리</span></a></li>
                            </ul>
                        </li>
                        <li class="n5">
                            <a data-target="#mMenu_modal5" href="javascript:alert('준비중입니다.');" class=""><span>등급권한관리</span></a>
                            <ul class="depth2_ul" id="mMenu_modal5" data-parent="#mobile-menu" style="display: none;">
                                <li class=""><a href="javascript:alert('준비중입니다.');" class="" data-menu="depth2"><span>권한관리</span></a></li>
                                <li class=""><a href="javascript:alert('준비중입니다.');" class="" data-menu="depth2"><span>사업지구관리</span></a></li>
                            </ul>
                        </li>
                        <li class="n6">
                            <a data-target="#mMenu_modal6" href="<c:url value='/admin/payment/excclcList.do' />" class=""><span>결제 관리</span></a>
                            <ul class="depth2_ul" id="mMenu_modal6" data-parent="#mobile-menu" style="display: none;">
								<li class=""><a href="<c:url value='/admin/payment/excclcList.do' />" class="" data-menu="depth2"><span>정산 관리</span></a></li>
								<li class=""><a href="<c:url value='/admin/payment/nbkkCnfirmList.do' />" class="" data-menu="depth2"><span>무통장 승인</span></a></li>
                            </ul>
                        </li>
                    </ul>       
                </div>
                    <button type="button" class="mobile-close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">닫기</span></button>
            </div>
        </div>
    </div>
    <!-- 모바일 메뉴 -->
	<script src="<c:url value='/css/gzonei/SRC/js/acego.gnb.js' />"></script>
	<script>
	    (function(){
	        var param = "#gnb_layout",
	            obj = ".depth2_ul",
	            btn = ".depth1_ul>li",
	            wrap = "#top_layout",
	            dur = 300,
	            meth = "easeOutCubic";
	        gnb(param,obj,btn,wrap,dur,meth);
	        gnb_open();
	    }());
	</script>
</header>

