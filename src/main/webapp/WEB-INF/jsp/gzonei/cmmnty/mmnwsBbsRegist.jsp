<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="ckeditor" uri="http://ckeditor.com"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang='ko'>
<script type="text/javascript" src="<c:url value='/js/gzonei/jquery-3.5.1.js' />"></script>
<head>
<%@ include file="/WEB-INF/jsp/gzonei/layout/header.jsp" %>
</head>
<body>
<script type="text/javascript" src="<c:url value='/html/egovframework/com/cmm/utl/ckeditor/ckeditor.js'/>"></script>
<script type="text/javascript" src="<c:url value='/html/egovframework/com/cmm/utl/ckeditor/adapters/jquery.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/gzonei/devlopInfo/twbsPagination.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/gzonei/invt/invtDevlop.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/gzonei/devlopInfo/devlopInfo.js'/>"></script>

<%@ include file="/WEB-INF/jsp/gzonei/layout/top.jsp" %>
<%
	Date nowTime = new Date();
	SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
	String now = simpleDate.format(nowTime);
%>
<!-- 구현부 : S -->
<script>
	function date_mask(objValue) {
		 var v = objValue.replace("--", "-");
	
		    if (v.match(/^\d{4}$/) !== null) {
		        v = v + '-';
		    } else if (v.match(/^\d{4}\-\d{2}$/) !== null) {
		        v = v + '-';
		    }
		 
		    return v;
	}
	function cancle() {
		document.location.href="<c:url value='/cmmnty/mmnwsBbsList.do'/>";
	}
	function validate(){

		if ($('#nttSj').val() == '') {
			Common.Dialog.alert({
	            content: '제목을 입력해주세요.'
	            ,ok : function(){
					$('#nttSj').focus();
	            }
	        });
	     	return false;
		}
// 		if ($('#lc').val() == '') {
// 			Common.Dialog.alert({
// 	            content: '지역을 선택해주세요.'
// 	            ,ok : function(){
// 	            	$('#lc').focus();
// 	            }
// 	        });
// 			return false;
// 		}	
// // 		if ($('#nsprcCode').val() == '') {
// 			Common.Dialog.alert({
// 	            content: '신문사를 선택해주세요.'
// 	            ,ok : function(){
// 	            	$('#nsprcCode').focus();
// 	            }
// 	        });
// 			return false;
// 		}	
		if ($('#articlDe').val() == '') {
			Common.Dialog.alert({
	            content: '기사일자를 선택해주세요.'
	            ,ok : function(){
	            	$('#articlDe').focus();
	            }
	        });
			return false;
		}	
		if ($('#frstRegistPnttm').val() == '') {
			Common.Dialog.alert({
	            content: '작성일자를 선택해주세요.'
	            ,ok : function(){
	            	$('#frstRegistPnttm').focus();
	            }
	        });
			return false;
		}	
		return true;
	}
	function devinfoPreCheck(){
		if ($('#dwknm').val() == '') {
			Common.Dialog.alert({
	            content: '개발 사업을 선택해주세요.'
	            ,ok : function(){
	            	$('#dwknm').focus();
	            }
	        });
			return false;
		}	
		return true;
	}
	function insert() {
		if(validate()){	
	        Common.Dialog.confirm({
		        title: '등록',
	            content: '현재 게시글을 등록하시겠습니까?'
	            ,ok: function(){
	    			document.insertForm.action="<c:url value='/cmmnty/mmnwsBbsRgst.do'/>";
	    			document.insertForm.submit();
	            }
		        ,cancel : function(){
		        	return false;;
		        }
	        });    
		}
	}
	
	$(document).ready(function(){
// 	$("#selboxDirect").hide();
// 	$("#nsprcCode").change(function() {
// 			if($("#nsprcCode").val() == "CM00090001") {
// 				$("#selboxDirect").show();
// 			}  else {
// 				$("#selboxDirect").hide();
// 			}
// 	}) 
		$('#devInfoSchBtn').on('click',function(e){
			nwsDevlopListSearch(2);
			$('#nwsDevlopInsertModal').css("display","block");
		});
	
	 $.datetimepicker.setLocale('ko');
	    $("#articlDe").datetimepicker({
	        timepicker : false,
	        format : 'Y-m-d',
	        scrollMonth : false,
	        scrollInput : false
	    	
	    });
	    $("#frstRegistPnttm").datetimepicker({
	        timepicker : false,
	        format : 'Y-m-d',
	        scrollMonth : false,
	        scrollInput : false
	    	
	    });
	    $('#devInfoPreSchBtn').on('click',function(e){
	    	if(devinfoPreCheck()){
	    	var devlopInfoSn = document.insertForm.devlopInfoSn.value;
	    	var newWindow = window.open("about:blank");   
	    	newWindow.location.href = getContextPath()+'/map.do?devlopInfoSn='+ devlopInfoSn;
	    	}
		});
	});
	function addComma(num) {
		var result = '';
		if(num!=null){
			var regexp = /\B(?=(\d{3})+(?!\d))/g;
			result = num.toString().replace(regexp, ',')
		}
		return result;
	}	
</script>
<div id="body_layout">	

    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
            <div id="location" class="title_wrap">
                <h2 class="page__title">토지보상 뉴스</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a  href="<c:url value='/cmmnty/noticeBbsList.do'/>">커뮤니티</a></li>
                        <li class="n3"><a href="<c:url value='/cmmnty/mmnwsBbsList.do'/>" class="navi_ov">토지보상 뉴스</a></li>
                    </ul>                            
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">
			<div class="board_view_in">
                    <form name="insertForm" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="devlopInfoSn"/>
                    <div class="form-horizontal bucket-form">

						<div class="form-group">
						    <div class="col-sm-2 control-label col-lg-2"><div class="label">제목 <span class="pilsu">필수</span></div></div>
						    <div class="col-sm-9">
						    	<input type="text" id="nttSj" name="nttSj" title="이름 입력" class="form-control" value="">
							</div>
						</div> 
						
						<div class="form-group">
<!-- 						    <div class="col-sm-2 control-label col-lg-2"><div class="label">개발 지역 <span class="pilsu">필수</span></div></div> -->
<!-- 								<div class="col-sm-2"> -->
<!-- 									<select name="lc" id="lc"  class="form-control"> -->
<!-- 										<option value="">-선택-</option> -->
<!-- 										<option value="서울">서울</option> -->
<!-- 										<option value="경기도">경기도</option> -->
<!-- 										<option value="강원도">강원도</option> -->
<!-- 										<option value="충청북도">충청북도</option> -->
<!-- 										<option value="충청남도">충청남도</option> -->
<!-- 										<option value="경상북도">경상북도</option> -->
<!-- 										<option value="경상남도">경상남도</option> -->
<!-- 										<option value="전라도">전라도</option> -->
<!-- 										<option value="제주도">제주도</option> -->
<!-- 									</select> -->
<!-- 								</div> -->
<!-- 							<div class="col-sm-2 control-label col-lg-2"><div class="label">신문사 <span class="pilsu">필수</span></div></div> -->
<!-- 						    <div class="col-sm-1"> -->
<!-- 						    	<select name="nsprcCode" id="nsprcCode" class="form-control">           -->
<!-- 						    		<option value="">-선택-</option> -->
<!-- 						    		<option value="CM00090002">디지털조선</option> -->
<!-- 						    		<option value="CM00090003">재경일보</option> -->
<!-- 						    		<option value="CM00090004">한겨레 신문</option> -->
<!-- 						    		<option value="CM00090005">조선일보</option> -->
<!-- 						    		<option value="CM00090006">중앙일보</option> -->
<!-- 						    		<option value="CM00090007">경향신문</option> -->
<!-- 						    		<option value="CM00090008">동아일보</option> -->
<!-- 						    		<option value="CM00090009">SBS TV</option> -->
<!-- 						    		<option value="CM00090010">KBS TV</option> -->
<!-- 						    		<option value="CM00090011">YBN TV</option> -->
<!-- 									<option value="CM00090012">MBC TV</option> -->
<!-- 						    		<option value="CM00090001">직접입력</option> -->
<!-- 						    	</select> -->
<!-- 							</div> -->
<!-- 							<div class="col-sm-2"> -->
<!-- 						    	<input type="text" id="selboxDirect" name="selboxDirect" class="form-control"/> -->
						    	<input type="hidden" id="nsprcCode" name="nsprcCode" value="CM00090001"/>
<!-- 						    </div> -->
							<div class="col-sm-2 control-label col-lg-2"><div class="label">기사 일자 <span class="pilsu">필수</span></div></div>
						    <div class="col-sm-2 search--calendar">
							    <div>
							    	<input type="text" name="articlDe" id="articlDe" placeholder="기사일자" class="form-control" autocomplete="off" value="<%=now%>" onkeyup="this.value = date_mask(this.value)" maxlength="10"/>
							    	<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
								</div>
							</div>
						 </div> 
<!-- 						    <div class="form-group"> -->
<!-- 							<div class="col-sm-2 control-label col-lg-2"><div class="label">작성 일자 <span class="pilsu">필수</span></div></div> -->
<!-- 						    <div class="col-sm-2 search--calendar"> -->
<!-- 							    <div> -->
<!-- 							    	<input type="text" name="frstRegistPnttm" id="frstRegistPnttm" placeholder="작성일자" class="form-control" autocomplete="off"/> -->
<!-- 							    	<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 							</div> -->
							
						<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2"><div class="label">개발 사업</div></div>
							<div class="col-sm-1">										
<!-- 										<button type="button" data-ly-btn="modal-search" class="btn-sm btn-primary" id="devInfoSchModalBtn">개발사업 검색</button>  -->
										<button type="button" data-ly-btn="modal-search" class="btn-sm btn-primary" id="devInfoSchBtn"  style="border-radius: 30px;">개발사업 검색</button> 
							</div>		
<!-- 							<div class="col-sm-2 control-label col-lg-2"><div class="label">개발 사업명</div></div>	 -->
							<div class="col-sm-4">
											<input id="dwknm" name="dwkNm"  type="text" readonly="readonly" class="form-control" ></input>
											<input type="hidden" name="blogId" id="blogid" />
							</div>
							<div class="col-sm-1">										
<!-- 										<button type="button" data-ly-btn="modal-search" class="btn-sm btn-primary" id="devInfoSchModalBtn">개발사업 검색</button>  -->
										<button type="button" class="btn-sm btn-primary" id="devInfoPreSchBtn"  style="border-radius: 30px;">미리보기</button> 
							</div>	
																					<!-- 							------------관리자 권한 넣기전 조치======================= -->
						<c:if test="${sessionScope.authVO.bbs005001.infoDspyAt == 'Y'}">
						
							<div class="col-sm-2 control-label col-lg-2"><div class="label">전시여부 </div></div>
						    <div class="col-sm-2">
						    	 <input class="radio-input" type="radio" value="Y"  id='dsply' name='dspyAt'  checked/><label class="radio-inline" for="dsply">전시</label>
                             	 <input class="radio-input" type="radio" value="N" id='noDsply' name='dspyAt' /><label class="radio-inline" for="noDsply">미전시</label>
							</div>
						</c:if>
						</div>
						<div class="form-group">
						    <div class="col-sm-12">
								<!-- CKEditor Sample <START> -->
								<textarea id="nttCn" name='nttCn' title="타이틀" class="form-control" rows="20"></textarea>
								<script type="text/javascript" src="<c:url value='/js/gzonei/ckeditor_custom_config.js'/>"></script>
								<!-- CKEditor Sample <END>-->
							</div>
						</div> 
						<div class="form-group">
						    <div class="col-sm-2 control-label col-lg-2"><label for="select">첨부파일 <span class="pilsu">필수</span></label></div>
						    <div class="col-sm-7">
						    	<div class="form-upload">
						    	 	<div class="file-form-group">
						    	 		<div class="form-group__upload">
						    	 			<input type="text" readonly="readonly" class="form-control disabled" name="atchFileNm">
						    	 			<input type="file" name="atchFile_1" id="atchFile_1" class="form-upload__file--hidden">
						    	 		</div>
						    	 		<div class="form-input__addon">
						                    <label for="atchFile_1" class="btn btn-sm btn-secondary" data-button="upload">파일첨부하기</label>
						                    <button type="button" class="btn btn-sm btn-primary file_del_btn">파일 삭제</button>
						               </div>
						    	 	</div>
						    	 	<div class="form-group file_author" style="display:none;">
									    <div class="col-sm-2 control-label col-lg-2"><label for="select">첨부파일 권한<span class="pilsu">필수</span></label></div>
									    <div class="col-sm-4">
										    <select name="fileAuthor" class="form-control">
<!-- 										    	<option value="">---권한 설정---</option> -->
										    	<option value="CM00209998">무료</option>
<!-- 										   		<option value="CM00200005">실버 (이코노미)</option> -->
<!-- 										    	<option value="CM00200006">실버 (스페셜)</option> -->
<!-- 										    	<option value="CM00200007">골드 (이코노미)</option> -->
<!-- 										    	<option value="CM00200008">골드 (비즈니스)</option> -->
<!-- 										    	<option value="CM00200009">골드 (스페셜)</option> -->
<!-- 										    	<option value="CM00200010">프리미엄 (이코노미)</option> -->
<!-- 										    	<option value="CM00200011">프리미엄 (스페셜)</option> -->
										    </select>
								    	</div>
									</div>
						    	 	<div class="file-button">
							    	 	<button type="button" class="addFile">추가</button>
										<button type="button" class="delFile">삭제</button>
							    	</div>
						    	</div>
							</div>
						</div>
									<input type="hidden" name="nttId"  value="0"/>
									<input type="hidden" name="bbsId"  value="BBSMSTR_000000000008"/>
									<input type="hidden" name="answerAt"  value="Y"/>
<!-- 									<input type="hidden" name="useAt"  value="Y"/> -->
									<input type="hidden" name="ntcrId"  value="${sessionScope.loginVO.id}"/>
									<input type="hidden" name="ntcrNm"  value="${sessionScope.loginVO.name}"/>  <!--추후 회원 아이디 추가 -->
									<input type="hidden" name="frstRegisterId"  value="${sessionScope.loginVO.id}"/><!--추후 회원 아이디 추가 -->
									<input type="hidden" name="password"  value="tester"/>
<!-- 									<input type="hidden" name="delAt"  value="N"/> -->
									<input type="hidden" name="noticeAt"  value="N"/> <!-- 공지 여부 -->
									<input type="hidden" name="freeAt"  value="Y"/>

						
						</div>
	                  </form>
                    </div>
                  
                    
                    <div class="board_btm">
                        <div class="btns_area fl_r mo_block">
		                            <a onclick="insert();" class="btn btn-default btn-create">등록</a>
		                            <a onclick="cancle();" class="btn btn-default">취소</a>
                        </div>
                    </div>
                    
                </div>
				<!-- view : E -->
			
			
            <!-- content 영역입니다. -->	
            </div>
        </div>
    
    <!-- layout -->
<%@ include file="/WEB-INF/jsp/gzonei/cmmnty/nwsDevlopInsertModal.jsp" %>
</div>

<!-- 구현부 : E -->
<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>
</body>
</html>
