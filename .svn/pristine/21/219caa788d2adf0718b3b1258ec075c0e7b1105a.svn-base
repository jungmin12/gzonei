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
                <h2 class="page__title">경·공매 사례
</h2>
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
					    <div class="col-sm-2 control-label"><label for="select">select <span class="pilsu">필수입력</span></label></div>
					    <div class="col-sm-4">
							<select id="select" name="select" class="form-control" title="구분 선택" required="">
								<option value="">전체</option>
								<option value="A">선택</option>
							</select>
					    </div>
					</div>
				
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label for="gubun1">select 구분1 <span class="pilsu">필수입력</span></label></div>
					    <div class="col-sm-4">
					    <select id="gubun1" name="gubun1" class="form-control" title="구분 선택" required="">
					    	<option value="">전체</option>
					    	<option value="A">구분1</option>
					    </select>
					    </div>
					    <div class="col-sm-4">
					    <select id="gubun2" name="gubun2" class="form-control" title="구분 선택">
					    	<option value="">전체</option>
					    	<option value="B">구분2</option>
					    </select>
						</div>
					</div>
					
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label for="gubun_a">select 구분2 <span class="pilsu">필수입력</span></label></div>
					    <div class="col-sm-4">
						    <select id="gubun_a" name="gubun_a" class="form-control" title="구분 선택" required="">
						    	<option value="">전체</option>
						    	<option value="A">구분1</option>
						    </select>
					    </div>
					    <div class="col-sm-2">
						    <select id="gubun_b" name="gubun_b" class="form-control" title="구분 선택">
						    	<option value="">전체</option>
						    	<option value="A">구분1</option>
						    </select>
					    </div>
					    <div class="col-sm-2">
						    <select id="gubun_c" name="gubun_c" class="form-control" title="구분 선택">
						    	<option value="">전체</option>
						    	<option value="A">구분1</option>
						    </select>
					    </div>
					</div>
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label for="name">이름 </label></div>
					    <div class="col-sm-9">
					    	<input type="text" id="name" name="name" title="이름 입력" class="form-control" value="">
						</div>
					</div>
				
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label for="age">나이</label></div>
					    <div class="col-sm-4">
					    	<input type="text" id="age" name="age" title="나이 입력" class="form-control" value="">
						</div>
					</div>
				
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label for="tel1">전화번호 <span class="pilsu">필수입력</span></label></div>
					  		<div class="col-sm-9">
								<div class="form-inline">
									<select id="tel1" name="tel1" class="form-control num" title="전화번호 첫번째  선택" required="">
										<option value="010">010</option>
										<option value="011">011</option>
										<option value="016">016</option>
										<option value="017">017</option>
										<option value="018">018</option>
										<option value="019">019</option>
									</select>
									<span>-</span>
										<input type="text" id="tel2" name="tel" title="전화번호 두번째창 입력" class="form-control num" value="" required="">
									<span>-</span>
									<input type="text" id="tel2" name="tel" title="전화번호 세번째창 입력" class="form-control num" value="" required="">
								</div>
							</div>
					</div>
				
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label for="email">이메일</label></div>
					    <div class="col-sm-9">
							<div class="form-inline">
								<input type="text" id="email" name="email" title="이메일 주소 입력" class="form-control mail" value="">
							    <span>@</span>
							    <input type="text" id="email2" title="이메일 도메인 입력" class="form-control mail">
								<select id="emailSel" title="이메일 도메인 선택" class="form-control mail">
									<option value="" selected="selected">직접입력</option>
									<option value="naver.com">네이버</option>
									<option value="daum.net">다음</option>
									<option value="hanmail.net">한메일</option>
									<option value="gmail.com">구글</option>
									<option value="hotmail.com">핫메일</option>
									<option value="yahoo.com">야후</option>
									<option value="nate.com">네이트</option>
								</select>
							</div>
					    </div>
					</div>
				
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label for="zip_view">주소 </label></div>
					    <div class="col-sm-9">
								<div class="form-control-static">
									<div class="col-sm-4 form-group">
										<input type="text" name="zip_view" id="zip_view" maxlength="8" placeholder="우편번호" readonly="readonly" class="form-control">
										<input type="hidden" id="zip" name="zip" value="">
									</div>
									<button type="button" class="btn btn-primary btn-sm"><i class="fa fa-search" aria-hidden="true"></i> 주소검색</button>
				
								</div>
								<div class="form-control-static">
								<input type="text" id="addr" name="addr" class="form-control" title="주소 입력">
								</div>
								<div class="form-control-static">
									<input type="text" id="detail_adres" name="detail_adres" class="form-control" title="상세주소 입력">
								</div>
				
						    </div>
				        </div>
				
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label for="radio1">radio</label></div>
					    <div class="col-sm-9">
							<label class="radio-inline" for="radio1">
							    <input type="radio" id="radio1" name="radio" title="라디오1" value="a">radio1
							</label>
							<label class="radio-inline" for="radio2">
							    <input type="radio" id="radio2" name="radio" title="라디오2" value="b">radio2
							</label>
							<label class="radio-inline" for="radio3">
							    <input type="radio" id="radio3" name="radio" title="라디오3" value="c" checked="">radio3
							</label>
					   	</div>
					</div>
				
					<div class="form-group">
					    <div class="col-sm-2 control-label"><label for="age">checkbox</label></div>
					    <div class="col-sm-9">
							<label class="checkbox-inline" for="checkbox">
							    <input type="checkbox" id="checkbox1" name="checkbox" title="checkbox1" value="d">checkbox1
							</label>
							<label class="checkbox-inline" for="checkbox2">
							    <input type="checkbox" id="checkbox2" name="checkbox" title="checkbox2" value="e">checkbox2
							</label>
							<label class="checkbox-inline" for="checkbox3">
							    <input type="checkbox" id="checkbox3" name="checkbox" title="checkbox3" value="f" checked="">checkbox3
							</label>
				    	</div>
					</div>
				
				    <div class="form-group">
				        <div class="col-sm-2 control-label"><label for="gubun3">첨부파일</label></div>
				        <!--
				            <div class="col-sm-4">
				                <input type="file" id="file" name="file" title="청부파일">
				            </div>
				            <div class="col-sm-5">
				                <input name="fileCn" type="text" title="첨부파일 설명입력" placeholder="첨부파일 설명입력" class="form-control">
				            </div>
				            -->
				
				            <div class="col-sm-9">
				            <div class="form-upload">
						              <div class="file-form-group"> 
						               <div class="form-group__upload">
						                   <input type="file" id="atchFileId_2" name="file_2" class="form-upload__file--hidden" multiple="">
						                   <span id="atchFileId_name2" class="form-control disabled"></span>
						                   <button type="button" class="form-upload__clear clear">선택한 2번 첨부 제거</button>
						               </div>
						               <div class="form-input__addon">
						                   <label for="atchFileId_2" class="btn btn btn-primary" data-button="upload" data-parent=".form-upload" data-original="#atchFileId_2" data-showfilename="atchFileId_name2"><span class="skip">1번째 </span>파일선택</label>
						               </div>
						             <!--  <input type="text" id="replcText_2" name="replcText" class="form-control" title="2번 첨부 이미지 대체 텍스트 입력" value="" placeholder="첨부 이미지 대체 텍스트 입력"> -->
						          </div>
				                </div>
				                </div>
				    </div>
				
				    <div class="form-group">
				        <div class="col-sm-2 control-label"><label for="gubun3">날짜</label></div>
				        <div class="col-sm-9">
				            <div class="form-inline">
				                <div class="search--calendar">
									<span>
										<input type="text" class="form-control" name="startDate" id="startDate" placeholder="시작일" value="" title="시작일 입력">
										<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
									</span>
								</div>
								<span class="sym">~</span>
								<div class="search--calendar">
									<span>
										<input type="text" class="form-control" name="endDate" id="endDate" placeholder="종료일" value="" title="종료일 입력">
                                    <button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
									</span>
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
