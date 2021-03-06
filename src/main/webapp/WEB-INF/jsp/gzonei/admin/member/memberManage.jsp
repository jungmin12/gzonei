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
	checkAuth("adm003006", "menuAccesAt",""); 
//     document.searchForm.submit(); // Submits the form without the button
});



function fn_search(){
	if(checkAuth("adm003006", "infoInqireAt","")){
		var startDate = $("#startDate").val();
		var endDate = $("#endDate").val();
		let today = new Date();   

		let year = today.getFullYear(); // 년도
		let month = today.getMonth() + 1;  // 월
		let date = today.getDate();  // 날짜
		
		var nowDate = year + '-' + month + '-' + date;
		
// 		if(startDate != "" || endDate != ""){
// 			if( nowDate > startDate ){
// 				swal("날짜확인필요", "종료일이 현재날짜보다 클수 없습니다.","warning");
// 				return false;
// 			}
// 			if( nowDate > endDate ){
// 				swal("날짜확인필요", "현재날짜가 종료일보다 클수 없습니다 123123123.","warning");
// 				return false;
// 			}
// 			if(endDate != ""){
// 				if(startDate > endDate){
// 					swal("날짜확인필요", "시작일이 종료일보다 클수 없습니다.","warning");
// 					return false;
// 				}
// 			}
// 		}
		
		document.searchForm.pageIndex.value = 1;
		document.searchForm.action = "<c:url value='/admin/member/memberManage.do'/>";
	   	document.searchForm.submit();
	}
}
/*********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_select_linkPage(pageNo){
	if(checkAuth("adm003006", "infoInqireAt","")){
		document.searchForm.pageIndex.value = pageNo;
		document.searchForm.action = "<c:url value='/admin/member/memberManage.do'/>";
	   	document.searchForm.submit();
	}
}
function fn_reg(){
	if(checkAuth("adm003006", "infoRegistAt","")){
		location.href = "<c:url value='/admin/member/memberReg.do'/>";
	}
}
// 		memberInfo.action	= "<c:url value='/admin/member/confirmPayment.do' />";
/*********************************************************
 * 회원 목록 엑셀 출력
 ******************************************************** */
 
 function download(){
	 if(checkAuth("adm003006", "executAt","")){
		$.ajax({
			type:"POST",
			url:"<c:url value='/admin/member/memberManageListExcel.do' />",
			data:$('#searchForm').serializeArray(),
			dataType:'json',
			async:false,
			success:function(data){
				if (data.length > 0) {
					//데이터 있음
					exportExcel('회원등급조회', 'sheetNm', data);
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


// Search Date
jQuery.fn.schDate = function(){
    var $obj = $(this);
    var $chk = $obj.find("input[type=radio]");
    $chk.click(function(){                
        $('input:not(:checked)').parent(".chkbox2").removeClass("on");
        $('input:checked').parent(".chkbox2").addClass("on");                    
    });
};


// DateClick
jQuery.fn.dateclick = function(){
    var $obj = $(this);
    $obj.click(function(){
        $(this).parent().find("input").focus();
    });
}    


function setSearchDate(start){

    var num = start.substring(0,1);
    var str = start.substring(1,2);

    var today = new Date();

    //var year = today.getFullYear();
    //var month = today.getMonth() + 1;
    //var day = today.getDate();
    
    var startDate = $.datepicker.formatDate('yy-mm-dd', today);
    $('#startDate').val(startDate);
    
    if(str == 'd'){
        today.setDate(today.getDate() + parseInt(num));
    }else if (str == 'w'){
        today.setDate(today.getDate() + (parseInt(num)*7));
    }else if (str == 'm'){
        today.setMonth(today.getMonth() + parseInt(num));
        today.setDate(today.getDate() + 1);
    }else if (str == 'y'){
        today.setYear(today.getFullYear() + parseInt(num));
        today.setDate(today.getDate() + 1);
    }

    var endDate = $.datepicker.formatDate('yy-mm-dd', today);
    $('#endDate').val(endDate);
            
    // 종료일은 시작일 이전 날짜 선택하지 못하도록 비활성화
    $("#endDate").datepicker( "option", "minDate", startDate );
    
    // 시작일은 종료일 이후 날짜 선택하지 못하도록 비활성화
    $("#startDate").datepicker( "option", "maxDate", endDate );

}



</script>
<!-- 구현부 : S -->

<div id="body_layout">	

    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
            <div id="location" class="title_wrap">
                <h2 class="page__title">회원 등급 조회</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="<c:url value='/admin/member/memberManage.do'/>">사용자관리</a></li>
                        <li class="n3"><a href="<c:url value='/admin/member/memberManage.do'/>" class="navi_ov">회원 등급 조회</a></li>
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
							<span class="p-col-3 p-col-sm-6 tit">기간검색</span>
	                       <div class="p-col-5 p-col-sm-9">
									<input type="text" class="p-control" name="startDate" id="startDate" placeholder="시작일" value="${searchVO.startDate}" title="시작일 입력" autocomplete="off">
									<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
							</div> 
							<div class="p-col-5 p-col-sm-9">
									<input type="text" class="p-control" name="endDate" id="endDate" placeholder="종료일" value="${searchVO.endDate}" title="종료일 입력" autocomplete="off">
	                                  <button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
							</div>
							<div class="p-col-10 p-col-sm-18">
								<button class="btn btn-default" onclick="setSearchDate('1m')">1개월</button>
								<button class="btn btn-default" onclick="setSearchDate('3m')">3개월</button>
								<button class="btn btn-default" onclick="setSearchDate('6m')">6개월</button>
								<button class="btn btn-default" onclick="setSearchDate('1y')">1년</button>
							</div>
						</div>
						<div class="form-group p-row">
							<span class="p-col-3 p-col-sm-6 tit">회원등급</span>
							<div class="p-col-10  p-col-sm-18">
							<c:set var="gradIds" value="${fn:join(searchVO.gradIds,',') }"/>
							<c:choose>
							<c:when test="${gradIds eq null or gradIds eq '' }">
							<c:forEach var="item" items="${mberGradCode }">
								<c:if test="${!item.codeIdNm.equals('무료회원') and not fn:contains(item.codeIdNm, '관리자') and !item.codeIdNm.equals('비로그인')}">
									<label>
										<input type="checkbox" name="gradId" value="${item.codeId }" 
											checked
										>${item.codeIdNm }
									</label>
								</c:if>
							</c:forEach>
							</c:when>
							<c:otherwise>
							<c:forEach var="item" items="${mberGradCode }">
								<c:if test="${!item.codeIdNm.equals('무료회원') and not fn:contains(item.codeIdNm, '관리자') and !item.codeIdNm.equals('비로그인')}">
									<label>
										<input type="checkbox" name="gradId" value="${item.codeId }" 
											<c:if test="${fn:contains(gradIds, item.codeId)}">checked</c:if>
										>${item.codeIdNm }
									</label>
								</c:if>
							</c:forEach>
							</c:otherwise>
							</c:choose>
<!-- 							<select name="grad_code_nm"class="p-control" > -->
<!-- 								<option value="">-- 전체 --</option> -->
<%-- 								<c:forEach var="item" items="${mberGradCode }"> --%>
<%-- 	                 			<option value="${item.codeIdNm }" <c:if test="${searchVO.gradCodeNm eq item.codeIdNm }">selected</c:if>>${item.codeIdNm }</option> --%>
<%-- 	                 			</c:forEach> --%>
<!-- 							</select> -->
	                       </div>
	                       <span class="p-col-1 p-col-sm-6 tit"></span>
	                       <span class="p-col-3 p-col-sm-6 tit">ID검색</span>
<!-- 							<div class="p-col-8 p-col-sm-18"> -->
<!-- 							<select name="searchSel" class="p-control" > -->
<!-- 								<option value="">-- 전체 --</option> -->
<%-- 								<option value="emplyr_id" <c:if test="${searchVO.searchSel eq 'emplyr_id' }">selected</c:if>>아이디</option> --%>
<%-- 								<option value="user_nm"  <c:if test="${searchVO.searchSel eq 'user_nm' }">selected</c:if>>사용자명</option> --%>
<%-- 								<option value="mbtlnum"  <c:if test="${searchVO.searchSel eq 'mbtlnum' }">selected</c:if>>휴대폰</option> --%>
<%-- 								<option value="bizrno"  <c:if test="${searchVO.searchSel eq 'bizrno' }">selected</c:if>>사업자등록번호</option> --%>
<%-- 								<option value="cmpny_nm"  <c:if test="${searchVO.searchSel eq 'cmpny_nm' }">selected</c:if>>상호(회사명)</option> --%>
<%-- 								<option value="rprsntv_nm"  <c:if test="${searchVO.searchSel eq 'rprsntv_nm' }">selected</c:if>>대표자명</option> --%>
<!-- 							</select> -->
<!-- 							</div> -->
							<div class="p-col-5 p-col-sm-18">
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
				<p>총 인원 수 : <fmt:formatNumber value="${paginationInfo.totalRecordCount}" pattern="#,###" />명</p>
						<table class="table table-bordered text-center">
							<caption>테이블 안내 – 구분, 부서/직위, 성명, 연락처, 홈페이지 정보 제공</caption>
							<colgroup>
								<col style="width:10%">
								<col style="width:10%">
								<col style="width:20%">
								<col style="width:20%">
								<col style="width:15%">
								<col style="width:15%">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">ID</th>
	                                <th scope="col">이름</th>
	                                <th scope="col">등급</th>
	                                <th scope="col">종료일</th>
	                                <th scope="col">이메일</th>
	                                <th scope="col">핸드폰</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
								<c:when test="${resultList == null or fn:length(resultList) == 0 }">
									<tr><td colspan="6">조회된 회원이 없습니다.</td></tr>
								</c:when>
								<c:otherwise>
	                        	<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
								<tr>
									<td>${resultInfo.userId}</td>
	                        		<td>${resultInfo.userNm }</td>
	                        		<td>${resultInfo.gradCodeNm }</td>
	                        		<td>
		                        		<fmt:parseDate  value="${resultInfo.useEndde}" var="useEndde" pattern="yyyy-MM-dd HH:mm:ss"/>
		     							<fmt:formatDate value="${useEndde}" pattern="yyyy-MM-dd"/>
	     							</td>  
	                        		<td>${resultInfo.emailAdres }</td>
	                        		<td>${resultInfo.mbtlnum }</td>
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
<!-- 						<a class="btn btn-default" href="javascript:fn_reg()" >등록</a> -->
					</div>
                </div>
				<!-- Paging : E -->
			
			
            <!-- content 영역입니다. -->	
            </div>
        </div>
    </div>
    <!-- layout -->
</div>
<%-- <form name="subForm" method="post" action="<c:url value='memberView.do'/>"> --%>
<!-- 	<input name="emplyrId" type="hidden" value=""> -->
<%-- 	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/> --%>
<!-- </form> -->

<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>
</body>
</html>
