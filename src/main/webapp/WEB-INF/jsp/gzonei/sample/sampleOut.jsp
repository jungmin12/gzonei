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
                <h2 class="page__title">지존안내</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="/site/kr/">HOME</a></li>
                        <li class="n2"><a href="/kr/html/sub01/010101.html">지존스토어</a></li>
                        <li class="n3"><a href="/kr/html/sub01/010101.html" class="navi_ov">보상판례</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                    <!-- 프린트 시작 -->
                    <ul class="print_wrap setting-box__group">
                        <li id="sns_layout" class="n2">
                            <button data-target="ui-open">SNS공유</button>
                            <div class="sns_wrap" data-id="ui-open">
                                <button data-button="sns_share" data-service="naver" data-title="네이버 SNS공유" title="새창열림" target="_blank"><span class="sr-only">네이버 SNS</span>공유하기</button>
                                <button data-button="sns_share" data-service="facebook" data-title="페이스북 SNS공유" title="새창열림" target="_blank"><span class="sr-only">페이스북 SNS </span>공유하기</button>
                                <button data-target="ui-close">닫기</button>
                            </div>
                        </li>                    
                        <li class="n1" id="print"><button data-print="print">프린트</button></li>
                    </ul>
                    <!-- 프린트 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">
            <!-- content 영역입니다. -->

<h1 style="margin-bottom: 50px;font-size: 40px;color: #000;">회원탈퇴페이지1 (화면정의서 17p)</h1> <!--페이지 안내 텍스트 입니다 개발 시 지워주세요-->

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

    <h2 class="h2">탈퇴약관</h2>
    <div class="example-box">
        <p>내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.</p>
    </div>


    <div class="text-center">
        <button type="button" class="btn btn-default">취소</button>
        <button type="button" data-toggle="modal" class="btn btn-primary btn-update">회원탈퇴</button>
    </div>
    <script>
        $(function () { 
            $(".btn-update").on('click', function(){
                Common.Dialog.confirm({
                    title: '회원탈퇴',
                    content: '정말 탈퇴하시겠습니까?'
                    ,ok: function(){
                        console.log('확인 클릭');
                    }
                });    
            });     
        });
    </script>
</div>


<h1 style="margin-bottom: 50px;font-size: 40px;color: #000;">회원탈퇴페이지2 (화면정의서 17p)</h1> <!--페이지 안내 텍스트 입니다 개발 시 지워주세요-->
<div class="out_wrap2">
    <span></span>
    <strong><b>GZONE</b>회원탈퇴가 완료되었습니다</strong>
    <p>그동안 지존서비스를 이용해 주셔서 감사합니다.</p>
    <button type="button" class="btn btn-default">메인으로</button>
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
