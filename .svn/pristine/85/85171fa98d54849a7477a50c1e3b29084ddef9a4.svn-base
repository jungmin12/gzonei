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
<%@ include file="/WEB-INF/jsp/gzonei/layout/admintop.jsp" %>


	<!-- header -->
	<script>
		function cancel() {
			document.location="<c:url value='/oper/viewBbsDetail.do?nttId=${result.nttId}&pageIndex=1&articleNum=3'/>";
		}
	</script>
	
	
<div id="body_layout">	
	
	<!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
            <div id="location" class="title_wrap">
                <h2 class="page__title">결재 업무 게시판</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do' />">HOME</a></li>
                        <li class="n3"><a href="<c:url value='/oper/viewBbsList.do'/>" class="navi_ov">결재 업무 게시판</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">
            <!-- content 영역입니다. -->
			<!-- view : S -->
			<div class="board_view_in">

				<form name="insertForm" method="post" enctype="multipart/form-data">
					<div class="form-horizontal bucket-form">
<!-- 						<div class="form-group"> -->
<!-- 							<div class="col-sm-2 control-label col-lg-2"> -->
<!-- 								<label for="select">구분 <span class="pilsu">필수</span></label> -->
<!-- 							</div> -->
<!-- 							<div class="col-sm-4"> -->
<!-- 								<select id="bbsTabCode" name="bbsTabCode" class="form-control" title="구분 선택" required=""> -->
<%-- 									<option value="" <c:if test="${result.bbsTabCode == null }">selected</c:if>>말머리 선택</option> --%>
<%-- 									<option value="penalty" <c:if test="${result.bbsTabCode eq 'penalty' }">selected</c:if>>패널티</option> --%>
<%-- 									<option value="nameChnge" <c:if test="${result.bbsTabCode eq 'nameChnge' }">selected</c:if>>이름변경</option> --%>
<%-- 									<option value="unrgstr" <c:if test="${result.bbsTabCode eq 'unrgstr' }">selected</c:if>>탈퇴신청</option> --%>
<!-- 								</select> -->
<!-- 							</div> -->
<!-- 						</div> -->
						
						
						
						<div class="form-group">
						<div class="col-sm-2 control-label col-lg-2">
							<div class="label">
								제목 <span class="pilsu">필수</span>
							</div>
						</div>
						<div class="col-sm-9">
<%-- 							<input type="text" id="nttSj" name="nttSj" title="제목 입력" class="form-control" value="${result.nttSj }" required /> --%>
							<input type="text" id="nttSj" name="nttSj" title="이름 입력" class="form-control" required value="<c:out value='${result.nttSj }'/>">
						</div>
					</div>
						
					
<!-- 					<div class="form-group"> -->
<%-- 						<c:if test="${sessionScope.authVO.adm001002.infoDspyAt eq 'Y'}">	 --%>
<!--                             <div class="col-sm-2 control-label"><div class="label">전시여부</div></div> -->
<!--                             <div class="col-sm-2"> -->
<%--                                 <input class="radio-input" type="radio" value="Y"  id='dsply' name='dspyAt' <c:if test="${result.dspyAt eq 'Y'}">checked</c:if> /><label class="radio-inline" for="dsply" >전시</label> --%>
<%--                               	<input class="radio-input" type="radio" value="N" id='noDsply' name='dspyAt' <c:if test="${result.dspyAt eq 'N'}">checked</c:if> /><label class="radio-inline" for="noDsply">미전시</label> --%>
<!--                             </div> -->
<%--                         </c:if>     --%>
<%--                        	<c:if test="${sessionScope.authVO.adm001002.infoDelAt eq 'Y'}">	 --%>
<!--                             <div class="col-sm-2 control-label"><div class="label">삭제여부</div></div> -->
<!--                        		<div class="col-sm-2"> -->
<%--                             	<input class="radio-input" type="radio" value="Y"  id='delete' name='delAt'  <c:if test="${result.delAt eq 'Y'}">checked</c:if> /><label class="radio-inline" for="delete">삭제</label> --%>
<%--                           		<input class="radio-input" type="radio" value="N" id='noDelete' name='delAt' <c:if test="${result.delAt eq 'N'}">checked</c:if>/><label class="radio-inline" for="noDelete">미삭제</label> --%>
<!--                           	</div> -->
<!-- 						<div class="col-sm-2 control-label col-lg-2"> -->
<!-- 							<div class="label"> -->
<!-- 								공지여부 <span class="pilsu">필수</span> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="col-sm-2"> -->
<!-- 							<div class="label-text"><input type="checkbox"  value="Y" name=noticeAt>공지</div> -->
<!-- 						</div> -->
<%-- 						</c:if> --%>
<!-- 					</div> -->
					
					<div class="form-group">
						<div class="col-sm-12">
							<textarea class="form-control" id="nttCn" name="nttCn" title="내용 입력" rows="100" required="required">${result.nttCn}</textarea>
							<script type="text/javascript" src="<c:url value='/js/gzonei/ckeditor_custom_config.js'/>"></script>
						</div>
					</div>
					
					<!-- 첨부파일 S  -->
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
								</c:forEach>
								<div class="file-button">
									<button type="button" class="addFileOper">추가</button>
									<button type="button" class="delFile">삭제</button>
								</div>
							</div>
					    </div>
					</div>
					<!-- 첨부파일 E -->
						
				</div>
							
				<input type="hidden" name="nttId"  value="${result.nttId}"/>
					<input type="hidden" name="bbsId"  value="${result.bbsId}"/>
 					<input type="hidden" name="answerAt"  value="${result.answerAt}"/>
 					<input type="hidden" name="dspyAt"  value="${result.dspyAt}"/>
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
					<input type="hidden" name="useAt"  value="${result.useAt}"/>
					<input type="hidden" name="ntcrId"  value="${result.ntcrId}"/>
					<input type="hidden" name="ntcrNm"  value="${result.ntcrNm}"/> 
					<input type="hidden" name="frstRegisterId"  value="${result.frstRegisterId}"/>
					<input type="hidden" name="password"  value="${result.password}"/>
					<input type="hidden" name="secretAt"  value="${result.secretAt}"/>
					<input type="hidden" name="lastUpdtPnttm"  value="${result.lastUpdtPnttm}"/>
					<input type="hidden" name="lastUpdusrId"  value="${result.lastUpdusrId}"/>
					<input type="hidden" name="bolgId"  value="${result.bolgId}"/>
					<input type="hidden" name="delAt"  value="${result.delAt}"/>
					<input type="hidden" name="trgamt"  value="${result.trgamt}"/>
					<input type="hidden" name="lc"  value="${result.lc}"/>
					<input type="hidden" name="dwkNm"  value="${result.dwkNm}"/>
					<input type="hidden" name="freeAt"  value="${result.freeAt}"/>
					<input type="hidden" name="nsprcCode"  value="${result.nsprcCode}"/>
					<input type="hidden" name="nsprcNm"  value="${result.nsprcNm}"/>
					<input type="hidden" name="articleDe"  value="${result.articleDe}"/> 


					<div class="board_btm">
                        <div class="btns_area fl_r mo_block">
<!--                 			<input class="btn btn-default" type='submit' value='수정 '/> -->
							<a href="#" class="btn btn-default" onclick="insert();">수정</a>
							<a href="#" class="btn btn-secondary" onclick="window.history.back();">취소</a>
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
function insert() {
    Common.Dialog.confirm({
        title: '수정',
        content: '현재 게시글을 수정하시겠습니까?'
        ,ok: function(){
        	document.insertForm.action="<c:url value='/oper/updateBbs.do'/>";
			document.insertForm.submit();
        }
        ,cancel : function(){
        	document.location.reload();
        }
    });    
}
</script>

<!-- 구현부 : E -->

<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>
</body>
</html>
