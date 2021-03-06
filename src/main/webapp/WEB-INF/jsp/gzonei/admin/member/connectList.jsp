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
	checkAuth("adm003003", "menuAccesAt",""); //접근
	
	var num = $("#tot").html();
	num = num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	$("#tot").html("");
	$("#tot").html(num);
	
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
function search(){
	document.connectForm.pageIndex.value = 1;
	document.connectForm.action = "<c:url value='/admin/member/connectList.do'/>";
	document.connectForm.submit();
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
	document.connectForm.pageIndex.value = pageNo;
	document.connectForm.action = "<c:url value='/admin/member/connectList.do'/>";
   	document.connectForm.submit();
}

function userConnectList(userId){
	//정보조회 권한 체크 
	if(checkAuth("adm003003", "infoInqireAt","")){
		$("#connectResult").html("");
		
		$.ajax({
			type:"POST",
			url:"<c:url value='/admin/member/userConnectList.do' />",
			data:{
				"userId": userId			
			},
			dataType:"JSON",
			cache : false,
			success:function(res){
				
			   
				var html = "";
				for(var i = 0; i<res.length; i++){
					html += "<tr><td>"+res[i].rownum+"</td>";
					html += "<td>"+res[i].userId+"</td>";
				    html += "<td>"+res[i].userNm+"</td>";
				    html += "<td>"+res[i].ipInfo+"</td>";
				    html += "<td>"+res[i].sesionId+"</td>";
				    html += "<td>"+res[i].loginDt+"</td>";
				    if(res[i].logoutDt == undefined){
				    	res[i].logoutDt = "";
				    }
				    html += "<td>"+res[i].logoutDt+"</td></tr>";
				}
				$("#connectTitle").text(userId+"님 접속이력");
				$("#connectResult").html(html);
				$("#modal-connect").modal();
				
				
			},error:function(){
				console.log("error");
			}
		});
	}
	
}
function fn_button_close(){
	$("#popupDiv").html("");
}
</script>
<!-- 구현부 : S -->

<div id="body_layout">	

    <!-- layout -->
    <div class="body_wrap layout">  
	<!-- contents -->
	<div id="contens" class="contents_wrap">
	
	
	<!-- 상단 -->
	<div id="location" class="title_wrap">
               <h2 class="page__title">접속 이력</h2>
               <!-- 유틸 시작 -->
               <div class="utile_wrap">
                   <!-- 로케이션 시작 -->
                   <ul class="location_wrap">
                       <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                       <li class="n2"><a href="<c:url value='/admin/member/memberList.do'/>">사용자관리</a></li>
                       <li class="n3"><a href="<c:url value='/admin/member/connectList.do'/>" class="navi_ov">접속 이력</a></li>
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
			 <form name="connectForm" method="post" >
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
								
								<div class="p-col-4 p-col-sm-6">
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
			    $("#startDate").datetimepicker({
			        timepicker : false,
			        format : 'Y-m-d',
			        scrollMonth : false,
			        scrollInput : false,
			        validateOnBlur: false,
			        onShow:function(){
			            var end = $("#endDate").val();
			            var start = $("#startDate").val();
			            this.setOptions({
			              maxDate: end? end : false,
			              
			              dateFormat: 'Y-m-d'
			              
			            })
			          }
			    	
			    }).on('keydown', function(event){
			    	onlyNum(this,event);
					});
			    
			    $("#endDate").datetimepicker({
			        timepicker : false,
			        format : 'Y-m-d',
			        scrollMonth : false,
			        scrollInput : false,
			        validateOnBlur: false,
			        onShow:function(){
			           // var end = $("#endDate").val();
			            var start = $("#startDate").val();
			            this.setOptions({
			              minDate: start? start : false,
			              dateFormat: 'Y-m-d'
			             
			            })
			          }
			    	
			    }).on('keydown', function(event){
			    	onlyNum(this,event);
					});
			   
			   
			   
			}); 
		</script>
    		</div>
		<!-- 검색 : E -->
	<h2 id="totCnt" style="margin: 10px 0 0; font-size:16px; color:#666;">총:<span id="tot" style="margin-left: 5px;">${totCnt }</span>건</h2>
	<!-- 테이블 -->
	<div class="guide_item" style="margin-top:0;">
				<!-- Table : S -->
				<div class="table-responsive mt_20">
					<table class="table table-bordered text-center">
						<colgroup>
							<col style="width:10%">
							<col style="width:10%">
							<col style="width:20%">
							<col style="width:*">
							<col style="width:15%">
							<col style="width:15%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">아이디</th>
								<th scope="col">이름(회사명)</th>
								<th scope="col">아이피</th>
								<th scope="col">세션아이디</th>
								<th scope="col">로그인시각</th>
								<th scope="col">로그아웃시각</th>
							</tr>
						</thead>
						<tbody>
						<c:choose>
							<c:when test="${resultList == null or fn:length(resultList) == 0 }">
								<tr>
									<td colspan="6">접속 이력 없음</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
								<tr onclick="javascript:userConnectList('${resultInfo.userId }')" style="cursor:pointer;"> 
								 	<td>${resultInfo.userId }</td>
								 	<td>${resultInfo.userNm }</td>
								 	<td>${resultInfo.ipInfo }</td>
								 	<td>${resultInfo.sesionId }</td>
								 	<td>${resultInfo.loginDt }</td>
								 	<td>${resultInfo.logoutDt }</td>
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

	</div>
	<!-- contents -->
    </div>
    <!-- layout -->
</div>
<!-- bodylayout -->
<!-- Modal Sample - body바로 밑에 놔주세요 :: S -->
      <div class="modal fade" role="dialog" data-ly-type="content" data-ly-target="modal-connect" id="modal-connect">
          <div class="modal-dialog">
              <!-- Modal content-->
              <div class="modal__body" style="width:1000px;">
                  <div class="modal__header">
                     <h4 class="modal__title">사용자접속이력</h4>
                      <div class="modal__close-button"><button type="button" class="close" data-dismiss="modal">닫기</button></div>
                  </div>
                  <div class="modal__content" style="word-break: break-all">
                      <div class="cont_wrap">
                      	  <div class="top_head">
                              <h3 class="h_title_sub" id="connectTitle"></h3>
                          </div>
                          <div class="table_wrap" style="overflow-y: auto;height: 280px;">
                              <table class="table_info">
                               <colgroup>
                               	<col style="width:9%">
								<col style="width:12%">
								<col style="width:13%">
								<col style="width:12%">
								<col style="width:*">
								<col style="width:18%">
								<col style="width:18%">
							</colgroup>
                                  <thead>
                                      <tr>
                                          <th>번호</th>
                                          <th>아이디</th>
                                          <th>이름</th>
                                          <th>아이피</th>
                                          <th>세션아이디</th>
                                          <th>로그인시각</th>
                                          <th>로그아웃시각</th>
                                      </tr>
                                  </thead>
                                  <tbody id="connectResult">
                                  </tbody>                            
                              </table>
                          </div>
                      </div>
                  </div>
                  
                  	<div class="modal__footer">
                   	<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                	</div>
              	</div>
          	</div>
      	</div>
    
<!-- Modal Sample - body바로 밑에 놔주세요 :: E -->
<!-- 구현부 : E -->
<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>
</body>
</html>