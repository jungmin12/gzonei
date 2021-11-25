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
	checkAuth("adm006001", "menuAccesAt",""); 
	document.getElementById('excclcAmount').addEventListener('keyup', function(event) {
    	this.value = insertComma(this.value.replace(/[,]/g, ''))
    });
	

    $.datetimepicker.setLocale('ko');
    $("#excclcPnttm").datetimepicker({
        timepicker : false,
        format : 'Y-m-d',
        scrollMonth : false,
        scrollInput : false,
        validateOnBlur: false
    	
    }).on('keydown', function(event){
    	onlyNum(this,event);
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

function fn_setInfo(obj){
	var id = obj.children[0].innerText;
	var nm = obj.children[1].innerText;
	$("#excclcId").val(id);
	$("#excclcNm").val(nm);
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
//정산내역 수정
function fn_update(){
	if(checkAuth("adm006001", "infoUpdtAt","")){
		if(validate()){
			Common.Dialog.confirm({
		        title: '수정',
		        content: '수정하시겠습니까?'
		        ,ok: function(){
		    		document.insertForm.action = "<c:url value='/admin/payment/excclcUpdateAction.do'/>";
		    		document.insertForm.submit();
		        }
		        ,cancel : function(){
		        	return false;
		        }
		    });
		}
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
				<input type="hidden" name="excclcManageSn" id="excclcManageSn" value="${resultVO.excclcManageSn}" >
					<div class="form-horizontal bucket-form">
						<div class="form-group">
                            <div class="col-sm-2 control-label col-lg-2"><div class="label">입금구분<span class="star" style="vertical-align: unset;">*</span></div></div>
                            <div class="col-sm-2">
                               <input class="radio-input" type="radio" value="CM00250004"  id='excclcTyCode1' name='excclcTyCode' <c:if test="${resultVO.excclcTyCode eq 'CM00250004'}">checked</c:if> /><label class="radio-inline" for="excclcTyCode1" >현금</label>
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
								<input type="text" id="excclcPnttm" name="excclcPnttm" title="입금일자 입력" class="form-control" value="${resultVO.excclcPnttm}" autocomplete="off" >
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
								<input type="text" id="excclcAmount" name="excclcAmount" title="입금금액 입력" class="form-control money" value="${resultVO.excclcAmount}" maxlength="12">
							</div>
						</div>
					
						<div class="form-group">
						
							<div class="col-sm-2 control-label col-lg-2">
								<div class="label">
									<label for="select">입금자ID<span class="star" style="vertical-align: unset;">*</span></label>
								</div>
							</div>
							<div class="col-sm-4 file-form-group">
								<input type="text" id="excclcId" name="excclcId" title="입금자ID 입력" class="form-control" required value="${resultVO.excclcId }" readonly="readonly">
							</div>
						</div>
					
						<div class="form-group">
						
							<div class="col-sm-2 control-label col-lg-2">
								<div class="label">
									<label for="select">입금자명<span class="star" style="vertical-align: unset;">*</span></label>
								</div>
							</div>
							<div class="col-sm-4">
								<input type="text" id="excclcNm" name="excclcNm" title="입금자명 입력" class="form-control" required value="${resultVO.excclcNm }" readonly="readonly">
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
                			<a href="javascript:fn_update()" class="btn btn-default">수정</a>
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
															<select name="searchSel" class="p-control" >
																<option value="">-- 전체 --</option>
																<option value="emplyr_id">사용자 ID</option>
																<option value="user_nm">사용자명</option>
															</select>
															</div>
															<div class="p-col-10 p-col-sm-18">
									                       	 <input type="text" name="searchKrwd" value="" title="검색어를 입력해주세요" placeholder="검색어를 입력해주세요" class="p-control">
									                       </div>
															<div class="p-col-5  p-col-sm-24">
									                       	 <button type="button" class="searchMember"  onclick="javascript:fn_searchUserInfo();" style="">검색</button>
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
