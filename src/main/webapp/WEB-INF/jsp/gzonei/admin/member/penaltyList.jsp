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
	checkAuth("adm003004", "menuAccesAt",""); //접근
	
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
	document.penaltyForm.pageIndex.value = 1;
	document.penaltyForm.action = "<c:url value='/admin/member/penaltyList.do'/>";
	document.penaltyForm.submit();
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
	document.penaltyForm.pageIndex.value = pageNo;
	document.penaltyForm.action = "<c:url value='/admin/member/penaltyList.do'/>";
   	document.penaltyForm.submit();
}
/*********************************************************
 * 회원정보상세페이지
 ******************************************************** */
function fn_detail_mber(id){
	//정보 조회 권한 체크
	if(checkAuth("adm003004", "infoInqireAt","")){	
	    $("#mdetailResult").html("");
		$.ajax({
			type:"POST",
			url:"<c:url value='/admin/member/memberDetailPopup.do' />",
			data:{"emplyrId": id},
			dataType:'json',
			async:false,
			success:function(data){
				var html = "";
				const apd = new Date(data.confmDe);
				const fd = new Date(data.frstRegistPnttm);
// 				debugger;
				if(data != null){
					html += "<tr><th>이름</th>";
					html += "<td>"+data.userNm+"</td></tr>";
					html += "<tr><th>아이디</th>";
					html += "<td>"+ data.emplyrId +"</td></tr>";
					html += "<tr><th>연령대</th>";
					html += "<td>"+data.agrde+"대</td></tr>";
					html += "<tr><th>성별</th>";
					if(data.sexdstnCode=="F"){
						html += "<td>여</td></tr>";
					}else{
						html += "<td>남</td></tr>";
					}
					html += "<tr><th>회원승인일</th>";
					if(data.confmDe == undefined){
						html += "<td></td></tr>";
					}else{
						html += "<td>"+apd.getFullYear()+"-"+("0" + (1 + apd.getMonth())).slice(-2)+"-"+("0" + apd.getDate()).slice(-2)+"</td></tr>";		
					}
					html += "<tr><th>회원등록일</th>";
					if(data.frstRegistPnttm == undefined){					
						html += "<td></td></tr>";
					}else{
						html += "<td>"+fd.getFullYear()+"-"+("0" + (1 + fd.getMonth())).slice(-2)+"-"+("0" + fd.getDate()).slice(-2)+"</td></tr>";
					}
					html += "<tr><th>회원구분</th>";
					if(data.gradCodeNm == undefined){
						html += "<td>무료회원</td></tr>";
					}else{					
						html += "<td>"+data.gradCodeNm+"</td></tr>";
					}
					if(data.indvdlMberCode == "CM00210002"){
						html += "<tr><th>회사명</th>";
						if(data.cmpnyNm == undefined){
							html += "<td></td></tr>";
						}else{							
							html += "<td>"+data.cmpnyNm+"</td></tr>";
						}
						html += "<tr><th>사업자번호</th>";
						html += "<td>"+data.bizrno+"</td></tr>";
						html += "<tr><th>대표자명</th>";
						if(data.rprsntvNm == undefined){
							html += "<td></td></tr>";
						}else{							
							html += "<td>"+data.rprsntvNm+"</td></tr>";
						}
						html += "<tr><th>업태</th>";
						if(data.bizcnd == undefined){
							html += "<td></td></tr>";
						}else{							
							html += "<td>"+data.bizcnd+"</td></tr>";
						}
						html += "<tr><th>업종</th>";
						if(data.induty == undefined){
							html += "<td></td></tr>";
						}else{							
							html += "<td>"+data.induty+"</td></tr>";
						}
						
						html += "<tr><th>대표자 이메일</th>";
						html += "<td>"+data.rprsntvEmail+"</td></tr>";
					}
					html += "<tr><th>휴대폰번호</th>";
					html += "<td>"+data.mbtlnum+"</td></tr>";
					html += "<tr><th>이메일</th>";
					html += "<td>"+data.emailAdres+"</td></tr>";
					
					html += "<tr><th>법인여부</th>";
					if(data.smtmConectAt == 'Y'){
						html += "<td class='board_view_in'><input class='radio-input' type='radio' name='smtmConectAt' id='smtmConectAtY' value='Y' checked onclick='return(false);'/><label class='radio-inline' style='padding:5px 0;' for='smtmConectAtY'>예</label>";
						html += "<input class='radio-input' type='radio' name='smtmConectAt' id='smtmConectAtN' value='N' onclick='return(false);'/><label class='radio-inline' style='padding:5px 0;' for='smtmConectAtN'>아니오</label></td></tr>";
					}else{
						html += "<td class='board_view_in'><input class='radio-input' type='radio' name='smtmConectAt' id='smtmConectAtY' value='Y' onclick='return(false);'/><label class='radio-inline' style='padding:5px 0;' for='smtmConectAtY'>예</label>";
						html += "<input class='radio-input' type='radio' name='smtmConectAt' id='smtmConectAtNY' value='N' checked onclick='return(false);'/><label class='radio-inline' style='padding:5px 0;' for='smtmConectAtN'>아니오</label></td></tr>";
					}
					html += "<tr><th>sms수신여부</th>";
					if(data.smsRecptnAt == 'Y'){
						html += "<td class='board_view_in'><input class='radio-input' type='radio' name='smsRecptnAt' id='smsRecptnAtY' value='Y' checked onclick='return(false);'/><label class='radio-inline' style='padding:5px 0;' for='smsRecptnAtY'>예</label>";
						html += "<input class='radio-input' type='radio' name='smsRecptnAt' id='smsRecptnAtN' value='N' onclick='return(false);'/><label class='radio-inline' style='padding:5px 0;' for='smsRecptnAtN'>아니오</label></td></tr>";
					}else{
						html += "<td class='board_view_in'><input class='radio-input' type='radio' name='smsRecptnAt' id='smsRecptnAtY' value='Y' onclick='return(false);'/><label class='radio-inline' style='padding:5px 0;' for='smsRecptnAtY'>예</label>";
						html += "<input class='radio-input' type='radio' name='smsRecptnAt' id='smsRecptnAtN' value='N'  checked onclick='return(false);'/><label class='radio-inline' style='padding:5px 0;' for='smsRecptnAtN'>아니오</label></td></tr>";
					}
					html += "<tr><th>이메일수신여부</th>";
					if(data.emailRecptnAt == 'Y'){
						html += "<td class='board_view_in'><input class='radio-input' type='radio' name='emailRecptnAt' id='emailRecptnAtY' value='Y' checked onclick='return(false);'/><label class='radio-inline' style='padding:5px 0;' for='emailRecptnAtY'>예</label>";
						html += "<input class='radio-input' type='radio' name='emailRecptnAt' id='emailRecptnAtN' value='N' onclick='return(false);'/><label class='radio-inline' style='padding:5px 0;' for='emailRecptnAtN'>아니오</label></td></tr>";
					}else{
						html += "<td class='board_view_in'><input class='radio-input' type='radio' name='emailRecptnAt' id='emailRecptnAtY' value='Y' onclick='return(false);'/><label class='radio-inline' style='padding:5px 0;' for='emailRecptnAtY'>예</label>";
						html += "<input class='radio-input' type='radio' name='emailRecptnAt' id='emailRecptnAtN' value='N' checked onclick='return(false);'/><label class='radio-inline' style='padding:5px 0;' for='emailRecptnAtN'>아니오</label></td></tr>";
					}
					html += "<tr><th>주소</th>";						
// 						html += "<td><p>"+data.zip+"</p>";
// 						html += "<p>"+data.houseAdres+"</p>";
// 						html += "<p>"+data.detailAdres+"</p></td></tr>";
// 						
					if(data.roadDetailAdres == null){
						if(data.zip == undefined){
							html += "<td>";
						}else{							
							html += "<td><p>"+data.zip+"</p>";
						}
						if(data.houseAdres == undefined){
							html += "<p></p>";
						}else{							
							html += "<p>"+data.houseAdres+"</p>";
						}
						if(data.detailAdres == undefined){
							html += "<p></p></td></tr>";
						}else{							
							html += "<p>"+data.detailAdres+"</p></td></tr>";
						}
						
					}else{
						html += "<td><p>"+data.roadDetailAdres+"</p></td></tr>";
					}					
					html += "<tr><th>관심지역</th>";
					html += "<td></td></tr>";
					html += "<tr><th>결제메모</th>";
					if(data.setleMemo == undefined){
						html += "<td></td></tr>";
					}else{
						var stm = data.setleMemo;
						stm = stm.replace(/(?:\\r\\n|\\r|\\n)/g, '<br/>');
						html += "<td>"+stm+"</td></tr>";
					}
					html += "<tr><th>교육메모</th>";
					if(data.edcMemo == undefined){
						html += "<td></td></tr>";
					}else{
						var edc = data.edcMemo;
						edc = edc.replace(/(?:\\r\\n|\\r|\\n)/g, '<br/>');
						html += "<td>"+edc+"</td></tr>";
					}
					html += "<tr><th>기타메모</th>";
					if(data.etcMemo == undefined){
						html += "<td></td></tr>";
					}else{
						var etc = data.etcMemo;
						etc = etc.replace(/(?:\\r\\n|\\r|\\n)/g, '<br/>');
						html += "<td>"+etc+"</td></tr>";
					}
				}else{
					html += "<tr><td colspan ='2'>조회하신 회원 정보가 없습니다.</td></tr>";
				}
				$("#mberDetailTitle").text(id+"님 상세정보");
				$("#mdetailResult").html(html);
				$("#modal-mberDetail").modal();
			}
			
		});
	}
}
/*********************************************************
 * 패널티 해제 처리 함수
 ******************************************************** */
 function fn_release_penalty(id){
	//해제 권한 조회
	if(checkAuth("adm003004", "infoUpdtAt","")){
		 Common.Dialog.confirm({
		        title: '패널티 해제',
		        content: id+'님의 패널티를 해제하시겠습니까?'
		        ,ok: function(){
		        	$.ajax({
		        		type:"POST",
		    			url:"<c:url value='/admin/member/penaltyRelease.do' />",
		    			data:{ "userId" : id},
		    			dataType:'json',
		    			async:false,
		        		success:function(data){
		        			if (data.result > 0) {
		        				Common.Dialog.alert({
				                    title: '패널티 해제'
				                    ,content: '패널티 해제 처리 되었습니다.'
				                    ,ok : function(){
				                    	fn_search();
				                    }
				                }); 
		        			}
		        			else {
		        				Common.Dialog.alert({
				                    title: '패널티 해제'
				                    ,content: '패널티 해제 처리에 실패했습니다.'
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

<!-- contents -->

	<div id="contens" class="contents_wrap">
	
		

			
		<!-- 상단 -->
		<div id="location" class="title_wrap">
            <h2 class="page__title">패널티</h2>
            <!-- 유틸 시작 -->
            <div class="utile_wrap">
                <!-- 로케이션 시작 -->
                <ul class="location_wrap">
                    <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                    <li class="n2"><a href="<c:url value='/admin/member/memberList.do'/>">사용자관리</a></li>
                    <li class="n3"><a href="<c:url value='/admin/member/penaltyList.do'/>" class="navi_ov">패널티</a></li>
                </ul>                           
                <!-- 로케이션 끝 -->
                <!-- 프린트 시작 -->
                <!-- 프린트 끝 -->
            </div>
            <!-- 유틸 끝 -->   
	     </div> 
	     <!-- 상단끝 -->
		
		 <!-- 검색창 -->
         <div class="guide_item" style="margin-top:0;">
           <!-- 검색 : S -->
		  <form name="penaltyForm" method="post" >
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
		<!-- 검색창끝 -->
		
		<!-- 테이블 -->
		<div class="guide_item" style="margin-top:0;">
				<!-- Table : S -->
				<div class="table-responsive mt_20">
					<table class="table table-bordered text-center">
						<colgroup>
							<col style="width:15%">
							<col style="width:10%">
							<col style="width:20%">
							<col style="width:20">
							<col style="width:15%">
							<col style="width:20%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">아이디</th>
								<th scope="col">이름(회사명)</th>
								<th scope="col">패널티적용일시</th>
								<th scope="col">패널티만료일시</th>
								<th scope="col">등록자</th>
								<th scope="col">패널티해제/수정일시</th>
							</tr>
						</thead>
						<tbody>
						<c:choose>
							<c:when test="${resultList == null or fn:length(resultList) == 0 }">
								<tr>
									<td colspan="6">패널티 이력 없음</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
								<tr> 
								 	<td onclick="javascript:fn_detail_mber('${resultInfo.userId}')" style="cursor:pointer">${resultInfo.userId }</td>
								 	<td onclick="javascript:fn_detail_mber('${resultInfo.userId}')" style="cursor:pointer">${resultInfo.userNm }</td>
								 	<td onclick="javascript:fn_detail_mber('${resultInfo.userId}')" style="cursor:pointer">${resultInfo.applcPnttm }</td>
								 	<td onclick="javascript:fn_detail_mber('${resultInfo.userId}')" style="cursor:pointer">${resultInfo.endPnttm }</td>
								 	<c:choose>
								 	<c:when test="${resultInfo.penaltyCheck == 'False'}">
								 	<td onclick="javascript:fn_detail_mber('${resultInfo.userId}')" style="cursor:pointer">${resultInfo.frstRegisterId }</td>
								 	<td><button style="line-height:0.7; height:36px; background-color:#fbcb00; border-color:#fbcb00;" onclick="javascript:fn_release_penalty('${resultInfo.userId }')" class="btn btn-secondary">풀어주기</button></td>
								 	</c:when>
								 	<c:when test="${resultInfo.penaltyCheck != 'False' and resultInfo.lastUpdtPnttm == null}">
								 	<td onclick="javascript:fn_detail_mber('${resultInfo.userId}')" style="cursor:pointer">${resultInfo.lastUpdusrId }</td>
								 	<td onclick="javascript:fn_detail_mber('${resultInfo.userId}')" style="cursor:pointer">${resultInfo.endPnttm }</td>
								 	</c:when>
								 	<c:otherwise>
								 	<td onclick="javascript:fn_detail_mber('${resultInfo.userId}')" style="cursor:pointer">${resultInfo.lastUpdusrId }</td>
								 	<td onclick="javascript:fn_detail_mber('${resultInfo.userId}')" style="cursor:pointer">${resultInfo.lastUpdtPnttm }</td>
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
				
            </div>
			<!-- 테이블끝 -->

	</div>
	<!-- contents -->
	</div>
	<!-- body-wrap layout -->
</div><!-- body layout -->
<!-- Modal Sample - body바로 밑에 놔주세요 :: S -->
     <div class="modal fade" role="dialog" data-ly-type="content" data-ly-target="modal-mberDetail" id="modal-mberDetail">
         <div class="modal-dialog">
             <!-- Modal content-->
             <div class="modal__body">
                 <div class="modal__header">
                    <h4 class="modal__title">회원 상세정보</h4>
                     <div class="modal__close-button"><button type="button" class="close" data-dismiss="modal">닫기</button></div>
                 </div>
                 <div class="modal__content" style="word-break: break-all">
                     <div class="cont_wrap">
                     	  <div class="top_head">
                             <h3 class="h_title_sub" id="mberDetailTitle"></h3>
                         </div>
                         <div class="table_wrap"  style="overflow-y: auto;height: 450px;">
                             <table class="table_info">
                              <colgroup>
							<col style="width:25%">
							<col style="width:*">
						</colgroup>
                                 <tbody id="mdetailResult">
                                 	
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
<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>
</body>
</html>