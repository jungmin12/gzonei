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
                                <a class="fa" href="#" onclick="facebookOpen('목록 > 신청 > 교육신청 > 교육프로그램 > 천안시직장맘지원센터','http://ca_momsworld.hdmotion.co.kr/kr/html/sub01/010101.html'); return false;" title="페이스북 공유하기, 새창열림">페이스북</a>
                                <a class="bl" href="#" onclick="naverOpen('목록 > 신청 > 교육신청 > 교육프로그램 > 천안시직장맘지원센터','http://ca_momsworld.hdmotion.co.kr/kr/html/sub01/010101.html'); return false;" title="블로그 공유하기, 새창열림">블로그</a>
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
            <div class="title_wrap" style="margin:50px 0 30px">
				<h4 class="sub_tit">[검색 - 1]</h4>
			</div>
            <div class="guide_item" style="margin-top:0;">
	            <!-- 검색 : S -->
	            <form name="bbsNttSearchForm" method="get" action="/">
				 <fieldset>
					 <legend>게시물 검색</legend>
					 <div class="search">
                        <div class="search-date">
                            <div class="inner">
	                            
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
                        <div class="search-text">
                            <div class="inner">
                                <div class="search--select">
									 <!-- select추가시 -->
									 <span> 
										 <select name="" title="검색 영역 선택">
										 	<option value="">제목</option>
											<option value="">작성자</option>
											<option value="">내용</option>
										 </select>
									 </span>
									 <!-- select추가시 -->
								 </div>
                                <div class="search--text">
									 <span><input type="text" name="searchKrwd" value="" title="검색어를 입력해주세요" placeholder="검색어를 입력해주세요" class="form-control"></span>
								</div>
								<div class="search--btn">
									 <span class="btn--submit"><input type="submit" value="검색"></span>
								 </div>
                            </div>
                        </div>			
                    </div>
				 </fieldset>
			 </form>
			 <link rel="stylesheet" href="/pcms/common/pluigs/jQueryDatepicker/jquery.datetimepicker.min.css">
			 <script src="/pcms/common/pluigs/jQueryDatepicker/jquery.datetimepicker.full.min.js"></script>
			 <script>
				$(document).ready(function(){
				    
				    $.datetimepicker.setLocale('ko');
				    $("#startDate,#endDate").datetimepicker({
				        timepicker : false,
				        format : 'Y-m-d',
				        scrollMonth : false,
				        scrollInput : false
				    });
				    
				    
				}); 
			</script>
			<!-- 검색 : E -->
            </div>
            
            
             <div class="title_wrap" style="margin:50px 0 30px">
				<h4 class="sub_tit">[검색 - 2]</h4>
			</div>
            <div class="guide_item" style="margin-top:0;">
	            <form name="bbsNttSearchForm" method="get" action="/">
				 <fieldset>
					 <legend>검색</legend>
					 <div class="search">
                        <!-- 01. item -->
                        <div class="item form-item">
                            <div class="form-group form-group1">
								<span class="tit">구분</span>
								<div class="search-inner text-left">
									<div class="search--select">
							    		<span>
								    		<select name="">
												<option value="">-- 전체 --</option>
											</select>
									   </span>
							    	</div>
								</div>
							</div>
							<div class="form-group form-group2">
								<span class="tit">법원</span>
								<div class="search-inner text-left">
									<div class="search--select">
							    		<span>
								    		<select name="">
												<option value="">-- 전체 --</option>
											</select>
									   </span>
									   <span>
								    		<select name="">
												<option value="">-- 전체 --</option>
											</select>
									   </span>
							    	</div>
								</div>
							</div>
						</div>	
						<!-- 01. item ::E -->
                        <!-- 01. item -->
                        <div class="item form-item">
                            <div class="form-group form-group1">
								<span class="tit">입찰시작일</span>
								<div class="search-inner text-left">
									<div class="search--calendar">
										<span>
											<input type="text" class="form-control" name="startDate" id="startDate" placeholder="시작일" value="" title="시작일 입력">
											<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
										</span>
									</div>
								</div>
							</div>
							<div class="form-group form-group2">
								<span class="tit">입찰종료일</span>
								<div class="search-inner text-left">
									<div class="search--calendar">
										<span>
											<input type="text" class="form-control" name="endDate" id="endDate" placeholder="종료일" value="" title="종료일 입력">
	                                    <button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
										</span>
									</div>
								</div>
							</div>
						</div>	
						<!-- 01. item ::E -->
						<!-- 01. item -->
                        <div class="item form-item">
                            <div class="form-group form-group1">
								<span class="tit">경매사건번호</span>
								<div class="search-inner text-left">
									<div class="search--select">
							    		<span>
								    		<select name="">
												<option value="">-- 전체 --</option>
											</select>
									   </span>
							    	</div>
								</div>
							</div>
							<div class="form-group form-group2">
								<span class="tit">타경</span>
								<div class="search-inner text-left">
									<div class="search--text">
										<span><input type="text" name="searchKrwd" value="" title="검색어를 입력해주세요" placeholder="검색어를 입력해주세요" class="form-control"></span>
									</div>
								</div>
							</div>
						</div>	
						<!-- 01. item ::E -->
						<!-- 01. item -->
                        <div class="item">
                            <div class="form-group full-group">
								<span class="tit">구분</span>
								<div class="search-inner text-left">
									<label class="checkbox-inline" for="id1">
									    <input type="checkbox" id="id1" name="">전체
									</label>
									<label class="checkbox-inline" for="id2">
									    <input type="checkbox" id="id2" name="">주거시설
									</label>
									<label class="checkbox-inline" for="id3">
									    <input type="checkbox" id="id3" name="">업무및상업시설
									</label>
									<label class="checkbox-inline" for="id4">
									    <input type="checkbox" id="id4" name="">토지
									</label>
									<label class="checkbox-inline" for="id5">
									    <input type="checkbox" id="id5" name="">공업시설
									</label>
									<label class="checkbox-inline" for="id6">
									    <input type="checkbox" id="id6" name="">동산및권리권
									</label>
									<div class="search--btn">
										 <span class="btn--submit"><input type="submit" value="검색"></span>
									</div>
								</div>
							</div>
						</div>	
						<!-- 01. item ::E -->
						
                    </div>
				 </fieldset>
			 </form> 
            </div>
            
            
             <div class="title_wrap" style="margin:50px 0 30px">
				<h4 class="sub_tit">[검색 - 3]</h4>
			</div>
            <div class="guide_item" style="margin-top:0;">
	            
	            
	            <form name="searchForm" method="post" action="">
			<input name="emplyrId" type="hidden" value="">
			<input name="pageIndex" type="hidden" value="">
				 <fieldset>
					 <legend>검색</legend>
					 <div class="search">
					 	 <!-- 01. item -->
                        <div class="item form-item">
                            <div class="form-group form-group1">
								<span class="tit">기간검색</span>
								<div class="search-inner text-left">
									<div class="search--calendar">
										<span>
											<input type="text" class="form-control" name="startDate" id="startDate" placeholder="시작일" value="" title="시작일 입력">
											<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
										</span>
									</div> ~
									<div class="search--calendar">
										<span>
											<input type="text" class="form-control" name="endDate" id="endDate" placeholder="종료일" value="" title="종료일 입력">
	                                    <button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
										</span>
									</div>
								</div>
							</div>
							 <div class="form-group form-group2">
								<span class="tit">회원등급</span>
								<div class="search-inner text-left">
									<div class="search--select">
							    		<span>
								    		<select name="grad_code_nm">
												<option value="">-- 전체 --</option>
												
					                 			<option value="골드">골드</option>
					                 			
					                 			<option value="프리미엄">프리미엄</option>
					                 			
					                 			<option value="법인(골드)">법인(골드)</option>
					                 			
					                 			<option value="법인(프리미엄)">법인(프리미엄)</option>
					                 			
					                 			<option value="실버(이코노미)">실버(이코노미)</option>
					                 			
					                 			<option value="실버(스페셜)">실버(스페셜)</option>
					                 			
					                 			<option value="골드(이코노미)">골드(이코노미)</option>
					                 			
					                 			<option value="골드(비즈니스)">골드(비즈니스)</option>
					                 			
					                 			<option value="골드(스페셜)">골드(스페셜)</option>
					                 			
					                 			<option value="프리미엄(이코노미)">프리미엄(이코노미)</option>
					                 			
					                 			<option value="프리미엄(스페셜)">프리미엄(스페셜)</option>
					                 			
											</select>
									   </span>
							    	</div>
								</div>
							</div>
							<div class="form-group form-group2">
								<span class="tit">회원상태</span>
								<div class="search-inner text-left">
									<div class="search--select">
							    		<span>
								    		<select name="mber_sttus_code">
												<option value="">-- 전체 --</option>
												<option value="CM00220001">승인요청</option>
					                 			<option value="CM00220002">승인</option>
					                 			<option value="CM00220004">탈퇴요청</option>
					                 			<option value="CM00220005">탈퇴</option>
											</select>
									   </span>
							    	</div>
								</div>
							</div>
						</div>	
						<!-- 01. item ::E -->
                        <!-- 01. item -->
                        <div class="item form-item">
							<div class="form-group form-group1">
								<span class="tit">이메일<br>수신여부</span>
								<div class="search-inner text-left">
									<div class="search--select">
							    		<span>
								    		<select name="email_recptn_at">
												<option value="">-- 전체 --</option>
												<option value="Y">수신</option>
												<option value="N">미수신</option>
											</select>
									   </span>
							    	</div>
								</div>
							</div>
							<div class="form-group form-group2">
								<span class="tit">SMS<br>수신여부</span>
								<div class="search-inner text-left">
									<div class="search--select">
							    		<span>
								    		<select name="sms_recptn_at">
												<option value="">-- 전체 --</option>
												<option value="Y">수신</option>
												<option value="N">미수신</option>
											</select>
									   </span>
							    	</div>
								</div>
							</div>
							<div class="form-group form-group2">
								<span class="tit">정렬기준</span>
								<div class="search-inner text-left">
									<div class="search--select">
							    		<span>
								    		<select name="order">
												<option value="">-- 기준 --</option>
												<option value="emplyr_id">아이디</option>
												<option value="user_nm">사용자명</option>
												<option value="mbtlnum">휴대폰</option>
												<option value="bizrno">사업자등록번호</option>
												<option value="cmpny_nm">상호(회사명)</option>
												<option value="rprsntv_nm">대표자명</option>
											</select>
									   </span>
							    	</div>
									<div class="search--select">
							    		<span>
								    		<select name="type">
												<option value="">-- 기준 --</option>
												<option value="ASC">오름차순</option>
												<option value="DESC">내림차순</option>
											</select>
									   </span>
							    	</div>
								</div>
							</div>
						</div>	
						<!-- 01. item ::E -->
						<!-- 01. item -->
                        <div class="item form-item">
                            <div class="form-group full-group">
								<span class="tit">검색조건</span>
								<div class="search-inner text-left">
									<div class="search--select">
							    		<span>
								    		<select name="searchSel">
												<option value="">-- 전체 --</option>
												<option value="emplyr_id">아이디</option>
												<option value="user_nm">사용자명</option>
												<option value="mbtlnum">휴대폰</option>
												<option value="bizrno">사업자등록번호</option>
												<option value="cmpny_nm">상호(회사명)</option>
												<option value="rprsntv_nm">대표자명</option>
											</select>
									   </span>
							    	</div>
									<div class="search--text">
										<span><input type="text" name="searchKrwd" value="" title="검색어를 입력해주세요" placeholder="검색어를 입력해주세요" class="form-control"></span>
									</div>
								
									<div class="search--btn">
										 <span class="btn--submit"><input type="submit" value="검색"></span>
									</div>
								</div>
							</div>
						</div>	
						<!-- 01. item ::E -->
						
                    </div>
				 </fieldset>
			 </form>
	            
            </div>
             
             <div class="title_wrap" style="margin:50px 0 30px">
				<h4 class="sub_tit">[검색 - 4]</h4>
			</div>
            <div class="guide_item" style="margin-top:0;">
	            
	            <form name="bbsNttSearchForm" method="get" action="/">
				 <fieldset>
					 <legend>검색</legend>
					 <div class="search custom-search">
						<div class="form-group p-row">
							<span class="p-col-3 p-col-sm-6 tit">검색조건</span>
							<div class="p-col-4 p-col-sm-9">
	                       	 <input type="text" id="hname" name="hname" class="p-control" value="최상훈">
	                       </div>
							<div class="p-col-4 p-col-sm-9">
	                       	 <input type="text" id="hname" name="hname" class="p-control" value="최상훈">
	                       </div>
							<span class="p-col-3 p-col-sm-6 tit">회원등급</span>
							<div class="p-col-4  p-col-sm-18">
	                       	 <select name="grad_code_nm" class="p-control" >
								<option value="">-- 전체 --</option>
							</select>
	                       </div>
						</div>
						
						<div class="form-group p-row">
							<span class="p-col-3 p-col-sm-6 tit">검색조건</span>
							<div class="p-col-4 p-col-sm-18">
	                       	 <select name="grad_code_nm" class="p-control" >
								<option value="">-- 전체 --</option>
							</select>
	                       </div>
							<span class="p-col-3 p-col-sm-6 tit">회원등급</span>
							<div class="p-col-4  p-col-sm-18">
	                       	 <select name="grad_code_nm" class="p-control" >
								<option value="">-- 전체 --</option>
							</select>
	                       </div>
							<span class="p-col-3 p-col-sm-6 tit">회원등급</span>
							<div class="p-col-3  p-col-sm-9">
	                       	 <select name="grad_code_nm" class="p-control" >
								<option value="">-- 전체 --</option>
							</select>
	                       </div>
	                       
						</div>
						<div class="form-group p-row">
							<span class="p-col-3 p-col-sm-6 tit">검색조건</span>
							<div class="p-col-18 p-col-sm-18">
	                       	 	<div class="checkbox-group text-left">
									<label class="checkbox-inline" for="id1">
									    <input type="checkbox" id="id1" name="">전체
									</label>
									<label class="checkbox-inline" for="id2">
									    <input type="checkbox" id="id2" name="">주거시설
									</label>
									<label class="checkbox-inline" for="id3">
									    <input type="checkbox" id="id3" name="">업무및상업시설
									</label>
									<label class="checkbox-inline" for="id4">
									    <input type="checkbox" id="id4" name="">토지
									</label>
									<label class="checkbox-inline" for="id5">
									    <input type="checkbox" id="id5" name="">공업시설
									</label>
									<label class="checkbox-inline" for="id6">
									    <input type="checkbox" id="id6" name="">동산및권리권
									</label>
								</div>
							</div>
							<div class="p-col-3  p-col-sm-24">
	                       	 <input type="submit" value="검색" class="submit">
	                       </div>
						</div>
                    </div>
				 </fieldset>
			 </form>
	            
	        </div>
	        
	        <div class="title_wrap" style="margin:50px 0 30px">
				<h4 class="sub_tit">[검색 - 5]</h4>
			</div>
            <div class="guide_item" style="margin-top:0;">
	            <!-- 검색 : S -->
	            <form name="bbsNttSearchForm" method="get" action="/">
				 <fieldset>
					 <legend>게시물 검색</legend>
					 <div class="search search-center">
                        <div class="search-date">
                            <div class="inner">
	                            <div class="search--calendar">
									<span>
										<input type="text" class="form-control" value="" title="년도 입력">
									</span>
								</div>
								<span class="sym">년</span>
								<div class="search--calendar">
									<span>
										<input type="text" class="form-control" value="" title="월 입력">
									</span>
								</div>
								<span class="sym">월</span>
								<div class="search--calendar">
									<span>
										<input type="text" class="form-control" value="" title="일 입력">
									</span>
								</div>
								<span class="sym">월</span>
								<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
								<div class="search--btn">
									 <span class="btn--submit"><input class="button" type="submit" value="이동"></span>
								</div>
                            </div>
                        </div>
                        		
                    </div>
				 </fieldset>
			 </form>
			<!-- 검색 : E -->
            </div>
	        
	        
	         
        
            <div id="txt">
            <!-- content 영역입니다. -->
            <div class="title_wrap" style="margin:50px 0 30px">
				<h4 class="sub_tit">[검색]</h4>
			</div>
            <div class="guide_item" style="margin-top:0;">
	            <!-- 검색 : S -->
	            <form name="bbsNttSearchForm" method="get" action="/">
				 <fieldset>
					 <legend>게시물 검색</legend>
					 <div class="search">
                        <div class="search-date">
                            <div class="inner">
	                            
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
                        <div class="search-text">
                            <div class="inner">
                                <div class="search--select">
									 <!-- select추가시 -->
									 <span> 
										 <select name="" title="검색 영역 선택">
										 	<option value="">제목</option>
											<option value="">작성자</option>
											<option value="">내용</option>
										 </select>
									 </span>
									 <!-- select추가시 -->
								 </div>
                                <div class="search--text">
									 <span><input type="text" name="searchKrwd" value="" title="검색어를 입력해주세요" placeholder="검색어를 입력해주세요" class="form-control"></span>
								</div>
								<div class="search--btn">
									 <span class="btn--submit"><input type="submit" value="검색"></span>
								 </div>
                            </div>
                        </div>			
                    </div>
				 </fieldset>
			 </form>
			 <script>
				$(document).ready(function(){
				    
				    $.datetimepicker.setLocale('ko');
				    $("#startDate,#endDate").datetimepicker({
				        timepicker : false,
				        format : 'Y-m-d',
				        scrollMonth : false,
				        scrollInput : false
				    });
				    
				    
				}); 
			</script>
			<!-- 검색 : E -->
            </div>
            
            <div class="title_wrap" style="margin:50px 0 30px">
				<h4 class="sub_tit">[정렬]</h4>
			</div>
            <div class="guide_item" style="margin-top:0;">
	          
	          <div class="program--search--index">
				<div class="program--control">
					<div class="sort">
						<div class="form">
							<select class="design-select gray-select small-select" id="orderType" onchange="goSearct_order()" title="검색조건">
								<option value="">최근 등록일순</option>
								<option value="">조회수</option>
								<option value="">추천수</option>
							</select>
						</div>	
		            </div>
				</div>
			</div>	
			<script src="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/CustomSelect/jquery.design-selectbox.js' />"></script>
			
			<script type="text/javascript">
				 function goSearct_order() {
					var f = document.searchForm;
					var orderType = $('#orderType').val();
				 	f.orderType.value=orderType;
				 	f.submit();
				 }
				$(document).ready(function(e) {
			    	var orderType = $('#orderType').val();
			     	if (orderType != '' && orderType != null) {
		                $('#orderType').val(orderType);
		                 $('#orderType').siblings('.selected').text($('#orderType option:selected').text());
		            }
				});	
			
			</script>  
	            
            </div>
             <div class="title_wrap" style="margin:50px 0 30px">
				<h4 class="sub_tit">[Tab]</h4>
			</div>
			<div class="guide_item" style="margin-top:0;">
				<div class="nav-4th">
					<ul>
						<li class="active"><a href="#">4차탭메뉴ov</a></li>
						<li><a href="#">4차탭메뉴</a></li>
						<li><a href="#">4차탭메뉴</a></li>
						<li><a href="#">4차탭메뉴</a></li>
					</ul>
				</div>
			</div>
            
            <div class="title_wrap" style="margin:50px 0 30px">
				<h4 class="sub_tit">[Paging]</h4>
			</div>
			<div class="guide_item" style="margin-top:0;">
				<!-- Paging : S -->
				<div class="pagination-inner">
					<ul class="pagination">
						<li class="page-item">
							<a class="page-link" aria-label="first" href="#">
								<span aria-hidden="true"><<</span>
								<span class="sr-only">첫번째페이지</span>
							</a>
						</li>
						<li class="page-item">
							<a class="page-link" aria-label="Previous" href="#">
								<span aria-hidden="true"><</span>
								<span class="sr-only">이전페이지</span>
							</a>
						</li>
						<li class="page-item active"><a class="page-link" href="#">1</a></li>
						<li class="page-item"><a class="page-link" href="#">2</a></li>
						<li class="page-item"><a class="page-link" href="#">3</a></li>
						<li class="page-item"><a class="page-link" href="#">4</a></li>
						<li class="page-item"><a class="page-link" href="#">5</a></li>
						<li class="page-item"><a class="page-link" href="#">6</a></li>
						<li class="page-item"><a class="page-link" href="#">7</a></li>
						<li class="page-item"><a class="page-link" href="#">8</a></li>
						<li class="page-item"><a class="page-link" href="#">9</a></li>
						<li class="page-item"><a class="page-link" href="#">10</a></li>
						<li class="page-item">
							<a class="page-link" aria-label="Next" href="#">
								<span aria-hidden="true">></span>
								<span class="sr-only">다음페이지</span>
							</a>
						</li>
						<li class="page-item">
							<a class="page-link" aria-label="last" href="#">
								<span aria-hidden="true">>></span>
								<span class="sr-only">마지막페이지</span>
							</a>
						</li>
					</ul>
                </div>
				<!-- Paging : E -->
            </div>
            
            <div class="title_wrap" style="margin:50px 0 30px">
				<h4 class="sub_tit">[Button]</h4>
			</div>
			<div class="guide_item" style="margin-top:0;">
                <button type="button" class="btn btn-default">등록</button>
                <button type="button" class="btn btn-secondary">삭제</button>
                <button type="button" class="btn btn-primary">수정</button>
                <button type="button" class="btn btn-success">목록</button>
            </div>
            <div class="guide_item" style="margin-top:50px;">
                <a href="javascript:;" class="btn btn-default">확인</a>
                <a href="javascript:;" class="btn btn-secondary">수정</a>
                <a href="javascript:;" class="btn btn-primary">인증하기</a>                           
                <a href="javascript:;" class="btn btn-success">상담신청</a>                           
            </div>
            <div class="title_wrap" style="margin:50px 0 30px">
				<h4 class="sub_tit">[텍스트 블릿]</h4>
			</div>
            <div class="guide_item" style="margin-top:50px;">
                <span class="txt_blt01 bgc01">N</span>
                <span class="txt_blt01 bgc01">N</span>
                <span class="txt_blt02 bgc01">NEW</span>
                <span class="txt_blt02 bgc01">Brand</span>
                <span class="txt_blt03 state01">진행중</span>
                <span class="txt_blt03">종료</span>                      
            </div>
            
            <div class="title_wrap" style="margin:50px 0 30px">
				<h4 class="sub_tit">[modal]</h4>
			</div>
			<div class="guide_item" style="margin-top:0;">
				
				<button type="button" data-toggle="modal" data-ly-btn="modal-pay" class="btn btn-default">결제/연장하기 팝업</button>
				<button type="button" data-toggle="modal" data-ly-btn="modal-pay1" class="btn btn-default">결제 내역 팝업</button>
				<button type="button" data-toggle="modal" data-ly-btn="modal-memo" class="btn btn-default">메모 팝업</button>
				<!-- Modal Sample - body바로 밑에 놔주세요 :: S -->
		        <div class="modal fade" role="dialog" data-ly-type="content" data-ly-target="modal-pay">
		            <div class="modal-dialog">
		                <!-- Modal content-->
		                <div class="modal__body">
		                    <div class="modal__header">
		                       <h4 class="modal__title">결제/연장하기</h4>
		                        <div class="modal__close-button"><button type="button" class="close" data-dismiss="modal">닫기</button></div>
		                    </div>
		                    <div class="modal__content" style="word-break: break-all">
		                        <div class="cont_wrap">
			                        <div class="top_head align_mo_block">
			                        	<p class="txt">현금 영수증  <strong>발급 전화번호</strong>를 입력해주세요</p>
			                        </div>
		                            <div class="flex_box ">
			                            <div class="flex_item">
			                                <input type="text" class="form-control" placeholder="현금 영수증 발급 전화번호 를 입력해주세요" value="" >
			                            </div>
			                        </div>
		                        </div>
		                    </div>
		                    <div class="modal__footer">
			                    <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			                    <button type="button" class="btn btn-primary">확인</button>
			                 </div>
		                </div>
		            </div>
		        </div>
				<!-- Modal Sample - body바로 밑에 놔주세요 :: E -->
				<!-- Modal Sample - body바로 밑에 놔주세요 :: S -->
		        <div class="modal fade" role="dialog" data-ly-type="content" data-ly-target="modal-pay1">
		            <div class="modal-dialog">
		                <!-- Modal content-->
		                <div class="modal__body">
		                    <div class="modal__header">
		                       <h4 class="modal__title">결제 내역</h4>
		                        <div class="modal__close-button"><button type="button" class="close" data-dismiss="modal">닫기</button></div>
		                    </div>
		                    <div class="modal__content" style="word-break: break-all">
		                        <div class="cont_wrap">
			                        <div class="top_head">
		                                <h3 class="h_title_sub">XXX 회원 결제 내역</h3>
		                            </div>
		                            <div class="table_wrap">
		                                <table class="table_info">
											<colgroup>
												<col style="width:10%">
												<col style="width:auto">
												<col style="width:10%">
												<col style="width:10%">
												<col style="width:10%">
												<col style="width:10%">
												<col style="width:10%">
											</colgroup>
		                                    <thead>
		                                        <tr>
		                                            <th>번호</th>
		                                            <th>내역</th>
		                                            <th>기간</th>
		                                            <th>금액</th>
		                                            <th>결제일</th>
		                                            <th>금액</th>
		                                            <th>결제일</th>
		                                        </tr>
		                                    </thead>
		                                    <tbody>
		                                        <tr>
		                                            <td>1</td>
		                                            <td class="subject"><a href="#">전국12개월(법인)</a></td>
		                                            <td>12개월</td>
		                                            <td>6,730,000</td>
		                                            <td>2020.07.31</td>
		                                            <td>2020.08.01</td>
		                                            <td>2021.08.01</td>
		                                        </tr>
		                                        <tr>
		                                            <td>1</td>
		                                            <td class="subject"><a href="#">전국6개월(프리미엄)</a></td>
		                                            <td>12개월</td>
		                                            <td>6,730,000</td>
		                                            <td>2020.07.31</td>
		                                            <td>2020.08.01</td>
		                                            <td>2021.08.01</td>
		                                        </tr>
		                                    </tbody>                            
		                                </table>
		                                
		                            </div>
		                        </div>
		                        <div class="modal__footer">
				                    <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				                    <button type="button" class="btn btn-primary">메모추가</button>
				                 </div>
		                    </div>
		                </div>
		            </div>
		        </div>
				<!-- Modal Sample - body바로 밑에 놔주세요 :: E -->
				<!-- Modal Sample - body바로 밑에 놔주세요 :: S -->
		        <div class="modal fade" role="dialog" data-ly-type="content" data-ly-target="modal-memo">
		            <div class="modal-dialog">
		                <!-- Modal content-->
		                <div class="modal__body">
		                    <div class="modal__header">
		                       <h4 class="modal__title">메모</h4>
		                        <div class="modal__close-button"><button type="button" class="close" data-dismiss="modal">닫기</button></div>
		                    </div>
		                    <div class="modal__content" style="word-break: break-all">
		                        <div class="cont_wrap">
		                            <div class="table_wrap">
		                                <table class="table_info">
			                                <colgroup>
												<col style="width:12%">
												<col style="width:auto">
												<col style="width:15%">
												<col style="width:12%">
											</colgroup>
		                                    <thead>
		                                        <tr>
		                                            <th>번호</th>
		                                            <th>내용</th>
		                                            <th>등록일</th>
		                                            <th></th>
		                                        </tr>
		                                    </thead>
		                                    <tbody>
		                                        <tr>
		                                            <td>1</td>
		                                            <td class="subject"><a href="#">19년 토지보상 특별강좌 수강생</a></td>
		                                            <td>2019.01.13</td>
		                                            <td>
														<button type="button" class="btn btn-secondary btn-sm">삭제</button>
													</td>
		                                        </tr>
		                                        <tr>
		                                            <td>1</td>
		                                            <td class="subject"><a href="#">19년 토지보상 특별강좌 수강생</a></td>
		                                            <td>2019.01.13</td>
		                                            <td>
														<button type="button" class="btn btn-secondary btn-sm">삭제</button>
													</td>
		                                        </tr>
		                                    </tbody>                            
		                                </table>
		                            </div>
		                        </div>
		                    </div>
		                    
		                    <div class="modal__footer">
			                    <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			                    <button type="button" class="btn btn-primary">메모추가</button>
			                 </div>
		                </div>
		            </div>
		        </div>
				<!-- Modal Sample - body바로 밑에 놔주세요 :: E -->
				
			</div>
            <div class="title_wrap" style="margin:50px 0 30px">
				<h4 class="sub_tit">[Dialog]</h4>
			</div>
			<div class="guide_item" style="margin-top:0;">
				<button type="button" data-toggle="modal" class="btn btn-default btn-create">등록</button>
				<button type="button" data-toggle="modal" class="btn btn-secondary btn-delete">삭제</button>
				<button type="button" data-toggle="modal" class="btn btn-primary btn-update">수정</button>
				<button type="button" data-toggle="modal" class="btn btn-success">수정</button>
				<button type="button" data-toggle="modal" class="btn btn-success btn-updating">변경하기</button>
				<!-- Dialog 알림참 스크립트 -->
				<script>
					$(function () { 
					    $(".btn-create").on('click', function(){
					        Common.Dialog.confirm({
						        title: '등록',
					            content: '현재 게시글을 등록하시겠습니까?'
					            ,ok: function(){
					                console.log('확인 클릭');
					            }
						        ,cancel : function(){
						        	console.log("캔슬버튼 클릭 후 로그");
						        }
					        });    
					    });
					    $(".btn-delete").on('click', function(){
					        Common.Dialog.confirm({
						        title: '삭제',
					            content: '현재 게시글을 삭제하시겠습니까?'
					            ,ok: function(){
					                console.log('확인 클릭');
					            }
						        ,cancel : function(){
						        	console.log("캔슬버튼 클릭 후 로그");
						        }
					        });    
					    });
					    $(".btn-update").on('click', function(){
					        Common.Dialog.confirm({
						        title: '수정',
					            content: '현재 게시글을 수정하시겠습니까?'
					            ,ok: function(){
					                console.log('확인 클릭');
					            }
						        ,cancel : function(){
						        	console.log("캔슬버튼 클릭 후 로그");
						        }
					        });    
					    });
					    $(".btn-updating").on('click', function(){
			                 Common.Dialog.alert({
			                    title: '변경하기'
			                    ,content: '등록 또는 삭제 할 수 있는 권한이 없습니다'
		                    	,ok: function(){
					                console.log('확인 클릭');
					            }
			                });    
			            });      
					});
				</script>	
				<!-- Dialog 알림참 스크립트 -->
			</div>
            <div class="title_wrap" style="margin:50px 0 30px">
				<h4 class="sub_tit">[Table]</h4>
			</div>
			<div class="guide_item" style="margin-top:0;">
				<!-- Table : S -->
				<div class="table-responsive mt_20">
					<table class="table table-bordered text-center">
						<caption>테이블 안내 – 구분, 부서/직위, 성명, 연락처, 홈페이지 정보 제공</caption>
						<colgroup>
							<col style="width:25%">
							<col style="width:30%">
							<col style="width:10%">
							<col style="width:15%">
							<col style="width:20%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">구분</th>
								<th scope="col">부서/직위</th>
								<th scope="col">성명</th>
								<th scope="col">연락처</th>
								<th scope="col">홈페이지</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th scope="row">공공데이터제공책임관</th>
								<td>홍보전산담당전산정보팀장자치분권과</td>
								<td>홍길동</td>
								<td>041-12-1234</td>
								<td><a href="#" class="btn btn-default btn-outline btn-icon">바로가기<i class="ir ir-bbs ir-arrow" aria-hidden="true"></i></a></td>
							</tr>
							<tr>
								<th scope="row">공공데이터제공실무담당자</th>
								<td>홍보전산담당전산정보팀장자치분권과</td>
								<td>홍길동</td>
								<td>041-12-1234</td>
								<td><a href="#" class="btn btn-default btn-outline btn-icon">바로가기<i class="ir ir-bbs ir-arrow" aria-hidden="true"></i></a></td>
							</tr>
							<tr>
								<th scope="row">공공데이터제공실무담당자</th>
								<td class="text-left">
									<ul class="list-1st">
										<li>상징물을 활용하여 물품 등을 제작하거나 행사 등에 이용하고자 하는 사람은 시장의 승인을 얻어야 합니다.</li>
										<li>사용승인을 받지 아니하고 상징물 사용시에는 관련법령에 따라 조치를 받게 됩니다.</li>
										<li>사용승인을 받지 아니하고 상징물 사용시에는 관련법령에 따라 조치를 받게 됩니다.
										</li>
									</ul>
								</td>
								<td>홍길동</td>
								<td>041-12-1234</td>
								<td></td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<th scope="row">합계</th>
								<td colspan="4" class="text-right"> 0000</td>
							</tr>
						</tfoot>
					</table>
				</div>
							
				<!-- Table : E -->
            </div>
            <div class="title_wrap" style="margin:50px 0 30px">
				<h4 class="sub_tit">[List]</h4>
			</div>
			<div class="guide_item" style="margin-top:0;">
				<!-- List : S -->
				<div class="table-list">
					<table>
						<colgroup>
							<col style="width:15%">
							<col style="width:auto">
							<col style="width:10%">
							<col style="width:10%">
							<col style="width:12%">
						</colgroup>
						</thead>
						<tbody>
							<tr>
								<td class="atchFileId"><span class="td__num">10303</span></td>
								<td class="subject"><a href="#view">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<span class="ir bbs-new">새글</span></a></td>
								<td><span class="td__date">전시</span></td>
								<td><span class="td__date">삭제</span></td>
								<td class="regDate"> <span class="td__date">2021-03-15</span></td>
							</tr>
							<tr class="notr"><td class="none" colspan="3"></td></tr>
							<tr>
								<td class="atchFileId"><span class="td__num">10303</span></td>
								<td class="subject"><a href="#view">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<span class="ir bbs-new">새글</span></a></td>
								<td><span class="td__date">전시</span></td>
								<td><span class="td__date">삭제</span></td>
								<td class="regDate"> <span class="td__date">2021-03-15</span></td>
							</tr>
							<tr class="notr"><td class="none" colspan="3"></td></tr>
							<tr>
								<td class="atchFileId"><span class="td__num">10303</span></td>
								<td class="subject"><a href="#view">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<span class="ir bbs-new">새글</span></a></td>
								<td><span class="td__date">전시</span></td>
								<td><span class="td__date">삭제</span></td>
								<td class="regDate"> <span class="td__date">2021-03-15</span></td>
							</tr>
							<tr class="notr"><td class="none" colspan="3"></td></tr>
							<tr>
								<td class="atchFileId"><span class="td__num">10303</span></td>
								<td class="subject"><a href="#view">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<span class="ir bbs-new">새글</span></a></td>
								<td><span class="td__date">전시</span></td>
								<td><span class="td__date">삭제</span></td>
								<td class="regDate"> <span class="td__date">2021-03-15</span></td>
							</tr>
							<tr class="notr"><td class="none" colspan="3"></td></tr>
							<tr>
								<td class="atchFileId"><span class="td__num">10303</span></td>
								<td class="subject"><a href="#view">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<span class="ir bbs-new">새글</span></a></td>
								<td><span class="td__date">전시</span></td>
								<td><span class="td__date">삭제</span></td>
								<td class="regDate"> <span class="td__date">2021-03-15</span></td>
							</tr>
							<tr class="notr"><td class="none" colspan="3"></td></tr>
							<tr>
								<td class="atchFileId"><span class="td__num">10303</span></td>
								<td class="subject"><a href="#view">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<span class="ir bbs-new">새글</span></a></td>
								<td><span class="td__date">전시</span></td>
								<td><span class="td__date">삭제</span></td>
								<td class="regDate"> <span class="td__date">2021-03-15</span></td>
							</tr>
							<tr class="notr"><td class="none" colspan="3"></td></tr>
							<tr>
								<td class="atchFileId"><span class="td__num">10303</span></td>
								<td class="subject"><a href="#view">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<span class="ir bbs-new">새글</span></a></td>
								<td><span class="td__date">전시</span></td>
								<td><span class="td__date">삭제</span></td>
								<td class="regDate"> <span class="td__date">2021-03-15</span></td>
							</tr>
							<tr class="notr"><td class="none" colspan="3"></td></tr>
							<tr>
								<td class="atchFileId"><span class="td__num">10303</span></td>
								<td class="subject"><a href="#view">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<span class="ir bbs-new">새글</span></a></td>
								<td><span class="td__date">전시</span></td>
								<td><span class="td__date">삭제</span></td>
								<td class="regDate"> <span class="td__date">2021-03-15</span></td>
							</tr>
							<tr class="notr"><td class="none" colspan="3"></td></tr>
							<tr>
								<td class="atchFileId"><span class="td__num">10303</span></td>
								<td class="subject"><a href="#view">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<span class="ir bbs-new">새글</span></a></td>
								<td><span class="td__date">전시</span></td>
								<td><span class="td__date">삭제</span></td>
								<td class="regDate"> <span class="td__date">2021-03-15</span></td>
							</tr>
							<tr class="notr"><td class="none" colspan="3"></td></tr>
							<tr>
								<td class="atchFileId"><span class="td__num">10303</span></td>
								<td class="subject"><a href="#view">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<span class="ir bbs-new">새글</span></a></td>
								<td><span class="td__date">전시</span></td>
								<td><span class="td__date">삭제</span></td>
								<td class="regDate"> <span class="td__date">2021-03-15</span></td>
							</tr>
							<tr class="notr"><td class="none" colspan="3"></td></tr>
						</tbody>
					</table>
					<!--<ul class="list_type--table">
	                    <li class="list_type--row">
	                    	<div class="list_type--td">
	                           <span class="td__num">10303</span>
	                        </div>
	                        <div class="list_type--th">
	                            <a href="#" class="list_link">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)</a>
	                        </div>
	                        <div class="list_type--td">
	                            <span class="td__date">2021-03-15</span>
	                        </div>
	                    </li>
	                    <li class="list_type--row">
	                    	<div class="list_type--td">
	                           <span class="td__num">10303</span>
	                        </div>
	                        <div class="list_type--th">
	                            <a href="#" class="list_link">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)</a>
	                        </div>
	                        <div class="list_type--td">
	                            <span class="td__date">2021-03-15</span>
	                        </div>
	                    </li>
	                    <li class="list_type--row">
	                    	<div class="list_type--td">
	                           <span class="td__num">10303</span>
	                        </div>
	                        <div class="list_type--th">
	                            <a href="#" class="list_link">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)</a>
	                        </div>
	                        <div class="list_type--td">
	                            <span class="td__date">2021-03-15</span>
	                        </div>
	                    </li>
	                    <li class="list_type--row">
	                    	<div class="list_type--td">
	                           <span class="td__num">10303</span>
	                        </div>
	                        <div class="list_type--th">
	                            <a href="#" class="list_link">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)</a>
	                        </div>
	                        <div class="list_type--td">
	                            <span class="td__date">2021-03-15</span>
	                        </div>
	                    </li>
	                    <li class="list_type--row">
	                    	<div class="list_type--td">
	                           <span class="td__num">10303</span>
	                        </div>
	                        <div class="list_type--th">
	                            <a href="#" class="list_link">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)</a>
	                        </div>
	                        <div class="list_type--td">
	                            <span class="td__date">2021-03-15</span>
	                        </div>
	                    </li>
	                    <li class="list_type--row">
	                    	<div class="list_type--td">
	                           <span class="td__num">10303</span>
	                        </div>
	                        <div class="list_type--th">
	                            <a href="#" class="list_link">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)</a>
	                        </div>
	                        <div class="list_type--td">
	                            <span class="td__date">2021-03-15</span>
	                        </div>
	                    </li>
	                    <li class="list_type--row">
	                    	<div class="list_type--td">
	                           <span class="td__num">10303</span>
	                        </div>
	                        <div class="list_type--th">
	                            <a href="#" class="list_link">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)</a>
	                        </div>
	                        <div class="list_type--td">
	                            <span class="td__date">2021-03-15</span>
	                        </div>
	                    </li>
	                    <li class="list_type--row">
	                    	<div class="list_type--td">
	                           <span class="td__num">10303</span>
	                        </div>
	                        <div class="list_type--th">
	                            <a href="#" class="list_link">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)</a>
	                        </div>
	                        <div class="list_type--td">
	                            <span class="td__date">2021-03-15</span>
	                        </div>
	                    </li>
	                    <li class="list_type--row">
	                    	<div class="list_type--td">
	                           <span class="td__num">10303</span>
	                        </div>
	                        <div class="list_type--th">
	                            <a href="#" class="list_link">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)</a>
	                        </div>
	                        <div class="list_type--td">
	                            <span class="td__date">2021-03-15</span>
	                        </div>
	                    </li>
	                    <li class="list_type--row">
	                    	<div class="list_type--td">
	                           <span class="td__num">10303</span>
	                        </div>
	                        <div class="list_type--th">
	                            <a href="#" class="list_link">고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)</a>
	                        </div>
	                        <div class="list_type--td">
	                            <span class="td__date">2021-03-15</span>
	                        </div>
	                    </li>
	                </ul>-->
				</div>
				<!-- List : E -->
				<!-- Paging : S -->
				<div class="pagination-inner">
					<ul class="pagination">
						<li class="page-item">
							<a class="page-link" aria-label="first" href="#">
								<span aria-hidden="true"><<</span>
								<span class="sr-only">첫번째페이지</span>
							</a>
						</li>
						<li class="page-item">
							<a class="page-link" aria-label="Previous" href="#">
								<span aria-hidden="true"><</span>
								<span class="sr-only">이전페이지</span>
							</a>
						</li>
						<li class="page-item active"><a class="page-link" href="#">1</a></li>
						<li class="page-item"><a class="page-link" href="#">2</a></li>
						<li class="page-item"><a class="page-link" href="#">3</a></li>
						<li class="page-item"><a class="page-link" href="#">4</a></li>
						<li class="page-item"><a class="page-link" href="#">5</a></li>
						<li class="page-item"><a class="page-link" href="#">6</a></li>
						<li class="page-item"><a class="page-link" href="#">7</a></li>
						<li class="page-item"><a class="page-link" href="#">8</a></li>
						<li class="page-item"><a class="page-link" href="#">9</a></li>
						<li class="page-item"><a class="page-link" href="#">10</a></li>
						<li class="page-item">
							<a class="page-link" aria-label="Next" href="#">
								<span aria-hidden="true">></span>
								<span class="sr-only">다음페이지</span>
							</a>
						</li>
						<li class="page-item">
							<a class="page-link" aria-label="last" href="#">
								<span aria-hidden="true">>></span>
								<span class="sr-only">마지막페이지</span>
							</a>
						</li>
					</ul>
                </div>
				<!-- Paging : E -->
            </div>
            
            <div class="title_wrap" style="margin:50px 0 30px">
				<h4 class="sub_tit">[view]</h4>
			</div>
			<div class="guide_item" style="margin-top:0;">
				<!-- view : S -->
			<div class="board_view_in">
                    <!-- board -->
                    <div class="board">
                        <div class="board_view">
                            <div class="view_header">
	                            <span class="view_tit_number">8880</span>
                                <div class="view_tit">
                                    <p class="tit_txt">
                                       고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)
                                    </p>
                                </div>
                                <span class="view_tit_aside">2020.11.24</span>
                                <div class="view_data">
	                               <span class="view-id">na9*****</span>  
	                               <span class="view-hit">34</span>     
                                </div>
                            </div>
                            
                            <div class="view_cont_box">
                                <div class="view_cont">
                                <!-- 게시글-->
								고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<br>
								고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<br><br>
								
								고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<br>
								고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<br><br>
								고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<br><br>
								고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<br><br>
								고등 취락지구 정비공사(소로3-678호선) 보상계획 열람 공고(2021.03.09)<br><br>
								
								* 단, 주문 건 당 30만원 초과 주문 건 발생 시 보증보험 가입 필수 
                                <!--// 게시글-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- board -->

                    <div class="board_btm">
	                    <div class="btns_area fl_l mo_block">
                            <a href="#" class="btn btn-default">목록</a>
                        </div>
                        <div class="btns_area fl_r mo_block">
                            <a href="#" class="btn btn-default">등록</a>
                        </div>
                    </div>
                </div>
				<!-- view : E -->
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
