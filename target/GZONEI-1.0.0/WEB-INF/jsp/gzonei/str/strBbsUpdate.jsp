<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="ckeditor" uri="http://ckeditor.com"%>
<!DOCTYPE html>
<html lang='ko'>
<script type="text/javascript" src="<c:url value='/js/gzonei/jquery-3.5.1.js' />"></script>
<script type="text/javascript" src="<c:url value='/html/egovframework/com/cmm/utl/ckeditor/ckeditor.js'/>"></script>
<script type="text/javascript" src="<c:url value='/html/egovframework/com/cmm/utl/ckeditor/adapters/jquery.js'/>"></script>
<head>
<%@ include file="/WEB-INF/jsp/gzonei/layout/header.jsp" %>
<script>
function insert() {
	if(insertForm.bbsId.value == ""){
		Common.Dialog.alert({
			content: '구분을 선택해주세요.'
			,ok : function(){
				insertForm.bbsId.focus();
			}
		}); 
		return;
   	}else if(insertForm.nttSj.value == ""){
		Common.Dialog.alert({
			content: '제목을 입력해주세요.'
			,ok : function(){
				insertForm.nttSj.focus();
			}
		});
		return;
	}else if(insertForm.frstRegistPnttm.value == ""){
		Common.Dialog.alert({
			content: '작성일을 선택해주세요.'
			,ok : function(){
				insertForm.frstRegistPnttm.focus();
			}
		});
		return;
	}else{
		Common.Dialog.confirm({
	        title: '수정',
	        content: '현재 게시글을 수정하시겠습니까?'
	        ,ok: function(){
	        	document.insertForm.action="<c:url value='/str/strBbsUdt.do'/>";
				document.insertForm.submit();
	        }
	        ,cancel : function(){
	        	document.location.reload();
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
</head>

<body>
<%@ include file="/WEB-INF/jsp/gzonei/layout/top.jsp" %>

<body>
<div id="body_layout">	

    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
            <div id="location" class="title_wrap">
            <c:if test="${searchVO.readngAuthorCode eq null or searchVO.readngAuthorCode eq ''}">
                <h2 class="page__title">지존스토어</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="<c:url value='/str/strBbsList.do'/>" class="navi_ov">지존스토어</a></li>
                    </ul>                           
                </div>
            </c:if>
            <c:if test="${searchVO.readngAuthorCode eq '002'}">
                <h2 class="page__title">보상투자성공사례</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                    	<li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="/str/strBbsList.do">지존스토어</a></li>
                        <li class="n3"><a href="<c:url value='/str/strSuccesBbsList.do'/>" class="navi_ov">보상투자성공사례</a></li>
                    </ul>                           
                </div>
            </c:if>
            <c:if test="${searchVO.readngAuthorCode eq '003'}">
                <h2 class="page__title">보상투자실패사례</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                    	<li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                     	<li class="n2"><a href="/str/strBbsList.do">지존스토어</a></li>
                        <li class="n3"><a href="<c:url value='/str/strFailrBbsList.do'/>" class="navi_ov">보상투자실패사례</a></li>
                    </ul>                           
                </div>
            </c:if>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">
	            
			<div class="nav-4th">
				<ul>
					<li <c:if test="${searchVO.readngAuthorCode eq null}"> class="active"</c:if>><a class="debug" href="<c:url value='/str/strBbsList.do'/>">전체보기 </a></li>
					<li <c:if test="${searchVO.readngAuthorCode eq '002'}"> class="active"</c:if>><a href="<c:url value='/str/strSuccesBbsList.do'/>">보상투자성공사례</a></li>
					<li <c:if test="${searchVO.readngAuthorCode eq '003'}"> class="active"</c:if>><a href="<c:url value='/str/strFailrBbsList.do'/>">보상투자실패사례</a></li>
				</ul>
			</div>
            <!-- content 영역입니다. -->
			<!-- view : S -->
			<div class="board_view_in">
              	 <form name="insertForm" method="post" enctype="multipart/form-data">
	                    <div class="form-horizontal bucket-form">
		                   <div class="form-group">
							    <div class="col-sm-2 control-label col-lg-2"><label for="select">구분 <span class="pilsu">필수</span></label></div>
							    <div class="col-sm-4">
									<select id="bbsTabCode" name="readngAuthorCode" class="form-control" title="구분 선택" >
										<option value="002" <c:if test="${result.readngAuthorCode eq '002' }">selected</c:if>>보상 투자 성공사례</option>
										<option value="003" <c:if test="${result.readngAuthorCode eq '003' }">selected</c:if>>보상 투자 실패사례</option>
									</select>
							    </div>
							</div> 
							<div class="form-group">
							    <div class="col-sm-2 control-label col-lg-2"><label for="select">제목 <span class="pilsu">필수</span></label></div>
							    <div class="col-sm-9">
							    	<input type="text" id="nttSj" name="nttSj" title="이름 입력" class="form-control" value="${result.nttSj}" placeholder="제목을 입력하세요.">
								</div>
							</div>
							<c:if test="${sessionScope.loginVO.indvdlMberCode eq 'CM00210003'}">
								<div class="form-group">
								    <div class="col-sm-1 control-label"><label for="select">전시여부</label></div>
								    <div class="col-sm-2">
						                <input class="radio-input" type="radio" value="Y"  id='dsply' name='dspyAt' <c:if test="${result.dspyAt eq 'Y'}">checked</c:if> /><label class="radio-inline" for="dsply">전시</label>
										<input class="radio-input" type="radio" value="N" id='noDsply' name='dspyAt' <c:if test="${result.dspyAt eq 'N'}">checked</c:if> /><label class="radio-inline" for="noDsply">미전시</label>
						            </div>
								    <div class="col-sm-1 control-label"><label for="select">삭제여부</label></div>
								    <div class="col-sm-2">
						                <input class="radio-input" type="radio" value="Y"  id='delete' name='delAt' <c:if test="${result.delAt eq 'Y'}">checked</c:if>/><label class="radio-inline" for="delete">삭제</label>
										<input class="radio-input" type="radio" value="N" id='noDelete' name='delAt' <c:if test="${result.delAt eq 'N'}">checked</c:if> /><label class="radio-inline" for="noDelete">미삭제</label>
						            </div>
								    <div class="col-sm-1 control-label" style="display:none"><label for="select">무료여부</label></div>
								    <div class="col-sm-2" style="display:none">
								    	<input class="radio-input" type="radio" value="Y"  id='free' name='freeAt' <c:if test="${result.freeAt eq 'Y'}">checked</c:if> /><label class="radio-inline" for="free">무료</label>
										<input class="radio-input" type="radio" value="N" id='pay' name='freeAt' <c:if test="${result.freeAt eq 'N'}">checked</c:if> /><label class="radio-inline" for="pay">유료</label>
						            </div>
						            <div class="col-sm-1 control-label"><label for="select">작성일</label></div>
                           			<div class="col-sm-2 search--calendar">
									    <div>
									    	<input type="text" name="frstRegistPnttm" id="frstRegistPnttm" placeholder="작성일" value="<fmt:formatDate  value="${result.frstRegistPnttm}" pattern="yyyy-MM-dd"/>" class="form-control" autocomplete="off"/>
									    	<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
										</div>
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
							<!-- 첨부파일 S --> 
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
										<div class="form-group file_author" style="display:none">
										    <div class="col-sm-2 control-label col-lg-2"><label for="select">첨부파일 권한<span class="pilsu">필수</span></label></div>
										    <div class="col-sm-4">
											    <select name="fileAuthor" class="form-control">
											    	<option value="CM00209998" <c:if test="${atcFile.readingAuthorCode eq 'CM00209998' or atcFile.readingAuthorCode eq null }">selected</c:if>selected>무료</option>
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
							<!-- 첨부파일 E -->
							</div> 
										<!-- 추가 정보사항 -->
										<input type="hidden" name="nttId"  value="${result.nttId}"/>
										<input type="hidden" name="articleNum"  value="${articleNum}"/>
										<input type="hidden" name="bbsId"  value="BBSMSTR_000000000021"/> 
										<input type="hidden" name="answerAt"  value="Y"/>
										<input type="hidden" name="useAt"  value="Y"/>
										<input type="hidden" name="ntcrId"  value="${sessionScope.loginVO.id}"/>
										<input type="hidden" name="ntcrNm"  value="${sessionScope.loginVO.name}"/>  <!--추후 회원 아이디 추가 -->
										<input type="hidden" name=lastUpdusrId  value="${sessionScope.loginVO.id}"/>
										<input type="hidden" name="password"  value="tester"/>
										<input type="hidden" name="bolgId"  value="N"/>
										<input type="hidden" name="noticeAt"  value="N"/> <!-- 공지 여부 -->
	                 	</form>
                   	</div>
                    <div class="board_btm">
                        <div class="btns_area fl_r mo_block">
                            <a class="btn btn-default" onclick="insert();">저장</a>
                            <a class="btn btn-secondary" onclick="window.history.back()">취소</a>
                        </div>
                    </div>
                    
                </div>
				<!-- view : E -->
            <!-- content 영역입니다. -->	
            </div>
        </div>
    </div>
    <!-- layout -->

</body>
<script>
/* 파일 저장 */
$('.save_btn').on('click',function(){
	$('#insertForm').attr("action","<c:url value='/str/strBbsUdt.do'/>");  
	$('#insertForm').submit();
});


</script>
</html>