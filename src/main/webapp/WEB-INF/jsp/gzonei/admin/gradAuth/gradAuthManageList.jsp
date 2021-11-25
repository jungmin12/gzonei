<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%-- 
<script language="javascript" src="<c:url value='/js/gzonei/jquery-3.5.1.js' />"></script>
 --%>
<%@ include file="/WEB-INF/jsp/gzonei/layout/header.jsp" %>
<script>
$(document).ready(function(){
	checkAuth("adm005001", "menuAccesAt","");
	if("N" == checkAuthValue("adm005001", "infoRegistAt")){
		$('#newBtn').css('display','none');
	}
	$('#updateBtn').css('display','none');
	$('#insertBtn').css('display','none');
	$('#cancelBtn').css('display','none');
	$('#newcancelBtn').css('display','none');
	$('#insertForm').css('display','none');
	fn_authTb_init();
	
	//금액 Input 한글 및 콤마 이벤트
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
// 	        return ( input === 0 ) ? "" : input.toLocaleString( "en-US" );
			var regexp = /\B(?=(\d{3})+(?!\d))/g;
	        return ( input === 0 ) ? "" : input.toString().replace(regexp, ',');
	    });

	} );

	$("#gradAuthListTb tr").click(function(){	
		if(checkAuth("adm005001", "infoInqireAt","")){
				
	// 		fn_authTb_init();
			$('#gradAuthListTb tr').css('background-color','');
			$(this).css('background-color','#fbcb00');
			$('.wrap-loading').removeClass('display-none');
	
			$('#updateBtn').css('display','inline-block');
			$('#insertBtn').css('display','none');
			$('#cancelBtn').css('display','none');
			$('#newcancelBtn').css('display','none');
			
			
	//	 	// 현재 클릭된 Row(<tr>)
			var tr = $(this);
			var gradAuthorSn = $(this.cells[0].children.gradAuthorSn).val();
			
			$.ajax({
				type : "post", 
				url : "<c:url value='/admin/gradAuth/selectGradAuthInfo.do'/>",
				async: false,
				dataType: "json",
		        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
				data : {gradAuthorSn:gradAuthorSn},
				success : function(data) {
					if (null!=data.gradInfoVO) {
						input_null();
						$('#insertForm').css('display','block');
	// 					console.log(data);
						
						//기본정보 표출
						$('#insertForm #gradAuthorSn').val(data.gradInfoVO.gradAuthorSn);
						$('#insertForm #gradAuthorNm').val(data.gradInfoVO.gradAuthorNm);
						$('#insertForm #gradAuthorDc').val(data.gradInfoVO.gradAuthorDc);
						$('#insertForm #gradAuthorUseAt').val(data.gradInfoVO.useAt);
						fn_change_checkbox_to_value('gradAuthorUseAt');
						$('#insertForm #gradAuthorDelAt').val(data.gradInfoVO.delAt);
						fn_change_checkbox_to_value('gradAuthorDelAt');
						
						
						//요금정보 표출
						for(i in data.gradAmountVO){
// 							for(var z = 1; z < $('#amountTb tr').size()-1; z++){
							for(var z = 1; z < $('#amountTb tr').length-1; z++){
								if($('#amountTb tr')[z].cells[1].children[1].value == data.gradAmountVO[i].useMonthCoCode){
									$('#amountTb tr')[z].cells[1].children[0].value = data.gradAmountVO[i].gradAmountSn;
									$('#amountTb tr')[z].cells[1].children[2].value = data.gradAmountVO[i].amount;
									var id = $('#amountTb tr')[z].cells[1].children[1].value;
									$('#amountTb #'+id).val(data.gradAmountVO[i].useAt);
									fn_change_checkbox_to_value(id);
								}	
							}
						}
						
						//권한정보 표출
						for(j in data.gradDetailInfoVO){
// 							for(var z = 0; z < $('#authTb tr').size(); z++){
							for(var z = 0; z < $('#authTb tr').length; z++){
								if($('#authTb tr')[z].cells[1].children[2].value == data.gradDetailInfoVO[j].authorCode){
									$('#authTb tr')[z].cells[1].children[3].value = data.gradDetailInfoVO[j].gradAuthorDetailSn;
									var id = $('#authTb tr')[z].cells[1].children[2].value;
									$('#authTb #'+id+"-01").val(data.gradDetailInfoVO[j].menuAccesAt);
									fn_change_checkbox_to_value(id+"-01");
									$('#authTb #'+id+"-02").val(data.gradDetailInfoVO[j].infoInqireAt);
									fn_change_checkbox_to_value(id+"-02");
									$('#authTb #'+id+"-03").val(data.gradDetailInfoVO[j].infoRegistAt);
									fn_change_checkbox_to_value(id+"-03");
									$('#authTb #'+id+"-04").val(data.gradDetailInfoVO[j].infoUpdtAt);
									fn_change_checkbox_to_value(id+"-04");
									$('#authTb #'+id+"-05").val(data.gradDetailInfoVO[j].infoDelAt);
									fn_change_checkbox_to_value(id+"-05");
									$('#authTb #'+id+"-06").val(data.gradDetailInfoVO[j].infoDspyAt);
									fn_change_checkbox_to_value(id+"-06");
									$('#authTb #'+id+"-07").val(data.gradDetailInfoVO[j].executAt);
									fn_change_checkbox_to_value(id+"-07");
								}
							}
						}
						
						$('.wrap-loading').addClass('display-none');
	// 					console.log("end");
					}
					else {
						
						Common.Dialog.alert({
		                    title: '등록실패'
		                    ,content: '등록에 실패했습니다.'
		                }); 
					}
				}
				,error : function(e) {
					$('.wrap-loading').addClass('display-none');
					Common.Dialog.alert({
		                title: '에러발생'
		                ,content: '에러가 발생하였습니다. 관리자에게 문의 바랍니다.'
		            }); 
				}
				,beforeSend:function(){
					$('.wrap-loading').removeClass('display-none');
			    }
			    ,complete:function(){
					
			    }
			}); 
			$('#insertForm input').prop('disabled',true);
			$(this).css('background-color','#fbcb00');
			if(!checkAuth("adm005001", "infoUpdtAt","")){
				$('#updateBtn').css('display','none');
			}
		}
	});

});

function fn_authTb_init(){
	$('#gradAuthListTb tr').css('background-color','');
	$('.wrap-loading').removeClass('display-none');
	$.ajax({
		type : "post", 
		url : "<c:url value='/json/auth.json'/>",
		async: false,
		dataType: "json",
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
		success : function(data) {
			var html = []; 
			$.each(data, function(i, item) { 
				
				html.push('<tr id="'+item.id+'">');
				html.push('<td>'+item.cl+'</td>');
				html.push('<td>'+item.name);
				html.push('<input type="hidden" name="authorNm" value="'+item.name+'"/>');
				html.push('<input type="hidden" name="authorDc" value="'+item.cl + "/" + item.name +'"/>');
				html.push('<input type="hidden" name="authorCode" value="'+item.id+'"/>');
				html.push('<input type="hidden" name="gradAuthorDetailSn" value=""/>');
				html.push('</td>');
				html.push('<td>');
				html.push('<input class="checkbox-input" type="checkbox" id="'+item.id+'-01Ck" title="메뉴접근권한" onchange="fn_change_checkbox('+"'"+item.id+'-01'+"'"+')">');
				html.push('<input class="checkbox-input" type="hidden" id="'+item.id+'-01" name="menuAccesAt" title="메뉴접근권한" value="N">');
				html.push('<label class="checkbox-inline" for="'+item.id+'-01Ck">허용</label>');
				html.push('</td>');
				html.push('<td>');
				html.push('<input class="checkbox-input" type="checkbox" id="'+item.id+'-02Ck" title="정보조회권한" onchange="fn_change_checkbox('+"'"+item.id+'-02'+"'"+')">');
				html.push('<input class="checkbox-input" type="hidden" id="'+item.id+'-02" name="infoInqireAt" title="정보조회권한" value="N">');
				html.push('<label class="checkbox-inline" for="'+item.id+'-02Ck">허용</label>');
				html.push('</td>');
				html.push('<td>');
				html.push('<input class="checkbox-input" type="checkbox" id="'+item.id+'-03Ck" title="정보등록권한" onchange="fn_change_checkbox('+"'"+item.id+'-03'+"'"+')">');
				html.push('<input class="checkbox-input" type="hidden" id="'+item.id+'-03" name="infoRegistAt" title="정보등록권한" value="N">');
				html.push('<label class="checkbox-inline" for="'+item.id+'-03Ck">허용</label>');
				html.push('</td>');
				html.push('<td>');
				html.push('<input class="checkbox-input" type="checkbox" id="'+item.id+'-04Ck" title="정보수정권한" onchange="fn_change_checkbox('+"'"+item.id+'-04'+"'"+')">');
				html.push('<input class="checkbox-input" type="hidden" id="'+item.id+'-04" name="infoUpdtAt" title="정보수정권한" value="N">');
				html.push('<label class="checkbox-inline" for="'+item.id+'-04Ck">허용</label>');
				html.push('</td>');
				html.push('<td>');
				html.push('<input class="checkbox-input" type="checkbox" id="'+item.id+'-05Ck" title="정보삭제권한" onchange="fn_change_checkbox('+"'"+item.id+'-05'+"'"+')">');
				html.push('<input class="checkbox-input" type="hidden" id="'+item.id+'-05" name="infoDelAt" title="정보삭제권한" value="N">');
				html.push('<label class="checkbox-inline" for="'+item.id+'-05Ck">허용</label>');
				html.push('</td>');
				html.push('<td>');
				html.push('<input class="checkbox-input" type="checkbox" id="'+item.id+'-06Ck" title="정보전시권한" onchange="fn_change_checkbox('+"'"+item.id+'-06'+"'"+')">');
				html.push('<input class="checkbox-input" type="hidden" id="'+item.id+'-06" name="infoDspyAt" title="정보전시권한" value="N">');
				html.push('<label class="checkbox-inline" for="'+item.id+'-06Ck">허용</label>');
				html.push('</td>');
				html.push('<td>');
				html.push('<input class="checkbox-input" type="checkbox" id="'+item.id+'-07Ck" title="실행&다운권한" onchange="fn_change_checkbox('+"'"+item.id+'-07'+"'"+')">');
				html.push('<input class="checkbox-input" type="hidden" id="'+item.id+'-07" name="executAt" title="실행&다운권한" value="N">');
				html.push('<label class="checkbox-inline" for="'+item.id+'-07Ck">허용</label>');
				html.push('</td>');
				html.push('</tr>');
				
	 			$('#authTb').html(html.join('')); 
	 			$('.wrap-loading').addClass('display-none');
			});
		}
		,error : function(e) {
			Common.Dialog.alert({
                title: '에러발생'
                ,content: '에러가 발생하였습니다. 관리자에게 문의 바랍니다.'
            }); 
		}
		,beforeSend:function(){
			$('.wrap-loading').removeClass('display-none');
	    }
	    ,complete:function(){
	    	$('.wrap-loading').addClass('display-none');
	    }
	}); 
}

function fn_search(){
	if(checkAuth("adm005001", "infoInqireAt","")){
		document.searchForm.pageIndex.value = 1;
		document.searchForm.action = "<c:url value='/admin/gradAuth/gradAuthManage.do'/>";
	   	document.searchForm.submit();
	}
}
	
	
function fn_egov_select_linkPage(pageNo){
	if(checkAuth("adm005001", "infoInqireAt","")){
		document.searchForm.pageIndex.value = pageNo;
		document.searchForm.action = "<c:url value='/admin/gradAuth/gradAuthManage.do'/>";
		document.searchForm.submit();
	}
}

function fn_change_checkbox(id){
	if($('#'+id+'Ck').is(":checked")){
		$('#'+id).val('Y');
	}else{
		$('#'+id).val('N');
	}
}

function fn_change_checkbox_to_value(id){
	if($('#'+id).val() == 'Y'){
		$('#'+id+'Ck').prop('checked',true);
	}else{
		$('#'+id+'Ck').prop('checked',false);
	}
}

function validate(){
	if ($('#gradAuthorNm').val() == '') {
		Common.Dialog.alert({
            content: '등급권한명을 입력해주세요.'
            ,ok : function(){
            	$('#gradAuthorNm').focus();
            }
        });
		return false;
	}
}

function fn_insert(){
// 	$('#infoTb input[type="checkbox"]').val('N');
// 	$('#infoTb input[type="checkbox"]:checked').val('Y');
// 	$('#amountTb input[type="checkbox"]').val('N');
// 	$('#amountTb input[type="checkbox"]:checked').val('Y');
// 	$('#authTb input[type="checkbox"]').val('N');
// 	$('#authTb input[type="checkbox"]:checked').val('Y');
	if(checkAuth("adm005001", "infoRegistAt","")){
		var data = $('#insertForm').serializeArray();
		Common.Dialog.confirm({
	        title: '등록',
	        content: '등급권한을 등록하시겠습니까?'
	        ,ok: function(){
	        	$.ajax({
	        		type:"POST",
	        		url:"<c:url value='/admin/gradAuth/insertGradAuthManage.do' />",
	//         		data:$('#insertForm').serializeArray(),
	        		data:data,
	        		dataType:'json',
	        		async:false,
	        		success:function(data){
	        			if (null != data) {
	        				Common.Dialog.alert({
			                    title: '등록'
			                    ,content: '등록 되었습니다.'
			                    ,ok : function(){
			                    	fn_search();
			                    }
			                }); 
	        			}
	        			else {
	        				Common.Dialog.alert({
			                    title: '등록실패'
			                    ,content: '등록에 실패했습니다.'
			                }); 
	        			}
	        		}
	        		,error : function(e) {
	        			Common.Dialog.alert({
		                    title: '에러발생'
		                    ,content: '에러가 발생하였습니다. 관리자에게 문의 바랍니다.'
		                }); 
					}
	        		,beforeSend:function(){
	        			$('.wrap-loading').removeClass('display-none');
	        	    }
	        	    ,complete:function(){
	        	    	$('.wrap-loading').addClass('display-none');
	        	    }
	        	});
	        }
	    });    
	}
}

function scrollAnimate(id,time,pd){
	var location = document.getElementById(id).offsetTop-127;
	if(pd){	location -= pd;}
	$('html').animate({scrollTop:location},time);
	$('#gradAuthorNm').focus();
}

//신규버튼
function newBtn(){
	if(checkAuth("adm005001", "infoRegistAt","")){
		//초기화
		input_null();
		$('#insertForm input').prop('disabled',false);
		$('#insertForm').css('display','block');
// 		$('#gradAuthorNm').focus();
		scrollAnimate('insertForm','700');
		
		$('#updateBtn').css('display','none');
		$('#insertBtn').css('display','inline-block');
		$('#cancelBtn').css('display','none');
		$('#newcancelBtn').css('display','inline-block');
	}
}


function updateBtn(){
	if(checkAuth("adm005001", "infoUpdtAt","")){
		//초기화
		$('#insertForm input').prop('disabled',false);
		$('#insertForm').css('display','block');
		scrollAnimate('insertForm','700');
// 		$('#gradAuthorNm').focus();
		
		$('#updateBtn').css('display','none');
		$('#insertBtn').css('display','inline-block');
		$('#cancelBtn').css('display','inline-block');
		$('#newcancelBtn').css('display','none');
	}
}

function cancelBtn(){
	
	$('#insertForm input').prop('disabled',true);
	$('#insertForm').css('display','block');
	scrollAnimate('insertForm','700');
// 	$('#gradAuthorNm').focus();
	
	$('#updateBtn').css('display','inline-block');
	$('#insertBtn').css('display','none');
	$('#cancelBtn').css('display','none');
	$('#newcancelBtn').css('display','none');
}
function newcancelBtn(){
	
	$('#insertForm input').prop('disabled',false);
	$('#insertForm').css('display','none');
	scrollAnimate('txt','700');
		
	$('#updateBtn').css('display','inline-block');
	$('#insertBtn').css('display','none');
	$('#cancelBtn').css('display','none');
	$('#newcancelBtn').css('display','none');
}

//인풋창들 초기화
function input_null(){
	//기본정보 초기화
	$('#gradAuthorSn').val("");
	$('#infoTb input[type=hidden]').val("");
	$('#infoTb input[type=text]').val("");
	$('#infoTb #gradAuthorUseAtCk').prop('checked',true);
	if("Y" == checkAuthValue("adm005001", "infoDspyAt")){
		$('#infoTb #gradAuthorUseAt').val("Y");
	}else{
		$('#infoTb #gradAuthorUseAt').val("N");
	}
	$('#infoTb #gradAuthorDelAtCk').prop('checked',false);
	$('#infoTb #gradAuthorDelAt').val("N");
	
	//금액정보 초기화
	$('.gradAmountSn').val("");
	$('#amountTb .money').val("");	//변경 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	$('#amountTb input[type=checkbox]').prop('checked',true);
	if("Y" == checkAuthValue("adm005001", "infoDspyAt")){
		$('#amountTb input[name="amountUseAt"]').val("Y");
	}else{
		$('#amountTb input[name="amountUseAt"]').val("N");
	}
	
	//권한정보 초기화
	$('#authTb input[name="gradAuthorDetailSn"]').val("");
	$('#authTb input[type=checkbox]').prop('checked',false);
	$('#authTb input[name="menuAccesAt"]').val("N");
	$('#authTb input[name="infoInqireAt"]').val("N");
	$('#authTb input[name="infoRegistAt"]').val("N");
	$('#authTb input[name="infoUpdtAt"]').val("N");
	$('#authTb input[name="infoDelAt"]').val("N");
	$('#authTb input[name="infoDspyAt"]').val("N");
	$('#authTb input[name="executAt"]').val("N");
// 	fn_authTb_init();
	
	
}
</script>
	
	
<style>
.checkbox-inline, .radio-inline{line-height: 22px;padding: 17px 0;padding-left: 3px;margin-right: 3px;margin-left: 0;}
.authList{max-height:300px;overflow-y:auto;}
.auth{max-height:500px;overflow-y:auto;}
.authList .table_info thead tr th{position: sticky;top: 0px;z-index: 1;}
.auth .table_info thead tr th{position: sticky;top: 0px;z-index: 1;transform:scale(0.999);}

.wrap-loading {position: fixed;left: 0;right: 0;top: 0;bottom: 0;background: rgba(0, 0, 0, 0.2);filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000',endColorstr='#20000000');z-index: 100;}
.wrap-loading div {position: fixed;top: 50%;left: 50%;margin-left: -128px;margin-top: -128px;}
.display-none {display: none;}

</style>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="/WEB-INF/jsp/gzonei/layout/admintop.jsp" %>



<!-- header -->

<div id="body_layout">	

    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
            <div id="location" class="title_wrap">
                <h2 class="page__title">등급권한관리</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="<c:url value='/admin/gradAuth/gradAuthManage.do'/>">등급권한관리</a></li>
                        <li class="n3"><a href="<c:url value='/admin/gradAuth/gradAuthManage.do'/>" class="navi_ov">등급권한관리</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>  
            
            <div id="">
            <form name="searchForm" id="searchForm" method="post" onsubmit="return fn_search()">
            <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
            <fieldset>
					 <legend>검색</legend>
					 <div class="search custom-search">
					 <div class="form-group p-row">
							<span class="p-col-4 p-col-sm-24 tit">등급권한 명</span>
							<div class="p-col-17 p-col-sm-24">
	                       	 <input type="text" name="gradAuthorNm" value="${searchVO.gradAuthorNm}" title="검색어를 입력해주세요" placeholder="검색어를 입력해주세요" class="p-control">
	                       </div>
							<div class="p-col-3  p-col-sm-24">
	                       	 <input type="submit" value="검색" class="submit">
	                       </div>
						</div>
					 </div>
				</fieldset>
            </form>
            </div>
        
            <div id="txt">
	            <h2 class="h2">등급권한 목록</h2>
             	<div class="board_btm2">
                    <div class="btns_area fl_r mo_block" id="newBtn">
                        <a href="javascript:newBtn();" class="btn btn-default btn-sm">신규</a>
                    </div>
                </div>
                <p>총 등급권한 수 : <fmt:formatNumber value="${paginationInfo.totalRecordCount}" pattern="#,###" />건</p>
	            <div class="table_wrap authList">
                    <table class="table_info" >
						<colgroup>
							<col style="width:20%">
							<col style="width:auto">
							<col style="width:10%">
							<col style="width:10%">
							<col style="width:10%">
							<col style="width:10%">
						</colgroup>
                        <thead>
                            <tr>
                                <th>등급권한 명</th>
                                <th>등급권한 설명</th>
                                <th>사용여부</th>
                                <th>삭제여부</th>
                                <th>최종수정자ID</th>
                                <th>최종수정일시</th>
                            </tr>
                        </thead>
                        <tbody id="gradAuthListTb">
                        	<c:choose>
								<c:when test="${resultList == null or fn:length(resultList) == 0 }">
									<tr><td colspan="6">조회된 권한이 없습니다.</td></tr>
								</c:when>
								<c:otherwise>
	                        	<c:forEach items="${resultList}" var="resultList" varStatus="status">
	                        	<tr>
	                        		<td>
	                        		<input type="hidden" name="gradAuthorSn" value="${resultList.gradAuthorSn}" >
	                        		${resultList.gradAuthorNm}
	                        		</td>
	                                <td class="subject">${resultList.gradAuthorDc}</td>
	                                <td>
	                                <c:choose>
									<c:when test="${resultList.useAt eq 'Y'}">
										사용
									</c:when>
									<c:when test="${resultList.useAt eq 'N'}">
										미사용
									</c:when>
									</c:choose>
	                                </td>
	                                <td>
	                                <c:choose>
									<c:when test="${resultList.delAt eq 'Y'}">
										삭제
									</c:when>
									<c:when test="${resultList.delAt eq 'N'}">
										사용
									</c:when>
									</c:choose>
	                                </td>
	                                <td>${resultList.lastUpdusrId}</td>
	                                <td>${resultList.lastUpdtPnttm}</td>
	                        	</tr>
	                        	</c:forEach>
	                        	</c:otherwise>
	                        </c:choose>
                        </tbody>                            
                    </table>
                </div>
                <div class="pagination-inner">
					<ul class="pagination">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_linkPage"/>
					</ul>
                </div>
                
                <form name="insertForm" id="insertForm" method="post" onsubmit="return false">
                <input type="hidden" id="gradAuthorSn" name="gradAuthorSn" value="">
                <h2 class="h2">등급 권한 기본정보</h2>
                <div class="table_wrap">
                    <table class="table_info">
	                    <colgroup>
							<col style="width:10%">
							<col style="width:20%">
							<col style="width:10%">
							<col style="width:auto">
							<col style="width:7%">
							<col style="width:7%">
							<col style="width:7%">
							<col style="width:7%">
						</colgroup>
                        <tbody id="infoTb">
                            <tr>
                                <th>등급권한 명</th>
                                <td>
	                                <input type="text" id="gradAuthorNm" name="gradAuthorNm" title="" class="form-control" value="" placeholder="ex) 프리미엄(스페셜)" maxlength="190">
                                </td>
                                <th>등급권한 설명</th>
                                <td>
	                                <input type="text" id="gradAuthorDc" name="gradAuthorDc" title="" class="form-control" value="" placeholder="ex) 프리미엄(스페셜) 2021년 5월 1일 생성" maxlength="1900">
                                </td>
                                <th>사용여부</th>
                                <td>
                                	<c:if test="${sessionScope.authVO.adm005001.infoDspyAt == 'Y'}">
	                                <input class="checkbox-input" type="checkbox" id="gradAuthorUseAtCk" title="사용" onchange="fn_change_checkbox('gradAuthorUseAt')" checked>
				                    <label class="checkbox-inline" for="gradAuthorUseAtCk">사용</label>
	                                <input class="checkbox-input" type="hidden" id="gradAuthorUseAt" name="gradAuthorUseAt" title="사용" value="Y">
	                                </c:if>
                                	<c:if test="${sessionScope.authVO.adm005001.infoDspyAt == 'N'}">
	                                <input class="checkbox-input" type="checkbox" id="gradAuthorUseAtCk" title="사용" checked style="display:none;">
				                    <label class="checkbox-inline" for="gradAuthorUseAtCk">수정불가</label>
	                                <input class="checkbox-input" type="hidden" id="gradAuthorUseAt" name="gradAuthorUseAt" title="사용" value="N">
	                                </c:if>
                                </td>
                                <th>삭제여부</th>
                                <td>
                                	<c:if test="${sessionScope.authVO.adm005001.infoDelAt == 'Y'}">
	                                <input class="checkbox-input" type="checkbox" id="gradAuthorDelAtCk" title="사용" onchange="fn_change_checkbox('gradAuthorDelAt')" >
				                    <label class="checkbox-inline" for="gradAuthorDelAtCk">삭제</label>
	                                </c:if>
                                	<c:if test="${sessionScope.authVO.adm005001.infoDelAt == 'N'}">
	                                <input class="checkbox-input" type="checkbox" id="gradAuthorDelAtCk" title="사용" style="display:none;">
				                    <label class="checkbox-inline" for="gradAuthorDelAtCk">수정불가</label>
	                                </c:if>
	                                <input class="checkbox-input" type="hidden" id="gradAuthorDelAt" name="gradAuthorDelAt" title="사용" value="N">
                                </td>
                            </tr>
                        </tbody>                            
                    </table>
                    <br/>
                    <h2 class="h2">등급 요금 정보</h2>
                    <table class="table_info">
	                    <colgroup>
							<col style="width:10%">
							<col style="width:10%">
							<col style="width:auto">
							<col style="width:10%">
							<col style="width:10%">
						</colgroup>
                        <tbody id="amountTb">
                        	<tr>
                        		<th colspan="5">상품 가격</th>
                        	</tr>
                        	<c:forEach items="${monthCode}" var="monthCode" varStatus="status">
<%--                             <tr id="${monthCode.codeId}"> --%>
                            <tr>
                                <td>
	                                ${monthCode.codeIdNm}
                                </td>
                                <td colspan="2">
                                	<input type="hidden" name="gradAmountSn" class="gradAmountSn" value="">
	                                <input type="hidden" name="useMonthCoCode" title="" class="form-control" value="${monthCode.codeId}">
	                                <input type="text" name="amount" title="" class="form-control money" value="" placeholder="ex) 1000000" maxlength="15">
                                </td>
                                <th>사용여부</th>
                                <td>
                                	<c:if test="${sessionScope.authVO.adm005001.infoDspyAt == 'Y'}">
	                                <input class="checkbox-input" type="checkbox" id="${monthCode.codeId}Ck"title="사용" onchange="fn_change_checkbox('${monthCode.codeId}')"checked>
				                    <label class="checkbox-inline" for="${monthCode.codeId}Ck">사용</label>
	                                <input class="checkbox-input" type="hidden" id="${monthCode.codeId}" name="amountUseAt" title="사용" value="Y">
	                                </c:if>
                                	<c:if test="${sessionScope.authVO.adm005001.infoDspyAt == 'N'}">
	                                <input class="checkbox-input" type="checkbox" id="${monthCode.codeId}Ck"title="사용" checked style="display:none;">
				                    <label class="checkbox-inline" for="${monthCode.codeId}Ck">수정불가</label>
	                                <input class="checkbox-input" type="hidden" id="${monthCode.codeId}" name="amountUseAt" title="사용" value="N">
	                                </c:if>
                                </td>
                            </tr>
                            </c:forEach>
                            
                             <tr style="display:none;">
                                <th>
	                                	서비스 지역
                                </th>
                                <td colspan="5">
	                                <input type="hidden" id="srvcSeCode" name="srvcSeCode" title="" class="form-control" value="S001">
                                </td>
                            </tr>
                        </tbody>                            
                    </table>
                </div>
                
                <h2 class="h2">등급 권한 상세</h2>
                <div class="table_wrap auth">
                    <table class="table_info">
						<colgroup>
							<col style="width:10%">
							<col style="width:auto">
							<col style="width:8%">
							<col style="width:8%">
							<col style="width:8%">
							<col style="width:8%">
							<col style="width:8%">
							<col style="width:8%">
							<col style="width:8%">
						</colgroup>
                        <thead>
                            <tr>
                                <th>분류</th>
                                <th>권한명</th>
                                <th>접근 권한</th>
                                <th>정보조회 권한</th>
                                <th>등록 권한</th>
                                <th>수정 권한</th>
                                <th>삭제 권한</th>
                                <th>전시 권한</th>
                                <th>실행/다운 권한</th>
                            </tr>
                        </thead>
                        <tbody id="authTb">
                        <!-- 
                            <tr id="bbs-01-01">
                                <td>게시판</td>
                                <td>Today보상계획공고-목록
                                <input type="hidden" name="authorNm" value="bbs-01-01"/>
                                <input type="hidden" name="gradAuthorDetailSn" value=""/>
                                </td>
                                <td>
	                                <input class="checkbox-input" type="checkbox" id="bbs-01-01-01" name="menuAccesAt" title="메뉴접근권한" value="N">
	                            	<label class="checkbox-inline" for="bbs-01-01-01">허용</label>
	                            </td>
                                <td>
	                                <input class="checkbox-input" type="checkbox" id="bbs-01-01-02" name="infoInqireAt" title="정보조회권한" value="N">
	                            	<label class="checkbox-inline" for="bbs-01-01-02">허용</label>
	                            </td>
                                <td>
	                                <input class="checkbox-input" type="checkbox" id="bbs-01-01-03" name="infoRegistAt" title="정보등록권한" value="N">
	                            	<label class="checkbox-inline" for="bbs-01-01-03">허용</label>
	                            </td>
                                <td>
	                                <input class="checkbox-input" type="checkbox" id="bbs-01-01-04" name="infoUpdtAt" title="정보수정권한" value="N">
	                            	<label class="checkbox-inline" for="bbs-01-01-04">허용</label>
	                            </td>
                                <td>
	                                <input class="checkbox-input" type="checkbox" id="bbs-01-01-05" name="infoDelAt" title="정보삭제권한" value="N">
	                            	<label class="checkbox-inline" for="bbs-01-01-05">허용</label>
	                            </td>
                                <td>
	                                <input class="checkbox-input" type="checkbox" id="bbs-01-01-06" name="infoDspyAt" title="정보전시권한" value="N">
	                            	<label class="checkbox-inline" for="bbs-01-01-06">허용</label>
	                            </td>
                                <td>
	                                <input class="checkbox-input" type="checkbox" id="bbs-01-01-07" name="executAt" title="실행&다운권한" value="N">
	                            	<label class="checkbox-inline" for="bbs-01-01-07">허용</label>
	                            </td>
                            </tr>
                             -->
                        </tbody>                            
                    </table>
                </div>


			
                <div class="board_btm">
                    <div class="btns_area fl_r mo_block">
                        <a id="updateBtn" href="javascript:updateBtn();" class="btn btn-default">수정</a>
                        <a id="insertBtn" href="javascript:fn_insert();" class="btn btn-primary">저장</a>
						<a id="cancelBtn" href="javascript:cancelBtn();" class="btn btn-secondary">취소</a>
						<a id="newcancelBtn" href="javascript:newcancelBtn();" class="btn btn-secondary">취소</a>
                    </div>
                </div>
			</form>
			
            <!-- content 영역입니다. -->	
            </div>
        </div>
    </div>
    <!-- layout -->
</div>
	<!-- contents -->
	
<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>



</body>
</html>