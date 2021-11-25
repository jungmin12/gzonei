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

<h1 style="margin-bottom: 50px;font-size: 40px;color: #000;">나의 관심정보 (화면정의서 20p)</h1> <!--페이지 안내 텍스트 입니다 개발 시 지워주세요-->

<p>회원님께서 관심있게 보신 개발정보를 그룹으로 묶어 관리하실 수 있습니다. <br>관심정보는 3개월간 저장됩니다.</p>
<div class="group_wrap">
    <div class="left">
        <h2 class="h2">그룹 관리</h2>
        <!-- 팝업1:S -->
        <div class="layer-button">
            <button type="button" class="bt" data-button="modal" data-target="#demo-media__popup" data-width="auto">
                추가/수정
            </button>
        </div>
        <div class="modal" id="demo-media__popup" tabindex="0" role="dialog">
            <div class="modal__body">
                <div class="modal__content">
                    <h2 class="h2">관심정보 그룹 추가/삭제</h2>
                    <strong>그룹 추가</strong>
                    <div class="form-group">
                        <input type="text" name="" id="" class="form-control">
                        <button type="button" class="btn btn-default">추가</button>
                    </div>
                    <strong>그룹 삭제</strong>
                    <div class="scroll">
                        <ul>
                            <li><input type="checkbox" id="group1" name="" value=""><label class="checkbox-inline" for="group1">Item1</label></li>
                            <li><input type="checkbox" id="group2" name="" value=""><label class="checkbox-inline" for="group2">Item2</label></li>
                            <li><input type="checkbox" id="group3" name="" value=""><label class="checkbox-inline" for="group3">Item3</label></li>
                            <li><input type="checkbox" id="group4" name="" value=""><label class="checkbox-inline" for="group4">Item4</label></li>
                            <li><input type="checkbox" id="group5" name="" value=""><label class="checkbox-inline" for="group5">Item5</label></li>
                            <li><input type="checkbox" id="group6" name="" value=""><label class="checkbox-inline" for="group6">Item6</label></li>
                            <li><input type="checkbox" id="group7" name="" value=""><label class="checkbox-inline" for="group7">Item7</label></li>
                        </ul>
                    </div>
                    <div class="right">
                        <button type="button" class="btn btn-default">삭제</button>
                    </div>
                </div>
                <div class="modal__close">
                    <button type="button" data-close="modal" class="modal__close-button">
                        <span>닫기</span>
                    </button>
                </div>
            </div>
        </div>
        <!-- 팝업1:E -->
        <ul>
            <li class="on"><a href="">전체 (14건)</a></li>
            <li><a href="">Item1 (5건)</a></li>
            <li><a href="">Item2 (9건)</a></li>
        </ul>
    </div>
    <div class="right">
        <h2 class="h2">그룹 조회 내역</h2>
        <a class="bt" href="#">선택삭제</a>
        <div class="wrap">
            <div class="box">
                <input type="checkbox" name="" id="checkbox1" value="">
                <label for="checkbox1">
                    <strong>신정 도시개발사업(前.신정동 갈산도시개발사업)</strong>
                    <ul>
                        <li>사업지구 : 도시개발사업</li>
                        <li>시행사 : 지방공사 > SH공사</li>
                        <li>사업방식 : 환지</li>
                    </ul>
                    <em>2021.03.18</em>
                </label>
            </div>
            <div class="box">
                <input type="checkbox" name="" id="checkbox2" value="">
                <label for="checkbox2">
                    <strong>신정 도시개발사업(前.신정동 갈산도시개발사업)</strong>
                    <ul>
                        <li>사업지구 : 도시개발사업</li>
                        <li>시행사 : 지방공사 > SH공사</li>
                        <li>사업방식 : 환지</li>
                    </ul>
                    <em>2021.03.18</em>
                </label>
            </div>
            <div class="box">
                <input type="checkbox" name="" id="checkbox3" value="">
                <label for="checkbox3">
                    <strong>신정 도시개발사업(前.신정동 갈산도시개발사업)</strong>
                    <ul>
                        <li>사업지구 : 도시개발사업</li>
                        <li>시행사 : 지방공사 > SH공사</li>
                        <li>사업방식 : 환지</li>
                    </ul>
                    <em>2021.03.18</em>
                </label>
            </div>
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
