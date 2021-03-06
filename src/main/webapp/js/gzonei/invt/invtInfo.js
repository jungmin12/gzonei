var flag = true;
var InvtoDev = 0;

$( document ).ready(function() {
// invListSearch();
	 setDateBox();
	 // 투자정보 데이터피커 오늘날짜 + 1달
	$("#startDate3").val(getFormatDate(new Date()));
	$("#endDate3").val(getFormatDate2(new Date()));
	
	//개발정보 미리보기
	$("#PreViewdevBtnD, #PreViewdevBtnI").click(function(e){
		var devInfoSn = "";
		switch(e.currentTarget.id){
		case "PreViewdevBtnI":
			devInfoSn = $('#invInsertDiv input[name="devlopInfoSn"]').val();
			break;
		case "PreViewdevBtnD":
			devInfoSn = $('#invDetailDiv input[name="devlopInfoSn"]').val();
			break;
		}
		if(devInfoSn !=null && devInfoSn!=""){
			devInfoDtl(devInfoSn,'in');
		}else{
			swal("개발정보를 먼저 선택하십시오", "[개발정보 찾기]버튼을 사용하여 개발정보를 추가", "info");
		}
	});
	
	// 검색창 경매, 공매 상세검색 - 사용자
	$("#aucShow").click(function(){
	    $("#auc").show();
	    $("#pauc").hide();
	    $("input:radio[name='paucgubun'][value='aucShow']").prop("checked", true);
	});
	$("#paucShow").click(function(){
	    $("#pauc").show();
	    $("#auc").hide();
	    $("input:radio[name='paucgubun'][value='paucShow']").prop("checked", true);
	});
	$("#bothShow").click(function(){
		$("#pauc").hide();
		$("#auc").hide();
		$("input:radio[name='paucgubun'][value='bothShow']").prop("checked", true);
	});
	
	// 사업지구 하위 Depth Level 기본값(안보이게)
	$('#invDs2, #invDs3, #invDs4').css('display','none');
	
	// 용도별, 진행내역 default 숨기기
	closeTabs();
	
	// 투발사업 정보 등록 보이기 (버튼)
	$('#invInsertShow').on('click',function(e){
		if(checkAuth("adm008001", "infoRegistAt","")){
			//개발사업번호 초기화
			document.invInsertDiv.devlopInfoSn.value = "";
			$("#invInsertDiv")[0].reset();
			map.removeLayer(map.getLayerByName('gz_invt_info'));
			if(select != null){
			select.getFeatures().clear();}
			sideShow('invtAdminInsert');
		}
		if(checkAuth('adm008002','infoDspyAt','')){
		    $("#invInsertDiv input:radio[name='cntntsOthbcAt'][value='Y']").prop("checked", true);
		}
	});
	
	// 지오코딩 (주소 -> x,y좌표 [lo,la])
	$('#findLoc').on('click',function(e){
		var addr = $('#loc').val();
		findAddr(addr);
	});
	// 지오코딩 (x,y좌표 [lo,la] -> 주소)
	$('#checkLoc').on('click',function(e){
		var lo = $('#lo').val();
		var la = $('#la').val();
		checkAddr(lo,la);
	});
	// 지오코딩 (주소 -> x,y좌표 [lo,la])
	$('#findLocDtl').on('click',function(e){
		var addr = $('#locDtl').val();
		$('#loDtl, #laDtl').removeAttr("style");
		findAddrDtl(addr);
		var lo = $('#loDtl').val();
		var la = $('#laDtl').val();
		makePt(lo, la);
	});
	// 지오코딩 (x,y좌표 [lo,la] -> 주소)
	$('#checkLocDtl').on('click',function(e){
		var lo = $('#loDtl').val();
		var la = $('#laDtl').val();
		checkAddr(lo,la);
	});
	
	// 투자정보 이동
	$('#moveInvtDtl').on('click',function(e){
		moveInvtAddr('Dtl');
	});
	
	// 개발사업 정보 등록 (버튼)
	$('#invtInfoInsertBtn').on('click',function(e){
		if(checkAuth("adm008002", "infoRegistAt","")){
			invtInfoInsert();
		}
	});
	
	// 투자 정보 검색조건
	$('#invtListSearch').on('click',function(e){
		 if(checkAuth("ivt001001", "infoInqireAt","")){ // 검색권환
			 if(checkAuth("ivt001002", "infoInqireAt","")){ // 목록권환
			 	var invArea1 = $('#invArea1 option:selected').val();
				var invArea2 = $('#invArea2 option:selected').val();
				if((invArea1 == null || invArea1 == ''||invArea2 == null || invArea2 == '') && $('#startDate3').val() == "" && $('#incdntManageNoDtl').val() == "" && $('#invDs1').val() == ""){
					swal("시군구까지 선택해주세요", "검색 범위가 넓습니다", "warning");
				}else{
					if(document.invtListForm.startDate3.value > document.invtListForm.endDate3.value){
						swal("날짜확인필요", "시작일이 종료일보다 클수 없습니다.","warning");
						return false;
					}
					invListSearch();
				}
			 }
		 }
		 InvtoDev = 0; // X버튼 초기화
	});
	// 투자 정보 검색조건 프리미엄 아님 사람들
	$('#invtSearchNo').on('click',function(e){
		swal("프리미엄 회원전용 서비스", "프리미엄 회원에게만 제공되는 서비스입니다.","warning");
	});
	
	// 투자 정보 마커 줌 이동 -- 사용자
	$('#invtSrchList').on('click','button.mapInvLink',function(e){
		// 아이디를 parameter로
		$("#sideAdmin").removeClass("moveTo");
		zoomLayer(e.currentTarget.id,"gz_invt_info");
	});
	
	// 투자 정보리스트 닫기(버튼) - 사용자
	$('#invtSideOff').on('click', function(e){
		map.removeLayer(map.getLayerByName('gz_invt_info'));
		if(InvtoDev ==2){
			sideShow('invtInfoAdminDtl');
			InvtoDev = 0;
		}
		else{
		if(InvtoDev ==1){
			map.removeLayer(map.getLayerByName('gz_devlop_info'));
			InvtoDev = 0;
		}
		if(select != null){
		select.getFeatures().clear();}
		$("#sideAdmin").removeClass("moveTo");
		$('#sideAdminTg').css('display','none');
		$('#invtSrchList').css('display','none');
		}
	});
	
	// 투자 정보 상세보기 (테이블 목록 클릭) -- 관리자
	$('#invtAdminTbody').on('click','tr',function(e){
		if(checkAuth("adm008002", "infoInqireAt","")){
			//devlopInfoSn 초기화
			document.invDetailDiv.devlopInfoSn.value = "";
			invtInfoDetailShow(e.currentTarget.id);
		}
	});
	
	// 투자 정보 상세보기 닫기(버튼)
	$('#invtInfoCancleBtn').on('click', function(e){
		$('#invtInfoDetailModal').css('display','none');
	});
	// 투자 정보 수정 (버튼)
	$('#invtnfoAdDtlUpdateBtn').on('click',function(e){
		if(checkAuth("adm008002", "infoUpdtAt","")){
			invtInfoUpdate();
		}
	});
	// 투자 정보 삭제 (버튼)
	$('#invtInfoAdDtlDelBtn').on('click',function(e){
		if(checkAuth("adm008002", "infoDelAt","")){
			invtInfoDelete();
		}
	});
	// 투자 정보 취소 (버튼)
	$('#invtInfoAdDtlCanBtn').on('click',function(e){
		sideShow('invtAdminList');
		closeTabs();
	});
	
	// 경매 등록폼 보이기 (버튼)
	$('#showProInsrtBtn').on('click',function(e){
		$('#proAucDt').css('display','none');
		$('#proPaucDt').css('display','none');
		if(document.invDetailDiv.aucPblsalSeCodeDt.value == "CM00110001"){
			$('#proPaucInsert').css('display','none');
			$('#proAucInsert').css('display','block');
			scrollAnimate('proAucInsert',700);
		}
		else{
		$('#proAucInsert').css('display','none');
		$('#proPaucInsert').css('display','block');
		scrollAnimate('proPaucInsert',700);
		}
		// 클릭시 스크롤 이동
		
	});
	
	// 진행내역 정보 등록 (버튼)
	$('#preViewInv').on('click',function(e){
		InvtoDev = 2;
		invListSearch();
		sideShow('invtSrchList');
	});
	// 진행내역 정보 등록 (버튼)
	$('#proAucInsertBtn, #proPaucInsertBtn').on('click',function(e){
		ProInsert();
	});
	// 진행내역 정보 수정 (버튼)
	$('#proAucUpdateBtn, #proPaucUpdateBtn').on('click',function(e){
		ProUpdate();
	});
	// 진행내역 정보 삭제 (버튼)
	$('#proAucDeleteBtn, #proPaucDeleteBtn').on('click',function(e){ 
		ProDelete();
	});
	// 용도별 등록폼/상세보기 숨기기 (버튼)
	$('#proPaucCancleBtn, #proAucCancleBtn,#proDetailPCancleBtn, #proDetailCancleBtn').on('click',function(e){
		closeTabs();
	});
	// 지역1선택시 지역2가 select 생성 이벤트
	$('.invArea1, .invArea2').on('change',function(e){
		var target = e.currentTarget; 
		var lastStrPlusOne = parseInt(target.id.charAt(target.id.length-1))+1;
		var selectTagId = target.parentElement.parentElement.querySelectorAll('.invArea'+lastStrPlusOne)[0].id;
		// 지역1에 대한 지역2 리스트 생성
		var resultData = getCodeAjax('AREA',$(this).val());
		var sortcodeList = resultData.codeList.sort(function(a, b) {
    	    return a.lowestAreaNm < b.lowestAreaNm ? -1 : a.lowestAreaNm > b.lowestAreaNm ? 1 : 0;
    	});
    	optionSet(sortcodeList,selectTagId,'전체','없음');
	});
	
	$('#incdntManageNoThing').on('focusout',function(e){
		if($('#incdntManageNoThing').val().length >10 && !isNaN($('#incdntManageNoThing').val()) ){
			var temp ="";
			temp += $('#incdntManageNoThing').val().substring(0,4);
			temp += "-";
			temp += $('#incdntManageNoThing').val().substring(4,9);
			temp += "-";
			temp += $('#incdntManageNoThing').val().substring(9);
			
			$('#incdntManageNoThing').val(temp);
		}
		
	});
	$('#incdntManageNoDtl').on('focusout',function(e){
		if($('#incdntManageNoDtl').val().length >7 && !isNaN($('#incdntManageNoDtl').val()) ){
			var temp ="";
			temp += $('#incdntManageNoDtl').val().substring(0,4);
			temp += "-";
			temp += $('#incdntManageNoDtl').val().substring(4);
			
			$('#incdntManageNoDtl').val(temp);
		}
	});
	
	$('.cntntsOthbcAtBtn').on('click',function(e){
		//권한 -- 개발정보 전시 (수정)
		if(checkAuth('adm008002','infoDspyAt','')){}
		else{ return false;}
		});
	
	function closeTabs(){
		$('#proAucDt').css('display','none');
		$('#proPaucDt').css('display','none');
		$('#proPaucInsert').css('display','none');
		$('#proAucInsert').css('display','none');
	}
	
	// 관리자
	// 투자정보 등록 display
	$('.aucPblsalSeCode').on('change',function(e){
		var code = e.currentTarget.value;
		if(code =='CM00110002'){ // 공매
			$('#paucAdmDiv1').css('display','block');
			$('#paucAdmDiv2').css('display','block');
			$('#paucAdmDiv3').css('display','block');
			$('#paucAdmDiv4').css('display','block');
			$('#aucAdmDiv1').css('display','none');
			$('#aucAdmDiv2').css('display','none');
		}else if(code =='CM00110001'){ // 경매
			$('#paucAdmDiv1').css('display','none');
			$('#paucAdmDiv2').css('display','none');
			$('#paucAdmDiv3').css('display','none');
			$('#paucAdmDiv4').css('display','none');
			$('#aucAdmDiv1').css('display','block');
			$('#aucAdmDiv2').css('display','block');
		}
	});
	// 관리자 데이트피커
	$.datetimepicker.setLocale('ko');
	$("#bidDeAD, #bidDeAI,  #bidBgndePD, #bidEnddePD, #opengDtPD, #bidBgndePI, #bidEnddePI, #opengDtPI").datetimepicker({
		timepicker : false,
		format : 'Y-m-d',
		scrollMonth : false,
		scrollInput : false,
		validateOnBlur: false
	}).on('keydown', function(event){
		onlyNum(this,event);
		});
	
	//투자정보 자동컴마
	 $("#scsbidAmountAI, #bidAmountAI, #apasmtAmount, #apasmtAmountAD, #lwetAmountPD,#scsbidAmountAD, #bidAmountAD, #scsbidAmountPD").on('keyup',function(event){
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
	 	})
	
	
	// 사업지구 select 생성 이벤트
	$('.prposCode1, .prposCode2, .prposCodeDtl1, .prposCodeDtl2').on('change',function(e){
		var target = e.currentTarget; 
		var idOnly = target.id.substring(0,target.id.length-1);
		var lastInt = parseInt(target.id.charAt(target.id.length-1))+1;
		var nextInt = lastInt + 1;
		var selectTagId = target.parentElement.parentElement.querySelectorAll('.'+idOnly+lastInt)[0].id;
		// 사업지구에 대한 리스트 생성
		var resultData;
		if(idOnly == "adDtlDs" || idOnly == "ds"|| idOnly == "adDs" || idOnly == "invDs"){
			resultData = getCodeAjax('DSTRC_UPCD',$(this).val());
		}else{
			resultData = getCodeAjax('CMMN',$(this).val());
		}
		if(resultData.codeList.length == 0 || target.options[target.selectedIndex].innerText == '전체'){
			$('#'+selectTagId).val('');
			$('#'+selectTagId).css('display','none');
			if(lastInt==2){
				$('#'+selectTagId.slice(0,-1)+3).val('');
				$('#'+selectTagId.slice(0,-1)+3).css('display','none');
			}
		}else{
			if($(this).val()!=""){
				devInfoOptionset(resultData.codeList,selectTagId,'전체','없음');
				$('#'+selectTagId).css('display','block');
				if(lastInt==2){
					$('#'+selectTagId.slice(0,-1)+3).val('');
					$('#'+selectTagId.slice(0,-1)+3).css('display','none');
				}
			}
		}
	});
	
});

// 투자 정보 등록 체크
function invtInfoInsertCk(params){
	var result ='Y';
	// 영어 체크
	var eChck = /^[a-zA-Z]+$/;
	if(params[7].value ==''){result ='개발사업 정보를 입력바랍니다.'; }
	else if(params[2].value ==''){result ='주소를 시군구까지 입력바랍니다.'; }
	else if(params[3].value =='' || eChck.test(params[3].value.trim()) ){result ='상세주소를 올바르게 입력바랍니다.'; }
	else if(params[6].value ==''){result ='대표 위치 입력 후, "위치입력"을 통해 경위도를 입력바랍니다.'; }
	else if(params[9].value ==''){result ='편입 여부를 입력바랍니다.'; }
	else if(params[10].value ==''){result ='편입 면적을 입력바랍니다.'; }
	// 경매 법원 확인
	if(	params[0].value == "CM00110001"){
		if(params[11].value ==''){result ="법원을 입력바랍니다."; }
		if(params[13].value ==''){result ='사건번호를 입력바랍니다.'; }
	}
	if(	params[0].value == "CM00110002"){
		if(params[15].value ==''){result ='관리번호를 입력바랍니다.'; }
	}
//	if(	params.find(element => element.name =='aucPblsalSeCode').value =='CM00110001'){
//		if(params.find(element => element.name =='courtNm').value ==''){result ='법원을 입력바랍니다.'; }}
//	
//	if(	params.find(element => element.name =='aucPblsalSeCode').value ==''){result ='경/공매 구분 값을 입력바랍니다.'; }
//	else if(params.find(element => element.name =='dwknm').value ==''){result ='개발사업 정보를 입력바랍니다.'; }
//	else if(params.find(element => element.name =='incrprAt').value ==''){result ='편입 여부를 입력바랍니다.'; }
//	else if(params.find(element => element.name =='incrprAr').value ==''){result ='편입 면적을 입력바랍니다.'; }
//	else if(params.find(element => element.name =='incdntManageNo').value ==''){result ='사건번호를 입력바랍니다.'; }
//	else if(params.find(element => element.name =='invAdmAreaAdd2').value ==''){result ='주소를 시군구까지 입력바랍니다.'; }
//	else if(params.find(element => element.name =='lo').value ==''){result ='대표 위치 입력 후, "위치입력"을 통해 경위도를 입력바랍니다.'; }
	return result;
}
	
// 투자 정보 중복 확인
function overlapCk(index){
	var result ='Y';
	var params = $('#invInsertDiv').serializeArray();
	$.ajax({
        type : 'POST',
        url : getContextPath() + "/invt/selectInvtOverlap.do",
        async: false,
        datatype : 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        data: params,
        success : function(data){
        	resData = JSON.parse(data);
        	if(resData.checkResult >= 1){
        		result ='중복된 투자정보가 존재합니다.';
        	}
        },
        error:function(e){
        	console.log(e);
        	alert('투자 정보 중복 체크 실패' + e);
    	}
	});
	return result;
}
// 투자 정보 등록
	function invtInfoInsert(val){
	var Olresult = overlapCk();
	document.invInsertDiv.endDate.value = document.invInsertDiv.endDate.value.replace(/-/gi,''); 
	document.invInsertDiv.startDate.value = document.invInsertDiv.startDate.value.replace(/-/gi,''); 
	document.invInsertDiv.apasmtAmount.value = document.invInsertDiv.apasmtAmount.value.replace(/,/gi,''); 
	var params = $('#invInsertDiv').serializeArray();
	var dataHtml;
	var resData;
	var Ckresult =invtInfoInsertCk(params);
	if(Ckresult=='Y' && Olresult=='Y'){
	if(params[0].value == 'CM00110001'){ // 경매
		var yn = confirm("경매 정보를 등록하시겠습니까?");
	}else if(params[0].value == 'CM00110002'){ // 공매
		var yn = confirm("공매 정보를 등록하시겠습니까?");
	}
	if(yn){
		$.ajax({
	        type : 'POST',
	        url : getContextPath() + "/invt/insertInvtDetail.do",
	        async: false,
	        datatype : 'json',
	        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
	        data: params,
	        success : function(data){
	        	resData = JSON.parse(data);
	        	if(resData.insertResult == 1){
	        		swal("등록되었습니다.", "투자정보가 등록되었습니다!", "success");
//	        		sideShow('invtAdminList');
	        		invAdmListSearch();
	        		invtInfoDetailShow(resData.searchVO.invtInfoSn);
//	        		invtInfoDetailShow(resData.insertInvtSn.invtInfoSn);
	        	}else{
	        		swal('등록실패');
	        	}
	        	$('#invtInfoInsertModal').css('display','none');
	        	
	        },
	        error:function(e){
	        	console.log(e);
	        	alert('투자 정보 등록 실패' + e);
	    	}
		});
	}
	}
	else{
		if(Olresult=='Y'){
		swal(Ckresult, "입력값을 확인바랍니다.","warning");}
		else swal(Olresult, "입력값을 확인바랍니다.","warning");
	}
}


// 투자 정보 목록 검색 - 관리자
var invtListSave;
var invtListSaveCnt;
var AdmareaList;
function invAdmListSearch(val){
	var paginationDiv = $('#invAdminListPagination');
	if(val){ // 검색조건으로 검색시 첫번째 페이지로 이동
		$('#pageIndexInvAdm').val(1)
	}
	// Page index
	var params = $('#invtAdmForm').serializeArray();
	var dataHtml;
	var resData; 
	
	$('.wrap-loading').removeClass('display-none');
	setTimeout(function() {
	$.ajax({
        type : 'POST',
        url : getContextPath() + "/invt/selectInvtAdmList.do",
        async: false,
        datatype : 'json',
        cache:false,
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
        	var courtList = resData.courtList.sort(function(a, b) {
    			return a.sortOrdr < b.sortOrdr ? -1 : a.sortOrdr > b.sortOrdr ? 1 : 0;
    		});
        	var prposList = resData.prposList.sort(function(a, b) {
        		return a.codeIdNm < b.codeIdNm ? -1 : a.codeIdNm > b.codeIdNm ? 1 : 0;
        	});
        	devInfoOptionset(courtList,'courtList','전체',resData.searchVO.courtList);
        	devInfoOptionset(courtList,'courtNm','전체',resData.searchVO.courtList);
        	devInfoOptionset(prposList,'prposCode1','전체','없음');
        	// 마커 뿌리기
        	viewLayer(resData.resultList,"gz_invt_info");
        
        	// 투자 정보 뿌리기
    			invtListSave = resData.resultList;
    			areaList = resData.area1List;
    			invtListSaveCnt = resData.resultListTotCnt;
	        	resData.resultList.forEach(function(data, index){
	        		// 지역1,지역2 코드명
	            	var area1_val = codeSet(resData.area1List,data.upperMapCode);
	        		var area2_val = codeSet(getCodeAjax('AREA',data.upperMapCode).codeList,data.mapCode);
	        		
	        		dataHtml += "<tr id='"+data.invtInfoSn+"' style='cursor: pointer;'>";
	        		if(data.aucYN == "경매"){  // 경매
	        			if(data.thingNo == "" || data.thingNo == null || data.thingNo =="99" ){ // 물건번호가 없거나 99일 경우 ,
	        				dataHtml += "<td class='atchFileId'>"+data.courtNm + data.smCode+"계  "+ data.incdntManageNo+"</td>";
	        			}else{
	        				dataHtml += "<td class='atchFileId'>"+data.courtNm + data.smCode+"계  "+data.incdntManageNo +"["+data.thingNo+"]"+"</td>"; 
	        				}
	        		}else{	// 공매
	        			dataHtml += "<td class='atchFileId'>"+"공매  "+ data.incdntManageNo+"</td>";
	        		}
	        		dataHtml += "<td class='subject'>"+area1_val+" "+area2_val+"</td>";
	        		dataHtml += "<td class='writer'>"+addComma(data.apasmtAmount)+"원</td>";
	        		if(data.cntntsOthbcAt=="Y"){
	        		dataHtml += "<td class='writer'>"+"공개"+"</td>";}
	        		else{
	        		dataHtml += "<td class='writer'>"+"비공개"+"</td>";}	
	        		dataHtml += "<td class='writer'>"+data.frstRegisterId+"</td>";
	        		dataHtml += "<td class='regDate'>"+tsToDt(data.lastUpdtPnttm)+"</td>";
	        		dataHtml += "</tr>";
	        		});
	        	// 페이지 네이션
	        	paginationInit(paginationDiv);
	        	makePageAdmin(paginationDiv,resData.resultListTotCnt,resData.paginationInfo.currentPageNo, 10);
        	}else{
        		// 페이지 네이션
	        	paginationInit(paginationDiv);
	        	makePageAdmin(paginationDiv,1,1, 10);
	        	map.removeLayer(map.getLayerByName('gz_invt_info'));
	        	if(select != null){
	        		select.getFeatures().clear();}
        		swal("검색된 결과가 없습니다.", "검색된 결과가 없습니다.","warning");
        		dataHtml = "<tr><td colspan='6' onclick='event.cancelBubble=true'>검색된 데이터가 없습니다</td></tr>";
        	}
        	$('#invInfoAdminTotalCount').html(addComma(resData.resultListTotCnt));
// $('#invtTbodyContents').html(dataHtml);
        	$('#invtAdminTbody').html(dataHtml);
        },
        error:function(e){
        	console.log(e);
        	alert('투자정보_조회 실패' + e);
    	},complete:function(){
            $('.wrap-loading').addClass('display-none');
            flag = true;
         }
      });
  }, 0);

}
// 투자 정보 목록 검색 - 이용자
var invtAdmListSave;
var invtAdmListSaveCnt;
var areaList;
var courtList;
var rewardList;
var prposList;
var stusList;

function invListSearch(dwk_no,topSearch,sampleAt){
	var paginationDiv = $('#invInfoListPagination');
	paginationInit(paginationDiv);
	
	// Page index
//	document.invtListForm.endDate3.value = document.invtListForm.endDate3.value.replace(/-/gi,''); 
//	document.invtListForm.startDate3.value = document.invtListForm.startDate3.value.replace(/-/gi,''); 
	var params = $('#invtListForm').serializeArray();
	params[7].value = $('#invArea3 option:selected').text(); // 동 디코딩
	// 개발정보에서 넘어오는 투자정보
	if(dwk_no){
		params.length = 0;
		params.push({
	        name: 'dwkNo', 
	        value:  dwk_no
	    });
	}
	// 상단 통합검색에서 넘어오는 투자정보
	if(topSearch){
		params.length = 0;
		params.push({
			name: 'topSearch', 
			value:  topSearch
		});
		// 상단 검색시 매각인것은 '투자물건'만 보이도록 ( 제거시 , 낙찰전례도 검색 됨)
		params.push({
			name: 'condiAt', 
			value:  "Y"
		});
//		params.push({
//			name: 'beginPnttm', 
//			value:  $('#startDate3')[0].value
//		});
//		params.push({
//			name: 'endPnttm', 
//			value:  $('#endDate3')[0].value
//		});
	}
	// 투자정보 관리자 미리보기 
	if(InvtoDev == 2){
		params.length = 0;
		params.push({
			name: 'invtInfoSn', 
			value: document.invDetailDiv.invtInfoSn.value
		});
	}
//	var bsnsMthd = new Array();
//	for(var i = 0; i<params.length; i++){
//		if(params[i].name=='bsnsMthdCode'){
//			bsnsMthd.push(params[i].value);
//			params.splice(i, 1);  i--;
//		}}
//	var bsnsMthdCode= {'name': 'bsnsMthdCode', 'value':bsnsMthd}
//	params.push(bsnsMthdCode);
	var dataHtml;
	var resData; 
	$('.wrap-loading').removeClass('display-none');
	setTimeout(function() {
		$.ajax({
			type : 'POST',
			url : getContextPath() + "/invt/selectInvtList.do",
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
					var dsCodeList = resData.dsCodeList.sort(function(a, b) {
						return a.codeIdNm < b.codeIdNm ? -1 : a.codeIdNm > b.codeIdNm ? 1 : 0;
					});
					
					// 마커 뿌리기
					if(checkAuthValue('ivt002002','infoInqireAt') == 'Y' || sampleAt != null){ // 포인트권환
						viewLayer(resData.resultList,"gz_invt_info"); 
					}
					
					// 투자 정보 뿌리기
					invtListSave = resData.resultList;
					areaList = resData.area1List;
					courtList = resData.courtList;
					rewardList = resData.rewardList;
					prposList = resData.prposList;
					stusList = resData.stusList;
					invtListSaveCnt = resData.resultListTotCnt;
					resData.resultList.forEach(function(data, index){
						if(index < 10){
							if(sampleAt){
								invtListSave[index].sampleAt = "Y"
							}
							var aucYN= "";
							if(data.aucPblsalSeCode == 'CM00110001'){aucYN="경매"}
							else if(data.aucPblsalSeCode == 'CM00110002'){aucYN="공매"}
							// 지역1,지역2 코드명
							var courtNm = codeInvSet(courtList,data.courtCode);
							var rewardNm = codeInvSet(rewardList,data.rewardAt);
							var prposNm = codeInvSet(prposList,data.prposThreeCode);
							var stusNm = codeInvSet(stusList,data.progrsResultCode);
							var area1_val = codeSet(areaList,data.upperMapCode);
							var area2_val = codeSet(getCodeAjax('AREA',data.upperMapCode).codeList,data.mapCode);
							// [경매] 사건번호가 비어있으면 사건번호의 default 값은 1
							if(data.thingNo == "" || data.thingNo == null){
								data.thingNo = 1
							}
							// 무료 전용 ( 프리미엄 이코노미 전용)
// if((data.free =="N" && 'CM00200010'!= $('#gradCode').val() && 'CM00200011'!=
// $('#gradCode').val()) &&'CM00210003'!=$('#indvdlMberCode').val()){
// dataHtml += '<div class="item" style="height:200px"><li
// class="primiumInv">프리미엄 전용 매물<img
// src="'+getContextPath()+'/images/develop/premium.png"></li></div>';
// }
// else
							// 프리미엄 스페셜 ( 프리미엄 이코노미 전용)
// if((data.special =="Y" && 'CM00200010'== $('#gradCode').val()) ||
// 'CM00210003'!=$('#indvdlMberCode').val()){
// if(data.special =="Y" && 'CM00200010'== $('#gradCode').val() &&
// 'CM00210003'!=$('#indvdlMberCode').val()){
							if(data.special =="Y" && checkAuthValue('ivt003004','infoInqireAt') == 'N' && sampleAt == null){
								dataHtml += '<div class="item" style="height:200px"><li class="primiumInv">본 물건은 감정가 1억원 이상의 물건으로<br>프리미엄(스페셜)등급 회원에게만 서비스 제공됩니다.<img src="'+getContextPath()+'/images/develop/premium.png"></li></div>';
//								
							}
							else{
								dataHtml += "<div class='item'>";
								dataHtml += "<a href='#' class='link' style='overflow-y: scroll; cursor: default;'>";
//								dataHtml += "<span class='td__category'>"+aucYN+"</span>";
								if(data.rewardAt =="CM00160001" ){ dataHtml += "<i class='txt_blt03 td__category stateInv01'>"} // 보상중
								else if(data.rewardAt =="CM00160002" ){ dataHtml += "<i class='txt_blt03 td__category stateInv02'>"} // 보상예정
								else if(data.rewardAt =="CM00160003" ){dataHtml += "<i class='txt_blt03 td__category stateInv03'>"} // 환지
								else if(data.rewardAt =="CM00160004" ){ dataHtml += "<i class='txt_blt03 td__category stateInv04'>"} // 기타
								else if(data.rewardAt =="CM00160005" ){ dataHtml += "<i class='txt_blt03 td__category stateInv05'>"} // 보상 + 환지
								dataHtml += rewardNm+"</i>";
								dataHtml += "<div class='description'>";
								dataHtml += "<strong class='title'>";
								if(aucYN == "경매"){  // 경매
									if(data.thingNo == "" || data.thingNo == null || data.thingNo =="99" ){ // 물건번호가  없거나 99일 경우 ,
										dataHtml += "<em class='invMN' onclick='detailSrch(\""+courtNm+"\",\""+data.incdntManageNo.split('-')[0]+'0130'+fillZero(6,data.incdntManageNo.split('-')[1])+"\",\"1\")'>사건번호 : "+courtNm + data.smCode+"계  "+ data.incdntManageNo +"</em>";
										dataHtml += "<button type='button' class='courtLink' onclick='detailSrch(\""+courtNm+"\",\""+data.incdntManageNo.split('-')[0]+'0130'+fillZero(6,data.incdntManageNo.split('-')[1])+"\",\"1\")'></button>";}
									else{ dataHtml += "<em class='invMN' onclick='detailSrch(\""+courtNm+"\",\""+data.incdntManageNo.split('-')[0]+'0130'+fillZero(6,data.incdntManageNo.split('-')[1])+"\",\""+data.thingNo+"\")'>사건번호 : "+courtNm + data.smCode+"계  "+ data.incdntManageNo +"["+data.thingNo+"]"+"</em>";
										dataHtml += "<button type='button' class='courtLink' onclick='detailSrch(\""+courtNm+"\",\""+data.incdntManageNo.split('-')[0]+'0130'+fillZero(6,data.incdntManageNo.split('-')[1])+"\",\""+data.thingNo+"\")'></button>";}
									
								}else{	// 공매
									dataHtml += "<em class='invMN' onclick='popOnbidMgrNoSearch_2021(\""+data.incdntManageNo+"\")'>관리번호 : "+data.incdntManageNo +"</em>";
									dataHtml += "<button type='button' class='onbidLink' onclick='popOnbidMgrNoSearch_2021(\""+data.incdntManageNo+"\")'></button>";
								}
								
								dataHtml += "<br></strong>";
								dataHtml += "<button type='button' class='mapInvLink' id='"+data.invtInfoSn+"'></button>";
								dataHtml += "<button type='button' class='devInvLink' onclick='devInfoDtl(\""+data.devlopInfoSn+"\", \"from\");'></button>";
//								dataHtml += rewardNm+"</i><em class='invDwknm invEN' onclick='devInfoDtl(\""+data.devlopInfoSn+"\", \"from\");' style='margin-left: 8px'>"+data.dwkNm+"</em></strong>";
								dataHtml += "<ul class='invCONTS'>";
//								dataHtml += "<li class='mid_td' style='width: 95%;'>소재지 :"+area1_val+" "+area2_val+" "+data.addr+"</li>";
								dataHtml += "<li class='mid_td'>소재지 :"+area1_val+" "+area2_val+" "+data.addr+"</li>";
								dataHtml += "<li class='mid_td'>용도 :"+prposNm+"</li>";
								dataHtml += "<li class='mid_td'>편입면적 :"+data.incrprAr+"</li>";
								dataHtml += "<li class='mid_td invEN'>개발사업명 :"+data.dwkNm+"</li>";
								dataHtml += "</ul>";
								dataHtml += "<ul class='invCONTS'>";
								dataHtml += "<li class='mid_td'>감정가 :"+addComma(data.apasmtAmount)+"원</li>";
								if(aucYN == "경매"){ // 경매, 최저가(lwetAmount) , 입찰일
								if(data.bidAmount == undefined || data.bidAmount=='' || data.bidAmount == null)
									{data.bidAmount = data.apasmtAmount}
								if(data.bidAmount <=0){dataHtml += "<li class='mid_td'>최저가 :"+addComma(data.bidAmount)+"원 </li>";}
								else{dataHtml += "<li class='mid_td'>최저가 :"+addComma(data.bidAmount)+"원 ( <span style='color: blue; font-weight:bold;'>"+( data.bidAmount  / data.apasmtAmount.replace(/,/g, "")  * 100).toFixed(2)+"%</span>)</li>";}
								dataHtml += "<li class='mid_td'>입찰일 :"+tsToDt(data.bidDe)+"</li>";
								}
								else{ // 공매, 최저가(lwetAmount) , 입찰기간
								if(data.lwetAmount == undefined || data.lwetAmount=='' || data.lwetAmount == null)
									{data.lwetAmount = data.apasmtAmount}
								if(data.lwetAmount <=0){dataHtml += "<li class='mid_td'>최저가 :"+addComma(data.lwetAmount)+"원 </li>";}
								else{dataHtml += "<li class='mid_td'>최저가 :"+addComma(data.lwetAmount)+"원 ( <span style='color: blue; font-weight:bold;'>"+( data.lwetAmount  / data.apasmtAmount.replace(/,/g, "")  * 100).toFixed(2)+"%</span>)</li>";}
								dataHtml += "<li class='mid_td'>입찰기간 : "+tsToDt(data.bidBgnde) +" ~ "+tsToDt(data.bidEndde)+" </li>";
								}
								dataHtml += "<li class='mid_td' >상태 :"+stusNm;
								if(data.progrsResultCode == 'CM00130003'){
									if(data.scsbidAmount>0){dataHtml += " ("+addComma(data.scsbidAmount)+"원 / <span style='color: red; font-weight:bold;'>"+(data.scsbidAmount/data.apasmtAmount*100).toFixed(2)+"%</span>)";}	
									else dataHtml += " ("+addComma(data.scsbidAmount)+" / "+"-"+"%)";
								}
								dataHtml += "</li></ul>";
								if(data.rewardAt == 'CM00160005' ){
									data.rmOne += "<br/>◈해당 토지가 환지 대상인지 보상대상인지 별도 확인 바랍니다. "
								}
								dataHtml += "<div class='td__knowhow' escapeXml='false'><strong>특급노하우 </strong>"+data.rmOne.replace(/\\r\\n\\r\\n/gi,"\\r\\n").replace(/\\r\\n/gi,"<br/>").replace(/\r\n/gi,"<br/>")+"</div></div>";
// dataHtml += "</ul><div class='td__knowhow'><strong>특급노하우
// </strong>"+data.rmOne+"</div></div>";
// dataHtml += "</ul><div class='td__knowhow'><strong>특급노하우
// </strong><pre>"+data.rmOne+"</pre></div></div>";
								dataHtml += "</a></div>";
								
// dataHtml += "</ul><ul class='fl_r_yjs'>";
// dataHtml += "<li class='full_td'><div class='td__knowhow'><strong>특급노하우
// </strong><br>"+data.rmOne+"</div></li>";
// dataHtml += "</ul></div>";
// dataHtml += "</a></div></div>";
								
// dataHtml += "<span class='td__knowhow' data-toggle='tooltip'
// data-container='body' data-html='true' title='<h5>특급노하우</h5><ul><li>- 2020년
// 6월 30일 실효된 구간 內 해당 물건임.</li>'";
// dataHtml += "<li>- 전체면적 1,785㎡ 中 입찰지분 1,723.1㎡</li></ul>'>특급노하우</span>";
							}
						}
					});
					makePage(paginationDiv,resData.resultListTotCnt,1, 10);
					sideShow('invtSrchList');
// makePage(paginationDiv,resData.resultListTotCnt,resData.paginationInfo.currentPageNo,
// 10);
				}else{
					map.removeLayer(map.getLayerByName('gz_invt_info'));
					if(select != null){
						select.getFeatures().clear();}
					swal("검색된 결과가 없습니다.", "검색된 결과가 없습니다.","warning");
					dataHtml = "<div style='text-align: center;' class='item'>검색된 결과가 없습니다.</div>";
				}
				$('#total-count').html(addComma(resData.resultListTotCnt));
// $('#invtTbodyContents').html(dataHtml);
				$('#invtListItem').html(dataHtml);
				
			},
			error:function(e){
				console.log(e);
				alert('투자정보_조회 실패' + e);
			},complete:function(){
				$('.wrap-loading').addClass('display-none');
				flag = true;
			}
		});
	}, 0);
	
}
// 사용자 투자정보 페이지네이션 리로드
function invtListRef(page,num){
	var dataHtml ="";
	for(var i =(page-1)*10; i<Math.min(page*10,invtListSaveCnt); i++){
		var data = invtListSave[i];
		var aucYN= "";
		if(data.aucPblsalSeCode == 'CM00110001'){aucYN="경매"}
		else if(data.aucPblsalSeCode == 'CM00110002'){aucYN="공매"}
		// 지역1,지역2 코드명
		var courtNm = codeInvSet(courtList,data.courtCode);
		var rewardNm = codeInvSet(rewardList,data.rewardAt);
		var prposNm = codeInvSet(prposList,data.prposThreeCode);
		var stusNm = codeInvSet(stusList,data.progrsResultCode);
		var area1_val = codeSet(areaList,data.upperMapCode);
		var area2_val = codeSet(getCodeAjax('AREA',data.upperMapCode).codeList,data.mapCode);
		// [경매] 사건번호가 비어있으면 사건번호의 default 값은 1
		if(data.thingNo == "" || data.thingNo == null){
			data.thingNo = 1
		}
		if(data.special =="Y" && checkAuthValue('ivt003004','infoInqireAt') == 'N' && data.sampleAt == null){
			if(i==num){dataHtml += '<div class="item blink " id="'+data.invtInfoSn+'" style="height:200px"><li id="tgInvt" class="primiumInv">본 물건은 감정가 1억원 이상의 물건으로<br>프리미엄(스페셜)등급 회원에게만 서비스 제공됩니다.<img src="'+getContextPath()+'/images/develop/premium.png"></li></div>';}
			else{dataHtml += '<div class="item" style="height:200px"><li class="primiumInv">본 물건은 감정가 1억원 이상의 물건으로<br>프리미엄(스페셜)등급 회원에게만 서비스 제공됩니다.<img src="'+getContextPath()+'/images/develop/premium.png"></li></div>';}
			
		}
		else{
			if(i==num){ 
				dataHtml += "<div class='item blink'>";
			dataHtml += "<a href='#' class='link' id='tgInvt' style='overflow-y: scroll;cursor: default;'>";}
			else{dataHtml += "<div class='item'>";
			dataHtml += "<a href='#' class='link' style='overflow-y: scroll;cursor: default;'>";}
			if(data.rewardAt =="CM00160001" ){ dataHtml += "<i class='txt_blt03 td__category stateInv01'>"} // 보상중
			else if(data.rewardAt =="CM00160002" ){ dataHtml += "<i class='txt_blt03 td__category stateInv02'>"} // 보상예정
			else if(data.rewardAt =="CM00160003" ){dataHtml += "<i class='txt_blt03 td__category stateInv03'>"} // 환지
			else if(data.rewardAt =="CM00160004" ){ dataHtml += "<i class='txt_blt03 td__category stateInv04'>"} // 기타
			else if(data.rewardAt =="CM00160005" ){ dataHtml += "<i class='txt_blt03 td__category stateInv05'>"} // 보상 + 환지
//			if(rewardNm =="보상완료" ){dataHtml += "<i class='txt_blt03 td__category state05'>"}
//			else if(rewardNm =="보상예정" ){ dataHtml += "<i class='txt_blt03 td__category state04'>"}
//			else{dataHtml += "<i class='txt_blt03 td__category state01'>"} // 보상중
			dataHtml += rewardNm+"</i>";
			dataHtml += "<div class='description'>";
			dataHtml += "<strong class='title'>";
			if(aucYN == "경매"){  // 경매
				if(data.thingNo == "" || data.thingNo == null || data.thingNo =="99" ){ // 물건번호가  없거나 99일 경우 ,
					dataHtml += "<em class='invMN' onclick='detailSrch(\""+courtNm+"\",\""+data.incdntManageNo.split('-')[0]+'0130'+fillZero(6,data.incdntManageNo.split('-')[1])+"\",\"1\")'>사건번호 : "+courtNm + data.smCode+"계  "+ data.incdntManageNo +"</em>";
					dataHtml += "<button type='button' class='courtLink' onclick='detailSrch(\""+courtNm+"\",\""+data.incdntManageNo.split('-')[0]+'0130'+fillZero(6,data.incdntManageNo.split('-')[1])+"\",\"1\")'></button>";}
				else{ dataHtml += "<em class='invMN' onclick='detailSrch(\""+courtNm+"\",\""+data.incdntManageNo.split('-')[0]+'0130'+fillZero(6,data.incdntManageNo.split('-')[1])+"\",\""+data.thingNo+"\")'>사건번호 : "+courtNm + data.smCode+"계  "+ data.incdntManageNo +"["+data.thingNo+"]"+"</em>";
					dataHtml += "<button type='button' class='courtLink' onclick='detailSrch(\""+courtNm+"\",\""+data.incdntManageNo.split('-')[0]+'0130'+fillZero(6,data.incdntManageNo.split('-')[1])+"\",\""+data.thingNo+"\")'></button>";}
				
			}else{	// 공매
				dataHtml += "<em class='invMN' onclick='popOnbidMgrNoSearch_2021(\""+data.incdntManageNo+"\")'>관리번호 : "+data.incdntManageNo +"</em>";
				dataHtml += "<button type='button' class='onbidLink' onclick='popOnbidMgrNoSearch_2021(\""+data.incdntManageNo+"\")'></button>";
			}
			
			dataHtml += "<br></strong>";
			dataHtml += "<button type='button' class='mapInvLink' id='"+data.invtInfoSn+"'></button>";
			dataHtml += "<button type='button' class='devInvLink' onclick='devInfoDtl(\""+data.devlopInfoSn+"\", \"from\");'></button>";
//			dataHtml += rewardNm+"</i><em class='invDwknm invEN' onclick='devInfoDtl(\""+data.devlopInfoSn+"\", \"from\");' style='margin-left: 8px'>"+data.dwkNm+"</em></strong>";
			dataHtml += "<ul class='invCONTS'>";
//			dataHtml += "<li class='mid_td' style='width: 95%;'>소재지 :"+area1_val+" "+area2_val+" "+data.addr+"</li>";
			dataHtml += "<li class='mid_td'>소재지 :"+area1_val+" "+area2_val+" "+data.addr+"</li>";
			dataHtml += "<li class='mid_td'>용도 :"+prposNm+"</li>";
			dataHtml += "<li class='mid_td'>편입면적 :"+data.incrprAr+"</li>";
			dataHtml += "<li class='mid_td invEN'>개발사업명 :"+data.dwkNm+"</li>";
			dataHtml += "</ul>";
			dataHtml += "<ul class='invCONTS'>";
			dataHtml += "<li class='mid_td'>감정가 :"+addComma(data.apasmtAmount)+"원</li>";
			if(aucYN == "경매"){ // 경매, 최저가(lwetAmount) , 입찰일
				if(data.bidAmount == undefined || data.bidAmount=='' || data.bidAmount == null)
					{data.bidAmount = data.apasmtAmount}
				if(data.bidAmount <=0){dataHtml += "<li class='mid_td'>최저가 :"+addComma(data.bidAmount)+"원 </li>";}
				else{dataHtml += "<li class='mid_td'>최저가 :"+addComma(data.bidAmount)+"원 ( <span style='color: blue; font-weight:bold;'>"+( data.bidAmount  / data.apasmtAmount.replace(/,/g, "")  * 100).toFixed(2)+"%</span>)</li>";}
				dataHtml += "<li class='mid_td'>입찰일 :"+tsToDt(data.bidDe)+"</li>";
				}
				else{ // 공매, 최저가(lwetAmount) , 입찰기간
				if(data.lwetAmount == undefined || data.lwetAmount=='' || data.lwetAmount == null)
					{data.lwetAmount = data.apasmtAmount}
				if(data.lwetAmount <=0){dataHtml += "<li class='mid_td'>최저가 :"+addComma(data.lwetAmount)+"원 </li>";}
				else{dataHtml += "<li class='mid_td'>최저가 :"+addComma(data.lwetAmount)+"원 ( <span style='color: blue; font-weight:bold;'>"+( data.lwetAmount  / data.apasmtAmount.replace(/,/g, "")  * 100).toFixed(2)+"%</span>)</li>";}
				dataHtml += "<li class='mid_td'>입찰기간 : "+tsToDt(data.bidBgnde) +" ~ "+tsToDt(data.bidEndde)+" </li>";
				}
			dataHtml += "<li class='mid_td' >상태 :"+stusNm;
			if(data.progrsResultCode == 'CM00130003'){
				if(data.scsbidAmount>0){dataHtml += " ("+addComma(data.scsbidAmount)+"원 / <span style='color: red; font-weight:bold;'>"+(data.scsbidAmount/data.apasmtAmount*100).toFixed(2)+"%</span>)";}	
				else dataHtml += " ("+addComma(data.scsbidAmount)+" / "+"-"+"%)";
			}
			dataHtml += "</li></ul>";
			if(data.rewardAt == 'CM00160005' && !data.rmOne.includes("해당 토지가 환지 대상인지 보상대상인지 별도 확인 바랍니다.") ){
				data.rmOne += "<br/>◈해당 토지가 환지 대상인지 보상대상인지 별도 확인 바랍니다. "
			}
			dataHtml += "<div class='td__knowhow' escapeXml='false'><strong>특급노하우 </strong>"+data.rmOne.replace(/\\r\\n\\r\\n/gi,"\\r\\n").replace(/\\r\\n/gi,"<br/>").replace(/\r\n/gi,"<br/>")+"</div></div>";
//dataHtml += "</ul><div class='td__knowhow'><strong>특급노하우
//</strong>"+data.rmOne+"</div></div>";
//dataHtml += "</ul><div class='td__knowhow'><strong>특급노하우
//</strong><pre>"+data.rmOne+"</pre></div></div>";
			dataHtml += "</a></div>";
	}
	}
	$('#invtListItem').html(dataHtml);
	$(".scroll").scrollTop(0);
	if(num){ // 마커 클릭 이벤트
		if(data.sampleAt != null){
			paginationInit($('#invInfoListPagination'));
			 makePage($('#invInfoListPagination'),invtListSaveCnt,page, 10);
			 scrollAnimate('tgInvt',800, 70);
		}
		else{
			if(checkAuth("ivt002002", "executAt","")){ // 포인트 실행권환
				 paginationInit($('#invInfoListPagination'));
				 makePage($('#invInfoListPagination'),invtListSaveCnt,page, 10);
				 scrollAnimate('tgInvt',800, 70);
			}
		}
	}
	else{document.documentElement.scrollTop = 0;} // 페이지네이션 눌렀을때
};

// 투자정보 상세보기 - 관리자
function invtInfoDetailShow(invtInfoSn){
	// Page index
	var params = {'invtInfoSn' : invtInfoSn};
	var dataHtml;
	sideShow('invtInfoAdminDtl');
	$.ajax({
        type : 'POST',
        url : getContextPath() + "/invt/selectDetail.do",
        async: false,
        datatype : 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        data: params,
        success : function(data){
        	var resData = JSON.parse(data);
        	// 경매 공매
        	if(resData.resultList.aucPblsalSeCode =='CM00110002'){ // 공매
    			$('#paucAdmDivDtl1').css('display','block');
    			$('#paucAdmDivDtl2').css('display','block');
    			$('#paucAdmDivDtl3').css('display','block');
    			$('#paucAdmDivDtl4').css('display','block');
    			$('#aucAdmDivDtl1').css('display','none');
    			$('#aucAdmDivDtl2').css('display','none');
    			devInfoOptionset(resData.proResList,'progrsResultCodePI','선택','없음');
    		}else if(resData.resultList.aucPblsalSeCode =='CM00110001'){ // 경매
    			$('#paucAdmDivDtl1').css('display','none');
    			$('#paucAdmDivDtl2').css('display','none');
    			$('#paucAdmDivDtl3').css('display','none');
    			$('#paucAdmDivDtl4').css('display','none');
    			$('#aucAdmDivDtl1').css('display','block');
    			$('#aucAdmDivDtl2').css('display','block');
    			devInfoOptionset(resData.proResList,'progrsResultCodeAI','선택','없음');
    		}
        	// 대표 위치 찾기
        	var geocoder = new kakao.maps.services.Geocoder();
        	var callback = function(result, status) {
        	    if (status === kakao.maps.services.Status.OK) {
        	    	document.invDetailDiv.locDtl.value = result[0].address.address_name;
        	    }
        	};
        	geocoder.coord2Address(resData.resultList.lo, resData.resultList.la, callback);
        	
        	
        	
        	var sortArea1List = resData.area1List.sort(function(a, b) {
        	    return a.lowestAreaNm < b.lowestAreaNm ? -1 : a.lowestAreaNm > b.lowestAreaNm ? 1 : 0;
        	});
        	// 지역1,지역2 코드명
        	var area1_val = devInfoCodeSet(resData.area1List,resData.resultList.upperMapCode);
    		// var area2_val =
			// devInfoCodeSet(getCodeAjax('AREA',resData.resultList.upperMapCode).codeList,resData.resultList.mapCode);
        	// 지역 (시도,시군구)
    		devInfoOptionset(sortArea1List,'invAdmAreaAddDtl1','선택',resData.resultList.upperMapCode);
    		devInfoOptionset(getCodeAjax('AREA',resData.resultList.upperMapCode).codeList,'invAdmAreaAddDtl2','선택',resData.resultList.mapCode);
        	// 법원
    		devInfoOptionset(resData.courtList,'courtNmDtl','선택',resData.resultList.courtCode);
    		// 예상보상상태
    		devInfoOptionset(resData.prposList,'prposCodeDtl1','선택',resData.resultList.prposOneCode);
    		devInfoOptionset(getCodeAjax('CMMN',resData.resultList.prposOneCode).codeList,'prposCodeDtl2','선택',resData.resultList.prposTwoCode);
    		devInfoOptionset(getCodeAjax('CMMN',resData.resultList.prposTwoCode).codeList,'prposCodeDtl3','선택',resData.resultList.prposThreeCode);
    		
    		$('#aucPblsalSeCodeDtl').val(resData.resultList.aucPblsalSeCode);
        	document.invDetailDiv.dwkno.value = resData.resultList.dwkNo;
        	document.invDetailDiv.dwknm.value = resData.resultList.dwkNm;
        	$('#incrprAtDtl').val(resData.resultList.incrprAt);
        	document.invDetailDiv.incrprAr.value = resData.resultList.incrprAr;
        	document.invDetailDiv.courtNmDtl.value = resData.resultList.courtCode;
        	document.invDetailDiv.smCode.value = resData.resultList.smCode;
        	document.invDetailDiv.thingNo.value = resData.resultList.thingNo;
        	document.invDetailDiv.incdntManageNo.value = resData.resultList.incdntManageNo;
        	document.invDetailDiv.pincdntManageNo.value = resData.resultList.incdntManageNo;
        	document.invDetailDiv.invAdmAreaAddDtl1.value = resData.resultList.upperMapCode;
        	document.invDetailDiv.invAdmAreaAddDtl2.value = resData.resultList.mapCode;
        	document.invDetailDiv.addr.value = resData.resultList.addr;
        	document.invDetailDiv.loDtl.value = resData.resultList.lo;
        	document.invDetailDiv.laDtl.value = resData.resultList.la;
        	document.invDetailDiv.prposCodeDtl1.value = resData.resultList.prposOneCode;
        	document.invDetailDiv.prposCodeDtl2.value = resData.resultList.prposTwoCode;
        	document.invDetailDiv.prposCodeDtl3.value = resData.resultList.prposThreeCode;
        	document.invDetailDiv.apasmtAmount.value = addComma(resData.resultList.apasmtAmount);
//        	document.invDetailDiv.cntntsOthbcAt.value = resData.resultList.cntntsOthbcAt;
    		$("#invDetailDiv input:radio[name='cntntsOthbcAt'][value='"+resData.resultList.cntntsOthbcAt+"']").prop("checked", true);
    		$("#invDetailDiv input:radio[name='smpleExAt'][value='"+resData.resultList.smpleExAt+"']").prop("checked", true);
    		$("#invDetailDiv input:radio[name='rewardAt'][value='"+resData.resultList.rewardAt+"']").prop("checked", true);
        	document.invDetailDiv.endDate.value = addDash(resData.resultList.endPnttm);
        	document.invDetailDiv.startDate.value = addDash(resData.resultList.beginPnttm);
        	document.invDetailDiv.rmOne.value = resData.resultList.rmOne;
        	// UUID
        	document.invDetailDiv.invtInfoSn.value = resData.resultList.invtInfoSn;
        	document.invDetailDiv.aucPblsalSeCodeDt.value = resData.resultList.aucPblsalSeCode;
        	// 지역별(용도), 진행내역에도 투자 일련번호 추가
        	document.proListForm.invtInfoSn.value = resData.resultList.invtInfoSn;
        	proListSearch(resData.resultList.aucPblsalSeCode);
        	//devlopInfoSn 추가
        	document.invDetailDiv.devlopInfoSn.value = resData.devList.devlopInfoSn;
        },
        error:function(e){
        	console.log(e);
        	alert('invtinfo_Detail_조회 실패' + e);
    	}
	});
}

// 수정
function invtInfoUpdate(){
	document.invDetailDiv.endDate.value = document.invDetailDiv.endDate.value.replace(/-/gi,''); 
	document.invDetailDiv.startDate.value = document.invDetailDiv.startDate.value.replace(/-/gi,''); 
	document.invDetailDiv.apasmtAmount.value = document.invDetailDiv.apasmtAmount.value.replace(/,/gi,''); 
	var params = $('#invDetailDiv').serializeArray();
	var resData;
	
	$.ajax({
        type : 'POST',
        url : getContextPath() + "/invt/updateInvtInfo.do",
        async: false,
        datatype : 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        data: params,
        success : function(data){
        	resData = JSON.parse(data);
        	if(resData.resultList == 1){
        		invAdmListSearch();
        		sideShow('invtAdminList');
        		swal("수정되었습니다.", "투자정보가 수정되었습니다!", "success");
			}else{
				swal("수정에 실패하였습니다.", "수정에 실패하였습니다!", "error");
        	}
        },
        error:function(e){
        	console.log(e);
        	alert('invtinfo_Detail_조회 실패' + e);
    	}
	});
}

// 삭제
function invtInfoDelete(){
	var params = $('#invDetailDiv').serializeArray();
	var yn = confirm("삭제하시겠습니까?");
	if(yn){
		$.ajax({
	        type : 'POST',
	        url : getContextPath() + "/invt/deleteInvtInfo.do",
	        async: false,
	        datatype : 'json',
	        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
	        data: params,
	        success : function(data){
	        	resData = JSON.parse(data);
	        	if(resData.resultList == 1){
	        		invAdmListSearch();
	        		sideShow('invtAdminList');
	        		swal("삭제되었습니다.", "투자정보가 삭제되었습니다!", "success");
				}else{
					swal("삭제에 실패하였습니다.", "삭제에 실패하였습니다!", "error");
	        	}
	        },
	        error:function(e){
	        	console.log(e);
	        	alert('devlopinfo_Detail_조회 실패' + e);
	    	}
		});
	}
}


// 투자정보 -관리자 - 진행내역 목록 뿌리기
function proListSearch(seCode){
	
	// Page index
	var params = $('#proListForm').serializeArray();
	var dataHtml="";
	var resData; 
	
	$.ajax({
		type : 'POST',
		url : getContextPath() + "/invt/selectProList.do",
		async: false,
		datatype : 'json',
		contentType: 'application/x-www-form-urlencoded;charset=utf-8',
		data: params,
		success : function(data){ 
			resData = JSON.parse(data);
			if(seCode =="CM00110001"){ // 경매
					dataHtml += "<table class='table table-bordered text-center'>"
					dataHtml += "				<colgroup>"
					dataHtml += "					<col style='width: 20%'>"
					dataHtml += "					<col style='width: 15%'>"
					dataHtml += "					<col style='width: 10%'>"
					dataHtml += "					<col style='width: auto'>"
					dataHtml += "					<col style='width: auto'>"
					dataHtml += "					<col style='width: 15%'>"
					dataHtml += "					<col style='width: 15%'>"
					dataHtml += "				</colgroup>"
					dataHtml += "				<thead>"
					dataHtml += "					<tr>"
					dataHtml += "						<th scope='col'>사건번호</th>"
					dataHtml += "						<th scope='col'>입찰일자</th>"
					dataHtml += "						<th scope='col'>진행결과</th>"
					dataHtml += "						<th scope='col'>입찰금액</th>"
					dataHtml += "						<th scope='col'>낙찰금액</th>"
					dataHtml += "						<th scope='col'>등록자ID</th>"
					dataHtml += "						<th scope='col'>등록일</th>"
					dataHtml += "					</tr>"
					dataHtml += "				</thead>"
					dataHtml += "				<tbody id='proListTbodyContents'>"
					if(resData.resultList.length != 0){
						resData.resultList.forEach(function(data, index){
							dataHtml += "<tr id='" + data.invtProgrsDtlsSn+ "' style='cursor: pointer;'>";
							dataHtml += "<td class='listtd'>" + data.courtNm +" "+data.smCode+"계 "+data.incdntManageNo+ "</td>";
							dataHtml += "<td class='listtd'>" + tsToDt(data.bidDe) + "</td>";
							dataHtml += "<td class='listtd'>" + data.stusNm + "</td>";
							dataHtml += "<td class='listtd'>" + addComma(data.bidAmount) + "원</td>";
							dataHtml += "<td class='listtd'>" + addComma(data.scsbidAmount) + "원</td>";
							dataHtml += "<td class='listtd'>" + data.lastUpdusrId + "</td>";
							dataHtml += "<td class='listtd'>" + tsToDt(data.lastUpdtPnttm) + "</td>";
							dataHtml += "</tr>";
						});
					}else{
						dataHtml += "<tr><td style='border: solid 1px ;text-align: center;'colspan='7'>없음</td></tr>";
					}
					dataHtml += "				</tbody>"
					dataHtml += "			</table>"
					$('#proListTbody').html(dataHtml);
					proDtShow('경매');
			} 
			else{ // 공매
				dataHtml += "<table class='table table-bordered text-center'>"
				dataHtml += "				<colgroup>"
				dataHtml += "					<col style='width: 10%'>"
				dataHtml += "					<col style='width: 20%'>"
				dataHtml += "					<col style='width: 10%'>"
				dataHtml += "					<col style='width: 10%'>"
				dataHtml += "					<col style='width: auto'>"
				dataHtml += "					<col style='width: 10%'>"
				dataHtml += "					<col style='width: 10%'>"
				dataHtml += "					<col style='width: 10%'>"
				dataHtml += "				</colgroup>"
				dataHtml += "				<thead>"
				dataHtml += "					<tr>"
				dataHtml += "						<th scope='col'>관리번호</th>"
				dataHtml += "						<th scope='col'>진행결과</th>"
				dataHtml += "						<th scope='col'>입찰시작일자</th>"
				dataHtml += "						<th scope='col'>입찰종료일자</th>"
				dataHtml += "						<th scope='col'>최저금액</th>"
				dataHtml += "						<th scope='col'>개찰일시</th>"
				dataHtml += "						<th scope='col'>등록자ID</th>"
				dataHtml += "						<th scope='col'>등록일</th>"
				dataHtml += "					</tr>"
				dataHtml += "				</thead>"
				dataHtml += "				<tbody id='proListTbodyContents'>"
				if(resData.resultList.length != 0){
					resData.resultList.forEach(function(data, index){
						
						dataHtml += "<tr id='" + data.invtProgrsDtlsSn + "' style='cursor: pointer;'>";
						dataHtml += "<td class='listtd'>" + data.incdntManageNo +"</td>";
						dataHtml += "<td class='listtd'>" + data.stusNm + "</td>";
						dataHtml += "<td class='listtd'>" + tsToDt(data.bidBgnde) + "</td>";
						dataHtml += "<td class='listtd'>" + tsToDt(data.bidEndde) + "</td>";
						dataHtml += "<td class='listtd'>" + addComma(data.lwetAmount) + "원</td>";
						dataHtml += "<td class='listtd'>" + addDash(data.opengDt) + "</td>";
						dataHtml += "<td class='listtd'>" + data.lastUpdusrId + "</td>";
						dataHtml += "<td class='listtd'>" + tsToDt(data.lastUpdtPnttm)+ "</td>";
						dataHtml += "</tr>";
					});
				}else{
					dataHtml += "<tr><td style='border: solid 1px ;text-align: center;'colspan='8'>없음</td></tr>";
				}
				dataHtml += "				</tbody>"
				dataHtml += "			</table>"
				$('#proListTbody').html(dataHtml);
				proDtShow('공매');
			} 
		},
		error:function(e){
			console.log(e);
			alert('진행내역 조회 실패' + e);
		}
	});
}

// 마커 클릭 이벤트
function zoomInv(targetSn){
	$("#sideAdmin").addClass('moveTo');
	
	if($('#invtAdminList')[0].style.display == 'block' || $('#invtInfoAdminDtl')[0].style.display == 'block' ){ // 관리자
		invtInfoDetailShow(targetSn);
	}else{
		var targetNum = 0;
		for(var i =0; i < invtListSave.length; i++){
			if(invtListSave[i].invtInfoSn == targetSn){
				targetNum  = i;
			}
		}
		var page = parseInt(targetNum / 10)+1;
		invtListRef(page,targetNum);
	}
}


// 진행내역 정보 상세보기 (테이블 목록 클릭)
function proDtShow(ts){
	$('#proListTbodyContents').on('click','tr',function(e){
		$('#proAucInsert').css('display','none');
		$('#proPaucInsert').css('display','none');
		if(ts =="경매"){
			$('#proAucDt').css('display','block');
			$('#proPaucDt').css('display','none');
			scrollAnimate('proAucDt',700);
		}else{
			$('#proPaucDt').css('display','block');
			$('#proAucDt').css('display','none');
			scrollAnimate('proPaucDt',700);
		}
			showProDetailForm(e.currentTarget.id,ts);
			// 클릭시 스크롤 이동
			
	});
}

// 진행내역 상세보기 보이기
function showProDetailForm(Sn,ts){
	var params = {'invtProgrsDtlsSn' : Sn};
	if(params.Sn != ""){
		var dataHtml;
		var resData; 
		
		$.ajax({
			type : 'POST',
			url : getContextPath() + "/invt/selectProDetail.do",
			async: false,
			datatype : 'json',
			contentType: 'application/x-www-form-urlencoded;charset=utf-8',
			data: params,
			success : function(data){
				resData = JSON.parse(data);
				if(ts =='경매'){
					// 법원
		    		devInfoOptionset(resData.proResList,'progrsResultCodeAD','선택',resData.resultList.progrsResultCode);
					document.proADetailForm.bidAmountAD.value = addComma(resData.resultList.bidAmount);
					document.proADetailForm.bidDeAD.value = tsToDt(resData.resultList.bidDe);
					document.proADetailForm.scsbidAmountAD.value = addComma(resData.resultList.scsbidAmount);
					document.proADetailForm.sucbidrNmAD.value = resData.resultList.sucbidrNm;
					document.proADetailForm.entendManCoAD.value = resData.resultList.entendManCo;
					document.proADetailForm.rmAD.value = resData.resultList.rm;
					// UUID
					document.proADetailForm.invtProgrsDtlsSnAD.value = resData.resultList.invtProgrsDtlsSn;
					document.proADetailForm.invtInfoSnAD.value = resData.resultList.invtInfoSn;
				}
				else if (ts == '공매'){
					// 법원
					devInfoOptionset(resData.proResList,'progrsResultCodePD','선택',resData.resultList.progrsResultCode);
					document.proPDetailForm.bidBgndePD.value = tsToDt(resData.resultList.bidBgnde);
					document.proPDetailForm.bidEnddePD.value = tsToDt(resData.resultList.bidEndde);
					document.proPDetailForm.lwetAmountPD.value = addComma(resData.resultList.lwetAmount);
					document.proPDetailForm.opengDtPD.value = addDash(resData.resultList.opengDt);
					document.proPDetailForm.scsbidAmountPD.value = addComma(resData.resultList.scsbidAmount);
					document.proPDetailForm.entendManCoPD.value = resData.resultList.entendManCo;
					if(resData.resultList.rm){
					document.proPDetailForm.rmPD.value = resData.resultList.rm;}
					// UUID
					document.proPDetailForm.invtProgrsDtlsSnPD.value = resData.resultList.invtProgrsDtlsSn;
					document.proPDetailForm.invtInfoSnPD.value = resData.resultList.invtInfoSn;
				}
			},
			error:function(e){
				console.log(e);
				alert('진행내역 상세보기_조회 실패' + e);
			}
		});
	}else{
		swal('추진내역이 없습니다');
	}
}

// 진행내역 수정
function ProUpdate(){
	var resData;
	if( document.invDetailDiv.aucPblsalSeCodeDt.value == "CM00110001"){ // 경매
		document.proADetailForm.bidAmountAD.value = document.proADetailForm.bidAmountAD.value.replace(/,/gi,''); 
		document.proADetailForm.scsbidAmountAD.value = document.proADetailForm.scsbidAmountAD.value.replace(/,/gi,''); 
		var params = $('#proADetailForm').serializeArray();
		var yn = confirm("경매 진행내역을 수정하시겠습니까?");
	}else{
		document.proPDetailForm.scsbidAmountPD.value = document.proPDetailForm.scsbidAmountPD.value.replace(/,/gi,''); 
		document.proPDetailForm.lwetAmountPD.value = document.proPDetailForm.lwetAmountPD.value.replace(/,/gi,''); 
		document.proPDetailForm.opengDtPD.value = document.proPDetailForm.opengDtPD.value.replace(/-/gi,''); 
		var params = $('#proPDetailForm').serializeArray();
		var yn = confirm("공매 진행내역을 수정하시겠습니까?");
		
	}
	if(yn){
		$.ajax({
			type : 'POST',
			url : getContextPath() + "/invt/updateProDetail.do",
			async: false,
			datatype : 'json',
			contentType: 'application/x-www-form-urlencoded;charset=utf-8',
			data: params,
			success : function(data){
				resData = JSON.parse(data);
				if(resData.updateResult == 1){
					swal('진행내역 수정완료');
// $("#proADetailForm")[0].reset();
// $("#proPDetailForm")[0].reset();
// closeTabs();
					proListSearch(document.invDetailDiv.aucPblsalSeCodeDt.value);
				}else{
					swal('진행내역 수정실패');
				}
			},
			error:function(e){
				console.log(e);
				alert('진행내역_수정_실패' + e);
			}
		});
	}
}

// 진행내역 삭제
function ProDelete(){
	var resData;
	if( document.invDetailDiv.aucPblsalSeCodeDt.value == "CM00110001"){ // 경매
		var params = $('#proADetailForm').serializeArray();
		var yn = confirm("경매 진행내역을 삭제하시겠습니까?");
	}else{
		var params = $('#proPDetailForm').serializeArray();
		var yn = confirm("공매 진행내역을 삭제하시겠습니까?");
	}
	
	if(yn){
		$.ajax({
			type : 'POST',
			url : getContextPath() + "/invt/deleteProDetail.do",
			async: false,
			datatype : 'json',
			contentType: 'application/x-www-form-urlencoded;charset=utf-8',
			data: params,
			success : function(data){
				resData = JSON.parse(data);
				if(resData.resultList == 1){
					swal('진행내역 삭제완료');
					closeTabs();
					$("#proADetailForm")[0].reset();
					$("#proPDetailForm")[0].reset();
					proListSearch(document.invDetailDiv.aucPblsalSeCodeDt.value);
				}else{
					swal('진행내역 삭제완료');
				}
			},
			error:function(e){
				console.log(e);
				alert('진행내역_삭제 실패' + e);
			}
		});
	}
}

// 진행내역 추가
function ProInsert(){
	var resData;
	if( document.invDetailDiv.aucPblsalSeCodeDt.value == "CM00110001"){ // 경매
		document.proAInsertForm.bidAmountAI.value = document.proAInsertForm.bidAmountAI.value.replace(/,/gi,''); 
		document.proAInsertForm.scsbidAmountAI.value = document.proAInsertForm.scsbidAmountAI.value.replace(/,/gi,''); 
		document.proAInsertForm.invtInfoSnAI.value = document.invDetailDiv.invtInfoSn.value;// UUID
		var params = $('#proAInsertForm').serializeArray();
		var yn = confirm("경매 진행내역을 등록하시겠습니까?");
	}else{ // 공매
		document.proDInsertForm.scsbidAmountPI.value = document.proDInsertForm.scsbidAmountPI.value.replace(/,/gi,''); 
		document.proDInsertForm.lwetAmountPI.value = document.proDInsertForm.lwetAmountPI.value.replace(/,/gi,''); 
//		document.proPDetailForm.opengDtPD.value = document.proAInsertForm.opengDtPD.value.replace(/-/gi,'');
		//정선씨 아니시에이팅
		document.proDInsertForm.opengDtPI.value = document.proDInsertForm.opengDtPI.value.replace(/-/gi,''); 
		document.proDInsertForm.invtInfoSnPI.value = document.invDetailDiv.invtInfoSn.value; // UUID
		var params = $('#proDInsertForm').serializeArray();
		var yn = confirm("공매 진행내역을 등록하시겠습니까?");
	}
	if(yn){
		$.ajax({
			type : 'POST',
			url : getContextPath() + "/invt/insertProDetail.do",
			async: false,
			datatype : 'json',
			contentType: 'application/x-www-form-urlencoded;charset=utf-8',
			data: params,
			success : function(data){
				resData = JSON.parse(data);
				if(resData.resultList == 1){
					swal('진행내역 등록완료');
					$("#proAInsertForm")[0].reset();
					$("#proDInsertForm")[0].reset();
					proListSearch(document.invDetailDiv.aucPblsalSeCodeDt.value);
				}else{
					swal('진행내역 등록실패');
				}
			},
			error:function(e){
				console.log(e);
				alert('지번별_등록 실패' + e);
			}
		});
	}
}

// 지역 코드
function codeInvSet(inputParam , dataParam){
	var result;
	inputParam.forEach(function(data, index){
		if(data.codeId == dataParam){
			result = data.codeIdNm;
		}
	});
	return result;
}
// 개발 코드
function codeSet(inputParam , dataParam){
	var result;
	inputParam.forEach(function(data, index){
		if(data.legaldongCode == dataParam){
			result = data.lowestAreaNm;
		}
	});
	return result;
}

function optionSet(codeList,selectTagId,firstStr,selVal){
	var strHtml = ""; 
	strHtml += "<option value=''>" + firstStr + "</option>";
	if(selectTagId == 'invDs1'
		|| selectTagId == 'invDs2'
		|| selectTagId == 'invDs3'
		|| selectTagId == 'invDs4'){
	var spclTxt;
		codeList.forEach(function(data){
			var resultData = getCodeAjax('CMMN',data.codeId);
			// 조회 후 Select 값 유지
			// 하위 Depth level이 있는 특수지구에게는 문자 마지막에 특수문자 부여
			if(resultData.codeList.length !=0){
				spclTxt = '&#9660';
			}else{
				spclTxt ='';
			}
			// ;
			if(selVal == data.codeId){
				strHtml += "<option value='" + data.codeId + "' selected>" + data.codeIdNm + " "+spclTxt+"</option>";
			}else{
				strHtml += "<option value='" + data.codeId + "'>" + data.codeIdNm + " "+spclTxt+"</option>";	
			}
		});
	}else{
		codeList.forEach(function(data){
			// 조회 후 Select 값 유지
			if(selVal == data.legaldongCode){
				strHtml += "<option value='" + data.legaldongCode + "' selected>" + data.lowestAreaNm + "</option>";
			}else{
				strHtml += "<option value='" + data.legaldongCode + "'>" + data.lowestAreaNm + "</option>";	
			}
		});
	}
	$('#'+selectTagId).html(strHtml);
}

// 법원페이지로
function detailSrch(vJiwonNm, vSaNo, vMaemulSer){
	var	dform	=document.hform; 
	window.open('', '_scourtSearch');
	dform.jiwonNm.value		= vJiwonNm;
	dform.saNo.value			= vSaNo;
	dform.maemulSer.value		= vMaemulSer;
	// dform.charset = 'euc-kr';
	eucKrEncodng();
	dform.submit();
}
// 공매 검색 화면
function popOnbidMgrNoSearch_2021(aMgrNo) {
	window.open('', '_onbidSearch');
	document.onbidMgrNoSearch_2021.searchCltrMnmtNo.value = aMgrNo;
	document.onbidMgrNoSearch_2021.submit();
}
function eucKrEncodng() {
	// IE 에서 accept-charset="euc-kr" 안먹음 해결
	var _ua = navigator.userAgent;
	var rv = -1;
     
	// IE 11,10,9,8
	var trident = _ua.match(/Trident\/(\d.\d)/i);
	if( trident != null )
	{
    	if( trident[1] == "7.0" ) rv = "IE" + 11;
    	if( trident[1] == "6.0" ) rv = "IE" + 10;
    	if( trident[1] == "5.0" ) rv = "IE" + 9;
    	if( trident[1] == "4.0" ) rv = "IE" + 8;
    	// alert(rv);
	} else {
		// IE 7...
	    if( navigator.appName == 'Microsoft Internet Explorer' ) rv = "IE" + 7;
	}
	if(rv != -1) {
		document.charset = 'euc-kr';
		return true;
		document.charset = 'utf-8';
	}
}
// 투자정보 포인트 이동
function moveInvtAddr(id){
	var lo = $('#lo'+id).val();
	var la =  $('#la'+id).val();
	map.removeLayer(map.getLayerByName('gz_invt_info'));
	removeInteraction(null, "edit");
	var center = ol.proj.transform([Number(lo),Number(la)],'EPSG:4326','EPSG:3857')
	
	var marker = new ol.Feature(new ol.geom.Point(center));
	marker.set("mapId",'gz_invt_info');
	var layerSource = new ol.source.Vector();
	layerSource.addFeature(marker);
	var vector = new ol.layer.Vector ({
	     source: layerSource, 
	     id: 'gz_invt_info',
	     name: 'gz_invt_info',
	     layerType : 'viewLayer'
	   });
	setFeatureStyle(marker, "select");
	map.addLayer(vector);
	map.getView().setCenter(ol.proj.fromLonLat([Number(lo),Number(la)]));
	map.getView().setZoom(14);
	$("#sideAdmin").removeClass("moveTo");// 닫기
	var select = new ol.interaction.Select({
        condition: ol.events.condition.never

    });
    select.getFeatures().push(marker);
    /* mode와 name에 관한 properties 입력 */
    select.setProperties({mode: "edit"});
    select.setProperties({name: "modifySelection"});
    select.setProperties({type: "select"});

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


// 페이지 네이션
function paginationInit(paginationDiv){
	paginationDiv.empty();
	paginationDiv.removeData("twbs-pagination");
	paginationDiv.unbind("page");
}
function makePage(paginationDiv,totalPages, currentPageNo, PageNum){
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
	    	document.invtListForm.pageIndex.value = page;
	    	// invListSearch();
	    	invtListRef(page);
	    }
	});
}

function makePageAdmin(paginationDiv,totalPages, currentPageNo, PageNum){
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
			document.invtAdmForm.pageIndex.value = page;
			invAdmListSearch();
		}
	});
}

function fillZero(width, str){
    return str.length >= width ? str:new Array(width-str.length+1).join('0')+str;// 남는
																					// 길이만큼
																					// 0으로
																					// 채움
}

function setDateBox(id){
    var dt = new Date();
    var year = "";
    var com_year = dt.getFullYear();
    // 올해 기준으로 -1년부터 +5년을 보여준다.
    for(var y = (com_year+3) ; y >= (2011); y--){
// if( id.name == "incdntManageNoYear"){
// $("#"+id.name).append("<option value='"+ y +"' >"+ y + " " +"</option>");
// }else
// $("#"+id.name).append("<option value='"+ y +"'>"+ y + " 년" +"</option>");
        $("#rwYr").append("<option value='"+ y +"'>"+ y + " 년" +"</option>");
    }
}

function closeTabs(){
	$('#proAucDt').css('display','none');
	$('#proPaucDt').css('display','none');
	$('#proPaucInsert').css('display','none');
	$('#proAucInsert').css('display','none');
}

// 우측 스르륵 관리자 div
function sideShow(id){
	var divNm =document.getElementById(id);
	for(var i = 0; i<divNm.parentNode.children.length; i++){
		divNm.parentNode.children[i].style.display="none"
	}
	if(id == 'invtAdminList'){ // 투자정보
		
	}else if(id == 'invtAdminInsert'){
		
	}else if(id == 'rewardAdminList'){// 보상전례
		map.removeLayer(map.getLayerByName('gz_reward_precednt_info'));
		map.removeLayer(map.getLayerByName('gz_invt_info'));
		removeInteraction(null, "edit");
		rewardAdmListSearch();
	}
	$("#invtAdminSearchForm").hide();
	$('#sideAdminTg').css('display','block');
	$("#sideAdmin").show();
	$("#sideAdmin").addClass('moveTo');
	divNm.style.display = 'block';
}

function invtAdminShow(){
	if(checkAuth("adm008001", "infoInqireAt","")){
		sideShow('invtAdminList');
		$("#invtAdmForm")[0].reset();
		invAdmListSearch();
	}
}

function fn_press(event, type) {
    if(type == "numbers") {
        if((event.keyCode < 48 || event.keyCode > 57) && event.keyCode != 45 ) return false;
        // onKeyDown일 경우 좌, 우, tab, backspace, delete키 허용 정의 필요
    }
}
/* 한글입력 방지 */
function fn_press_han(obj)
{
    // 좌우 방향키, 백스페이스, 딜리트, 탭키에 대한 예외
    if(event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 39 || event.keyCode == 189
    || event.keyCode == 46 ) return;
    // obj.value = obj.value.replace(/[\a-zㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
    obj.value = obj.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
}

// 투자정보 등록 주소찾기
function findAddr(addr)
{
	var geocoder = new kakao.maps.services.Geocoder();
	// api 사용 자제 지오코딩 테스트
	if(addr != null){
		geocoder.addressSearch(addr, function(result, status) {
			if(status == "OK"){
				var lat = result[0].y;
				var lon = result[0].x;
		        $('#lo').val(lon);
		        $('#la').val(lat);
		        swal("해당 주소 좌표가 입력되었습니다.", "하단의 위치확인버튼으로 지도에서 확인해 주세요!", "success");
			}else{
				swal("정보가 없습니다.", "주소를 확인해 주세요!", "error");
			}
		});
	}
}

//투자정보 등록 주소찾기
function findAddrAuto(){
	if(document.invInsertDiv.invAdmAreaAdd2.value){
		document.invInsertDiv.loc.value = $('#invAdmAreaAdd1 option:selected').text() + " " + $('#invAdmAreaAdd2 option:selected').text() + " " +document.invInsertDiv.addr.value;
		findAddr(document.invInsertDiv.loc.value );
	}else if(document.invInsertDiv.invAdmAreaAdd1.value){
		document.invInsertDiv.loc.value = $('#invAdmAreaAdd1 option:selected').text() + " " +document.invInsertDiv.addr.value;
		findAddr(document.invInsertDiv.loc.value );
	}
}
//투자정보 수정 주소찾기
function findAddrAutoID(){
	if(document.invDetailDiv.invAdmAreaAddDtl2.value){
		document.invDetailDiv.locDtl.value = $('#invAdmAreaAddDtl1 option:selected').text() + " " + $('#invAdmAreaAddDtl2 option:selected').text() + " " +document.invDetailDiv.addr.value;
		findAddr(document.invDetailDiv.locDtl.value );
	}else if(document.invDetailDiv.invAdmAreaAddDtl1.value){
		document.invDetailDiv.locDtl.value = $('#invAdmAreaAddDtl1 option:selected').text() + " " +document.invDetailDiv.addr.value;
		findAddr(document.invDetailDiv.locDtl.value );
	}
}

// 투자정보 상세보기 주소찾기
function findAddrDtl(addr)
{
	var geocoder = new kakao.maps.services.Geocoder();
	// api 사용 자제 지오코딩 테스트
	if(addr != null){
		geocoder.addressSearch(addr, function(result, status) {
			if(status == "OK"){
				var lat = result[0].y;
				var lon = result[0].x;
				$('#loDtl').val(lon);
				$('#laDtl').val(lat);
				swal("해당 주소 좌표가 입력되었습니다.", "하단의 위치확인버튼으로 지도에서 확인해 주세요!", "success");
			}else{
				swal("정보가 없습니다.", "주소를 확인해 주세요!", "error");
			}
		});
	}
}

// 투자정보 등록 지도에서 위치 확인
function checkAddr(lo, la)
{
	map.getView().setCenter(ol.proj.fromLonLat([Number(lo),Number(la)]));
    map.getView().setZoom(14);
    makePt(lo, la);
    $("#sideAdmin").removeClass("moveTo"); // 닫기
}

// Timestamp to Date 함수
function tsToDt(ts){
	if(ts >= 0){
	var date = new Date(ts);
	var month = (date.getMonth()+1);
	var day = date.getDate();
	if(month < 10){month = '0'+ month;}
	if(day < 10){day = '0' + day;}
	return date.getFullYear()+"-"+month+"-"+day ;
	}
	else 
		return "0000-00-00";
}
// 대쉬(-) 추가
function addDash(noDash){
	if(noDash!=null && noDash.length<9){
		return noDash.substring(0,4)+"-"+noDash.substring(4,6)+"-"+noDash.substring(6,8);
	}else{
		return "";
	}
}

// 포인트 만들기
function makePt(lo,la){
	   map.removeLayer(map.getLayerByName('gz_invt_info'));
	   overlay.setPosition(undefined);
	   closer.blur();
	   //removeInteraction(null, "edit");
	   var center = ol.proj.transform([Number(lo),Number(la)],'EPSG:4326','EPSG:3857')

	   var marker = new ol.Feature(
			      new ol.geom.Point(center)
			   );
	   		marker.set("mapId",'gz_invt_info');	
			   var layerSource = new ol.source.Vector();
			   layerSource.addFeature(marker);
			   var vector = new ol.layer.Vector ({
			        source: layerSource, 
			        id: 'gz_invt_info',
			        name: 'gz_invt_info',
			        layerType : 'viewLayer'
			      });


			   setFeatureStyle(marker, "deselect");
			   map.addLayer(vector);
			}

function getFormatDate(date){
    var year = date.getFullYear();
    var month = (1 + date.getMonth());
    month = month >= 10 ? month : '0' + month;
    var day = date.getDate();
    day = day >= 10 ? day : '0' + day;
    return year + '-' + month + '-' + day;
}
function getFormatDate2(date){
	date.setMonth(date.getMonth() + 1);
    var year = date.getFullYear();
    var month = (1 + date.getMonth());
    month = month >= 10 ? month : '0' + month;
    var day = date.getDate();
    day = day >= 10 ? day : '0' + day;
    return year + '-' + month + '-' + day;
}