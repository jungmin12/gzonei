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
                <h2 class="page__title">경·공매 사례</h2>
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
	            
			<div class="nav-4th">
				<ul>
					<li class="active"><a href="#">4차탭메뉴ov</a></li>
					<li><a href="#">4차탭메뉴</a></li>
					<li><a href="#">4차탭메뉴</a></li>
					<li><a href="#">4차탭메뉴</a></li>
				</ul>
			</div>
            <!-- content 영역입니다. -->
			<!-- view : S -->
			<div class="board_view_in">
                    <div class="form-horizontal bucket-form">
	                   <div class="form-group">
						    <div class="col-sm-2 control-label col-lg-2 col-hide"><label for="select">구분 <span class="pilsu">필수</span></label></div>
						    <div class="col-sm-3">
								<select id="select" name="select" class="form-control" title="구분 선택" required="">
									<option value="">전체</option>
									<option value="A">선택</option>
								</select>
						    </div>
						    <div class="col-sm-9">
						    	<input type="text" id="name" name="name" title="이름 입력" class="form-control" value="">
							</div>
						</div> 
						<div class="form-group">
						    <div class="col-sm-1 control-label"><label for="select">공지여부</label></div>
						    <div class="col-sm-2">
				                <input class="checkbox-input" type="checkbox" id="checkbox1" name="" title="수신동의" value="a">
				                <label class="checkbox-inline" for="checkbox1">수신동의</label>
				            </div>
						    <div class="col-sm-1 control-label"><label for="select">전시여부</label></div>
						    <div class="col-sm-2">
				                <input class="radio-input" type="radio" id="radio1" >
				                <label class="radio-inline" for="radio1">전시</label>
				                <input class="radio-input" type="radio" id="radio2" >
				                <label class="radio-inline" for="radio2">미전시</label>
				            </div>
						    <div class="col-sm-1 control-label"><label for="select">삭제여부</label></div>
						    <div class="col-sm-2">
				                <input class="radio-input" type="radio" id="radio3" >
				                <label class="radio-inline" for="radio3">삭제</label>
				                <input class="radio-input" type="radio" id="radio4" >
				                <label class="radio-inline" for="radio4">미삭제</label>
				            </div>
				        </div>
						<div class="form-group form-line">
						    <div class="col-sm-12">
						    	<textarea class="form-control" id="content" name="content" title="내용 입력" rows="20"> </textarea>
							</div>
						</div> 
						<div class="form-group">
						    <div class="col-sm-2 control-label col-lg-2"><label for="select">첨부파일 <span class="pilsu">필수</span></label></div>
						    <div class="col-sm-5">
						    	<div class="form-upload">
						    	 	<div class="file-form-group">
						    	 		<div class="form-group__upload">
						    	 			<input type="text" readonly="readonly" class="form-control disabled" title="1번째 파일명">
						    	 			<input type="file" name="file_1" id="atchmn_1" class="form-upload__file--hidden">
						    	 		</div>
						    	 		<div class="form-input__addon">
			                                <label for="atchmn_1" class="btn btn-sm btn-secondary" data-button="upload"><span class="skip">1번째 </span>파일첨부하기</label>
			                           </div>
						    	 	</div>
						    	 	<!--
						    	 	<div class="file-form-group">
						    	 		<div class="form-group__upload">
						    	 			<input type="text" readonly="readonly" class="form-control disabled" title="1번째 파일명">
						    	 			<input type="file" name="file_1" id="atchmn_1" class="form-upload__file--hidden">
						    	 		</div>
						    	 		<div class="form-input__addon">
			                                <label for="atchmn_1" class="btn btn-sm btn-secondary" data-button="upload"><span class="skip">2번째 </span>파일선택</label>
			                           </div>
						    	 	</div>
						    	 	-->
						    	 	<div class="file-button">
							    	 	<button type="button">추가</button>
							    	 	<button type="button">삭제</button>
							    	</div>
						    	</div>
							</div>
						</div> 
	                    
                    </div>
                    
                    
                    <div class="board_btm">
                        <div class="btns_area fl_r mo_block">
                            <a href="#" class="btn btn-default">등록</a>
                        </div>
                    </div>
                </div>
				<!-- view : E -->
			
			
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
