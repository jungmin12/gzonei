<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="ckeditor" uri="http://ckeditor.com"%>
<!DOCTYPE html>
<html lang="ko">
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<script type="text/javascript" src="<c:url value='/js/gzonei/jquery-3.5.1.js' />"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<%@ include file="/WEB-INF/jsp/gzonei/layout/header.jsp" %>

<!-- 행정안전부 공통서비스 테스트 사이트 -->
<script type="text/javascript" src="<c:url value='/html/egovframework/com/cmm/utl/ckeditor/ckeditor.js'/>"></script>
<script type="text/javascript" src="<c:url value='/html/egovframework/com/cmm/utl/ckeditor/adapters/jquery.js'/>"></script>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	Date nowTime = new Date();
	SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
	String now = simpleDate.format(nowTime);
%>
</head>

<body topmargin="0" leftmargin="0">
<%@ include file="/WEB-INF/jsp/gzonei/layout/top.jsp" %>


	<!-- header -->
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
                <h2 class="page__title">자료실</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do' />">HOME</a></li>
                        <li class="n2"><a href="#">부가서비스</a></li>
                        <li class="n3"><a href="<c:url value='/adisvc/recsroomBbsList.do'/>" class="navi_ov">자료실</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">
            <!-- content 영역입니다. -->
			<!-- view : S -->
			<div class="board_view_in">

				<form name="insertForm" id="insertForm" method="post" action="<c:url value='/adisvc/recsroomInsertBbs.do'/>" onSubmit="fn_insert(); return false;" enctype="multipart/form-data">
					<div class="form-horizontal bucket-form">
						<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2">
								<label for="select">구분 <span class="pilsu">필수</span></label>
							</div>
							<div class="col-sm-4">
								<select id="detailSeCode" name="detailSeCode" class="form-control" title="구분 선택" required="">
									<option value="">지역/사업지구 선택</option>
									<option value="">선택 없음</option>
										<c:if test="${!empty devInfoList}">
											<c:forEach var="list" items="${devInfoList}" varStatus="status">
												<option value="${list.codeId}"><c:out value="${list.codeIdNm}"/></option>
											</c:forEach>
										</c:if>
								</select>
							</div>
						</div>	
						
						<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2">
								<label for="select">열람권한 <span class="pilsu">필수</span></label>
							</div>
							<div class="col-sm-4">
								<select id="readngAuthorCode" name="readngAuthorCode" class="form-control"
									title="열람권한 선택" required="">
									<option value="">열람권한 선택</option>
<!-- 									<option value="CM00209998">무료</option> -->
									<option value="bbs009002">1레벨</option>
									<option value="bbs009003">2레벨</option>
									<option value="bbs009004">3레벨</option>
<!-- 									<option value="CM00200005">실버</option> -->
<!-- 									<option value="CM00200005">실버(이코노미)</option> -->
<!-- 									<option value="CM00200006">실버(스페셜)</option> -->
<!-- 									<option value="CM00200007">골드</option> -->
<!-- 									<option value="CM00200007">골드(이코노미)</option> -->
<!-- 									<option value="CM00200008">골드(비즈니스)</option> -->
<!-- 									<option value="CM00200009">골드(스페셜)</option> -->
<!-- 									<option value="CM00200010">프리미엄</option> -->
<!-- 									<option value="CM00200010">프리미엄(이코노미)</option> -->
<!-- 									<option value="CM00200011">프리미엄(스페셜)</option> -->
								</select>
							</div>
						</div>
						
					
						
                          
						<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2">
								<label for="select">제목 <span class="pilsu">필수</span></label>
							</div>
							<div class="col-sm-9">
								<input type="text" id="nttSj" name="nttSj" title="제목 입력" class="form-control" required>
							</div>
						</div>
					
						<div class="form-group">
                      		<div class="col-sm-1 control-label"><label for="select">전시여부</label></div>
                            <div class="col-sm-2">
                            	<input class="radio-input" type="radio" value="Y"  id='dsply' name='dspyAt' /><label class="radio-inline" for="dsply" >전시</label>
                              	<input class="radio-input" type="radio" value="N" id='noDsply' name='dspyAt' checked /><label class="radio-inline" for="noDsply">미전시</label>
                            </div>
                        	<div class="col-sm-1 control-label"><label for="select">삭제여부</label></div>
                            <div class="col-sm-2">
                            	<input class="radio-input" type="radio" value="Y"  id='delete' name='delAt'  <c:if test="${result.delAt eq 'Y'}">checked</c:if> /><label class="radio-inline" for="delete">삭제</label>
                            	<input class="radio-input" type="radio" value="N" id='noDelete' name='delAt' checked<c:if test="${result.delAt eq 'N'}">checked</c:if>/><label class="radio-inline" for="noDelete" >미삭제</label>
                            </div>
                            <div class="col-sm-1 control-label"><label for="select">작성일</label></div>
                        	<div class="col-sm-2 search--calendar">
							    <div>
							    	<input type="text" name="frstRegistPnttm" id="frstRegistPnttm" placeholder="작성일" class="form-control" autocomplete="off" onkeyup="this.value = date_mask(this.value)" maxlength="10" value="<%=now%>"  />
							    	<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
								</div>
							</div>
                            <div class="col-sm-1 control-label" style="display:none"><label for="select">사용여부</label></div>
                            <div class="col-sm-2" style="display:none">
                               <input class="radio-input" type="radio" value="Y"  id='use' name='useAt' checked<c:if test="${result.useAt eq 'Y'}">checked</c:if> /><label class="radio-inline" for="use" >사용</label>
                              <input class="radio-input" type="radio" value="N" id='disuse' name='useAt' <c:if test="${result.useAt eq 'N'}">checked</c:if> /><label class="radio-inline" for="disuse">미사용</label>
                              </div>
                          </div>
                          
					
						<div class="form-group">
							<div class="col-sm-12">
								<textarea class="form-control" id="nttCn" name="nttCn" title="내용 입력" rows="100"></textarea>
								<script type="text/javascript" src="<c:url value='/js/gzonei/ckeditor_custom_config.js'/>"></script>
							</div>
						</div>
					
						<!-- 첨부파일 S  -->
						<div class="form-group">
						    <div class="col-sm-2 control-label col-lg-2"><label for="select">첨부파일 <span class="pilsu">필수</span></label></div>
						    
						    <div class="col-sm-7">
						    	<div class="form-upload">
						    	 	<div class="file-form-group">
						    	 		<div class="form-group__upload">
						    	 			<input type="text" readonly="readonly" name="atchFileNm" class="form-control disabled">
						    	 			<input type="file" name="atchFile_1" id="atchFile_1" class="form-upload__file--hidden">
						    	 		</div>
						    	 		<div class="form-input__addon">
						                    <label for="atchFile_1" class="btn btn-sm btn-secondary" data-button="upload">파일첨부하기</label>
						                    <button type="button" class="btn btn-sm btn-primary file_del_btn">파일 삭제</button>
						               </div>
						    	 	</div>
						    	 	<div class="form-group file_author">
									 	<div class="col-sm-2 control-label col-lg-2"><label for="select">첨부파일 권한<span class="pilsu">필수</span></label></div>
									    <div class="col-sm-4">
										    <select name="fileAuthor" class="form-control">   
			 									<option value="bbs009005">1레벨</option>
												<option value="bbs009006">2레벨</option>
												<option value="bbs009007">3레벨</option>
<!-- 										    	<option value="CM00209998">무료</option> -->
<!-- 										    	<option value="CM00200005">실버 (이코노미)</option> -->
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
						<!-- 첨부파일 E  -->
				
					</div>
						
					<input type="hidden" name="nttId"  value="0"/>
					<input type="hidden" name="bbsId"  value="BBSMSTR_000000000011"/>
					<input type="hidden" name="answerAt"  value="Y"/>
					<input type="hidden" name="dspyAt"  value="Y"/>
<!-- 					<input type="hidden" name="parntscttNo"  value="1"/> -->
<!-- 					<input type="hidden" name="answerLc"  value="1"/> -->
<!-- 					<input type="hidden" name="sortOrder"  value=""/> -->
<!-- 					<input type="hidden" name="rdcnt"  value=""/> -->
					<input type="hidden" name="useAt"  value="Y"/>
					<input type="hidden" name="ntcrId"  value="${ loginVO.get("id") }"/>
					<input type="hidden" name="ntcrNm"  value="${ loginVO.get("userNm") }"/>  <!--추후 회원 아이디 추가 -->
					<input type="hidden" name="frstRegisterId"  value="${ loginVO.get("id") }"/><!--추후 회원 아이디 추가 -->
					<input type="hidden" name="password"  value="tester"/>
<!-- 					<input type="hidden" name="secretAt"  value="1"/> -->
<!-- 					<input type="hidden" name="lastUpdtPnttm"  value="1"/> -->
<!-- 					<input type="hidden" name="lastUpdusrId"  value="1"/> -->
					<input type="hidden" name="bolgId"  value="N"/>
					<input type="hidden" name="delAt"  value="N"/>
<!-- 					<input type="hidden" name="trgamt"  value="0"/> -->
<!-- 					<input type="hidden" name="lc"  value="0"/> -->
<!-- 					<input type="hidden" name="dwkNm"  value="0"/> -->
					<input type="hidden" name="freeAt"  value="Y"/>
<!-- 					<input type="hidden" name="nsprcCode"  value="0"/> -->
<!-- 					<input type="hidden" name="nsprcNm"  value="0"/> -->
<!-- 					<input type="hidden" name="articleDe"  value="0"/>  -->

					<div class="board_btm">
                        <div class="btns_area fl_r mo_block">
                			<a href="javascript:fn_insert()" class="btn btn-default">등록</a>
							<a href="#" class="btn btn-default" onclick="cancel();">취소</a>
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


	<script>
		function cancel() {
			document.location="<c:url value='/adisvc/recsroomBbsList.do'/>";
		}
		
// 		function insert() {
// 			document.insertForm.action="<c:url value='/oper/insertBbs.do'/>";
// 			document.insertForm.submit();
// 		}
	
	function validate(){
		if ($('#bbsTabCode').val() == '') {
			Common.Dialog.alert({
	            content: '구분을 선택해주세요.'
	            ,ok : function(){
	            	$('#bbsTabCode').focus();
	            }
	        });
			return false;
		}
		
		if ($('#readngAuthorCode').val() == '') {
			Common.Dialog.alert({
	            content: '열람권한을 선택해주세요.'
	            ,ok : function(){
	            	$('#readngAuthorCode').focus();
	            }
	        });
			return false;
		}
		
		if ($('#nttSj').val() == '') {
			Common.Dialog.alert({
	            content: '제목을 입력해주세요.'
	            ,ok : function(){
					$('#nttSj').focus();
	            }
	        });
	     	return false;
		}
		
		if ($('#frstRegistPnttm').val() == '') {
			Common.Dialog.alert({
	            content: '작성일을 선택해주세요.'
	            ,ok : function(){
					$('#frstRegistPnttm').focus();
	            }
	        });
	     	return false;
		}
		
		
// 		if (document.insertForm.nttCn.value == '') {
		if (CKEDITOR.instances.nttCn.getData() == '') {
			Common.Dialog.alert({
	            content: '내용을 입력해주세요.'
	            ,ok : function(){
					$('#nttCn').focus();
	            }
	        });
			return false;
		}
		return true;
	}
	
	function fn_insert(){
		if(validate()){
			Common.Dialog.confirm({
		        title: '등록',
	            content: '등록하시겠습니까?'
	            ,ok: function(){
// 	        		document.insertForm.action = "<c:url value='/adisvc/recsroomInsertBbs.do'/>";
	        		document.insertForm.submit();
	            }
		        ,cancel : function(){
		        	return false;
		        }
	        });
		}
	}
	
	$(function() {
		getTimeStamp();
	});

	function getTimeStamp() {
		var d = new Date();
		var date = leadingZeros(d.getFullYear(), 4) + '-' +
					leadingZeros(d.getMonth() + 1, 2) + '-' +
					leadingZeros(d.getDate(), 2) + '';

		$('#frstRegistPnttm').val(date);

	}

	function leadingZeros(n, digits) {
		var zero = '';

		n = n.toString();
		if (n.length < digits) {
			for (i = 0; i < digits - n.length; i++)
				zero += '0';
		}
		return zero + n;
	}

	</script>


<!-- 구현부 : E -->

<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>
</body>
</html>
