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
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>

<html lang='ko'>

<script type="text/javascript"
	src="<c:url value='/js/gzonei/jquery-3.5.1.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/html/egovframework/com/cmm/utl/ckeditor/ckeditor.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/html/egovframework/com/cmm/utl/ckeditor/adapters/jquery.js'/>"></script>
<head>
<%@ include file="/WEB-INF/jsp/gzonei/layout/header.jsp"%>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/gzonei/layout/top.jsp"%>

	<!-- 구현부 : S -->

	<div id="body_layout">

		<!-- layout -->
		<div class="body_wrap layout">
			<div id="contens" class="contents_wrap">
				<div id="location" class="title_wrap">
					<h2 class="page__title">Q&A 게시판</h2>
					<!-- 유틸 시작 -->
					<div class="utile_wrap">
						<!-- 로케이션 시작 -->
						<ul class="location_wrap">
							<li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
							<li class="n2"><a href="<c:url value='/cmmnty/noticeBbsList.do'/>">커뮤니티</a></li>
							<li class="n3"><a
								href="<c:url value='/cmmnty/qnaBbsList.do'/>" class="navi_ov">Q&A게시판</a></li>
						</ul>
					</div>
					<!-- 유틸 끝 -->
				</div>

				<div id="txt">

					<div class="nav-4th">
						<ul>
							<li><a href="<c:url value='/cmmnty/qnaBbsList.do'/>">전체보기</a></li>
							<li><a href="<c:url value='/cmmnty/qnaDevinfoList.do'/>">개발정보관련</a></li>
							<li><a href="<c:url value='/cmmnty/qnaAucList.do'/>">경매관련</a></li>
							<li><a href="<c:url value='/cmmnty/qnaPblsalList.do'/>">공매관련</a></li>
						</ul>
					</div>
					<!-- content 영역입니다. -->
					<!-- view : S -->
					<div class="board_view_in">
						<form name="updateForm" method="post" enctype="multipart/form-data">
							<div class="form-horizontal bucket-form">
								<div class="form-group">
									<div class="col-sm-2 control-label col-lg-2">
										<div class="label">구분 <span class="pilsu">필수</span></div>
									</div>
									<div class="col-sm-4">
										<select id="seCode" name="seCode" class="form-control"
											title="구분 선택">
											<option value="">-구분-</option>
											<option value="001"
												<c:if test="${result.seCode eq '001' }">selected</c:if>>개발정보관련
												</option>
											<option value="002"
												<c:if test="${result.seCode eq '002' }">selected</c:if>>경매관련
												</option>
											<option value="003"
												<c:if test="${result.seCode eq '003' }">selected</c:if>>공매관련
												</option>
										</select>
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-2 control-label col-lg-2">
										<div class="label">제목 <span class="pilsu">필수</span></div>
									</div>
									<div class="col-sm-9">
<%-- 										<input type="text" id="nttSj" name="nttSj" title="이름 입력" class="form-control" value="${result.nttSj}"> --%>
										<input type="text" id="nttSj" name="nttSj" title="이름 입력" class="form-control" value="<c:out value='${result.nttSj }'/>">
									</div>
								</div>
							
								<c:if test="${sessionScope.authVO.bbs008002.infoDspyAt == 'Y'}">
		                           <div class="form-group">
<!-- 		                            <div class="col-sm-2 control-label col-lg-2"><div class="label">사용여부</div></div> -->
<!-- 		                            <div class="col-sm-2"> -->
<%-- 		                               <input class="radio-input" type="radio" value="Y"  id='use' name='useAt' <c:if test="${result.useAt eq 'Y'}">checked</c:if> /><label class="radio-inline" for="use">사용</label> --%>
<%-- 		                              <input class="radio-input" type="radio" value="N" id='disuse' name='useAt' <c:if test="${result.useAt eq 'N'}">checked</c:if> /><label class="radio-inline" for="disuse">미사용</label> --%>
<!-- 		                              </div> -->
		                            <div class="col-sm-2 control-label"><div class="label">전시여부</div></div>
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
								</c:if>
								
								<div class="form-group">
									<div class="col-sm-12">
										<!-- CKEditor Sample <START> -->
										<textarea id="nttCn" name='nttCn' title="타이틀"
											class="form-control" rows="20">${result.nttCn}</textarea>
										<script type="text/javascript"
											src="<c:url value='/js/gzonei/ckeditor_custom_config.js'/>"></script>
										<!-- CKEditor Sample <END>-->
									</div>
								</div>
								<div class="form-group">
							    <div class="col-sm-2 control-label col-lg-2"><label for="select">첨부파일 <span class="pilsu">필수</span></label></div>
							    <div class="col-sm-7">
									<div class="form-upload">
									<c:forEach items="${atchFileDetail}" var="atcFile" varStatus="status">
										<c:set var="atcNum" value="${atcNum+1}"/>
										<div class="file-form-group">
											<div class="form-group__upload">
							    	 			<input type="text" readonly="readonly" name="atchFileNm" class="form-control disabled" value="${atcFile.orignlFileNm}">
							    	 			<input type="file" id="atchFile_${atcNum}" name="atchFile_${atcNum}" class="form-upload__file--hidden">
							    	 		</div>
							    	 		<div class="form-input__addon">
												<label for="atchFile_${atcNum}" class="btn btn-sm btn-secondary" data-button="upload">파일첨부하기</label>
												<button type="button" class="btn btn-sm btn-primary file_del_btn">파일 삭제</button>
												<input type="hidden"  name="fileStreCours" value="<c:out value='${atcFile.fileStreCours }'/>"/>
												<input type="hidden"  name="orignlFileNm" value="<c:out value='${atcFile.orignlFileNm }'/>"/>
												<input type="hidden"  class="fileSn" name="fileSn" value="<c:out value='${atcFile.fileSn}'/>"/>
												<input type="hidden"  name="uploadDt" value="<c:out value='${atcFile.uploadDt}'/>"/>
												<input type="hidden"  name="atchFileId" value="<c:out value='${atcFile.atchFileId}'/>"/>	
											</div>
										</div>
										<div class="form-group file_author" style="display:none;">
										    <div class="col-sm-2 control-label col-lg-2"><label for="select">첨부파일 권한<span class="pilsu">필수</span></label></div>
										    <div class="col-sm-4">
											    <select name="fileAuthor" class="form-control">
<!-- 											    	<option value="">---권한 설정---</option> -->
											    	<option value="CM00209998" <c:if test="${atcFile.readingAuthorCode eq 'CM00209998' or atcFile.readingAuthorCode eq null }">selected</c:if>>무료</option>
<%-- 											    	<option value="CM00200005" <c:if test="${atcFile.readingAuthorCode eq 'CM00200005'}">selected</c:if> >실버 (이코노미)</option> --%>
<%-- 											    	<option value="CM00200006" <c:if test="${atcFile.readingAuthorCode eq 'CM00200006'}">selected</c:if>>실버 (스페셜)</option> --%>
<%-- 											    	<option value="CM00200007" <c:if test="${atcFile.readingAuthorCode eq 'CM00200007'}">selected</c:if>>골드 (이코노미)</option> --%>
<%-- 											    	<option value="CM00200008" <c:if test="${atcFile.readingAuthorCode eq 'CM00200008'}">selected</c:if>>골드 (비즈니스)</option> --%>
<%-- 											    	<option value="CM00200009" <c:if test="${atcFile.readingAuthorCode eq 'CM00200009'}">selected</c:if>>골드 (스페셜)</option> --%>
<%-- 											    	<option value="CM00200010" <c:if test="${atcFile.readingAuthorCode eq 'CM00200010'}">selected</c:if>>프리미엄 (이코노미)</option> --%>
<%-- 											    	<option value="CM00200011" <c:if test="${atcFile.readingAuthorCode eq 'CM00200011'}">selected</c:if>>프리미엄 (스페셜)</option> --%>
											    </select>
									    	</div>
										</div>
										</c:forEach>
										<div class="file-button">
											<button type="button" class="addFile">추가</button>
											<button type="button" class="delFile">삭제</button>
										</div>
									</div>
							    </div>
							</div>
							</div>
					


					<div class="board_btm">
						<div class="btns_area fl_r mo_block">
							<a class="btn btn-primary" onclick="update();">수정</a> 
							<a class="btn btn-default"  onclick="cancel();">취소</a>
						</div>
					</div>
					<input type="hidden" name="nttId" value="${result.nttId}" /> <input
						type="hidden" name="bbsId" value="${result.bbsId}" /> <input
						type="hidden" name="answerAt" value="${result.answerAt}" /> <input
						type="hidden" name="dspyAt" value="${result.dspyAt}" />
					<c:if test="${result.parntscttNo ne null}">
						<input type="hidden" name="parntscttNo"
							value="${result.parntscttNo}" />
					</c:if>
					<c:if test="${result.answerLc ne null}">
						<input type="hidden" name="answerLc" value="${result.answerLc}" />
					</c:if>
					<c:if test="${result.sortOrder ne null}">
						<input type="hidden" name="sortOrder" value="${result.sortOrder}" />
					</c:if>
					<input type="hidden" name="rdcnt" value="${result.rdcnt}" /> <input
						type="hidden" name="useAt" value="${result.useAt}" /> <input
						type="hidden" name="ntcrId" value="${result.ntcrId}" /> <input
						type="hidden" name="ntcrNm" value="${result.ntcrNm}" />
						 <input type="hidden" name="frstRegisterId" value="${result.frstRegisterId}" /> 
						 <input type="hidden" name="frstRegistPnttm" value="${result.frstRegistPnttm}" /> 
						<input type="hidden"
						name="password" value="${result.password}" /> <input
						type="hidden" name="secretAt" value="${result.secretAt}" /> <input
						type="hidden" name="lastUpdtPnttm" value="${result.lastUpdtPnttm}" />
					<input type="hidden" name="lastUpdusrId"
						value="${result.lastUpdusrId}" /> <input type="hidden"
						name="bolgId" value="${result.bolgId}" /> <input type="hidden"
						name="delAt" value="${result.delAt}" /> <input type="hidden"
						name="trgamt" value="${result.trgamt}" /> <input type="hidden"
						name="lc" value="${result.lc}" /> <input type="hidden"
						name="dwkNm" value="${result.dwkNm}" /> <input type="hidden"
						name="freeAt" value="${result.freeAt}" /> <input type="hidden"
						name="nsprcCode" value="${result.nsprcCode}" /> <input
						type="hidden" name="nsprcNm" value="${result.nsprcNm}" /> <input
						type="hidden" name="articleDe" value="${result.articleDe}" />

					</form>
					</div>
				</div>
				<!-- view : E -->
				<script>
				function cancel() {
					history.go(-1);
				}
				
				function validate(){
					
					if ($('#bbsTabCode').val() == '') {
						Common.Dialog.alert({
				            content: '구분을 선택해주세요.'
				            ,ok : function(){
				            	$('#nttSj').focus();
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
					return true;
				}
				
				function update() {
					if(validate()){	
						Common.Dialog
								.confirm({
									title : '수정',
									content : '현재 게시글을 수정하시겠습니까?',
									ok : function() {
										document.updateForm.action = "<c:url value='/cmmnty/qnaBbsUdt.do'/>";
										document.updateForm.submit();
									},
									cancel : function() {
										return false;
									}
								});
					}
				}
				</script>
				<script>
				/* 첨부파일 삭제*/
				$('.file_del_btn').on('click',function(){
					if (confirm("첨부파일을 삭제하시겠습니까?") == true){    //확인
						debugger;
						var parent = $(this).parent().parent();
						var fileSn = $(this).nextAll('.fileSn').val();
						var atchFileId = $('input[name=atchFileId]').val(); 
						$.ajax({
							type: "POST",
							data: {
								atchFileId: atchFileId,
								fileSn: fileSn
							},
							url: "<c:url value='/str/deleteAtchFile.do'/>",
							success: function(data) {
								alert('첨부파일을 삭제하였습니다.');
								$(parent).remove();
							}
						}); 
					}else{return;}
				});
				</script>

				<!-- content 영역입니다. -->
			</div>
		</div>
	</div>
	<!-- layout -->

	<!-- 구현부 : E -->

	<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp"%>
</body>
</html>
