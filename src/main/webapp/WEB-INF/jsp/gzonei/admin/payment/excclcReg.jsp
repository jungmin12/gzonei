<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/gzonei/layout/header.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/jsp/gzonei/layout/admintop.jsp" %>
<script type="text/javascript" src="<c:url value='/js/gzonei/devlopInfo/twbsPagination.js' />"></script>
<!-- header -->
<script>
$(document).ready(function(){
	
	document.getElementById('excclcAmount').addEventListener('keyup', function(event) {
    	this.value = insertComma(this.value.replace(/[,]/g, ''))
    });
	
	$('#searchBtn').on('click',function(e){
		fn_searchUserInfo();
	});
	$("#excclcPnttm").datetimepicker({
        timepicker : false,
        format : 'Y-m-d',
        scrollMonth : false,
    });
	//입금금액 숫자만 입력
	var input = $('.money');
	input.on( "keyup", function( event ) {
	    // 1.
	    var selection = window.getSelection().toString();
	    if ( selection !== '' ) {
	        return;
	    }
	    // 2.
	    if ( $.inArray( event.keyCode, [38,40,37,39] ) !== -1 ) {
	        return;
	    }
	    // 3
	    var $this = $( this );
	    var input = $this.val();
	 
	    // 4
	    var input = input.replace(/[\D\s\._\-]+/g, "");
	 
	    // 5
	    input = input ? parseInt( input, 10 ) : 0;
	 
	    // 6
	    $this.val( function() {
	        return ( input === 0 ) ? "" : input.toLocaleString( "en-US" );
	    });

	} );
});

function goList(){
	document.location = "<c:url value='/admin/payment/excclcList.do'/>";
}
var ID_CHK_FLAG = false;
function fn_setInfo(obj){
	ID_CHK_FLAG = true;
	var id = obj.children[0].innerText;
	var nm = obj.children[1].innerText;
	$("#excclcId").val(id);
	$("#excclcNm").val(nm);
}
//사용자 조회
function fn_searchUserInfo(page){
	ID_CHK_FLAG = false;
	$("#excclcId").val("");
	$("#excclcNm").val("");
	var paginationDiv = $('#userPagination');
	paginationInit(paginationDiv);
	//Page index
	if(page){
		document.userInfoForm.pageIndex.value = page;
	}else{
		$("#searchKrwd").val("");
		$("#searchSel").val("");
	}
	$.ajax({
		type:"POST",
		url: getContextPath() + "/admin/member/searchMemberInfo.do",
		data:$('#userInfoForm').serializeArray(),
		dataType:'json',
		async:false,
		success:function(data){
			var dataHtml = '';
        	if(data.result.length == 0){
    			dataHtml += "<tr><td style='border: solid 1px ;text-align: center;'colspan='2'>사용자정보가 없습니다.</td></tr>";
    		}else{
	        	data.result.forEach(function(data, index){
	        		dataHtml += "<tr style='cursor: pointer;' onClick='javascript:fn_setInfo(this)' data-dismiss='modal'>";
        			dataHtml += "<td class='listtd'>" + data.emplyrId +"</td>";
        			dataHtml += "<td class='listtd'>" + data.userNm + "</td>";
        			dataHtml += "</tr>";
	        	});
    		}
        	$('#userContents').html(dataHtml);
        	makePage(paginationDiv,data.paginationInfo.totalRecordCount,data.paginationInfo.currentPageNo, 10);
		} 
		,error : function(e) {
			Common.Dialog.alert({
	            content: '사용자 조회시 에러가 발생했습니다.\n관리자에게 문의바랍니다.'
	        });
		}
		,beforeSend:function(){
			//전송 전
	    }
	    ,complete:function(){
	        //전송 후
	    }
		});
	$("#search_user").modal();
}
function paginationInit(paginationDiv){
	paginationDiv.empty();
	paginationDiv.removeData("twbs-pagination");
	paginationDiv.unbind("page");
}
function makePage(paginationDiv,totalPages, currentPageNo, pageCount){
	var totalPagesOption;
	var visiblePage = pageCount;
	var pageCal = totalPages/visiblePage;
	var pageCalRemain = totalPages%visiblePage;
	if(pageCalRemain == 0){
		totalPagesOption = pageCal;
	}else{
		totalPagesOption = pageCal + 1;
	}
	paginationDiv.twbsPagination({
	    totalPages: totalPagesOption,	// 총 페이지 번호 수
	    visiblePages: visiblePage,	// 하단에서 한번에 보여지는 페이지 번호 수
	    startPage : currentPageNo, // 시작시 표시되는 현재 페이지
	    initiateStartPageClick: false,	// 플러그인이 시작시 페이지 버튼 클릭 여부 (default : true)
	    first : "<<",	// 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
	    prev : "<",	// 이전 페이지 버튼에 쓰여있는 텍스트
	    next : ">",	// 다음 페이지 버튼에 쓰여있는 텍스트
	    last : ">>",	// 페이지네이션 버튼중 마지막으로 가는 버튼에 쓰여있는 텍스트
	    nextClass : "page-item Next",	// 이전 페이지 CSS class
	    prevClass : "page-item Previous",	// 다음 페이지 CSS class
	    lastClass : "page-item last",	// 마지막 페이지 CSS calss
	    firstClass : "page-item first",	// 첫 페이지 CSS class
	    pageClass : "page-item",	// 페이지 버튼의 CSS class
	    activeClass : "active",	// 클릭된 페이지 버튼의 CSS class
	    disabledClass : "disabled",	// 클릭 안된 페이지 버튼의 CSS class
	    anchorClass : "page-link",	//버튼 안의 앵커에 대한 CSS class
	    
	    onPageClick: function (event, page) {
	    	//클릭 이벤트
	    	document.userInfoForm.pageIndex.value = page;
	    	fn_searchUserInfo();
	    }
	});
	paginationDiv.children().children('.first').children('a').attr('aria-label','first');
	paginationDiv.children().children('.Previous').children('a').attr('aria-label','Previous');
	paginationDiv.children().children('.Next').children('a').attr('aria-label','Next');
	paginationDiv.children().children('.last').children('a').attr('aria-label','last');
}
/*********************************************************
 *숫자 ,
 ******************************************************** */
function insertComma(num) {
	if(num.length <= 3) {
	return num;
	}
	var count = Math.ceil(num.length / 3);
	var newNum = [];
	for(var i=0; i<count; i++) {
	newNum.unshift(num.slice(-3*(i+1), num.length-(3*i)));
	}
	return newNum.join(',');
}
/*********************************************************
 * 입력폼 검증
 ******************************************************** */
function validate(){
	
	if ($("[name=excclcTyCode]:checked").val() == '' || $("[name=excclcTyCode]:checked").val() == undefined) {
		Common.Dialog.alert({
            content: '입금구분을 선택해주세요.'
            ,ok : function(){
            	$('#excclcTyCode').focus();
            }
        });
		return false;
	}
	
	if ($('#excclcPnttm').val() == '') {
		Common.Dialog.alert({
            content: '입금일자를 선택해주세요.'
            ,ok : function(){
            	$('#excclcPnttm').focus();
            }
        });
		return false;
	}
	
	if ($('#excclcAmount').val() == '') {
		Common.Dialog.alert({
            content: '입금금액을 입력해주세요.'
            ,ok : function(){
				$('#excclcAmount').focus();
            }
        });
     	return false;
	}
	
	if(ID_CHK_FLAG == false){
		Common.Dialog.alert({
            content: '사용자를 선택해주세요.'
            ,ok : function(){
				$('#emplyrId').focus();
            }
        });
		return false;
	}
	
	if ($('#excclcId').val() == '') {
		Common.Dialog.alert({
            content: '입금자ID를 입력해주세요.'
            ,ok : function(){
				$('#excclcId').focus();
            }
        });
     	return false;
	}
	if ($('#excclcNm').val() == '') {
		Common.Dialog.alert({
            content: '입금자명을 입력해주세요.'
            ,ok : function(){
				$('#excclcNm').focus();
            }
        });
     	return false;
	}
	
	return true;
}
//정산내역 등록
function fn_insert(){
	if(checkAuth("adm006001", "infoRegistAt","")){
		if(validate()){
			
			Common.Dialog.confirm({
		        title: '등록',
		        content: '등록하시겠습니까?'
		        ,ok: function(){
		    		document.insertForm.action = "<c:url value='/admin/payment/excclcRegAction.do'/>";
		    		document.insertForm.submit();
		        }
		        ,cancel : function(){
		        	return false;
		        }
		    });
		}
	}
}

function enterkeyInv() {
	if (window.event.keyCode == 13) { //javascript에서는 13이 enter키를 의미함 
		event.preventDefault();
		fn_searchUserInfo(1);
	}
}

</script>
<!-- 구현부 : S -->

<div id="body_layout">	

    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
            <div id="location" class="title_wrap">
                <h2 class="page__title">정산 관리</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="<c:url value='/admin/payment/excclcList.do'/>" >결제 관리</a></li>
                        <li class="n3"><a href="<c:url value='/admin/payment/excclcList.do'/>" class="navi_ov">정산 관리</a></li>
                    </ul>                            
                    <!-- 로케이션 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">
            <!-- content 영역입니다. -->
			<!-- view : S -->
			<div class="board_view_in">

				<form name="insertForm" id="insertForm" method="post" action="<c:url value='/admin/payment/excclcRegAction.do'/>"  onSubmit="fn_insert(); return false;" enctype="multipart/form-data">
				<input type="hidden" name="userId" id="userId" value="${sessionScope.loginVO.id}" >
					<div class="form-horizontal bucket-form">
						<div class="form-group">
                            <div class="col-sm-2 control-label col-lg-2"><div class="label">입금구분<span class="star" style="vertical-align: unset;">*</span></div></div>
                            <div class="col-sm-2">
                               <input class="radio-input" type="radio" value="CM00250004"  id='excclcTyCode1' name='excclcTyCode' checked<c:if test="${resultVO.excclcTyCode eq 'CM00250004'}">checked</c:if> /><label class="radio-inline" for="excclcTyCode1" >현금</label>
                              <input class="radio-input" type="radio" value="CM00250001" id='excclcTyCode2' name='excclcTyCode' <c:if test="${resultVO.excclcTyCode eq 'CM00250001'}">checked</c:if> /><label class="radio-inline" for="excclcTyCode2">카드</label>
                              </div>
                          </div>
						
						<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2">
								<div class="label">
									<label for="select">입금일자<span class="star" style="vertical-align: unset;">*</span></label>
								</div>
							</div>
							<div class="col-sm-4 search--calendar">
								<input type="text" id="excclcPnttm" name="excclcPnttm" title="입금일자 입력" class="form-control" required autocomplete="off">
								<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
							</div>
						</div>
						
					
						
                          
						<div class="form-group">
						
							<div class="col-sm-2 control-label col-lg-2">
								<div class="label">
									<label for="select">입금금액<span class="star" style="vertical-align: unset;">*</span></label>
								</div>
							</div>
							<div class="col-sm-4">
								<input type="text" id="excclcAmount" name="excclcAmount" title="입금금액 입력" class="form-control money" required maxlength="12">
							</div>
						</div>
					
						<div class="form-group">
						
							<div class="col-sm-2 control-label col-lg-2">
								<div class="label">
									<label for="select">입금자ID<span class="star" style="vertical-align: unset;">*</span></label>
								</div>
							</div>
								<div class="col-sm-4">
									<input type="text" id="excclcId" name="excclcId" title="입금자ID 입력" class="form-control" required readonly="readonly" onclick="javascript:fn_searchUserInfo()">
								</div>
								<div class="col-sm-1">
									<a href="javascript:fn_searchUserInfo()"  class="btn btn-sm btn-secondary">사용자 검색</a>
								</div>
						</div>
					
						<div class="form-group">
						
							<div class="col-sm-2 control-label col-lg-2">
								<div class="label">
									<label for="select">입금자명<span class="star" style="vertical-align: unset;">*</span></label>
								</div>
							</div>
							<div class="col-sm-4">
								<input type="text" id="excclcNm" name="excclcNm" title="입금자명 입력" class="form-control" required  readonly="readonly"  onclick="javascript:fn_searchUserInfo()">
							</div>
						</div>
					
						<div class="form-group">
						
							<div class="col-sm-2 control-label col-lg-2">
								<div class="label">
									<label for="select">입금내역</label>
								</div>
							</div>
							<div class="col-sm-4">
								<textarea name="excclcCn" id="excclcCn" cols="70" rows="7" class="form-control" style="height: 150px;">${resultVO.excclcCn }</textarea>
							</div>
						</div>
					
						<div class="form-group">
						
							<div class="col-sm-2 control-label col-lg-2">
								<div class="label">
									<label for="select">특이사항</label>
								</div>
							</div>
							<div class="col-sm-4">
								<textarea name="excclcEtcCn" id="excclcEtcCn" cols="70" rows="7" class="form-control" style="height: 150px;">${resultVO.excclcEtcCn }</textarea>
							</div>
						</div>
					
				
					</div>
						
					<div class="board_btm">
                        <div class="btns_area fl_r mo_block">
                			<a href="javascript:fn_insert()" class="btn btn-default">등록</a>
							<a href="javascript:goList()"  class="btn btn-default">취소</a>
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
<!-- Modal Sample ::S -->
				
				<div class="modal fade" role="dialog" data-ly-type="content" data-ly-target="search_user" id="search_user">
				    <div class="modal-dialog">
				        <!-- Modal content-->
				        <div class="modal__body">
				            <div class="modal__header">
				               <h4 class="modal__title">사용자 검색</h4>
				               <div class="modal__close-button"><button type="button" class="close" data-dismiss="modal">닫기</button></div>
				            </div>
				            <div class="modal__content" style="word-break: break-all">
				                <div class="cont_wrap">
					               <div class="modal__board">

					                    <div class="form-horizontal bucket-form">
										 <form id="userInfoForm" name="userInfoForm" method="post">
											<input type="hidden" name="devlopInfoSn">
											<input type="hidden" name="pageIndex"> 
											<input type="hidden" name="pageUnit" value="5">
											<input type="hidden" name="pageSize" value="5">
												 <fieldset>
													 <legend>검색</legend>
													 <div class="search custom-search" style="margin-bottom: unset;padding: 1px 0px 0px 58px;">
														<div class="form-group p-row" style="margin-top: 14px;">
															<div class="p-col-7 p-col-sm-18">
															<select name="searchSel" class="p-control" id="searchSel" >
																<option value="">-- 전체 --</option>
																<option value="emplyr_id">사용자 ID</option>
																<option value="user_nm">사용자명</option>
															</select>
															</div>
															<div class="p-col-10 p-col-sm-18">
									                       	 <input type="text" name="searchKrwd" id="searchKrwd" value="" title="검색어를 입력해주세요"  onkeypress="return enterkeyInv();"  placeholder="검색어를 입력해주세요" class="p-control">
									                       </div>
															<div class="p-col-5  p-col-sm-24">
									                       	 <button type="button" class="searchMember"  onclick="javascript:fn_searchUserInfo(1);" style="">검색</button>
									                       </div>
														</div>
								                    </div>
												 </fieldset>
												
												<div id="contents" class="modal__content" style="word-break: break-all">
				                                <table class="paginated table_info">
				                                    <colgroup>
														<col style="width:50%">
														<col style="width:50%">
													</colgroup>
				                                    <thead>
				                                        <tr>
				                                            <th>사용자 ID</th>
				                                            <th>사용자명</th>
				                                        </tr>
				                                    </thead>
													<tbody id="userContents">
													</tbody>                         
				                                </table>
				                                </div>
				                               <div id="userPagination" style="text-align: center;"><ul class="pagination"><li class="page-item first disabled"><a href="#" class="page-link" aria-label="first">&lt;&lt;</a></li><li class="page-item Previous disabled"><a href="#" class="page-link" aria-label="Previous">&lt;</a></li><li class="page-item active"><a href="#" class="page-link">1</a></li><li class="page-item"><a href="#" class="page-link">2</a></li><li class="page-item"><a href="#" class="page-link">3</a></li><li class="page-item"><a href="#" class="page-link">4</a></li><li class="page-item"><a href="#" class="page-link">5</a></li><li class="page-item Next"><a href="#" class="page-link" aria-label="Next">&gt;</a></li><li class="page-item last"><a href="#" class="page-link" aria-label="last">&gt;&gt;</a></li></ul></div>          
				                            </form>
					                    </div>
					                    
					                </div>
				                </div>
				            </div>
	
						</div>
					</div>
				</div>
<!-- 구현부 : E -->

<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>
</body>
</html>
