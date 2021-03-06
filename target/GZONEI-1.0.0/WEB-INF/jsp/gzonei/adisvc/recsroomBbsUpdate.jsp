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

</head>

<body topmargin="0" leftmargin="0">
<%@ include file="/WEB-INF/jsp/gzonei/layout/top.jsp" %>
<script>
/*********************************************************
 * 승인상태 변경 함수
 ******************************************************** */
function fn_memberConfirm(id, name){
	 if(checkAuth("adm003001", "infoUpdtAt","")){
		 
		Common.Dialog.confirm({
	        title: '승인',
	        content: name +'('+id+ ') 회원을(를) 승인하시겠습니까?'
	        ,ok: function(){
	        	$.ajax({
	        		type:"POST",
	        		url:"<c:url value='/admin/member/memberConfirm.do' />",
	        		data:{ "emplyrId" : id	},
	        		dataType:'json',
	        		async:false,
	        		success:function(data){
	        			if (data.result > 0) {
	        				Common.Dialog.alert({
			                    title: '승인'
			                    ,content: '승인처리 되었습니다.'
			                    ,ok : function(){
			                    	fn_search();
			                    }
			                }); 
	        			}
	        			else {
	        				Common.Dialog.alert({
			                    title: '승인'
			                    ,content: '승인처리에 실패했습니다.'
			                }); 
	        			}
	        		}
	        		,error : function(e) {alert("관리자에게 문의바랍니다.");}
	        		,beforeSend:function(){
	    				//전송 전
	    				$('.wrap-loading').removeClass('display-none');	
	    		    }
	    		    ,complete:function(){
	    		        //전송 후
	    		    	$('.wrap-loading').addClass('display-none');
	    		    }
	        	    
	        	});
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

				<form name="insertForm" method="post" enctype="multipart/form-data">
					<div class="form-horizontal bucket-form">
						<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2">
								<label for="select">구분 <span class="pilsu">필수</span></label>
							</div>
							<div class="col-sm-4">
								<select id="detailSeCode" name="detailSeCode" class="form-control" title="구분 선택" required="">
									<option value="">구분선택</option>
									<option value="">선택 없음</option>
										<c:if test="${!empty devInfoList}">
											<c:forEach var="list" items="${devInfoList}" varStatus="status">
												<option value="${list.codeId}" <c:if test="${result.detailSeCode eq list.codeId }">selected</c:if>><c:out value="${list.codeIdNm}"/></option>
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
 									<option value="bbs009002" <c:if test="${result.readngAuthorCode eq 'bbs009002' }">selected</c:if>>1레벨</option>
									<option value="bbs009003" <c:if test="${result.readngAuthorCode eq 'bbs009003' }">selected</c:if>>2레벨</option>
									<option value="bbs009004" <c:if test="${result.readngAuthorCode eq 'bbs009004' }">selected</c:if>>3레벨</option>
<%-- 									<option value="CM00209998" <c:if test="${result.readngAuthorCode eq 'CM00209998' }">selected</c:if>>무료</option> --%>
<%-- 									<option value="CM00200005" <c:if test="${result.readngAuthorCode eq 'CM00200005' }">selected</c:if>>실버(이코노미)</option> --%>
<%-- 									<option value="CM00200006" <c:if test="${result.readngAuthorCode eq 'CM00200006' }">selected</c:if>>실버(스페셜)</option> --%>
<%-- 									<option value="CM00200007" <c:if test="${result.readngAuthorCode eq 'CM00200007' or result.readngAuthorCode eq 'CM00200001'}">selected</c:if>>골드(이코노미)</option> --%>
<%-- 									<option value="CM00200008" <c:if test="${result.readngAuthorCode eq 'CM00200008' or result.readngAuthorCode eq 'CM00200003'}">selected</c:if>>골드(비즈니스)</option> --%>
<%-- 									<option value="CM00200009" <c:if test="${result.readngAuthorCode eq 'CM00200009' }">selected</c:if>>골드(스페셜)</option> --%>
<%-- 									<option value="CM00200010" <c:if test="${result.readngAuthorCode eq 'CM00200010' or result.readngAuthorCode eq 'CM00200002'}">selected</c:if>>프리미엄(이코노미)</option> --%>
<%-- 									<option value="CM00200011" <c:if test="${result.readngAuthorCode eq 'CM00200011' or result.readngAuthorCode eq 'CM00200004'}">selected</c:if>>프리미엄(스페셜)</option> --%>
								</select>
							</div>
						</div>
						
						
					<div class="form-group">
						<div class="col-sm-2 control-label col-lg-2">
							<label for="select">제목 <span class="pilsu">필수</span></label>
						</div>
						<div class="col-sm-9">
							<input type="text" id="nttSj" name="nttSj" title="제목 입력" class="form-control" value="${result.nttSj }">
						</div>
					</div>
					
					<div class="form-group">
						<c:if test="${sessionScope.authVO.bbs009001.infoDspyAt eq 'N' }">
	                        <div class="col-sm-1 control-label" style="display:none"><label for="select">전시여부</label></div>
	                        <div class="col-sm-2" style="display:none">
		                        <input class="radio-input" type="radio" value="Y"  id='dsply' name='dspyAt' <c:if test="${result.dspyAt eq 'Y'}">checked</c:if> /><label class="radio-inline" for="dsply">전시</label>
	                        	<input class="radio-input" type="radio" value="N" id='noDsply' name='dspyAt'<c:if test="${result.dspyAt eq 'N'}">checked</c:if> /><label class="radio-inline" for="noDsply">미전시</label>
	                        </div>
                        </c:if>
						<c:if test="${sessionScope.authVO.bbs009001.infoDspyAt eq 'Y' }">
	                        <div class="col-sm-1 control-label"><label for="select">전시여부</label></div>
	                        <div class="col-sm-2">
	                        	<input class="radio-input" type="radio" value="Y"  id='dsply' name='dspyAt' <c:if test="${result.dspyAt eq 'Y'}">checked</c:if> /><label class="radio-inline" for="dsply">전시</label>
	                        	<input class="radio-input" type="radio" value="N" id='noDsply' name='dspyAt'<c:if test="${result.dspyAt eq 'N'}">checked</c:if> /><label class="radio-inline" for="noDsply">미전시</label>
	                        </div>
                        </c:if>
                        <div class="col-sm-1 control-label"><label for="select">삭제여부</label></div>
                        <div class="col-sm-2">
                            <input class="radio-input" type="radio" value="Y"  id='delete' name='delAt'  <c:if test="${result.delAt eq 'Y'}">checked</c:if> /><label class="radio-inline" for="delete">삭제</label>
                        	<input class="radio-input" type="radio" value="N" id='noDelete' name='delAt' <c:if test="${result.delAt eq 'N'}">checked</c:if>/><label class="radio-inline" for="noDelete">미삭제</label>
                        </div>
                        <div class="col-sm-2 control-label col-lg-2" style="display:none"><div class="label">사용여부</div></div>
                        <div class="col-sm-2" style="display:none">
                        	<input class="radio-input" type="radio" value="Y"  id='use' name='useAt' <c:if test="${result.useAt eq 'Y'}">checked</c:if> /><label class="radio-inline" for="use">사용</label>
                        	<input class="radio-input" type="radio" value="N" id='disuse' name='useAt' <c:if test="${result.useAt eq 'N'}">checked</c:if> /><label class="radio-inline" for="disuse">미사용</label>
                        </div>
                   		<div class="col-sm-1 control-label"><label for="select">작성일</label></div>
                        <div class="col-sm-2 search--calendar">
						    <div>
						    	<input type="text" name="frstRegistPnttm" id="frstRegistPnttm" placeholder="작성일" value="<fmt:formatDate  value="${result.frstRegistPnttm}" pattern="yyyy-MM-dd"/>" class="form-control" autocomplete="off"/>
						    	<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
							</div>
						</div>
                   	</div>
					
					<div class="form-group">
						<div class="col-sm-12">
							<textarea class="form-control" id="nttCn" name="nttCn" title="내용 입력" rows="100">${result.nttCn}</textarea>
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
								<div class="form-group file_author">
								    <div class="col-sm-2 control-label col-lg-2"><label for="select">첨부파일 권한<span class="pilsu">필수</span></label></div>
								    <div class="col-sm-4">
									    <select name="fileAuthor" class="form-control">
		 									<option value="bbs009005" <c:if test="${atcFile.readingAuthorCode eq 'bbs009005'}">selected</c:if>>1레벨</option>
											<option value="bbs009006" <c:if test="${atcFile.readingAuthorCode eq 'bbs009006'}">selected</c:if>>2레벨</option>
											<option value="bbs009007" <c:if test="${atcFile.readingAuthorCode eq 'bbs009007'}">selected</c:if>>3레벨</option>
									    	
<!-- 									    	<option value="">---권한 설정---</option> -->
<%-- 									    	<option value="CM00209998" <c:if test="${atcFile.readingAuthorCode eq 'CM00209998' or atcFile.readingAuthorCode eq null }">selected</c:if>>무료</option> --%>
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
							<a href="#" class="btn btn-default" onclick="insert()">수정</a>
							<a href="#" class="btn btn-secondary" onclick="window.history.back()">취소</a>
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
/* 파일 저장 */
$('.save_btn').on('click',function(){
	$('#insertForm').attr("action","<c:url value='/adisvc/recsroomUpdateBbs.do'/>");  
	$('#insertForm').submit();
});
/* 첨부파일 삭제*/
$('.file_del_btn').on('click',function(){
	if (confirm("첨부파일을 삭제하시겠습니까?") == true){    //확인
		var parent = $(this).parent().parent();
		var fileSn = $(this).nextAll('.fileSn').val();
		var atchFileId = $('input[name=atchFileId]').val(); 
// 		$(parent).remove();
		


		/* $.ajax({
			type: "POST",
			data: {
				atchFileId: atchFileId,
				fileSn: fileSn
			},
			url: "<c:url value='/str/deleteAtchFile.do'/>",
			success: function(data) {
				alert('첨부파일을 삭제하였습니다.');
			}
		});  */
	}else{return;}
});

function insert() {
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
	
	
//		if (document.insertForm.nttCn.value == '') {
	if (CKEDITOR.instances.nttCn.getData() == '') {
		Common.Dialog.alert({
            content: '내용을 입력해주세요.'
            ,ok : function(){
				$('#nttCn').focus();
            }
        });
		return false;
	}
	
    Common.Dialog.confirm({
        title: '수정',
        content: '현재 게시글을 수정하시겠습니까?'
        ,ok: function(){
        	document.insertForm.action="<c:url value='/adisvc/recsroomUpdateBbs.do'/>";
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
