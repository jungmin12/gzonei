<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="ckeditor" uri="http://ckeditor.com"%>
<!DOCTYPE html>
<html lang='ko'>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<script type="text/javascript" src="<c:url value='/js/gzonei/jquery-3.5.1.js' />"></script>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<%@ include file="/WEB-INF/jsp/gzonei/layout/header.jsp" %>
<script type="text/javascript" src="<c:url value='/html/egovframework/com/cmm/utl/ckeditor/ckeditor.js'/>"></script>
<script type="text/javascript" src="<c:url value='/html/egovframework/com/cmm/utl/ckeditor/adapters/jquery.js'/>"></script>

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
            <c:if test="${searchVO.readngAuthorCode eq null}">
                <h2 class="page__title">???????????????</h2>
                <!-- ?????? ?????? -->
                <div class="utile_wrap">
                    <!-- ???????????? ?????? -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="<c:url value='/str/strBbsList.do'/>" class="navi_ov">???????????????</a></li>
                    </ul>                           
                </div>
            </c:if>
            <c:if test="${searchVO.readngAuthorCode eq '002'}">
                <h2 class="page__title">????????????????????????</h2>
                <!-- ?????? ?????? -->
                <div class="utile_wrap">
                    <!-- ???????????? ?????? -->
                    <ul class="location_wrap">
                    	<li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="/str/strBbsList.do">???????????????</a></li>
                        <li class="n3"><a href="<c:url value='/str/strSuccesBbsList.do'/>" class="navi_ov">????????????????????????</a></li>
                    </ul>                           
                </div>
            </c:if>
            <c:if test="${searchVO.readngAuthorCode eq '003'}">
                <h2 class="page__title">????????????????????????</h2>
                <!-- ?????? ?????? -->
                <div class="utile_wrap">
                    <!-- ???????????? ?????? -->
                    <ul class="location_wrap">
                    	<li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                     	<li class="n2"><a href="/str/strBbsList.do">???????????????</a></li>
                        <li class="n3"><a href="<c:url value='/str/strFailrBbsList.do'/>" class="navi_ov">????????????????????????</a></li>
                    </ul>                           
                </div>
            </c:if>
                <!-- ?????? ??? -->   
            </div>  
        
            <div id="txt">
	            
			<div class="nav-4th">
				<ul>
					<li <c:if test="${searchVO.readngAuthorCode eq null}"> class="active"</c:if>><a class="debug" href="<c:url value='/str/strBbsList.do'/>">???????????? </a></li>
					<li <c:if test="${searchVO.readngAuthorCode eq '002'}"> class="active"</c:if>><a href="<c:url value='/str/strSuccesBbsList.do'/>">????????????????????????</a></li>
					<li <c:if test="${searchVO.readngAuthorCode eq '003'}"> class="active"</c:if>><a href="<c:url value='/str/strFailrBbsList.do'/>">????????????????????????</a></li>
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
									<select id="bbsTabCode" name="readngAuthorCode" class="form-control" title="?????? ??????" >
										<option value="002" <c:if test="${searchVO.readngAuthorCode eq '002'}"> selected</c:if>>?????? ?????? ????????????</option>
										<option value="003" <c:if test="${searchVO.readngAuthorCode eq '003'}"> selected</c:if>>?????? ?????? ????????????</option>
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
										<input class="radio-input" type="radio" value="N" id='noDsply' name='dspyAt' checked /><label class="radio-inline" for="noDsply">?????????</label>
						            </div>
						            <div class="col-sm-1 control-label"><label for="select">?????????</label></div>
                           			   	<div class="col-sm-2 search--calendar">
									    <div>
									    	<input type="text" name="frstRegistPnttm" id="frstRegistPnttm" placeholder="?????????" class="form-control" autocomplete="off" onkeyup="this.value = date_mask(this.value)" maxlength="10" value="<%=now%>"  />
									    	<button type="button" class="btn__calendar"><span class="skip">????????????</span></button>
										</div>
									</div>
								    <div class="col-sm-1 control-label" style="display:none"><label for="select">????????????</label></div>
								    <div class="col-sm-2" style="display:none">
								    	<input class="radio-input" type="radio" value="Y"  id='free' name='freeAt' checked /><label class="radio-inline" for="free">??????</label>
										<input class="radio-input" type="radio" value="N" id='pay' name='freeAt' /><label class="radio-inline" for="pay">??????</label>
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
							    	 	<div class="form-group file_author" style="display:none">
										    <div class="col-sm-2 control-label col-lg-2"><label for="select">???????????? ??????<span class="pilsu">??????</span></label></div>
										    <div class="col-sm-4">
											    <select name="fileAuthor" class="form-control">
											    	<option value="CM00209998" selected>??????</option>
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
							<input type="hidden" name="bbsId"  value="BBSMSTR_000000000021"/>
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
	
	if(insertForm.readngAuthorCode.value == ""){
		Common.Dialog.alert({
			content: '????????? ??????????????????.'
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
				document.insertForm.action="<c:url value='/str/strBbsRgst.do'/>";
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