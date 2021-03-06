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
/*********************************************************
 * 
 ******************************************************** */
$(document).ready(function(){
	//권한 --접근
	checkAuth("adm004001", "menuAccesAt",""); //접근
	
	document.addEventListener('keydown', function(event) {
		  if (event.keyCode === 13) {
		    event.preventDefault();
		  };
		}, true);
	
	$("#groupInfo input").attr('disabled','true');
	
	//그룹구성원 전체선택 클릭
	$("#group_select_all").on("click", function () {
		if($("#group_select_all").hasClass("on")){
			$(".checkbox-input1").prop('checked',false);
	    	$("#group_select_all").removeClass("on");
		}else{			
	    	$(".checkbox-input1").prop('checked',true);
	    	$("#group_select_all").addClass("on");
		}
	});
	
	//그룹구성원 - 선택삭제버튼 클릭
	$("#group_mem_delete").on("click",function(){
		
		$("input[class=checkbox-input1]:checked").each(function(){
			$(this).parent().parent().remove();
		});
		
		var isInput = $("input[class=checkbox-input1]").length;
		if(isInput == 0){
			$("#groupMembertb").html("<tr id='grmNotice'><td colspan='5'>그룹원이 없습니다.</td></tr>");
		}
	});
		
});
/*********************************************************
 * 그룹원 추가 버튼 
 ******************************************************** */
function replaceId(id){
	var speChar = id.replace(/[^\~\!\@\#\$\%\^\&\*\(\)\_\+\,\.\/\;\[\]\(\)\{\}\:\<\>\?]/gi,"");
	var reChar = "";
	for(var i = 0; i < id.length; i++){
		if(id[i].replace(/[^\~\!\@\#\$\%\^\&\*\(\)\_\+\,\.\/\;\[\]\(\)\{\}\:\<\>\?]/gi,"").length>0){
			reChar += id[i].replace(id[i],"\\"+id[i]); 	
		}else{
			reChar += id[i];
		}		
	}
	return reChar;
}
function fn_addGroup_Mem(){
		$("#grmNotice").remove();
		$("input[class=checkbox-inputM]:checked").each(function(){
			var gmtr = $(this).parent().parent();
// 			debugger;
			gmtr = gmtr.clone();
			var gmtrId = gmtr.children().first().find("input").attr("id").replace(/ /gi,"_");
			gmtr = gmtr.children().first().find("input").attr("class","checkbox-input1");
			gmtr = gmtr.prop('checked',false);
			gmtr = gmtr.prevObject.parent();
			gmtr = gmtr.prop("id",gmtrId);
			if($("#groupMembertb").find("#"+replaceId(gmtrId)).length<1){								
				$("#groupMembertb").append(gmtr);
			}
		});
}
/*********************************************************
 * 신규버튼
 ******************************************************** */
function fn_newGroupInsert(){
	//등록 권한 조회
	if(checkAuth("adm004001", "infoRegistAt","")){
		$("#btnBox").show();
		$("#newGroupBtn").show();
		$("#modifyBtn").attr('style','display:none');
		$("#useAtY").prop('checked',false);
		$("#useAtN").removeAttr('checked',false);
		$("#groupId").html("");
		$("#groupNm").val("");
		$("#groupDc").val("");
		$("#groupInfo input").removeAttr('disabled');
		$("#groupInsert").removeAttr('style');
		$("#groupId").html("자동으로 생성됩니다.");
		$("#groupMembertb").html("");
		$("#groupMembertb").html("<tr id='grmNotice'><td colspan='5'>회원 목록에서 회원 검색 후 구성원을 추가해주세요.</td></tr>");
		$("#memberLResult").html("<tr><td colspan ='5'>검색 결과가 없습니다.</td></tr>");
		$("#searchSel").val("");
		$("#searchKrwd").val("");
		$("#deleteBtn").attr('style','display:none');
		scrollAnimate('groupInfo',700,118);
		
	}
	
}
/*********************************************************
 * 해당그룹 클릭시
 ******************************************************** */
 function fn_updateGroupBtn(groupId){
	//정보 조회 권한 조회
	if(checkAuth("adm004001", "infoInqireAt","")){
	 $("#btnBox").show();
	 $("#modifyBtn").show();
	 $("#newGroupBtn").attr('style','display:none');
	 $("#useAtY").prop('checked',false);
	 $("#useAtN").removeAttr('checked',false);
	 $("#groupId").html("");
	 $("#groupNm").val("");
	 $("#groupDc").val("");
	 $("#memberLResult").html("<tr><td colspan ='5'>검색 결과가 없습니다.</td></tr>");
	 $("#searchSel").val("");
	 $("#searchKrwd").val("");
	 $('.wrap-loading').removeClass('display-none');
	 if("Y" == checkAuthValue("adm004001", "infoDelAt")){
	 		$("#deleteBtn").removeAttr('style','display:none');
		}
	 $.ajax({
			type:"POST",
			url:"<c:url value='/oper/selectGroupInfoDt.do' />",
			data:{
				"groupId": groupId 			
			},
			dataType:"JSON",
			cache : false,
			success:function(data){
// 				debugger;
				$("#groupMembertb").html("");
				$("#modifyBtn").attr('href','');
				if(data != null){
					var gId = data.resultVO["groupId"];
					$("#deleteBtn").attr('href','javascript:fn_groupDelete("'+gId+'");');
					 if("Y" == checkAuthValue("adm004001", "infoDspyAt")){
						 if(data.resultVO["useAt"] =='Y'){
								$("#useAtY").prop('checked',true);
							}else{
								$("#useAtN").prop('checked',true);
							}
					}else{
						if(data.resultVO["useAt"] =='Y'){
							$("#useAtY").prop('checked',true);
							$("#useAtY").attr('onclick','return(false);');
							$("#useAtN").attr('onclick','return(false);');
						}else{
							$("#useAtN").prop('checked',true);
							$("#useAtY").attr('onclick','return(false);');
							$("#useAtN").attr('onclick','return(false);');
						}
					}
					
					var gI = data.resultVO["groupId"];
					$("#groupId").html(data.resultVO["groupId"]);
					$("#groupNm").val(data.resultVO["groupNm"]);
					$("#groupDc").val(data.resultVO["groupDc"]);
					$("#modifyBtn").attr('href','javascript:fn_modifyGroupMem("'+gId+'");');
					if(data.groupMList.length > 0){
						for(var i = 0; i<data.groupMList.length; i++){
							var emId = data.groupMList[i].emplyrId;
							emId = emId.replace(/ /gi,"_");
							var html = "";
							html += "<tr id='"+emId+"'>";
							html += "<td><input class='checkbox-input1' type='checkbox' name='checkbox-input1' id='"+data.groupMList[i].emplyrId+"' value='"+data.groupMList[i].emplyrId+"'></td>"
							
							html += "<td>"+data.groupMList[i].userNm+"</td>";
							
							html += "<td>"+data.groupMList[i].emplyrId+"</td>";
							if(data.groupMList[i].indvdlMberCode =='CM00210001'){
								html += "<td><span class='txt_blt03'>개인</span></td>";
							}else if(data.groupMList[i].indvdlMberCode =='CM00210002'){
								html += "<td><span class='txt_blt03 state01'>법인</span></td>";
							}else if(data.groupMList[i].indvdlMberCode =='CM00210003'){
								html += "<td><span class='txt_blt03 state02'>관리자</span></td>";
							}
							html += "<td>"+data.groupMList[i].gradNm+"</td>";
							html += "</tr>";
							$("#groupMembertb").append(html);
						}
							
					}else{
						var html ="";
						html += "<tr id='grmNotice'>";
						html += "<td colspan='5'>그룹원이 없습니다.</td></tr>";
						$("#groupMembertb").append(html);
					}
					
					$("#groupInfo input").removeAttr('disabled');
					$("#groupInsert").removeAttr('style');
				}
			},complete:function(){
	        	$('.wrap-loading').addClass('display-none');
	    	}
		});
	 	
	 	scrollAnimate('groupInfo',700,118);
	}

}
 /*********************************************************
  *구성원수 
  ******************************************************** */
function memCnt(param){
	var data = ""+param;
	var result = data.split(",");

	return result.length;
}
/*********************************************************
 *회원검색
 ******************************************************** */
function fn_memSearch(){
// 		
	if($("#searchSel").val()==''){
		Common.Dialog.alert({
            title: '회원검색'
            ,content: '구분 탭을 선택해주세요.'
        	,ok: function(){
//                 $("#searchKrwd").focus();
        		return;
            }
        })
// 		swal("회원검색", "구분 탭을 선택해주세요.","warning");
//         return false;
	}else if($("#searchKrwd").val()==''){
		Common.Dialog.alert({
            title: '회원검색'
            ,content: '검색어를 입력해주세요.'
        	,ok: function(){
//         		$("#searchKrwd").focus();
        		return;
                console.log('확인 클릭');
            }
        })
// 		swal("회원검색", "검색어를 입력해주세요.","warning");
//         return false;
	}else{
		$('.wrap-loading').removeClass('display-none');
		var params = $("#memSearch").serialize();
		$.ajax({
			type:"POST",
			url:"<c:url value='/oper/selectMemberSearch.do' />",
			data:params,
			dataType:"JSON",
			cache : false,
			success:function(data){
				console.log("확인");
				$("#memberLResult").html("");
				if(data.length>0){
					for(var i = 0; i<data.length; i++){
						var html = "";
						html += "<tr id='"+data[i].emplyrId+"'>";
						html += "<td><input class='checkbox-inputM' type='checkbox' name='checkbox-inputM' id='"+data[i].emplyrId+"' value='"+data[i].emplyrId+"'></td>";
						
						html += "<td>"+data[i].userNm+"</td>";
						
						html += "<td>"+data[i].emplyrId+"</td>";
						if(data[i].indvdlMberCode=="CM00210001"){
							html += "<td><span class='txt_blt03'>개인</span></td>";
						}else if(data[i].indvdlMberCode =='CM00210002'){
							html += "<td><span class='txt_blt03 state01'>법인</span></td>";
						}else if(data[i].indvdlMberCode =='CM00210003'){
							html += "<td><span class='txt_blt03 state02'>관리자</span></td>";
						}
						html += "<td>"+data[i].gradNm+"</td></tr>";
						$("#memberLResult").append(html);
					}
				}else{
					$("#memberLResult").html("<tr><td colspan ='5'>검색 결과가 없습니다.</td></tr>");
				}
				
			},complete:function(){
	        	$('.wrap-loading').addClass('display-none');
	    	}
		});
	}
}
/*********************************************************
 *수정버튼클릭시
 ******************************************************** */
function fn_modifyGroupMem(gI){
	//정보 수정 권한 조회
	if(checkAuth("adm004001", "infoUpdtAt","")){
		var grMem = "";
		$("#grMem").val("");
		$("#groupId2").val("");
		$("input[class=checkbox-input1]").each(function(){
			var gm = $(this).val();
			grMem += gm +",";
		});
		grMem = grMem.substr(0,grMem.length -1);
		var groupId = gI;
		$("#grMem").val(grMem);
// 		debugger;
		$("#groupId2").val(groupId);
		var params = $("#updateGrDt").serialize();
		
		$.ajax({
			type:"POST",
			url:"<c:url value='/oper/updateGroupMember.do' />",
			data:params,
			dataType:"JSON",
			cache : false,
			success:function(data){
		
				if (data == "1") {
					Common.Dialog.alert({
	                    title: '그룹 수정'
	                    ,content: '그룹이 수정 되었습니다.'
	                    ,ok : function(){
	                    	location.href="<c:url value='/oper/groupManage.do' />";
	                    }
	                }); 
				}
				else {
					Common.Dialog.alert({
	                    title: '그룹 수정'
	                    ,content: '그룹 수정 처리에 실패했습니다.'
	                }); 
				}
			}
			,error : function(e) {alert("관리자에게 문의바랍니다.");}
			,beforeSend:function(){
				//전송 전
		    }
		    ,complete:function(){
		        //전송 후
		        
		    }
		});
	}
}
/*********************************************************
 *등록버튼클릭시
 ******************************************************** */
function fn_newGroup(){
	if(checkAuth("adm004001", "infoRegistAt","")){
		$("#grMem").val("");
		$("#groupId2").val("");
		if($("input[name='useAt']:checked").length<1){
			Common.Dialog.alert({
	            title: '신규 그룹 등록'
	            ,content: '사용 여부를 선택해주세요.'
	        	,ok: function(){
	        		return;
	                console.log('확인 클릭');
	            }
	        })
// 			swal("신규 그룹 등록", "사용 여부를 선택해주세요.","warning");
// 	        return false;
		}else if($("#groupNm").val()==""){
			Common.Dialog.alert({
	            title: '신규 그룹 등록'
	            ,content: '그룹 명을 입력해주세요.'
	        	,ok: function(){
	        		return;
	                console.log('확인 클릭');
	            }
	        })
// 			swal("신규 그룹 등록", "그룹 명을 입력해주세요.","warning");
// 	        return false;
		}else if($("#groupDc").val()==""){
			Common.Dialog.alert({
	            title: '신규 그룹 등록'
	            ,content: '그룹 설명을 입력해주세요.'
	        	,ok: function(){
	        		return;
	                console.log('확인 클릭');
	            }
	        })
// 			swal("신규 그룹 등록", "그룹 설명을 입력해주세요.","warning");
// 	        return false;
		}else{
			Common.Dialog.confirm({
		        title: '신규 그룹 등록'
		        ,content: '신규 그룹을 등록하시겠습니까? '
		    	,ok: function(){
		    		var grMem = "";
		    		$("input[class=checkbox-input1]").each(function(){
		    			var gm = $(this).val();
		    			grMem += gm +",";
		    		});
		    		grMem = grMem.substr(0,grMem.length -1);
		    		$("#grMem").val(grMem);
		    		var params = $("#updateGrDt").serialize();
		    		
		    		$.ajax({
		    			type:"POST",
		    			url:"<c:url value='/oper/insertNewGroup.do' />",
		    			data:params,
		    			dataType:"JSON",
		    			cache : false,
		    			success:function(data){
// 		    				debugger;
		    				if (data == "1") {
		    					Common.Dialog.alert({
		    	                    title: '신규 그룹 등록'
		    	                    ,content: '신규 그룹이 등록 되었습니다.'
		    	                    ,ok : function(){
		    	                    	location.href="<c:url value='/oper/groupManage.do' />";
		    	                    }
		    	                }); 
		    				}
		    				else {
		    					Common.Dialog.alert({
		    	                    title: '신규 그룹 수정'
		    	                    ,content: '신규 그룹 등록 처리에 실패했습니다.'
		    	                }); 
		    				}
		    			}
		    			,error : function(e) {alert("관리자에게 문의바랍니다.");}
		    			,beforeSend:function(){
		    				//전송 전
		    		    }
		    		    ,complete:function(){
		    		        //전송 후
		    		        
		    		    }
		    		});
		    		
		    		
					console.log('확인 클릭');
					
		        },cancel : function(){
		        	return;
		        	console.log("캔슬버튼 클릭 후 로그");
		        }
		    });
		}
	}
	
}

/*********************************************************
 *취소
 ******************************************************** */
function fn_cancelBtn(){
	location.href="<c:url value='/oper/groupManage.do' />";
}
/*********************************************************
 *회원 전체선택
 ******************************************************** */
function fn_member_All(){
	if($("#memberAllChk").hasClass("on")){
		$(".checkbox-inputM").prop('checked',false);
		$("#memberAllChk").removeClass("on");
	}else{
		$(".checkbox-inputM").prop('checked',true);
		$("#memberAllChk").addClass("on");
	}
	
}
/*********************************************************
 * 삭제버튼 클릭시
 ******************************************************** */
function fn_groupDelete(groupId){

	var grId = groupId; 
		Common.Dialog.confirm({
	        title: '그룹삭제',
	        content: '해당 그룹을 삭제하시겠습니까?'
	        ,ok: function(){
	        	$.ajax({
	        		cache:false,
	        		url:"<c:url value='/oper/groupDelete.do' />",
	        		type:"POST",
	        		data:{
	    				"groupId": grId 			
	    			}, 
	        		dataType:'json',
	        		cache : false,
	        		success:function(data){
// 	        			debugger;
	        			if(data == 1){
	        				location.href="<c:url value='/oper/groupManage.do' />";
	        			}else{
	        				Common.Dialog.alert({
	                            title: '그룹삭제'
	                            ,content: '그룹 삭제 처리에 실패했습니다.'
	                        });
	        			}
	        			
	        		}
	        		,error : function(e) {alert("관리자에게 문의바랍니다.");}
	        		,beforeSend:function(){		
	    				//전송 전
	    					
	    		    }
	    		    ,complete:function(){
	    		        //전송 후
	    		    	
	    		    }
	        		
	        	});
	            
		}
	    ,cancel : function(){
	        	
	    }
	});
}
function scrollAnimate(id,time,pd){
// 	debugger;
	var location = document.getElementById(id).offsetTop;
	if(pd){	location -= pd;}
	$("html").animate({scrollTop:location},time);
}
</script>
<!-- 구현부 : S -->

<div id="body_layout">	

    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
            <div id="location" class="title_wrap">
                <h2 class="page__title">그룹관리</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="<c:url value='/oper/groupManage.do'/>" >운영관리</a></li>
                        <li class="n3"><a href="<c:url value='/oper/groupManage.do'/>" class="navi_ov">그룹관리</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">
	          	
	          	
	        	<div class="p-row">
		        	<div class="p-col-24 p-col-sm-24">
			        	<h2 class="h2">그룹목록</h2>
			        	<div class="p-col-24 p-col-sm-24"></div>
		             	<div class="board_btm2" style="margin-bottom:15px;padding-right:3px;" >
		                    <div class="btns_area fl_r mo_block">
		                        <a href="javascript:fn_newGroupInsert();" class="btn btn-default btn-sm">신규</a>
		                    </div>
		                </div>
		                <div class="table_wrap table_scroll">
			                <table class="table_info"  style="table-layout: fixed; border-collapse: collapse;">
			                	<colgroup>
									<col style="width:9%">
									<col style="width:15%">
									<col style="width:15%">
									<col style="width:*">
									<col style="width:10%">
									<col style="width:15%">								
								</colgroup>
		                        <thead>
		                            <tr class="groupTH">
		                                <th>사용여부</th>
		                                <th>그룹아이디</th>
		                                <th>그룹명</th>
		                                <th>그룹설명</th>
		                                <th>구성원수</th>
		                                <th>등록일</th>
		                            </tr>
		                        </thead>
		                        <tbody>
	                            	<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
	                            		<tr onclick="javascript:fn_updateGroupBtn('${resultInfo.groupId}');" style="cursor: pointer;">
	                            			<c:choose>
	                            				<c:when test="${resultInfo.useAt =='Y' }">		                            				
	                            					<td>사용</td>
	                            				</c:when>
	                            				<c:otherwise>
	                            					<td>미사용</td>
	                            				</c:otherwise>
	                            			</c:choose>
	                            			<td>${resultInfo.groupId }</td>
	                            			<td>${resultInfo.groupNm }</td>
	                            			<td>${resultInfo.groupDc }</td>
	                            			<c:choose>
	                            				<c:when test="${resultInfo.groupMem == null }">
	                            					<td>0</td>
	                            				</c:when>
	                            				<c:otherwise>
	                            					<td class="memCnt" id="${resultInfo.groupId}">
	                            					<%-- <c:out value='${resultInfo.groupMem }'/> --%>
	                            					</td>
	                            					<script>
// 	                            						$('#<c:out value="${resultInfo.groupId}"/>').text(memCnt(<c:out value='${resultInfo.groupMem }'/>));
														var mem = "<c:out value='${resultInfo.groupMem }'/>";
														if(mem == ""){
															$('#<c:out value="${resultInfo.groupId}"/>').text("0");
														}else{															
	                            						$('#<c:out value="${resultInfo.groupId}"/>').text(memCnt(mem));
														}
	                            					</script>
	                            				</c:otherwise>
	                            			</c:choose>
	                            			
	                            			<td>${resultInfo.groupCreatDe }</td>
	                            		</tr>
	                            	</c:forEach>
		                      	</tbody>
			                </table>
		              		</div>
		        		</div>
		        	</div>
		        	<!-- 그룹목록 끝 -->
		        	
					<!-- 그룹상세정보 시작 -->	
		        	<div class="p-col-24 p-col-sm-24" style="padding: 15px 3px;"></div>
		        	<div id="groupInfo">
		        	<h2 class="h2">그룹상세정보</h2>
		        	<div class="p-col-24 p-col-sm-24"></div>
		             	<div class="board_btm2" style="margin-bottom:15px;padding-right:3px;" >
		                    <div class="btns_area fl_r mo_block">
		                        <a href="javascript:" id="deleteBtn" class="btn btn-secondary btn-sm" style="display:none;">삭제</a>
		                    </div>
		                </div>
					 <div class="board__banner">
						<div class="item">
						<form name="updateGrDt" id="updateGrDt" method="post">	
							<div class="form-horizontal bucket-form">
						        <div class="form-group">
								    <div class="col-sm-2 control-label"><label for="useAtY">사용여부</label></div>
								    <div class="col-sm-2">								    	
										<label class="radio-inline" for="useAtY">
										    <input type="radio" id="useAtY" name="useAt" value="Y" title="사용" style="margin-left: -33.2px;">Y
										</label>
										<label class="radio-inline" for="useAtN">
										    <input type="radio" id="useAtN" name="useAt" value="N" title="미사용" style="margin-left: -33.2px;">N
										</label>										
								   	</div>
								   	<div class="col-sm-2 control-label"><label for="">그룹아이디</label></div>
						            <div class="col-sm-2 control-label" id="groupId">
						                
						            </div>
						            <div class="col-sm-2 control-label"><label for="">그룹명</label></div>
						            <div class="col-sm-2">
						                <input type="text"  id="groupNm" name="groupNm" title="그룹명" class="form-control">
						            </div>
								</div>
						        <div class="form-group">
						            <div class="col-sm-2 control-label"><label for="">그룹설명</label></div>
						            <div class="col-sm-10">
						                <input type="text"  id="groupDc" name="groupDc" title="그룹설명" class="form-control">
						                <input type="hidden" id="grMem" name="groupMem">
						                <input type="hidden" id="groupId2" name="groupId">
						            </div>
						        </div> 
						    </div>
						   </form>
						</div>
					</div>
				
	                </div>
	                <!-- 그룹상세정보 끝 -->
	                <div class="p-row" id="groupInsert" style="display:none;">
	               	<div class="p-col-24 p-col-sm-24" style="margin-top:15px;"></div>
	                <!-- 그룹구성원 시작 -->
	               	<div class="p-col-12 p-col-sm-24" style="padding-right: 10px;">
			        <h2 class="h2">그룹구성원</h2>
			        <div class="p-col-12 p-col-sm-24"></div>
		             	<div class="board_btm2" style="margin-bottom:15px;">
		                    <div class="btns_area fl_r mo_block">
		                        <a href="javascript:" id="group_select_all" class="btn btn-default btn-sm">전체선택</a>
		                        <a href="javascript:" id="group_mem_delete" class="btn btn-secondary btn-sm">선택삭제</a>
		                    </div>
		                </div>
		                <div class="table_wrap table_scroll" style="height: 235px;">
			                <table class="table_info"  style="table-layout: fixed; border-collapse: collapse;">
		                        <thead>
			                        <colgroup>
										<col style="width:8%">
										<col style="width:25%">
										<col style="width:25%">
										<col style="width:21%">
										<col style="width:21%">								
									</colgroup>
		                            <tr class="groupTH">
		                            	<th>선택</th>
		                                <th>이름(회사명)</th>
		                                <th>아이디</th>
		                                <th>구분</th>
		                                <th>등급</th>
		                            </tr>
		                        </thead>
		                        <tbody id="groupMembertb">

		                        </tbody>
			                </table>
		                </div>
		        		</div>
		        	<!-- 그룹구성원끝 -->
		        	<!-- 회원검색 -->
		        	<div class="p-col-12 p-col-sm-24">
			        	<h2 class="h2">회원목록</h2>
			        	<div class="p-col-12 p-col-sm-24"></div>
		             	<div class="board_btm2" style="margin-bottom:9px;">
		                    <div class="btns_area fl_r mo_block">
		                    <form name="memSearch" id="memSearch" method="post">
		                    	<select name="searchSel" id="searchSel" style="height: 32px;width: 215px;">
		                    		<option value="">선택</option>
		                    		<option value="indvdl_mber_code">구분(법인,개인,관리자)</option>
		                    		<option value="grad_code_nm">등급</option>
		                    		<option value="user_nm">이름</option>
		                    		<option value="emplyr_id">아이디</option>
		                    	</select>
		                    	<input type="text" id="searchKrwd" name="searchKrwd" onkeydown="javascript:if(event.keyCode == 13)fn_memSearch();" style="display: inline-block; outline:#aaaaaa solid 1px; height: 30px;">
		                    	<a href="#" onClick="fn_memSearch();"  class="btn btn-default btn-sm" style="border-color:#fbcb00; background-color:#fbcb00;">검색</a>
		                        <a href="#" onclick="javascript:fn_member_All();return false;" id="memberAllChk" class="btn btn-default btn-sm">전체선택</a>
		                        <a href="#" onclick="javascript:fn_addGroup_Mem();return false;" id="addGroupMem" class="btn btn-secondary btn-sm">선택추가</a>
		                    </form>
		                    </div>
		                </div>
		                <div class="table_wrap table_scroll" style="height: 235px;">
			                <table class="table_info"  style="table-layout: fixed; border-collapse: collapse;">
		                        <thead >
		                        	<colgroup>
										<col style="width:8%">
										<col style="width:25%">
										<col style="width:25%">
										<col style="width:21%">
										<col style="width:21%">								
									</colgroup>
		                            <tr class="groupTH">
		                                <th>선택</th>
		                                <th>이름(회사명)</th>
		                                <th>아이디</th>
		                                <th>구분</th>
		                                <th>등급</th>
		                            </tr>
		                        </thead>
		                        <tbody id="memberLResult">
		                        	<tr><td colspan='5'>검색 결과가 없습니다.</td></tr>
		                        </tbody>
			                </table>
		                </div>
		        	</div>
		        	<!-- 회원검색끝 -->
		        	</div>
            		<div class="board_btm" style="border-top:none;" >
                        <div class="btns_area fl_r mo_block" id="btnBox" style="margin-top:15px; display:none;">
                            <a href="#" id="modifyBtn" class="btn btn-default">수정</a>
                            <a href="#" onclick="javascript:fn_newGroup();" id="newGroupBtn" class="btn btn-primary">등록</a>
							<a href="#" onclick="javascript:fn_cancelBtn();" class="btn btn-secondary">취소</a>
                        </div>
                    </div>
            </div>
        </div>
    </div>
    <!-- layout -->
</div>

<!-- 구현부 : E -->

<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>
</body>
</html>
