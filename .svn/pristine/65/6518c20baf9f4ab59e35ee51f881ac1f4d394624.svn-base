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
<!DOCTYPE html>
<html lang="ko">
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="/WEB-INF/jsp/gzonei/layout/header.jsp" %>

<!-- 행정안전부 공통서비스 테스트 사이트 -->
<script type="text/javascript" src="<c:url value='/html/egovframework/com/cmm/utl/ckeditor/ckeditor.js'/>"></script>
<script type="text/javascript" src="<c:url value='/html/egovframework/com/cmm/utl/ckeditor/adapters/jquery.js'/>"></script>
</head>

<body topmargin="0" leftmargin="0">
<%@ include file="/WEB-INF/jsp/gzonei/layout/top.jsp" %>


	<!-- header -->

	
	
<div id="body_layout">	
	
	<!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
            <div id="location" class="title_wrap">
                <h2 class="page__title">토지보상 검토의뢰</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do' />">HOME</a></li>
                        <li class="n2"><a href="#">부가서비스</a></li>
                        <li class="n3"><a href="<c:url value='/adisvc/reqestBbsList.do'/>" class="navi_ov">토지보상 검토의뢰</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">
            <!-- content 영역입니다. -->
			<!-- view : S -->
			<div class="board_view_in">

				<form name="insertForm" id="insertForm" method="post" action="<c:url value='/adisvc/reqestInsertBbs.do'/>" onSubmit="fn_insert(); return false;" enctype="multipart/form-data">
					<div class="form-horizontal bucket-form">
						<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2">
								<div class="label">
									<label for="select">구분 <span class="pilsu">필수</span></label>
								</div>
							</div>
							<div class="col-sm-4">
								<select id="bbsTabCode" name="bbsTabCode" class="form-control"
									title="구분 선택" required="">
									<option value="">지역/사업지구 선택</option>
									<option value="구분A">구분A</option>
									<option value="구분B">구분B</option>
									<option value="구분C">구분C</option>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2">
								<div class="label">
									<label for="select">열람권한 <span class="pilsu">필수</span></label>
								</div>
							</div>
							<div class="col-sm-4">
								<select id="readngAuthorCode" name="readngAuthorCode" class="form-control"
									title="열람권한 선택" required="">
									<option value="">열람권한 선택</option>
									<option value="CM00209998">무료</option>
									<option value="CM00200005">실버(이코노미)</option>
									<option value="CM00200006">실버(스페셜)</option>
									<option value="CM00200007">골드(이코노미)</option>
									<option value="CM00200008">골드(비즈니스)</option>
									<option value="CM00200009">골드(스페셜)</option>
									<option value="CM00200010">프리미엄(이코노미)</option>
									<option value="CM00200011">프리미엄(스페셜)</option>
								</select>
							</div>
						</div>
						
						
						<div class="form-group">
						
							<div class="col-sm-2 control-label col-lg-2">
								<div class="label">
									<label for="select">제목 <span class="pilsu">필수</span></label>
								</div>
							</div>
							<div class="col-sm-9">
								<input type="text" id="nttSj" name="nttSj" title="제목 입력" class="form-control" required>
							</div>
						</div>
					
						<div class="form-group">
                            <div class="col-sm-2 control-label col-lg-2"><div class="label">사용여부</div></div>
                            <div class="col-sm-2">
                               <input class="radio-input" type="radio" value="Y"  id='use' name='useAt' <c:if test="${result.useAt eq 'Y'}">checked</c:if> /><label class="radio-inline" for="use">사용</label>
                              <input class="radio-input" type="radio" value="N" id='disuse' name='useAt' <c:if test="${result.useAt eq 'N'}">checked</c:if> /><label class="radio-inline" for="disuse">미사용</label>
                              </div>
                            <div class="col-sm-1 control-label"><div class="label">전시여부</div></div>
                            <div class="col-sm-2">
                                  <input class="radio-input" type="radio" value="Y"  id='dsply' name='dspyAt' <c:if test="${result.dspyAt eq 'Y'}">checked</c:if> /><label class="radio-inline" for="dsply">전시</label>
                              <input class="radio-input" type="radio" value="N" id='noDsply' name='dspyAt'<c:if test="${result.dspyAt eq 'N'}">checked</c:if> /><label class="radio-inline" for="noDsply">미전시</label>
                              </div>
                            <div class="col-sm-1 control-label"><div class="label">삭제여부</div></div>
                            <div class="col-sm-2">
                                  <input class="radio-input" type="radio" value="Y"  id='delete' name='delAt'  <c:if test="${result.delAt eq 'Y'}">checked</c:if> /><label class="radio-inline" for="delete">삭제</label>
                              <input class="radio-input" type="radio" value="N" id='noDelete' name='delAt' <c:if test="${result.delAt eq 'N'}">checked</c:if>/><label class="radio-inline" for="noDelete">미삭제</label>
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
										    	<option value="">---권한 설정---</option>
										    	<option value="CM00209998">무료</option>
										    	<option value="CM00200005">실버 (이코노미)</option>
										    	<option value="CM00200006">실버 (스페셜)</option>
										    	<option value="CM00200007">골드 (이코노미)</option>
										    	<option value="CM00200008">골드 (비즈니스)</option>
										    	<option value="CM00200009">골드 (스페셜)</option>
										    	<option value="CM00200010">프리미엄 (이코노미)</option>
										    	<option value="CM00200011">프리미엄 (스페셜)</option>
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
					<input type="hidden" name="bbsId"  value="BBSMSTR_000000000024"/>
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
			document.location="<c:url value='/adisvc/reqestBbsList.do'/>";
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
	</script>


<!-- 구현부 : E -->

<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>
</body>
</html>
