<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang='ko'>
<head>
<%@ include file="/WEB-INF/jsp/gzonei/layout/header.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/jsp/gzonei/layout/admintop.jsp" %>
<script>
$(document).ready(function(){
// 	$("#wct").focus(function(){
// 		var wctVal = $("#wct").val();
// 		if(wctVal.length > 0){
// 			alert("d");
// 		}
// 	});

	
	//권한 --접근
	checkAuth("adm002003", "menuAccesAt",""); //접근

    $.datetimepicker.setLocale('ko');
	$("#bsnsBgnde").datetimepicker({
        timepicker : false,
        format : 'Y-m-d',
        scrollMonth : false,
        scrollInput : false,
        validateOnBlur: false,
        onShow:function(){
            var end = $("#bsnsEndde").val();
            
            this.setOptions({
              maxDate: end? end : false,
              
              dateFormat: 'Y-m-d'
              
            })
          }
    	
    }).on('keydown', function(event){
    	onlyNum(this,event);
		});
    
    $("#bsnsEndde").datetimepicker({
        timepicker : false,
        format : 'Y-m-d',
        scrollMonth : false,
        scrollInput : false,
        validateOnBlur: false,
        onShow:function(){
            
             var start = $("#bsnsBgnde").val();
             this.setOptions({
               minDate: start? start : false,
               dateFormat: 'Y-m-d'
              
             })
           }
        
    }).on('keydown', function(event){
    	onlyNum(this,event);
		});
    
    $("#dscssRewardBeginDe,#bsnsrcognNtfcDe").datetimepicker({
        timepicker : false,
        format : 'Y-m-d',
        scrollMonth : false,
        scrollInput : false,
        validateOnBlur: false
    }).on('keydown', function(event){
    	onlyNum(this,event);
		});  
    
    $("#wct,#lct").on('keyup',function(event){
     
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

    	 
    })
   
    
    document.getElementById('wct').addEventListener('keyup', function(event) {
    	this.value = this.value.replace(/^0/,'');
    });
    
    document.getElementById('lct').addEventListener('keyup', function(event) {
    	this.value = this.value.replace(/^0/,'');
    });
    
    document.getElementById('wct').addEventListener('click', function(event) {
    	this.value = this.value.replace(/^0/,'');
    });
    
    document.getElementById('lct').addEventListener('click', function(event) {
    	this.value = this.value.replace(/^0/,'');
    });
    

});
/*********************************************************
 * 검색
 ******************************************************** */
function fn_search(pageIndex,search){
	
	if(pageIndex == '' || (pageIndex == '' && search == "search") || (pageIndex != '' && search == "search")){		
		document.searchForm.pageIndex.value = 1;
	}else{
		document.searchForm.pageIndex.value = pageIndex;
	}
// 	document.searchForm.pageIndex.value=1;
	document.searchForm.action = "<c:url value='/admin/today/reqDevelopInfo.do'/>";
   	document.searchForm.submit();
}
/*********************************************************
 * 입력 마감일 갱신
 ******************************************************** */   
function fn_infoReset(sn){
	$("#modal_infoReset").modal();
}

/*********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_select_linkPage(pageNo){
	document.searchForm.pageIndex.value = pageNo;
	document.searchForm.action = "<c:url value='/admin/today/reqDevelopInfo.do'/>";
   	document.searchForm.submit();
}

/*********************************************************
 *상세정보 조회
 ******************************************************** */
function fn_selectReqDevInfo(sn){
	//정보조회 권한체크
	if(checkAuth("adm002003", "infoInqireAt","")){
		$("#bsnsBgnde").attr('placeholder','시작일');
		$("#bsnsBgnde").val("");
		$("#bsnsEndde").attr('placeholder','종료일');
		$("#bsnsEndde").val("");
		$("#dscssRewardBeginDe").attr('placeholder','협의보상개시일');
		$("#dscssRewardBeginDe").val("");
		$("#bsnsrcognNtfcDe").attr('placeholder','사업인정시점');
		$("#bsnsrcognNtfcDe").val("");
		$("#wct").val("");
		$("#lct").val("");
		$("#devlopInfoSn").val("");
		
		$.ajax({
			type:"POST",
			url:"<c:url value='/admin/today/selectReqDevInfo.do' />",
			data:{
				"devlopInfoSn": sn 			
			},
			dataType:"JSON",
			cache : false,
			success:function(data){
				$("#devlopInfoSn").val(sn);
				$("#bsnsBgnde").val(addDash(data.bsnsBgnde));
				$("#bsnsEndde").val(addDash(data.bsnsEndde));
				$("#dscssRewardBeginDe").val(addDash(data.dscssRewardBeginDe));
				$("#bsnsrcognNtfcDe").val(addDash(data.bsnsrcognNtfcDe));
				
				if(data.wct != null){
					var wctnum = data.wct;
				 	wctnum = wctnum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
					$("#wct").val(wctnum);
				}
				
				if(data.lct != null){
					var lctnum = data.lct;
				 	lctnum = lctnum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
					$("#lct").val(lctnum);
				}
				$("#modal_updateInfo").modal();
				
			}
		});
	}
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
 *상세정보 수정
 ******************************************************** */
function fn_udtDevlopInfo(){
	//수정권한체크
	if(checkAuth("adm002003", "infoUpdtAt","")){
		var bsnsBgnde = $("#bsnsBgnde");
		var bsnsEndde = $("#bsnsEndde");
		var dscssRewardBeginDe = $("#dscssRewardBeginDe");
		var bsnsrcognNtfcDe = $("#bsnsrcognNtfcDe");
		
		bsnsBgnde.val(bsnsBgnde.val().replace(/-/gi,''));
		bsnsEndde.val(bsnsEndde.val().replace(/-/gi,''));
		dscssRewardBeginDe.val(dscssRewardBeginDe.val().replace(/-/gi,''));
		bsnsrcognNtfcDe.val(bsnsrcognNtfcDe.val().replace(/-/gi,''));
		
		if($("#wct").val() != ""){
			var wct = $("#wct");
			wct.val(wct.val().replace(/,/gi,''));
		}
		
		if($("#lct").val() != ""){
			var lct = $("#lct");
			lct.val(lct.val().replace(/,/gi,''));
		} 
		
	
		var params = $("#udtDevlop").serialize();
		$.ajax({
			type:"POST",
			url:"<c:url value='/admin/today/udtDevlopInfo.do' />",
			data:params,
			dataType:"JSON",
			cache : false,
			success:function(result){
				if(result.result == '1'){
					Common.Dialog.alert({
			            title: '개발정보 수정'
			            ,content: '해당 개발정보 수정 완료'
			        	,ok: function(){
			        		var index = $("#pageIndex").val();
			        		fn_search(index);
			                console.log('확인 클릭');
			            }
			        });
				}else{
					Common.Dialog.alert({
			            title: '개발정보 수정'
			            ,content: '해당 개발정보 수정 실패'
			        	,ok: function(){		
							fn_search();
			                console.log('확인 클릭');
			            }
			        });
				}
			}
			
		});
	}
}

function addDash(noDash){
	   if(noDash!=null){
	      return noDash.substring(0,4)+"-"+noDash.substring(4,6)+"-"+noDash.substring(6,8);
	   }else{
	      return "";
	   }
	}
	
/*********************************************************
 *개발정보 페이지로 이동
 ******************************************************** */	
function fn_toDevBtn(sn){
	if(checkAuth("adm002002", "infoInqireAt","")){
		document.searchForm.devlopInfoSn.value = sn;
		document.searchForm.action = "<c:url value='/map.do'/>";
		document.searchForm.target = "_blank";
	   	document.searchForm.submit();
	}
}
</script>
<!-- 구현부 : S -->
<div id="body_layout">	
    <!-- layout -->
    <div class="body_wrap layout"> 
		<div id="contens" class="contents_wrap">
			<!-- 상단 -->
			<div id="location" class="title_wrap">
               <h2 class="page__title">개발정보 필수정보</h2>
               <!-- 유틸 시작 -->
               <div class="utile_wrap">
                   <!-- 로케이션 시작 -->
                   <ul class="location_wrap">
                       <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                       <li class="n2"><a href="<c:url value='/admin/today/prtnSttus.do'/>">오늘의 정보</a></li>
                       <li class="n3"><a href="<c:url value='/admin/today/reqDevelopInfo.do'/>" class="navi_ov">개발정보 필수정보</a></li>
                   </ul>                           
                   <!-- 로케이션 끝 -->
               </div>
               <!-- 유틸 끝 -->   
           </div>
		   
		   <div id="txt">
		   <form name="searchForm" method="post" action="javascript:fn_search('${paginationInfo.currentPageNo}','search');" >
			<input name="pageIndex" type="hidden" id="pageIndex" value="<c:out value='${paginationInfo.currentPageNo}'/>"/>
<!-- 			<form name="searchForm" method="post" action="javascript:fn_search();" > -->
<%-- 			<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/> --%>
			<input type="hidden" name="devlopInfoSn" value=""/>
			<input name="emplyrId" type="hidden" value="">
				 <fieldset>
					 <legend>검색</legend>
					 <div class="search custom-search">
						<div class="form-group p-row">
							<span class="p-col-3 p-col-sm-6 tit">정렬조건</span>
							<div class="p-col-18 p-col-sm-18">
	                       	 	<div class="checkbox-group text-left">
									<label class="checkbox-inline" for="id1">
								    	<input type="checkbox" id="id1" name="type" value="bsns_bgnde"
									    <c:forEach var="item" items="${searchVO.type}">
									    <c:if test="${item eq 'bsns_bgnde'}">checked="checked"</c:if>
			                 			</c:forEach>
			                 			 >사업기간
									</label>
									<label class="checkbox-inline" for="id2">
									    <input type="checkbox" id="id2" name="type" value="dscss_reward_begin_de"
									    <c:forEach var="item" items="${searchVO.type}">
									    <c:if test="${item eq 'dscss_reward_begin_de'}">checked="checked"</c:if>
			                 			</c:forEach>
			                 			 >협의보상개시
									</label>
									<label class="checkbox-inline" for="id3">
									    <input type="checkbox" id="id3" name="type" value="bsnsrcogn_ntfc_de"
									    <c:forEach var="item" items="${searchVO.type}">
									    <c:if test="${item eq 'bsnsrcogn_ntfc_de'}">checked="checked"</c:if>
			                 			</c:forEach>
			                 			 >사업인정시점
									</label>
									<label class="checkbox-inline" for="id4">
									    <input type="checkbox" id="id4" name="type" value="wct"
									    <c:forEach var="item" items="${searchVO.type}">
									    <c:if test="${item eq 'wct'}">checked="checked"</c:if>
			                 			</c:forEach>
			                 			 >사업비
									</label>
									<label class="checkbox-inline" for="id5">
									    <input type="checkbox" id="id5" name="type" value="lct"
									    <c:forEach var="item" items="${searchVO.type}">
									    <c:if test="${item eq 'lct'}">checked="checked"</c:if>
			                 			</c:forEach>
			                 			 >용지비
									</label>
								</div>
							</div>
						</div>
						<div class="form-group p-row">
<!-- 							<span class="p-col-2 p-col-sm-6 tit">입력마감일</span> -->
<!-- 							<span class="p-col-1 p-col-sm-6 tit"></span> -->
<!-- 	                       <div class="p-col-4 p-col-sm-9"> -->
<!-- 									<input type="text" class="p-control" name="endDate" id="endDate" placeholder="마감일" value="" title="시작일 입력"> -->
<!-- 									<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button> -->
<!-- 							</div>  -->
<!-- 							<span class="p-col-1 p-col-sm-6 tit"></span> -->
								
							<span class="p-col-3 p-col-sm-6 tit">개발 사업명</span>
							<div class="p-col-18  p-col-sm-18">
								<input type="text" name="searchKrwd" value="${searchVO.searchKrwd}" title="검색어를 입력해주세요" placeholder="검색어를 입력해주세요" class="p-control">
	                       </div>
	                       <div class="p-col-2  p-col-sm-24">
	                       	 <input type="submit" value="검색" class="submit">
	                       </div>
						</div>	
                    </div>
				 </fieldset>
			 </form>
		   <!-- Table : S -->
			<div class="table-responsive mt_20">
			<p style="margin: 10px 0 0; font-size:16px; color:#666;">총 : <fmt:formatNumber value="${totCnt}" pattern="#,###" />건</p>
				<table class="table table-bordered text-center">
					<colgroup>
						<col style="width:10%">
						<col style="width:40%">
<%-- 						<col style="width:15%"> --%>
<%-- 						<col style="width:10%"> --%>
						<col style="width:10%">
						<col style="width:10%">
						<col style="width:10%">
						<col style="width:10%">
						<col style="width:10%">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">개발사업명</th>
<!-- 							<th scope="col">입력마감일</th> -->
<!-- 							<th scope="col">갱신/누적 횟수</th> -->
							<th scope="col">사업기간</th>
							<th scope="col">협의보상개시</th>
							<th scope="col">사업인정시점</th>
							<th scope="col">사업비</th>
							<th scope="col">용지비</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
							<tr>
								<td>${resultInfo.dwkNo }</td>
<%-- 								<td>${resultInfo.dwkNm }</td> --%>
								<td>
									<a id="${resultInfo.devlopInfoSn}" class="bt toDevBtn" href="javascript:fn_toDevBtn('${resultInfo.devlopInfoSn}')">
									${resultInfo.dwkNm }
									</a>
								</td>
<!-- 								<td>마감날짜</td> -->
<%-- 								<td><button onclick="javascript:fn_infoReset('${resultInfo.devlopInfoSn }');" class="btn btn-default btn-outline btn-icon" type="button" style="height:35px; font-size:14px; line-height:0.8;">갱신</button><br>누적<span>1</span>회</td> --%>
								<c:choose>
									<c:when test="${resultInfo.bsnsBgnde == null or resultInfo.bsnsEndde == null  }">
											<td>
												<a id="${resultInfo.devlopInfoSn }" href="javascript:fn_selectReqDevInfo('${resultInfo.devlopInfoSn }')" style="text-decoration:underline; color:#3399FF">입력</a>
											</td>
									</c:when>
									<c:otherwise>
											<td>
												<a id="${resultInfo.devlopInfoSn }" href="javascript:fn_selectReqDevInfo('${resultInfo.devlopInfoSn }')">입력완료</a>
											</td>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${resultInfo.dscssRewardBeginDe == null }">
											<td>
												<a id="${resultInfo.devlopInfoSn }" href="javascript:fn_selectReqDevInfo('${resultInfo.devlopInfoSn }')" style="text-decoration:underline; color:#3399FF">입력</a>
											</td>
									</c:when>
									<c:otherwise>
											<td>
												<a id="${resultInfo.devlopInfoSn }" href="javascript:fn_selectReqDevInfo('${resultInfo.devlopInfoSn }')">입력완료</a>
											</td>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${resultInfo.bsnsrcognNtfcDe == null}">
											<td>
												<a id="${resultInfo.devlopInfoSn }" href="javascript:fn_selectReqDevInfo('${resultInfo.devlopInfoSn }')" style="text-decoration:underline; color:#3399FF">입력</a>
											</td>
									</c:when>
									<c:otherwise>
											<td>
												<a id="${resultInfo.devlopInfoSn }" href="javascript:fn_selectReqDevInfo('${resultInfo.devlopInfoSn }')">입력완료</a>
											</td>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${resultInfo.wct == null or resultInfo.wct eq '0'}">
											<td>
												<a id="${resultInfo.devlopInfoSn }" href="javascript:fn_selectReqDevInfo('${resultInfo.devlopInfoSn }')" style="text-decoration:underline; color:#3399FF">입력</a>
											</td>
									</c:when>
									<c:otherwise>
											<td>
												<a id="${resultInfo.devlopInfoSn }" href="javascript:fn_selectReqDevInfo('${resultInfo.devlopInfoSn }')">입력완료</a>
											</td>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${resultInfo.lct == null or resultInfo.lct eq '0'}">
											<td>
												<a id="${resultInfo.devlopInfoSn }" href="javascript:fn_selectReqDevInfo('${resultInfo.devlopInfoSn }')" style="text-decoration:underline; color:#3399FF">입력</a>
											</td>
									</c:when>
									<c:otherwise>
											<td>
												<a id="${resultInfo.devlopInfoSn }" href="javascript:fn_selectReqDevInfo('${resultInfo.devlopInfoSn }')">입력완료</a>
											</td>
									</c:otherwise>
								</c:choose>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
							
			<!-- Table : E -->
			<!-- Paging : S -->
				<div class="pagination-inner">
					<ul class="pagination">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_linkPage"/>
					</ul>
                </div>
				<!-- Paging : E -->	
		</div>
		</div>
	</div>
</div>
<!-- Modal Sample ::S -->
				
				<div class="modal fade" role="dialog" data-ly-type="content" data-ly-target="modal_infoReset" id="modal_infoReset">
				    <div class="modal-dialog">
				        <!-- Modal content-->
				        <div class="modal__body">
				            <div class="modal__header">
				               <h4 class="modal__title">갱신</h4>
				               <div class="modal__close-button"><button type="button" class="close" data-dismiss="modal">닫기</button></div>
				            </div>
				            <div class="modal__content" style="word-break: break-all">
				                <div class="cont_wrap">
					               <div class="modal__board">
						               						               
					                    <div class="form-horizontal bucket-form">
						                   <div class="form-group">
											   <div class="p-col-6 p-col-sm-6 control-label p-col-lg-2"><label for="select">입력마감일​</label></div>
											   <div class="p-col-15 p-col-sm-9" style="padding: 17px 3px;">
											    	<div class="search--calendar">
														<span>
															<input type="text" class="form-control" name="resetDate" id="startDate" placeholder="입력마감일" value="" title="시작일 입력">
															<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
														</span>
													</div>
												</div>
											</div>       
					                    </div>
					                    <div class="board_btm">
					                        <div class="btns_area fl_r mo_block">
						                        <a href="#" class="btn btn-default">확인</a>
					                            <a href="#" class="btn btn-default" data-dismiss="modal">취소</a>
					                        </div>
					                    </div>
					                </div>
				                </div>
				            </div>
						</div>
					</div>
				</div>
				
				<!-- Modal Sample ::S -->
				
				<div class="modal fade" role="dialog" data-ly-type="content" data-ly-target="modal_updateInfo" id="modal_updateInfo">
				    <div class="modal-dialog">
				        <!-- Modal content-->
				        <div class="modal__body">
				            <div class="modal__header">
				               <h4 class="modal__title">상세내역</h4>
				               <div class="modal__close-button"><button type="button" class="close" data-dismiss="modal">닫기</button></div>
				            </div>
				            <div class="modal__content" style="word-break: break-all">
				                <div class="cont_wrap">
					               <div class="modal__board">
						               	<form name="udtDevlop" id="udtDevlop" method="post">	
						               	<input type="hidden" id="devlopInfoSn" name="devlopInfoSn" value="">			               
					                    <div class="form-horizontal bucket-form">
						                   <div class="form-group">
											   <div class="p-col-6 p-col-sm-6 control-label p-col-lg-2"><label for="select">사업기간​</label></div>
											   <div class="p-col-9 p-col-sm-9">
											    	<div class="search--calendar">
														<span>
															<input type="text" class="form-control" name="bsnsBgnde" id="bsnsBgnde" placeholder="시작일" value="" title="시작일 입력">
															<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
														</span>
													</div>
												</div>
											   <div class="p-col-9 p-col-sm-9">
											    	<div class="search--calendar">
														<span>
															<input type="text" class="form-control" name="bsnsEndde" id="bsnsEndde" placeholder="종료일" value="" title="시작일 입력">
															<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
														</span>
													</div>
												</div>
											</div> 
											<div class="form-group">
											    <div class="p-col-6 p-col-sm-6 control-label p-col-lg-2"><label for="select">협의보상개시​</label></div>
											    <div class="p-col-9 p-col-sm-9">
											    	<div class="search--calendar">
														<span>
															<input type="text" class="form-control" name="dscssRewardBeginDe" id="dscssRewardBeginDe" placeholder="협의보상개시일" value="" title="시작일 입력">
															<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
														</span>
													</div>
												</div>
											</div> 
											<div class="form-group">
											    <div class="p-col-6 p-col-sm-6 control-label p-col-lg-2"><label for="select">사업인정시점</label></div>
											    <div class="p-col-9 p-col-sm-9">
												    <div class="search--calendar">
															<span>
																<input type="text" class="form-control" name="bsnsrcognNtfcDe" id="bsnsrcognNtfcDe" placeholder="사업인정시점" value="" title="시작일 입력">
																<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
															</span>
													</div>
												</div>
											</div> 
											<div class="form-group">
											    <div class="p-col-6 p-col-sm-6 control-label p-col-lg-2"><label for="select">사업비​</label></div>
												<div class="p-col-9 p-col-sm-9">
											    	<input type="text" id="wct" name="wct" maxlength="18" class="form-control" value="" >
												</div>
												<div class="p-col-2 p-col-sm-2">
													
												</div>
											</div> 
											<div class="form-group">
											    <div class="p-col-6 p-col-sm-6 control-label p-col-lg-2"><label for="select">용지비 ​</label></div>
												<div class="p-col-9 p-col-sm-9">
											    	<input type="text" id="lct" name="lct" maxlength="18" class="form-control" value="" >
												</div>
												<div class="p-col-2 p-col-sm-2">
													
												</div>
											</div> 
					                    </div>
						                   </form>	
					                    
					                    
					                    <div class="board_btm">
					                        <div class="btns_area fl_r mo_block">
						                        <a href="javascript:fn_udtDevlopInfo();" class="btn btn-default">확인</a>
					                            <a href="#" class="btn btn-default" data-dismiss="modal">취소</a>
					                        </div>
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
