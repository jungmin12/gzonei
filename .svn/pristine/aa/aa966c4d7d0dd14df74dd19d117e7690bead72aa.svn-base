$( document ).ready(function() {
	
	//등록페이지 이동
	$('#rewardInsertShow').on('click',function(e){
		sideShow('rewardAdminInsert');
		$("#rewardInsertDiv")[0].reset();
		makeCode();
	});
	
	//개발정보 리스트 모달
	$('#rewardDevlopListSearch').on('click',function(e){
		devlopListSearch(1);
	});
	
	//등록 (버튼)
	$('#rewardInfoInsertBtn').on('click',function(e){
		rewardInfoInsertBtn();
	});
	
	// 수정 (버튼)
	$('#rewardUpdateBtn').on('click',function(e){
		rewardUpdate();
	});
	
	$('#infoReward').on('click',function(e){
		if(checkAuth("ivt004001","infoInqireAt","")){
			infoReward();
		}
	});
	
	// 삭제 (버튼)
	$('#rewardDeleteBtn').on('click',function(e){
		rewardDelete();
	});
	
	$('#rewardAdmArea1,#rewardAdmArea2').on('change',function(e){
		var target = e.currentTarget; 
		var lastStrPlusOne = parseInt(target.id.charAt(target.id.length-1))+1;
		var selectTagId = target.parentElement.parentElement.querySelectorAll('#rewardAdmArea'+lastStrPlusOne)[0].id;
		// 지역1에 대한 지역2 리스트 생성
		var resultData = getCodeAjax('AREA',$(this).val());
		var sortcodeList = resultData.codeList.sort(function(a, b) {
    	    return a.lowestAreaNm < b.lowestAreaNm ? -1 : a.lowestAreaNm > b.lowestAreaNm ? 1 : 0;
    	});
    	optionSet(sortcodeList,selectTagId,'전체','없음');
		
	});
	
	//상세 및 수정페이지 이동
	$('#rewardAdminTbody').on('click','tr',function(e){
		if(e.currentTarget.id != ''){
			rewardInfoDetailShow(e.currentTarget.id);
			sideShow('rewardAdminDtl');
    	}
		
	});
	
	//금액 Input 한글 및 콤마 이벤트
	var input = $('.money');
	input.on( "keyup", function( event ) {
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

	} );
	devlopListSearch();
});

//좌표 탐색 및 Input 매칭
function findrewardloc(id){
	var upperMapCode = $('#upperMapCode'+id+' option:selected').text();
	var mapCode = $('#mapCode'+id+' option:selected').text();
	var rewardAddr = $('#addr'+id).val();
	if(upperMapCode == '선택'||upperMapCode == '-- 전체 --'||mapCode == '-- 전체 --'||mapCode == '-- 선택 --'){
		swal("정보가 없습니다.", "주소를 확인해 주세요!", "error");
		return false;
	}
	$('#loc'+id).val(upperMapCode+' '+mapCode+' '+rewardAddr);
	var addr = $('#loc'+id).val();
	var geocoder = new kakao.maps.services.Geocoder();
	if(addr != null){
		geocoder.addressSearch(addr, function(result, status) {
			if(status == "OK"){
				$('#lo'+id).removeAttr("style");
				$('#la'+id).removeAttr("style");
				var lat = result[0].y;
				var lon = result[0].x;
		        $('#lo'+id).val(lon);
		        $('#la'+id).val(lat);
		        swal("해당 주소 좌표가 입력되었습니다.", "하단의 위치확인버튼으로 지도에서 확인해 주세요!", "success");
			}else{
				swal("정보가 없습니다.", "주소를 확인해 주세요!", "error");
			}
		});
	}
}

// 포인트 만들기
function checkRewaedAddr(id){
	var lo = $('#lo'+id).val();
	var la =  $('#la'+id).val();
	removeInteraction('viewLayer', "edit");
	var center = ol.proj.transform([Number(lo),Number(la)],'EPSG:4326','EPSG:3857')
	
	var marker = new ol.Feature(new ol.geom.Point(center));
	
	marker.set("mapId",'gz_reward_precednt_info');
	var layerSource = new ol.source.Vector();
	layerSource.addFeature(marker);
	var vector = new ol.layer.Vector ({
	     source: layerSource, 
	     id: 'gz_reward_precednt_info',
	     name: 'gz_reward_precednt_info',
	     layerType : 'viewLayer'
	   });
	setFeatureStyle(marker, "deselect");
	map.addLayer(vector);
	map.getView().setCenter(ol.proj.fromLonLat([Number(lo),Number(la)]));
	
	$("#sideAdmin").toggleClass('moveTo'); // 닫기
	
}

function changeRewaedAddr(id){
	var lo = $('#lo'+id).val();
	var la =  $('#la'+id).val();
	removeInteraction('viewLayer', "edit");
	var center = ol.proj.transform([Number(lo),Number(la)],'EPSG:4326','EPSG:3857')
	
	var marker = new ol.Feature(new ol.geom.Point(center));
	marker.set("mapId",'gz_reward_precednt_info');
	var layerSource = new ol.source.Vector();
	layerSource.addFeature(marker);
	var vector = new ol.layer.Vector ({
	     source: layerSource, 
	     id: 'gz_reward_precednt_info',
	     name: 'gz_reward_precednt_info',
	     layerType : 'viewLayer'
	   });
	setFeatureStyle(marker, "select");
	map.addLayer(vector);
	map.getView().setCenter(ol.proj.fromLonLat([Number(lo),Number(la)]));
	$("#sideAdmin").toggleClass('moveTo'); // 닫기
	var select = new ol.interaction.Select({
        condition: ol.events.condition.never

    });
    select.getFeatures().push(marker);
    /*mode와 name에 관한 properties 입력*/
    select.setProperties({mode: "edit"});

    map.addInteraction(select);
	
	var translate = new ol.interaction.Translate({
	        features: select.getFeatures()
	    });

	    translate.setProperties({mode: "edit"});
	    map.addInteraction(translate);
	    translate.on('translateend', function (e) {
	        
	        var lattitude = e.features.array_[0].getGeometry().getCoordinates()[0];
	        var longitude = e.features.array_[0].getGeometry().getCoordinates()[1];
	        var latLong = transformLatLong(lattitude, longitude);
	        
	        var lo = $('#lo'+id).val(latLong[0]);
	    	var la =  $('#la'+id).val(latLong[1]);
	    	$('#lo'+id).css({
	    	    "color" :"blue",
	    		"font-weight": "bold"
	    	});
	    	$('#la'+id).css({
	    		"color" :"blue",
	    		"font-weight": "bold"
	    	});
	    });
}


function transformLatLong(lattitude, longitude)
{
    var coordinates = ol.proj.transform([lattitude, longitude], 'EPSG:3857', 'EPSG:4326');
    return coordinates;
}

//보상전례 리스트
function rewardAdmListSearch(){
	var paginationDiv = $('#rewardAdminListPagination');
	paginationInit(paginationDiv);
	// Page index
	
	var startDate = rewardAdmForm.startDate1.value;
	var endDate = rewardAdmForm.endDate1.value;
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
	var params = $('#rewardAdmForm').serializeArray();
	var dataHtml;
	var resData;
	$('.wrap-loading').removeClass('display-none');
	setTimeout(function() {
	$.ajax({
        type : 'POST',
        url : getContextPath() + "/reward/selectRewardAdmList.do",
        async: false,
        datatype : 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        data: params,
        success : function(data){ 
        	resData = JSON.parse(data);
        	dataHtml = "";
        	if(resData.resultList.length > 0){
        	// 지역 가져오기
        	var sortArea1List = resData.area1List.sort(function(a, b) {
        	    return a.lowestAreaNm < b.lowestAreaNm ? -1 : a.lowestAreaNm > b.lowestAreaNm ? 1 : 0;
        	});
        	devInfoOptionset(sortArea1List,'rewardAdmArea1','-- 전체 --','없음');
    			rewardListSave = resData.resultList;
    			areaList = resData.area1List;
    			rewardListSaveCnt = resData.resultListTotCnt;
	        	resData.resultList.forEach(function(data, index){
	        		if(index < 10){
	        		// 지역1,지역2 코드명
	            	var area1_val = codeSet(resData.area1List,data.upperMapCode);
	        		var area2_val = codeSet(getCodeAjax('AREA',data.upperMapCode).codeList,data.mapCode);
	        		dataHtml += "<tr id='"+data.rewardPrecedntSn+"'style='cursor: pointer;'>";
	        		dataHtml += "<td>"+data.dwkNm+"</td>";
	        		dataHtml += "<td>"+area1_val+" "+area2_val+"</td>";
	        		dataHtml += "<td>"+addComma(data.rewardCo)+"원</td>";
	        		dataHtml += "<td>"+data.codeIdNm+"</td>";
	        		dataHtml += "<td>"+addComma(data.pcpnttmIndvdlzPclnd)+"원</td>";
	        		dataHtml += "<td>"+tsToDt(data.pcpnttm)+"</td>";
	        		dataHtml += "<td>"+data.frstRegisterId+"</td>";
	        		var date = new Date(data.frstRegistPnttm);
	        		dataHtml += "<td>"+date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate()+"</td>";
	        		dataHtml += "</tr>";
	        		}
        		});
	        	makeRewardPageAdmin(paginationDiv,resData.resultListTotCnt,resData.paginationInfo.currentPageNo, 10);
        	}else{
        		swal("검색된 결과가 없습니다.", "검색된 결과가 없습니다.","warning");
        		dataHtml = "<tr><td style='text-align: center;'colspan='8'>없음</td></tr>";
        	}
        	$('#rewardInfoAdminTotalCount').html(addComma(resData.resultListTotCnt));
        	$('#rewardAdminTbody').html(dataHtml);
        },
        error:function(e){
        	console.log(e);
        	alert('보상전례_조회 실패' + e);
    	},complete:function(){
            $('.wrap-loading').addClass('display-none');
            flag = true;
         }
      });
  }, 0);

}

//리스트 페이징
function makeRewardPageAdmin(paginationDiv,totalPages, currentPageNo, PageNum){
	var totalPagesOption;
	var visivlePageNum = PageNum;
	var pageCal = totalPages/visivlePageNum;
	var pageCalRemain = totalPages%visivlePageNum;
	if(pageCalRemain == 0){
		totalPagesOption = pageCal;
	}else{
		totalPagesOption = pageCal + 1;
	}
	paginationDiv.twbsPagination({
		totalPages: totalPagesOption,	// 총 페이지 번호 수
		visiblePages: visivlePageNum,	// 하단에서 한번에 보여지는 페이지 번호 수
		startPage : currentPageNo, // 시작시 표시되는 현재 페이지
		initiateStartPageClick: false,	// 플러그인이 시작시 페이지 버튼 클릭 여부 (default :
										// true)
		first : "<<",	// 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
		prev : "<",	// 이전 페이지 버튼에 쓰여있는 텍스트
		next : ">",	// 다음 페이지 버튼에 쓰여있는 텍스트
		last : ">>",	// 페이지네이션 버튼중 마지막으로 가는 버튼에 쓰여있는 텍스트
		nextClass : "page-item next",	// 이전 페이지 CSS class
		prevClass : "page-item prev",	// 다음 페이지 CSS class
		lastClass : "page-item last",	// 마지막 페이지 CSS calss
		firstClass : "page-item first",	// 첫 페이지 CSS class
		pageClass : "page-item",	// 페이지 버튼의 CSS class
		activeClass : "active",	// 클릭된 페이지 버튼의 CSS class
		disabledClass : "disabled",	// 클릭 안된 페이지 버튼의 CSS class
		anchorClass : "page-link",	// 버튼 안의 앵커에 대한 CSS class
		
		onPageClick: function (event, page) {
			// 클릭 이벤트
			document.rewardtAdmForm.pageIndex.value = page;
			rewardAdmListSearch();
		}
	});
}

//개발정보 리스트(모달)
function devlopListSearch(val){
	var paginationDiv = $('#rewardDevlopPagination');
	paginationInit(paginationDiv);
	//Page index
	
	if(val){
		$('#pageIndexReward').val(1)
	}
	var params = $('#rewardDevlopInsertForm').serializeArray();
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
	        		dataHtml += '<tr onClick="selectDwk(\''+data.dwkNo+'\',\''+data.dwkNm+'\');"data-dismiss="modal" style="cursor: pointer;">';
        			dataHtml += "<td class='listtd'>" + data.dwkNo +"</td>";
        			dataHtml += "<td class='listtd'>" + data.dwkNm + "</td>";
        			dataHtml += "</tr>";
	        	});
    		}
        	$('#rewardDevlopTotalCount').html(addComma(resData.resultListTotCnt));
        	$('#rewardDevlopContents').html(dataHtml);
        	rewardDevlopMakePage(paginationDiv,resData.resultListTotCnt,resData.paginationInfo.currentPageNo, 5);
        },
        error:function(e){
        	console.log(e);
        	alert('devlopinfo_list_조회 실패' + e);
    	},complete:function(){
    		flag = true;
    	}
    });
};

//개발정보(모달) 페이징
function rewardDevlopMakePage(paginationDiv,totalPages, currentPageNo, pageCount){
	
	if(paginationDiv.data("twbs-pagination")){
		paginationDiv.twbsPagination('destroy');
		currentPageNo =1;
    }
	
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
	    	document.rewardDevlopInsertForm.pageIndex.value = page;
	    	devlopListSearch();
	    }
	});
	paginationDiv.children().children('.first').children('a').attr('aria-label','first');
	paginationDiv.children().children('.Previous').children('a').attr('aria-label','Previous');
	paginationDiv.children().children('.Next').children('a').attr('aria-label','Next');
	paginationDiv.children().children('.last').children('a').attr('aria-label','last');
}

//개발정보 이름 번호 매칭
function selectDwk(dwkNo,dwkNm){
	var displayChk = $('#rewardAdminDtl').css('display');
	if(displayChk === 'block'){
		$('#dwkNoRewardDtl').val(dwkNo);
		$('#dwkNmRewardDtl').val(dwkNm);
	}else{
		$('#rewardDwkNo').val(dwkNo);
		$('#rewardDwkNm').val(dwkNm);
	}
}

//코드 생성
function makeCode(){
	var area1List = getCodeAjax('AREA','0000000000');
	var prposList = getCodeAjax('CMMN','US00000000');
	
	area1List = area1List.codeList.sort(function(a, b) {
	    return a.lowestAreaNm < b.lowestAreaNm ? -1 : a.lowestAreaNm > b.lowestAreaNm ? 1 : 0;
	});
	
	prposList = prposList.codeList.sort(function(a, b) {
		return a.codeIdNm < b.codeIdNm ? -1 : a.codeIdNm > b.codeIdNm ? 1 : 0;
	});
	$('#prposTwoCode').css('display','none');
	$('#prposThreeCode').css('display','none');

	$("#mapCodeReward option").remove();

	$("#mapCodeReward").append("<option value=''>-- 전체 --</option>");
	devInfoOptionset(area1List,'upperMapCodeReward','-- 전체 --','없음');
	devInfoOptionset(prposList,'prposOneCode','-- 필수항목 --','없음');
	
}

//지역변경 이벤트(1,2)
function areaChange(e,id){
	var codeVal = e.value;
	var resultData = getCodeAjax('AREA',codeVal);
	if(resultData.length != 0){
		var sortCodeList = resultData.codeList.sort(function(a, b) {
			return a.lowestAreaNm < b.lowestAreaNm ? -1 : a.lowestAreaNm > b.lowestAreaNm ? 1 : 0;
		});
		var strHtml;
    	strHtml += "<option value=''>-- 전체 --</option>";
    	sortCodeList.forEach(function(data){
    		strHtml += "<option value='" + data.legaldongCode + "'>" + data.lowestAreaNm + "</option>";	
		});
    	$('#'+id).html(strHtml);
	}
}

//지목변경 이벤트(1,2,3)
function propChange(index,e){
	var codeVal,codeKey;
	var one = e.parentElement.children[0].id;
	var two = e.parentElement.children[1].id;
	var three = e.parentElement.children[2].id;
	if(index =='1'){
		$('#'+three).css('display','none');
		codeVal = document.getElementById(one).value;
		codeKey = two;
	}else{
		codeVal = document.getElementById(two).value;
		codeKey = three;
	}
	var prposList = getCodeAjax('CMMN',codeVal);
	prposList = prposList.codeList.sort(function(a, b) {
		return a.codeIdNm < b.codeIdNm ? -1 : a.codeIdNm > b.codeIdNm ? 1 : 0;
	});
	devInfoOptionset(prposList,codeKey,'-- 필수항목 --','없음');
	$('#'+codeKey).css('display','block');
	
}

//등록 펑션
function rewardInfoInsertBtn(){
	swal({
		  title: "보상전례 등록",
		  text: "보상전례를 등록 하시겠습니까?",
		  icon: "info",
		  buttons: ["취소", "이동"]
		})
		.then(function(result) {
		  if (result) {
			  var params = $('#rewardInsertDiv').serializeArray();
			  var resData;
			  $.ajax({
			        type : 'POST',
			        url : getContextPath() + "/reward/insertRewardDetail.do",
			        async: false,
			        datatype : 'json',
			        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
			        data: params,
			        success : function(data){
			        	resData = JSON.parse(data);
			        	if(resData.insertResult == 1){
			        		swal("성공!", "등록되었습니다.", "success");
			        		removeInteraction('viewLayer', "edit");
			        		rewardAdmListSearch();
			        	}else{
			        		removeInteraction('viewLayer', "edit");
			        		swal("실패!", "실패하였습니다.", "error");
			        	}
			        	$('#rewardAdminInsert').css('display','none');
			        	$('#rewardAdminList').css('display','block');
			        },
			        error:function(e){
			        	console.log(e);
			        	swal("실패!", "보상전례 등록을 실패하였습니다.", "error");
			    	}
				});
		  }
		});
}

//보상전례 상세보기
function rewardInfoDetailShow(rewardPrecedntSn){
	// Page index
	var params = {'rewardPrecedntSn' : rewardPrecedntSn};
	$.ajax({
        type : 'POST',
        url : getContextPath() + "/reward/selectRewardDetail.do",
        async: false,
        datatype : 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        data: params,
        success : function(data){
        	var resData = JSON.parse(data);
        	var list = Object.keys(resData.resultList);
        	list.forEach(function(data, index){
        		$('#'+data+'RewardDtl').removeAttr("style");
        		if(data=='useAt'||data=='arithAvrgAt'){
        			$('#'+data+resData.resultList[data]).prop('checked', true);
        		}else if(data=='pcpnttm'){
        			var dt = tsToDt(resData.resultList[data]);
        			$('#'+data+'RewardDtl').val(dt);
        		}else{
        			$('#'+data+'RewardDtl').val(resData.resultList[data]);
        		}
        	});
        	var sortArea1List = resData.area1List.sort(function(a, b) {
        	    return a.lowestAreaNm < b.lowestAreaNm ? -1 : a.lowestAreaNm > b.lowestAreaNm ? 1 : 0;
        	});
    		devInfoOptionset(sortArea1List,'upperMapCodeRewardDtl','선택',resData.resultList.upperMapCode);
    		devInfoOptionset(getCodeAjax('AREA',resData.resultList.upperMapCode).codeList,'mapCodeRewardDtl','선택',resData.resultList.mapCode);
    		devInfoOptionset(resData.prposList,'prposOneCodeRewardDtl','선택',resData.resultList.prposOneCode);
    		devInfoOptionset(getCodeAjax('CMMN',resData.resultList.prposOneCode).codeList,'prposTwoCodeRewardDtl','선택',resData.resultList.prposTwoCode);
    		devInfoOptionset(getCodeAjax('CMMN',resData.resultList.prposTwoCode).codeList,'prposThreeCodeRewardDtl','선택',resData.resultList.prposThreeCode);
    		
    		var upperMapCode = $('#upperMapCodeRewardDtl option:selected').text();
    		var mapCode = $('#mapCodeRewardDtl option:selected').text();
    		var rewardAddr = $('#addrRewardDtl').val();
    		$('#locRewardDtl').val(upperMapCode+' '+mapCode+' '+rewardAddr);
        	
        },
        error:function(e){
        	console.log(e);
        	swal("실패!", "보상전례 조회를 실패하였습니다.", "error");
    	}
	});
}

function rewardUpdate(){
	swal({
		  title: "보상전례 수정",
		  text: "보상전례를 수정 하시겠습니까?",
		  icon: "info",
		  buttons: ["취소", "이동"]
		})
		.then(function(result) {
		  if (result) {
			  var params = $('#rewardUpdateDiv').serializeArray();
			  var resData;
			  $.ajax({
			        type : 'POST',
			        url : getContextPath() + "/reward/updateRewardDetail.do",
			        async: false,
			        datatype : 'json',
			        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
			        data: params,
			        success : function(data){
			        	resData = JSON.parse(data);
			        	if(resData.updateResult == 1){
			        		swal("성공!", "수정되었습니다.", "success");
			        		removeInteraction('viewLayer', "edit");
			        		$("#rewardUpdateDiv")[0].reset();
			        		rewardAdmListSearch();
			        	}else{
			        		removeInteraction('viewLayer', "edit");
			        		swal("실패!", "실패하였습니다.", "error");
			        	}
			        	$('#rewardAdminDtl').css('display','none');
			        	$('#rewardAdminList').css('display','block');
			        },
			        error:function(e){
			        	console.log(e);
			        	swal("실패!", "보상전례 수정을 실패하였습니다.", "error");
			    	}
				});
		  }
		});
}

function rewardDelete(){
	swal({
		  title: "보상전례 삭제",
		  text: "보상전례를 삭제 하시겠습니까?",
		  icon: "info",
		  buttons: ["취소", "이동"]
		})
		.then(function(result) {
		  if (result) {
			  var params = $('#rewardUpdateDiv').serializeArray();
			  var resData;
			  $.ajax({
			        type : 'POST',
			        url : getContextPath() + "/reward/deleteRewardDetail.do",
			        async: false,
			        datatype : 'json',
			        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
			        data: params,
			        success : function(data){
			        	resData = JSON.parse(data);
			        	if(resData.deleteResult == 1){
			        		swal("성공!", "삭제되었습니다.", "success");
			        		$("#rewardUpdateDiv")[0].reset();
			        		rewardAdmListSearch();
			        	}else{
			        		swal("실패!", "실패하였습니다.", "error");
			        	}
			        	$('#rewardAdminDtl').css('display','none');
			        	$('#rewardAdminList').css('display','block');
			        },
			        error:function(e){
			        	console.log(e);
			        	swal("실패!", "보상전례 삭제를 실패하였습니다.", "error");
			    	}
				});
		  }
		});
}

function infoReward(){
	var devlopInfoSn = devInfoDtlForm.devlopInfoSn.value;
	var params = {devlopInfoSn : devlopInfoSn};
	$.ajax({
        type : 'POST',
        url : getContextPath() + "/reward/selectInfoReward.do",
        async: false,
        datatype : 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        data: params,
        success : function(data){
        	resData = JSON.parse(data);
        	var list = resData.resultList;
        	if(list.length >0){
        		var layerSource = new ol.source.Vector();
        		list.forEach(function(data, index){
        			var center = ol.proj.transform([Number(data.lo),Number(data.la)],'EPSG:4326','EPSG:3857')
        			var marker = new ol.Feature(new ol.geom.Point(center));
        			marker.set("mapId",'gz_reward_precednt_info');
        			for(key in data) {
        				marker.set(key,data[key]);
					}
        			layerSource.addFeature(marker);
        			marker.setId(data.rewardPrecedntSn);
        			setFeatureStyle(marker, "deselect");
        		});
        		var vector = new ol.layer.Vector ({
        			source: layerSource, 
        			id: 'gz_reward_precednt_info',
        			name: 'gz_reward_precednt_info',
        			layerType : 'viewLayer'
        		});
        		map.addLayer(vector);
        		vector.set('selectable',true);
        		$("#info").addClass('moveTo'); // 까꾸로 넣었어
    			overlay.setPosition(undefined);
    		  	closer.blur();
    		  	if(select != null){
    		  		setFeatureStyle(select.getFeatures().array_[0],'deselect');
    		  		select.getFeatures().clear();
    		  	}
        	}else{
        		swal("조회건수가 없습니다.", "주변 20km이내 보상전례가 없습니다.", "error");	
        	}
        },
        error:function(e){
        	console.log(e);
        	swal("실패!", "보상전례 조회에 실패했습니다.", "error");
    	}
	});
			
}
