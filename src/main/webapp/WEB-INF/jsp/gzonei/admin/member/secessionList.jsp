<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang='ko'>
<head>
<%@ include file="/WEB-INF/jsp/gzonei/layout/header.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/jsp/gzonei/layout/admintop.jsp" %>
<script>
$(document).ready(function(){
	//권한 --접근
	checkAuth("adm003005", "menuAccesAt",""); //접근
	
	var num = $("#waitCnt").html();
	num = num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	$("#waitCnt").html("");
	$("#waitCnt").html(num);
	
	$("#searchBtn").on("click", function () {
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
	});
});
function fn_search(){
	document.secessionForm.pageIndex.value = 1;
	document.secessionForm.action = "<c:url value='/admin/member/secessionList.do'/>";
	document.secessionForm.submit();
}
/*********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_select_linkPage(pageNo){
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
	document.secessionForm.pageIndex.value = pageNo;
	document.secessionForm.action = "<c:url value='/admin/member/secessionList.do'/>";
   	document.secessionForm.submit();
}
/*********************************************************
 * 탈퇴승인 처리 함수
 ******************************************************** */
function fn_secession_confirm(id){
	//탈퇴 승인 권한 조회
	if(checkAuth("adm003005", "infoUpdtAt","")){
		Common.Dialog.confirm({
	        title: '탈퇴 승인',
	        content: id +'회원의 탈퇴를 승인하시겠습니까?'
	        ,ok: function(){
	        	$.ajax({
	        		type:"POST",
	        		url:"<c:url value='/admin/member/secessionConfirm.do' />",
	        		data:{ "userId" : id	},
	        		dataType:'json',
	        		async:false,
	        		success:function(data){
	        			if (data.result > 0) {
	        				Common.Dialog.alert({
			                    title: '탈퇴 승인'
			                    ,content: '탈퇴가 승인 되었습니다.'
			                    ,ok : function(){
			                    	fn_search();
			                    }
			                }); 
	        			}
	        			else {
	        				Common.Dialog.alert({
			                    title: '탈퇴 승인'
			                    ,content: '탈퇴 승인 처리에 실패했습니다.'
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

</script>
<!-- 구현부 : S -->

<div id="body_layout">	
    <!-- layout -->
    <div class="body_wrap layout"> 
		<div id="contens" class="contents_wrap">
	
			<!-- 상단 -->
			<div id="location" class="title_wrap">
               <h2 class="page__title">탈퇴 신청</h2>
               <!-- 유틸 시작 -->
               <div class="utile_wrap">
                   <!-- 로케이션 시작 -->
                   <ul class="location_wrap">
                       <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                       <li class="n2"><a href="<c:url value='/admin/member/memberList.do'/>">사용자관리</a></li>
                       <li class="n3"><a href="<c:url value='/admin/member/secessionList.do'/>" class="navi_ov">탈퇴 신청</a></li>
                   </ul>                           
                   <!-- 로케이션 끝 -->
                   <!-- 프린트 시작 -->
                   <!-- 프린트 끝 -->
               </div>
               <!-- 유틸 끝 -->   
           </div> 
           
          <!-- 검색창 -->
          <div class="guide_item" style="margin-top:0;">
           <!-- 검색 : S -->
		 	<form name="secessionForm" method="post" >
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
								
								<div class="p-col-4 p-col-sm-6 ">
									<select class="p-control" name="searchSel" title="검색 영역 선택">
										 	<option value="">--전체--</option>
										 	<option value="userId"<c:if test="${searchVO.searchSel eq 'userId' }">selected</c:if>>아이디</option>
											<option value="userNm"<c:if test="${searchVO.searchSel eq 'userNm' }">selected</c:if>>이름</option>
									 </select>
								</div>
								<div class="p-col-8  p-col-sm-18">
									<input type="text" name="searchKrwd" value="${searchVO.searchKrwd}" title="검색어를 입력해주세요" placeholder="검색어를 입력해주세요" class="p-control">
									<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
		                       </div>
		                       <div class="p-col-2  p-col-sm-24">
		                       	 <input type="submit" id="searchBtn" value="검색" class="submit">
		                       </div>
							</div>
	                    </div>
					 </fieldset>
				 </form>
			 <script>
				$(document).ready(function(){
				    
				    $.datetimepicker.setLocale('ko');
				    $("#startDate,#endDate").datetimepicker({
				        timepicker : false,
				        format : 'Y-m-d',
				        scrollMonth : false,
				        scrollInput : false,
				        validateOnBlur: false
				    }).on('keydown', function(event){
				    	onlyNum(this,event);
					});
				    
				    
				}); 
			</script>
   		</div>
		<!-- 검색 : E -->
		<h2 id="totCnt" style="margin-bottom:10px 0 0;  font-weight:800; font-size:16px; color:red;">탈퇴승인대기 : <span id="waitCnt">${secsnWaitCnt }</span>건</h2>
		<!-- 테이블 -->
		<div class="guide_item" style="margin-top:0;">
				<!-- Table : S -->
				<div class="table-responsive mt_20">
					<table class="table table-bordered text-center">
						<colgroup>
							<col style="width:15%">
							<col style="width:15%">
							<col style="width:*">
							<col style="width:20%">
							<col style="width:20%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">사용자아이디</th>
								<th scope="col">이름</th>
								<th scope="col">탈퇴사유</th>
								<th scope="col">신청일자</th>
								<th scope="col">승인상태</th>
							</tr>
						</thead>
						<tbody>
						<c:choose>
							<c:when test="${resultList == null or fn:length(resultList) == 0 }">
								<tr>
									<td colspan="5">탈퇴 신청 내역 없음</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
								<tr onclick="javascript:userConnectList('${resultInfo.userId }')"> 
								 	<td>${resultInfo.userId }</td>
								 	<td>${resultInfo.userNm }</td>
								 	<td>${resultInfo.secsnResn }</td>
								 	<td>${resultInfo.secsnReqstDt }</td>
								 	<c:choose>
								 	<c:when test="${resultInfo.processSttusCode == 'CM00260001' }">
								 		<td><button onclick="javascript:fn_secession_confirm('${resultInfo.userId }')" class="btn btn-secondary" style="padding:0; height:28px; font-size:14px;">탈퇴승인</button></td>
								 	</c:when>
								 	<c:otherwise>
								 		<td>탈퇴 승인 완료</td>
								 	</c:otherwise>
								 	</c:choose>
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
				<!-- Table : E -->
            </div>
			<!-- 테이블끝 -->

<!-- layout -->
		</div>
    </div>
</div>
<!-- 구현부 : E -->

<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>
</body>
</html>