<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang='ko'>
<head>
<title>전국개발정보 지존</title>
<meta name="robots" content="index,follow">
<meta name="author" content="전국개발정보 지존 ">
<meta name="keywords" content="토지보상, 부동산개발정보, 아너스클럽">
<meta name="description" content="토지보상, 부동산개발정보, 아너스클럽" />
<meta name="copyright" content="copyright (c) Gzone Corp. All rights reserved.">
<meta property="og:title" content="전국개발정보 지존" />
<meta property="og:type" content="전국개발정보 지존" />
<meta name="og:description" content="토지보상, 부동산개발정보, 아너스클럽" />
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="shortcut icon" type="image/x-icon" href="<c:url value='/css/gzonei/SRC/images/common/favicon.ico' />">
<link rel="apple-touch-icon-precomposed" href="<c:url value='/css/gzonei/SRC/images/common/favicon.png' />">

<link rel="stylesheet" href="<c:url value='/css/gzonei/SRC/pcms/common/css/common.css' />" />
<link rel="stylesheet" href="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/bootstrap/bootstrap.min.css' />" />
<link rel="stylesheet" href="<c:url value='/css/gzonei/SRC/pcms/common/font/font_gothic.css' />" media="all">
<link rel="stylesheet" href="<c:url value='/css/gzonei/SRC/pcms/common/font/font_gmarketsans.css' />" media="all">

<link rel="stylesheet" href="<c:url value='/css/gzonei/SRC/css/acego.header.css' />" />
<!-- <link rel="stylesheet" href="<c:url value='/css/gzonei/SRC/css/acego.layout.css' />" /> -->
<link rel="stylesheet" href="<c:url value='/css/gzonei/SRC/css/acego.footer.css' />" />
<link rel="stylesheet" href="<c:url value='/css/gzonei/SRC/css/main.css' />" />

<link rel="stylesheet" href="<c:url value='/css/podo.css' />" />

<script src="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/jQuery/jquery-3.3.1.min.js' />"></script>
<script src="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/jQuery/jquery-migrate-1.4.1.min.js' />"></script>
<script src="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/jQueryUI/jquery-ui.min.js' />"></script>
<script src="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/bootstrap/bootstrap.min.js' />"></script>
<script src="<c:url value='/css/gzonei/SRC/pcms/common/js/acego.common.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/gzonei/mainPage.js' />"></script>
<script src="<c:url value='/css/gzonei/SRC/js/common.js' />"></script>
<!--[if lt IE 9]>
    <script src="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/html5/html5shiv.min.js' />"></script>
<![endif]-->

<link rel="stylesheet" href="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/slick/slick.css' />">
<script src="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/slick/slick.js' />"></script>
<script src="<c:url value='/css/gzonei/SRC/pcms/common/js/popzone/common-popup.js' />"></script>
<script type="text/javascript" src="<c:url value='/css/gzonei/SRC/pcms/common/js/scroll/common-scroll.js' />"></script>
<link href="<c:url value='/css/gzonei/SRC/js/mCustomScrollbar/jquery.mCustomScrollbar.css' />" rel="stylesheet" type="text/css" /> 
<script src="<c:url value='/css/gzonei/SRC/js/mCustomScrollbar/jquery.mCustomScrollbar.concat.min.js' />"></script>
<script src="<c:url value='/css/gzonei/SRC/js/atoh.js' />"></script>
<script src="<c:url value='/css/gzonei/SRC/js/Hangul.js' />"></script>
<!-- 개발서버 -->
<!-- 
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0f1f8f2c7f914174f9e28f77fe45c1e7"></script>
 -->
<!-- 개인로컬서버 -->


<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d66487bcadf6db5ece95fbe4b6e5049a&libraries=services,clusterer,drawing"></script> -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=effad4d17be3943669dbae719f538667&libraries=services,clusterer,drawing"></script>
<script src="<c:url value='/css/gzonei/SRC/js/main.js' />"></script>
<script type="text/javascript"	src="<c:url value='/js/gzonei/map/sweetalert.min.js' />"></script>
<!--엑셀 다운로드 JS -->
<script language="javascript" src="<c:url value='/js/gzonei/xlsx.full.min.js' />"></script>
<script language="javascript" src="<c:url value='/js/gzonei/FileSaver.min.js' />"></script>
<script language="javascript" src="<c:url value='/js/gzonei/excel.js' />"></script>
<script>
sessionStorage.setItem("contextpath", "${pageContext.request.contextPath}");
sessionStorage.setItem("authVO",'${sessionScope.authVO2}');
function getContextPath() {
    return sessionStorage.getItem("contextpath");
}

var RemainDate = 1800;
var tid = null;
$(document).ready(function(){
	var height =  $(".notice").height(); //공지사항의 높이값을 구해주고~~
	var num = $(".rolling li").length; // 공지사항의 개수를 알아볼수 있어요! length라는 것으로!
	var max = height * num; //그렇다면 총 높이를 알 수 있겠죠 ?
	var move = 0; //초기값을 설정해줍니다.
	function noticeRolling(){
		move += height; //여기에서 += 이라는 것은 move = move + height 값이라는 뜻을 줄인 거에요.
		$(".rolling").animate({"top":-move},2000,function(){ // animate를 통해서 부드럽게 top값을 올려줄거에요.
			if( move >= max ){ //if문을 통해 최대값보다 top값을 많이 올렸다면 다시 !
				$(this).css("top",0); //0으로 돌려주고~
				move = 0; //초기값도 다시 0으로!
			};
		});
	};
	noticeRollingOff = setInterval(noticeRolling,3000); //자동롤링답게 setInterval를 사용해서 1000 = 1초마다 함수 실행!!
	$(".rolling").append($(".rolling li").first().clone()); //올리다보면 마지막이 안보여서 clone을 통해 첫번째li 복사!
	
	
	//<p class="topinfo"><b> ${devCt.dt} 현재 기준</b>개발정보 <b>${devCt.devCount}</b>건 / 투자정보 ${devCt.invtCount}건</p>.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
	
	var dt = '<c:out value="${devCt.dt}"/>';
	var devCount = '<c:out value="${devCt.devCount}"/>';
	devCount = devCount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	var invtCount = '<c:out value="${devCt.invtCount}"/>';
	invtCount = invtCount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	var invtTotCount = '<c:out value="${devCt.invtTotCount}"/>';
	invtTotCount = invtTotCount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	
	var topInfoHtml = '';
	topInfoHtml += '<b> ' + dt + ' 현재 기준</b>개발정보 <span style="color: #ff0000;font-weight: bold;">' + devCount + '</span>건 / 투자정보 <span style="color: #ff0000;font-weight: bold;">' + invtTotCount + '</span>건(<span style="color: #ff0000;font-weight: bold;">' + invtCount + '</span>건)</p>';
	$('#topinfo').html(topInfoHtml);
	
	
	var message = '<c:out value="${redircetResult.message}"/>';
	var errorCode = '<c:out value="${redircetResult.errorCode}"/>';
	if("" != message && "MULTI" != errorCode){
		swal({
			  title: message,
			  text: "로그인화면으로 이동 하시겠습니까?",
			  icon: "warning",
			  buttons: ["취소", "이동"]
		}).then(function(result) {
		  if (result) {
			  location.href="cmmn/gzoneiLogin.do";
		  }
		});
	}else if("" != message && "MULTI" == errorCode){
		swal({
			  title: "법인회원 동시로그인 안내",
			  text: message,
			  icon: "info",
			  buttons: "확인"
		}).then(function(result) {
		  
		});
	}
	LoginChk();
// 	today 보상공고 
	var message2 = '<c:out value="${bbsredircetResult.message}"/>';
	if("" != message2){
		swal({
			  title: message2,
			  icon: "warning",
			  text: "결제화면으로 이동 하시겠습니까?",
			  buttons: ["취소","이동"]
		}).then(function(result){
		  if (result) {
			  location.href="mypage/payReqst.do";
		  }
		}); 
	}
	
	
});

function LoginChk(){
	var loginVO = '<c:out value="${sessionScope.loginVO.indvdlMberCode}"/>';
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
		if('CM00210003'== loginVO){
			$('.box.pc').css("display","inline-block");
		}
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
		$('.box.pc').css("display","none");
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
</head>
<body id="body">
<!-- 오픈팝업 시작 -->
<div id="op_layout">
	<a class="opBtn_open" href="#">팝업존<b>OPEN</b></a>
    <div class="main-photo__skin" id="op_slide">
        <div class="photo_list--wrap">
            <div class="photo_list--slider">
                <!-- 
                <div class="photo_list--item">
                    <a href="#" class="js-link" data-id="modalNews" data-url="#link">
                    
                        <span class="icon"><img src="<c:url value='/css/gzonei/SRC/images/main/popup_img.jpg' />" alt=""/></span>
                        <span class="copy">
                            <span class="txt">당신 인생의 모든 순간, 법무사가 함께합니다</span>
                            <span class="tit">법무사 박문수</span>
                        </span> 
                    </a>
                </div>  
                -->
<!--                 <div class="photo_list--item"> -->
<!--                     <a href="#" class="js-link" data-id="modalNews" data-url="#link"> -->
<%--                         <img src="<c:url value='/css/gzonei/SRC/images/main/tpopup_img01.jpg'/> " alt=""/> --%>
<!--                     </a> -->
<!--                 </div> -->
                <%-- 
                <div class="photo_list--item">
                    <a href="#" class="js-link" data-id="modalNews" data-url="#link">
                        <img src="<c:url value='/css/gzonei/SRC/images/main/tpopup_img01.jpg'/>" alt=""/>
                    </a>
                </div>
                 --%>
                <%--상단배너 --%>
                <c:forEach items="${topSlideList }" var="topList" varStatus="status">
 					<div class="photo_list--item">
 					<c:choose>
 						<c:when test="${topList.url == null or topList.url == ''}">
							<a href="#" target="_blank" class="js-link" data-id="modalNews" data-url="#link">
	                        	<img src="<c:url value='/file/displayFile.do?filePath=/home/gzoneiweb/${topList.fileStreCours }&fileName=${topList.streFileNm }'/>" alt=""/>
	                    	</a>		
 						</c:when>
 						<c:otherwise> 						
	                    	<a href="${topList.url }" target="_blank" class="js-link" data-id="modalNews" data-url="#link">
	                        	<img src="<c:url value='/file/displayFile.do?filePath=/home/gzoneiweb/${topList.fileStreCours }&fileName=${topList.streFileNm }'/>" alt=""/>
	                    	</a>
 						</c:otherwise>
 					</c:choose>
                	</div>              
                </c:forEach> 
            </div>
            <div class="slider-control">
                <button type="button" class="ir ir-main popup__button prev slick-arrow">팝업 이전</button>
                <button type="button" class="ir ir-main popup__button pause">팝업 정지</button>
                <button type="button" class="ir ir-main popup__button play">팝업 재생</button>
                <button type="button" class="ir ir-main popup__button next slick-arrow">팝업 다음</button>
            </div>
        </div>
    </div>
    <div class="opBtn_close">
        <form name="todayChk_form">
            <span class="today_close">
                <input type="checkbox" name="${siteCode}_todayChk" id="todayChk">
				<label for="todayChk">오늘하루 열지않기</label>
            </span>
            <a href="#">닫기</a>
        </form>
    </div>
</div>
<!-- 오픈팝업 끝 -->


<!-- *** 로그인시 나타납니다 addClass login *** -->
<header id="top_layout" class="">
    <div class="fix">
        <!-- 로그인시 나타납니다 로그아웃시 출력 X start -->
        <div class="layout login_util">
            <ul>
                <li class="infor1"><em>${sessionScope.loginVO.gradCodeNm}</em><b><a href="<c:url value='/mypage/modifyMyInfo.do' />">${sessionScope.loginVO.userNm}</a></b>님</li>
                <li class="infor2">잔여기간 <b>
                <c:choose>
                <c:when test ="${sessionScope.loginVO.remindDay+0 lt 999+0} ">
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
                    <a href="<c:url value="/cmmnty/todayBbsList.do"/>"><b>Today's</b> 보상계획공고 <em>유료존</em></a>   
                </li>
            </ul>
        </div>
        <!-- 로그인시 나타납니다 로그아웃시 출력 X end -->
        <div class="layout top_wrap">
            <h1 class="logo_wrap" id="logo"><a href="<c:url value='/main.do' />" class="ir ir-tmpl">GZONE</a></h1>
            <ul class="utile_wrap">
<!--             	<li class="gzone"> -->
<!--                 	<a href="http://www2.gzonei.com" target="_blank">gzone</a> -->
<!--                 </li> -->
                <li class="login">
                    <!-- 로그아웃시 시 Login 텍스트로 교체 -->
                    <a href="#">Login</a>
                    
                </li>
                <li class="box pc" style="display:none; width:35px; height:35px;margin-left:10px;margin-top: 3px;">
                    <a id="btnAllmenu" href="<c:url value='/oper/viewBbsList.do'/>" style="background:url(<%=request.getContextPath()%>/css/gzonei/SRC/images/main/system2.png) no-repeat;background-size:35px;"><span>관리자메뉴</span><i class="ir ir-tmpl"></i></a>
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
                            <a href="<c:url value='/map.do?tabId=dev' />" class="th1_lnk"><span>개발정보</span></a>
                        </li>
                        <li class="th1 n2">
                            <a href="<c:url value='/map.do?tabId=invt' />" class="th1_lnk"><span>투자정보</span></a>
                        </li>
                        <li class="th1 n3">
                            <a href="<c:url value='/str/strBbsList.do' />" class="th1_lnk"><span>지존스토어</span></a>
                            <ul class="depth2_ul">
                                <li><a href="<c:url value='/str/strSuccesBbsList.do' />" target="_self">보상투자성공사례</a></li>
                                <li><a href="<c:url value='/str/strFailrBbsList.do' />" target="_self">보상투자실패사례</a></li>
                                <!-- 
                                <li><a href="#" target="_self">보상판례</a></li>
                                <li><a href="#" target="_self">지존출판도서</a></li>
                                <li><a href="#" target="_self">지존추천도서</a></li>
                                 -->
                            </ul>
                        </li>
                        <li class="th1 n4">
                            <a href="<c:url value='/cmmnty/noticeBbsList.do' />" class="th1_lnk"><span>커뮤니티</span></a>
                            <ul class="depth2_ul">
                                <li><a href="<c:url value='/cmmnty/noticeBbsList.do' />" target="_self">공지사항</a></li>
                                <li><a href="<c:url value='/cmmnty/focusBbsList.do' />" target="_self">지존포커스</a></li>
                                <li><a href="<c:url value='/cmmnty/mmnwsBbsList.do' />" target="_self">토지보상뉴스</a></li>
                                <li><a href="<c:url value='/cmmnty/nwsBbsList.do' />" target="_self">보도자료</a></li>
                                <%-- 
                                <li><a href="<c:url value='' />" target="_self">지식게시판</a></li>
                                 --%>
                                <li><a href="<c:url value='/cmmnty/colmnBbsList.do' />" target="_self">칼럼</a></li>
                                <li><a href="<c:url value='/cmmnty/qnaBbsList.do' />" target="_self">Q&amp;A게시판</a></li>
                                <!-- 
                                <li>
                                    <a href="#" target="_self">地知GO</a>
                                    <ul class="depth3_ul">
                                        <li><a href="#" target="_self">언론기사</a></li>
                                        <li><a href="#" target="_self">보도자료</a></li>
                                    </ul>
                                </li>
                                 -->
                                
                                <!-- 
                                <li>
                                    <a href="#" target="_self">카페</a>
                                    <ul class="depth3_ul">
                                        <li><a href="#" target="_self">토지골든벨</a></li>
                                        <li><a href="#" target="_self">지존이 쏜다</a></li>
                                    </ul>
                                </li>
                                 -->
                            </ul>
                        </li>

                        <li class="th1 n5">
                            <a href="<c:url value='/adisvc/recsroomBbsList.do' />" class="th1_lnk"><span>부가서비스</span></a>
                            <ul class="depth2_ul">
                                <li><a href="<c:url value='/adisvc/recsroomBbsList.do' />" target="_self">자료실</a></li>
                                <li><a href="<c:url value='/adisvc/rewardPrcdntBbsList.do' />" target="_self">보상판례</a></li>
                                <li><a href="<c:url value='/design/usfulSiteView.do'/>" target="_self">유용한사이트</a></li>
                                <li><a href="<c:url value='/design/ladRewardView.do' />" target="_self">토지보상 검토의뢰</a></li>
                            </ul>
                        </li>
                        <li class="th1 n6">
                            <a href="<c:url value='/mypage/modifyMyInfo.do' />" class="th1_lnk"><span>마이페이지</span></a>
                            <ul class="depth2_ul">
                                <li><a href="<c:url value='/mypage/modifyMyInfo.do' />" target="_self">회원정보수정</a></li>
                                <li><a href="<c:url value='/mypage/secessionReqst.do' />" target="_self">회원탈퇴신청</a></li>
                                <li><a href="<c:url value='/mypage/mypaymentList.do' />" target="_self">나의결제내역</a></li>
                                <li><a href="<c:url value='/mypage/interestList.do' />" target="_self">나의관심정보</a></li>
                                <li><a href="<c:url value='/mypage/payReqst.do' />" target="_self">결제/연장하기</a></li>
                            </ul>
                        </li>
                        <li class="th1 n7">
                            <a href="<c:url value='/design/useGuidanceView.do' />" class="th1_lnk"><span>서비스 안내</span></a>
                            <ul class="depth2_ul">
                                <li><a href="<c:url value='/design/useGuidanceView.do'/>" target="_self">이용 안내</a></li>
                                <li><a href="<c:url value='/design/chrgeGuidanceView.do'/>" target="_self">요금 안내</a></li>
                                <li><a href="<c:url value='/design/sitemapView.do' />" target="_self">서비스 전체보기</a></li>
                                
                            </ul>
                        </li>
                    </ul>
                </div>
                <span class="line"></span>
                <!-- 공통메뉴틀 끝 -->
           </div>
        </nav>
<!-- 		<p class="open_info">MENU<br>OPEN</p> -->
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
                        <li class="today">
                            <a href="<c:url value="/cmmnty/todayBbsList.do"/>"><b>Today's</b> 보상계획공고 <em>유료존</em></a>   
                        </li>
                    </ul>
                </div>
                <div class="modal-body accordion">
                    <ul class="depth1_ul n3">
                        <li class="n1">
                            <a data-target="#mMenu_modal1" href="<c:url value='/map.do?tabId=dev' />" class="ov"><span>개발정보</span></a>
                         </li>
                         <li class="n2">
                            <a data-target="#mMenu_modal2" href="<c:url value='/map.do?tabId=invt' />" class=""><span>투자정보</span></a>
                        </li>
                        <li class="n3">
                            <a data-target="#mMenu_modal3" href="<c:url value='/str/strBbsList.do' />" class=""><span>지존스토어</span></a>
                            <ul class="depth2_ul" id="mMenu_modal3" data-parent="#mobile-menu" style="display: none;">
                                <li class=""><a href="<c:url value='/str/strBbsList.do' />" class="" data-menu="depth2"><span>보상 투자 성공사례</span></a></li>
                                <li class=""><a href="<c:url value='/str/strBbsList.do' />" class="" data-menu="depth2"><span>보상 투자 실패사례</span></a></li>
                                <%-- 
                                <li class=""><a href="<c:url value='' />" class="" data-menu="depth2"><span>보상판례</span></a></li>
                                <li class=""><a href="#" class="" data-menu="depth2"><span>지존출판도서</span></a></li>
                                <li class=""><a href="#" class="" data-menu="depth2"><span>지존추천도서</span></a></li>
                                 --%>
                            </ul>
                        </li>
                        <li class="n4">
                            <a data-target="#mMenu_modal4" href="<c:url value='/cmmnty/noticeBbsList.do' />" class=""><span>커뮤니티</span></a>
                            <ul class="depth2_ul" id="mMenu_modal4" data-parent="#mobile-menu" style="display: none;">
                                <li class=""><a href="<c:url value='/cmmnty/noticeBbsList.do' />" class="" data-menu="depth2"><span>공지사항</span></a></li>
                                <li class=""><a href="<c:url value='/cmmnty/focusBbsList.do' />" class="" data-menu="depth2"><span>지존포커스</span></a></li>
                                <%-- 
                                <li class=""><a href="<c:url value='' />" class="" data-menu="depth2"><span>지식게시판</span></a></li>
                                 --%>
                                <li class=""><a href="<c:url value='/cmmnty/mmnwsBbsList.do' />" class="" data-menu="depth2"><span>토지보상뉴스</span></a></li>
                                <li class=""><a href="<c:url value='/cmmnty/nwsBbsList.do' />" class="" data-menu="depth2"><span>보도자료</span></a></li>
                                <li class=""><a href="<c:url value='/cmmnty/colmnBbsList.do' />" class="" data-menu="depth2"><span>칼럼</span></a></li>
								<li class=""><a href="<c:url value='/cmmnty/qnaBbsList.do' />" class="" data-menu="depth2"><span>Q&A게시판</span></a></li>
                                <!-- 
                                <li class="">
                                    <a href="#" class="" data-menu="depth2"><span>地知GO</span></a>
                                    <ul class="depth3_ul" data-parent="#mobile-menu" style="display: none;">
                                        <li class=""><a href="#" class="" data-menu="depth2"><span>언론기사</span></a></li>
                                        <li class=""><a href="#" class="" data-menu="depth2"><span>보도자료</span></a></li>
                                    </ul>
                                </li>
                                 -->
                               
                                <!-- 
                                <li class="">
                                    <a href="#" class="" data-menu="depth2"><span>카페</span></a>
                                    <ul class="depth3_ul" data-parent="#mobile-menu" style="display: none;">
                                        <li class=""><a href="#" class="" data-menu="depth2"><span>토지골든벨</span></a></li>
                                        <li class=""><a href="#" class="" data-menu="depth2"><span>지존이 쏜다</span></a></li>
                                    </ul>
                                </li>
                                 -->
                            </ul>
                        </li>
                        <li class="n5">
                            <a data-target="#mMenu_modal5" href="<c:url value='/adisvc/recsroomBbsList.do' />" class=""><span>부가서비스</span></a>
                            <ul class="depth2_ul" id="mMenu_modal5" data-parent="#mobile-menu" style="display: none;">
                                <li class=""><a href="<c:url value='/adisvc/recsroomBbsList.do' />" class="" data-menu="depth2"><span>자료실</span></a></li>
                                <li class=""><a href="<c:url value='/adisvc/rewardPrcdntBbsList.do' />" class="" data-menu="depth2"><span>보상판례</span></a></li>
                                <li class=""><a href="<c:url value='/design/usfulSiteView.do'/>" class="" data-menu="depth2"><span>유용한사이트</span></a></li>
                                <li class=""><a href="<c:url value='/design/ladRewardView.do' />" class="" data-menu="depth2"><span>토지보상 검토의뢰</span></a></li>
                            </ul>
                        </li>
                        <li class="n6">
                            <a data-target="#mMenu_modal6" href="<c:url value='/mypage/modifyMyInfo.do' />" class=""><span>마이페이지</span></a>
                            <ul class="depth2_ul" id="mMenu_modal6" data-parent="#mobile-menu" style="display: none;">
                                <li class=""><a href="<c:url value='/mypage/modifyMyInfo.do' />" class="" data-menu="depth2"><span>회원정보수정</span></a></li>
                                <li class=""><a href="<c:url value='/mypage/secessionReqst.do' />" class="" data-menu="depth2"><span>회원탈퇴신청</span></a></li>
                                <li class=""><a href="<c:url value='/mypage/mypaymentList.do' />" class="" data-menu="depth2"><span>나의결제내역</span></a></li>
                                <li class=""><a href="<c:url value='/mypage/interestList.do' />" class="" data-menu="depth2"><span>나의관심정보</span></a></li>
                                <li class=""><a href="<c:url value='/mypage/payReqst.do' />" class="" data-menu="depth2"><span>결제/연장하기</span></a></li>
                            </ul>
                        </li>
                        
                        <li class="n7">
                            <a data-target="#mMenu_modal7" href="<c:url value='/design/useGuidanceView.do' />" class=""><span>서비스 안내</span></a>
                            <ul class="depth2_ul">
                                <li class=""><a href="<c:url value='/design/useGuidanceView.do'/>" class="" data-menu="depth2">이용 안내</a></li>
                                <li class=""><a href="<c:url value='/design/chrgeGuidanceView.do'/>" class="" data-menu="depth2">요금 안내</a></li>
                                <li class=""><a href="<c:url value='/design/sitemapView.do' />" class="" data-menu="depth2">서비스 전체보기</a></li>
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
	$(document).on("keyup", "input[noSpecial]", function() {
		
		//$(this).val( $(this).val().replace(/^[a-zA-Z]+$/,"") );
		$(this).val(AtoH.convert($(this).val()));
		var list = $(this).val();
		list = Hangul.disassemble(list);
		list = Hangul.assemble(list);
		console.log(list);
		$(this).val(list);
	});
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

<div id="body_layout">	
    <!-- main 영역입니다. -->
    <div id="mvisual">
        <strong class="logo"></strong>
        <div class="main-photo__skin" id="mvisual_slide">
            <div class="layout">
                <div class="title">
                	<div class="notice">
                		 <ul class="rolling">
                		<c:forEach items="${updateDevNmList}" var="nmList" varStatus="status">
							<li>
                				 <span><em>UPDATE</em>${nmList.dwkNm}</span>
                			</li>
						</c:forEach>
                		</ul>
<!--                     <span><em>UPDATE</em>가평역세권 개발사업</span> -->
                	</div>
                    <p>국내유일의 토지보상 및 부동산 개발정보 플랫폼 지존</p>
                    <strong>G.zone</strong>
                    <div class="search">
                        <form onsubmit="return false;">
                            <fieldset>
                                <legend class="hide">검색</legend>
                                <div class="search_box placeholder">
                                    <input id="address"  name="address" type="text" title="우리동네 검색" autocomplete="off" placeholder="우리동네 개발사업이 궁금하세요?"  required="required" class="text1" onkeypress="return enterkey()" noSpecial>
                                    <button type="button" id="searchSubmit" onclick="search('address')">검색</button>
                                </div>
                            </fieldset>
                        </form>
                        <a href="javascript:search('location');" style="display:none;">현재 위치로 <br>주소 찾기</a>
<!--                         <a href="javascript:search('location');">현재 위치로 <br>주소 찾기</a> -->
                    </div>
                </div>
            </div>
            <div class="photo_list--wrap">
                <div class="photo_list--slider">
<%--                     <div class="photo_list--item" style="background-image: url(<%=request.getContextPath()%>/css/gzonei/SRC/images/main/mvisual_img01.jpg)"></div> --%>
<%--                     <div class="photo_list--item" style="background-image: url(<%=request.getContextPath()%>/css/gzonei/SRC/images/main/mvisual_img02.jpg)"></div> --%>
                    <%--메인페이지배너--%>
                    <c:forEach items="${mainSlideList }" var="mainPopList" varStatus="status">
                    	<div class="photo_list--item" style="background-image: url(<c:url value='/file/displayFile.do?filePath=/home/gzoneiweb/${mainPopList.fileStreCours }&fileName=${mainPopList.streFileNm }'/>)"></div>
                	</c:forEach>
                </div>
            </div>
        </div>
        <div id="popupzone">
            <div class="grap">
                <ul class="obj">                          
<%--                     <li class="item"><a href="<c:url value='/design/ladRewardView.do'/>"><img src="<c:url value='/css/gzonei/SRC/images/main/popup_img02.jpg' />" alt=""></a></li> --%>
                    <%--팝업존배너 --%>
                    <c:forEach items="${popSlideList }" var="popList" varStatus="status">
		                <li class="item">
		                	<c:choose>
		                		<c:when test="${popList.url == '' or popList.url == null }">
		                			<a href="#" target="_blank" class="js-link" data-id="modalNews" data-url="#link">
		                        		<img src="<c:url value='/file/displayFile.do?filePath=/home/gzoneiweb/${popList.fileStreCours }&fileName=${popList.streFileNm }'/>" alt=""/>
		                    		</a>
		                		</c:when>
		                		<c:otherwise>
		                			<a href="${popList.url }" target="_blank" class="js-link" data-id="modalNews" data-url="#link">
		                        		<img src="<c:url value='/file/displayFile.do?filePath=/home/gzoneiweb/${popList.fileStreCours }&fileName=${popList.streFileNm }'/>" alt=""/>
		                    		</a>
		                		</c:otherwise>
		                	</c:choose>
		                    
		                </li>
                	</c:forEach>
<%--                     <li class="item"><a href="#"><img src="<c:url value='/css/gzonei/SRC/images/main/popup_img01.jpg' />" alt=""></a></li> --%>
                </ul>
            </div>      
            <div class="controlBox">
                <button type="button" data-control="prev" class="btn_prev">이전</button>
                <button type="button" data-control="play" class="btn_play" style="display: none;">재생</button>
                <button type="button" data-control="stop" class="btn_stop">일시정지</button>
                <button type="button" data-control="next" class="btn_next">다음</button>
                <div class="number"></div>
            </div>
        </div>
    </div>
    <div id="mcont1">
        <div class="layout">
            <div class="ui ui-tablist">
            	<div class="btitle">
<%--             	${popSlideList.url } --%>
                    <strong>소식</strong>
                </div>
                <ul class="tab-ul" role="tablist">
	                <li role="presentation" class="js-tab"><a role="tab" id="tab1" aria-controls="tab-panel1" href="#tab-panel1">전체</a></li>
                    <li role="presentation" class="js-tab"><a role="tab" id="tab2" aria-controls="tab-panel2" href="#tab-panel2">공지</a></li>
                    <li role="presentation" class="js-tab"><a role="tab" id="tab3" aria-controls="tab-panel3" href="#tab-panel3">토지보상뉴스</a></li>
                    <li role="presentation" class="js-tab"><a role="tab" id="tab4" aria-controls="tab-panel4" href="#tab-panel4">칼럼</a></li>
                    <li role="presentation" class="js-tab"><a role="tab" id="tab5" aria-controls="tab-panel5" href="#tab-panel5">보도자료</a></li>
                    <li role="presentation" class="js-tab"><a role="tab" id="tab6" aria-controls="tab-panel6" href="#tab-panel6">보상판례</a></li>
                    <li role="presentation" class="js-tab"><a role="tab" id="tab7" aria-controls="tab-panel7" href="#tab-panel7">Q&A</a></li>
                </ul>
				<div class="tabpanel on" id="tab-panel1" role="tabpanel" aria-labelledby="tab1">
					<ul>
						<c:forEach items="${newsTab}" var="list" varStatus="status">
						<c:set var="listGrade" value="${list.readngAuthorCode}"/>
                    	<fmt:formatDate var="regDate"  value="${list.frstRegistPnttm}" pattern="yyyy.MM.dd"/>
	                        <li class="board__item">
								<c:if test="${list.bbsId eq 'BBSMSTR_000000000001'}">
		                            <a href="<c:url value='/cmmnty/noticeBbsDetail.do?nttId=${list.nttId}'/>">
		                                <span>공지</span>
		                                <strong class="board__item--title">${list.nttSj}<span class="ir ir-icon__new">new</span></strong>
                                		<em class="board__item--date"><span>${regDate}</span></em>
									</a>
								</c:if>
								<c:if test="${list.bbsId eq 'BBSMSTR_000000000008'}">
		                            <a href="<c:url value='/cmmnty/mmnwsBbsDetail.do?nttId=${list.nttId}'/>">
		                                <span>토지보상뉴스</span>
		                                <strong class="board__item--title">${list.nttSj}<span class="ir ir-icon__new">new</span></strong>
                                		<em class="board__item--date"><span>${regDate}</span></em>
									</a>
								</c:if>
								<c:if test="${list.bbsId eq 'BBSMSTR_000000000009'}">
		                            <a href="<c:url value='/cmmnty/colmnBbsDetail.do?nttId=${list.nttId}'/>">
		                                <span>칼럼</span>
		                                <strong class="board__item--title">${list.nttSj}<span class="ir ir-icon__new">new</span></strong>
                                		<em class="board__item--date"><span>${regDate}</span></em>
									</a>
								</c:if>
								<c:if test="${list.bbsId eq 'BBSMSTR_000000000005'}">
		                            <a href="<c:url value='/cmmnty/nwsBbsDetail.do?nttId=${list.nttId}'/>">
		                                <span>보도자료</span>
		                                <strong class="board__item--title">${list.nttSj}<span class="ir ir-icon__new">new</span></strong>
                                		<em class="board__item--date"><span>${regDate}</span></em>
									</a>
								</c:if>
								<c:if test="${list.bbsId eq 'BBSMSTR_000000000006'}">
		                            <a href="<c:url value='/adisvc/rewardPrcdntBbsDetail.do?nttId=${list.nttId}&listGrade=${listGrade}'/>">
		                                <span>보상판례</span>
		                                <strong class="board__item--title">${list.nttSj}<span class="ir ir-icon__new">new</span></strong>
                                		<em class="board__item--date"><span>${regDate}</span></em>
									</a>
<%-- 		                            <a href="<c:url value='/adisvc/rewardPrcdntBbsDetail.do?nttId=${list.nttId}'/>">
		                                <span>보상판례</span>
		                                <strong class="board__item--title">${list.nttSj}<span class="ir ir-icon__new">new</span></strong>
                                		<em class="board__item--date"><span>${regDate}</span></em>
									</a> --%>
								</c:if>
								<c:if test="${list.bbsId eq 'BBSMSTR_000000000007'}">
		                            <a href="<c:url value='/cmmnty/qnaBbsDetail.do?nttId=${list.nttId}'/>">
		                                <span>Q&A</span>
		                                <strong class="board__item--title">${list.nttSj}<span class="ir ir-icon__new">new</span></strong>
                                		<em class="board__item--date"><span>${regDate}</span></em>
									</a>
								</c:if>
	                        </li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="tabpanel" id="tab-panel2" role="tabpanel" aria-labelledby="tab2">
                    <strong class="skip">공지</strong>
                    <ul>
						<c:forEach items="${noticeTab}" var="list" varStatus="status">
                    	<fmt:formatDate var="regDate"  value="${list.frstRegistPnttm}" pattern="yyyy.MM.dd"/>
	                        <li class="board__item">
	                            <a href="<c:url value='/cmmnty/noticeBbsDetail.do?nttId=${list.nttId}'/>">
	                                <span>공지</span>
	                                <strong class="board__item--title">${list.nttSj}<span class="ir ir-icon__new">new</span></strong>
	                                <em class="board__item--date"><span>${regDate}</span></em>
	                            </a>
	                        </li>
                        </c:forEach>
                    </ul>
                    <div class="more" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath()%>/cmmnty/noticeBbsList.do'">
                      <button type="button">더보기</button>
                    </div>
                </div>
                <div class="tabpanel" id="tab-panel3" role="tabpanel" aria-labelledby="tab3">
                    <strong class="skip">토지보상뉴스</strong>
                    <ul>
						<c:forEach items="${mmnwsTab}" var="list" varStatus="status">
                    	<fmt:formatDate var="regDate"  value="${list.frstRegistPnttm}" pattern="yyyy.MM.dd"/>
	                        <li class="board__item">
	                            <a href="<c:url value='/cmmnty/mmnwsBbsDetail.do?nttId=${list.nttId}'/>">
	                                <span>토지보상뉴스</span>
	                                <strong class="board__item--title">${list.nttSj}<span class="ir ir-icon__new">new</span></strong>
	                                <em class="board__item--date"><span>${regDate}</span></em>
	                            </a>
	                        </li>
                        </c:forEach>
                    </ul>
                    <div class="more" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath()%>/cmmnty/mmnwsBbsList.do'">
                      <button type="button">더보기</button>
                    </div>
                </div>
                <div class="tabpanel" id="tab-panel4" role="tabpanel" aria-labelledby="tab4">
                    <strong class="skip">칼럼</strong>
                    <ul>
						<c:forEach items="${colmnTab}" var="list" varStatus="status">
                    	<fmt:formatDate var="regDate"  value="${list.frstRegistPnttm}" pattern="yyyy.MM.dd"/>
	                        <li class="board__item">
	                            <a href="<c:url value='/cmmnty/colmnBbsDetail.do?nttId=${list.nttId}'/>">
	                                <span>칼럼</span>
	                                <strong class="board__item--title">${list.nttSj}<span class="ir ir-icon__new">new</span></strong>
	                                <em class="board__item--date"><span>${regDate}</span></em>
	                            </a>
	                        </li>
                        </c:forEach>
                    </ul>
                    <div class="more" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath()%>/cmmnty/colmnBbsList.do'">
                      <button type="button">더보기</button>
                    </div>
                </div>
                <div class="tabpanel" id="tab-panel5" role="tabpanel" aria-labelledby="tab5">
                    <strong class="skip">보도자료</strong>
                    <ul>
						<c:forEach items="${nwsTab}" var="list" varStatus="status">
                    	<fmt:formatDate var="regDate"  value="${list.frstRegistPnttm}" pattern="yyyy.MM.dd"/>
	                        <li class="board__item">
	                            <a href="<c:url value='/cmmnty/nwsBbsDetail.do?nttId=${list.nttId}'/>">
	                                <span>보도자료</span>
	                                <strong class="board__item--title">${list.nttSj}<span class="ir ir-icon__new">new</span></strong>
	                                <em class="board__item--date"><span>${regDate}</span></em>
	                            </a>
	                        </li>
                        </c:forEach>
                    </ul>
                    <div class="more" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath()%>/cmmnty/nwsBbsList.do'">
                      <button type="button">더보기</button>
                    </div>
                </div>
                <div class="tabpanel" id="tab-panel6" role="tabpanel" aria-labelledby="tab6">
                    <strong class="skip">보상판례</strong>
                    <ul>
                    	<c:forEach items="${rewardPrcdntTab}" var="list" varStatus="status">
                    	<c:set var="listGrade" value="${list.readngAuthorCode}"/>
                    	<fmt:formatDate var="regDate"  value="${list.frstRegistPnttm}" pattern="yyyy.MM.dd"/>
	                        <li class="board__item">
	                            <a href="<c:url value='/adisvc/rewardPrcdntBbsDetail.do?nttId=${list.nttId}&listGrade=${listGrade}'/>">
	                                <span>보상판례</span>
	                                <strong class="board__item--title">${list.nttSj}<span class="ir ir-icon__new">new</span></strong>
	                                <em class="board__item--date"><span>${regDate}</span></em>
	                            </a>
	                        </li>
                        </c:forEach>
                    </ul>
                    <div class="more" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath()%>/adisvc/rewardPrcdntBbsList.do'">
                      <button type="button">더보기</button>
                    </div>
                </div>
                <div class="tabpanel" id="tab-panel7" role="tabpanel" aria-labelledby="tab7">
                    <strong class="skip">Q&A</strong>
                    <ul>
                        <c:forEach items="${qnaTab}" var="list" varStatus="status">
                    	<fmt:formatDate var="regDate"  value="${list.frstRegistPnttm}" pattern="yyyy.MM.dd"/>
	                        <li class="board__item">
	                            <a href="<c:url value='/cmmnty/qnaBbsDetail.do?nttId=${list.nttId}'/>">
	                                <span>Q&A</span>
	                                <strong class="board__item--title">${list.nttSj}<span class="ir ir-icon__new">new</span></strong>
	                                <em class="board__item--date"><span>${regDate}</span></em>
	                            </a>
	                        </li>
                        </c:forEach>
                    </ul>
                    <div class="more" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath()%>/cmmnty/qnaBbsList.do'">
                      <button type="button">더보기</button>
                    </div>
                </div>
            </div>
            <div class="blog">
                <a href="https://blog.naver.com/gzonestory" target="_blank" title="새창열림">
                    <strong>G.Zone Story</strong>
                    <p>전국개발정보 서비스<br> 지존 공식 블로그</p>   
                    <b>blog</b>
                </a>
            </div>   
            <div class="talk">
                <strong><b>G.Zone</b>포커스</strong>
                <c:forEach items="${focusTab}" var="list" varStatus="status">
                	<p><a href="<c:url value='/cmmnty/focusBbsDetail.do?nttId=${list.nttId}'/>">${list.nttSj}</a></p>
                </c:forEach>
            </div>
        </div>
    </div>
    <div id="mcont2">
        <div class="layout">
            <div class="img_slide" id="img_slide" style="display:none;">
                <div class="btitle">
                    <span>NEW</span>
                    <strong>개발정보</strong>
                </div>
                <div class="grap">
                    <ul class="obj focusIn">
                      <c:forEach items="${devTop}" var="list" varStatus="status">
                    	<li class="item">
                            <a  href="javascript:void(0);" onclick="searchDevTop('${list.devlopInfoSn}');" attr-a="onclick : attr-a"  class="link">
                                <span>${list.legaldongNm}</span>  
                                <strong>${list.dwkNm}</strong>
                                <ul>
                                	<c:if test="${list.bsnsArMeter != null  && !empty list.bsnsArMeter}">
	                                	<c:choose>
	                                		<c:when test="${list.unitTy =='길이'}">
		                                		<li><fmt:formatNumber type="number" maxFractionDigits="3" value="${list.bsnsArMeter}"/>km (<fmt:formatNumber type="number" maxFractionDigits="3" value="${list.bsnsArPyeong}"/>m)</li>
	                                		</c:when>
											<c:otherwise>
												<li><fmt:formatNumber type="number" maxFractionDigits="3" value="${list.bsnsArMeter}"/>㎡ (<fmt:formatNumber type="number" maxFractionDigits="3" value="${list.bsnsArPyeong}"/>평)</li>
											</c:otherwise>
	                                	</c:choose>
                                	</c:if>
                                	<c:choose>
                                		<c:when test="${list.opertnCmpnyNm == '직접입력' || empty list.opertnCmpnyNm}">
			                                <li>${list.opertnCmpny}</li>
                                		</c:when>
                                		<c:otherwise>
                                			<li>${list.opertnCmpnyNm}</li>
                               			</c:otherwise>
                               		</c:choose>
                                    <!-- <li>${list.bsnsArKmeter}km(<fmt:formatNumber type="number" maxFractionDigits="3" value="${list.bsnsArMeter}" />m)</li>
                                    <li>${list.opertnCmpny}</li>-->
                                </ul>
                            </a>
                        </li>
                    </c:forEach>
                    </ul>
                </div>
                <div class="control">
                    <button type="button" data-control="prev">이전</button>
                    <button type="button" data-control="next">다음</button>
                </div>
            </div>
                    
            <div class="bottom">
                <strong>내 토지보상금은 적정한가? <b>토지보상가 적정성 검토무료 컨설팅 해보세요!</b></strong>
                <div class="txt">
                    <b>02-322-3152</b>
                    <p>평일 09:00 ~18:00</p>
                    <a href="<c:url value='/design/ladRewardView.do'/>">무료신청 바로가기</a>   
                </div>
            </div>
        </div>
    </div>
    <div id="mcont3">
        <div class="layout">
            <div class="ui ui-tablist">
                <ul class="tab-ul" role="tablist">
                    <li role="presentation" class="js-tab on"><a role="tab" id="tab8" aria-controls="tab-panel8" href="<c:url value='/map.do?tabId=dev'/>">개발정보</a></li>
                    <li><a id="tab9" href="<c:url value='/map.do?tabId=invt'/>">투자정보</a></li>
                </ul>
                <div class="tabpanel on" id="tab-panel8" role="tabpanel" aria-labelledby="tab8">
                    <strong class="skip">개발정보</strong>
					<p class="topinfo" id="topinfo"><b> ${devCt.dt} 현재 기준</b>개발정보 <b>${devCt.devCount}</b>건 / 투자정보 ${devCt.invtCount}건</p>
                    <div class="map_wrap">
<!--                     <div class="map_wrap" style="height: 711px; padding-right: 700px;"> -->
                        <div class="txt_wrap">
<!--                         <div class="txt_wrap" style="width:700px"> -->
                            <form name="searchForm2" id="searchForm2" method="post" target="_self" title="검색화면으로이동" onsubmit="">
                                <div class="top">
                                    <div class="box box1">
                                        <strong><span class="icon1"></span>사업지구</strong>
                                        <div class="scroll">
                                            <ul>
                                            	<c:forEach items="${dsList}" var="dsData" varStatus="status">
                                            		<c:if test="${status.count % 2 ==1}"> 
                                            			<li><button type="button" class="" onclick="location.href='<%=request.getContextPath()%>/map.do?tabId=dev'">${dsData.codeIdNm} (${dsData.devcnt})</button></li>
                                            		</c:if>
                                            	</c:forEach>
                                            </ul>
                                            <ul>	
                                            	<c:forEach items="${dsList}" var="dsData" varStatus="status">
                                            		<c:if test="${status.count % 2 == 0}"> 
                                            			<li><button type="button" class="" onclick="location.href='<%=request.getContextPath()%>/map.do?tabId=dev'">${dsData.codeIdNm} (${dsData.devcnt})</button></li>
                                            		</c:if>
                                            	</c:forEach>
                                           	</ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="bottom">
                                   
                                </div>
                            </form>
                        </div>
                        <div id="map" class="map">
                            
                        </div>
                    </div>
                </div>
                <div class="tabpanel" id="tab-panel9" role="tabpanel" aria-labelledby="tab9">
                    <strong class="skip">투자정보</strong>
                    
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="mcont4">
        <div class="layout">
            <div class="btitle">
                <strong>샘플보기</strong>
            </div>
            <div class="main-photo__skin" id="mcont4_slide">
                <div class="info">
                    <strong class="title">개발정보 <em>무료샘플</em></strong>
                    <div class="board_txt">
                        <a href="#" class="board__link">
                                <div class="thumb"><img src="<c:url value='/css/gzonei/SRC/images/main/mcont4_img01.jpg'/>" alt=""></div>
                        </a>
                    </div>
                    
                    <ul>
                    	<c:forEach items="${freeSample}" var="sample">
                        <li <c:if test="${sample.smpleManageNo == '1'}">class="on"</c:if>>
                            <a href="<c:url value='/free/devFreeView.do?smpleNo=${sample.smpleManageNo}'/>">
                                <p>${sample.addr}</p>
                                <strong>${sample.dwkNm}</strong>
                                <div class="thumb"><img src="<c:url value='/css/gzonei/SRC/images/main/mcont4_img01.jpg'/>" alt=""></div>
                            </a>
                        </li>
                        </c:forEach>
                    </ul>
                </div>   
                <div class="info2">
                    <strong class="title">투자정보 <em>무료샘플</em></strong>
                    <ul>
                        <li>
                            <a href="<c:url value='/design/invtFreeView.do'/>">
                                <span class="type1">경매</span>
                                <strong>사건번호</strong>
                                <p>성남지원 8계 2018-11918</p>
                            </a>
                        </li>
                        <li>
                            <a href="<c:url value='/design/invtFreeView.do'/>">
                                <span class="type2">공매</span>
                                <strong>관리번호</strong>
                                <p>2013-18610-001</p>
                            </a>
                        </li>
                        <li>
                            <a href="<c:url value='/design/invtFreeView.do'/>">
                                <span class="type1">경매</span>
                                <strong>사건번호</strong>
                                <p>부산서부지원3계 2020-1814</p>
                            </a>
                        </li>
                        <li>
                            <a href="<c:url value='/design/invtFreeView.do'/>">
                                <span class="type1">경매</span>
                                <strong>사건번호</strong>
                                <p>포항지원 4계 2019-34405</p>
                            </a>
                        </li>
                    </ul>
                </div>  
                
            </div>

        </div>
    </div>   
    <div id="mcont5">
        <div class="layout">
            <div class="btitle">
                <strong>지존 파트너</strong>
                <p>각 분야별 전문가로 구성된 지존 협력업체 정보입니다. ​</p>
            </div>
            <ul class="link_wrap">
                 <li><a title="새창열림" target="_blank" href="http://www.reward2030.kr/"><span class="icon1"></span>토지보상 지원센터</a></li>
                <li><a title="새창열림" target="_blank" href="https://cafe.daum.net/toji200"><span class="icon2"></span>임&조 세무회계사무소</a></li>
                <li><a title="새창열림" target="_blank" href="http://tbapp.co.kr/"><span class="icon3"></span>㈜감정평가법인 태백</a></li>
            </ul>
        </div>
    </div>
    <!-- main 영역입니다. -->
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
<footer id="foot_layout">
    <!-- 푸터틀 시작 -->
    <div class="layout">
        <a href="javascript:scrollMotionListener();" id="btnTop" title="컨텐츠 상단으로 이동">컨텐츠 상단으로 이동</a>
        <div class="footer-info">
            <strong class="logo">GZONE 전국개발정보</strong>
            <p><span>(주)전국개발정보 지존</span>  <span>서울특별시 영등포구 당산로 246 viewtiful tower 6F, 8F</span> <span>사업자등록번호 743-88-00139</span></p>
            <p><span>대표이사 : 신태수</span><span>개인정보보호정책책임자 : 고이내</span><span>통신판매신고 제2020-서울영등포-1492호   </span></p>
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
<script type="text/javascript">
function enterkey(){
	
	if(window.event.keyCode == 13){ //javascript에서는 13이 enter키를 의미함 
		$("#searchSubmit").click();
// 		$('#searchResult').css("display","block");
// 		search();
		}
	}
</script>
</body>
</html>


