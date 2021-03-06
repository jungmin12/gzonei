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
 * 첫 페이지 화면
 ******************************************************** */
function fn_search(se){
	document.bnFrm.pageIndex.value = 1;
	document.bnFrm.se.value = se;
	document.bnFrm.action = "<c:url value='/admin/bannerRegist.do'/>";
	document.bnFrm.submit();
}
/*********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_select_linkPage(pageNo,se){
	document.bnFrm.pageIndex.value = pageNo;
	document.bnFrm.se.value = se;
	document.bnFrm.action = "<c:url value='/admin/bannerRegist.do'/>";
	document.bnFrm.submit();
}
/*********************************************************
 * 배너 등록
 ******************************************************** */
$(document).ready(function(){

	//접근 권한 조회
	if(checkAuth("adm004005", "menuAccesAt","")){
		$("#submitBtn").click(function(){
			  var startDate = $("#bgnDate").val();
		      var endDate = $("#endDate").val();
		      let today = new Date();   

		      let year = today.getFullYear(); // 년도
		      let month = today.getMonth() + 1;  // 월
		      let date = today.getDate();  // 날짜
		      
		      var nowDate = year + '-' + month + '-' + date;
		      
		      if(startDate != "" || endDate != ""){
// 		         if( nowDate < startDate ){
// 		            swal("날짜확인필요", "시작일이 현재날짜보다 클수 없습니다.","warning");
// 		            return false;
// 		         }
// 		         if( nowDate < endDate ){
// 		            swal("날짜확인필요", "종료일이 현재날짜보다 클수 없습니다.","warning");
// 		            return false;
// 		         }
		         if(endDate != ""){
		            if(startDate > endDate){
		               swal("날짜확인필요", "시작일이 종료일보다 클수 없습니다.","warning");
		               return false;
		            }
		         }
		      }
			 
		 //등록 권한 조회
		 if(checkAuth("adm004005", "infoRegistAt","")){
		 	var fileOk = $("#atchFile_1").val();
			var urlcheck = /(http(s)?:\/\/)([a-z0-9\w]+\.*)+[a-z0-9]{2,4}/gi;
			if($("#bgnDate").val() == ""){
				Common.Dialog.alert({
		            title: '배너등록'
		            ,content: '게시일을 선택해주세요.'
		        	,ok: function(){
		        		return;
		                console.log('확인 클릭');
		            }
		        });
			}else if($("#endDate").val() ==""){
				Common.Dialog.alert({
		            title: '배너등록'
		            ,content: '만료일을 선택해주세요.'
		        	,ok: function(){
						return;        		
		                console.log('확인 클릭');
		            }
		        });
			}else if(!fileOk){
				Common.Dialog.alert({
		            title: '배너등록'
		            ,content: '파일 첨부를 해주세요.'
		        	,ok: function(){
						return;
		                console.log('확인 클릭');
		            }
		        });
			}else if($("#url").val() != '' && $("#url").val() != null){
				if(!check(urlcheck,document.getElementById("url"),"url을 형식에 맞게 입력해주세요.")){
					$("#url").focus();
					return;
				}else{
					Common.Dialog.confirm({
				        title: '배너등록'
				        ,content: '배너를 등록하시겠습니까? '
				    	,ok: function(){
				    		document.bannerForm.action = "<c:url value='/admin/bannerInsert.do'/>";
				    		document.bannerForm.submit();
							console.log('확인 클릭');
							
				        },cancel : function(){
				        	return;
				        	console.log("캔슬버튼 클릭 후 로그");
				        }
				    });
				}
			}else if($("input[class='useAt']:checked").length<1){			
				Common.Dialog.alert({
		            title: '배너등록'
		            ,content: '사용여부를 선택해주세요.'
		        	,ok: function(){
						return;
		                console.log('확인 클릭');
		            }
		        });
			}else{
				Common.Dialog.confirm({
			        title: '배너등록'
			        ,content: '배너를 등록하시겠습니까? '
			    	,ok: function(){
			    		document.bannerForm.action = "<c:url value='/admin/bannerInsert.do'/>";
			    		document.bannerForm.submit();
						console.log('확인 클릭');
						
			        },cancel : function(){
			        	return;
			        	console.log("캔슬버튼 클릭 후 로그");
			        }
			    });
			}	
		 }	
		});
	}
	
	
});

/*********************************************************
 * 배너 삭제
 ******************************************************** */
function fn_delete_File(sn,fl,se){
	console.log(sn);
	console.log(fl);
	console.log(se);
	//삭제 권한 조회
	if(checkAuth("adm004005", "infoDelAt","")){
		Common.Dialog.confirm({
	        title: '배너삭제'
	        ,content: '해당 이미지를 삭제하시겠습니까?'
	    	,ok: function(){		
				console.log('확인 클릭');
				$.ajax({
					type:"POST",
					url:"<c:url value='/admin/bannerDelete.do' />",
					data:{
						"bannerManageSn": sn , "atchFileId" :fl			
					},
					dataType:"JSON",
					cache : false,
					success:function(result){
						
						if(result.result == '1'){
							Common.Dialog.alert({
					            title: '배너삭제'
					            ,content: '해당이미지 삭제 완료'
					        	,ok: function(){		
									fn_search(se);
					                console.log('확인 클릭');
					            }
					        });
						}else{
							Common.Dialog.alert({
					            title: '배너삭제'
					            ,content: '해당이미지 삭제 실패'
					        	,ok: function(){		
									fn_search(se);
					                console.log('확인 클릭');
					            }
					        });
						}
					}
				});
	        },cancel : function(){
	        	return;
	        	console.log("캔슬버튼 클릭 후 로그");
	        }
	    });
	}
}
/*********************************************************
 * 배너 정보 불러오기
 ******************************************************** */
function fn_detail_File(sn,fl,se){
	// 정보 조회 권한 조회
	if(checkAuth("adm004005", "infoInqireAt","")){
		$.ajax({
			type:"POST",
			url:"<c:url value='/admin/selectBannerDetail.do' />",
			data:{
				"bannerManageSn": sn , "atchFileId" :fl			
			},
			dataType:"JSON",
			cache : false,
			success:function(data){
				$("tr").remove("#popupSe");
				const bgn = new Date(data.bgndeMan);
				var by = bgn.getFullYear();
				var bmm = ("0" + (1 + bgn.getMonth())).slice(-2);
				var bdd = ("0" + bgn.getDate()).slice(-2);
				
				const end = new Date(data.endDe);
				var ey = end.getFullYear();
				var emm = ("0" + (1 + end.getMonth())).slice(-2);
				var edd = ("0" + end.getDate()).slice(-2);
							
				if(data != null){
					$("#fileNm").html(data.orignlFileNm);
					$("#bannerSn").val(sn);
					if("N" == checkAuthValue("adm004005", "infoDspyAt")){
						$("#useAtN").prop('checked',true);
						$("#useAtN").attr('onclick','return(false);');
						$("#useAtY").attr('onclick','return(false);');
					}else{
						if(data.useAt =='Y'){
							$("#useAtY").prop('checked',true);
						}else{
							$("#useAtN").prop('checked',true);
						}
					}
					
					$("#bgnPop").attr('placeholder',by+"-"+bmm+"-"+bdd);
					$("#bgnPop").attr('value',by+"-"+bmm+"-"+bdd);
					$("#endPop").attr('placeholder',ey+"-"+emm+"-"+edd);
					$("#endPop").attr('value',ey+"-"+emm+"-"+edd);
					
					if(se == 'CM00330003' || se == 'CM00330001'){
						var html = "";
						html += "<tr id='popupSe'><th>url</th>";
						html += "<td>";
						html += "<div class='col-sm-12'>";
						if(data.url==undefined){
							html += "<input input type='text'  name='linkurl' id='linkurl' title='url주소 입력' class='form-control' value=''>";
						}else{							
							html += "<input input type='text'  name='linkurl' id='linkurl' title='url주소 입력' class='form-control' value='"+data.url+"'>";
						}
						html += "<span style='color:red; margin-left: -175px;'>http:// 또는 https:// 필수 입력</span></div>";
						html += "</div>";
						html += "</td></tr>";
						$("#bnResult").append(html);	
					}
				}
				
				
				$("#modal-banner").modal();
			}
		});
	}
	
}

/*********************************************************
 * 배너 정보 수정
 ******************************************************** */
 function fn_updtBannerDt(){
	 var linkAdr = /(http(s)?:\/\/)([a-z0-9\w]+\.*)+[a-z0-9]{2,4}/gi;
	//정보 수정 권한 조회
	if(checkAuth("adm004005", "infoUpdtAt","")){
		var se = $("#se").val();
		var bgn = new Date($("#bgnPop").val());
		var end = new Date($("#endPop").val());
		var params = $("#udtBnFrm").serialize();
		
		if(bgn > end){
			swal("날짜확인필요", "시작일이 종료일보다 클수 없습니다.","warning");
            return false;
		}else if($("#linkurl").val() != '' && $("#linkurl").val() != null){
			if(!check(linkAdr,document.getElementById("linkurl"),"url을 형식에 맞게 입력해주세요.")){
				$("#linkurl").focus();
				return;
			}else{
				$.ajax({
					type:"POST",
					url:"<c:url value='/admin/updateBannerInfo.do' />",
					data:params,
					dataType:"JSON",
					cache : false,
					success:function(result){
						if(result.result == '1'){
							Common.Dialog.alert({
					            title: '배너수정'
					            ,content: '해당배너 수정 완료'
					        	,ok: function(){		
									fn_search(se);
					                console.log('확인 클릭');
					            }
					        });
						}else{
							Common.Dialog.alert({
					            title: '배너수정'
					            ,content: '해당배너 수정 실패'
					        	,ok: function(){		
									fn_search(se);
					                console.log('확인 클릭');
					            }
					        });
						}
					}
					
				});	
			}
// 		else if(!check(linkAdr,document.getElementById("linkurl"),"url을 형식에 맞게 입력해주세요.")){
// 			$("#linkurl").focus();
// 			return;
// 		}
		}else{
			$.ajax({
				type:"POST",
				url:"<c:url value='/admin/updateBannerInfo.do' />",
				data:params,
				dataType:"JSON",
				cache : false,
				success:function(result){
					if(result.result == '1'){
						Common.Dialog.alert({
				            title: '배너수정'
				            ,content: '해당배너 수정 완료'
				        	,ok: function(){		
								fn_search(se);
				                console.log('확인 클릭');
				            }
				        });
					}else{
						Common.Dialog.alert({
				            title: '배너수정'
				            ,content: '해당배너 수정 실패'
				        	,ok: function(){		
								fn_search(se);
				                console.log('확인 클릭');
				            }
				        });
					}
				}
				
			});	
		}
	}
	
}
function check(re, what, message) {
	var matchPart = re.exec(what.value);
	if(matchPart != null) {
        return true;
    } 
	swal("url 확인", message,"warning");

	if(what.id != "linkurl"){
		what.value = "";
	}
    what.focus();
    //return false;
}
</script>
<!-- 구현부 : S -->
<div id="body_layout">	

    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
        	<div id="location" class="title_wrap">
                <h2 class="page__title">배너관리​</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="<c:url value='/oper/groupManage.do'/>" >운영관리</a></li>
                        <li class="n3"><a href="<c:url value='/admin/bannerRegist.do'/>" class="navi_ov">배너관리</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                    <!-- 프린트 시작 -->
                    <!-- 프린트 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div> 
            
            <div id="txt">
			<form name="bnFrm" id="bnFrm" method="post">
            <div class="nav-4th" id="tab_menu">
				<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
				<ul>
					<li style="cursor:pointer;" <c:if test="${searchVO.se == 'CM00330001'}">class="active"</c:if>><a href="javascript:fn_search('CM00330001');">상단 슬라이드</a></li>
					<li style="cursor:pointer;" <c:if test="${searchVO.se == 'CM00330002'}">class="active"</c:if>><a href="javascript:fn_search('CM00330002');">메인 배경</a></li>
					<li style="cursor:pointer;" <c:if test="${searchVO.se == 'CM00330003'}">class="active"</c:if>><a href="javascript:fn_search('CM00330003');">팝업 슬라이드</a></li>
				</ul>
			</div>
			<input type="hidden" name="se" id="se" value="${searchVO.se }">
			</form>
            <!-- content 영역입니다. -->
            <form name="bannerForm" id="bannerForm"  method="post"  enctype="multipart/form-data" >
			<input type="hidden" name="se" id="se" value="${searchVO.se }">
            <div class="board__banner">
				<!-- 배너01 -->
				<h2 class="h2" id="bannerTit">
					<c:if test="${searchVO.se == 'CM00330001'}">상단 슬라이드</c:if>
					<c:if test="${searchVO.se == 'CM00330002'}">메인 배경</c:if>
					<c:if test="${searchVO.se == 'CM00330003'}">팝업 슬라이드</c:if>
				</h2>
				<div class="item">
					<div class="form-horizontal bucket-form">
				        
				            <div class="col-sm-2 control-label"><label for="">게시일자</label></div>
				            <div class="col-sm-4">
				                <div class="search--calendar">
									<span>
										<input type="text" class="form-control" name="bgndeMan" id="bgnDate" placeholder="게시일자" value="" title="게시일자 입력" autocomplete="off">
                                    <button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
									</span>
								</div>
				            </div>
				            <div class="col-sm-2 control-label"><label for="">만료일자</label></div>
				            <div class="col-sm-4">
				                <div class="search--calendar">
									<span>
										<input type="text" class="form-control" name="endDe" id="endDate" placeholder="만료일자" value="" title="만료일자 입력" autocomplete="off">
                                    <button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
									</span>
								</div>
				            </div>
				     		<div class="form-group">
						    	<div class="col-sm-2 control-label col-lg-2"><label for="select">첨부파일 </label></div>
							    <div class="col-sm-10">
							    	<div class="form-upload">
							    	 	<div class="file-form-group">
							    	 		<div class="form-group__upload">
							    	 			<input type="text" readonly="readonly" name="atchFileNm" class="form-control disabled">
							    	 			<input type="file" name="atchFile_1" id="atchFile_1" class="form-upload__file--hidden" accept="image/*">
							    	 		</div>
							    	 		<div class="form-input__addon">
							                    <label for="atchFile_1" class="btn btn-primary" data-button="upload">파일첨부하기</label>    
							               </div>
							    	 	</div>
							    	</div>
								</div>
							</div>
							<c:if test="${searchVO.se == 'CM00330003' or searchVO.se == 'CM00330001'}">						
							<div class="form-group">
				            <div class="col-sm-2 control-label"><label for="">url 링크</label></div>
					            <div class="col-sm-10">
					                <input type="text"  name="linkurl" id="url" title="url주소 입력" class="form-control" placeholder="https://www.gzonei.com">
					                <span style="color:red">http:// 또는 https:// 필수 입력</span>
					            </div>
				        	</div>
				        	</c:if>
				        	<div class="form-group">
				        	 <div class="col-sm-2 control-label"><label for="">사용여부</label></div>
					            <div class="col-sm-9">
					            	<c:if test="${sessionScope.authVO.adm004005.infoDspyAt == 'Y'}">
									<label class="radio-inline" for="radio1">
									    <input type="radio" class="useAt" id="radio1" name="useAt" title="사용" value="Y" style="margin-left:-33px;">Y
									</label>
									<label class="radio-inline" for="radio2">
									    <input type="radio" class="useAt" id="radio2" name="useAt" title="미사용" value="N" style="margin-left:-34px">N
									</label>
									</c:if>
									<c:if test="${sessionScope.authVO.adm004005.infoDspyAt == 'N'}">
									<label class="radio-inline" for="radio1">
									    <input type="radio" id="radio1" name="useAt" title="사용" value="Y" onclick="return(false);" style="margin-left:-33px">Y
									</label>
									<label class="radio-inline" for="radio2">
									    <input type="radio" id="radio2" name="useAt" title="미사용" value="N" checked onclick="return(false);" style="margin-left:-34px" >N (수정불가)
									</label>
									</c:if>
					   			</div>
				        	</div>
							<div class="form-group" >
			                    <div class="btns_area fl_r mo_block" style="float:right; cursor:pointer;">
			                        <button type="button" id="submitBtn" class="btn btn-default">등록</button>
			                    </div>
				        </div>
				       
				        
				    </div>
				    
                </div>
                	
			</div>
			</form>
				<!-- 배너01 -->	
				<script>
				$(document).ready(function(){
				    
				        
				    $.datetimepicker.setLocale('ko');
				    $("#bgnDate").datetimepicker({
				        timepicker : false,
				        format : 'Y-m-d',
				        scrollMonth : false,
				        scrollInput : false,
				        validateOnBlur: false,
				        onShow:function(){
				            var end = $("#endDate").val();
				            var start = $("#bgnDate").val();
				            this.setOptions({
				              dateFormat: 'Y-m-d',
				              maxDate: end? end : false,
				              minDate: 0
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
				            var end = $("#endDate").val();
				            var start = $("#bgnDate").val();
				            this.setOptions({
				              dateFormat: 'Y-m-d',
				             
				              minDate: start? start : false
				            })
				          }
				    }).on('keydown', function(event){
				    	onlyNum(this,event);
						});
				    
				    $("#bgnPop").datetimepicker({
				        timepicker : false,
				        format : 'Y-m-d',
				        scrollMonth : false,
				        scrollInput : false,
				        validateOnBlur: false,
				        onShow:function(){
				            var end = $("#endPop").val();
				            var start = $("#bgnPop").val();
				            this.setOptions({
				              dateFormat: 'Y-m-d',
				              minDate: 0
				            })
				          }
				    }).on('keydown', function(event){
				    	onlyNum(this,event);
						});
				    
				    $("#endPop").datetimepicker({
				        timepicker : false,
				        format : 'Y-m-d',
				        scrollMonth : false,
				        scrollInput : false,
				        validateOnBlur: false,
				        onShow:function(){
				            var end = $("#endPop").val();
				            var start = $("#bgnPop").val();
				            this.setOptions({
				              dateFormat: 'Y-m-d',
				             
				              minDate: start? start : false
				            })
				          }
				    }).on('keydown', function(event){
				    	onlyNum(this,event);
						});
				    
				    
				}); 
				</script>
			 <div class="title_wrap" style="margin:50px 0 30px">
				<h4 class="sub_tit"></h4>
			</div>
			<div class="guide_item" style="margin-top:0;">
				<!-- Table : S -->
				<div class="table-responsive mt_20">
					<table class="table table-bordered text-center">
						<caption>테이블 안내 – 구분, 부서/직위, 성명, 연락처, 홈페이지 정보 제공</caption>
						<colgroup>
							<col style="width:7%">
							<col style="width:*">
							<col style="width:7%">
							<col style="width:13%">
							<col style="width:13%">
							<col style="width:7%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">파일명</th>
								<th scope="col">사용여부</th>
								<th scope="col">게시일</th>
								<th scope="col">만료일</th>
								<th scope="col">삭제</th>
							</tr>
						</thead>
						<tbody id="resultList">
							<c:choose>
							<c:when test="${resultList == null or fn:length(resultList) == 0 }">
								<tr>
									<td colspan="6">등록된 배너 없음</td>
								</tr>
							</c:when>
							<c:otherwise>
							<c:forEach items="${resultList}" var="result" varStatus="status">
							<tr>
								<td onclick="jsvascript:fn_detail_File('${result.bannerManageSn}','${result.atchFileId }','${result.se }')" style="cursor:pointer">${result.rownum }</td>
								<td onclick="jsvascript:fn_detail_File('${result.bannerManageSn}','${result.atchFileId }','${result.se }')" style="cursor:pointer">${result.orignlFileNm }</td>
								<td onclick="jsvascript:fn_detail_File('${result.bannerManageSn}','${result.atchFileId }','${result.se }')" style="cursor:pointer">${result.useAt }</td>
								<td onclick="jsvascript:fn_detail_File('${result.bannerManageSn}','${result.atchFileId }','${result.se }')" style="cursor:pointer">${result.bgndeMan }</td>
								<td onclick="jsvascript:fn_detail_File('${result.bannerManageSn}','${result.atchFileId }','${result.se }')" style="cursor:pointer">${result.endDe }</td>
								<c:if test="${sessionScope.authVO.adm004005.infoDelAt == 'Y'}">
								<td><button  onclick="jsvascript:fn_delete_File('${result.bannerManageSn}','${result.atchFileId }','${result.se }')" type="button" class="btn btn-secondary btn-sm">삭제</button></td>
								</c:if>
								<c:if test="${sessionScope.authVO.adm004005.infoDelAt == 'N'}">
								<td>삭제불가</td>
								</c:if>
							</tr>
							</c:forEach>
							</c:otherwise>
							</c:choose>
						</tbody>
						
					</table>
				</div>
				<div class="pagination-inner">
					<ul class="pagination" id="pagination">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_linkPage('${result.se }')"/>	
						
					</ul>
				</div>
							
				<!-- Table : E -->
            </div>
				
			
			
		
			
				<!-- content 영역입니다. -->
            </div>
        </div>
    </div>
    <!-- layout -->
</div>
<!-- Modal Sample - body바로 밑에 놔주세요 :: S -->
		        <div class="modal fade" role="dialog" data-ly-type="content" data-ly-target="modal-banner" id="modal-banner">
		            <div class="modal-dialog">
		                <!-- Modal content-->
		                <div class="modal__body">
		                    <div class="modal__header">
		                       <h4 class="modal__title">배너수정</h4>
		                        <div class="modal__close-button"><button type="button" class="close" data-dismiss="modal">닫기</button></div>
		                    </div>
		                    <div class="modal__content" style="word-break: break-all">
		                        <div class="cont_wrap">
		                            <div class="table_wrap">
		                                <form name='udtBnFrm' id='udtBnFrm' method='post'>
		                                
		                                <table class="table_info">
			                                <colgroup>
												<col style="width:30%">
												<col style="width:*">
											</colgroup>
		                                    <tbody id="bnResult">
												<tr>
													<th>파일명</th>
													<td id="fileNm" style="text-align:left; padding-left:30px;"></td>
												</tr>
												<tr><th>사용여부</th>
													<td>
														<div class='col-sm-9' style="margin-left: -80px;">
															<input type="hidden" id="bannerSn" name="bannerManageSn">
															<label class='radio-inline' for='useAtY'>
															<input type='radio' id='useAtY' name='useAt' title='사용' value='Y'>Y</label>
															<label class='radio-inline' for='useAtN'>
															<input type='radio' id='useAtN' name='useAt' title='사용' value='N'>N</label>
														</div>
													</td>
												</tr>
												<tr>
													<th>게시일자</th>
													<td>
														<div class="col-sm-12">
											                <div class="search--calendar">
																<span>
																	<input type="text" class="form-control" name="bgndeMan" id="bgnPop" placeholder="" value="" title="게시일자 입력" autocomplete="off">
							                                    <button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
																</span>
															</div>
				            							</div>
													</td>
												</tr>
												<tr>
													<th>만료일</th>
													<td>
														<div class="col-sm-12">
											                <div class="search--calendar">
																<span>
																	<input type="text" class="form-control" name="endDe" id="endPop" placeholder="" value="" title="게시일자 입력" autocomplete="off">
							                                    <button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
																</span>
															</div>
				            							</div>
													</td>
												</tr>
		                                    </tbody>                            
		                                </table>
										</form>
		                            </div>
		                        </div>
		                    </div>
		                    
		                    <div class="modal__footer">
			                    <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			                    <button type="button" onclick="javascript:fn_updtBannerDt();" class="btn btn-primary">수정</button>
			                 </div>
		                </div>
		            </div>
		        </div>
				<!-- Modal Sample - body바로 밑에 놔주세요 :: E -->
<!-- 구현부 : E -->
<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>
</body>
</html>