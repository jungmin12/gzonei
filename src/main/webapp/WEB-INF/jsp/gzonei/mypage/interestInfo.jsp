<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang='ko'>
<head>
<%@ include file="/WEB-INF/jsp/gzonei/layout/header.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/jsp/gzonei/layout/top.jsp" %>

<script>
$(document).ready(function(){
	// 체크박스 전체 선택
	$("#groupList li").on("click", function () {
		debugger;
		$('#groupList input').prop("checked",false);
		setHtmlGroupModify(this);
	});
	
});
function fn_toDevBtn(sn){
	document.subForm.devlopInfoSn.value = sn;
	document.subForm.action = "<c:url value='/map.do'/>";
   	document.subForm.submit();
}

/*********************************************************
 * 그룹별 상세 조회 처리 함수
 ******************************************************** */
function fn_search(sn){
	document.subForm.pageIndex.value = 1;
	document.subForm.upperIntrstThingSn.value = sn;
	document.subForm.action = "<c:url value='/mypage/interestList.do'/>";
   	document.subForm.submit();
}
/*********************************************************
 * 개발사업 상세 조회 처리 함수
 ******************************************************** */
function fn_detail_mber(id){
	document.subForm.emplyrId.value = id;
	document.subForm.action = "<c:url value='/admin/member/memberView.do'/>";
	document.subForm.submit();
}
/*********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_select_linkPage(pageNo){
	document.subForm.pageIndex.value = pageNo;
	document.subForm.action = "<c:url value='/mypage/interestList.do'/>";
   	document.subForm.submit();
}
/*********************************************************
 * 선택정보 삭제
 ******************************************************** */
function fn_delInfo(){
var chkObj = document.getElementsByName("INTER_PROD_SEQ");
	
	var chkCnt = 0;
	for (var i = 0; i < chkObj.length; i++) {
		if (chkObj[i].checked) {
			chkCnt ++;
		}
	}
	
	if (chkCnt == 0) {
		Common.Dialog.alert({
            content: '삭제할 관심정보를 선택해 주세요'
            ,ok : function(){
            }
        }); 
		return;
	}	
	$.ajax({
		type:"POST",
		url:"<c:url value='/mypage/interestProdDel.do' />",
		data:$('#subForm').serialize(),
		dataType:'json',
		async:false,
		success:function(data){
			if (data.result > 0) {
				Common.Dialog.alert({
                   content: '관심정보가 삭제되었습니다.'
                    ,ok : function(){
						document.location.reload();
                    }
                }); 
				
			}
			else {
				Common.Dialog.alert({
	                   content: '관심정보 삭제 처리에 실패했습니다.'
	                    ,ok : function(){
							document.location.reload();
	                    }
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
function addGroup(id) {
    var interGroupNm = $('#interGroupNm').val().trim();

	if (interGroupNm == '') {
		Common.Dialog.alert({
            content: '그룹명을 입력해 주세요.'
            ,ok : function(){
        		return false;
            }
        });
		return;
	}	
	$.ajax({
		type:"POST",
		url:"<c:url value='/mypage/interestGroupAdd.do' />",
		data:{ "userId" : id, "interGroupNm" : interGroupNm},
		dataType:'json',
		async:false,
		success:function(data){
			if (data.result == 'SUCCESS') {
				Common.Dialog.alert({
		            content: '그룹이 추가되었습니다.'
		            ,ok : function(){
		            	document.location.reload(); 
		        		return false;
		            }
		        });
				$('#modifyGroup').hide();
			}
			else if (data.result == 'GROUP_CNT_OVER') {
				Common.Dialog.alert({
		            content: '그룹추가 최대개수는 5개까지 입니다.'
		            ,ok : function(){
		            	$('#interGroupNm').val("");
		            	$('#modifyGroup').show();
		        		return false;
		            }
		        });
				$('#modifyGroup').hide();
			}
			else {
				Common.Dialog.alert({
		            content: '그룹추가에 실패했습니다.'
		            ,ok : function(){
		            	$('#interGroupNm').val("");
		            	$('#modifyGroup').show();
		        		return false;
		            }
		        });
				$('#modifyGroup').hide();
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
function modifyGroup() {
    var interGroupNm = $('#interGroupNm').val().trim();
    var id = $("#userId").val();
    var uuid = $("#uuid").val();
	debugger;
	if (interGroupNm == '') {
		Common.Dialog.alert({
            content: '그룹명을 입력해 주세요.'
            ,ok : function(){
        		return false;
            }
        });
		return;
	}	
	
	$.ajax({
		type:"POST",
		url:"<c:url value='/mypage/updateInterProdGrpNm.do' />",
		data:{ "userId" : id, "interGroupNm" : interGroupNm, "uuid" : uuid},
		dataType:'json',
		async:false,
		success:function(data){
			if (data.result == 'SUCCESS') {
				Common.Dialog.alert({
		            content: '그룹이 수정되었습니다.'
		            ,ok : function(){
		            	document.location.reload(); 
		        		return false;
		            }
		        });
				$('#modifyGroup').hide();
			}
			else {
				Common.Dialog.alert({
		            content: '그룹수정에 실패했습니다.'
		            ,ok : function(){
		            	$('#interGroupNm').val("");
		            	$('#modifyGroup').show();
		        		return false;
		            }
		        });
				$('#modifyGroup').hide();
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
function delGroup() {
    var id = $("#userId").val();
    var uuid = $("#uuid").val();
	var interGroupNm = $('#interGroupNm').val().trim();
	if (interGroupNm == '') {
		Common.Dialog.alert({
            content: '삭제할 그룹명을 선택해주세요.'
            ,ok : function(){
        		return false;
            }
        });
		return;
	}	
	
	$.ajax({
		type:"POST",
		url:"<c:url value='/mypage/deleteInterProdGrpNm.do' />",
		data:{ "userId" : id, "interGroupNm" : interGroupNm, "uuid" : uuid},
		dataType:'json',
		async:false,
		success:function(data){
			if (data.result == 'SUCCESS') {
				Common.Dialog.alert({
		            content: '그룹이 삭제되었습니다.'
		            ,ok : function(){
		            	document.location.reload(); 
		        		return false;
		            }
		        });
				$('#modifyGroup').hide();
			}
			else {
				Common.Dialog.alert({
		            content: '그룹삭제에 실패했습니다.'
		            ,ok : function(){
		            	$('#interGroupNm').val("");
		            	$('#modifyGroup').show();
		        		return false;
		            }
		        });
				$('#modifyGroup').hide();
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
function setHtmlGroupAdd() {
	$('#groupList input').prop("checked",false);
	var id = $("#userId").val();
	document.getElementById("group_modify").innerHTML = '';
	document.getElementById("group_title").innerHTML = '';
	var html = '<input type="text" name="interGroupNm" id="interGroupNm" class="form-control">';
    html += '<button type="button" class="btn btn-default" onclick="javascript:addGroup(\''+id+'\')">추가</button>';
	document.getElementById("group_title").innerHTML = "그룹 추가";
	document.getElementById("group_modify").innerHTML = html;
}

function setHtmlGroupModify(obj) {
	var id = $("#userId").val();
	$(obj).children('input').prop("checked",true);
	var uuid = $(obj).children('input').prop("value");
	var selText = $(obj).children('label')[0].innerHTML;
	document.getElementById("group_modify").innerHTML = '';
	document.getElementById("group_title").innerHTML = '';
	var html = '<input type="text" name="interGroupNm" id="interGroupNm" class="form-control" value="'+selText+'">';
	html += '<input type="hidden" name="interGroupNm" id="uuid"  value="'+uuid+'">';
    html += '<button type="button" class="btn btn-default" onclick="javascript:modifyGroup()">수정</button>';
	document.getElementById("group_title").innerHTML = "그룹 편집";
	document.getElementById("group_modify").innerHTML = html;

}
</script>
<!-- 구현부 : S -->

<div id="body_layout">	
    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
            <div id="location" class="title_wrap">
                <h2 class="page__title">나의관심정보</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="<c:url value='/mypage/modifyMyInfo.do'/>">마이페이지</a></li>
                        <li class="n3"><a href="<c:url value='/mypage/interestList.do'/>" class="navi_ov">나의관심정보</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">
            <!-- content 영역입니다. -->
			<p>회원님께서 관심있게 보신 개발정보를 그룹으로 묶어 관리하실 수 있습니다. 
			<!-- <br>관심정보는 3개월간 저장됩니다. -->
			</p>
			<div class="group_wrap">
			    <div class="left">
			        <h2 class="h2">그룹 관리</h2>
			        <!-- 팝업1:S -->
<%-- 			        onClick="javascript:fn_modifyGroup('${sessionScope.loginVO.id}')" --%>
			        <div class="layer-button">
			            <button type="button" class="bt" data-button="modal" data-target="#modifyGroup" data-width="auto">
			                추가/수정
			            </button>
			        </div>
			        <div class="modal" id="modifyGroup" tabindex="0" role="dialog">
			            <div class="modal__body">
			                <div class="modal__content">
			                    <h2 class="h2">관심정보 그룹 추가/삭제</h2>
			                    <strong id="group_title">그룹 추가</strong>
			                  	<input type="hidden" id="userId" value="${sessionScope.loginVO.id}">
			                    <div class="form-group" id="group_modify">
			                        <input type="text" name="interGroupNm" id="interGroupNm" class="form-control">
			                        <button type="button" class="btn btn-default" onclick="javascript:addGroup('${sessionScope.loginVO.id}')">추가</button>
			                    </div>
			                    <strong>그룹 삭제</strong>
			                    <div class="scroll">
			                        <ul id="groupList">
			                        	<c:forEach items="${groupList}" var="group" varStatus="status">
			                        		<c:if test="${group.intrstThingSn ne null}">
			                        			<li><input type="checkbox" id="group${status.index}" name="" value="${group.intrstThingSn}"><label class="checkbox-inline" for="group${status.index}">${group.intrstGroupNm}</label></li>
			                        		</c:if>
							        	</c:forEach>
			                        </ul>
			                    </div>
			                    <div class="right">
			                        <button type="button" class="btn btn-default" onclick="javascript:setHtmlGroupAdd()">새그룹 추가</button>
			                        <button type="button" class="btn btn-default" onclick="javascript:delGroup()">그룹 삭제</button>
			                    </div>
			                </div>
			                <div class="modal__close">
			                    <button type="button" data-close="modal" class="modal__close-button">
			                        <span>닫기</span>
			                    </button>
			                </div>
			            </div>
			        </div>
			        <!-- 팝업1:E -->
			        <ul>
			        	<c:forEach items="${groupList}" var="group" varStatus="status">
			        		<c:if test="${searchVO.upperIntrstThingSn == null or searchVO.upperIntrstThingSn == ''}">
				            <li <c:if test="${status.index == 0}">class="on"</c:if>><a href="javascript:fn_search('${group.intrstThingSn}')">${group.intrstGroupNm} (${group.interProdCnt }건)</a></li>
				            </c:if>
			        		<c:if test="${!(searchVO.upperIntrstThingSn == null or searchVO.upperIntrstThingSn == '')}">
				            <li <c:if test="${searchVO.upperIntrstThingSn == group.intrstThingSn}">class="on"</c:if>><a href="javascript:fn_search('${group.intrstThingSn}')">${group.intrstGroupNm} (${group.interProdCnt }건)</a></li>
				            </c:if>
			        	</c:forEach>
			        </ul>
			    </div>
			    <div class="right">
			    <form name="subForm" id="subForm" method="post" action="<c:url value='/mypage/interestList.do'/>">
			    <input name="userId" type="hidden" value="${sessionScope.loginVO.id}">
				<input name="upperIntrstThingSn" type="hidden" value="${searchVO.upperIntrstThingSn} }">
				<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
			        <h2 class="h2">그룹 조회 내역</h2>
			        <a class="bt" href="javascript:fn_delInfo()">선택삭제</a>
			        <div class="wrap">
			        <c:choose>
						<c:when test="${infoList == null or fn:length(infoList) == 0 }">
							<div class="box">
				                <label>
				                    <strong>조회된 내역이 없습니다.</strong>
				                </label>
				            	</div>
						</c:when>
						<c:otherwise>
							<input type="hidden" name="devlopInfoSn" value=""/>
							<c:forEach items="${infoList}" var="result" varStatus="status">
					            <div class="box">
				                <input type="checkbox" name="INTER_PROD_SEQ" id="checkbox${status.index}" value="${result.intrstThingSn}">
				                
				                <label for="checkbox${status.index}">
				                    <strong>${result.dwkNm}</strong>
				                    <ul>
				                        <li>사업지구 : ${result.bsnsDstrc}</li>
				                        <li>시행사 : ${result.opertnCmpny}</li>
				                        <li>사업방식 :  ${result.bsnsMthd}</li>
				                        <li><a id="${result.devlopInfoSn}" class="bt toDevBtn" href="javascript:fn_toDevBtn('${result.devlopInfoSn}')">개발정보 보러가기</a></li>
				                    </ul>
				                    <em>${result.regDate }</em>
				                </label>
				            	</div>
				        	</c:forEach>
						</c:otherwise>
					</c:choose>
			        </div>
			        <!-- Paging : S -->
				<div class="pagination-inner">
					<ul class="pagination">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_linkPage"/>
					</ul>
                </div>
				<!-- Paging : E -->
				</form>
			    </div>
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
