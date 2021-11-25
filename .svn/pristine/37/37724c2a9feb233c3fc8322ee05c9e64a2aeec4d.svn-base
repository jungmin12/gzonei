var flag = true;
$( document ).ready(function() {
	//정선,중원================
	$('#showModalBtn').on('click',function(e){
		invDevlopListSearch();
	});
	$('#showModalBtnDtl').on('click',function(e){
		invDevlopListSearch();
	});
	$('#invDevlopListSearch').on('click',function(e){
		invDevlopListSearch(1);
	});
	$('#devInfoSchModalBtn').on('click',function(e){
		/*$('#nwsDevlopInsertModal').css('display','block');*/
		nwsDevlopListSearch();
	});
	$('#nwsDevlopListSearch').on('click',function(e){
		/*$('#nwsDevlopInsertModal').css('display','block');*/
		nwsDevlopListSearch(1);
	});
	//개발사업 정보 선택모달 닫기(버튼)
	$('#invtDevlopInsertModal_CloseSpan, #invtDevlopCancleBtn').on('click', function(e){
		$('#invtDevlopInsertModal').css('display','none');
	});
	$('#invtDevlopListSearch').on('click', function(e){
		invtDevlopListSearch();
	});
	$('#invDevlopContents,#nwsDevlopContents').on('click','tr',function(e){
		  //개발사업 일련번호(UUID)
	      var devlopInfoSn = e.currentTarget.id;
	      //개발사업번호
	      var dwkno = e.currentTarget.dataset.dwkno;
	      //개발사업명
	      var dwknm = e.currentTarget.dataset.dwknm;
		//투자정보 입력폼에 개발사업번호 넘기기
	      if(document.invInsertDiv){
		      document.invInsertDiv.dwkno.value = dwkno;
		      document.invInsertDiv.dwknm.value = dwknm;
		      document.invDetailDiv.dwknm.value = dwknm;
		      document.invDetailDiv.dwkno.value = dwkno;
	      }else{
		      /*document.insertForm.dwkno.value = dwkno;*/
		      document.insertForm.dwknm.value = dwknm;
//		      $('#modal-search').modal('hide');
	      }
//		$('#invDevlopInsertModal').css('display','none');
		$('#nwsDevlopInsertModal').css('display','none');
	});
	//정선================
});

//개발사업 정보 선택입력(정선)
function invDevlopListSearch(val){
	var paginationDiv = $('#invDevlopPagination');
	nwsPaginationInit(paginationDiv);
	//Page index
	if(val){
		$('#pageIndexInvt').val(1)
	}
	var params = $('#invDevlopInsertForm').serializeArray();
	//var initVal = {name:'initVal',value:'init'};
	//params.push(initVal);
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
        	if(resData.resultListTotCnt == 0){
    			dataHtml += "<tr><td style='border: solid 1px ;text-align: center;'colspan='2'>없음</td></tr>";
    		}else{
	        	resData.resultList.forEach(function(data, index){
	        		dataHtml += "<tr id='" + data.devlopInfoSn + "' data-dwkNo='"+data.dwkNo+"'  data-dwkNm='"+data.dwkNm+"' data-dismiss='modal' style='cursor: pointer;'>";
        			dataHtml += "<td class='listtd'>" + data.dwkNo +"</td>";
        			dataHtml += "<td class='listtd'>" + data.dwkNm + "</td>";
        			dataHtml += "</tr>";
	        	});
    		}
        	$('#invDevlopTotalCount').html(addComma(resData.resultListTotCnt));
        	$('#invDevlopContents').html(dataHtml);
        	invDevlopMakePage(paginationDiv,resData.resultListTotCnt,resData.paginationInfo.currentPageNo, 5);
        },
        error:function(e){
        	console.log(e);
        	alert('devlopinfo_list_조회 실패' + e);
    	},complete:function(){
    		flag = true;
    	}
    });
}
//----------------------
function nwsDevlopListSearch(val){
	var paginationDiv = $('#nwsDevlopPagination');
	nwsPaginationInit(paginationDiv);
	//Page index
	if(val){
		$('#pageIndexNws').val(1);
	}
	
	var params = $('#nwsDevlopInsertForm').serializeArray();
	//var initVal = {name:'initVal',value:'init'};
	//params.push(initVal);
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
        	if(resData.resultListTotCnt == 0){
    			dataHtml += "<tr><td style='border: solid 1px ;text-align: center;'colspan='2'>없음</td></tr>";
    		}else{
	        	resData.resultList.forEach(function(data, index){
	        		dataHtml += "<tr id='" + data.devlopInfoSn + "' data-dwkNo='"+data.dwkNo+"'  data-dwkNm='"+data.dwkNm+"' data-dismiss='modal' style='cursor: pointer;'>";
        			dataHtml += "<td class='listtd'>" + data.dwkNo +"</td>";
        			dataHtml += "<td class='listtd'>" + data.dwkNm + "</td>";
        			dataHtml += "</tr>";
	        	});
    		}
        	$('#nwsDevlopTotalCount').html(resData.resultListTotCnt);
        	$('#nwsDevlopContents').html(dataHtml);
        	nwsDevlopMakePage(paginationDiv,resData.resultListTotCnt,resData.paginationInfo.currentPageNo, 5);
        },
        error:function(e){
        	console.log(e);
        	alert('devlopinfo_list_조회 실패' + e);
    	},complete:function(){
    		flag = true;
    	}
    });
}

function nwsPaginationInit(paginationDiv){
	paginationDiv.empty();
	paginationDiv.removeData("twbs-pagination");
	paginationDiv.unbind("page");
}

function invDevlopMakePage(paginationDiv,totalPages, currentPageNo, pageCount){
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
	    	document.invDevlopInsertForm.pageIndex.value = page;
	    	invDevlopListSearch();
	    }
	});
	paginationDiv.children().children('.first').children('a').attr('aria-label','first');
	paginationDiv.children().children('.Previous').children('a').attr('aria-label','Previous');
	paginationDiv.children().children('.Next').children('a').attr('aria-label','Next');
	paginationDiv.children().children('.last').children('a').attr('aria-label','last');
}
function nwsDevlopMakePage(paginationDiv,totalPages, currentPageNo, pageCount){
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
	    	document.nwsDevlopInsertForm.pageIndex.value = page;
	    	nwsDevlopListSearch();
	    }
	});
	paginationDiv.children().children('.first').children('a').attr('aria-label','first');
	paginationDiv.children().children('.Previous').children('a').attr('aria-label','Previous');
	paginationDiv.children().children('.Next').children('a').attr('aria-label','Next');
	paginationDiv.children().children('.last').children('a').attr('aria-label','last');
}