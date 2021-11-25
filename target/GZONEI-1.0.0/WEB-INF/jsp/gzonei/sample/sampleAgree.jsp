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

				<h1 style="margin-bottom: 50px;font-size: 40px;color: #000;">약관동의화면1 (화면정의서 13p)</h1> <!--페이지 안내 텍스트 입니다 개발 시 지워주세요-->
				<ul class="step_list">
				    <li class="on"><span></span>회원선택</li>
				    <li><span></span>약관동의</li>
				    <li><span></span>정보입력</li>
				    <li><span></span>가입완료</li>
				</ul>
				<div class="agree_wrap">
				    <div class="header">
				        <h4 class="modal__title"><b>GZONE</b>회원가입을 환영합니다.</h4>
				        <p>회원 유형에 따라 가입 절차에 차이가 있으니 개인회원 또는 법인 회원을 선택해주세요.</p>
				    </div>
				    <div class="wrap">
				        <div class="box">
				            <span class="icon1"></span>
				            <strong>개인회원</strong>
				            <p>만 14세 이상 개인회원 가입을 원하시면 선택해주세요.</p>
				            <a href="#">회원가입</a>
				        </div>
				        <div class="box">
				            <span class="icon2"></span>
				            <strong>법인회원</strong>
				            <p>법인회원 가입을 원하시면 선택해주세요</p>
				            <a href="#">회원가입</a>
				        </div>
				    </div>
				</div>
				
				
				<h1 style="margin-bottom: 50px;font-size: 40px;color: #000;">약관동의화면2 (화면정의서 13p)</h1> <!--페이지 안내 텍스트 입니다 개발 시 지워주세요-->
				
				<ul class="step_list">
				    <li><span></span>회원선택</li>
				    <li class="on"><span></span>약관동의</li>
				    <li><span></span>정보입력</li>
				    <li><span></span>가입완료</li>
				</ul>
				<div class="agree">
				    <div class="top">
				        <p>소중한 회원님의 정보는 동의 없이 공개 되지 않으며 개인정보보호정책에 의거하여 보호 받고 있습니다.  지존에서는 회원님들의 개인정보보호를 위해 최선을 다할 것을 약속 드립니다. <b>이용약관, 개인정보 취급방침  및 휴면계정 약관에 대한 내용을 모두 확인하고 동의합니다.</b></p>
				        <div class="ui_radio--custom">
				            <input type="checkbox" name="" id="agree_confirm_all">
				            <label for="agree_confirm_all"><span class="chk_ball"></span>모두 동의합니다</label>
				        </div>
				    </div>
				            
				    <h2 class="h2">이용약관</h2>
				    <div class="example-box">
				        <p>내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.</p>
				    </div>
				    <div class="ui_radio--custom">
				        <input type="checkbox" name="" id="agree_confirm_1">
				        <label for="agree_confirm_1"><span class="chk_ball"></span>약관에 동의합니다(필수)</label>
				    </div>
				
				
				    <h2 class="h2">개인정보 취급방침</h2>
				    <div class="example-box">
				        <p>내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.</p>
				    </div>
				    <div class="ui_radio--custom">
				        <input type="checkbox" name="" id="agree_confirm_2">
				        <label for="agree_confirm_2"><span class="chk_ball"></span>약관에 동의합니다(필수)</label>
				    </div>
				
				
				
				    <h2 class="h2">휴면 계정 약관</h2>
				    <div class="example-box">
				        <p>내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.</p>
				    </div>
				    <div class="ui_radio--custom">
				        <input type="checkbox" name="" id="agree_confirm_3">
				        <label for="agree_confirm_3"><span class="chk_ball"></span>약관에 동의합니다(필수)</label>
				    </div>
				
				
				       
				    <div class="text-center">
				        <button type="button" class="btn btn-default">취소</button>
				        <button type="button" class="btn btn-primary">다음</button>
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
