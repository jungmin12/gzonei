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
<script>
function fn_secsn_reqst(){
	$("#modal-secsnreqst").modal();
}


function fn_secessionConfirm(){
	
	var param = $("#secessionRestqForm").serialize();
	
	$.ajax({
		cache:false,
		url:"<c:url value='/mypage/secessionCheck.do' />",
		type:"POST",
		data:param,
		dataType:'json',
		async:false,
		success:function(data){
			if(data.result == 1){
				location.href="<c:url value='/mypage/secsnReqstCompt.do'/>";
			}else if(data.result == 3){
				Common.Dialog.alert({
                    title: '회원 탈퇴 신청'
                    ,content: '이미 탈퇴 신청되었습니다.'
                }); 
			}else{
				Common.Dialog.alert({
                    title: '회원 탈퇴 신청'
                    ,content: '탈퇴 신청 처리에 실패했습니다.'
                });
			}
			
		}
		,error : function(e) {alert("관리자에게 문의바랍니다.");}
		,beforeSend:function(){		
			//전송 전
			$('.wrap-loading').removeClass('display-none');	
	    }
	    ,complete:function(){
	        //전송 후
	    	$('.wrap-loading').addClass('display-none');
	    }
		
	});
		
}

function fn_main(){
	location.href="<c:url value='/main.do' />";
}
</script>
<!-- 구현부 : S -->

<div id="body_layout">	
    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
	        <div id="location" class="title_wrap">
	                <h2 class="page__title">회원탈퇴신청</h2>
	                <!-- 유틸 시작 -->
	                <div class="utile_wrap">
	                    <!-- 로케이션 시작 -->
	                    <ul class="location_wrap">
	                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
	                        <li class="n2"><a href="<c:url value='/mypage/modifyMyInfo.do'/>">마이페이지</a></li>
	                        <li class="n3"><a href="<c:url value='/mypage/secessionReqst.do'/>" class="navi_ov">회원탈퇴신청</a></li>
	                    </ul>                           
	                    <!-- 로케이션 끝 -->
	                    <!-- 프린트 시작 -->
	                    <!-- 프린트 끝 -->
	                </div>
	                <!-- 유틸 끝 -->   
	            </div>
             	<div id="txt">
            	<!-- content 영역입니다. -->
					<div class="out_wrap">
					        
					    <h2 class="h2">회원탈퇴신청</h2>
					    <p>회원탈퇴는 지존에서의 모든 이용권한 해지를 의미합니다. <br>반드시 아래 유의사항을 확인 후, 회원 탈퇴 신청을 해주시기 바랍니다.</p>
					
					    <div class="box">
					        <strong>회원탈퇴 시, 이런점은 유의하세요 !</strong>
					        <ul>
					            <li><span class="icon1"></span>회원탈퇴 시, <br>회원님의 가입정보와 결제 내역 정보 등이 <br>모두 삭제됩니다.</li>
					            <li><span class="icon2"></span>사업자회원의 경우, <br>신청서류 또한 모두 삭제 됩니다.</li>
					            <li><span class="icon3"></span>나의 관심정보에 담으셨던 <br>개발정보, 경매, 공매 물건 등이 삭제 됩니다. <br>(재가입 후에도 내역확인 불가능)</li>
					            <li><span class="icon1"></span>회원이 직접 등록한 <br>‘직매물’정보도 삭제됩니다.</li>
					            <li><span class="icon2"></span>단, 상담게시판 등에 회원이 <br>직접 등록한 게시물, 댓글 등은 <br> 탈퇴 후에도 삭제되지 않습니다.</li>
					            <li><span class="icon3"></span>탈퇴한 아이디는  <br>‘회원 ID 영구보관’ 정책으로 <br>재가입 시에도 다시 사용할 수 없습니다. <br>(다른회원도 사용불가)</li>
					        </ul>
					    </div>
					
<!-- 					    <h2 class="h2">탈퇴약관</h2> -->
<!-- 					    <div class="example-box"> -->
<!-- 					        <p>내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.</p> -->
<!-- 					    </div> -->
					
					
					    <div class="text-center">
					        <button type="button" class="btn btn-default" onclick="javascript:fn_main();">취소</button>
					        <button type="button" onclick="javascript:fn_secsn_reqst()" data-toggle="modal" class="btn btn-primary">회원탈퇴</button>
					    </div>
					</div>
            	<!-- content 영역입니다. -->	
            	</div>
	
		</div>
	</div>
    <!-- layout -->
</div>
<!-- 탈퇴신청 modal -->
 <div class="modal fade" role="dialog" data-ly-type="content" data-ly-target="modal-secsnreqst" id="modal-secsnreqst">
       <div class="modal-dialog">
           <!-- Modal content-->
           <div class="modal__body">
               <div class="modal__header">
                  <h4 class="modal__title">회원탈퇴신청</h4>
                   <div class="modal__close-button"><button type="button" class="close" data-dismiss="modal">닫기</button></div>
               </div>
               <form id="secessionRestqForm" name="secessionRestqForm" method="post">
               <div class="modal__content" style="word-break: break-all">
                   <div class="cont_wrap">
                    <div class="top_head align_mo_block">
                    	<p class="txt"><strong>탈퇴사유</strong>를 입력해주세요</p>
                    </div>
                       <div class="flex_box ">
                        <div class="flex_item">
                            <input type="text" id="secsnResn" name="secsnResn" class="form-control" placeholder="탈퇴 사유를 입력해주세요." />
                        </div>
                    </div>
                   </div>
               </div>
               <div class="modal__footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" onclick="fn_secessionConfirm();">탈퇴신청</button>
             </div>
             </form>
           </div>
       </div>
  </div>
<!-- 구현부 : E -->

<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>
</body>
</html>

