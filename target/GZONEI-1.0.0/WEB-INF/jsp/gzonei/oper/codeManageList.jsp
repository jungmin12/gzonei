<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- 행정안전부 공통서비스 테스트 사이트 -->
<script language="javascript" src="<c:url value='/js/gzonei/jquery-3.5.1.js' />"></script>
<%@ include file="/WEB-INF/jsp/gzonei/layout/header.jsp" %>

<style>
	* {
	box-sizing: border-box;
	}
    .table_wrap {
        overflow: auto;
    }
    #upperCodeTb th,#upperCodeTb td, #codeTb th, #codeTb td{
        width: 20%;
        border-right: 1px solid lightgray;
    }
    #upperCodeTb th, #codeTb th {
        position: sticky;
        top: 0px;
        z-index:5;
        border-bottom: 1px #000 solid;
        border-top: 1px #000 solid;
    }
</style>



</head>
<body topmargin="0" leftmargin="0">
<%@ include file="/WEB-INF/jsp/gzonei/layout/admintop.jsp" %>


<div id="body_layout">	

   <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
            <div id="location" class="title_wrap">
                <h2 class="page__title">코드관리</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do' />">HOME</a></li>
                        <li class="n2"><a href="<c:url value='/oper/groupManage.do'/>" >운영관리</a></li>
                        <li class="n3"><a href="<c:url value='/oper/codeManage.do'/>" class="navi_ov">코드관리</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
<!--                     프린트 시작 -->
<!--                     <ul class="print_wrap setting-box__group"> -->
<!--                         <li id="sns_layout" class="n2"> -->
<!--                             <button data-target="ui-open">SNS공유</button> -->
<!--                             <div class="sns_wrap" data-id="ui-open"> -->
<!--                                 <button data-button="sns_share" data-service="naver" data-title="네이버 SNS공유" title="새창열림" target="_blank"><span class="sr-only">네이버 SNS</span>공유하기</button> -->
<!--                                 <button data-button="sns_share" data-service="facebook" data-title="페이스북 SNS공유" title="새창열림" target="_blank"><span class="sr-only">페이스북 SNS </span>공유하기</button> -->
<!--                                 <button data-target="ui-close">닫기</button> -->
<!--                             </div> -->
<!--                         </li>                     -->
<!--                         <li class="n1" id="print"><button data-print="print">프린트</button></li> -->
<!--                     </ul> -->
<!--                     프린트 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">
	          	
	          	
	        	<div class="p-row">
		        	<div class="p-col-12 p-col-sm-24">
			        	<h2 class="h2">대분류 목록</h2>
		             	<div class="board_btm2">
		                    	<div class="btns_area fl_r mo_block" style="display:none" id="newUpCdDv">
		                        	<a href="#n" class="btn btn-default btn-sm" id="newUpCd">신규</a>
<!-- 		                        <a href="#" class="btn btn-secondary btn-sm">미사용</a> -->
			                    </div>
		                </div>
		                <div class="table_wrap table_scroll">
			                <table class="table_info" id="upperCodeTb">
		                        <thead>
		                            <tr>
<!-- 		                                <th>선택</th> -->
		                                <th style="width: 116px;">대분류코드</th>
		                                <th style="width: 135px;">대분류코드명</th>
		                                <th>코드설명</th>
		                                <th style="width: 102px;">사용여부</th>
		                                <th style="width: 102px;">삭제여부</th>
		                                <th>최종수정일</th>
		                            </tr>
		                        </thead>
		                        <tbody id="upCdTb">
		                        	<c:forEach var="list" items="${upperCodeList}">
			                        	<tr>
<!-- 			                                <td><input class="checkbox-input" type="checkbox" id="checkbox1" name="" title="선택" value="a"></td> -->
			                                <td><c:out value="${list.codeId}"/></td>
			                                <td class="subject"><c:out value="${list.codeIdNm}"/></td>
			                                <td><c:out value="${list.codeDc}"/></td>
			                                <td><c:out value="${list.useAt}"/></td>
			                                <td><c:out value="${list.delAt}"/></td>
			                                <td><fmt:formatDate pattern="yyyy-MM-dd" value="${list.lastUpdtPnttm }"/></td>
			                            </tr>
	                            	</c:forEach>
		                        </tbody>
			                </table>
		                </div>
		        	</div>
		        	
		        	
		        	<div class="p-col-12 p-col-sm-24">
			        	<h2 class="h2">소분류 목록</h2>
		             	<div class="board_btm2">
		                    <div class="btns_area fl_r mo_block" style="display:none" id="newLwCdDv">
		                        <a href="#n" class="btn btn-default btn-sm" id="newCd">신규</a>
<!-- 		                        <a href="#" class="btn btn-secondary btn-sm">미사용</a> -->
		                    </div>
		                </div>
		                <div class="table_wrap table_scroll">
			                <table class="table_info" id="codeTb">
		                        <thead>
		                            <tr>
<!-- 		                                <th>선택</th> -->
		                                <th style="width: 116px;">소분류코드</th>
		                                <th style="width: 135px;">소분류코드명</th>
		                                <th>코드설명</th>
		                                <th style="width: 102px;">사용여부</th>
		                                <th style="width: 102px;">삭제여부</th>
		                                <th>최종수정일</th>
		                            </tr>
		                        </thead>
		                        <tbody id="lwCdTb">
		                        </tbody>
			                </table>
		                </div>
		        	</div>
		        	
		        	
		        	
		        	
		        	<div class="p-col-12 p-col-sm-24">
				        <h2 class="h2">대분류 정보</h2>
				        <div class="table_wrap">
	                    	<table class="table_info" id="upCd">
		                    	<tbody>
			                    	<tr>
				                    	<th>대분류코드명</th>
				                    	<td><input type="text" id="upperCodeNm" name="upperCodeNm" title="" class="form-control" value=""></td>
			                    	</tr>
			                    	<tr>
				                    	<th>대분류코드</th>
				                    	<td><input type="text" id="upperCode" name="upperCode" title="" class="form-control" value=""></td>
			                    	</tr>
			                    	<tr>
				                    	<th>대분류설명</th>
				                    	<td><input type="text" id="upperCodeDc" name="upperCodeDc" title="" class="form-control" value=""></td>
			                    	</tr>
			                    	<tr>
				                    	<th>사용여부</th>
				                    	<td>
					                    	 <input class="checkbox-input" type="checkbox" id="upperUseAt" name="upperUseAt" title="사용" >
											 <label class="checkbox-inline" for="upperUseAt">사용</label>
				                    	</td>
			                    	</tr>
			                    	<tr>
				                    	<th>삭제여부</th>
				                    	<td>
					                    	 <input class="checkbox-input" type="checkbox" id="upperDelAt" name="upperDelAt" title="삭제">
											 <label class="checkbox-inline" for="upperDelAt">삭제</label>
				                    	</td>
			                    	</tr>
		                    	</tbody>
	                    	</table>
				        </div>	
				        <div class="board_btm">
	                        <div class="btns_area fl_r mo_block">
	                            <a href="#n" class="btn btn-default" id="updateUpBtn">수정</a>
	                            <a href="#n" class="btn btn-primary" id="saveUpBtn">저장</a>
	                            <a href="#n" class="btn btn-primary" id="insertUpBtn">등록</a>
								<a href="#n" class="btn btn-secondary" id="cancleUpUpBtn">수정취소</a>
								<a href="#n" class="btn btn-secondary" id="cancleInUpBtn">등록취소</a>
	                        </div>
	                    </div>
		        	</div>
		        	
		        	
		        	<div class="p-col-12 p-col-sm-24">
				        <h2 class="h2">소분류 정보</h2>
				        <div class="table_wrap">
	                    	<table class="table_info" id="lwCd">
		                    	<tbody>
			                    
			                    	<tr>
				                    	<th>소분류코드명</th>
				                    	<td><input type="text" id="codeNm" name="codeNm" title="" class="form-control" value=""></td>
			                    	</tr>
			                    	<tr>
				                    	<th>소분류코드</th>
				                    	<td><input type="text" id="code" name="code" title="" class="form-control" value=""></td>
			                    	</tr>
			                    	<tr>
				                    	<th>소분류설명</th>
				                    	<td><input type="text" id="codeDc" name="codeDc" title="" class="form-control" value=""></td>
			                    	</tr>
		                    		<tr>
				                    	<th>사용여부</th>
				                    	<td>
					                    	 <input class="checkbox-input" type="checkbox" id="useAt" name="useAt" title="사용" value="a">
											 <label class="checkbox-inline" for="useAt">사용</label>
				                    	</td>
			                    	</tr>
			                    	<tr>
				                    	<th>삭제여부</th>
				                    	<td>
					                    	 <input class="checkbox-input" type="checkbox" id="delAt" name="delAt" title="삭제" value="a">
											 <label class="checkbox-inline" for="delAt">삭제</label>
				                    	</td>
			                    	</tr>
		                    	</tbody>
	                    	</table>
				        </div>	
				        <div class="board_btm">
	                        <div class="btns_area fl_r mo_block">
	                            <a href="#n" class="btn btn-default" id="updateBtn">수정</a>
	                            <a href="#n" class="btn btn-primary" id="saveBtn">저장</a>
	                            <a href="#n" class="btn btn-primary" id="insertBtn">등록</a>
								<a href="#n" class="btn btn-secondary" id="cancleUpBtn">수정취소</a>
								<a href="#n" class="btn btn-secondary" id="cancleInBtn">등록취소</a>
	                        </div>
	                    </div>
		        	</div>
		        	
	        	</div>
			
            </div>
        </div>
    </div>
    <!-- layout -->
		
	

</div>
<!-- contents -->

<script>
$(document).ready(function(){
	$('#upCd input').attr('disabled', 'disabled');
	$('#lwCd input').attr('disabled', 'disabled');
	
	// 등록버튼 숨김 -- 신규 누르면 보임
	$('#insertUpBtn').hide();
	$('#insertBtn').hide();
	
	// 등록취소버튼 숨김 -- 신규버튼 누르면 보임
	$('#cancleInUpBtn').hide();
	$('#cancleInBtn').hide();
	
	// 모든 수정 관련 버튼 숨김 
	//	대분류
	$('#updateUpBtn').hide();
	$('#saveUpBtn').hide();
	$('#cancleUpUpBtn').hide();
	
	// 소분류
	$('#updateBtn').hide();
	$('#cancleUpBtn').hide();
	$('#saveBtn').hide();
	
	if(checkAuthValue("adm004002", "infoRegistAt") == 'Y'){
		$('#newUpCdDv').show();
		$('#newLwCdDv').show();
	}

	
	
});


// Timestamp Date로 변환
function date_to_str(format){
	
    var year = format.getFullYear();
    var month = format.getMonth() + 1;
    
    if(month<10) month = '0' + month;
    var date = format.getDate();

    if(date<10) date = '0' + date;


    return year + "-" + month + "-" + date;

}




// 대분류
$('#updateUpBtn').click(function(){
	if(checkAuthValue("adm004002", "infoUpdtAt") == 'Y'){
		$('#saveUpBtn').show();
		$('#cancleUpUpBtn').show();
		$('#updateUpBtn').hide();
		
		$('#upCd input').removeAttr('disabled');
		$('#upCd input[name=upperCode]').attr('disabled', 'disabled');
		
		if(checkAuthValue("adm004002", "infoDelAt") == 'N'){
			$('#upCd input[name=upperDelAt]').attr('disabled', 'disabled');
		}
	};
})

// 대분류 수정취소
$('#cancleUpUpBtn').click(function(){
	$('#upCd input').attr('disabled', 'disabled');
	$('#upCdTb tr').css('background-color','');

	$('#updateUpBtn').hide();
	$('#saveUpBtn').hide();
	$('#insertUpBtn').hide();
	$('#cancleUpUpBtn').hide();
	
	$("#lwCdTb").empty();

	$('#upCd input').val('');
	$('#upperUseAt')[0].checked = false;
	$('#upperDelAt')[0].checked = false;
	
	
	// 소분류도 취소
	$('#lwCd input').attr('disabled', 'disabled');
	$('#lwCdTb tr').css('background-color','');

	$('#insertUpBtn').hide();
	$('#cancleUpBtn').hide();
	$('#updateBtn').hide();
	$('#saveBtn').hide();
	
	$('#lwCd input').val('');
	$('#useAt')[0].checked = false;
	$('#delAt')[0].checked = false;
	
	
	
})

// 소분류 수정취소
$('#cancleUpBtn').click(function(){
	$('#lwCd input').attr('disabled', 'disabled');
	$('#lwCdTb tr').css('background-color','');

	$('#insertUpBtn').hide();
	$('#cancleUpBtn').hide();
	$('#updateBtn').hide();
	$('#saveBtn').hide();
	
	$('#lwCd input').val('');
	$('#useAt')[0].checked = false;
	$('#delAt')[0].checked = false;
})





// 대분류 등록취소
$('#cancleInUpBtn').click(function(){
	$('#upCd input').attr('disabled', 'disabled');
	$('#upCdTb tr').css('background-color','');

	$('#cancleInUpBtn').hide();
	$('#cancleUpUpBtn').hide();
	
	$('#updateUpBtn').hide();
	$('#saveUpBtn').hide();
	$('#insertUpBtn').hide();
	
	$("#lwCdTb").empty();

	$('#upCd input').val('');
	$('#upperUseAt')[0].checked = false;
	$('#upperDelAt')[0].checked = false;
})

// 소분류 등록취소
$('#cancleInBtn').click(function(){
	$('#lwCd input').attr('disabled', 'disabled');
	$('#lwCdTb tr').css('background-color','');

	$('#cancleInBtn').hide();
	$('#cancleUpBtn').hide();
	
	$('#updateBtn').hide();
	$('#saveBtn').hide();
	$('#insertBtn').hide();
	

	$('#lwCd input').val('');
	$('#useAt')[0].checked = false;
	$('#delAt')[0].checked = false;
})

// 대분류 신규버튼
$('#newUpCd').click(function(){
	if(checkAuthValue("adm004002", "infoRegistAt") == 'Y'){
		$('#upCd input').removeAttr('disabled');
		$('#upCdTb tr').css('background-color','');
		
		// 신규버튼 클릭시 버튼 변경
		$('#cancleInUpBtn').show();
		$('#cancleUpUpBtn').hide();
		
		$('#updateUpBtn').hide();
		$('#saveUpBtn').hide();
		$('#insertUpBtn').show();
		
		// 대분류 정보 칸 비우기
		$('#upCd input').val('');
		$('#upperUseAt')[0].checked = false;
		$('#upperDelAt')[0].checked = false;
		
		// 소분류 정보 칸 비우기
		$('#lwCd input').val('');
		$('#useAt')[0].checked = false;
		$('#delAt')[0].checked = false;
		
		// 소분류 테이블 비우기
		$("#lwCdTb").empty();
		$('#cancleInBtn').click();
		
	}
});


// 대분류 신규 등록
$('#insertUpBtn').click(function(){

	var upCdNm = $('#upperCodeNm').val();
	var upCd = $('#upperCode').val();
	var upCdDc = $('#upperCodeDc').val();
	
	var upCdUseAt = $('#upperUseAt')[0].checked; // true = Y
	var upCdDelAt = $('#upperDelAt')[0].checked; // true = Y
	
	
	if(upCd.length>10){
		Common.Dialog.alert({
			title: '확인',
            content: '대분류코드를 10글자 이하로 입력해주세요.'
            ,ok : function(){
            	
            	setTimeout(function(){
            	    $('#upperCode').focus();
            	},100);
            }
        });
	}else if(upCdNm.length>200){
		Common.Dialog.alert({
			title: '확인',
            content: '대분류코드명을 짧게 입력해주세요.'
            ,ok : function(){
            	
            	setTimeout(function(){
            	    $('#upperCodeNm').focus();
            	},100);
            }
        });
	}else if(upCdDc.length>500){
		Common.Dialog.alert({
			title: '확인',
            content: '대분류코드설명을 짧게 입력해주세요.'
            ,ok : function(){
            	
            	setTimeout(function(){
            	    $('#upperCodeDc').focus();
            	},100);
            }
        });
	}else{
		Common.Dialog.confirm({
		      title: '저장',
		      content: '대분류 코드를 신규 등록하시겠습니까?',
		      ok: function(){
		      	if(upCd != ''){
					// AJAX 통신 : POST 
					$.ajax({ 
						type : "post", 
						url : "<c:url value='/oper/insertUpCd.do'/>",
						async: false,
						dataType: "text",
				        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
						data : {upCdNm:upCdNm, upCd:upCd, upCdDc:upCdDc, upCdUseAt:upCdUseAt, upCdDelAt:upCdDelAt },
						success : function() { 
							Common.Dialog.alert({
								title: '확인',
								content: '대분류 코드가 등록되었습니다',
								ok: function(){
									// 성공적인 댓글 등록 처리 알림 
									location.reload();
									}
								});
							},
							error : function( jqXHR, textStatus, errorThrown ) {
								alert( jqXHR.status );
								alert( jqXHR.statusText );
								alert( jqXHR.responseText );
								alert( jqXHR.readyState );
								location.reload();
							}
						}); 
					}else{
						Common.Dialog.alert({
							title: '확인',
				            content: '입력 내용을 입력해주세요.'
				            ,ok : function(){
				            	
				            	setTimeout(function(){
				            	    $('#upperCodeNm').focus();
				            	},100);
				            }
				        });
					}
		      	},cancel : function(){
				Common.Dialog.alert({
					title: '확인',
					content: '신규 등록 취소'
					});
				}
			});
	}
	
	
});



//대분류 수정
$('#saveUpBtn').click(function(){
	$('#cancleInBtn').click();

	var upCdNm = $('#upperCodeNm').val();
	var upCdDc = $('#upperCodeDc').val();
	var upCd = $('#upperCode').val();
	
	var upCdUseAt = $('#upperUseAt')[0].checked; // true = Y
	var upCdDelAt = $('#upperDelAt')[0].checked; // true = Y
	
	
	
	if(upCd.length>10){
		Common.Dialog.alert({
			title: '확인',
            content: '대분류코드를 10글자 이하로 입력해주세요.'
            ,ok : function(){
            	
            	setTimeout(function(){
            	    $('#upperCode').focus();
            	},100);
            }
        });
	}else if(upCdNm.length>200){
		Common.Dialog.alert({
			title: '확인',
            content: '대분류코드명을 짧게 입력해주세요.'
            ,ok : function(){
            	
            	setTimeout(function(){
            	    $('#upperCodeNm').focus();
            	},100);
            }
        });
	}else if(upCdDc.length>500){
		Common.Dialog.alert({
			title: '확인',
            content: '대분류코드설명을 짧게 입력해주세요.'
            ,ok : function(){
            	
            	setTimeout(function(){
            	    $('#upperCodeDc').focus();
            	},100);
            }
        });
	}else{
		Common.Dialog.confirm({
		      title: '저장',
		      content: '대분류 코드를 수정하시겠습니까?',
		      ok: function(){
		      	if(upCd != ''){
				// AJAX 통신 : POST 
				$.ajax({ 
					type : "post", 
					url : "<c:url value='/oper/updateUpCd.do'/>",
					async: false,
					dataType: "text",
			        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
					data : {upCdNm:upCdNm, upCd:upCd, upCdDc:upCdDc, upCdUseAt:upCdUseAt, upCdDelAt:upCdDelAt },
					success : function() { 
						Common.Dialog.alert({
							title: '확인',
							content: '대분류 코드가 수정되었습니다',
							ok: function(){
								// 성공적인 댓글 등록 처리 알림 
								location.reload();
								}
							});
						},
						error : function( jqXHR, textStatus, errorThrown ) {
							alert( jqXHR.status );
							alert( jqXHR.statusText );
							alert( jqXHR.responseText );
							alert( jqXHR.readyState );
							location.reload();
						}
					}); 
				}else{
					Common.Dialog.alert({
						title: '확인',
			            content: '입력 내용을 입력해주세요.'
			            ,ok : function(){
			            	
			            	setTimeout(function(){
			            	    $('#upperCodeNm').focus();
			            	},100);
			            }
			        });
				}
		      	},cancel : function(){
				Common.Dialog.alert({
					title: '확인',
					content: '대분류 수정 취소'
					});
				}
			});
	}
});




//소분류 수정
$('#saveBtn').click(function(){

	var lwCdNm = $('#codeNm').val();
	var lwCdDc = $('#codeDc').val();
	var lwCd = $('#code').val();
	var upCd = $('#upperCode').val();

	var lwCdUseAt = $('#useAt')[0].checked; // true = Y
	var lwCdDelAt = $('#delAt')[0].checked; // true = Y
	
	
	if(lwCd.length>10){
		Common.Dialog.alert({
			title: '확인',
            content: '소분류코드를 10글자 이하로 입력해주세요.'
            ,ok : function(){
            	
            	setTimeout(function(){
            	    $('#code').focus();
            	},100);
            }
        });
	}else if(lwCdNm.length>200){
		Common.Dialog.alert({
			title: '확인',
            content: '소분류코드명을 짧게 입력해주세요.'
            ,ok : function(){
            	
            	setTimeout(function(){
            	    $('#codeNm').focus();
            	},100);
            }
        });
	}else if(lwCdDc.length>500){
		Common.Dialog.alert({
			title: '확인',
            content: '소분류코드설명을 짧게 입력해주세요.'
            ,ok : function(){
            	
            	setTimeout(function(){
            	    $('#codeDc').focus();
            	},100);
            }
        });
	}else{
		Common.Dialog.confirm({
		      title: '저장',
		      content: '소분류 코드를 수정하시겠습니까?',
		      ok: function(){
		      	if(upCd != ''){
				// AJAX 통신 : POST 
				$.ajax({ 
					type : "post", 
					url : "<c:url value='/oper/updateLwCd.do'/>",
					async: false,
					dataType: "text",
			        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
					data : {upCd:upCd, lwCdNm:lwCdNm, lwCdDc:lwCdDc, lwCd:lwCd, lwCdUseAt:lwCdUseAt, lwCdDelAt:lwCdDelAt },
					success : function() { 
						Common.Dialog.alert({
							title: '확인',
							content: '소분류 코드가 수정되었습니다',
							ok: function(){
								// 성공적인 댓글 등록 처리 알림 
								location.reload();
								}
							});
						},
						error : function( jqXHR, textStatus, errorThrown ) {
							alert( jqXHR.status );
							alert( jqXHR.statusText );
							alert( jqXHR.responseText );
							alert( jqXHR.readyState );
							location.reload();
						}
					}); 
				}else{
					Common.Dialog.alert({
						title: '확인',
			            content: '입력 내용을 입력해주세요.'
			            ,ok : function(){
			            	
			            	setTimeout(function(){
			            	    $('#upperCodeNm').focus();
			            	},100);
			            }
			        });
				}
		      	},cancel : function(){
				Common.Dialog.alert({
					title: '확인',
					content: '대분류 수정 취소'
					});
				}
			});
	}
});


$('#cancleBtn').click(function(){
	$('#lwCd input').attr('disabled', 'disabled');
	$('#updateBtn').show();
	$('#saveBtn').show();
// 	$('#insertBtn').hide();
	
	$('#lwCd input').val('');
	$('#useAt')[0].checked = false;
	$('#delAt')[0].checked = false;
// 	$('#lwCd input').attr('disabled', 'disabled');
})

// 소분류 신규버튼
$('#newCd').click(function(){
		var upCd = $('#upperCode').val();
	
		if(upCd != ''){
			$('#lwCdTb tr').css('background-color','');
			$('#lwCd input').removeAttr('disabled');
			
			
			// 입력 칸 비우기
			$('#lwCd input').val('');
			$('#useAt')[0].checked = false;
			$('#delAt')[0].checked = false;
			
			// 신규버튼 클릭시 버튼 변경
			$('#cancleInBtn').show();
			$('#cancleUpBtn').hide();
			
			$('#updateBtn').hide();
			$('#saveBtn').hide();
			$('#insertBtn').show();
		}else{
			Common.Dialog.alert({
				title: '확인',
	            content: '대분류코드 선택을 먼저 해주세요.'
	            ,ok : function(){
	            	
	            	setTimeout(function(){
	            	    $('#code').focus();
	            	},100);
	            }
	        });
		}
		

});


// 소분류 신규 등록버튼
$('#insertBtn').click(function(){
	var lwCdNm = $('#codeNm').val();
	var lwCd = $('#code').val();
	var lwCdDc = $('#codeDc').val();
	var upCd = $('#upperCode').val();

	var lwCdUseAt = $('#useAt')[0].checked; // true = Y
	var lwCdDelAt = $('#delAt')[0].checked; // true = Y
	
	
	
	if(lwCd.length>10){
		Common.Dialog.alert({
			title: '확인',
            content: '소분류코드를 10글자 이하로 입력해주세요.'
            ,ok : function(){
            	setTimeout(function(){
            	    $('#code').focus();
            	},100);
            }
        });
	}else if(lwCdNm.length>200){
		Common.Dialog.alert({
			title: '확인',
            content: '소분류코드명을 짧게 입력해주세요.'
            ,ok : function(){
            	setTimeout(function(){
            	    $('#codeNm').focus();
            	},100);
            }
        });
	}else if(lwCdDc.length>500){
		Common.Dialog.alert({
			title: '확인',
            content: '소분류코드설명을 짧게 입력해주세요.'
            ,ok : function(){
            	setTimeout(function(){
            	    $('#codeDc').focus();
            	},100);
            }
        });
	}else{
		Common.Dialog.confirm({
		      title: '저장',
		      content: '소분류 코드를 신규 등록하시겠습니까?',
		      ok: function(){
		      	if(upCd != ''){
				// AJAX 통신 : POST 
				$.ajax({ 
					type : "post", 
					url : "<c:url value='/oper/insertLwCd.do'/>",
					async: false,
					dataType: "text",
			        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
					data : {upCd:upCd, lwCdNm:lwCdNm, lwCd:lwCd, lwCdDc:lwCdDc, lwCdUseAt:lwCdUseAt, lwCdDelAt:lwCdDelAt },
					success : function() { 
						Common.Dialog.alert({
							title: '확인',
							content: '소분류 코드가 등록되었습니다',
							ok: function(){
								// 성공적인 댓글 등록 처리 알림 
								location.reload();
								}
							});
						},
						error : function( jqXHR, textStatus, errorThrown ) {
							alert( jqXHR.status );
							alert( jqXHR.statusText );
							alert( jqXHR.responseText );
							alert( jqXHR.readyState );
							location.reload();
						}
					}); 
				}else{
					Common.Dialog.alert({
						title: '확인',
			            content: '대분류 코드 선택'
			            ,ok : function(){
			            	
			            	setTimeout(function(){
			            	    $('#upperCodeNm').focus();
			            	},100);
			            }
			        });
				}
		      	},cancel : function(){
				Common.Dialog.alert({
					title: '확인',
					content: '신규 등록 취소'
					});
				}
			});
	}
});





// 대분류 테이블의 Row 클릭시 값 가져오기
$("#upCdTb tr").click(function(){	
	$('#upCdTb tr').css('background-color','');
	$(this).css('background-color','#fbcb00');
	
	
	if(checkAuthValue("adm004002", "infoUpdtAt") == 'Y'){
		$('#updateUpBtn').show();
	}

// 	if(checkAuth("adm004002", "infoUpdtAt","") == 'N'){
// 		$('#lwCd input[name=delAt]').attr('disabled', 'disabled');
// 	}

	$('#saveUpBtn').hide();
	
	$('#cancleUpUpBtn').hide();
	$('#cancleInUpBtn').hide();
	$('#insertUpBtn').hide();

	$('#cancleInBtn').hide();
	$('#insertBtn').hide();
	
	$('#upCd input').attr('disabled', 'disabled');
	$('#lwCd input').attr('disabled', 'disabled');
	
	// 입력 칸 비우기
	$('#lwCd input').val('');
	$('#useAt')[0].checked = false;
	$('#delAt')[0].checked = false;
	
	
	
	
	var str = "";
	var tdArr = new Array();	// 배열 선언
	
	// 현재 클릭된 Row(<tr>)
	var tr = $(this);
	var td = tr.children();
	
	// tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
	console.log("클릭한 Row의 모든 데이터 : "+tr.text());
	
	// 반복문을 이용해서 배열에 값을 담아 사용할 수 도 있다.
	td.each(function(i){
		tdArr.push(td.eq(i).text());
	});
	
	console.log("배열에 담긴 값 : "+tdArr);
	
	// td.eq(index)를 통해 값을 가져올 수도 있다.
	var upperCode = td.eq(0).text();
	var upperCodeNm = td.eq(1).text();
	var upperCodeDc = td.eq(2).text();
	var upperUseAt = td.eq(3).text();
	var upperDelAt = td.eq(4).text();
	var upperDate = td.eq(5).text();
	
	$('#upperCode').val(upperCode);
	$('#upperCodeNm').val(upperCodeNm);
	$('#upperCodeDc').val(upperCodeDc);
	if(upperUseAt=='Y'){
		$('#upperUseAt')[0].checked = true
	}
	if(upperDelAt=='Y'){
		$('#upperDelAt')[0].checked = true
	}
	
	
	$.ajax({
		type : "post", 
		url : "<c:url value='/oper/code.do'/>",
		async: false,
		dataType: "json",
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
		data : {upperCode:upperCode},
		success : function(data2) {
					var html = '';	
					
					for(key in data2.codeList){
					
						var codeId= data2.codeList[key].codeId;
						var codeIdNm= data2.codeList[key].codeIdNm;
						
						if(!data2.codeList[key].codeDc == "" || !data2.codeList[key].codeDc == null){
							var codeDc= data2.codeList[key].codeDc;
						}else{
							var codeDc= "";
						}
						
						
						
						var useAt= data2.codeList[key].useAt;
						var delAt= data2.codeList[key].delAt;
						
						if(!data2.codeList[key].lastUpdtPnttm == "" || !data2.codeList[key].lastUpdtPnttm==null){
							var lastUpdtPnttm= new Date(data2.codeList[key].lastUpdtPnttm);
							lastUpdtPnttm = date_to_str(lastUpdtPnttm);
						}else{
							var lastUpdtPnttm= "";
						}
						
						
					html += '<tr>';
					html += '<td>'+codeId+'</td>';
					html += '<td>'+codeIdNm+'</td>';
					html += '<td>'+codeDc+'</td>';
					html += '<td>'+useAt+'</td>';
					html += '<td>'+delAt+'</td>';
					html += '<td>'+lastUpdtPnttm+'</td>';
					html += '</tr>';	
					}
										
					$("#lwCdTb").empty();
					$("#lwCdTb").append(html);
		},
		error : function( jqXHR, textStatus, errorThrown ) {
			alert( jqXHR.status );
			alert( jqXHR.statusText );
			alert( jqXHR.responseText );
			alert( jqXHR.readyState );
			location.reload();
		}
	}); 
});


//소분류 수정 버튼
$('#updateBtn').click(function(){
	if(checkAuthValue("adm004002", "infoUpdtAt") == 'Y'){
		$('#saveBtn').show();
		$('#cancleUpBtn').show();
		$('#updateBtn').hide();
		
		$('#lwCd input').removeAttr('disabled');
		$('#lwCd input[name=code]').attr('disabled', 'disabled');
		
		if(checkAuthValue("adm004002", "infoDelAt") == 'N'){
			$('#lwCd input[name=delAt]').attr('disabled', 'disabled');
		}
	};
})


$(document.body).delegate('#lwCdTb tr', 'click', function() {
// $('#lwCdTb tr').click(function(){ 	
	$('#lwCdTb tr').css('background-color','');
	$(this).css('background-color','#fbcb00');
	$('#lwCd input').attr('disabled', 'disabled');
	
	if(checkAuthValue("adm004002", "infoUpdtAt") == 'Y'){
		$('#updateBtn').show();
	}
	
	
	$('#saveBtn').hide();
	$('#cancleUpBtn').hide();
	$('#cancleInBtn').hide();
	$('#insertBtn').hide();
	
	var str = "";
	var tdArr = new Array();	// 배열 선언
	
	// 현재 클릭된 Row(<tr>)
	var tr = $(this);
	var td = tr.children();
	
	// tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
	console.log("클릭한 Row의 모든 데이터 : "+tr.text());
	
	// 반복문을 이용해서 배열에 값을 담아 사용할 수 도 있다.
	td.each(function(i){
		tdArr.push(td.eq(i).text());
	});
	
	console.log("배열에 담긴 값 : "+tdArr);
	
	// td.eq(index)를 통해 값을 가져올 수도 있다.
	var code = td.eq(0).text();
	var codeNm = td.eq(1).text();
	var codeDc = td.eq(2).text();
	var useAt = td.eq(3).text();
	var delAt = td.eq(4).text();
	var date = td.eq(5).text();
	
	$('#code').val(code);
	$('#codeNm').val(codeNm);
	$('#codeDc').val(codeDc);
	
	if(useAt=='Y'){
		$('#useAt')[0].checked = true
	}
	if(delAt=='Y'){
		$('#delAt')[0].checked = true
	}
});





	//수정 버튼 클릭시 확인 취소
	function updateBtn() {

		$('.updateBtn' + i).css("display", "none");
		$('.updateCmtBtn' + i).css("display", "inline-block");
		$('.deleteBtn' + i).css("display", "none");
		$('.cancleBtn' + i).css("display", "inline-block");

		$('#updateAnswer' + i).css("display", "block");
		$('#ansCnt' + i).css("display", "none");

		$('#updateAnswer' + i).val($("#ansCnt" + i).text());
	}

	// 취소 버튼 클릭시 수정 삭제
	function cancleBtn() {

		$('.updateBtn' + i).css("display", "inline-block");
		$('.updateCmtBtn' + i).css("display", "none");
		$('.deleteBtn' + i).css("display", "inline-block");
		$('.cancleBtn' + i).css("display", "none");

		$('#updateAnswer' + i).css("display", "none");
		$('#ansCnt' + i).css("display", "block");

		$('#updateAnswer' + i).val($("#ansCnt" + i).text());
	}
</script>
	
<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>



</body>
</html>