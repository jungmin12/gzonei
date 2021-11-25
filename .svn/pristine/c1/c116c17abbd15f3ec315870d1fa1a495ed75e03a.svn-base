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

<h1 style="margin-bottom: 50px;font-size: 40px;color: #000;">회원정보입력 (화면정의서 14p)</h1> <!--페이지 안내 텍스트 입니다 개발 시 지워주세요-->
<ul class="step_list">
    <li><span></span>회원선택</li>
    <li><span></span>약관동의</li>
    <li class="on"><span></span>정보입력</li>
    <li><span></span>가입완료</li>
</ul>

<div class="join_wrap">
            
    <h2 class="h2">14세 이상의 일반회원</h2>
    <p class="point">* 표시된 항목은 필수 항목이므로 꼭 입력하셔야 합니다. </p>
        
    <div class="form-horizontal bucket-form">
        <div class="form-group">
            <div class="col-sm-2 control-label"><label for="name"><span class="pilsu">필수입력</span>회원명</label></div>
            <div class="col-sm-4">
                <input type="text" value="" id="name" name="name" title="회원명 입력" class="form-control indispensable">
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-2 control-label"><label for="eng_name"><span class="pilsu">필수입력</span>아이디</label></div>
            <div class="col-sm-10">
                <div class="form-inline">
                    <input type="text" value="" id="eng_name" name="eng_name" title="아이디" class="form-control indispensable">
                    <button type="button" class="btn btn-default">중복검사</button>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-2 control-label"><label for="pw"><span class="pilsu">필수입력</span>비밀번호</label></div>
            <div class="col-sm-4">
                <input type="password" value="" id="pw" name="pw" title="비밀번호 입력" class="form-control indispensable" placeholder="영문자, 숫자, 특수문자 조합으로 최소 8자 이상 입력해 주세요.">
            </div>  
            <div class="col-sm-2 control-label"><label for="pw_check"><span class="pilsu">필수입력</span>비밀번호확인</label></div>
            <div class="col-sm-4">
                <input type="password" value="" id="pw_check" name="pw_check" title="비밀번호 확인 입력" class="form-control indispensable" placeholder="비밀번호를 한번 더 입력해주세요.">
            </div>
        
        </div>
        <div class="form-group">
            <div class="col-sm-2 control-label"><label for="birth"><span class="pilsu">필수입력</span>연령대</label></div>
            <div class="col-sm-4">
                <select id="tel1" name="tel" class="form-control" title="연령대 선택">
                    <option value=""></option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-2 control-label"><label for="tel"><span class="pilsu">필수입력</span>휴대폰</label></div>
            <div class="col-sm-10">
                <div class="form-inline">
                    <select id="tel1" name="tel" class="form-control" title="연락처 첫번째창 선택">
                        <option value="02">02</option>
                        <option value="031">031</option>
                        <option value="032">032</option>
                        <option value="033">033</option>
                        <option value="041">041</option>
                        <option value="042">042</option>
                        <option value="043">043</option>
                        <option value="044">044</option>
                        <option value="051">051</option>
                        <option value="052">052</option>
                        <option value="053">053</option>
                        <option value="054">054</option>
                        <option value="055">055</option>
                        <option value="061">061</option>
                        <option value="062">062</option>
                        <option value="063">063</option>
                        <option value="064">064</option>
                        <option value="070">070</option>
                    </select>
                    <span>-</span>
                    <input type="text" id="tel2" name="tel2" title="연락처 두번째창 입력" class="form-control" value="" maxlength="4" onkeydown="onlyNumber(this)">
                <span>-</span>
                <input type="text" id="tel" name="tel3" title="연락처 세번째창 입력" class="form-control" value="" maxlength="4" onkeydown="onlyNumber(this)">
                <input type="hidden" name="tel3" value="">
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-2 control-label"><label for="email1"><span class="pilsu">필수입력</span>이메일 </label></div>
            <div class="col-sm-10">
                <div class="form-inline">
                    <input type="text" id="email1" name="email" title="이메일 주소 입력" class="form-control indispensable" value="">
                    <span>@</span>
                    <input type="text" id="email2" name="email" title="이메일 도메인 입력" class="form-control indispensable">
                    <select id="emailSel" title="이메일 도메인 선택" class="form-control" onchange="javascript: setEmailSelectBox(this)">
                        <option value="" selected="selected">직접입력</option>
                        <option value="naver.com">네이버</option>
                        <option value="daum.net">다음</option>
                        <option value="hanmail.net">한메일</option>
                        <option value="gmail.com">구글</option>
                        <option value="hotmail.com">핫메일</option>
                        <option value="yahoo.com">야후</option>
                        <option value="nate.com">네이트</option>
                    </select>
                    <input type="hidden" name="email" value="">
	                <input class="checkbox-input" type="checkbox" id="checkbox1" name="" title="수신동의" value="a">
	                <label class="checkbox-inline" for="checkbox1">수신동의</label>
                    
                </div>
            </div>
        </div>
        <div class="form-group">
           <div class="col-sm-2 control-label"><label for="zip_view"><span class="pilsu">필수입력</span>주소 </label></div>
           <div class="col-sm-10">
                <div class="form-control-static">
                    <div class="col-md-4 form-group">
                        <input type="text" name="zip_view" id="zip_view" maxlength="8" class="form-control">
                        <input type="hidden" id="zip" name="addrZip" value="">
                    </div>
                    <button type="button" onclick="javascript:goZipCodePopup();" class="btn btn-default">주소검색</button>
        
                </div>
                <div class="form-control-static">
                    <input type="text" id="adres" name="addr" class="form-control" title="주소 입력">
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-2 control-label"><label for="brhs">관심지역</label></div>
            <div class="col-sm-4">
                <div class="form-inline">
                    <select id="" name="" class="form-control" title="관심지역 첫번째창 선택">
                        <option value="">서울</option>
                    </select>
                    <select id="" name="" class="form-control" title="관심지역 두번째창 선택">
                        <option value="">구/군</option>
                    </select>
                </div>
            </div>
            <div class="col-sm-2 control-label"><label for="">관심분야</label></div>
            <div class="col-sm-4">
                <input class="radio-input" type="radio" id="radio1" name="ch_01_01" title="개발정보" value="a">
                <label class="radio-inline" for="radio1">개발정보</label>
                <input class="radio-input" type="radio" id="radio2" name="ch_01_01" title="투자정보" value="b">
                <label class="radio-inline" for="radio2">투자정보</label>
            </div>
        </div>
    </div>


    <h2 class="h2">정보 제공 수신 동의</h2>
    <div class="example-box">
        <p>내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.</p>
    </div>
    <div class="ui_radio--custom">
        <input type="checkbox" name="" id="agree_confirm_1">
        <label for="agree_confirm_1"><span class="chk_ball"></span>SMS 문자메세지</label>
        <input type="checkbox" name="" id="agree_confirm_2">
        <label for="agree_confirm_2"><span class="chk_ball"></span>E-mail</label>
        <input type="checkbox" name="" id="agree_confirm_3">
        <label for="agree_confirm_3"><span class="chk_ball"></span>SNS</label>
    </div>



    <h2 class="h2">정보 수신 미동의 약관</h2>
    <div class="example-box">
        <p>내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.</p>
    </div>
    <div class="ui_radio--custom">
        <input type="checkbox" name="" id="agree_confirm_4">
        <label for="agree_confirm_4"><span class="chk_ball"></span>약관에 동의합니다(필수)</label>
    </div>


       
    <div class="text-center">
        <button type="button" class="btn btn-default">취소</button>
        <button type="button" class="btn btn-primary">회원가입</button>
    </div>
                
</div>

<h1 style="margin-bottom: 50px;font-size: 40px;color: #000;">회원가입완료 (화면정의서 14p)</h1> <!--페이지 안내 텍스트 입니다 개발 시 지워주세요-->
<ul class="step_list">
    <li><span></span>회원선택</li>
    <li><span></span>약관동의</li>
    <li><span></span>정보입력</li>
    <li class="on"><span></span>가입완료</li>
</ul>
<div class="out_wrap2">
    <span></span>
    <strong><b>GZONE</b>회원가입이 완료되었습니다</strong>
    <p>로그인 후 서비스를 이용하실 수 있습니다.</p>
    <button type="button" class="btn btn-default">메인으로</button>
    <button type="button" class="btn btn-primary">로그인페이지가기</button>
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
