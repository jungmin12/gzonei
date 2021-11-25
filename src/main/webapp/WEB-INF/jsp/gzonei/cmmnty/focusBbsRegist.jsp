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
<script type="text/javascript"
	src="<c:url value='/js/gzonei/jquery-3.5.1.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/html/egovframework/com/cmm/utl/ckeditor/ckeditor.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/html/egovframework/com/cmm/utl/ckeditor/adapters/jquery.js'/>"></script>
<head>
<%@ include file="/WEB-INF/jsp/gzonei/layout/header.jsp" %>
</head>
<body>
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
		document.location.href="<c:url value='/cmmnty/focusBbsList.do'/>";
	}
	function validate(){
		if ($('#nttSj').val() == '') {
			Common.Dialog.alert({
	            content: '제목을 입력해주세요'
	            ,ok : function(){
	            	$('#nttSj').focus();
	            }
	        });
			return false;
		}
		if ($('#frstRegistPnttm').val() == '') {
			Common.Dialog.alert({
	            content: '작성일자를 선택해주세요'
	            ,ok : function(){
	            	$('#frstRegistPnttm').focus();
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
            	document.insertForm.action="<c:url value='/cmmnty/focusBbsRgst.do'/>";
    			document.insertForm.submit();
            }
	        ,cancel : function(){
	        	return false;
	        }
        });   
		}
	}
	$(document).ready(function(){
		 $.datetimepicker.setLocale('ko');
		    $("#frstRegistPnttm").datetimepicker({
		        timepicker : false,
		        format : 'Y-m-d',
		        scrollMonth : false,
		        scrollInput : false
		    	
		    });
		});
</script>
<div id="body_layout">	

    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
            <div id="location" class="title_wrap">
                <h2 class="page__title">지존포커스</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a  href="<c:url value='/cmmnty/noticeBbsList.do'/>">커뮤니티</a></li>
                        <li class="n3"><a href="<c:url value='/cmmnty/focusBbsList.do'/>" class="navi_ov">지존포커스</a></li>
                    </ul>                            
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">
			<div class="board_view_in">
                    <form name="insertForm" method="post" enctype="multipart/form-data">
                    <div class="form-horizontal bucket-form">

						<div class="form-group">
						    <div class="col-sm-2 control-label col-lg-2"><div class="label">제목 <span class="pilsu">필수</span></div></div>
						    <div class="col-sm-9">
						    	<input type="text" id="nttSj" name="nttSj" title="이름 입력" class="form-control" value="">
							</div>
						</div> 
						<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2"><div class="label">작성 일자 <span class="pilsu">필수</span></div></div>
						    <div class="col-sm-2 search--calendar">
							    <div>
							    	<input type="text" name="frstRegistPnttm" id="frstRegistPnttm" placeholder="작성일자"  value="<%=now%>"  class="form-control"  autocomplete="off" onkeyup="this.value = date_mask(this.value)" maxlength="10"/>
							    	<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
								</div>
							</div>
						</div> 
						<!-- 							------------관리자 권한 넣기전 조치======================= -->
						<c:if test="${sessionScope.authVO.bbs004001.infoDspyAt == 'Y'}"> 
						<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2"><div class="label">공지여부 <span class="pilsu">필수</span></div></div>
						    <div class="col-sm-2">
						    	<div class="label-text"><input type="checkbox"  value="Y" name="noticeAt">공지</div>
							</div>
							<div class="col-sm-2 control-label col-lg-2"><div class="label">전시여부 <span class="pilsu">필수</span></div></div>
						    <div class="col-sm-2">
						    	 <input class="radio-input" type="radio" value="Y"  id='dsply' name='dspyAt' /><label class="radio-inline" for="dsply">전시</label>
                              <input class="radio-input" type="radio" value="N" id='noDsply' name='dspyAt' checked/><label class="radio-inline" for="noDsply">미전시</label>

							</div>
						</div> 
						</c:if>
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
<!-- 											    	<option value="">---권한 설정---</option> -->
											    	<option value="CM00209998">무료</option>
<!-- 											    	<option value="CM00200005">실버 (이코노미)</option> -->
<!-- 											    	<option value="CM00200006">실버 (스페셜)</option> -->
<!-- 											    	<option value="CM00200007">골드 (이코노미)</option> -->
<!-- 											    	<option value="CM00200008">골드 (비즈니스)</option> -->
<!-- 											    	<option value="CM00200009">골드 (스페셜)</option> -->
<!-- 											    	<option value="CM00200010">프리미엄 (이코노미)</option> -->
<!-- 											    	<option value="CM00200011">프리미엄 (스페셜)</option> -->
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
									<input type="hidden" name="bbsId"  value="BBSMSTR_000000000010"/>
									<input type="hidden" name="answerAt"  value="Y"/>
									<input type="hidden" name="dspyAt"  value="Y"/>
									<input type="hidden" name="useAt"  value="Y"/>
									<input type="hidden" name="ntcrId"  value="${sessionScope.loginVO.id}"/>
									<input type="hidden" name="ntcrNm"  value="${sessionScope.loginVO.name}"/>  <!--추후 회원 아이디 추가 -->
									<input type="hidden" name="frstRegisterId"  value="${sessionScope.loginVO.id}"/><!--추후 회원 아이디 추가 -->
									<input type="hidden" name="password"  value="tester"/>
									<input type="hidden" name="bolgId"  value="N"/>
								
									<input type="hidden" name="noticeAt"  value="N"/> <!-- 공지 여부 -->
									<input type="hidden" name="freeAt"  value="Y"/>
						
                    </div>
                    <div class="board_btm">
                        <div class="btns_area fl_r mo_block">
		                   <a onclick="insert();" class="btn btn-default btn-create">등록</a>
		                   <a onclick="cancle();" class="btn btn-default">취소</a>
                        </div>
                    </div>
                    </form>
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
