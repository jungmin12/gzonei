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
function getUrl(){
	var scheme = '<c:out value="${pageContext.request.scheme}"/>';
	var serverName = '<c:out value="${pageContext.request.serverName}"/>';
	var port = '<c:out value="${pageContext.request.serverPort}"/>';
	var context = '<c:out value="${pageContext.request.contextPath}"/>';
	
	var url = scheme+'://'+serverName;
	if(''!=port||null!=port||'undefined'!=port){
		url += ':';
		url += port;
	}
	if(''!=context||null!=context||'undefined'!=context){
		url += context;
	}
	url += '/';
	
	return url;
	
}
$(document).ready(function(){
	$('.custom-search .p-control').attr("autocomplete","off");
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
	
    
	//게시판 이미지 경로 변경해주는 코드
    setImgPath('/sts_docs/upload/','upload');
    setImgPath('/sts_docs/images/','images');
});
//게시판 이미지 경로 변경해주는 코드
function setImgPath(oldPath,midPath){
	var viewCont = $('.view_cont');
	if(viewCont.length!=0){
		if(viewCont.html().includes(oldPath)){
			for(var i=0;i<viewCont.find('img').length;i++){
				var imgTxt = viewCont.find('img')[i].src;
				var splitTxtList = imgTxt.split('/');
				const encoded = encodeURI(midPath);
				var fileName = encodeURI(splitTxtList[splitTxtList.length-1]);
				imgTxt = imgTxt.replace(oldPath,'/file/displayFile.do?filePath=/home/gzoneiweb/'+encoded+'/');
				imgTxt += '&fileName='+fileName;
				viewCont.find('img')[i].src = imgTxt;
			}
		}
	}
}
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
                    <ul id="mobileMapUl" class="depth1_ul n3">
                        <li class="n1 singleLi">
                            <a data-target="#mMenu_modal1" href="<c:url value='/map.do?tabId=dev' />" class=""><span>개발정보</span></a>
                         </li>
                         <li class="n2 singleLi">
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

