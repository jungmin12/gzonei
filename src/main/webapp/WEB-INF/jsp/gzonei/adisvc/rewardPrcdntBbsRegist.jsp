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

<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<head>
<%@ include file="/WEB-INF/jsp/gzonei/layout/header.jsp" %>
</head>

<body>
<%@ include file="/WEB-INF/jsp/gzonei/layout/top.jsp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	Date nowTime = new Date();
	SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
	String now = simpleDate.format(nowTime);
%>

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
                <h2 class="page__title">????????????</h2>
                <!-- ?????? ?????? -->
                <div class="utile_wrap">
                    <!-- ???????????? ?????? -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="<c:url value='/adisvc/rewardPrcdntBbsList.do'/>" >???????????????</a></li>
                        <li class="n3"><a href="<c:url value='/adisvc/rewardPrcdntBbsList.do'/>" class="navi_ov">????????????</a></li>
                    </ul>                           
                    <!-- ???????????? ??? -->
                    <!-- ????????? ?????? -->
                    <!-- <ul class="print_wrap setting-box__group">
                        <li id="sns_layout" class="n2">
                            <button data-target="ui-open">SNS??????</button>
                            <div class="sns_wrap" data-id="ui-open">
                                <button data-button="sns_share" data-service="naver" data-title="????????? SNS??????" title="????????????" target="_blank"><span class="sr-only">????????? SNS</span>????????????</button>
                                <button data-button="sns_share" data-service="facebook" data-title="???????????? SNS??????" title="????????????" target="_blank"><span class="sr-only">???????????? SNS </span>????????????</button>
                                <button data-target="ui-close">??????</button>
                            </div>
                        </li>                    
                        <li class="n1" id="print"><button data-print="print">?????????</button></li>
                    </ul> -->
                    <!-- ????????? ??? -->
                </div>
                <!-- ?????? ??? -->   
            </div>  
        
            <div id="txt">
	            
			<div class="nav-4th">
				<ul>
					<li <c:if test="${searchVO.seCode eq null or searchVO.seCode eq ''}"> class="active"</c:if>><a href="<c:url value='/adisvc/rewardPrcdntBbsList.do'/>">???????????? </a></li>
					<li <c:if test="${searchVO.seCode eq 'prcdnt'}"> class="active"</c:if>><a href="<c:url value='/adisvc/rewardPrcdntList.do'/>">???????????? </a></li>
					<li <c:if test="${searchVO.seCode eq 'instrc'}"> class="active"</c:if>><a href="<c:url value='/adisvc/rewardInstructionList.do'/>">?????? </a></li>
					<li <c:if test="${searchVO.seCode eq 'reg'}"> class="active"</c:if>><a href="<c:url value='/adisvc/rewardRegList.do'/>">?????? </a></li>
				</ul>
			</div>
            <!-- content ???????????????. -->
			<!-- view : S -->
			<div class="board_view_in">
              	 <form name="insertForm" method="post" enctype="multipart/form-data">
	                    <div class="form-horizontal bucket-form">
		                   <div class="form-group">
							    <div class="col-sm-2 control-label col-lg-2"><label for="select">?????? <span class="pilsu">??????</span></label></div>
							    <div class="col-sm-4">
									<select id="seCode" name="seCode" class="form-control" title="?????? ??????" >
										<option value="">-??????-</option>
										<option value="prcdnt" <c:if test="${searchVO.seCode eq 'prcdnt'}">selected</c:if>>????????????</option>
										<option value="instrc" <c:if test="${searchVO.seCode eq 'instrc'}">selected</c:if>>??????</option>
										<option value="reg" <c:if test="${searchVO.seCode eq 'reg'}">selected</c:if>>??????</option>
									</select>
							    </div>
							</div>
							<div class="form-group">
								<div class="col-sm-2 control-label col-lg-2">
									<label for="select">???????????? <span class="pilsu">??????</span></label>
								</div>
								<div class="col-sm-4">
									<select id="readngAuthorCode" name="readngAuthorCode" class="form-control" title="???????????? ??????" required="">
										<option value="">---?????? ??????---</option>
		 									<option value="bbs010002">1??????</option>
											<option value="bbs010003">2??????</option>
											<option value="bbs010004">3??????</option>
<!-- 										<option value="CM00209998">??????</option> -->
<!-- 										<option value="CM00200005">??????(????????????)</option> -->
<!-- 										<option value="CM00200006">??????(?????????)</option> -->
<!-- 										<option value="CM00200007">??????(????????????)</option> -->
<!-- 										<option value="CM00200008">??????(????????????)</option> -->
<!-- 										<option value="CM00200009">??????(?????????)</option> -->
<!-- 										<option value="CM00200010">????????????(????????????)</option> -->
<!-- 										<option value="CM00200011">????????????(?????????)</option> -->
									</select>
								</div>
							</div> 
							<div class="form-group">
							    <div class="col-sm-2 control-label col-lg-2"><label for="select">?????? <span class="pilsu">??????</span></label></div>
							    <div class="col-sm-9">
							    	<input type="text" id="nttSj" name="nttSj" title="?????? ??????" class="form-control" value="" placeholder="????????? ???????????????.">
								</div>
							</div> 
							<c:if test="${sessionScope.loginVO.indvdlMberCode eq 'CM00210003'}">
								<div class="form-group">
								    <div class="col-sm-1 control-label"><label for="select">????????????</label></div>
								    <div class="col-sm-2">
						                <input class="radio-input" type="radio" value="Y"  id='dsply' name='dspyAt' /><label class="radio-inline" for="dsply">??????</label>
										<input class="radio-input" type="radio" value="N" id='noDsply' name='dspyAt' checked/><label class="radio-inline" for="noDsply">?????????</label>
						            </div>
 						            <div class="col-sm-1 control-label"><label for="select">?????????</label></div>
			                        <div class="col-sm-2 search--calendar">
									    <div>
									    	<input type="text" name="frstRegistPnttm" id="frstRegistPnttm" placeholder="?????????"  onkeyup="this.value = date_mask(this.value)" maxlength="10" value="<%=now%>"  class="form-control" autocomplete="off"/>
									    	<button type="button" class="btn__calendar"><span class="skip">????????????</span></button>
										</div>
									</div>
						        </div>
							</c:if>
							<div class="form-group">
							    <div class="col-sm-12">
									<!-- CKEditor Sample <START> -->
									<textarea id="nttCn" name='nttCn' title="?????????" class="form-control" rows="20"></textarea>
									<script type="text/javascript" src="<c:url value='/js/gzonei/ckeditor_custom_config.js'/>"></script>
									<!-- CKEditor Sample <END>-->
								</div>
							</div> 
							<!-- ???????????? S  -->
							<div class="form-group">
							    <div class="col-sm-2 control-label col-lg-2"><label for="select">???????????? <span class="pilsu">??????</span></label></div>
							    <div class="col-sm-7">
							    	<div class="form-upload">
							    	 	<div class="file-form-group">
							    	 		<div class="form-group__upload">
							    	 			<input type="text" readonly="readonly" name="atchFileNm" class="form-control disabled">
							    	 			<input type="file" name="atchFile_1" id="atchFile_1" class="form-upload__file--hidden">
							    	 		</div>
							    	 		<div class="form-input__addon">
				                                <label for="atchFile_1" class="btn btn-sm btn-secondary" data-button="upload">??????????????????</label>
				                                <button type="button" class="btn btn-sm btn-primary file_del_btn">?????? ??????</button>
				                           </div>
							    	 	</div>
							    	 	<div class="form-group file_author">
										    <div class="col-sm-2 control-label col-lg-2"><label for="select">???????????? ??????<span class="pilsu">??????</span></label></div>
										    <div class="col-sm-4">
											    <select name="fileAuthor" class="form-control">
   			 										<option value="bbs010005">1??????</option>
													<option value="bbs010006">2??????</option>
													<option value="bbs010007">3??????</option>
<!-- 											    	<option value="CM00209998">??????</option> -->
<!-- 											    	<option value="CM00200005">?????? (????????????)</option> -->
<!-- 											    	<option value="CM00200006">?????? (?????????)</option> -->
<!-- 											    	<option value="CM00200007">?????? (????????????)</option> -->
<!-- 											    	<option value="CM00200008">?????? (????????????)</option> -->
<!-- 											    	<option value="CM00200009">?????? (?????????)</option> -->
<!-- 											    	<option value="CM00200010">???????????? (????????????)</option> -->
<!-- 											    	<option value="CM00200011">???????????? (?????????)</option> -->
											    </select>
									    	</div>
										</div>
							    	 	<div class="file-button">
								    	 	<button type="button" class="addFile">??????</button>
											<button type="button" class="delFile">??????</button>
								    	</div>
							    	</div>
								</div>
							</div>
							<!-- ???????????? E  -->
							</div>
							<!-- ?????? ???????????? -->
							<input type="hidden" name="rdcnt"  value="0"/>
							<input type="hidden" name="bbsId"  value="BBSMSTR_000000000006"/>
							<input type="hidden" name="answerAt"  value="Y"/>
							<input type="hidden" name="useAt"  value="Y"/>
							<input type="hidden" name="delAt"  value="N"/>
							<input type="hidden" name="ntcrId"  value="${sessionScope.loginVO.id}"/>
							<input type="hidden" name="ntcrNm"  value="${sessionScope.loginVO.name}"/>  <!--?????? ?????? ????????? ?????? -->
							<input type="hidden" name="frstRegisterId"  value="${sessionScope.loginVO.id}"/><!--?????? ?????? ????????? ?????? -->
							<input type="hidden" name="password"  value="tester"/>
							<input type="hidden" name="bolgId"  value="N"/>
							<input type="hidden" name="noticeAt"  value="N"/> <!-- ?????? ?????? -->
	                 	</form>
                   	</div>
                    <div class="board_btm">
                        <div class="btns_area fl_r mo_block">
                            <a class="btn btn-default" onclick="insert();">??????</a>
                            <a class="btn btn-secondary" onclick="window.history.back()">??????</a>	
                        </div>
                    </div>
                    
                </div>
				<!-- view : E -->
            <!-- content ???????????????. -->	
            </div>
        </div>
    </div>
    <!-- layout -->
</body>
<script>
function insert() {
	
	if(insertForm.seCode.value == ""){
		Common.Dialog.alert({
			content: '????????? ??????????????????.'
			,ok : function(){
				insertForm.bbsId.focus();
			}
		}); 
		return;
   	}else if(insertForm.readngAuthorCode.value == ""){
		Common.Dialog.alert({
			content: '??????????????? ??????????????????.'
			,ok : function(){
				insertForm.readngAuthorCode.focus();
			}
		});
		return;
   	}else if(insertForm.nttSj.value == ""){
		Common.Dialog.alert({
			content: '????????? ??????????????????.'
			,ok : function(){
				insertForm.nttSj.focus();
			}
		});
		return;
	}else if(insertForm.frstRegistPnttm.value == ""){
		Common.Dialog.alert({
			content: '???????????? ??????????????????.'
			,ok : function(){
				insertForm.frstRegistPnttm.focus();
			}
		});
		return;
	}else{
		Common.Dialog.confirm({
	        title: '??????',
	        content: '?????? ???????????? ?????????????????????????'
	        ,ok: function(){
	        	content: '?????? ???????????? ?????????????????????.';
				document.insertForm.action="<c:url value='/adisvc/rewardPrcdntBbsRgst.do'/>";
				document.insertForm.submit();
			}
			,cancel : function(){
				document.location.reload();;
			}	
		});    
	}
	
}

	$(function() {
		getTimeStamp();
	});

	function getTimeStamp() {
		var d = new Date();
		var date = leadingZeros(d.getFullYear(), 4) + '-' +
					leadingZeros(d.getMonth() + 1, 2) + '-' +
					leadingZeros(d.getDate(), 2) + '';

		$('#frstRegistPnttm').val(date);

	}

	function leadingZeros(n, digits) {
		var zero = '';

		n = n.toString();
		if (n.length < digits) {
			for (i = 0; i < digits - n.length; i++)
				zero += '0';
		}
		return zero + n;
	}
</script>
</html>