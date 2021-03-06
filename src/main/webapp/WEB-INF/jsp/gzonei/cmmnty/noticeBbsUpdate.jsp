<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="ckeditor" uri="http://ckeditor.com"%>
<!DOCTYPE html>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
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

		function cancel() {
			history.go(-1);
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
		function update() {		
			if(validate()){	
			Common.Dialog.confirm({
		        title: '수정',
	            content: '현재 게시글을 수정하시겠습니까?'
	            ,ok: function(){
	            	document.updateForm.action="<c:url value='/cmmnty/noticeBbsUdt.do'/>";
					document.updateForm.submit();
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
                <h2 class="page__title">공지사항</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a  href="<c:url value='/cmmnty/noticeBbsList.do'/>">커뮤니티</a></li>
                        <li class="n3"><a href="<c:url value='/cmmnty/noticeBbsList.do'/>" class="navi_ov">공지사항</a></li>
                    </ul>                            
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">

            <!-- content 영역입니다. -->
			<!-- view : S -->
			<div class="board_view_in">
                    <form name="updateForm" method="post"  enctype="multipart/form-data">
                    <div class="form-horizontal bucket-form">
						<div class="form-group">
						    <div class="col-sm-2 control-label col-lg-2"><div class="label">제목 <span class="pilsu">필수</span></div></div>
						    <div class="col-sm-9">
						    	<input type="text" id="nttSj" name="nttSj" title="이름 입력" class="form-control" value="<c:out value='${result.nttSj }'/>">
							</div>
						</div> 
						<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2"><div class="label">작성 일자 <span class="pilsu">필수</span></div></div>
						    <div class="col-sm-2 search--calendar">
							    <div>
							    	<input type="text" name="frstRegistPnttm" id="frstRegistPnttm" placeholder="작성일자" onkeyup="this.value = date_mask(this.value)" maxlength="10" value="<fmt:formatDate  value="${result.frstRegistPnttm}" pattern="yyyy-MM-dd"/>" class="form-control"  autocomplete="off"/>
							    	<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
								</div>
							</div>
						</div> 
						
<!-- 							------------관리자 권한 넣기전 조치======================= -->
						<c:if test="${sessionScope.authVO.bbs001001.infoDspyAt == 'Y'}"> 
						<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2"><div class="label">공지여부</div></div>
						    <div class="col-sm-2">
						    	<div class="label-text">
									<input type="checkbox"  value="Y" name="noticeAt" <c:if test="${result.noticeAt eq 'Y' }">checked</c:if> />&nbsp;&nbsp;공지
								</div>
							</div>
						</div> 
						<div class="form-group">
<!--                             <div class="col-sm-2 control-label col-lg-2"><div class="label">사용여부</div></div> -->
<!--                             <div class="col-sm-2"> -->
<%--                                <input class="radio-input" type="radio" value="Y"  id='use' name='useAt' <c:if test="${result.useAt eq 'Y'}">checked</c:if> /><label class="radio-inline" for="use">사용</label> --%>
<%--                               <input class="radio-input" type="radio" value="N" id='disuse' name='useAt' <c:if test="${result.useAt eq 'N'}">checked</c:if> /><label class="radio-inline" for="disuse">미사용</label> --%>
<!--                               </div> -->

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
								<textarea id="nttCn" name='nttCn' title="타이틀" class="form-control" rows="20">${result.nttCn}</textarea>
								<script type="text/javascript" src="<c:url value='/js/gzonei/ckeditor_custom_config.js'/>"></script>
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
<!-- 									    	<option value="">---권한 설정---</option> -->
									    	<option value="CM00209998" <c:if test="${atcFile.readingAuthorCode eq 'CM00209998' or atcFile.readingAuthorCode eq null }">selected</c:if>>무료</option>
<%-- 									    	<option value="CM00200005" <c:if test="${atcFile.readingAuthorCode eq 'CM00200005'}">selected</c:if> >실버 (이코노미)</option> --%>
<%-- 									    	<option value="CM00200006" <c:if test="${atcFile.readingAuthorCode eq 'CM00200006'}">selected</c:if>>실버 (스페셜)</option> --%>
<%-- 									    	<option value="CM00200007" <c:if test="${atcFile.readingAuthorCode eq 'CM00200007'}">selected</c:if>>골드 (이코노미)</option> --%>
<%-- 									    	<option value="CM00200008" <c:if test="${atcFile.readingAuthorCode eq 'CM00200008'}">selected</c:if>>골드 (비즈니스)</option> --%>
<%-- 									    	<option value="CM00200009" <c:if test="${atcFile.readingAuthorCode eq 'CM00200009'}">selected</c:if>>골드 (스페셜)</option> --%>
<%-- 									    	<option value="CM00200010" <c:if test="${atcFile.readingAuthorCode eq 'CM00200010'}">selected</c:if>>프리미엄 (이코노미)</option> --%>
<%-- 									    	<option value="CM00200011" <c:if test="${atcFile.readingAuthorCode eq 'CM00200011'}">selected</c:if>>프리미엄 (스페셜)</option> --%>
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
					<input type="hidden" name="nttId"  value="${result.nttId}"/>
					<input type="hidden" name="bbsId"  value="${result.bbsId}"/>
 					<input type="hidden" name="answerAt"  value="${result.answerAt}"/>

					<c:if test="${result.parntscttNo ne null}">
						<input type="hidden" name="parntscttNo"  value="${result.parntscttNo}"/>
					</c:if>
					<c:if test="${result.answerLc ne null}">
						<input type="hidden" name="answerLc"  value="${result.answerLc}"/>
					</c:if>
					<c:if test="${result.sortOrder ne null}">
						<input type="hidden" name="sortOrder"  value="${result.sortOrder}"/>
					</c:if>
					<input type="hidden" name="rdcnt"  value="${result.rdcnt}"/>
					<input type="hidden" name="ntcrId"  value="${result.ntcrId}"/>
					<input type="hidden" name="ntcrNm"  value="${result.ntcrNm}"/> 
					<input type="hidden" name="frstRegisterId"  value="${result.frstRegisterId}"/>
					<input type="hidden" name="password"  value="${result.password}"/>
					<input type="hidden" name="secretAt"  value="${result.secretAt}"/>
					<input type="hidden" name="lastUpdtPnttm"  value="${result.lastUpdtPnttm}"/>
					<input type="hidden" name="lastUpdusrId"  value="${result.lastUpdusrId}"/>
					<input type="hidden" name="bolgId"  value="${result.bolgId}"/>
					<input type="hidden" name="trgamt"  value="${result.trgamt}"/>
					<input type="hidden" name="freeAt"  value="${result.freeAt}"/>
					<input type="hidden" name="nsprcCode"  value="${result.nsprcCode}"/>
					<input type="hidden" name="nsprcNm"  value="${result.nsprcNm}"/>
					<input type="hidden" name="articleDe"  value="${result.articleDe}"/> 

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
