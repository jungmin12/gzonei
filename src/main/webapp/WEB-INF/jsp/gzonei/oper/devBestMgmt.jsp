<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
<!-- 행정안전부 공통서비스 테스트 사이트 -->
<!DOCTYPE html>
<html lang='ko'>
<script type="text/javascript"
	src="<c:url value='/js/gzonei/jquery-3.5.1.js' />"></script>

<script type="text/javascript"
	src="<c:url value='/html/egovframework/com/cmm/utl/ckeditor/ckeditor.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/html/egovframework/com/cmm/utl/ckeditor/adapters/jquery.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/gzonei/devlopInfo/devlopInfo.js'/>"></script>
<head>
<%@ include file="/WEB-INF/jsp/gzonei/layout/header.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/jsp/gzonei/layout/admintop.jsp" %>
<!-- 구현부 : S -->
<div id="body_layout">	
<%@ include file="/WEB-INF/jsp/gzonei/oper/devBestInsertModal.jsp" %>

    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contents" class="contents_wrap">
             <div id="location" class="title_wrap">
                <h2 class="page__title">샘플관리</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">샘플관리</a></li>

                        <li class="n2"><a href="<c:url value='/oper/groupManage.do'/>" >운영관리</a></li>
                        <li class="n3"><a href="<c:url value='/oper/selectDevBestList.do'/>" class="navi_ov">샘플관리</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>
             	<div id="txt">
					<div class="board_view_in">
                   		<form id="devBestForm" name="devBestForm" method="post" enctype="multipart/form-data">
                   			<div class="form-horizontal bucket-form">
								<c:forEach items="${bestList}" var="list" varStatus="status">
									<div class="form-group">
										<div class="col-sm-1 control-label col-lg-2">
											<div style="    margin: 8px 0px 13px 42px;font-size: larger;font-weight: bold">개발 정보 전시${status.count}</div>
										</div>
										<div class="col-sm-1">
											<button type="button" class="btn-sm btn-primary devInfoSearch"  onclick="devInfoSearch('${status.count}');" style="border-radius: 10px;">개발사업 검색</button>
										</div>
										<div class="col-sm-1">
											<div  style="margin: 8px 0px 8px 19px;font-size: medium;font-weight: bold;">사업번호</div>
										</div>
										<div class="col-sm-3">
											<input type="text" id="dwkNo${status.count}" name="dwkNo${status.count}" value="${list.dwkNo}" readonly class="form-control">

										</div>
										<div class="col-sm-1">
											<div style="margin: 8px 0px 8px 31px;font-size: medium;font-weight: bold;">사업명</div>
										</div>
										<div class="col-sm-3">
											<input type="text" id="dwkNm${status.count}" name="dwkNm${status.count}" value="${list.dwkNm}" readonly  class="form-control">
										</div>
									</div>
									<div class = "form-group">
										<div class="col-sm-1 control-label col-lg-2">
										<input type="hidden" id="bsnsSn${status.count}" name="bsnsSn${status.count}" value="${list.bsnsSn}" >
										<input type="hidden" id="atchFileId${status.count}" name="atchFileId${status.count}">
										<input type="hidden" id="smpleManageNo${status.count}" name="smpleManageNo${status.count}" value="${status.count}">
										</div>
										<div class="col-sm-1">
										<input type="hidden" id="frstRegisterId${status.count}" name="frstRegisterId${status.count}">
										<input type="hidden" id="lastUpdusrId${status.count}" name="lastUpdusrId${status.count}">
										<input type="hidden" id="flpth${status.count}" name="flpth${status.count}">
										</div>
										<div class="col-sm-1">
											<div style="    margin: 1px 0px 8px 19px;font-size: medium;font-weight: bold;">첨부파일</div>
										</div>
<!-- 										<div class="col-sm-3__upload"> -->
<!-- 							    	 		<input type="text" readonly="readonly" class="form-control disabled" name="atchFileNm"> -->
<!-- 							    	 		<input type="file" name="atchFile_1" id="atchFile_1" class="form-upload__file--hidden"> -->
<%-- 											<input type="text" id="fileNm${status.count}" name="fileNm${status.count}" value="${list.fileNm}" readonly class="form-control fileInfo"> --%>
<!-- 										</div> -->
<!-- 										<div class="col-sm-1"> -->
<!-- 											<label for="label">파일 경로</label> -->
<!-- 										</div> -->
<!-- 										<div class="col-sm-3"> -->
<%-- 											<input type="text" id="flpth${status.count}" name="flpth${status.count}" value="${list.flpth}" readonly  class="form-control"> --%>
<!-- 										</div> -->
										<div class="form-upload">
							    	 	<div class="file-form-group">
							    	 		<div class="form-group__upload"style="padding-left: 5px;">
							    	 			<input type="text" readonly="readonly" class="form-control disabled" name="atchFileNm${status.count}" id="atchFileNm${status.count}" value="${list.fileNm}">
							    	 			<input type="file" name="atchFile_${status.count}" id="atchFile_${status.count}" class="form-upload__file--hidden">
<%-- 							    	 			<input type="hidden" name="orignlfilenmInfo${status.count}" id="orignlfilenmInfo${status.count}" > --%>
							    	 		</div>
							    	 		<div class="form-input__addon" style="padding-right: 123px">
							                    <label for="atchFile_${status.count}" class="btn btn-sm btn-secondary" data-button="upload">파일첨부</label>
							                    <button type="button" class="btn btn-sm btn-primary file_del_btn">삭제</button>
							               </div>
							               <div class="form-group file_author" style="display:none;">
										    <div class="col-sm-2 control-label col-lg-2"><label for="select">첨부파일 권한<span class="pilsu">필수</span></label></div>
										    <div class="col-sm-4">
											    <select name="fileAuthor" class="form-control">
											    	<option value="CM00209998">무료</option>
											    </select>
									    	</div>
									</div>
								    	</div>
										</div>
										</div>
								</c:forEach>
							</div>
						</form>
	                    <div class="board_btm">
	                        <div class="btns_area fl_r mo_block">
									<button onclick="updateBest();" class="btn-lg btn-primary" style="border-radius: 10px;">등록</button> 
	                        </div>
	                    </div>
	                    
    <script>
	function updateBest(){
		if(checkAuth("adm004004", "infoUpdtAt","")){
	    Common.Dialog.confirm({
	         title: '등록',
	          content: '현재 게시글을 등록하시겠습니까?'
	          ,ok: function(){
				Common.Dialog.alert({
			        title: '등록',
			        content: '등록되었습니다'
			        ,ok: function(){
			       	 	 document.devBestForm.action = "<c:url value='/oper/updateDevBestList.do'/>";
			       		 document.devBestForm.submit();
			        }
			   });
			},cancel : function(){
	            return false;
	         }
	      }); 
		}
	}
	$(document).ready(function() {
		checkAuth("adm004004", "menuAccesAt","");
	});
</script>
					</div>
				</div>
         </div>
    </div>
    <!-- layout -->
</div>
<!-- 구현부 : E -->
		<!-- bottom -->

<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>
<script>
	function devInfoSearch(i){
		$('#devModal').modal('show');
		devBestListSearch(i,2);
	}
	function devBestInsert(i){
		
	}
	$( document ).ready(function() {
		$('#devBestListSearch').on('click',function(e){
			devBestListSearch('',1);
		});
		$('#devBestContents').on('click','tr',function(e){
			  //개발사업 일련번호(UUID)
		      var devlopInfoSn = e.currentTarget.id;
		      //개발사업번호
		      var dwkno = e.currentTarget.dataset.dwkno;
		      //개발사업명
		      var dwknm = e.currentTarget.dataset.dwknm;
		      //선택한 인덱스
		      var index = e.currentTarget.dataset.index;
		      //첨부파일 명
		      var orignlfilenm = e.currentTarget.dataset.orignlfilenm;
		      var fileStreCours = e.currentTarget.dataset.fileStreCours;
		      var atchFileId = e.currentTarget.dataset.atchFileId;
			  //투자정보 입력폼에 개발사업번호 넘기기
			  var devlopInfoSnInfo = "#bsnsSn"+index;
			  var dwknmInfo = "#dwkNm"+index;
			  var dwknoInfo = "#dwkNo"+index;
			  var orignlfilenmInfo = "#fileNm"+index;
			  var fileStreCoursInfo = "#flpth"+index;
			  var atchFileIdInfo = "#atchFileId"+index;
			  $(devlopInfoSnInfo).val(devlopInfoSn);
			  $(dwknmInfo).val(dwknm);
			  $(dwknoInfo).val(dwkno);
			  $(orignlfilenmInfo).val(orignlfilenm);
			  $(fileStreCoursInfo).val(fileStreCours);
			  $(atchFileIdInfo).val(atchFileId);
			  $('#devModal').modal('hide');
		});
		$('.fileInfo').on('click',function(){
			
		});
		
	});
	function devBestListSearch(i,val){
		var paginationDiv = $('#devBestPagination');
		devBestPaginationInit(paginationDiv);
		//Page index
		if(val){
			$('#pageIndexDevBest').val(1);
		}
		
		if(val == 2){
			$('#bestDevArea1').val("");
			document.getElementById("bestDevArea2").options.length=1;
			$('#bestDevArea2').val("");
			$('#searchCondition').val("dwkNm");
			$('#pageIndexInvt').val("1");	
			
		}
		
		var params = $('#devBestInsertForm').serializeArray();
		var dataHtml;
		var resData; 
		$.ajax({
	        type : 'POST',
	        url : getContextPath() + "/devlopInfo/selectDevInfoModalList.do",
	        async: false,
	        datatype : 'json',
	        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
	        data: params,
	        success : function(data){
	        	resData = JSON.parse(data);
	        	var sortArea1List = resData.area1List.sort(function(a, b) {
	        	    return a.sortOrdr < b.sortOrdr ? -1 : a.sortOrdr > b.sortOrdr ? 1 : 0;
	        	});
	        	devInfoOptionset(sortArea1List,'bestDevArea1','전체',resData.searchVO.area1);
	        	if(resData.resultListTotCnt == 0){
	    			dataHtml += "<tr><td style='border: solid 1px ;text-align: center;'colspan='2'>검색 결과가 없습니다</td></tr>";
	    		}else{
		        	resData.resultList.forEach(function(data, index){
		        		dataHtml += "<tr id='" + data.devlopInfoSn + "' data-dwkNo='"+data.dwkNo+"' data-dwkNm='"+data.dwkNm+"' data-index='"+i+"' data-orignlFileNm ='" + data.orignlFileNm +"' data-fileStreCours ='" + data.fileStreCours + "' data-atchFileId ='"+data.atchFileId+"' style='cursor: pointer;'>";
	        			dataHtml += "<td class='listtd'>" + data.dwkNo +"</td>";
	        			dataHtml += "<td class='listtd'>" + data.dwkNm + "</td>";
	        			dataHtml += "</tr>";
		        	});
	    		}
	        	$('#devBestTotalCount').html(addComma(resData.resultListTotCnt));
	        	$('#devBestContents').html(dataHtml);
	        	devBestMakePage(paginationDiv,resData.resultListTotCnt,resData.paginationInfo.currentPageNo, 5);
	        },
	        error:function(e){
	        	console.log(e);
	        	alert('devlopinfo_list_조회 실패' + e);
	    	},complete:function(){
	    		flag = true;
	    	}
	    });
	}

	function devBestPaginationInit(paginationDiv){
		paginationDiv.empty();
		paginationDiv.removeData("twbs-pagination");
		paginationDiv.unbind("page");
	}

	function devBestMakePage(paginationDiv,totalPages, currentPageNo, pageCount){
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
		    	document.devBestInsertForm.pageIndex.value = page;
		    	devBestListSearch();
		    }
		});
		paginationDiv.children().children('.first').children('a').attr('aria-label','first');
		paginationDiv.children().children('.Previous').children('a').attr('aria-label','Previous');
		paginationDiv.children().children('.Next').children('a').attr('aria-label','Next');
		paginationDiv.children().children('.last').children('a').attr('aria-label','last');
	}
	
	function addComma(num) {
		var result = '';
		if(num!=null){
			var regexp = /\B(?=(\d{3})+(?!\d))/g;
			result = num.toString().replace(regexp, ',')
		}
		return result;
	}
</script>
<script type="text/javascript"  src="<c:url value='/js/gzonei/devlopInfo/twbsPagination.js'/>"></script>
</body>
</html>