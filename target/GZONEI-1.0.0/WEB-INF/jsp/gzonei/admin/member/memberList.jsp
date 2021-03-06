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
	//권한 --접근
	checkAuth("adm003001", "menuAccesAt",""); 

});
function fn_search(){
	if(checkAuth("adm003001", "infoInqireAt","")){
		var startDate = $("#startDate").val();
		var endDate = $("#endDate").val();
		let today = new Date();   

		let year = today.getFullYear(); // 년도
		let month = today.getMonth() + 1;  // 월
		let date = today.getDate();  // 날짜
		
		var nowDate = year + '-' + month + '-' + date;
		
		if(startDate != "" || endDate != ""){
			if( nowDate < startDate ){
				swal("날짜확인필요", "시작일이 현재날짜보다 클수 없습니다.","warning");
				return false;
			}
			if( nowDate < endDate ){
				swal("날짜확인필요", "종료일이 현재날짜보다 클수 없습니다.","warning");
				return false;
			}
			if(endDate != ""){
				if(startDate > endDate){
					swal("날짜확인필요", "시작일이 종료일보다 클수 없습니다.","warning");
					return false;
				}
			}
		}
		document.searchForm.pageIndex.value = 1;
		document.searchForm.action = "<c:url value='/admin/member/memberList.do'/>";
	   	document.searchForm.submit();
	}
}
/*********************************************************
 * 사용자 상세 조회 처리 함수
 ******************************************************** */
function fn_detail_mber(id){
	if(checkAuth("adm003001", "infoInqireAt","")){
		var startDate = $("#startDate").val();
		var endDate = $("#endDate").val();
		let today = new Date();   

		let year = today.getFullYear(); // 년도
		let month = today.getMonth() + 1;  // 월
		let date = today.getDate();  // 날짜
		
		var nowDate = year + '-' + month + '-' + date;
		
		if(startDate != "" || endDate != ""){
			if( nowDate < startDate ){
				swal("날짜확인필요", "시작일이 현재날짜보다 클수 없습니다.","warning");
				return false;
			}
			if( nowDate < endDate ){
				swal("날짜확인필요", "종료일이 현재날짜보다 클수 없습니다.","warning");
				return false;
			}
			if(endDate != ""){
				if(startDate > endDate){
					swal("날짜확인필요", "시작일이 종료일보다 클수 없습니다.","warning");
					return false;
				}
			}
		}
		document.searchForm.emplyrId.value = id;
		document.searchForm.action = "<c:url value='/admin/member/memberView.do'/>";
		document.searchForm.submit();
	}
}
/*********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_select_linkPage(pageNo){
	if(checkAuth("adm003001", "infoInqireAt","")){
		document.searchForm.pageIndex.value = pageNo;
		document.searchForm.action = "<c:url value='/admin/member/memberList.do'/>";
	   	document.searchForm.submit();
	}
}
function fn_reg(){
	if(checkAuth("adm003001", "infoRegistAt","")){
		location.href = "<c:url value='/admin/member/memberReg.do'/>";
	}
}
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
/*********************************************************
 * 입금 승인
 ******************************************************** */
 function fn_doPayment(setleSn,id,goodsDetailCode,useMonthCo,goodsCode)	{
	 if(checkAuth("adm003001", "infoRegistAt","")){
		Common.Dialog.confirm({
	        title: '무통장 입금 확인',
	        content: '입금 여부를 확인하였습니까?'
	        ,ok: function(){
	        	Common.Dialog.confirm({
	                title: '무통장 입금 확인',
	                content:id+'회원의 서비스 이용등록을 하시겠습니까?'
	                ,ok: function(){
	                	$.ajax({
	                		type:"POST",
	                		url:"<c:url value='/admin/member/confirmPayment.do' />",
	                		data:{ "userId" : id , "setleSn" : setleSn, "goodsDetailCode":goodsDetailCode, "useMonthCo":useMonthCo, "goodsCode":goodsCode 	},
	                		dataType:'json',
	                		async:false,
	                		success:function(data){
	                			if (data.result > 0) {
	                				Common.Dialog.alert({
	        		                    title: '무통장 입금 확인'
	        		                    ,content: '서비스 이용 등록 되었습니다.'
	        		                    ,ok : function(){
	        		                    }
	        		                }); 
	                			}
	                			else {
	                				Common.Dialog.alert({
	        		                    title: '무통장 입금 확인'
	        		                    ,content: '이용 등록 처리에 실패했습니다.'
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
		});
	 }
}
// 		memberInfo.action	= "<c:url value='/admin/member/confirmPayment.do' />";
/*********************************************************
 * 회원 목록 엑셀 출력
 ******************************************************** */
 
 function download(){
	 if(checkAuth("adm003001", "executAt","")){
		$.ajax({
			type:"POST",
			url:"<c:url value='/admin/member/selectMemberListExcel.do' />",
			data:$('#searchForm').serializeArray(),
			dataType:'json',
			async:false,
			success:function(data){
				if (data.length > 0) {
					//데이터 있음
					exportExcel('회원목록', 'sheetNm', data);
					return;
				}else{
					//데이터 없음
					return;
				}
			} 
			,error : function(e) {alert("데이터 조회에 실패하였습니다.\n관리자에게 문의바랍니다.");}
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
	}
/*********************************************************
 * 결제내역, 조회이력 목록 조회
 ******************************************************** */
function fn_infoList(id, type, page){
	if(checkAuth("adm003001", "infoInqireAt","")){
		//Page index
		debugger;
		if(page){
			$("#subPageIndex").val(page);
		}else{
			$("#subPageIndex").val("1");
		}
		var subPageIndex = $("#subPageIndex").val();
		$.ajax({
			type:"POST",
			url:"<c:url value='/admin/member/infoList.do' />",
			data:{ "userId" : id, "type" : type	, "pageIndex" : subPageIndex},
			dataType:'json',
			async:false,
			success:function(data){
// 				debugger;
				var html = '';
				if(type == "payment"){//결제내역
					if(data.paymentList.length > 0){
						$.each(data.paymentList, function(index,item){
							
			   				html += "<tr><td>"+item.rownum+"</td>";
			   				if(item.setleDtls == undefined){
			   					html += "<td></td>";
			   				}else{
			   					html += "<td>"+item.setleDtls+"</td>";
			   				}
			   				html += "<td>"+item.useMonthCo+"개월</td>";
			   				if(item.amount != null && item.amount != undefined){
								var amountNum = item.amount;
								amountNum = amountNum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");								
			   					html += "<td>"+amountNum+"원</td>";
							}else{
								html += "<td></td>";
							}
							if (item.rcpmnyCnfirmAt == "N"){	
			   					html += "<td>무통장입금</td>"
			   					html += "<td colspan='3'><button class='txt_blt03 state01' style='padding-left:10px; padding-right:10px;' onclick='javascript:fn_doPayment("+ '"' +item.setleSn+ '"' + ',"'+id+'"'+',"'+item.goodsDetailCode+'"'+',"'+item.useMonthCo+'"'+',"'+item.goodsCode+'"'+");'>무통장입금확인</button></td>";
							}
							else{
								html += "<td>"+item.codeIdNm+"</td>";
								html += "<td>"+item.setlede+"</td>";//getPAYMENT_DT
								html += "<td>"+item.useBgnde+"</td>";//getSUP_STRT_DT
								html += "<td>"+item.useEndde+"</td>";//getSUP_END_DT
							}
				   		});
			   			html += "</tr>";
					}else{
						html += "<tr><td colspan='8'>조회하신 내역이 없습니다.</td></tr>";
					}
					$("#payTitle").text(id + " 회원 결제 내역");
					$("#payResult").html(html);
					$('#modal-pay').modal();
					
				}else if(type == "chkInfo"){//조회이력
					if(data.chkInfoList.length > 0){
						var paginationDiv = $('#userPagination');
						paginationInit(paginationDiv);
						makePage(paginationDiv,data.paginationInfo.totalRecordCount,data.paginationInfo.currentPageNo, 10);
						$.each(data.chkInfoList, function(index,item){
							html += "<tr><td>"+item.rownum+"</td>";
			   				html += "<td>"+item.inqireIem+"</td>";
			   				html += "<td>"+item.dwkNm+"</td>";
			   				html += "<td>"+item.inqireDt+"</td>";
			   			});
			   			html += "</tr>";
			   			$('#userPagination').show();
					}else{
						$('#userPagination').hide();
						html += "<tr><td colspan='4'>조회하신 내역이 없습니다.</td></tr>";
					}
				
					$("#subId").val(id);
					$("#chkTitle").text(id + " 회원");
					$("#chkInfoResult").html(html);
					$('#modal-chkInfo').modal();
				}
				
				
			} 
			,error : function(e) {alert("결과가 존재하지 않습니다.");}
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
	    	$("#subPageIndex").val(page);
	    	var id = $("#subId").val();
	    	fn_infoList(id, "chkInfo", page );
	    }
	});
	paginationDiv.children().children('.first').children('a').attr('aria-label','first');
	paginationDiv.children().children('.Previous').children('a').attr('aria-label','Previous');
	paginationDiv.children().children('.Next').children('a').attr('aria-label','Next');
	paginationDiv.children().children('.last').children('a').attr('aria-label','last');
}
</script>
<!-- 구현부 : S -->

<div id="body_layout">	

    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
            <div id="location" class="title_wrap">
                <h2 class="page__title">회원 관리</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="<c:url value='/admin/member/memberList.do'/>">사용자관리</a></li>
                        <li class="n3"><a href="<c:url value='/admin/member/memberList.do'/>" class="navi_ov">회원 관리</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">
	               
            <!-- content 영역입니다. -->
			<form name="searchForm" id="searchForm" method="post" action="javascript:fn_search();">
			<input name="emplyrId" type="hidden" value="">
			<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
				 <fieldset>
					 <legend>검색</legend>
					 <div class="search custom-search">
						<div class="form-group p-row">
							<span class="p-col-2 p-col-sm-6 tit">기간검색</span>
	                       <div class="p-col-4 p-col-sm-9">
									<input type="text" class="p-control" name="startDate" id="startDate" placeholder="시작일" value="${searchVO.startDate}" title="시작일 입력" autocomplete="off">
									<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
							</div> 
							<div class="p-col-4 p-col-sm-9">
									<input type="text" class="p-control" name="endDate" id="endDate" placeholder="종료일" value="${searchVO.endDate}" title="종료일 입력" autocomplete="off">
	                                  <button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
							</div>
							<span class="p-col-3 p-col-sm-6 tit">회원등급</span>
							<div class="p-col-4  p-col-sm-18">
							<select name="grad_code_nm"class="p-control" >
								<option value="">-- 전체 --</option>
								<c:forEach var="item" items="${mberGradCode }">
	                 			<option value="${item.codeIdNm }" <c:if test="${searchVO.gradCodeNm eq item.codeIdNm }">selected</c:if>>${item.codeIdNm }</option>
	                 			</c:forEach>
							</select>
	                       </div>
						</div>
						
						<div class="form-group p-row">
							<span class="p-col-2 p-col-sm-6 tit">회원상태</span>
							<div class="p-col-4 p-col-sm-18">
							<select name="mber_sttus_code" class="p-control" >
								<option value="">-- 전체 --</option>
								<option value="CM00220001" <c:if test="${searchVO.mberSttusCode eq 'CM00220001' }">selected</c:if>>승인요청</option>
	                 			<option value="CM00220002" <c:if test="${searchVO.mberSttusCode eq 'CM00220002' }">selected</c:if>>승인</option>
	                 			<option value="CM00220004" <c:if test="${searchVO.mberSttusCode eq 'CM00220004' }">selected</c:if>>탈퇴요청</option>
	                 			<option value="CM00220005" <c:if test="${searchVO.mberSttusCode eq 'CM00220005' }">selected</c:if>>탈퇴</option>
							</select>
	                       </div>
	                        <span class="p-col-4 p-col-sm-6 tit"></span>
							<span class="p-col-3 p-col-sm-6 tit">이메일수신여부</span>
							<div class="p-col-4  p-col-sm-18">
							<select name="email_recptn_at" class="p-control" >
								<option value="">-- 전체 --</option>
								<option value="Y" <c:if test="${searchVO.emailRecptnAt eq 'Y' }">selected</c:if>>수신</option>
								<option value="N" <c:if test="${searchVO.emailRecptnAt eq 'N' }">selected</c:if>>미수신</option>
							</select>
	                       </div>
							<span class="p-col-3 p-col-sm-6 tit">SMS수신여부</span>
							<div class="p-col-4  p-col-sm-9">
							<select name="sms_recptn_at" class="p-control" >
								<option value="">-- 전체 --</option>
								<option value="Y" <c:if test="${searchVO.smsRecptnAt eq 'Y' }">selected</c:if>>수신</option>
								<option value="N" <c:if test="${searchVO.smsRecptnAt eq 'N' }">selected</c:if>>미수신</option>
							</select>
	                       </div>
	                       
						</div>
						<div class="form-group p-row">
							<span class="p-col-2 p-col-sm-6 tit">정렬기준</span>
							<div class="p-col-4 p-col-sm-18">
							<select name="order" class="p-control" >
								<option value="">-- 기준 --</option>
								<option value="emplyr_id" <c:if test="${searchVO.order eq 'emplyr_id' }">selected</c:if>>아이디</option>
								<option value="user_nm" <c:if test="${searchVO.order eq 'user_nm' }">selected</c:if>>사용자명</option>
								<option value="mbtlnum" <c:if test="${searchVO.order eq 'mbtlnum' }">selected</c:if>>휴대폰</option>
								<option value="bizrno" <c:if test="${searchVO.order eq 'bizrno' }">selected</c:if>>사업자등록번호</option>
								<option value="cmpny_nm" <c:if test="${searchVO.order eq 'cmpny_nm' }">selected</c:if>>상호(회사명)</option>
								<option value="rprsntv_nm" <c:if test="${searchVO.order eq 'rprsntv_nm' }">selected</c:if>>대표자명</option>
							</select>
							</div>
							<div class="p-col-4 p-col-sm-18">
							<select name="type"  class="p-control" >
								<option value="">-- 기준 --</option>
								<option value="ASC" <c:if test="${searchVO.type eq 'ASC' }">selected</c:if>>오름차순</option>
								<option value="DESC" <c:if test="${searchVO.type eq 'DESC' }">selected</c:if>>내림차순</option>
							</select>
	                       </div>
	                       <span class="p-col-3 p-col-sm-6 tit">검색조건</span>
							<div class="p-col-4 p-col-sm-18">
							<select name="searchSel" class="p-control" >
								<option value="">-- 전체 --</option>
								<option value="emplyr_id" <c:if test="${searchVO.searchSel eq 'emplyr_id' }">selected</c:if>>아이디</option>
								<option value="user_nm"  <c:if test="${searchVO.searchSel eq 'user_nm' }">selected</c:if>>사용자명</option>
								<option value="mbtlnum"  <c:if test="${searchVO.searchSel eq 'mbtlnum' }">selected</c:if>>휴대폰</option>
								<option value="bizrno"  <c:if test="${searchVO.searchSel eq 'bizrno' }">selected</c:if>>사업자등록번호</option>
								<option value="cmpny_nm"  <c:if test="${searchVO.searchSel eq 'cmpny_nm' }">selected</c:if>>상호(회사명)</option>
								<option value="rprsntv_nm"  <c:if test="${searchVO.searchSel eq 'rprsntv_nm' }">selected</c:if>>대표자명</option>
							</select>
							</div>
							<div class="p-col-4 p-col-sm-18">
	                       	 <input type="text" name="searchKrwd" value="${searchVO.searchKrwd}" title="검색어를 입력해주세요" placeholder="검색어를 입력해주세요" class="p-control">
	                       </div>
							<div class="p-col-3  p-col-sm-24">
	                       	 <input type="submit" value="검색" class="submit">
	                       </div>
						</div>
                    </div>
				 </fieldset>
			 </form>
			<!-- Table : S -->
				<div class="table-responsive mt_20">
				<p>총 인원 수 : <fmt:formatNumber value="${paginationInfo.totalRecordCount}" pattern="#,###" />명 / 승인대기 : <fmt:formatNumber value="${searchVO.chkCnt}" pattern="#,###" />명</p>
						<table class="table table-bordered text-center">
							<caption>테이블 안내 – 구분, 부서/직위, 성명, 연락처, 홈페이지 정보 제공</caption>
							<colgroup>
								<col style="width:10%">
								<col style="width:20%">
								<col style="width:16%">
								<col style="width:19%">
								<col style="width:10%">
								<col style="width:10%">
								<col style="width:10%">
								<col style="width:10%">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">구분</th>
	                                <th scope="col">이름(회사명)</th>
	                                <th scope="col">아이디</th>
	                                <th scope="col">등급</th>
	                                <th scope="col">가입일</th>
	                                <th scope="col">회원상태</th>
	                                <th scope="col">결제내역</th>
	                                <th scope="col">조회이력</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
								<c:when test="${resultList == null or fn:length(resultList) == 0 }">
									<tr><td colspan="8">조회된 회원이 없습니다.</td></tr>
								</c:when>
								<c:otherwise>
	                        	<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
								<tr>
								<c:choose>
									<c:when test="${resultInfo.indvdlMberCode eq 'CM00210001'}">
										<th scope="row"><span class="txt_blt03">개인</span></th>
									</c:when>
									<c:when test="${resultInfo.indvdlMberCode eq 'CM00210002'}">
										<th scope="row"><span class="txt_blt03 state01">법인</span></th>
									</c:when>
									<c:when test="${resultInfo.indvdlMberCode eq 'CM00210003'}">
										<th scope="row"><span class="txt_blt03 state02">관리자</span></th>
									</c:when>
									<c:otherwise>
										<th scope="row">[${resultInfo.indvdlMberCode}]</th>
									</c:otherwise>
								</c:choose>
								<c:if test="${resultInfo.indvdlMberCode eq 'CM00210002'}">
	                        		<td onClick="javascript:fn_detail_mber('${resultInfo.emplyrId }');" style="cursor:pointer;">${resultInfo.cmpnyNm }</td>
								</c:if>
								<c:if test="${resultInfo.indvdlMberCode ne 'CM00210002'}">
	                        		<td onClick="javascript:fn_detail_mber('${resultInfo.emplyrId }');" style="cursor:pointer;">${resultInfo.userNm }</td>
								</c:if>
	                        		<td id="emplyrId">${resultInfo.emplyrId }</td>
	                        		<td>${resultInfo.gradNm }</td>
	                        		<td>
	                        		<fmt:parseDate  value="${resultInfo.sbscrbDe}" var="parsedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
	     							<fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd"/>
	     							</td>  
								<c:if test="${resultInfo.mberSttusCode eq 'CM00220001'}">
	                        		<td><a href="javascript:fn_memberConfirm('${resultInfo.emplyrId }','${resultInfo.cmpnyNm }')" class="btn btn-default btn-outline btn-icon">승인대기<i class="ir ir-bbs ir-arrow" aria-hidden="true"></i></a></td> 
								</c:if>     							
								<c:if test="${resultInfo.mberSttusCode ne 'CM00220001'}">
									<c:forEach var="item" items="${mberStateCode }">
									<c:if test="${resultInfo.mberSttusCode eq item.codeId}"><td>${item.codeIdNm }</td></c:if>
		                 			</c:forEach>
								</c:if>     							
									<td><a href="javascript:fn_infoList('${resultInfo.emplyrId }', 'payment','')" class="btn btn-default btn-outline btn-icon">결제내역<i class="ir ir-bbs ir-arrow" aria-hidden="true"></i></a></td>
<%-- 									<td><a href="javascript:fn_infoList('${resultInfo.emplyrId }', 'payment')" data-toggle="modal" data-ly-btn="modal-pay1" class="btn btn-default btn-outline btn-icon">결제내역<i class="ir ir-bbs ir-arrow" aria-hidden="true"></i></a></td> --%>
									<td><a href="javascript:fn_infoList('${resultInfo.emplyrId }', 'chkInfo','1')" class="btn btn-default btn-outline btn-icon">조회이력<i class="ir ir-bbs ir-arrow" aria-hidden="true"></i></a></td>
	                        	</tr>
	                       		</c:forEach>
	                       		</c:otherwise>
							</c:choose>
	                        </tbody>
						</table>
				</div>
							
				<!-- Table : E -->
				<!-- Paging : S -->
				<div class="pagination-inner">
					<ul class="pagination">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_linkPage"/>
					</ul>
					<div class="button-group">
						<a class="btn btn-default" href="javascript:download()" >엑셀출력</a>
						<a class="btn btn-default" href="javascript:fn_reg()" >등록</a>
					</div>
                </div>
				<!-- Paging : E -->
			
			
            <!-- content 영역입니다. -->	
            </div>
        </div>
    </div>
    <!-- layout -->
</div>

<!-- 구현부 : E -->
<!-- Modal_1:: S -->
      <div class="modal fade" role="dialog" data-ly-type="content" data-ly-target="modal-pay1" id="modal-pay">
          <div class="modal-dialog">
              <!-- Modal content-->
              <div class="modal__body" style="width:950px;">
                  <div class="modal__header">
                     <h4 class="modal__title">결제내역</h4>
                      <div class="modal__close-button"><button type="button" class="close" data-dismiss="modal">닫기</button></div>
                  </div>
                  <div class="modal__content" style="word-break: break-all">
                      <div class="cont_wrap">
                       <div class="top_head">
                              <h3 class="h_title_sub" id="payTitle"></h3>
                          </div>
                          <div class="table_wrap" style="overflow-y: auto;height: 260px;">
                              <table class="table_info">
							<colgroup>
								<col style="width:9%">
								<col style="width:auto">
								<col style="width:10%">
								<col style="width:14.5%">
								<col style="width:11.5%">
								<col style="width:10.5%">
								<col style="width:10.5%">
								<col style="width:10.5%">
							</colgroup>
                                  <thead>
                                      <tr>
                                          <th>번호</th>
                                          <th>결제내역</th>
                                          <th>기간(월/일)</th>
                                          <th>결제금액</th>
                                          <th>결제방법</th>
                                          <th>결제일</th>
                                          <th>시작일</th>
                                          <th>만료일</th>
                                      </tr>
                                  </thead>
                                  <tbody id="payResult">
                                  </tbody>                            
                              </table>
                              
                          </div>
                      </div>
                      <div class="modal__footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                 </div>
                  </div>
              </div>
          </div>
      </div>
<!-- Modal_1 :: E -->
<!-- Modal_2:: S -->
      <div class="modal fade" role="dialog" data-ly-type="content" data-ly-target="modal-pay1" id="modal-chkInfo">
      	<input type="hidden" name="subPageIndex" id="subPageIndex" > 
      	<input type="hidden" name="subId" id="subId"> 
          <div class="modal-dialog">
              <!-- Modal content-->
              <div class="modal__body" style="width:920px;">
                  <div class="modal__header">
                     <h4 class="modal__title">개발정보 조회이력</h4>
                      <div class="modal__close-button"><button type="button" class="close" data-dismiss="modal">닫기</button></div>
                  </div>
                  <div class="modal__content" style="word-break: break-all">
                      <div class="cont_wrap">
                       <div class="top_head">
                              <h3 class="h_title_sub" id="chkTitle"></h3>
                          </div>
                          <div class="table_wrap" style="overflow-y: auto;height: 260px;">
                              <table class="table_info">
							<colgroup>
								<col style="width:10%">
								<col style="width:20%">
								<col style="width:auto">
								<col style="width:20%">
							</colgroup>
                                  <thead>
                                      <tr>
                                          <th>번호</th>
                                          <th>개발사업번호</th>
                                          <th>개발사업명</th>
                                          <th>조회일</th>
                                      </tr>
                                  </thead>
                                  <tbody id="chkInfoResult">
                                  </tbody>                            
                              </table>
                              
                          </div>
                          <div id="userPagination" style="text-align: center;"><ul class="pagination"><li class="page-item first disabled"><a href="#" class="page-link" aria-label="first">&lt;&lt;</a></li><li class="page-item Previous disabled"><a href="#" class="page-link" aria-label="Previous">&lt;</a></li><li class="page-item active"><a href="#" class="page-link">1</a></li><li class="page-item"><a href="#" class="page-link">2</a></li><li class="page-item"><a href="#" class="page-link">3</a></li><li class="page-item"><a href="#" class="page-link">4</a></li><li class="page-item"><a href="#" class="page-link">5</a></li><li class="page-item Next"><a href="#" class="page-link" aria-label="Next">&gt;</a></li><li class="page-item last"><a href="#" class="page-link" aria-label="last">&gt;&gt;</a></li></ul></div>
                      </div>
                      <div class="modal__footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                 </div>
                  </div>
              </div>
          </div>
      </div>
<!-- Modal_2 :: E -->
<%-- <form name="subForm" method="post" action="<c:url value='memberView.do'/>"> --%>
<!-- 	<input name="emplyrId" type="hidden" value=""> -->
<%-- 	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/> --%>
<!-- </form> -->

<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>
</body>
</html>
