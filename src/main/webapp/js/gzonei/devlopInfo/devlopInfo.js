//페이지 뜰때 로딩
var flag = true;
//지역1 코드
var area1CodeList = [];
var swalConfirm;
//map페이지 권한
var authVO;
//사업지구 코드
//var dsCodeList = [];

$( document ).ready(function() {
	//모바일 개발정보/투자정보 선택 CSS 변경
/*	$('#mobileMapUl .singleLi').on('click',function(e){
		var selClsNm = e.currentTarget.className;
		switch(selClsNm){
			case"n2 singleLi":
				$('.n1.singleLi a').removeClass('ov');
				break;
			default:
				break;
			
		}
		
	});
*/	
	//개발사업명 검색창 포커스시 검색어 지우기
	$('#searchKeyword').focus(function(e){
		$('#searchKeyword').val("");
	});
	
	//금액 Input 한글 및 콤마 이벤트
	var input = $('.moneyDev');
	input.on( "keyup", function( event ) {
	    var selection = window.getSelection().toString();
	    if ( selection !== '' ) {return;}
	    if ( $.inArray( event.keyCode, [38,40,37,39] ) !== -1 ) {return;}

	    var $this = $( this );
	    var input = $this.val();
	    var strKrInput = numberToKorean(Number(input.replace(/,/gi,'')));
	    $('#'+event.currentTarget.id+"Str").html(strKrInput);
	    
	    var input = input.replace(/[\D\s\._\-]+/g, "");
	    input = input ? parseInt( input, 10 ) : 0;
	    $this.val( function() {return ( input === 0 ) ? "" : input.toLocaleString( "en-US" );});
	} );
	
	//상세정보 마우스 오버 이벤트
	$('.devInfoImgBtn').mouseover(function(e){
		mouseOverEvent(e);
	});
	$('.devInfoImgBtn').mouseout(function(e){
		mouseOverEvent(e);
	});
	
	//프린트 클릭 수 업데이트
	$('#printCntChk').on('click',function(e){
		var curCnt =  e.currentTarget.dataset.cntnum;
		var cntDt =  e.currentTarget.dataset.cntdt;
		var today = getToday();
		if(curCnt == "0" && cntDt==today){
			swal('프린트 할 수 없습니다','프린트 가능 횟수를 초과하였습니다','error');
		}else{
			var outptCo = "0";
			if(curCnt !="0"){
				outptCo = (parseInt(curCnt)-1).toString();
			}
			$.ajax({
				type : 'POST',
				url : getContextPath()+"/devlopInfo/updatePrintCnt.do",
				async: false,
				datatype : 'json',
				contentType: 'application/x-www-form-urlencoded;charset=utf-8',
				data: {'outptCo':outptCo},
				success : function(data){ 
					var resData = JSON.parse(data);
					if(resData.updateResult==1){
						var printAtag = $('#printCntChk');
						printAtag.attr('data-cntnum',resData.UserCntMap.outptCo);
						printAtag.attr('data-cntdt',resData.UserCntMap.outptDt);
						printAtag.html("<i class='icon-print'></i> 인쇄하기 ("+resData.UserCntMap.outptCo+" / 20)");
					}
				},
				error:function(e){
					console.log(e);
					alert('updatePrintCnt 조회 실패' + e);
				}
			});
			//프린트 영역
			$("#info .scroll").print({
		        globalStyles : true,
		        mediaPrint : false,
		        iframe : true,
		        prepend: '<div id="printLogo" style="text-align:left;max-height: 50px;overflow: hidden;border-width: 1px 0 0 0px;border-color: #000;"><img src=\''+getContextPath()+'/css/gzonei/SRC/images/common/logo.svg\' width=\'65\'><span style="font-size: 20px;line-height: 50px;font-weight: bold;width: 100%;">　(주)지존</span><hr style="border: solid 1px black;display: inline-block;width: 30em;margin: 0 0 5px 20px;"></div>',
		        noPrintSelector : ".avoid-this",
		    });
		}
	});	
	//철도, 도로 면적 단위 변경 옵션
	$('#adDs2, #adDtlDs2, #adDs3, #adDtlDs3').on('change',function(e){
		var selectValUnit = e.currentTarget.options[e.currentTarget.selectedIndex].dataset.unitty;
		if(selectValUnit){
			var selForm = e.currentTarget.form;
			setUnitLabel(selForm.id,selectValUnit);
			areaAutoCal(selForm.bsnsArMeter);
		}
	});
	//프린트 횟수제한 이벤트
		
	
	//데이트 픽커 자동완성 비활성화
	$('.search--calendar input').attr("autocomplete","off");
	
	//recDevInfoLogHist();
	var lon = $('#lon').val();
	var lat = $('#lat').val();
	if(lon != null && lon !=''){
		devInfoListSearch('search',lon,lat);
		areaSetup();
	}else{
		devInfoListSearch('init',null,null);
	}
	//사업지구 하위 Depth Level 기본값(안보이게)
	$('#ds2, #ds3, #ds4').css('display','none');
	$('#adDs2, #adDs3').css('display','none');
	//프린트
	
	
	//추진내역 default 숨기기
	$('#prtnDetailContentsDiv').css('display','none');
	$('#prtnInsrtContentsDiv').css('display','none');
	//개발정보 검색(버튼)
	$('#listSearch').on('click',function(e){
		//devInfoListSearch('search',null,null);
	});
	//개발사업 등록 면적계산 onchange
	$('#devInfoAdminInsrtForm [name="bsnsArMeter"]').on('change',function(e){
		areaAutoCal(e.currentTarget);
	});
	
	$('#devInfoAdminDtlForm [name="bsnsArMeter"]').on('change',function(e){
		areaAutoCal(e.currentTarget);
	});
	
	//시행사 선택시 입력창
	$('#devInfoAdminInsrtForm [name="adCp1"]').on('change',function(e){
		if($('#devInfoAdminInsrtForm [name="adCp1"]').val() == "CP01010000"){
			$('#devInfoAdminInsrtForm [name="opertnCmpny"]').attr('type','text');
		}else{
			$('#devInfoAdminInsrtForm [name="opertnCmpny"]').attr('type','hidden');
		}
		$('#devInfoAdminInsrtForm [name="opertnCmpny"]').val('');
	});
	$('#devInfoAdminDtlForm [name="adDtlCp1"]').on('change',function(e){
		if($('#devInfoAdminDtlForm [name="adDtlCp1"]').val() == "CP01010000"){
			$('#devInfoAdminDtlForm [name="opertnCmpny"]').attr('type','text');
		}else{
			$('#devInfoAdminDtlForm [name="opertnCmpny"]').attr('type','hidden');
		}
		$('#devInfoAdminDtlForm [name="opertnCmpny"]').val('');
	});
	//라디오버튼 액션
	
	$('.dwkOthbcAtRadio').on('click',function(e){
		//권한 -- 개발정보 전시 (수정)
		if(checkAuthValue('dev005004','infoDspyAt') == "Y"){
			if(e.currentTarget.innerText =="공개"){
				$("#devInfoAdminInsrtForm input:radio[id='insrtDwkOthbcAtY']").prop("checked", true);
				$("#devInfoAdminDtlForm input:radio[id='dtlDwkOthbcAtY']").prop("checked", true);
			}else{
				$("#devInfoAdminInsrtForm input:radio[id='insrtDwkOthbcAtN']").prop("checked", true);
				$("#devInfoAdminDtlForm input:radio[id='dtlDwkOthbcAtN']").prop("checked", true);
			}
			console.log($('#devInfoAdminInsrtForm input:radio[name="dwkOthbcAt"]:checked').val());
		}
	});
	$('.smpleInqireRadio').on('click',function(e){
		if(e.currentTarget.innerText =="공개"){
			$("#devInfoAdminInsrtForm input:radio[id='insrtSmpleInqireAtY']").prop("checked", true);
			$("#devInfoAdminDtlForm input:radio[id='dtlSmpleInqireAtY']").prop("checked", true);
		}else{
			$("#devInfoAdminInsrtForm input:radio[id='insrtSmpleInqireAtN']").prop("checked", true);
			$("#devInfoAdminDtlForm input:radio[id='dtlSmpleInqireAtN']").prop("checked", true);
		}
		console.log($('#devInfoAdminInsrtForm input:radio[name="smpleInqireAt"]:checked').val());
	});
/*	$('#showInsrtBtn').on('click',function(e){
		$('#devlopInfoInsrtModal').css('display','block');
		$('#devlopInfoDetailModal').css('display','none');
	});*/			
	//개발사업 정보 목록(버튼) -- 관리자
	$('#devInfoAdminListBtn ,#devInfoAdminSchBtn').on('click',function(e){
		//검색, 초기화 시 무조건 1페이지부터
		document.devInfoAdminListForm.pageIndex.value = '1';
		devInfoAdminList();
	});
	//개발사업 정보 등록 페이지 열기 (버튼) -- 관리자
	$('#devInfoAdminShowInsrtPage').on('click',function(e){
		//showDevInfoInsrt();
		//sideShow('devInfoAdminInsrt');
		//파일첨부 리스트 초기화
		$('#file-form-upload-insrt').html(initInsrtHtml());
		//사업비,용지비 한글 초기화
		clearWctLct();
		
		$("#sideAdmin").toggleClass('moveTo');
		
		swal("원하는 위치에 주소를 입력해주세요.", {
			  content: "input",
		  	   buttons: {
				    cancel: true,
				    confirm: true,
				  },
			})
			.then(function (value) {
				switch (value) {
				case null:
					swal("입력 취소", "현 위치에서 작업을 계속 해주십시오.", "info");
					insrtLayer('gz_devlop_info');
			    	break;
			    default:
			    	if(value == ''){
			    		 insrtLayer('gz_devlop_info');
			    	}else{
			    		naver.maps.Service.geocode({
					        query: value
					    }, function(status, response) {
					        if (status !== naver.maps.Service.Status.OK) {
					            return  swal("입력 주소 오류!", "주소가 잘못 되어 이동을 못 했습니다.", "warning"); 
					        }else{
					        	var result = response.v2, // 검색 결과의 컨테이너
					            items = result.addresses; // 검색 결과의 배열
					        	if(items.length != 0){
					        		var center = ol.proj.transform([Number(items[0].x),Number(items[0].y)],'EPSG:4326','EPSG:3857')
									map.getView().setCenter(center);
					        	}else{
					        		swal("입력 주소 오류!", "주소가 잘못 되어 이동을 못 했습니다.", "warning");
					        	}
					        }
					        insrtLayer('gz_devlop_info');
					    });
			    	}
				}
			});
		
		
	});
	//개발사업 정보 등록 (버튼) -- 관리자
	$('#devInfoAdminInsrtBtn').on('click',function(e){
		devlopInfoInsrt();
	});
	//취소버튼 목록으로 -- 관리자
	$('#devInfoAdminCancleBtn, #devInfoAdDtlCancleBtn').on('click',function(e){
		removeInteraction("viewLayer", "edit");
		sideShow('devInfoAdminList');
		
		//추진내역 등록/상세보기 닫기
		$('#devAdPrtnDtl').css('display','none');
		$('#devAdPrtnInsrt').css('display','none');
		//추진내역 등록 수정창 닫기
		$('.devInfoAdPrtn').css('display','none');
		$('#deleteLayer').css('display','none');
		//개발정보&추진내역 폼초기화
		$('#devInfoAdminInsrtForm')[0].reset();
		$('#devInfoAdminDtlForm')[0].reset();
		$('#adPrtnListForm')[0].reset();
	});
	//개발사업 정보 상세보기 (테이블 목록 클릭) -- 관리자
	$('#devinfoAdminListContent').on('click','tr',function(e){
		/*$('#file-form-upload-dtl .devInfoAdminFormG').remove();
		$('#file-form-upload-dtl .form-input__addon').remove();*/
		//파일첨부 리스트 초기화
		$('#file-form-upload-dtl').html(initDtlHtml());
		//사업비,용지비 onkeyup 초기화
		clearWctLct();
		devlopInfoDetail(e.currentTarget.id);
		sideShow('devInfoAdminDtl');
	});
	//관리자 상세보기 -> 사용자 상세보기창으로 이동
	$('#devInfoAdDtlShowDtlBtn').on('click',function(e){
		var devInfoSn = $('#devInfoAdminDtlForm input[name="devlopInfoSn"]').val();
		devInfoDtl(devInfoSn,'in');
	});
	
	
	//레이어 수정 버튼
	$('#devInfoAdDtlLayerBtn').on('click',function(e){
		devInfoAdDtlLayerUpdate();
	});
	//개발정보 내용 수정 버튼
	$('#devInfoAdDtlUpdateBtn').on('click',function(e){
		devInfoAdDtlUpdate();
	});
	//개발정보 삭제 버튼
	$('#devInfoAdDtlDelBtn').on('click',function(e){
		//권한 -- 개발정보 상세 - 미분류(삭제)
		if(checkAuth('dev003002','infoDelAt',"")){
			devlopInfoDelete();
		}
	});
	//추진내역 등록 --관리자
	$('#showPrtnInsrtBtn').on('click',function(e){
		$('#devAdPrtnInsrt').css('display','block');
		$('#devAdPrtnDtl').css('display','none');
		$('.prtnClCodeDiv').css('display','block');
		showPrtnInsrt();
		//클릭시 스크롤 이동
		scrollAnimate('devAdPrtnInsrt',700);
	});
	//추진내역 상세보기 --관리자
	$('#prtnDtlContents').on('click','tr',function(e){
		$('#devAdPrtnDtl').css('display','block');
		$('#devAdPrtnInsrt').css('display','none');
		showPrtnDtl(e.currentTarget.id);
		//클릭시 스크롤 이동
		scrollAnimate('devAdPrtnDtl',700);
	});
	//추진내역 등록폼/상세보기 없애기 (버튼) -- 관리자
	$('#adInsrtPrtnCancle, #adDtlPrtnCanle').on('click',function(e){
		$('#devAdPrtnDtl').css('display','none');
		$('#devAdPrtnInsrt').css('display','none');
		//추진내역 등록 수정창 닫기
		$('.devInfoAdPrtn').css('display','none');
	});
	//추진내역 정보 등록 (버튼) -- 관리자
	$('#adInsrtPrtnInsrt').on('click',function(e){
		prtnInsrt();
	});
	//추진내역 정보 수정 (버튼) -- 관리자
	$('#adDtlPrtnUpdate').on('click',function(e){
		prtnUpdate();
	});
	//추진내역 정보 삭제 (버튼) -- 관리자
	$('#adDtlPrtnDelete').on('click',function(e){
		//권한 -- 추진내역 - 목록 (삭제)
		if(checkAuth('dev004001','infoDelAt',"")){
			PrtnDelete();
		}
	});
	//개발사업 정보 수정 (버튼) -- 관리자
	$('#devlopInfoUpdateBtn').on('click',function(e){
		devlopInfoUpdate();
	});
	//개발사업 정보 삭제 (버튼) -- 관리자
	$('#devlopInfoDeleteBtn').on('click',function(e){
		devlopInfoDelete();
	});
	//----------------------사용자 START------------------------
	$('#devInfoUserBtn').on('click',function(e){
		//권한 -- 검색
		if(checkAuthValue('dev001001','infoInqireAt') =="Y"){
			//아이디를 parameter로
			var area1 = $('#area1 option:selected').val();
			var area2 = $('#area2 option:selected').val();
			var moreBtnTxt = $('#devInfoMore button').html();
			if(area1 != null && area1 != ''&& area2 != null && area2 != '' || checkAuthValue('dev001003','infoInqireAt') == "Y"){
				//검색시 무조건 1페이지로
				document.devInfoInfoListForm.pageIndex.value = '1';
				devInfoListSearch('search',null,null);
			}else{
				swal("시군구까지 선택해주세요", "검색 범위가 넓습니다", "warning");
			}
		}else{
			swal("정보 조회 권한이 없는 등급입니다", "권한이 부족합니다", "warning");
		}
		
	});
	//개발사업정보 상세보기>레이어로 줌,최근열람사업에 추가 -- 사용자
	$('.searchResult__obj').on('click','div.item',function(e){
		if (!$("#info").hasClass('moveTo')) {
    		$("#info").toggleClass('moveTo');
		}
		//권한 -- 목록
		if(checkAuthValue("dev001002","infoInqireAt")=="Y"){
		//if(authVO.dev001002.infoInqireAt =="Y"){
			//아이디를 parameter로
			zoomLayer(e.currentTarget.id,"gz_devlop_info");
		}/*else{
			swal("정보 조회 권한이 없는 등급입니다", "권한이 부족합니다", "warning");
		}*/
	});
	//개발사업정보 상세보기 > 투자정보 -- 사용자
	$('#infoObject').on('click',function(e){
		//준공여부
		var smpleAt = e.currentTarget.dataset.smpleat;
		if(checkAuthValue("ivt001001","infoInqireAt")=="Y" || smpleAt == "Y"){
			if(smpleAt == 'Y'){
				invListSearch(document.devInfoDtlForm.dwkNo.value,null,'Y');
			}else{
				invListSearch(document.devInfoDtlForm.dwkNo.value);
			}
		}else{
			swal("정보 조회 권한이 없는 등급입니다.","권한이 부족합니다.","warning");
		}
	});
	//개발사업정보 상세보기 > 관련기사 --- 사용자
	$('#infoParagraph').on('click',function(e){
		//아이디를 parameter로
		devInfoArticle(document.devInfoDtlForm.dwkNm.value);
	});
	$('#infoAdd').on('click',function(e){
		//$('#devInfoModifyGroup').css('display','block');
		devInfoIntrst(document.devInfoDtlForm.dwkNo.value);
		$('#modalIntrst').modal({backdrop: false,keyboard:false});
	});
	$('#devInfoIntrstAddBtn').on('click',function(e){
		devInfoIntrstInsrt(document.devInfoDtlForm.dwkNo.value);
	});
	$('#devInfoIntrstGroupBtn').on('click',function(e){
		window.open(getContextPath()+"/mypage/interestList.do");
		$('#modalIntrst').modal('hide');
	})
	
	//상세정보(첨부파일 다운로드)
	$('#devInfoDtl_fileList').on('click','a', function(e){
		//첨부파일 권한
		var dataSet = e.currentTarget.dataset;
		if(checkAuthValue('dev005002','infoInqireAt')=="Y" || dataSet.smpleauth == 'Y' || dataSet.dschkval == 'true'){
			attFileDown(dataSet.url);
		}else{
			swal('첨부파일 다운로드 권한이 없는 등급입니다.','권한이 부족합니다.','warning');
		}
	});
	//추진내역,향후추진내역 첨부파일 다운로드
	$('#devInfoDtl_prtnList, #devInfoDtl_prtnPlanList').on('click','a', function(e){
		//첨부파일 권한
		var dataSet = e.currentTarget.dataset;
		if(dataSet.auth == 'Y' || dataSet.smpleauth == 'Y' || dataSet.dschkval == 'true'){
			attFileDown(dataSet.url);
		}else{
			swal('첨부파일 다운로드 권한이 없는 등급입니다.','권한이 부족합니다.','warning');
		}
	});
	//----------------------사용자 END------------------------
	
	//추진내역 코드
	$('.prtnSeCode').on('change',function(e){
		if($(this).val() == "CM00170002"){
			$(".prtnClCodeDiv").css('display','none');
			$(".prtnClCode").val('');
		}else{
			$(".prtnClCodeDiv").css('display','block');
			$(".prtnClCode").children('option').remove();
			$(".prtnClCode").val('');
			var resultList = getCodeAjax('CMMN','CM00340000');
			var sortClCodeList = resultList.codeList.sort(function(a, b) {
			    return a.sortOrdr < b.sortOrdr ? -1 : a.sortOrdr > b.sortOrdr ? 1 : 0;
			});
			switch(e.currentTarget.id){
				case "adDtlPrtnSeCode":
					devInfoOptionset(sortClCodeList,'adDtlPrtnClCode','선택','없음');
					break;
				case "adInsrtPrtnSeCode":
					devInfoOptionset(sortClCodeList,'adInsrtPrtnClCode','선택','없음');
					break;
			}
		}
	});
	//지역1선택시 지역2 select 생성 이벤트
	$('.area1, .area2, .invArea1, .invArea2, .AdmArea1, .adArea1, .adDtlArea1, .invAdmArea1, .invAdmAreaAdd1, .invAdmAreaAddDtl1, .devArea1, .nwsArea1, .rwdArea1, .bestDevArea1').on('change',function(e){
      var target = e.currentTarget; 
      var idOnly = target.id.substring(0,target.id.length-1);
      var lastInt = parseInt(target.id.charAt(target.id.length-1));
      var nextInt = lastInt + 1;
      var selectTagId = target.parentElement.parentElement.querySelectorAll('.'+idOnly+lastInt)[0].id;
      //지역1에 대한 지역2 리스트 생성
      var resultData = getCodeAjax('AREA',$(this).val());
      if(resultData.length != 0){
         var sortCodeList = resultData.codeList.sort(function(a, b) {
            return a.lowestAreaNm < b.lowestAreaNm ? -1 : a.lowestAreaNm > b.lowestAreaNm ? 1 : 0;
         });
         devInfoOptionset(sortCodeList,idOnly+nextInt,'전체','없음');
         if(resultData.codeList.length ==0){
            if(lastInt == 1){
               var emptyList = [];
               devInfoOptionset(emptyList,idOnly+3,'전체','없음');
            }
         }
      }
   });
	//보상시작년도 전체 선택시 기간도 전체로 바꾸는 이벤트
	$('.rwYr').on('change',function(e){
		var id = e.currentTarget.id;
		if($('#'+id).val()==""){
			$('#'+id+'Range').val('');
		}
	});
	
	//사업지구 select 생성 이벤트
	$('.ds1, .ds2, .ds3, .cp1, .adCp1, .adDtlCp1, .invDs1, .invDs2, .invDs3, .adDs1, .adDs2, .adDtlDs1, .adDtlDs2').on('change',function(e){
		var target = e.currentTarget; 
		var idOnly = target.id.substring(0,target.id.length-1);
		var lastInt = parseInt(target.id.charAt(target.id.length-1))+1;
		var nextInt = lastInt + 1;
		var selectTagId = target.parentElement.parentElement.querySelectorAll('.'+idOnly+lastInt)[0].id;
		//사업지구에 대한 리스트 생성
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
				var sortCodeList = resultData.codeList.sort(function(a, b) {
				    return a.sortOrdr < b.sortOrdr ? -1 : a.sortOrdr > b.sortOrdr ? 1 : 0;
				});
				if(idOnly == "adCp1" || idOnly == "adDtlCp1"){
					devInfoOptionset(sortCodeList,selectTagId,'선택','없음');
				}else{
					devInfoOptionset(sortCodeList,selectTagId,'전체','없음');
				}
				$('#'+selectTagId).css('display','block');
				if(lastInt==2){
					$('#'+selectTagId.slice(0,-1)+3).val('');
					$('#'+selectTagId.slice(0,-1)+3).css('display','none');
				}
			}
		}
	});
	
	
});

// ================================  관리자  START =============================
function devInfoAdminList(){
	var paginationDiv = $('#devInfoAdminListPagination');
	paginationInit(paginationDiv);
	//Page index
	//var params = $('#listForm').serializeArray();
	var params = $('#devInfoAdminListForm').serializeArray();
	var dataHtml='';
	var resData; 
	//$('.wrap-loading').removeClass('display-none');
	$.ajax({
        type : 'POST',
        url : getContextPath()+"/devlopInfo/selectAdminList.do",
        async: false,
        datatype : 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        data: params,
        success : function(data){ 
        	resData = JSON.parse(data);
        	var sortArea1List = resData.area1List.sort(function(a, b) {
        	    return a.sortOrdr < b.sortOrdr ? -1 : a.sortOrdr > b.sortOrdr ? 1 : 0;
        	});
        	
        	devInfoOptionset(sortArea1List,'AdmArea1','전체',resData.searchVO.area1);
        	//devInfoOptionset(sortArea1List,'AdmArea1','전체','없음');
/*	    		var dsCodeListAll = resData.dsCodeListAll.sort(function(a, b) {
	    			return a.codeIdNm < b.codeIdNm ? -1 : a.codeIdNm > b.codeIdNm ? 1 : 0;
	    		});
	        	var cpCodeList = resData.cpCodeList.sort(function(a, b) {
	        	    return a.codeIdNm < b.codeIdNm ? -1 : a.codeIdNm > b.codeIdNm ? 1 : 0;
	        	});
	        	if(initVal == 'init'){
	        		devInfoOptionset(sortArea1List,'area1','전체','없음');
	        		devInfoOptionset(resData.dsCodeList,'ds1','전체','없음');
	        		devInfoOptionset(cpCodeList,'cp1','전체','없음');
	        		devInfoOptionset(resData.cmCodeList,'rw1','전체','없음');
	        		//투자정보(정선)OptionSet 추가
	        		devInfoOptionset(sortArea1List,'invArea1','전체','없음');
	        		devInfoOptionset(resData.dsCodeList,'invDs1','전체','없음');
	        	}else{*/
        		if(resData.resultList!=null && resData.resultList.length!=0){
		        	resData.resultList.forEach(function(data, index){ 
		        		//지역1,지역2 코드명
		            	var area1_val = devInfoCodeSet(resData.area1List,data.upperMapCode);
		            	if(area1_val =="undefined" || area1_val == null){
		            		area1_val = "";
		            	}
		        		var area2_val = devInfoCodeSet(getCodeAjax('AREA',data.upperMapCode).codeList,data.mapCode);
		        		if(area2_val =="undefined" || area2_val == null){
		        			area2_val = "";
		            	}
		        		var dwkOthbcAt = '';
		        		if(data.dwkOthbcAt == "Y"){
		        			dwkOthbcAt = "공개";
	        			}else{
	        				dwkOthbcAt = "비공개";
        				}
		        		
		        		dataHtml += "<tr id='" + data.devlopInfoSn + "' style='cursor: pointer;'>"
		        			dataHtml += "<th scope='row'>" + data.dwkNo + "</th>"
	        				dataHtml += "<td>" + data.dwkNm + "</td>"
	        				dataHtml += "<td>" + dwkOthbcAt + "</td>"
	        				dataHtml += "<td>" + area1_val + "</td>"
        					dataHtml += "<td>" + area2_val + "</td>"
    						dataHtml += "<td>" + data.frstRegisterId + "</td>"
							dataHtml += "<td>" + toStrDate(data.frstRegistPnttm) + "</td>"
							dataHtml += "<td>" + toStrDate(data.lastUpdtPnttm) + "</td>"
						dataHtml += "</tr>";
		        	});
		        	
		        	makeDevInfoAdminPagination(paginationDiv,resData.resultListTotCnt,resData.paginationInfo.currentPageNo, 10);
	        	}else{
	        		dataHtml += "<tr>"
        				dataHtml += "<td onclick='event.cancelBubble=true' colspan='7'>검색 결과가 없습니다</td>"
					dataHtml += "</tr>"
	        	}
	        	$('#devInfoAdminTotalCount').html(addComma(resData.resultListTotCnt));
	        	$('#devinfoAdminListContent').html(dataHtml);
        	//}
        },
        error:function(e){
        	console.log(e);
        	alert('devlopinfo_Admin_list_조회 실패' + e);
    	},complete:function(){
        	//$('.wrap-loading').addClass('display-none');
    		flag = true;
    	}
    });
}
//상세보기 -- 관리자
function devlopInfoDetail(devlopInfoSn){
	//폼 초기화
	$('#devInfoAdminDtlForm')[0].reset();
	$('#devInfoAdminDtlForm input[name="atchFileId"]').val('');
	$('#devInfoAdminDtlForm input[name="thumbFileId"]').val('');
	//Page index
	var params = [];
	params.push({name:'devlopInfoSn',value:devlopInfoSn});
	var dataHtml;
	var resData; 
	
	$.ajax({
        type : 'POST',
        url : getContextPath()+"/devlopInfo/selectDetail.do",
        async: false,
        datatype : 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        data: params,
        success : function(data){
        	resData = JSON.parse(data);
        	var sortArea1List = resData.area1List.sort(function(a, b) {
        	    return a.sortOrdr < b.sortOrdr ? -1 : a.sortOrdr > b.sortOrdr ? 1 : 0;
        	});
        	var dsCodeList = resData.dsCodeList.sort(function(a, b) {
        		return a.sortOrdr < b.sortOrdr ? -1 : a.sortOrdr > b.sortOrdr ? 1 : 0;
        	});
        	//시행사
    		var cpCodeList = resData.cpCodeList.sort(function(a, b) {
        	    return a.sortOrdr < b.sortOrdr ? -1 : a.sortOrdr > b.sortOrdr ? 1 : 0;
        	});
        	//지역1,지역2 코드명
        	var area1_val = devInfoCodeSet(resData.area1List,resData.resultList.upperMapCode);
    		//var area2_val = devInfoCodeSet(getCodeAjax('AREA',resData.resultList.upperMapCode).codeList,resData.resultList.mapCode);
        	//지역 (시도,시군구)
    		devInfoOptionset(sortArea1List,'adDtlArea1','선택',resData.resultList.upperMapCode);
    		devInfoOptionset(getCodeAjax('AREA',resData.resultList.upperMapCode).codeList,'adDtlArea2','선택',resData.resultList.mapCode);
    		//사업지구 코드 3댑스
    		var dsL1;
    		var dsL2;
    		var dsL3;
    		var dsL1SelVal = '';
    		var dsL2SelVal = '';
    		var dsL3SelVal = '';
    		var selCd1Val;
    		dsCodeList.forEach(function(d,i){
    			if(d.codeId == resData.resultList.bsnsDstrcCode){
    				if(d.codeLevel == "1"){
    					dsL3 = getCodeAjax('DSTRC_UPCD',d.codeId);
    					dsL2 = getCodeAjax('DSTRC_UPCD',d.upperCodeId);
    					dsL2SelVal = d.codeId;
    					selCd1Val = getCodeAjax('DSTRC_CD',d.upperCodeId);
    				}else if(d.codeLevel == "2"){
    					dsL3 = getCodeAjax('DSTRC_UPCD',d.upperCodeId);
    					dsL3SelVal = d.codeId;
    					var selCd2Val = getCodeAjax('DSTRC_CD',d.upperCodeId);
    					dsL2 = getCodeAjax('DSTRC_UPCD',selCd2Val.codeList[0].upperCodeId);
    					dsL2SelVal = selCd2Val.codeList[0].codeId;
    					selCd1Val = getCodeAjax('DSTRC_CD',selCd2Val.codeList[0].upperCodeId);
    				}
    				if(selCd1Val.codeList!=null && selCd1Val.codeList.length !=0){
    					dsL1 = getCodeAjax('DSTRC_UPCD',selCd1Val.codeList[0].upperCodeId);
    					dsL1SelVal = selCd1Val.codeList[0].codeId;
    				}
    			}
    		});
    		devInfoOptionset(dsL1.codeList,'adDtlDs1','선택',dsL1SelVal);
    		devInfoOptionset(dsL2.codeList,'adDtlDs2','선택',dsL2SelVal);
    		if(dsL3){
    			devInfoOptionset(dsL3.codeList,'adDtlDs3','전체',dsL3SelVal);
    		}
    		
    		//시행사 코드 2댑스
    		var cpList1;
    		var cpList2;
    		var cp1UpCodeVal = '';
    		var cp2UpCodeVal = '';
    		if(resData.resultList.opertnCmpnyCode !=null && resData.resultList.opertnCmpnyCode != ""){
    			cpCodeList.forEach(function(d,i){
        			if(d.codeId == resData.resultList.opertnCmpnyCode){
        				if(d.codeLevel == "1"){
        					cp1UpCodeVal = d.codeId;
        					cpList1 = getCodeAjax('CMMN_UPCD',d.upperCodeId);
        				}else{
        					var cp2Val = getCodeAjax('CMMN_CD',d.codeId);
        					cp2UpCodeVal = cp2Val.codeList[0].codeId;
        					cpList2 = getCodeAjax('CMMN_UPCD',d.upperCodeId);
        					var cp1Val = getCodeAjax('CMMN_CD',d.upperCodeId);
        					cp1UpCodeVal = cp1Val.codeList[0].codeId;
        					cpList1 = getCodeAjax('CMMN_UPCD',cp1Val.codeList[0].upperCodeId);
        				}
    				}
    			});
    			if(cpList1){
    				devInfoOptionset(cpList1.codeList,'adDtlCp1','선택',cp1UpCodeVal);
    			}
    			if(cpList2){
    				devInfoOptionset(cpList2.codeList,'adDtlCp2','선택',cp2UpCodeVal);
    			}
    		}else{
    			devInfoOptionset(cpCodeList,'adDtlCp1','선택','없음');
    		}
    		
			
    		if($('#devInfoAdminDtlForm [name="adDtlCp1"]').val() == "CP01010000"){
    			if(cp2UpCodeVal == ""){
    				$('#devInfoAdminDtlForm [name="adDtlCp2"]').css('display','none');
    			}
    			$('#devInfoAdminDtlForm [name="opertnCmpny"]').attr('type','text');
    		}else{
    			$('#devInfoAdminDtlForm [name="opertnCmpny"]').attr('type','hidden');
    			$('#devInfoAdminDtlForm [name="opertnCmpny"]').val('');
    		}
    		
    		//사업방식
    		devInfoOptionset(resData.mtCodeList,'adDtlBsnsMthdCode','선택',resData.resultList.bsnsMthdCode);
    		//예상보상상태
    		devInfoOptionset(resData.cmCodeList,'adDtlExpectRewardCode','선택',resData.resultList.expectRewardCode);
    		
        	document.devInfoAdminDtlForm.applcLaw.value = resData.resultList.applcLaw;
        	document.devInfoAdminDtlForm.bsnsArMeter.value = addComma(resData.resultList.bsnsArMeter);
        	document.devInfoAdminDtlForm.bsnsArPyeong.value = addComma(resData.resultList.bsnsArPyeong);
        	setUnitLabel('devInfoAdminDtlForm',resData.resultList.unitTy);
        	
        	//내용 엔터 제거        	
        	var aplyBsnsCn = adRbAply('\\r\\n',resData.resultList.bsnsCn);
        	document.devInfoAdminDtlForm.bsnsCn.value = aplyBsnsCn;
        	document.devInfoAdminDtlForm.bsnsMthdCode.value = resData.resultList.bsnsMthdCode;
        	document.devInfoAdminDtlForm.bsnsrcognNtfcNm.value = resData.resultList.bsnsrcognNtfcNm;
        	document.devInfoAdminDtlForm.chrgDept.value = resData.resultList.chrgDept;
        	document.devInfoAdminDtlForm.dwkNm.value = resData.resultList.dwkNm;
        	document.devInfoAdminDtlForm.dwkOthbcAt.value = resData.resultList.dwkOthbcAt;
        	document.devInfoAdminDtlForm.expectRewardCode.value = resData.resultList.expectRewardCode;
        	//지존멘트 엔터 제거
        	var aplyGment = adRbAply('\\r\\n',resData.resultList.gzMent);
        	document.devInfoAdminDtlForm.gzMent.value = aplyGment;
        	document.devInfoAdminDtlForm.opertnCmpny.value = resData.resultList.opertnCmpny;
        	document.devInfoAdminDtlForm.wrterOpinion.value = resData.resultList.wrterOpinion;
        	document.devInfoAdminDtlForm.addr.value = resData.resultList.addr;
        	document.devInfoAdminDtlForm.expectRewardEra.value = addDash(resData.resultList.expectRewardEra);
        	document.devInfoAdminDtlForm.mngrLastUpdtPnttm.value = addDash(resData.resultList.mngrLastUpdtPnttm);
        	
        	//공개여부
        	if(resData.resultList.dwkOthbcAt == "Y"){
				$("#devInfoAdminDtlForm input:radio[id='dtlDwkOthbcAtY']").prop("checked", true);
			}else{
				$("#devInfoAdminDtlForm input:radio[id='dtlDwkOthbcAtN']").prop("checked", true);
			}
        	//우리동네 공개여부
        	if(resData.resultList.smpleInqireAt == "Y"){
    			$("#devInfoAdminDtlForm input:radio[id='dtlSmpleInqireAtY']").prop("checked", true);
        	}else{
    			$("#devInfoAdminDtlForm input:radio[id='dtlSmpleInqireAtN']").prop("checked", true);
        	}
        	
        	if(resData.resultList.atchFileId != "old"){
	    		//대표이미지 썸네일 첨부파일 -- 05.25
	        	var thumbFileResult = getThumbFilesAjax("gz_devlop_info",resData.resultList.thumbFileId);
	        	if(thumbFileResult.atchFiles!=null &&thumbFileResult.atchFiles.length !=0){
        			document.devInfoAdminDtlForm.thumbFileNm.value = thumbFileResult.atchFiles[0].orignlFileNm;
	        	}
	        	//첨부파일
	        	var fileResult = getFilesAjax("gz_devlop_info",resData.resultList.atchFileId);
	        	//if(fileResult != ''){
	        		//임시
            	if(fileResult.atchFiles!=null && fileResult.atchFiles.length!=0){
            		fileResult.atchFiles.forEach(function(dat,dex){
	        			document.devInfoAdminDtlForm.atchFileNm.value = fileResult.atchFiles[0].orignlFileNm;
	        			var num = dex+1;
        				if(num != 1){
        					$('#file-form-upload-dtl').append(getDtlHtml(num));
        				}
        				$('#DtlAtchFile_'+num).siblings().val(dat.orignlFileNm);
	        		});
            	}
            	//Form에 첨부파일 + 썸네일 아이디 넣기
            	document.devInfoAdminDtlForm.thumbFileId.value = resData.resultList.thumbFileId;
	        	document.devInfoAdminDtlForm.atchFileId.value = resData.resultList.atchFileId;
        	}else{
	        	if(resData.oldFileMap!=null && resData.oldFileMap.length!=0){
	        		var fMap = resData.oldFileMap;
	        		if(fMap.fileNm){
	        			if(!fMap.fileDisNm){
	        				fMap.fileDisNm = 'titleImg';
	        				document.devInfoAdminDtlForm.thumbFileId.value = "";
	    	        		document.devInfoAdminDtlForm.thumbFileNm.value = fMap.fileNm;
	        			}
	        		}
	        		var fileMapList = [];
	        		var newMap = {fileNm:'',filePath:'',fileDisNm:''};
	        		for(let key in fMap){
	        			if(key.includes('fileNm')){
	        				newMap.fileNm=fMap[key];
	        			}else if(key.includes('filePath')){
	        				newMap.filePath=fMap[key];
	        			}else if(key.includes('fileDisNm')){
	        				newMap.fileDisNm=fMap[key];
	        				fileMapList.push(newMap);
	        				newMap = {fileNm:'',filePath:'',fileDisNm:''};
	        			}
	        		}
	        		fileMapList.forEach(function(dat,dex){
	        			var num = dex+1;
	        			if(dat.fileNm != ""){
	        				if(dat.fileDisNm !="titleImg"){
	        					 if(num != 1){
	        						 $('#file-form-upload-dtl').append(getDtlHtml(num));
	        					 }
	        					$('#DtlAtchFile_'+num).siblings().val(dat.fileDisNm); 
	        				}
	        			}
	        		});
	        		document.devInfoAdminDtlForm.atchFileId.value = "old";
	        	}
        	}
        	
        	//UUID
        	document.devInfoAdminDtlForm.devlopInfoSn.value = resData.resultList.devlopInfoSn;
        	document.devInfoAdminDtlForm.dwkNo.value = resData.resultList.dwkNo;
        	document.devInfoAdminDtlForm.wkt.value = resData.resultList.wkt;
        	if(resData.resultList.bsnsBgnde){
        		document.devInfoAdminDtlForm.bsnsBgnde.value = addDash(resData.resultList.bsnsBgnde);
        	}
        	if(resData.resultList.bsnsEndde){
        		document.devInfoAdminDtlForm.bsnsEndde.value = addDash(resData.resultList.bsnsEndde);
        	}
        	if(resData.resultList.dscssRewardBeginDe){
        		document.devInfoAdminDtlForm.dscssRewardBeginDe.value = addDash(resData.resultList.dscssRewardBeginDe);
        	}
        	/*if(resData.resultList.bsnsrcognNtfcDe){
        		document.devInfoAdminDtlForm.bsnsrcognNtfcDe.value = addDash(resData.resultList.bsnsrcognNtfcDe);
        	}*/
        	if(resData.resultList.wct){
        		document.devInfoAdminDtlForm.wct.value = addComma(resData.resultList.wct);
        		$('#dtlWctStr').html(numberToKorean(Number(resData.resultList.wct)));
        	}
        	if(resData.resultList.lct){
        		document.devInfoAdminDtlForm.lct.value = addComma(resData.resultList.lct);
        		$('#dtlLctStr').html(numberToKorean(Number(resData.resultList.lct)));
        	}
        	
        	//추진내역에도 개발사업 일련번호 추가
        	document.adPrtnListForm.devlopInfoSn.value = resData.resultList.devlopInfoSn;
        	//추진내역 등록시 필요한 개발사업번호/개발사업정보UUID
        	document.devAdPrtnInsrtForm.devlopInfoSn.value = resData.resultList.devlopInfoSn;
        	document.devAdPrtnDtlForm.devlopInfoSn.value = resData.resultList.devlopInfoSn;
        	
        	
        	prtnListSearch(resData.resultList.devlopInfoSn);
        },
        error:function(e){
        	console.log(e);
        	alert('devlopinfo_Detail_조회 실패' + e);
    	}
	});
}
/*//상세보기 -- 관리자
function devlopInfoDetail(devlopInfoSn){
	//Page index
	var params = {'devlopInfoSn' : devlopInfoSn};
	var dataHtml;
	var resData; 
	
	$.ajax({
		type : 'POST',
		url : getContextPath()+"/devlopInfo/selectDetail.do",
		async: false,
		datatype : 'json',
		contentType: 'application/x-www-form-urlencoded;charset=utf-8',
		data: params,
		success : function(data){
			resData = JSON.parse(data);
			$('#devlopInfoDetailModal').css('display','block');
			
			var sortArea1List = resData.area1List.sort(function(a, b) {
				return a.lowestAreaNm < b.lowestAreaNm ? -1 : a.lowestAreaNm > b.lowestAreaNm ? 1 : 0;
			});
			var dsCodeList = resData.dsCodeList.sort(function(a, b) {
				return a.lowestAreaNm < b.lowestAreaNm ? -1 : a.lowestAreaNm > b.lowestAreaNm ? 1 : 0;
			});
			
			//지역1,지역2 코드명
			var area1_val = devInfoCodeSet(resData.area1List,resData.resultList.upperMapCode);
			//var area2_val = devInfoCodeSet(getCodeAjax('AREA',resData.resultList.upperMapCode).codeList,resData.resultList.mapCode);
			
			devInfoOptionset(sortArea1List,'detailArea1','전체',resData.resultList.upperMapCode);
			devInfoOptionset(getCodeAjax('AREA',resData.resultList.upperMapCode).codeList,'detailArea2','전체',resData.resultList.mapCode);
			devInfoOptionset(resData.dsCodeList,'detailDsCodeList','사업지구',resData.resultList.bsnsDstrcCode);
			
			document.detailForm.applcLaw.value = resData.resultList.applcLaw;
			document.detailForm.bsnsArMeter.value = resData.resultList.bsnsArMeter;
			document.detailForm.bsnsArPyeong.value = resData.resultList.bsnsArPyeong;
			document.detailForm.bsnsCn.value = resData.resultList.bsnsCn;
			document.detailForm.bsnsMthdCode.value = resData.resultList.bsnsMthdCode;
			document.detailForm.bsnsrcognNtfcNm.value = resData.resultList.bsnsrcognNtfcNm;
			document.detailForm.chrgDept.value = resData.resultList.chrgDept;
			document.detailForm.dwkNm.value = resData.resultList.dwkNm;
			document.detailForm.dwkOthbcAt.value = resData.resultList.dwkOthbcAt;
			document.detailForm.expectRewardCode.value = resData.resultList.expectRewardCode;
			document.detailForm.gzMent.value = resData.resultList.gzMent;
			document.detailForm.opertnCmpny.value = resData.resultList.opertnCmpny;
			document.detailForm.wrterOpinion.value = resData.resultList.wrterOpinion;
			//UUID
			document.detailForm.devlopInfoSn.value = resData.resultList.devlopInfoSn;
			//추진내역에도 개발사업 일련번호 추가
			document.prtnListForm.devlopInfoSn.value = resData.resultList.devlopInfoSn;
			//추진내역 등록시 필요한 개발사업번호/개발사업정보UUID
			document.detailForm.dwkNo.value = resData.resultList.dwkNo;
			document.prtnInsrtForm.devlopInfoSn.value = resData.resultList.devlopInfoSn;
			
			prtnListSearch();
		},
		error:function(e){
			console.log(e);
			alert('devlopinfo_Detail_조회 실패' + e);
		}
	});
}
*///개발정보 등록페이지 보기 -- 관리자
function showDevInfoInsrt(){
	$('#devInfoAdminInsrtForm')[0].reset();
	$('#devInfoAdminInsrtForm input[name="atchFileId"]').val('');
	$('#devInfoAdminInsrtForm input[name="thumbFileId"]').val('');
	var dataHtml;
	var resData;
	$.ajax({
        type : 'POST',
        url : getContextPath()+"/devlopInfo/showDevInfoInsert.do",
        async: false,
        datatype : 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        success : function(data){
        	var resData = JSON.parse(data);
        	//사업지구코드 (1 lv)
        	var dsCodeListLow = [];
        	resData.dsCodeListAll.forEach(function(data,index){
        		if(data.codeLevel == "0"){
        			dsCodeListLow.push(data);
        		}
        	});
        	dsCodeListLow = dsCodeListLow.sort(function(a, b) {
        		return a.sortOrdr < b.sortOrdr ? -1 : a.sortOrdr > b.sortOrdr ? 1 : 0;
        	});
        	devInfoOptionset(dsCodeListLow,'adDs1','선택','없음');
        	//지역코드
        	var sortArea1List = resData.area1List.sort(function(a, b) {
        	    return a.sortOrdr < b.sortOrdr ? -1 : a.sortOrdr > b.sortOrdr ? 1 : 0;
        	});
        	devInfoOptionset(sortArea1List,'adArea1','선택','없음');
    		//시행사코드
        	var cpCodeList = resData.cpCodeList.sort(function(a, b) {
        	    return a.sortOrdr < b.sortOrdr ? -1 : a.sortOrdr > b.sortOrdr ? 1 : 0;
        	});
        	
        	devInfoOptionset(cpCodeList,'adCp1','선택','없음');
        	//devInfoCodeSet(getCodeAjax('AREA',data.upperMapCode).codeList,data.mapCode);
        	
        	if($('#devInfoAdminInsrtForm [name="adCp1"]').val() == "CP01010000"){
        		$('#devInfoAdminDtlForm [name="adCp2"]').css('display','none');
    			$('#devInfoAdminInsrtForm [name="opertnCmpny"]').attr('type','text');
    		}else{
    			$('#devInfoAdminInsrtForm [name="opertnCmpny"]').attr('type','hidden');
    			$('#devInfoAdminInsrtForm [name="opertnCmpny"]').val('');
    		}
        	
        	//사업방식
        	devInfoOptionset(resData.mtCodeList,'adBsnsMthdCode','선택','없음');
        	//보상 상태
        	devInfoOptionset(resData.cmCodeList,'adExpectRewardCode','선택','없음');
        	
        },
        error:function(e){
        	console.log(e);
        	alert('devinfo_Insrt_등록페이지 실패' + e);
    	}
	});
}


//개발정보 등록 -- 관리자
function devlopInfoInsrt(){
	//숫자에 ,특수문자 빼기
	var wct = $('#devInfoAdminInsrtForm input[name="wct"]');
	var lct = $('#devInfoAdminInsrtForm input[name="lct"]');
	var bsnsArPyeong = $('#devInfoAdminInsrtForm input[name="bsnsArPyeong"]');
	var bsnsArMeter = $('#devInfoAdminInsrtForm input[name="bsnsArMeter"]');
	wct.val(wct.val().replace(/,/gi,''));
	lct.val(lct.val().replace(/,/gi,''));
	bsnsArPyeong.val(bsnsArPyeong.val().replace(/,/gi,''));
	bsnsArMeter.val(bsnsArMeter.val().replace(/,/gi,''));
	//날짜형식 대쉬 제거
	var expectRewardEra = $('#devInfoAdminInsrtForm input[name="expectRewardEra"]');
	var mngrLastUpdtPnttm = $('#devInfoAdminInsrtForm input[name="mngrLastUpdtPnttm"]');
	var bsnsBgnde = $('#devInfoAdminInsrtForm input[name="bsnsBgnde"]');
	var bsnsEndde = $('#devInfoAdminInsrtForm input[name="bsnsEndde"]');
	var dscssRewardBeginDe = $('#devInfoAdminInsrtForm input[name="dscssRewardBeginDe"]');
	//var bsnsrcognNtfcDe = $('#devInfoAdminInsrtForm input[name="bsnsrcognNtfcDe"]');
	expectRewardEra.val(expectRewardEra.val().replace(/-/gi,''));
	mngrLastUpdtPnttm.val(mngrLastUpdtPnttm.val().replace(/-/gi,''));
	bsnsBgnde.val(bsnsBgnde.val().replace(/-/gi,''));
	bsnsEndde.val(bsnsEndde.val().replace(/-/gi,''));
	dscssRewardBeginDe.val(dscssRewardBeginDe.val().replace(/-/gi,''));
	//bsnsrcognNtfcDe.val(bsnsrcognNtfcDe.val().replace(/-/gi,''));
			
	var paramsCheck = $('#devInfoAdminInsrtForm').serializeArray();
	
	var chkVal = true;
	paramsCheck.forEach(function(data, index){
		if(data.value =="" || data.value==null || data.value=="undefined" || data.value==undefined){
			if(data.name !="geom" && data.name !="adDs3" && data.name !="opertnCmpny"){
				//임시 -- 필수입력사항 체크해제
				switch(data.name){
					case "area1":
					case "area2":
					case "adDs1":
					case "adDs2":
					case "dwkNm":
					case "bsnsCn":
					/*case "bsnsArPyeong":
					case "bsnsArMeter":
					case "opertnCmpnyCode":
					case "opertnCmpny":
					case "applcLaw":
					case "bsnsMthdCode":
					case "bsnsrcognNtfcNm":
					case "chrgDept":
					case "wrterOpinion":
					case "gzMent":
					case "expectRewardCode":
					case "expectRewardEra":
					case "lastUpdtPnttm":
					case "dwkOthbcAt":
					case "smpleInqireAt":
					case "atchFileNm":*/
					swal("필수입력사항을 확인해주세요", "필수입력사항 중 비어있는 값이 있습니다", "error");
					chkVal = false;
					break;
				}
			}
		}
	});
	if(chkVal){
		var dataHtml;
		var resData;
		var yn = confirm("등록하시겠습니까?");
		if(yn){
			//썸네일, 파일 업로드
			var form = $('#devInfoAdminInsrtForm')[0];
			var formData = new FormData(form);
			//21.05.24 작업 ---------------------- 썸네일작업
			if($('#devInfoAdminInsrtForm input[name="thumbFileNm"]').val() != ""){
				var reThumbFileId = thumbFileUpload(formData);
				$('#devInfoAdminInsrtForm input[name="thumbFileId"]').val(reThumbFileId);
			}
			if(""!=form[name='atchFile_1'].value){
				var returnFileId = fileUpload(formData);
				$('#devInfoAdminInsrtForm input[name="atchFileId"]').val(returnFileId);
			}
			var params = $('#devInfoAdminInsrtForm').serializeArray();
			
			$.ajax({
				type : 'POST',
				url : getContextPath()+"/devlopInfo/insertDetail.do",
				async: false,
				datatype : 'json',
				contentType: 'application/x-www-form-urlencoded;charset=utf-8',
				data: params,
				success : function(data){
					resData = JSON.parse(data);
					if(resData.insertResult == 1){
						swal('등록완료','개발정보를 등록하였습니다','success');
						//등록폼 초기화=====================
						$('#devInfoAdminInsrtForm')[0].reset();
						removeInteraction("viewLayer", "edit");
						sideShow('devInfoAdminList');
						devInfoAdminList();
						//등록 후 상세보기 바로열기==============
						$('#file-form-upload-dtl').html(initDtlHtml());
						//사업비,용지비 onkeyup 초기화
						clearWctLct();
						devlopInfoDetail(resData.resultMap.devlopInfoSn);
						sideShow('devInfoAdminDtl');
						//스크롤 상단으로 이동
						$("#sideAdmin .scroll").scrollTop(0);
					}else{
						swal('등록실패','개발정보를 등록하지 못하였습니다','error');
					}
					
				},
				error:function(e){
					console.log(e);
					alert('devlopinfo_Insrt_등록 실패' + e);
				}
			});
		}
	}
}
/*function devlopInfoInsrt(){
	var params = $('#InsrtForm').serializeArray();
	var dataHtml;
	var resData;
	var yn = confirm("등록하시겠습니까?");
	if(yn){
		$.ajax({
			type : 'POST',
			url : getContextPath()+"/devlopInfo/InsrtDetail.do",
			async: false,
			datatype : 'json',
			contentType: 'application/x-www-form-urlencoded;charset=utf-8',
			data: params,
			success : function(data){
				resData = JSON.parse(data);
				if(resData.InsrtResult == 1){
					alert('등록완료');
					listSearch();
				}else{
					alert('등록실패');
				}
				$('#devlopInfoInsrtModal').css('display','none');
			},
			error:function(e){
				console.log(e);
				alert('devlopinfo_Insrt_등록 실패' + e);
			}
		});
	}
}
*/
//개발정보 레이어 수정 -- 관리자
function devInfoAdDtlLayerUpdate(){
	// 레이어수정
	swal({
		  title: "개발지구를 수정 하시겠습니까?",
		  text: "개발지구의 면적을 수정 하실수 있습니다.",
		  icon: "info",
		  buttons: ["취소", "이동"]
		})
		.then(function(result) {
		  if (result) {
			  //초기화
			  $("#searchResult").hide();
			  $("#info").hide();
			  overlay.setPosition(undefined);
		  	  closer.blur();
			  removeInteraction("viewLayer", "edit");
			  $("#sideAdmin").toggleClass('moveTo');
			  var wkt = document.devInfoAdminDtlForm.wkt.value;
			  var format = new ol.format.WKT();
			  var feature = format.readFeature(wkt, {
				dataProjection: 'EPSG:3857',
				featureProjection: 'EPSG:3857'
			  });
			  feature.set("mapId",'gz_devlop_info');
			  var layerSource = new ol.source.Vector();
	          layerSource.addFeature(feature);
	          var vector = new ol.layer.Vector ({
            	  source: layerSource, 
            	  id: 'gz_devlop_info',
            	  name: 'gz_devlop_info',
            	  layerType : 'viewLayer'
        	});
	        map.addLayer(vector);
	        setFeatureStyle(feature, "select");
	        var extent = feature.getGeometry().getExtent();
		 	var view = map.getView();
		    var coordinate = ol.extent.getCenter(extent);
		    view.setCenter(coordinate);
		    view.setZoom(17);
		    $('#deleteLayer').css('display','block');
		    var select = new ol.interaction.Select({
		        condition: ol.events.condition.never

		    });
		    select.getFeatures().push(feature);
		    /*mode와 name에 관한 properties 입력*/
		    select.setProperties({mode: "edit"});

		    map.addInteraction(select);
		    
		    var modify = new ol.interaction.Modify({
		        features: select.getFeatures()
		    });
			
			modify.setProperties({mode: "edit"});
			
			map.addInteraction(modify);
			
			modify.on('modifystart', function (e) {
		        var features = e.features.array_;
		        $.each(features, function(key, val){
		            val.revision_ = 0;
		        });
		    });
			
			modify.on('modifyend', function (e) {
		        var features = e.features.array_;
		        var setWkt = format.writeGeometry(e.features.array_[0].getGeometry());
		        document.devInfoAdminDtlForm.wkt.value = setWkt;
		    });
		  }
		});
}
//개발정보 수정 -- 관리자
function devInfoAdDtlUpdate(){
	var yn = confirm("수정하시겠습니까?");
	if(yn){
		//용지비 용적비 콤마 제거
		var wct = $('#devInfoAdminDtlForm input[name="wct"]');
		var lct = $('#devInfoAdminDtlForm input[name="lct"]');
		var bsnsArPyeong = $('#devInfoAdminDtlForm input[name="bsnsArPyeong"]');
		var bsnsArMeter = $('#devInfoAdminDtlForm input[name="bsnsArMeter"]');
		wct.val(wct.val().replace(/,/gi,''));
		lct.val(lct.val().replace(/,/gi,''));
		bsnsArPyeong.val(bsnsArPyeong.val().replace(/,/gi,''));
		bsnsArMeter.val(bsnsArMeter.val().replace(/,/gi,''));
		//날짜형식 대쉬 제거
		var expectRewardEra = $('#devInfoAdminDtlForm input[name="expectRewardEra"]');
		var mngrLastUpdtPnttm = $('#devInfoAdminDtlForm input[name="mngrLastUpdtPnttm"]');
		var bsnsBgnde = $('#devInfoAdminDtlForm input[name="bsnsBgnde"]');
		var bsnsEndde = $('#devInfoAdminDtlForm input[name="bsnsEndde"]');
		var dscssRewardBeginDe = $('#devInfoAdminDtlForm input[name="dscssRewardBeginDe"]');
		//var bsnsrcognNtfcDe = $('#devInfoAdminDtlForm input[name="bsnsrcognNtfcDe"]');
		expectRewardEra.val(expectRewardEra.val().replace(/-/gi,''));
		mngrLastUpdtPnttm.val(mngrLastUpdtPnttm.val().replace(/-/gi,''));
		bsnsBgnde.val(bsnsBgnde.val().replace(/-/gi,''));
		bsnsEndde.val(bsnsEndde.val().replace(/-/gi,''));
		dscssRewardBeginDe.val(dscssRewardBeginDe.val().replace(/-/gi,''));
		//bsnsrcognNtfcDe.val(bsnsrcognNtfcDe.val().replace(/-/gi,''));
		
		//파일첨부가 있는경우
		/*var form = $('#devAdPrtnDtlForm')[0];
		if(""!=form[name='atchFile_1'].value){
			var inputFormData = new FormData(form);
			//파일업로드
			var returnFileId = fileUpload(inputFormData);
			//var returnFileId = fileUpload($('#devAdPrtnInsrtForm').serializeArray());
			document.devAdPrtnDtlForm.atchFileId.value = returnFileId;
		}else{
			document.devAdPrtnDtlForm.atchFileId.value = '';
		}*/
		//파일업로드
		var form = $('#devInfoAdminDtlForm')[0];
		var formData = new FormData(form);
		if($('#devInfoAdminDtlForm input[name="atchFileId"]').val() != "old"){
			//21.05.24 작업중 ---------------------- 썸네일작업
			var reThumbFileId = thumbFileUpload(formData);
			document.devInfoAdminDtlForm.thumbFileId.value = reThumbFileId;
			
			//개발정보 파일첨부
			var returnFileId = fileUpload(formData);
			document.devInfoAdminDtlForm.atchFileId.value = returnFileId;
		}else{
			//old_썸네일 파일첨부
			var reThumbFileId = oldThumbFileUpload(formData);
			document.devInfoAdminDtlForm.thumbFileId.value = "";
			
			//old_개발정보 파일첨부
			var returnFileId = oldFileUpload(formData);
			document.devInfoAdminDtlForm.atchFileId.value = "old";
		}
		var params = $('#devInfoAdminDtlForm').serializeArray();
		//라디오버튼 체크값
		var dwkOthbcAtVal = $('#devInfoAdminDtlForm input:radio[name="dwkOthbcAt"]:checked').val();
		var smpleInqireAtVal = $('#devInfoAdminDtlForm input:radio[name="smpleInqireAt"]:checked').val();
		params.push({name:'dwkOthbcAt',value:dwkOthbcAtVal});
		params.push({name:'smpleInqireAt',value:smpleInqireAtVal});
		
		
		var chkVal = true;
		params.forEach(function(data, index){
			if(data.value =="" || data.value==null || data.value=="undefined" || data.value==undefined){
				//if(data.name !="geom" && data.name !="opertnCmpny"){
				if(data.name !="geom" && data.name !="adDs3" && data.name !="opertnCmpny"){
					if(data.name =="opertnCmpnyCode" && data.value ==""){
						//시행사(선택시)
						params.push({name:'opertnCmpnyCode',value:'CP01010000'});
					}else{
						//필수입력사항 체크해제
						/*swal("필수입력사항을 확인해주세요", "필수입력사항 중 비어있는 값이 있습니다", "error");
						chkVal = false;*/
					}
					/*switch(data.name){
					case "area1":
					case "area2":
					case "dwkNm":
					case "bsnsCn":
					case "addr":
					case "bsnsArPyeong":
					case "bsnsArMeter":
					case "opertnCmpnyCode":
					case "opertnCmpny":
					case "applcLaw":
					case "bsnsMthdCode":
					case "bsnsrcognNtfcNm":
					case "chrgDept":
					case "wrterOpinion":
					case "gzMent":
					case "expectRewardCode":
					case "expectRewardEra":
					case "lastUpdtPnttm":
					case "dwkOthbcAt":
					case "smpleInqireAt":
					case "atchFileNm":
					swal("필수입력사항을 확인해주세요", "필수입력사항 중 비어있는 값이 있습니다", "error");
					//break;
					//}
					chkVal = false;*/
				}
			}
		});
		var dataHtml;
		var resData;
		if(chkVal){
			$.ajax({
				type : 'POST',
				url : getContextPath()+"/devlopInfo/updateDetail.do",
				async: false,
				datatype : 'json',
				contentType: 'application/x-www-form-urlencoded;charset=utf-8',
				data: params,
				success : function(data){
					resData = JSON.parse(data);
					if(resData.updateResult == 1){
						swal('수정완료','개발정보를 수정하였습니다','success');
						removeInteraction("viewLayer", "edit");
						sideShow('devInfoAdminList');
						devInfoAdminList();
						
					}else{
						swal('수정실패','개발정보를 수정하지 못하였습니다','error');
					}
					$('#deleteLayer').css('display','none');
					$('#devlopInfoDetailModal').css('display','none');
					$('#devlopInfoDetailModal').css('display','block');
				},
				error:function(e){
					console.log(e);
					alert('devlopinfo_Update_수정 실패' + e);
				}
			});
		}
	}
}
/*function devlopInfoUpdate(){
	var params = $('#detailForm').serializeArray();
	var dataHtml;
	var resData;
	var yn = swalConfirm("개발사업 수정","수정하시겠습니까?");
	if(yn){
		$.ajax({
			type : 'POST',
			url : getContextPath()+"/devlopInfo/updateDetail.do",
			async: false,
			datatype : 'json',
			contentType: 'application/x-www-form-urlencoded;charset=utf-8',
			data: params,
			success : function(data){
				resData = JSON.parse(data);
				if(resData.updateResult == 1){
					alert('수정완료');
					devInfoListSearch('search',null,null);
				}else{
					alert('수정실패');
				}
				$('#devlopInfoDetailModal').css('display','none');
				$('#devlopInfoDetailModal').css('display','block');
			},
			error:function(e){
				console.log(e);
				alert('devlopinfo_Update_수정 실패' + e);
			}
		});
	}
}
*///개발정보 삭제 -- 관리자
function devlopInfoDelete(){
	var params = $('#devInfoAdminDtlForm').serialize();
	var dataHtml;
	var resData;
	var yn = confirm("삭제하시겠습니까?");
	if(yn){
		$.ajax({
	        type : 'POST',
	        url : getContextPath()+"/devlopInfo/deleteDetail.do",
	        async: false,
	        datatype : 'json',
	        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
	        data: params,
	        success : function(data){
	        	resData = JSON.parse(data);
	        	if(resData.updateResult == 1){
	        		swal('삭제완료','개발정보를 삭제하였습니다','success');
	        		removeInteraction("viewLayer", "edit");
	        	}else{
	        		swal('삭제실패','개발정보를 삭제하지 못했습니다','error');
	        	}
	        	sideShow('devInfoAdminList');
	        	$('#deleteLayer').css('display','none');
	        	devInfoAdminList();
	        },
	        error:function(e){
	        	console.log(e);
	        	alert('devlopinfo_Detail_조회 실패' + e);
	    	}
		});
	}
}
/*function devlopInfoDelete(){
	var params = $('#detailForm').serialize();
	var dataHtml;
	var resData;
	var yn = confirm("삭제하시겠습니까?");
	if(yn){
		$.ajax({
			type : 'POST',
			url : getContextPath()+"/devlopInfo/deleteDetail.do",
			async: false,
			datatype : 'json',
			contentType: 'application/x-www-form-urlencoded;charset=utf-8',
			data: params,
			success : function(data){
				resData = JSON.parse(data);
				if(resData.updateResult == 1){
					alert('삭제완료');
				}else{
					alert('삭제실패');
				}
				devInfoListSearch('search',null,null);
				$('#devlopInfoDetailModal').css('display','none');
			},
			error:function(e){
				console.log(e);
				alert('devlopinfo_Detail_조회 실패' + e);
			}
		});
	}
}
*/
//추진내역 목록 -- 관리자
function prtnListSearch(devlopInfoSn){
	//Page index
	//var params = $('#adPrtnListForm').serializeArray();
	var paramsS = [];
	paramsS.push({name:'devlopInfoSn',value:devlopInfoSn});
	var dataHtml;
	$.ajax({
        type : 'POST',
        url : getContextPath()+"/devlopInfo/selectPrtnList.do",
        async: false,
        datatype : 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        data: paramsS,
        success : function(data){ 
        	var resData = JSON.parse(data);
        	
        	if(resData.resultList!=null && resData.resultList.length!=0){
        		resData.resultList.forEach(function(data, index){
        			var seCodeNm = devInfoCodeSet(resData.seCodeList,data.prtnSeCode);
        				
	        		dataHtml += "<tr id='" + data.bsnsPrtnSttusSn + "' style='cursor: pointer;'>";
	        		if(data.prtnBgnde!=""&&data.prtnBgnde!=null){
	    			dataHtml += "<td class='listtd'>" + strToDate(data.prtnBgnde) +"</td>";
	        		}else{
	    				dataHtml += "<td class='listtd'> </td>";
	    			}
	    			if(data.prtnEndde!=""&&data.prtnEndde!=null){
	    				dataHtml += "<td class='listtd'>" + strToDate(data.prtnEndde) + "</td>";
	    			}else{
	    				dataHtml += "<td class='listtd'> </td>";
	    			}
	    			dataHtml += "<td class='listtd'>" + data.sj + "</td>";
	    			dataHtml += "<td class='listtd'>" + data.relateKwrd + "</td>";
	    			dataHtml += "<td class='listtd'>" + seCodeNm + "</td>";
	    			if(data.atchFileId == "old"){
	    				if(data.fileNm){
	    					dataHtml += "<td class='listtd'>" + data.fileNm + "</td>";
	    				}else{
	    					dataHtml += "<td class='listtd'> </td>";
	    				}
	    			}else{
	    				var fileResult = getFilesAjax("gz_dwk_prtn_sttus",data.atchFileId);
	    	        	if(fileResult.atchFiles!=null && fileResult.atchFiles.length!=0 ){
	    	        		dataHtml += "<td class='listtd'>" + fileResult.atchFiles[0].orignlFileNm + "</td>";
	    	        	}else{
	    	        		dataHtml += "<td class='listtd'> </td>";
	    	        	}
	    			}
	    			dataHtml += "</tr>";
        		});
        	}else{
        		dataHtml += "<tr><td style='border: solid 1px ;text-align: center;'colspan='6'>없음</td></tr>";
        	}
        	$('#prtnDtlContents').html(dataHtml);
        },
        error:function(e){
        	console.log(e);
        	alert('prtn_devlopinfo_list_조회 실패' + e);
    	}
    });
}

//추진내역 등록 폼 보이기 -- 관리자
function showPrtnInsrt(){
	$('#devAdPrtnInsrtForm')[0].reset();
	$('#devAdPrtnInsrtForm input[name="atchFileId"]').val('');
	//dwkNo 개발사업번호
	document.devAdPrtnInsrtForm.dwkNo.value = document.devInfoAdminDtlForm.dwkNo.value;
	
	$.ajax({
	    type : 'POST',
	    url : getContextPath()+"/devlopInfo/showPrtnInsrt.do",
	    async: false,
	    datatype : 'json',
	    contentType: 'application/x-www-form-urlencoded;charset=utf-8',
	    success : function(data){
	    	resData = JSON.parse(data);
	    	//추진구분코드
    		devInfoOptionset(resData.seCodeList,'adInsrtPrtnSeCode','선택','없음');
			//추진분류코드
			devInfoOptionset(resData.clCodeList,'adInsrtPrtnClCode','선택','없음');
	    },error:function(e){
	    	console.log(e);
	    	alert('prtn_showInsrt_조회 실패' + e);
	    }
    });
	    
	
}

//추진내역 상세보기 보이기 -- 관리자
function showPrtnDtl(bsnsPrtnSttusSn){
	$('#devAdPrtnDtlForm')[0].reset();
	$('#devAdPrtnDtlForm input[name="atchFileId"]').val('');
	//dwkNo 개발사업번호
	document.devAdPrtnDtlForm.dwkNo.value = document.devInfoAdminDtlForm.dwkNo.value;
	var params = [];
	params.push({name:'bsnsPrtnSttusSn',value:bsnsPrtnSttusSn});
	
	if(params.bsnsPrtnSttusSn != ""){
		var dataHtml;
		var resData; 
		$.ajax({
		    type : 'POST',
		    url : getContextPath()+"/devlopInfo/selectPrtnDetail.do",
		    async: false,
		    datatype : 'json',
		    contentType: 'application/x-www-form-urlencoded;charset=utf-8',
		    data: params,
		    success : function(data){
		    	resData = JSON.parse(data);
		    	if(resData.resultList!=null && resData.resultList.length!=0){
			    	//추진구분코드
		    		devInfoOptionset(resData.seCodeList,'adDtlPrtnSeCode','선택',resData.resultList.prtnSeCode);
		    		if(resData.resultList.prtnSeCode != "CM00170002"){
		    			//추진분류코드
		    			devInfoOptionset(resData.clCodeList,'adDtlPrtnClCode','선택',resData.resultList.prtnClCode);
		    			$(".prtnClCodeDiv").css('display','block');
		    		}else{
		    			$(".prtnClCodeDiv").css('display','none');
		    		}
		    		
			    	document.devAdPrtnDtlForm.dwkNo.value = resData.resultList.dwkNo;
			    	document.devAdPrtnDtlForm.sj.value = resData.resultList.sj;
			    	document.devAdPrtnDtlForm.prtnBgnde.value = addDash(resData.resultList.prtnBgnde);
			    	//document.devAdPrtnDtlForm.prtnEndde.value = addDash(resData.resultList.prtnEndde);
			    	document.devAdPrtnDtlForm.relateKwrd.value = resData.resultList.relateKwrd;
			    	
			    	//파일 아이디로 조회
			    	if(resData.resultList.atchFileId != "old"){
			    		var fileResult = getFilesAjax("gz_dwk_prtn_sttus",resData.resultList.atchFileId);
			    		//임시
			    		if(fileResult.atchFiles!=null && fileResult.atchFiles.length!=0 ){
			    			document.devAdPrtnDtlForm.atchFileNm.value = fileResult.atchFiles[0].orignlFileNm;
			    			document.devAdPrtnDtlForm.atchFileId.value = fileResult.atchFiles[0].atchFileId;
			    		}else{
			    			document.devAdPrtnDtlForm.atchFileNm.value = "";
			    			document.devAdPrtnDtlForm.atchFileId.value = "";
			    		}
			    	}else{
			    		if(resData.resultList.fileNm){
			    			document.devAdPrtnDtlForm.atchFileNm.value = resData.resultList.fileNm;
			    		}
		    			document.devAdPrtnDtlForm.atchFileId.value = "old";
			    	}
			    	
			    	//document.devAdPrtnDtlForm.atchFileId.value = resData.fileList[0].orignlFileNm;
			    	//UUID
			    	document.devAdPrtnDtlForm.bsnsPrtnSttusSn.value = resData.resultList.bsnsPrtnSttusSn;
			    	document.devAdPrtnDtlForm.devlopInfoSn.value = resData.resultList.devlopInfoSn;
			    	
			    	prtnListSearch(resData.resultList.devlopInfoSn);
		    	}
		    },error:function(e){
		    	console.log(e);
		    	alert('prtn_Devlopinfo_Detail_조회 실패' + e);
			}
		});
	}else{
		swal('추진내역이 없습니다','추진내역이 없습니다','warning');
		$('#devAdPrtnDtl').css('display','none');
	}
}
//추진내역 등록 -- 관리자
function prtnInsrt(){
	
	//개발정보 Sn 추가
	var devlopInfoSn = $('#devInfoAdminDtlForm input[name="devlopInfoSn"]').val();
	$('#devAdPrtnInsrtForm input[name="devlopInfoSn"]').val(devlopInfoSn);
	//날짜형식 바꾸기
	var bgnde = $('#adInsrtPrtnBgnde');
	//var endde = $('#adInsrtPrtnEndde');
	var insrtBsnsBgnde = $('#insrtBsnsBgnde');
	//var insrtBsnsEndde = $('#insrtBsnsEndde');
	var insrtDscssRewardBeginDe = $('#insrtDscssRewardBeginDe');
	//var insrtBsnsrcognNtfcDe = $('#insrtBsnsrcognNtfcDe');
	bgnde.val(bgnde.val().replace(/-/gi,''));
	//endde.val(endde.val().replace(/-/gi,''));
	insrtBsnsBgnde.val(insrtBsnsBgnde.val().replace(/-/gi,''));
	//insrtBsnsEndde.val(insrtBsnsEndde.val().replace(/-/gi,''));
	insrtDscssRewardBeginDe.val(insrtDscssRewardBeginDe.val().replace(/-/gi,''));
	//insrtBsnsrcognNtfcDe.val(insrtBsnsrcognNtfcDe.val().replace(/-/gi,''));
	
	//파일첨부가 있는경우
	var form = $('#devAdPrtnInsrtForm')[0];
	
	//$('#devAdPrtnInsrtForm input[name="atchFileId"]').val()
	if(""!=form[name='atchFile_1'].value){
		//파일업로드
		var inputFormData = new FormData(form);
		var returnFileId = fileUpload(inputFormData);
		document.devAdPrtnInsrtForm.atchFileId.value = returnFileId;
	}else{
		document.devAdPrtnInsrtForm.atchFileId.value = '';
	}
	var params = $('#devAdPrtnInsrtForm').serializeArray();
	var dataHtml;
	var resData;
	var yn = confirm("등록하시겠습니까?");
	if(yn){
		$.ajax({
	        type : 'POST',
	        url : getContextPath()+"/devlopInfo/insertPrtnDetail.do",
	        async: false,
	        datatype : 'json',
	        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
	        data: params,
	        success : function(data){
	        	resData = JSON.parse(data);
	        	if(resData.updateResult == 1){
	        		swal('등록완료','추진내역을 등록하였습니다','success');
	        		prtnListSearch(devlopInfoSn);
	        		//등록폼 리셋
	        		$('#devAdPrtnInsrtForm')[0].reset();
	        		$('#devAdPrtnInsrtForm input[name="atchFileId"]').val('');
	        	}else{
	        		swal('등록실패','추진내역을 등록하지 못하였습니다','error');
	        	}
	        },
	        error:function(e){
	        	console.log(e);
	        	alert('prtn_Devlopinfo_Insrt_등록 실패' + e);
	    	}
		});
	}
}
//파일업로드 -- 관리자
function fileUpload(formData){
	var resultFileId;
	var dataHtml;
	var resData;
	$.ajax({
		type : 'POST',
		url : getContextPath()+"/devlopInfo/fileUpload.do",
		async: false,
		datatype : 'json',
		processData: false,
		contentType: false,
		enctype: 'multipart/form-data',
		data: formData,
		success : function(data){
			resData = JSON.parse(data);
			if(""!=resData.atchFileId){
				resultFileId = resData.atchFileId;
			}else{
				alert('파일 업로드실패');
			}
		},
		error:function(e){
			console.log(e);
			alert('파일 업로드실패' + e);
			$('#devAdPrtnInsrtForm input[name="atchFileId"]').val('');
			$('#devAdPrtnDtlForm input[name="atchFileId"]').val('');
			$('#devAdPrtnInsrt').css('display','none');
			$('#devAdPrtnDtl').css('display','none');
		}
	});
	return resultFileId;
}
//썸네일 업로드
function thumbFileUpload(formData){
	var resultThumbFileId;
	var dataHtml;
	var resData;
	$.ajax({
		type : 'POST',
		url : getContextPath()+"/devlopInfo/thumbFileUpload.do",
		async: false,
		datatype : 'json',
		processData: false,
		contentType: false,
		enctype: 'multipart/form-data',
		data: formData,
		success : function(data){
			resData = JSON.parse(data);
			if(""!=resData.thumbFileId){
				resultThumbFileId = resData.thumbFileId;
			}else{
				alert('썸네일 파일 업로드실패');
			}
		},
		error:function(e){
			console.log(e);
			alert('썸네일 파일 업로드실패' + e);
			$('#devInfoAdminInsrtForm input[name="thumbFileId"]').val('');
			$('#devInfoAdminDtlForm input[name="thumbFileId"]').val('');
			
		}
	});
	return resultThumbFileId;
}
//Old 파일업로드 -- 관리자 (개발정보 - 첨부파일)
function oldFileUpload(formData){
	var dataHtml;
	var resData;
	$.ajax({
		type : 'POST',
		url : getContextPath()+"/devlopInfo/oldFileUpload.do",
		async: false,
		datatype : 'json',
		processData: false,
		contentType: false,
		enctype: 'multipart/form-data',
		data: formData,
		success : function(data){
			resData = JSON.parse(data);
		},
		error:function(e){
			console.log(e);
			alert('old_파일 업로드실패' + e);
			$('#devAdPrtnInsrtForm input[name="atchFileId"]').val('');
			$('#devAdPrtnDtlForm input[name="atchFileId"]').val('');
		}
	});
}

//Old 파일업로드 -- 관리자 (개발정보 - 첨부파일)
function oldPrtnFileUpload(formData){
	var dataHtml;
	var resData;
	$.ajax({
		type : 'POST',
		url : getContextPath()+"/devlopInfo/oldPrtnFileUpload.do",
		async: false,
		datatype : 'json',
		processData: false,
		contentType: false,
		enctype: 'multipart/form-data',
		data: formData,
		success : function(data){
			resData = JSON.parse(data);
		},
		error:function(e){
			console.log(e);
			alert('old_파일 업로드실패' + e);
			$('#devAdPrtnInsrtForm input[name="atchFileId"]').val('');
			$('#devAdPrtnDtlForm input[name="atchFileId"]').val('');
		}
	});
}

//old_썸네일 업로드 -- 관리자 (개발정보 - 썸네일 첨부)
function oldThumbFileUpload(formData){
	var resultThumbFileId = '';
	var dataHtml;
	var resData;
	$.ajax({
		type : 'POST',
		url : getContextPath()+"/devlopInfo/oldThumbFileUpload.do",
		async: false,
		datatype : 'json',
		processData: false,
		contentType: false,
		enctype: 'multipart/form-data',
		data: formData,
		success : function(data){
			resData = JSON.parse(data);
		},
		error:function(e){
			console.log(e);
			alert('old_썸네일 파일 업로드실패' + e);
			$('#devInfoAdminInsrtForm input[name="thumbFileId"]').val('');
			$('#devInfoAdminDtlForm input[name="thumbFileId"]').val('');
			
		}
	});
	return resultThumbFileId;
}


//추진내역 수정 -- 관리자
function prtnUpdate(){
	var yn = confirm("수정하시겠습니까?");
	if(yn){
		//개발정보 Sn 추가
		var devlopInfoSn = $('#devInfoAdminDtlForm input[name="devlopInfoSn"]').val();
		$('#devAdPrtnDtlForm input[name="devlopInfoSn"]').val(devlopInfoSn);
		//날짜형식 바꾸기
		var bgnde = $('#adDtlPrtnBgnde');
		//var endde = $('#adDtlPrtnEndde');
		bgnde.val(bgnde.val().replace(/-/gi,''));
		//endde.val(endde.val().replace(/-/gi,''));
		//파일첨부가 있는경우
		var form = $('#devAdPrtnDtlForm')[0];
		var formData = new FormData(form);
		
		if($('#devAdPrtnDtlForm input[name="atchFileId"]').val() != "old"){
			var returnFileId = fileUpload(formData);
			document.devAdPrtnDtlForm.atchFileId.value = returnFileId;
		}else{
			var returnFileId = oldPrtnFileUpload(formData);
			document.devAdPrtnDtlForm.atchFileId.value = "old";
		}
		/*if(""!=form[name='atchFile_1'].value){
			var inputFormData = new FormData(form);
			//파일업로드
			var returnFileId = fileUpload(inputFormData);
			//var returnFileId = fileUpload($('#devAdPrtnInsrtForm').serializeArray());
			document.devAdPrtnDtlForm.atchFileId.value = returnFileId;
		}else{
			document.devAdPrtnDtlForm.atchFileId.value = '';
		}*/
		var params = $('#devAdPrtnDtlForm').serializeArray();
		var dataHtml;
		var resData;
		
		$.ajax({
	        type : 'POST',
	        url : getContextPath()+"/devlopInfo/updatePrtnDetail.do",
	        async: false,
	        datatype : 'json',
	        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
	        data: params,
	        success : function(data){
	        	resData = JSON.parse(data);
	        	if(resData.updateResult == 1){
	        		swal('수정완료','추진내역을 수정하였습니다','success');
	        		prtnListSearch(devlopInfoSn);
	        	}else{
	        		swal('수정실패','추진내역을 수정하지 못하였습니다','error');
	        	}
	        	$('#prtnDetailContentsDiv').css('display','none');
	        	$('#prtnDetailContentsDiv').css('display','block');
	        },
	        error:function(e){
	        	console.log(e);
	        	alert('prtn_Devlopinfo_Update_수정 실패' + e);
	    	}
		});
	}
}
//추진내역 삭제 -- 관리자
function PrtnDelete(){
	var params = $('#devAdPrtnDtlForm').serialize();
	
	var dataHtml;
	var resData;
	var yn = confirm("삭제하시겠습니까?");
	if(yn){
		$.ajax({
	        type : 'POST',
	        url : getContextPath()+"/devlopInfo/deletePrtnDetail.do",
	        async: false,
	        datatype : 'json',
	        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
	        data: params,
	        success : function(data){
	        	resData = JSON.parse(data);
	        	if(resData.updateResult == 1){
	        		swal('삭제완료','추진내역을 삭제하였습니다','success');
	        		prtnListSearch(document.adPrtnListForm.devlopInfoSn.value);
	        		$('#devAdPrtnDtl').css('display','none');
	        	}else{
	        		swal('삭제실패','추진내역을 삭제하지 못하였습니다','error');
	        	}
	        	$('#prtnDetailContentsDiv').css('display','none');
	        },
	        error:function(e){
	        	console.log(e);
	        	alert('prtn_Devlopinfo_Delete_삭제 실패' + e);
	    	}
		});
	}
}
// ============================ 관리자 END ===========================
//============================ 사용자 START ===========================
//개발사업정보 목록 -- 사용자
/*function startDevInfoSearch(){
	if(checkAuthValue('dev001001','infoInqireAt') =="Y"){
		//아이디를 parameter로
		var area1 = $('#area1 option:selected').val();
		var area2 = $('#area2 option:selected').val();
		var moreBtnTxt = $('#devInfoMore button').html();
		if(area1 != null && area1 != ''&& area2 != null && area2 != '' || checkAuthValue('dev001003','infoInqireAt') == "Y"){
			//검색시 무조건 1페이지로
			document.devInfoInfoListForm.pageIndex.value = '1';
			devInfoListSearch('search',null,null);
		}else{
			swal("시군구까지 선택해주세요", "검색 범위가 넓습니다", "warning");
		}
	}else{
		swal("정보 조회 권한이 없는 등급입니다", "권한이 부족합니다", "warning");
	}
}*/

function devInfoListTopSearch(initVal,lon,lat){
	$('#info').css('display','none');
	//Page index
	//var params = $('#listForm').serializeArray();
	//var params = $('#devInfoInfoListForm').serializeArray();
	var params = [];
	params.push({name:'pageIndex',value:$('#keyPageIndex').val()});
	params.push({name:'textSearch',value:$('#searchKeyword').val()});
	params.push({name:'initVal',value:initVal});
	
	if(lon!=null){
		//params 좌표를 뺀 나머지 조건 초기화
		params=[];
		params.push({name:'initVal',value:initVal});
		params.push({name:'lon',value:lon});
		params.push({name:'lat',value:lat});
		//페이징
	}
	
	var dataHtml='';
	var resData; 
	//var resultValChk = false;
	$('.wrap-loading').removeClass('display-none');
	setTimeout(function() {
		$.ajax({
	        type : 'POST',
	        url : getContextPath()+"/devlopInfo/selectList.do",
	        async: false,
	        datatype : 'json',
	        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
	        data: params,
	        success : function(data){ 
	        	resData = JSON.parse(data);
	        	var sortArea1List = resData.area1List.sort(function(a, b) {
	        	    return a.sortOrdr < b.sortOrdr ? -1 : a.sortOrdr > b.sortOrdr ? 1 : 0;
	        	});
	    		var dsCodeListAll = resData.dsCodeListAll.sort(function(a, b) {
	    			return a.sortOrdr < b.sortOrdr ? -1 : a.sortOrdr > b.sortOrdr ? 1 : 0;
	    		});
	    		var dsCodeList = resData.dsCodeList.sort(function(a, b) {
	    			return a.sortOrdr < b.sortOrdr ? -1 : a.sortOrdr > b.sortOrdr ? 1 : 0;
	    		});
	        	var cpCodeList = resData.cpCodeList.sort(function(a, b) {
	        	    return a.codeIdNm < b.codeIdNm ? -1 : a.codeIdNm > b.codeIdNm ? 1 : 0;
	        	});
	        	
	        	if(initVal == 'init'){
	        		devInfoOptionset(sortArea1List,'area1','전체','없음');
	        		devInfoOptionset(dsCodeList,'ds1','전체','없음');
	        		devInfoOptionset(cpCodeList,'cp1','전체','없음');
	        		devInfoOptionset(resData.cmCodeList,'rw1','전체','없음');
	        		//투자정보(정선)OptionSet 추가
	        		devInfoOptionset(resData.cmCodeList,'rewardAt','전체','없음');
	        		devInfoOptionset(sortArea1List,'invArea1','전체','없음');
	        		devInfoOptionset(dsCodeList,'invDs1','전체','없음');
	        	}else{
	        		if(resData.resultList!=null && resData.resultList.length!=0){
	        			//resultValChk == true;
		        		if(initVal!='pageOnly'){
		        			//권한 -- 포인트
		        			if(checkAuthValue("dev002002","infoInqireAt")=="Y"){
		        				viewLayer(resData.LayerList,"gz_devlop_info",dsCodeListAll);
		        			}
		        		}
			        	resData.resultList.forEach(function(data, index){ 
			        		//지역1,지역2 코드명
			            	var area1_val = devInfoCodeSet(resData.area1List,data.upperMapCode);
			        		var area2_val = devInfoCodeSet(getCodeAjax('AREA',data.upperMapCode).codeList,data.mapCode);
			        		var ds_val = devInfoCodeSet(dsCodeListAll,data.bsnsDstrcCode);
			        		var chk_dstrc = checkApplcDstrc(resData.applcDstrcCodeList,data.bsnsDstrcCode,data.smpleInqireAt);
			        		
			        		dataHtml += "<div class='item' id='" + data.devlopInfoSn + "' style='cursor: pointer;'>";
							dataHtml += "<button class='devInfoListClick link'>";
							dataHtml += "<strong><em>"+ds_val+"</em>"+data.dwkNm+"</strong>";
							if(data.addr != '' && data.addr != null){
								dataHtml += "<span>"+area1_val+" "+area2_val+" "+data.addr+"</span>";
							}
							dataHtml += chk_dstrc;
							dataHtml += "</button>";
			    			dataHtml += "</div>";
			        	});
			        	/*if(resData.resultListTotCnt == 0){
			    			dataHtml += "<tr><td style='border: solid 1px ;text-align: center;'colspan='7'>없음</td></tr>";
			    			
			    		}else{
				        	resData.resultList.forEach(function(data, index){
				        		//지역1,지역2 코드명
				            	var area1_val = devInfoCodeSet(resData.area1List,data.upperMapCode);
				        		var area2_val = devInfoCodeSet(getCodeAjax('AREA',data.upperMapCode).codeList,data.mapCode);
				        		
			        			dataHtml += "<tr id='" + data.devlopInfoSn + "' style='cursor: pointer;'>";
			        			dataHtml += "<td class='listtd'>" + data.dwkNo +"</td>";
			        			dataHtml += "<td class='listtd'>" + data.dwkNm + "</td>";
			        			dataHtml += "<td class='listtd'>" + area1_val + "</td>";
			        			dataHtml += "<td class='listtd'>" + area2_val + "</td>";
			        			dataHtml += "<td class='listtd'>" + data.frstRegisterId + "</td>";
			        			dataHtml += "<td class='listtd'>" + data.frstRegistPnttm + "</td>";
			        			dataHtml += "<td class='listtd'>" + data.lastUpdtPnttm + "</td>";
			        			dataHtml += "</tr>";
				        	});
			    		}*/
			        	
			        	//$('#total-count').html(resData.resultListTotCnt);
			        	//$('#tbodyContents').html(dataHtml);
			        	
			        	dataHtml += '<div id="devInfoListPagination"></div>'
			        	
		        	}else{
		        		swal("검색된 결과가 없습니다.", "검색된 결과가 없습니다.","warning");
		        		dataHtml += "<div class='item' id='' style='cursor: pointer;'>";
						dataHtml += "<button>";
						dataHtml += "<strong>검색 결과가 없습니다</strong>";
						dataHtml += "</button>";
		    			dataHtml += "</div>";
		        	}
		        	$('#devInfoTotalCount').html(addComma(resData.resultListTotCnt));
		        	$('#devInfoCntList').html(dataHtml);
		        	
		        	var paginationDiv = $('#devInfoListPagination');
		        	if(paginationDiv[0]){
		        		paginationInit(paginationDiv);
		        		// makeDevInfoTopPagination(paginationDiv,resData.resultListTotCnt,resData.paginationInfo.currentPageNo, 10);
						// 2021-05-26 : bmna - 지도 검색 부분 페이지 네비게이션 5개로 줄임.
						makeDevInfoTopPagination(paginationDiv,resData.resultListTotCnt,resData.paginationInfo.currentPageNo, 5);
		        	}
	        	}
	        	/*page(resData.resultListTotCnt);*/
	        	/*$('#pagination').children;*/
	        },
	        error:function(e){
	        	console.log(e);
	        	alert('devlopinfo_list_조회 실패' + e);
	    	},complete:function(){
	        	$('.wrap-loading').addClass('display-none');
	    		flag = true;
	    		/*if(resultValChk){
	    			areaSetup();
	    		}*/
	    	}
	    });
	}, 0);
}
//하단 간편검색&상세검색
//개발사업 정보 목록
function devInfoListSearch(initVal,lon,lat){
	//Page index
	//var params = $('#listForm').serializeArray();
	var params = $('#devInfoInfoListForm').serializeArray();
	var areaText = $('#area3 option:selected').text();
	var areaTL = areaText.split(' ');
	if(areaTL.length == 1){
		params.push({'name':'area3txt','value':areaTL[0]});
	}else{
		params.push({'name':'area3txt','value':areaTL[1]});
	}
	params.push({name:'initVal',value:initVal});
	
	if(lon!=null){
		//params 좌표를 뺀 나머지 조건 초기화
		params=[];
		params.push({name:'initVal',value:initVal});
		params.push({name:'lon',value:lon});
		params.push({name:'lat',value:lat});
		//페이징
	}
	
	var dataHtml='';
	var resData;
	//var resultValChk = false;
	$('.wrap-loading').removeClass('display-none');
	setTimeout(function() {
		$.ajax({
	        type : 'POST',
	        url : getContextPath()+"/devlopInfo/selectList.do",
	        async: false,
	        datatype : 'json',
	        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
	        data: params,
	        success : function(data){ 
	        	resData = JSON.parse(data);
	        	var sortArea1List = resData.area1List.sort(function(a, b) {
	        	    return a.sortOrdr < b.sortOrdr ? -1 : a.sortOrdr > b.sortOrdr ? 1 : 0;
	        	});
	    		var dsCodeListAll = resData.dsCodeListAll.sort(function(a, b) {
	    			return a.sortOrdr < b.sortOrdr ? -1 : a.sortOrdr > b.sortOrdr ? 1 : 0;
	    		});
	    		var dsCodeList = resData.dsCodeList.sort(function(a, b) {
	    			return a.sortOrdr < b.sortOrdr ? -1 : a.sortOrdr > b.sortOrdr ? 1 : 0;
	    		});
	        	var cpCodeList = resData.cpCodeList.sort(function(a, b) {
	        	    return a.codeIdNm < b.codeIdNm ? -1 : a.codeIdNm > b.codeIdNm ? 1 : 0;
	        	});
	        	var courtList = resData.courtList.sort(function(a, b) {
	    			return a.sortOrdr < b.sortOrdr ? -1 : a.sortOrdr > b.sortOrdr ? 1 : 0;
	    		});
	        	if(initVal == 'init'){
	        		devInfoOptionset(sortArea1List,'area1','전체','없음');
	        		devInfoOptionset(dsCodeList,'ds1','전체','없음');
	        		devInfoOptionset(cpCodeList,'cp1','전체','없음');
	        		devInfoOptionset(resData.cmCodeList,'rw1','전체','없음');
	        		//투자정보(정선)OptionSet 추가
	        		devInfoOptionset(resData.cmCodeList,'rewardAt','전체','없음');
	        		devInfoOptionset(courtList,'userCourt','전체','없음');
	        		devInfoOptionset(sortArea1List,'invArea1','전체','없음');
	        		devInfoOptionset(sortArea1List,'invAdmArea1','전체','없음');
	        		devInfoOptionset(sortArea1List,'invAdmAreaAdd1','전체','없음');
	        		devInfoOptionset(dsCodeList,'invDs1','전체','없음');
	        		//최초 권한 저장
	        		authVO = resData.authVO;
	        	}else{
	        		if(resData.resultList!=null && resData.resultList.length!=0){
	        			//resultValChk == true;
		        		if(initVal!='pageOnly'){
		        			//권한 -- 포인트
		        			if(checkAuthValue("dev002002","infoInqireAt")=="Y"){
		        				viewLayer(resData.LayerList,"gz_devlop_info",dsCodeListAll);
		        			}
		        		} 
			        	resData.resultList.forEach(function(data, index){ 
			        		//지역1,지역2 코드명
			            	var area1_val = devInfoCodeSet(resData.area1List,data.upperMapCode);
			        		var area2_val = devInfoCodeSet(getCodeAjax('AREA',data.upperMapCode).codeList,data.mapCode);
			        		var ds_val = devInfoCodeSet(dsCodeListAll,data.bsnsDstrcCode);
			        		var chk_dstrc = checkApplcDstrc(resData.applcDstrcCodeList,data.bsnsDstrcCode,data.smpleInqireAt);
			        		
			        		dataHtml += "<div class='item' id='" + data.devlopInfoSn + "' style='cursor: pointer;'>";
							dataHtml += "<button class='devInfoListClick link'>";
							dataHtml += "<strong><em>"+ds_val+"</em>"+data.dwkNm+"</strong>";
							if(checkAuthValue("dev003005","infoInqireAt")=="Y"){
								dataHtml += "<span>"+area1_val+" "+area2_val+" "+data.addr+"</span>";
							}
							dataHtml += chk_dstrc;
							dataHtml += "</button>";
			    			dataHtml += "</div>";
			        	});
			        	/*if(resData.resultListTotCnt == 0){
			    			dataHtml += "<tr><td style='border: solid 1px ;text-align: center;'colspan='7'>없음</td></tr>";
			    			
			    		}else{
				        	resData.resultList.forEach(function(data, index){
				        		//지역1,지역2 코드명
				            	var area1_val = devInfoCodeSet(resData.area1List,data.upperMapCode);
				        		var area2_val = devInfoCodeSet(getCodeAjax('AREA',data.upperMapCode).codeList,data.mapCode);
				        		
			        			dataHtml += "<tr id='" + data.devlopInfoSn + "' style='cursor: pointer;'>";
			        			dataHtml += "<td class='listtd'>" + data.dwkNo +"</td>";
			        			dataHtml += "<td class='listtd'>" + data.dwkNm + "</td>";
			        			dataHtml += "<td class='listtd'>" + area1_val + "</td>";
			        			dataHtml += "<td class='listtd'>" + area2_val + "</td>";
			        			dataHtml += "<td class='listtd'>" + data.frstRegisterId + "</td>";
			        			dataHtml += "<td class='listtd'>" + data.frstRegistPnttm + "</td>";
			        			dataHtml += "<td class='listtd'>" + data.lastUpdtPnttm + "</td>";
			        			dataHtml += "</tr>";
				        	});
			    		}*/
			        	
			        	//$('#total-count').html(resData.resultListTotCnt);
			        	//$('#tbodyContents').html(dataHtml);
			        	
			        	dataHtml += '<div id="devInfoListPagination"></div>'
			        	
		        	}else{
		        		swal("검색된 결과가 없습니다.", "검색된 결과가 없습니다.","warning");
		        		dataHtml += "<div class='item' id='' style='cursor: pointer;'>";
						dataHtml += "<button>";
						dataHtml += "<strong>검색 결과가 없습니다</strong>";
						dataHtml += "</button>";
		    			dataHtml += "</div>";
		    			
		        	}
		        	$('#devInfoTotalCount').html(addComma(resData.resultListTotCnt));
		        	$('#devInfoCntList').html(dataHtml);
		        	
		        	var paginationDiv = $('#devInfoListPagination');
		        	if(paginationDiv[0]){
		        		paginationInit(paginationDiv);
		        		//makeDevInfoPagination(paginationDiv,resData.resultListTotCnt,resData.paginationInfo.currentPageNo, 10);
						// 2021-05-26 : bmna - 지도 검색 부분 페이지 네비게이션 5개로 줄임.
						makeDevInfoPagination(paginationDiv,resData.resultListTotCnt,resData.paginationInfo.currentPageNo, 5);
		        	}
	        	}
	        	/*page(resData.resultListTotCnt);*/
	        	/*$('#pagination').children;*/
	        },
	        error:function(e){
	        	console.log(e);
	        	alert('devlopinfo_list_조회 실패' + e);
	    	},complete:function(){
	        	$('.wrap-loading').addClass('display-none');
	    		flag = true;
	    		//목록 표출
	    		/*if(resultValChk){
	    			areaSetup();
	    		}*/
	    	}
	    });
	}, 0);
}

//개발정보 상세보기 -- 사용자
function devInfoDtl(devlopInfoSn,from){
	//Page index
	var params = [];
	params.push({name:"devlopInfoSn",value:devlopInfoSn});
	
	var dataHtml;
	var resData; 
	$.ajax({
        type : 'POST',
        url : getContextPath()+"/devlopInfo/selectDetail.do",
        async: false,
        datatype : 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        data: params,
        success : function(data){
        	resData = JSON.parse(data);
        	authVO = resData.authVO;
        	//권한 -- 상세조회
        	//분류(준공)
        	if(checkAuth("dev003001","infoInqireAt","")){
        		//분류(미분류)
        		//미분류 권한이 있거나, 데이터가 준공처리 되었거나
        		if(checkAuthValue("dev003002","infoInqireAt") == "Y" || resData.resultList.smpleInqireAt == "Y"){
        			//투자정보 건수
        			$('#infoObject span').html("투자정보("+resData.InvtListCnt+"건)");
        			var userResult = resData.userResult;
        			//프린트 남은횟수 체크
        			var printAtag = $('#printCntChk');
        			printAtag.attr('data-cntnum',userResult.outptCo);
        			printAtag.attr('data-cntdt',userResult.outptDt);
        			printAtag.html("<i class='icon-print'></i> 인쇄하기 ("+userResult.outptCo+" / 20)");
        			
        			if(from=='from'){
        				if(map.getLayerByName('gz_devlop_info')!=null){} // 개발정보-투자정보-개발정보 일때
        				else{
    	        		var inputList=[];
    	        		inputList.push(resData.resultList);
    	        		//권한 -- 포인트
    	        		if(checkAuth("dev002002","infoInqireAt","")){
    	        			viewLayer(inputList,"gz_devlop_info",resData.dsCodeList);
    	        			InvtoDev = 1;
    	        		}}
    	        	}
    	        	$('#devInfoDtlForm').parents('#info').css('display','block');
    	        	
    	        	var mtCode = devInfoCodeSet(resData.mtCodeList, resData.resultList.bsnsMthdCode);
    	        	var area1_val = devInfoCodeSet(resData.area1List,resData.resultList.upperMapCode);
    	        	var area2_val = devInfoCodeSet(getCodeAjax('AREA',resData.resultList.upperMapCode).codeList,resData.resultList.mapCode);
    	        	var mbCode_val = devInfoCodeSet(resData.mbCodeList,resData.gradCode);
    	        	
    	        	//권한 -- 상세 > 시도/시군구
    	    		if(authVO.dev003004.infoInqireAt == "Y" || resData.resultList.smpleInqireAt == "Y" || resData.dsChkVal == "true"){
    	    			$('#devInfoDtl_area').html(area1_val+' '+area2_val);
    	    		}else{
    	    			$('#devInfoDtl_bsnsCn').html(" ");
    	    		}
    	        	$('#devInfoDtl_dwkNm').html(resData.resultList.dwkNm);
    	        	//권한 -- 상세 > 읍면동이하 주소
    	        	if(resData.resultList.addr!="undefined" && resData.resultList.addr!="" && resData.resultList.addr!=null) {
	    	    		if(authVO.dev003005.infoInqireAt == "Y" || resData.resultList.smpleInqireAt == "Y" || resData.dsChkVal == "true"){
	    	    			$('#devInfoDtl_addr').html(resData.resultList.addr);
	    	    			$('#devInfoDtl_addr').removeClass('noAuthTxt');
	    	    		}else{
	    	    			$('#devInfoDtl_addr').html("정보 조회 권한이 없는 등급입니다");
	    	    			$('#devInfoDtl_addr').addClass('noAuthTxt');
	    	    		}
    	        	}else{
    	        		$('#devInfoDtl_addr').html('');
	    				$('#devInfoDtl_addr').siblings('strong').html('');
    	    		}
    	        	//권한 -- 상세 > 기본정보1
    	    		if(authVO.dev003003.infoInqireAt == "Y" || resData.resultList.smpleInqireAt == "Y" || resData.dsChkVal == "true"){
    	    			//면적 / 길이 변환
    	    			if(resData.resultList.bsnsArMeter!="undefined" && resData.resultList.bsnsArMeter!="" && resData.resultList.bsnsArMeter!=null) {
    	    				switch(resData.resultList.unitTy){
    	    					case"길이":
    	    						//if(resData.resultList.bsnsArMeter!=null){
    	    							$('#devInfoDtl_bsnsAr').html(addComma(resData.resultList.bsnsArMeter)+'km('+addComma(resData.resultList.bsnsArPyeong)+'m)</span>');
    	    						//}else{$('#devInfoDtl_bsnsAr').html('　');}
    	    							$('#devInfoDtl_bsnsAr').siblings('strong').html('길이');
    	    						break;
    	    					default:
    	    						//if(resData.resultList.bsnsArMeter!=null){
    	    							$('#devInfoDtl_bsnsAr').html(addComma(resData.resultList.bsnsArMeter)+'m<sup>2</sup> ('+addComma(resData.resultList.bsnsArPyeong)+'평</sup>)');
    	    						//}else{$('#devInfoDtl_bsnsAr').html('　');}
    	    							$('#devInfoDtl_bsnsAr').siblings('strong').html('면적');
    	    						break;
    	    				}
    	    				$('#devInfoDtl_bsnsAr').siblings('strong').text(resData.resultList.unitTy);
    	    				
    	    			}else{
    	    				$('#devInfoDtl_bsnsAr').html('');
    	    				$('#devInfoDtl_bsnsAr').siblings('strong').html('');
    	    			}
    	    			
    	    			//사업기간
    	    			if(resData.resultList.bsnsBgnde!="undefined" && resData.resultList.bsnsBgnde!="" && resData.resultList.bsnsBgnde!=null) {
    	    				if(resData.resultList.bsnsEndde!="undefined" && resData.resultList.bsnsEndde!="" && resData.resultList.bsnsEndde!=null){
    	    					$('#devInfoDtl_bsnsDe').html(strToDate(resData.resultList.bsnsBgnde)+" ~ "+strToDate(resData.resultList.bsnsEndde));
    	    				}else{
    	    					$('#devInfoDtl_bsnsDe').html(strToDate(resData.resultList.bsnsBgnde));
    	    				}
    	    				$('#devInfoDtl_bsnsDe').siblings('strong').html('사업기간');
    	    			}else{
    	    				$('#devInfoDtl_bsnsDe').html('');
    	    				$('#devInfoDtl_bsnsDe').siblings('strong').html('');
    	    			}
    	    			//사업비
    	    			if(resData.resultList.wct!="undefined" && resData.resultList.wct!="" && resData.resultList.wct!=null) {
    	    				$('#devInfoDtl_wct').html(numberToKorean(resData.resultList.wct));
    	    				$('#devInfoDtl_wct').siblings('strong').html('사업비');
    	    			}else{
    	    				$('#devInfoDtl_wct').html('');
    	    				$('#devInfoDtl_wct').siblings('strong').html('');
    	    			}
	    	    		$('#devInfoDtl_bsnsAr').removeClass('noAuthTxt');
	    	    		$('#devInfoDtl_bsnsDe').removeClass('noAuthTxt');
	    	    		$('#devInfoDtl_wct').removeClass('noAuthTxt');
    	    		}else{
    	    			$('#devInfoDtl_bsnsAr').html('정보 조회 권한이 없는 등급입니다');
    	    			$('#devInfoDtl_bsnsDe').html('정보 조회 권한이 없는 등급입니다');
    	    			$('#devInfoDtl_wct').html('정보 조회 권한이 없는 등급입니다');
    	    			$('#devInfoDtl_bsnsAr').addClass('noAuthTxt');
    	    			$('#devInfoDtl_bsnsDe').addClass('noAuthTxt');
    	    			$('#devInfoDtl_wct').addClass('noAuthTxt');
    	    		}
    	    		//권한 -- 상세 > 기본정보2
    	    		if(authVO.dev003006.infoInqireAt == "Y" || resData.resultList.smpleInqireAt == "Y" || resData.dsChkVal == "true"){
    	    			//적용법률
    	    			if(resData.resultList.applcLaw !="undefined" && resData.resultList.applcLaw!="" && resData.resultList.applcLaw!=null){
    	    				$('#devInfoDtl_applcLaw').html(resData.resultList.applcLaw);
    	    				$('#devInfoDtl_applcLaw').siblings('strong').html('적용법률');
    	    			}else{
    	    				$('#devInfoDtl_applcLaw').html('');
    	    				$('#devInfoDtl_applcLaw').siblings('strong').html('');
    	    			}
    	    			//사업방식
    	    			if(resData.resultList.bsnsMthdCode !="undefined" && resData.resultList.bsnsMthdCode!="" && resData.resultList.bsnsMthdCode!=null){
    	    				$('#devInfoDtl_bsnsMthdCode').html(mtCode);
    	    				$('#devInfoDtl_bsnsMthdCode').siblings('strong').html('사업방식');
    	    			}else{
    	    				$('#devInfoDtl_bsnsMthdCode').html('');
    	    				$('#devInfoDtl_bsnsMthdCode').siblings('strong').html('');
    	    			}
    	    			//사업인정시점
    	    			if(resData.resultList.bsnsrcognNtfcNm !="undefined" && resData.resultList.bsnsrcognNtfcNm!="" && resData.resultList.bsnsrcognNtfcNm!=null){
    	    				$('#devInfoDtl_bsnsrcognNtfcNm').html(resData.resultList.bsnsrcognNtfcNm);
    	    				$('#devInfoDtl_bsnsrcognNtfcNm').siblings('strong').html('사업인정시점');
    	    			}else{
    	    				$('#devInfoDtl_bsnsrcognNtfcNm').html('');
    	    				$('#devInfoDtl_bsnsrcognNtfcNm').siblings('strong').html('');
    	    			}
    	    			//시행사
    	    			if(resData.resultList.opertnCmpny !="undefined" && resData.resultList.opertnCmpny!="" && resData.resultList.opertnCmpny!=null){
	    	    			$('#devInfoDtl_opertnCmpny').html(resData.resultList.opertnCmpny);
	    	    			$('#devInfoDtl_opertnCmpny').siblings('strong').html('시행사');
	    	    		}else if(resData.resultList.opertnCmpnyCode !="undefined" && resData.resultList.opertnCmpnyCode!="" && resData.resultList.opertnCmpnyCode!=null){
	    	    			$('#devInfoDtl_opertnCmpny').html(devInfoCodeSet(resData.cpCodeList,resData.resultList.opertnCmpnyCode));
	    	    			$('#devInfoDtl_opertnCmpny').siblings('strong').html('시행사');
	    	    		}else{
	    	    			$('#devInfoDtl_opertnCmpny').html('');
	    	    			$('#devInfoDtl_opertnCmpny').siblings('strong').html('');
	    	    		}
    	    			//용지비
    	    			if(resData.resultList.lct!="undefined" && resData.resultList.lct!="" && resData.resultList.lct!=null){
    	    				$('#devInfoDtl_lct').html(numberToKorean(resData.resultList.lct));
    	    				$('#devInfoDtl_lct').siblings('strong').html('용지비');
    	    			}else{
    	    				$('#devInfoDtl_lct').html('');
    	    				$('#devInfoDtl_lct').siblings('strong').html('');
    	    			}
    	    			$('#devInfoDtl_applcLaw').removeClass('noAuthTxt');
    	    			$('#devInfoDtl_bsnsMthdCode').removeClass('noAuthTxt');
    	    			$('#devInfoDtl_bsnsrcognNtfcNm').removeClass('noAuthTxt');
    	    			$('#devInfoDtl_opertnCmpny').removeClass('noAuthTxt');
    	    			$('#devInfoDtl_lct').removeClass('noAuthTxt');
    	    		}else{
    	    			$('#devInfoDtl_applcLaw').html('정보 조회 권한이 없는 등급입니다');
    	    			$('#devInfoDtl_bsnsMthdCode').html('정보 조회 권한이 없는 등급입니다');
    	    			$('#devInfoDtl_bsnsrcognNtfcNm').html('정보 조회 권한이 없는 등급입니다');
    	    			$('#devInfoDtl_opertnCmpny').html('정보 조회 권한이 없는 등급입니다');
    	    			$('#devInfoDtl_lct').html('정보 조회 권한이 없는 등급입니다');
    	    			$('#devInfoDtl_applcLaw').addClass('noAuthTxt');
    	    			$('#devInfoDtl_bsnsMthdCode').addClass('noAuthTxt');
    	    			$('#devInfoDtl_bsnsrcognNtfcNm').addClass('noAuthTxt');
    	    			$('#devInfoDtl_opertnCmpny').addClass('noAuthTxt');
    	    			$('#devInfoDtl_lct').addClass('noAuthTxt');
    	    		}
    	    		//권한 -- 상세 > 사업주요내용
    	    		if(authVO.dev003007.infoInqireAt == "Y" || resData.resultList.smpleInqireAt == "Y" || resData.dsChkVal == "true"){
    	    			var aplyHtml = rbAply('\\r\\n',resData.resultList.bsnsCn);
    	    			$('#devInfoDtl_bsnsCn').html(aplyHtml);
    	    			$('#devInfoDtl_bsnsCn li').css('white-space','pre-line');
    	    			$('#devInfoDtl_bsnsCn').removeClass('noAuthTxt');
    	    		}else{
    	    			$('#devInfoDtl_bsnsCn').html("정보 조회 권한이 없는 등급입니다");
    	    			$('#devInfoDtl_bsnsCn').addClass('noAuthTxt');
    	    		}
    	    		
    	    		//if(resData.login)
    	    		/*var chkVal = mbGradeChk(resData.gradCode);
    	    		if(chkVal){*/
    	    		//권한 -- 상세 > 지존멘트
    	    		if(authVO.dev005003.infoInqireAt == "Y" || resData.resultList.smpleInqireAt == "Y" || resData.dsChkVal == "true"){
    	    			var gzMentHtml = rbAply('\\r\\n', resData.resultList.gzMent);
    	    			if(gzMentHtml==''){
    	    				gzMentHtml += '지존 멘트가 없습니다'
    	    			}
    		    		$('#devInfoDtl_gzMent').html(gzMentHtml);
    		    		$('#devInfoDtl_gzMent li').css('white-space','pre-line');
    	    		}else{
    	    			$('#devInfoDtl_gzMent').html('<li class="primium">정보 조회 권한이 없는 등급입니다<img src="'+getContextPath()+'/images/develop/premium.png"></li>');
    	    		}
    	    		//권한 -- 상세  > 파일첨부
    	    		var fileAuthChkVal;
	    			if(authVO.dev005002.infoInqireAt == "Y" || resData.resultList.smpleInqireAt == "Y" || resData.dsChkVal == "true"){
	    				fileAuthChkVal = true;
	    			}else{
	    				fileAuthChkVal = false;
	    			}
    	    		//첨부파일& 썸네일
    	    		if(resData.resultList.atchFileId == "old"){
    	    			createFileListHtml(fileAuthChkVal,resData.pathMap,'devInfoDtl_thumbnail','devInfoDtl_fileList',resData.oldFileMap,resData.resultList.smpleInqireAt,resData.dsChkVal);
    	    		}else{
    	    			//대표이미지 썸네일 첨부파일 -- 05.25
    		        	var thumbFileResult = getThumbFilesAjax("gz_devlop_info",resData.resultList.thumbFileId);
    		        	if(thumbFileResult.atchFiles!=null &&thumbFileResult.atchFiles.length !=0){
    		        		$('#devInfoDtl_thumbnail').html();
    		        		$('#devInfoTbImg').attr('src','/file/displayFile.do?filePath=/upload/gzone/'+thumbFileResult.atchFiles[0].fileStreCours+'&fileName='+thumbFileResult.atchFiles[0].streFileNm);
    		        	}else{
    		        		$('#devInfoDtl_thumbnail').html();
    		        		$('#devInfoTbImg').attr('src',getContextPath()+'/images/develop/noImage.png');
    		        	}
    	    			
    	    			var filedownHtml = "";
    	    			/*if(fileAuthChkVal){*/
    		    			var fileMapList = getFilesAjax("gz_devlop_info",resData.resultList.atchFileId);
    		    			if(fileMapList.atchFiles!=null && fileMapList.atchFiles.length !=0 ){
	    		    			fileMapList.atchFiles.forEach(function(data,index){
	    							filedownHtml +="<div class='fileDiv banner__box down'>";
	    							filedownHtml +="<a class='down' data-url=\'"+getContextPath()+"/cmmn/downloadFile.do?orignlFileNm="+data.streFileNm+"&fileStreCours=/upload/gzone/"+data.fileStreCours+"\' data-smpleAuth=\'"+resData.resultList.smpleInqireAt+"\' data-dschkval=\'"+resData.dsChkVal+"\' >";
	    							filedownHtml +="<strong class='ui-banner__title'>"+data.orignlFileNm.replace('.pdf','').replace('.jpg','').replace('.jpeg','') +"</strong>";
	    							filedownHtml +="</a>";
	    							filedownHtml +="</div>";
	    		    			});
    		    			}
    	    			/*}else{
    	    				filedownHtml +="<ul>";
    	    				filedownHtml +='<li class="primium">정보 조회 권한이 없는 등급입니다<img src="'+getContextPath()+'/images/develop/premium.png"></li>';
    	    				filedownHtml +="</ul>";
    	    			}*/
    	    			//파일아이디 추가
    	    			//document.devInfoAdminDtlForm.atchFileId = resData.resultList.atchFileId;
    	    			$('#devInfoDtl_fileList').html(filedownHtml);
    	    		}
    	    		//관리자 최종 수정일
    	    		$('#mngrLastUpdtPnttmText').html(strToDateKr(resData.resultList.mngrLastUpdtPnttm));
    	    		$('.pnttmText').html(strToDate(resData.resultList.mngrLastUpdtPnttm)+" 기준 작성(이후 변경가능)");
    	    		//투자정보 클릭시 데이터
    	    		$('#infoObject').attr('data-smpleat',resData.resultList.smpleInqireAt);
    	    		
    	    		
    	    		document.devInfoDtlForm.dwkNm.value = resData.resultList.dwkNm;
    	    		document.devInfoDtlForm.dwkNo.value = resData.resultList.dwkNo;
    	    		document.devInfoDtlForm.devlopInfoSn.value = resData.resultList.devlopInfoSn;
	    			//추진내역
    	    		devInfoPrtnListSearch(resData.searchVO.devlopInfoSn,resData.resultList.smpleInqireAt,resData.dsChkVal);
    	    		
        		}else{
        			swal("선택하신 자료의 열람권한이 없는 등급입니다","현재 회원님의 등급은 '"+resData.gradCodeNm+"'입니다","error");
        		}
        	}/*else{
        		swal("해당 정보를 열람할 수 없습니다","현재 회원님의 등급은 '"+resData.gradCodeNm+"'입니다","error");
        	}*/
        	if ($("#info").hasClass('moveTo')) {
        		$("#info").toggleClass('moveTo');
			}
        	
        },
        error:function(e){
        	console.log(e);
        	alert('devInfoDtl_조회 실패' + e);
    	}
	});
	//페이지 열때 항상 맨 위로 스크롤
	$("#info .scroll").scrollTop(0);
}
//관련기사
function devInfoArticle(dwkNm){
	var devInfoDtlForm = $('#devInfoDtlForm').serializeArray();
	var formDwkNm = devInfoDtlForm[1];
	var formDwkNo = devInfoDtlForm[2];
	var uri = getContextPath()+"/cmmnty/mmnwsBbsList.do?"+formDwkNm.name+"="+formDwkNm.value+"&"+formDwkNo.name+"="+formDwkNo.value; 
	const encoded = encodeURI(uri);
	window.open(encoded);
	//window.open(getContextPath()+"/devlopInfo/selectMmnwsBbsListByDwkNm.do?"+devInfoDtlForm);
	//window.open(getContextPath()+"/devlopInfo/selectNwsListByDwkNm.do?"+devInfoDtlForm);
	/*document.devInfoDtlForm.action = getContextPath()+"/devlopInfo/selectNwsListByDwkNm.do";
	document.devInfoDtlForm.submit();
	document.devInfoDtlForm.pageIndex.value = 1;*/
}
//관심정보 등록 -- 사용자
function devInfoIntrst(dwkNo){
	var params = [];
	params.push({name:'dwkNo',value:dwkNo});
	$.ajax({
        type : 'POST',
        url : getContextPath()+"/devlopInfo/selectIntrstList.do",
        async: false,
        datatype : 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        data: params,
        success : function(data){
        	var resData = JSON.parse(data);
        	devInfoOptionset(resData.IntrstList,'devlopIntrstThingSn','전체','없음');
        },
        error:function(e){
        	console.log(e);
        	alert('selectIntrstList_조회 실패' + e);
    	}
	});
}
//관심정보 등록 ---- 사용자
function devInfoIntrstInsrt(dwkNo){
	var params = $('#devInfoIntrst').serializeArray();
	var gnText = $('#devlopIntrstThingSn option:selected').text();
	if(gnText !='전체'){
		params.push({'name':'intrstGroupNm','value':gnText});
		params.push({'name':'dwkNo','value':dwkNo});
		$.ajax({
	        type : 'POST',
	        url : getContextPath()+"/devlopInfo/InsertIntrst.do",
	        async: false,
	        datatype : 'json',
	        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
	        data: params,
	        success : function(data){
	        	var resData = JSON.parse(data);
	        	if(resData.insertIntrstResult==1){
	        		swal('관심정보를 추가하였습니다','해당 사업정보를 관심그룹에 추가하였습니다','success');
	        		//모달닫기
	        		$('#modalIntrst').modal('hide');
	        	}else if(resData.insertIntrstResult==2){
	        		swal('이미 해당 정보가 관심그룹에 있습니다','동일한 사업정보가 관심그룹정보에 있습니다','warning');
	        	}
	        },
	        error:function(e){
	        	console.log(e);
	        	alert('selectIntrstInsrt 관심정보 등록 실패' + e);
	    	}
		});
	}else{
		swal('관심그룹을 선택해주세요','관심그룹을 선택하지 않았습니다','warning');
	}
	
}

function devInfoInvtList(dwkNo){
	$.ajax({
        type : 'POST',
        url : getContextPath()+"/devlopInfo/selectInvtListBydwkNo.do",
        async: false,
        datatype : 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        data: {'dwkNo':dwkNo},
        success : function(data){
        	var resData = JSON.parse(data);
        	var dataHtml='';
        	if(resData.invtList == 0){
        		swal("검색된 결과가 없습니다.", "검색된 결과가 없습니다.","warning");
        		dataHtml = "<tr><td style='border: solid 1px ;text-align: center;'colspan='7'>없음</td></tr>";
    		}else{
    			resData.invtList.forEach(function(data, index){
	        		//지역1,지역2 코드명
	            	var area1_val = codeSet(resData.area1List,data.upperMapCode);
	        		var area2_val = codeSet(getCodeAjax('AREA',data.upperMapCode).codeList,data.mapCode);
	        		// [경매] 사건번호가 비어있으면 사건번호의 default 값은 1
	        		if(data.thingNo == "" || data.thingNo == null){
	        			data.thingNo = 1
	        		}
	        		// 무료 전용 ( 프리미엄 이코노미 전용)
	        		if((data.free =="N" && 'CM00200010'!= $('#gradCode').val() && 'CM00200011'!= $('#gradCode').val()) && 'CM00210003'!=$('#indvdlMberCode').val()){
	        			dataHtml += '<div class="item" style="height:200px"><li class="primiumInv">프리미엄 전용 매물<img src="'+getContextPath()+'/images/develop/premium.png"></li></div>';
	        		}
	        		// 프리미엄 스페셜 ( 프리미엄 이코노미 전용)
	        		else if(data.special =="Y" && 'CM00200010'== $('#gradCode').val() && 'CM00210003'!=$('#indvdlMberCode').val() ){
	        			dataHtml += '<div class="item" style="height:200px"><li class="primiumInv">1억 이상의 매물 (프리미엄[스폐셜]만 이용 가능)<img src="'+getContextPath()+'/images/develop/premium.png"></li></div>';
	        		}
	        		else{
	        		dataHtml += "<div class='item' id='"+data.invtInfoSn+"'>";
	        		dataHtml += "<a href='#' class='link' style='overflow: auto;'>";
	        		dataHtml += "<span class='td__category'>"+data.aucYN+"</span>";
	        		dataHtml += "<div class='description'>";
	        		dataHtml += "<strong class='title'>";
	        		if(data.aucYN == "경매"){  // 경매
	        			if(data.thingNo == "" || data.thingNo == null || data.thingNo =="99" ){ // 물건번호가 없거나 99일 경우 , 
	        			dataHtml += "<em style='min-width: 431px;' onclick='detailSrch(\""+data.courtNm+"\",\""+data.incdntManageNo.split('-')[0]+'0130'+fillZero(6,data.incdntManageNo.split('-')[1])+"\",\"1\")'>사건번호 : "+data.courtNm + data.smCode+"계  "+ data.incdntManageNo +"</em>";}
	        			else{ dataHtml += "<em style='min-width: 431px;' onclick='detailSrch(\""+data.courtNm+"\",\""+data.incdntManageNo.split('-')[0]+'0130'+fillZero(6,data.incdntManageNo.split('-')[1])+"\",\""+data.thingNo+"\")'>사건번호 : "+data.courtNm + data.smCode+"계  "+ data.incdntManageNo +"["+data.thingNo+"]"+"</em>";}
	        		}else{	// 공매
	        			dataHtml += "<em style='min-width: 431px;' onclick='popOnbidMgrNoSearch_2021(\""+data.incdntManageNo+"\")'>관리번호 : "+data.incdntManageNo +"</em>";
	        		}
	        		dataHtml += "<br><br>";
	        		if(data.rewardAt ="보상완료"){dataHtml += "<i class='txt_blt03 state05'>"}
	        		else if(data.rewardAt ="보상예정"){ ataHtml += "<i class='txt_blt03 state04'>"}
	        		else{dataHtml += "<i class='txt_blt03 state01'>"}
	        		dataHtml += data.rewardAt+"</i><em class='invDwknm' onclick='devInfoDtl(\""+data.devlopInfoSn+"\", \"from\"); $(\"#sideAdmin\").toggleClass(\"moveTo\");' style='margin-left: 8px'>"+data.dwkNm+"</em></strong>";
	        		dataHtml += "<ul>";
	        		dataHtml += "<li class='mid_td'>용도 :"+data.prposNm+"</li>";
	        		dataHtml += "<li class='mid_td'>소재지 :"+area1_val+" "+area2_val+" "+data.addr+"</li>";
	        		dataHtml += "<li class='mid_td'>편입면적 :"+data.incrprAr+"</li>";
	        		dataHtml += "<li class='mid_td'>감정가 :"+addComma(data.apasmtAmount)+"원</li>";
	        		if(data.bidAmount == undefined || data.bidAmount=='' || data.bidAmount == null){data.bidAmount = data.apasmtAmount}
	        		dataHtml += "<li class='mid_td'>최저가 :"+addComma(data.bidAmount)+"원 ("+(data.bidAmount/data.apasmtAmount*100).toFixed(2)+"%)</li>";
	        		dataHtml += "<li class='mid_td'>입찰일 :"+(new Date(data.bidDe)).toLocaleDateString()+"</li>";
	        		dataHtml += "<li class='mid_td'>상태 :"+data.stusNm+"</li>";
	        		dataHtml += "</ul><div class='td__knowhow'><strong>특급노하우 </strong>"+data.rmOne+"</div></div>";
	        		dataHtml += "</a></div></div>";
	        		}
        		});
    			$('#modalInvtShowDev').modal({backdrop: false,keyboard:false});
    		}
        	$('#devInfoDtlInvtContent').html(dataHtml);
        },
        error:function(e){
        	console.log(e);
        	alert('selectInvtListBydwkNo 투자정보 조회 실패' + e);
    	}
	});
}
//추진내역 목록 -- 사용자
function devInfoPrtnListSearch(devlopInfoSn,smpleAuth,dsChkVal){
	$("#sideAdmin").removeClass("moveTo");  
	//Page index
	var paramsS = [];
	paramsS.push({name:'devlopInfoSn',value:devlopInfoSn});
	
	var prtnListHtml ="";
	var prtnPlanListHtml ="";
	var prtnChk = false;
	var prtnPlanChk = false;
	$.ajax({
        type : 'POST',
        url : getContextPath()+"/devlopInfo/selectPrtnList.do",
        async: false,
        datatype : 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        data: paramsS,
        success : function(data){ 
        	var resData = JSON.parse(data);
        	//권한 -- 상세  > 추진내역 목록
        	var subFilePath = resData.pathMap.devlopSubFilePath;
			if(checkAuthValue('dev004001','infoInqireAt') == "Y" || smpleAuth == "Y"){
				if(resData.resultList!=null && resData.resultList.length!=0){
	        		resData.resultList.forEach(function(data, index){
	        			if(data.prtnSeCode == 'CM00170001'){
	        				//추진내역 분류코드명
	        				var clCode = devInfoCodeSet(resData.clCodeList,data.prtnClCode);
	        				switch(data.prtnClCode){
		        				case"CM00340001":
		        					//미분류
		        					//if(authVO.dev004010.infoInqireAt == "Y"){
			        					prtnListHtml = createPrtnHtmlList(prtnListHtml,subFilePath,data,authVO.dev004010.infoInqireAt,smpleAuth,dsChkVal);
			        					prtnChk = true;
		        					//}else{prtnChk = "Auth"}
		        					break;
		        				case"CM00340002":
		        					//구역지정고시
		        					//if(authVO.dev004002.infoInqireAt == "Y"){
			        					prtnListHtml = createPrtnHtmlList(prtnListHtml,subFilePath,data,authVO.dev004002.infoInqireAt,smpleAuth,dsChkVal);
			        					prtnChk = true;
		        					//}else{prtnChk = "Auth"}
		        					break;
		        				case"CM00340003":
		        					//지구지정고시
		        					//if(authVO.dev004003.infoInqireAt == "Y"){
			        					prtnListHtml = createPrtnHtmlList(prtnListHtml,subFilePath,data,authVO.dev004003.infoInqireAt,smpleAuth,dsChkVal);
			        					prtnChk = true;
		        					//}else{prtnChk = "Auth"}
		        					break;
		        				case"CM00340004":
		        					//단지지정고시
		        					//if(authVO.dev004004.infoInqireAt == "Y"){
			        					prtnListHtml = createPrtnHtmlList(prtnListHtml,subFilePath,data,authVO.dev004004.infoInqireAt,smpleAuth,dsChkVal);
			        					prtnChk = true;
		        					//}else{prtnChk = "Auth"}
		        					break;
		        				case"CM00340005":
		        					//구역결정고시
		        					//if(authVO.dev004005.infoInqireAt == "Y"){
			        					prtnListHtml = createPrtnHtmlList(prtnListHtml,subFilePath,data,authVO.dev004005.infoInqireAt,smpleAuth,dsChkVal);
			        					prtnChk = true;
		        					//}else{prtnChk = "Auth"}
		        					break;
		        				case"CM00340006":
		        					//사업시행승인고시
		        					//if(authVO.dev004006.infoInqireAt == "Y"){
			        					prtnListHtml = createPrtnHtmlList(prtnListHtml,subFilePath,data,authVO.dev004006.infoInqireAt,smpleAuth,dsChkVal);
			        					prtnChk = true;
		        					//}else{prtnChk = "Auth"}
		        					break;
		        				case"CM00340007":
		        					//지구계획승인고시
		        					//if(authVO.dev004007.infoInqireAt == "Y"){
			        					prtnListHtml = createPrtnHtmlList(prtnListHtml,subFilePath,data,authVO.dev004007.infoInqireAt,smpleAuth,dsChkVal);
			        					prtnChk = true;
		        					//}else{prtnChk = "Auth"}
		        					break;
		        				case"CM00340008":
		        					//개발계획승인고시
		        					//if(authVO.dev004008.infoInqireAt == "Y"){
			        					prtnListHtml = createPrtnHtmlList(prtnListHtml,subFilePath,data,authVO.dev004008.infoInqireAt,smpleAuth,dsChkVal);
			        					prtnChk = true;
		        					//}else{prtnChk = "Auth"}
		        					break;
		        				case"CM00340009":
		        					//실시계획승인고시
		        					//if(authVO.dev004009.infoInqireAt == "Y"){
			        					prtnListHtml = createPrtnHtmlList(prtnListHtml,subFilePath,data,authVO.dev004009.infoInqireAt,smpleAuth,dsChkVal);
			        					prtnChk = true;
		        					//}else{prtnChk = "Auth"}
		        					break;
	        				}
	        			}else{
	        				//권한 -- 상세  > 향후추진내역
	        				//if(authVO.dev005001.infoInqireAt == "Y"){
	        					prtnPlanListHtml = createPrtnPlanHtmlList(prtnPlanListHtml,subFilePath,data,authVO.dev005001.infoInqireAt,smpleAuth,dsChkVal);
		        				prtnPlanChk = true;
	        				//}else{prtnPlanChk = "Auth"}
	        			}
	        		});
	        	}
	        	if(prtnChk == false){
	        		prtnListHtml += "<li>추진내역 없음</li>";
	        	}
	        	if(prtnPlanChk  == false){
	        		prtnPlanListHtml += "<li>향후 추진내역 없음</li>";
	        	}
	        	/*if(prtnChk != "Auth"){
		        	if(prtnChk == false){
		        		prtnListHtml += "<li>추진내역 없음</li>";
		        	}
	        	}else{
	        		prtnListHtml += "<li>정보 조회 권한이 없는 등급입니다</li>";
	        	}
	        	if(prtnPlanChk != "Auth"){
		        	if(prtnPlanChk  == false){
		        		prtnPlanListHtml += "<li>추진내역 없음</li>";
		        	}
	        	}else{
	        		prtnPlanListHtml += "<li>정보 조회 권한이 없는 등급입니다</li>";
	        	}*/
        	}else{
        		prtnListHtml += "<li class='noAuthTxt'>정보 조회 권한이 없는 등급입니다</li>";
        		prtnPlanListHtml += "<li class='noAuthTxt'>정보 조회 권한이 없는 등급입니다</li>";
        	}
        	$('#devInfoDtl_prtnList').html(prtnListHtml);
        	$('#devInfoDtl_prtnPlanList').html(prtnPlanListHtml);
        	
        },
        error:function(e){
        	console.log(e);
        	alert('prtn_devlopinfo_list_조회 실패' + e);
    	},complete : function() {
    		$("#sideAdmin").removeClass("moveTo");  
        }

    });
}
//============================ 사용자 END ===========================

// ============================ 유틸 ====================================
function paginationInit(paginationDiv){
	paginationDiv.empty();
	paginationDiv.removeData("twbs-pagination");
	paginationDiv.unbind("page");
}
//개발사업정보 -- 사용자 하단검색 페이지 목록
function makeDevInfoPagination(paginationDiv,totalPages, currentPageNo, pageCount){
	var totalPagesOption;
	var visiblePage = pageCount;
	var pageCal = totalPages/10;
	var pageCalRemain = totalPages%10;
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
	    	document.devInfoInfoListForm.pageIndex.value = page;
	    	devInfoListSearch('pageOnly',null,null);
	    	$('.mCSB_container').css('top','0');
	    }
	});
	paginationDiv.children().children('.first').children('a').attr('aria-label','first');
	paginationDiv.children().children('.Previous').children('a').attr('aria-label','Previous');
	paginationDiv.children().children('.Next').children('a').attr('aria-label','Next');
	paginationDiv.children().children('.last').children('a').attr('aria-label','last');
}
//개발사업정보 -- 사용자 상단검색 페이지 목록
function makeDevInfoTopPagination(paginationDiv,totalPages, currentPageNo, pageCount){
	var totalPagesOption;
	var visiblePage = pageCount;
	var pageCal = totalPages/10;
	var pageCalRemain = totalPages%10;
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
	    	$('#keyPageIndex').val(page)
	    	devInfoListTopSearch('pageOnly',null,null);
	    	$('.mCSB_container').css('top','0');
	    }
	});
	paginationDiv.children().children('.first').children('a').attr('aria-label','first');
	paginationDiv.children().children('.Previous').children('a').attr('aria-label','Previous');
	paginationDiv.children().children('.Next').children('a').attr('aria-label','Next');
	paginationDiv.children().children('.last').children('a').attr('aria-label','last');
}
//개발사업정보 -- 관리자 목록
function makeDevInfoAdminPagination(paginationDiv,totalPages, currentPageNo, pageCount){
	var totalPagesOption;
	var visiblePage = pageCount;
	var pageCal = totalPages/10;
	var pageCalRemain = totalPages%10;
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
	    	document.devInfoAdminListForm.pageIndex.value = page;
	    	devInfoAdminList();
	    }
	});
	paginationDiv.children().children('.first').children('a').attr('aria-label','first');
	paginationDiv.children().children('.Previous').children('a').attr('aria-label','Previous');
	paginationDiv.children().children('.Next').children('a').attr('aria-label','Next');
	paginationDiv.children().children('.last').children('a').attr('aria-label','last');
}

function devInfoCodeSet(inputParam , dataParam){
	var result;
	inputParam.forEach(function(data, index){
		if(data.legaldongCode){
			if(data.legaldongCode == dataParam){
				result = data.lowestAreaNm;
			}
		}
		if(data.codeId){
			if(data.codeId == dataParam){
				result = data.codeIdNm;
			}
		}
	});
	return result;
}

function devInfoOptionset(codeList,selectTagId,firstStr,selVal){
	var strHtml = ""; 
	switch(selectTagId){
		//---- 개발정보 ----
		//등록 페이지
		case"adDs2":
		case"adDs3":
		case"adArea2":
		//상세 페이지
		case"adDtlDs2":
		//기존 데이터 보호차원
		//case"adDtlDs3":
		case"adDtlArea2":
		//---- 추진내역 -----
		//등록페이지
		case"adInsrtPrtnSeCode":
		case"adInsrtPrtnClCode":
		//상세페이지
		case"adDtlPrtnSeCode":
		case"adDtlPrtnClCode":
			break;
		default:
			strHtml += "<option value=''>" + firstStr + "</option>";
			break;
	}
	
	var idWoNo = selectTagId.substring(0,selectTagId.length-1);
	switch(selectTagId){
		case 'InsrtDsCodeList':
			break;
		case 'devlopIntrstThingSn':
			codeList.forEach(function(data){
				if(selVal == data.intrstThingSn){
					strHtml += "<option value='" + data.intrstThingSn + "'selected>" + data.intrstGroupNm +"</option>";
				}else{
					strHtml += "<option value='" + data.intrstThingSn + "'>" + data.intrstGroupNm +"</option>";	
				}
			});
			break;
//		case'devArea1':
//			codeList.forEach(function(data){
//				//조회 후 Select 값 유지
//				if(selVal == data.legaldongCode){
//					strHtml += "<option value='" + data.legaldongCode + "' selected>" + data.lowestAreaNm + "</option>";
//				}else{
//					strHtml += "<option value='" + data.legaldongCode + "'>" + data.lowestAreaNm + "</option>";	
//				}
//			});
//			break;
		default:
			switch(idWoNo){
				case'ds':
				case'adDs':
				case'adDtlDs':
				//case'cp':
				//case'rw':
				case'invDs':
					var spclTxt;
					codeList.forEach(function(data){
						//하위 Depth level이 있는 특수지구에게는 문자 마지막에 특수문자 부여
						if(idWoNo!='cp' && data.codeLevel == '1' && data.upperCodeAt == 'Y'){
							spclTxt = '&#9660';
						}else{
							spclTxt ='';
						}
						//조회 후 Select 값 유지
						if(data.codeIdNm !='직접입력'){
							if(selVal == data.codeId){
								strHtml += "<option data-unitTy='"+data.unitTy+"' value='" + data.codeId + "' selected>" + data.codeIdNm + " "+spclTxt+"</option>";
							}else{
								strHtml += "<option data-unitTy='"+data.unitTy+"' value='" + data.codeId + "'>" + data.codeIdNm + " "+spclTxt+"</option>";	
							}
						}
					});
					break;
				case'area':
				case'AdmArea':
				case'adDtlArea':
				case'adArea':
				case'invArea':
				case'invAdmArea':
				case'upperMapCodeRewar':
				case'invAdmAreaAdd':
				case'invAdmAreaAddDtl':
				case'upperMapCodeRewardDt':
				case'mapCodeRewardDt':
				case'devArea':
				case'bestDevArea':
				case'nwsArea':
				case'rwdArea':
				case'rewardAdmArea':
					codeList.forEach(function(data){
						//조회 후 Select 값 유지
						if(selVal == data.legaldongCode){
							strHtml += "<option value='" + data.legaldongCode + "' selected>" + data.lowestAreaNm + "</option>";
						}else{
							strHtml += "<option value='" + data.legaldongCode + "'>" + data.lowestAreaNm + "</option>";	
						}
					});
					break;
				default:
					codeList.forEach(function(data){
						if(selVal == data.codeId){
							strHtml += "<option value='" + data.codeId + "' selected>" + data.codeIdNm + "</option>";
						}else{
							strHtml += "<option value='" + data.codeId + "'>" + data.codeIdNm + "</option>";	
						}
					});
					break;
			}
			break;
	}
	$('#'+selectTagId).html(strHtml);
}

function getFilesAjax(tableNm,val){
	var resultData;
	$.ajax({
        type : 'POST',
        url : getContextPath()+"/devlopInfo/selectFiles.do",
        async: false,
        datatype : 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        data: {'tableNm':tableNm,'atchFileId':val},
        success : function(data){
        	resultData = JSON.parse(data);
        },
        error:function(e){
        	console.log(e);
        	alert('atchFiles_조회 실패' + e);
    	},complete:function(){
    	}
	});
	return resultData;
}

function getThumbFilesAjax(tableNm,val){
	var resultData;
	$.ajax({
        type : 'POST',
        url : getContextPath()+"/devlopInfo/selectFiles.do",
        async: false,
        datatype : 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        data: {'tableNm':tableNm,'thumbFileId':val},
        success : function(data){
        	resultData = JSON.parse(data);
        },
        error:function(e){
        	console.log(e);
        	alert('ThumbFiles_조회 실패' + e);
    	},complete:function(){
    	}
	});
	return resultData;
}

function getCodeAjax(codeKey,codeVal){
	var resultData;
	$.ajax({
        type : 'POST',
        url : getContextPath()+"/devlopInfo/selectCodeList.do",
        async: false,
        datatype : 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        data: {'codeKey':codeKey ,'codeVal':codeVal},
        success : function(data){
        	resultData = JSON.parse(data);
        },
        error:function(e){
        	console.log(e);
        	alert('select_CodeList_조회 실패' + e);
    	},complete:function(){
    	}
	});
	return resultData;
}

function adRbAply(frontStr, input){
	var resultHtml = '';
	if(input!=null){
		var strList = input.split(frontStr);
		strList.forEach(function(data,index){
			var subStr = data;
			/*if(strList.length-1 != index){
					subStr = data.substring(0,data.length-4);
				}*/
			//if(frontStr!='◈'){
			resultHtml += subStr;
			/*}else{
					resultHtml += frontStr + subStr;	
				}*/
			if(strList.length != index+1){
				resultHtml += "\r\n";
			}
			
		});
	}
	return resultHtml;
}

function rbAply(frontStr, input){
	var resultHtml = '';
	if(input!=null){
		var strList = input.split(frontStr);
		strList.forEach(function(data,index){
			var subStr = data;
			/*if(strList.length-1 != index){
				subStr = data.substring(0,data.length-4);
			}*/
			resultHtml +="<li>";
			//if(frontStr!='◈'){
			resultHtml += subStr;
			/*}else{
				resultHtml += frontStr + subStr;	
			}*/
			resultHtml +="</li>";
		});
	}
	return resultHtml;
}
function mbGradeChk(mbCode){
	var chkRe = false;
	switch(mbCode){
		case'CM00200002':
		case'CM00200004':
		case'CM00200010':
		case'CM00200011':
			chkRe = true;
			break;
		default:
			break;
	}
	return chkRe;
}

function recDevInfoLogHist(){
	$.ajax({
        type : 'POST',
        url : getContextPath()+"/devlopInfo/selectRecDevInfoLog.do",
        async: false,
        datatype : 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        success : function(data){
        	var resultData = JSON.parse(data);
        	var recDevHtml= '';
        	if(resultData.recLogList){
        		recDevHtml += '<ul>' 
        		resultData.recLogList.forEach(function(data,index){
        			recDevHtml += '<li class="notice-text">'
        			recDevHtml += '<a href="javascript:devInfoDtl(\''+data.devlopInfoSn+'\',\'from\');">'+data.dwkNm+'</a>'
        			recDevHtml += '</li>'
        		});
        		recDevHtml += '</ul>'
        	}else{
        		
        	}
			$('#recClickDevInfo').html(recDevHtml);
        },
        error:function(e){
        	console.log(e);
        	alert('selectRecDevInfoLog_조회 실패' + e);
    	},complete:function(){
    	}
	});
}
function createFileListHtml(chkVal,pathMap,tumbnailDiv,filedownDiv,fileMap,smpleAuth){
	if(fileMap){
		if(!fileMap.fileDisNm){
			fileMap.fileDisNm = 'titleImg';
		}
		$('#devInfoDtl_thumbnail').html();
		/*/file/displayFile.do?filePath=/upload/gzone/images/develop/2015/11/19/0380442621_1.jpg&fileName=0380442621_1.jpg*/
		if(fileMap.fileNm){
			if(fileMap.fileNm.substring(0,3) == "BBS"){
				$('#devInfoTbImg').attr('src','/file/displayFile.do?filePath=/upload/gzone/'+fileMap.filePath+'&fileName='+fileMap.fileNm);
			}else{
				$('#devInfoTbImg').attr('src','/file/displayFile.do?filePath=/upload/gzone/images/develop/'+fileMap.filePath+'/'+fileMap.fileNm+'&fileName='+fileMap.fileNm);
			}
		}
	}
	var tumbnailHtml = '';
	var filedownHtml = '';
	var fileMapList = [];
	
	var newMap = {fileNm:'',filePath:'',fileDisNm:''};
	/*var fruitArr = $.makeArray(fileMap);
	$.map( fruitArr, function(val, i) {
		alert(val);
	})*/
	for(let key in fileMap){
		if(key.includes('fileNm')){
			newMap.fileNm=fileMap[key];
		}else if(key.includes('filePath')){
			newMap.filePath=fileMap[key];
		}else if(key.includes('fileDisNm')){
			newMap.fileDisNm=fileMap[key];
			fileMapList.push(newMap);
			newMap = {fileNm:'',filePath:'',fileDisNm:''};
		}
	}
	
	
	fileMapList.forEach(function(data,index){
		if(data.fileDisNm == 'titleImg' || data.fileDisNm == ''){
		}else{
			filedownHtml +="<div class='fileDiv banner__box down'>";
			if(data.fileNm.substring(0,3) == "BBS"){
				filedownHtml +="<a class='down' data-url=\'"+getContextPath()+"/cmmn/downloadFile.do?orignlFileNm="+data.fileNm+"&fileStreCours=/upload/gzone/"+data.filePath+"\' data-smpleAuth=\'"+smpleAuth+"\'>";
			}else{
				filedownHtml +="<a class='down' data-url=\'"+getContextPath()+"/cmmn/downloadFile.do?orignlFileNm="+data.fileNm+"&fileStreCours="+pathMap.devlopFilePath+"/"+data.filePath+"/"+data.fileNm+"\' data-smpleAuth=\'"+smpleAuth+"\'>";
			}
			filedownHtml +="<strong class='ui-banner__title'>"+data.fileDisNm.replace('.pdf','').replace('.jpg','').replace('.jpeg','')+"</strong>";
			filedownHtml +="</a>";
			filedownHtml +="</div>";
		}
	});
	/*if(!chkVal){
		filedownHtml +="<ul>";
		filedownHtml +='<li class="primium">정보 조회 권한이 없는 등급입니다<img src="'+getContextPath()+'/images/develop/premium.png"></li>';
		filedownHtml +="</ul>";
	}*/
	
	$('#'+filedownDiv).html(filedownHtml);
}
function strToDate(date_str)
{
	if(date_str){
		var totalDate = '';
		var sYear = date_str.substring(0,4);
		var sMonth = date_str.substring(4,6);
		var sDate = date_str.substring(6,8);
		if(sDate == '00' ){
			sDate = '00';
		}
		totalDate += sYear;
		if(sMonth!=""){
			totalDate += '.'+sMonth;
		}
		if(sDate!=""){
			totalDate += '.'+sDate;
		}
		return totalDate;
	}else{
		return null;
	}
}

//데이트형식
function getFormatDate(date){
	 var year = date.getFullYear();
	 var month = (1+date.getMonth());
	 month = month >= 10 ? month : '0' + month;
	 var day = date.getDate(0);
	 day = day >= 10 ? day : '0' + day;
	 return year+'.'+month+'.'+day;
}
//Timestamp to YYYYMMDD
function toStrDate(timestamp) {
    //var d = new Date(timestamp * 1000), // Convert the passed timestamp to milliseconds
    var d = new Date(timestamp), // Convert the passed timestamp to milliseconds
    yyyy = d.getFullYear(),
    mm = ('0' + (d.getMonth() + 1)).slice(-2),  // Months are zero based. Add leading 0.
    dd = ('0' + d.getDate()).slice(-2),         // Add leading 0.
    hh = d.getHours(),
    h = hh,
    min = ('0' + d.getMinutes()).slice(-2),     // Add leading 0.
    ampm = 'AM',
    time;
        
    if (hh > 12) {
        h = hh - 12;
        ampm = 'PM';
    } else if (hh === 12) {
        h = 12;
        ampm = 'PM';
    } else if (hh == 0) {
        h = 12;
    }
    
    // ie: 2013-02-18, 8:35 AM  
    //time = yyyy + '년' + mm + '월' + dd + '일' + h + ':' + min + ' ' + ampm;
    time = yyyy + '-' + mm + '-' + dd;
        
    return time;
}
function scrollAnimate(id,time,pd){
	var location = document.getElementById(id).offsetTop;
	if(pd){	location -= pd;}
	$('#sideAdmin .scroll').animate({scrollTop:location},time);
}
function createPrtnHtmlList(prtnListHtml,subFilePath,data,auth,smpleAuth,dsChkVal){
	prtnListHtml += "<li id='" + data.bsnsPrtnSttusSn + "'>";
	/*if(data.prtnEndde!=""&&data.prtnEndde!=null){
		prtnListHtml += "<div class='tableCellTxt firTxtLong'><strong>" + strToDate(data.prtnBgnde)+" ~ "+strToDate(data.prtnEndde)+"</strong></div>";
	}else{*/
		prtnListHtml += "<div class='tableCellTxt firTxt'><strong>" + strToDate(data.prtnBgnde)+"</strong></div>";
	//}
	if(auth =="Y" || smpleAuth=="Y" || dsChkVal == "true"){
		prtnListHtml += "<div class='tableCellTxt secTxt'><span>" + data.sj + "</span></div>";
	}else{
		prtnListHtml += "<div class='tableCellTxt secTxt'><span class='noAuthTxt'>정보 조회 권한이 없는 등급입니다</span></div>";
	}
	//if(auth =="Y" || smpleAuth=="Y"){
	var aTagChk = false;
		if(data.fileNm!=null && data.fileNm!="" && data.fileNm!="undefined"){
			if(data.fileNm.substring(0,3) == "BBS"){
				prtnListHtml +="<div class='tableCellTxt thirTxt'><a class='down fr' data-url=\'"+getContextPath()+"/cmmn/downloadFile.do?orignlFileNm="+data.fileNm+"&fileStreCours=/upload/gzone/"+data.atchFilePath+"\' data-auth=\'"+auth+"\' data-smpleAuth=\'"+smpleAuth+"\' data-dschkval=\'"+dsChkVal+"\' >";
				prtnListHtml +="파일";	
				prtnListHtml +="</a></div>";
			}else{
				prtnListHtml +="<div class='tableCellTxt thirTxt'><a class='down fr' data-url=\'"+getContextPath()+"/cmmn/downloadFile.do?orignlFileNm="+data.fileNm+"&fileStreCours="+subFilePath+data.atchFilePath+"/"+data.fileNm+"\' data-auth=\'"+auth+"\' data-smpleAuth=\'"+smpleAuth+"\' data-dschkval=\'"+dsChkVal+"\' >";
				prtnListHtml +="파일";	
				prtnListHtml +="</a></div>";
			}
			aTagChk=true;
		}else{
			//첨부파일 아이디로 검색해서 첨부파일 아이디 뿌려줄것
			var fileResult = getFilesAjax("gz_dwk_prtn_sttus",data.atchFileId);
	    	//추진내역 파일 다운로드
			if(fileResult.atchFiles!=null && fileResult.atchFiles.length!=0 ){
	    		prtnListHtml +="<div class='tableCellTxt thirTxt'><a class='down fr' data-url=\'"+getContextPath()+"/cmmn/downloadFile.do?orignlFileNm="+fileResult.atchFiles[0].streFileNm+"&fileStreCours=/upload/gzone/"+fileResult.atchFiles[0].fileStreCours+"\' data-auth=\'"+auth+"\' data-smpleAuth=\'"+smpleAuth+"\' data-dschkval=\'"+dsChkVal+"\'>";
				prtnListHtml +="파일";	
				prtnListHtml +="</a></div>";
				aTagChk=true;
	    	}
		}
	if(aTagChk == false){
		prtnListHtml +="<div class='tableCellTxt thirTxt'>";
		prtnListHtml +="</div>";				
	}
	//}
	prtnListHtml += "</li>";
	return prtnListHtml;
}
function createPrtnPlanHtmlList(prtnPlanListHtml,subFilePath,data,auth,smpleAuth,dsChkVal){
	//prtnListHtml += "<li id='" + data.bsnsPrtnSttusSn + "' style='cursor: pointer;'>";
	prtnPlanListHtml += "<li id='" + data.bsnsPrtnSttusSn + "'>";
	/*if(data.prtnEndde!=""&&data.prtnEndde!=null){
		prtnPlanListHtml += "<div class='tableCellTxt firTxtLong'><strong>" + strToDate(data.prtnBgnde)+" ~ "+strToDate(data.prtnEndde)+"</strong></div>";
	}else{*/
		prtnPlanListHtml += "<div class='tableCellTxt firTxt'><strong>" + strToDate(data.prtnBgnde)+"</strong></div>";
	//}
	if(auth =="Y" || smpleAuth=="Y" || dsChkVal == "true"){
		prtnPlanListHtml += "<div class='tableCellTxt secTxt'><span>" + data.sj + "</span></div>";
	}else{
		prtnPlanListHtml += "<div class='tableCellTxt secTxt'><span class='noAuthTxt'>정보 조회 권한이 없는 등급입니다</span></div>";
	}
	//if(auth =="Y" || smpleAuth=="Y"){
	var aTagChk = false;
		if(data.fileNm!=null && data.fileNm!="" && data.fileNm!="undefined"){
			if(data.fileNm.substring(0,3) == "BBS"){
				prtnPlanListHtml +="<div class='tableCellTxt thirTxt'><a class='down fr' data-url=\'"+getContextPath()+"/cmmn/downloadFile.do?orignlFileNm="+data.fileNm+"&fileStreCours=/upload/gzone/"+data.atchFilePath+"\' data-auth=\'"+auth+"\' data-smpleAuth=\'"+smpleAuth+"\' data-dschkval=\'"+dsChkVal+"\' >";
				//prtnPlanListHtml +="<div class='tableCellTxt thirTxt'><a class='down fr' href=\'"+getContextPath()+"/cmmn/downloadFile.do?orignlFileNm="+data.fileNm+"&fileStreCours="+subFilePath+data.atchFilePath+"/"+data.fileNm+"\' data-smpleAuth=\'"+smpleAuth+"\' data-dschkval=\'"+dsChkVal+"\'>";
				prtnPlanListHtml +="파일";	
				prtnPlanListHtml +="</a></div>";
			}else{
				prtnPlanListHtml +="<div class='tableCellTxt thirTxt'><a class='down fr' data-url=\'"+getContextPath()+"/cmmn/downloadFile.do?orignlFileNm="+data.fileNm+"&fileStreCours="+subFilePath+data.atchFilePath+"/"+data.fileNm+"\' data-auth=\'"+auth+"\' data-smpleAuth=\'"+smpleAuth+"\' data-dschkval=\'"+dsChkVal+"\'>";
				prtnPlanListHtml +="파일";
				prtnPlanListHtml +="</a></div>";
			}
			aTagChk=true;
		}else{
			//첨부파일 아이디로 검색해서 첨부파일 아이디 뿌려줄것`
			var filePlanResult = getFilesAjax("gz_dwk_prtn_sttus",data.atchFileId);
	    	//추진내역 파일 다운로드
	    	if(filePlanResult.atchFiles!=null && filePlanResult.atchFiles.length!=0){
	    		prtnPlanListHtml +="<div class='tableCellTxt thirTxt'><a class='down fr' data-url=\'"+getContextPath()+"/cmmn/downloadFile.do?orignlFileNm="+filePlanResult.atchFiles[0].streFileNm+"&fileStreCours=/upload/gzone/"+filePlanResult.atchFiles[0].fileStreCours+"\' data-smpleAuth=\'"+smpleAuth+"\' data-dschkval=\'"+dsChkVal+"\'>";
				//prtnListHtml +="<strong class='ui-banner__title'>파일</strong>";	
	    		prtnPlanListHtml +="파일";	
	    		prtnPlanListHtml +="</a></div>";
	    		aTagChk=true;
	    	}
		}
		if(aTagChk == false){
			prtnPlanListHtml +="<div class='tableCellTxt thirTxt'>";
			prtnPlanListHtml +="</div>";
		}
	//}
	prtnPlanListHtml += "</li>";
	return prtnPlanListHtml;
}

function removeA(arr) {
    var what, a = arguments, L = a.length, ax;
    while (L > 1 && arr.length) {
        what = a[--L];
        while ((ax= arr.indexOf(what)) !== -1) {
            arr.splice(ax, 1);
        }
    }
    return arr;
}
function blankVal(input){
	if(input==null){
		input = '　';
	}
	return input;
}
function areaAutoCal(input){
	var targetVal = input.value.replace(/,/gi,'');
	var targetLabel = input.parentElement.previousElementSibling.textContent;
	var targetForm = input.form;
	if(targetVal != ""){
		if(!isNaN(targetVal)){
			var meterVal = parseFloat(targetVal);
			if(targetLabel == '길이/km'){
				targetForm.bsnsArMeter.value = addComma(meterVal);
				targetForm.bsnsArPyeong.value = addComma((Number(meterVal) * (1000)).toFixed(0));
			}else{
				targetForm.bsnsArMeter.value = addComma(meterVal);
				targetForm.bsnsArPyeong.value = addComma((Number(meterVal) * (121/400)).toFixed(0));
			}
		}
	}else{
		targetForm.bsnsArMeter.value = '';
	}
}
function getToday(){
	var date = new Date();
	var year = date.getFullYear();
	var month = (1+date.getMonth());
	month = month >= 10 ? month : '0' + month;
	var day = date.getDate(0);
	day = day >= 10 ? day : '0' + day;
	return year+'-'+month+'-'+day;
}

function checkApplcDstrc(dsList,code,smpleInqireAt){
	var chkVal = "";
	var existChk = false;
	if(dsList.length!=0){
		dsList.forEach(function(data, index){
			if(data.codeId == code || smpleInqireAt == "Y"){
				chkVal = "<span class='fr'>상세정보 조회 가능 등급</span>";
				existChk = true;
			}
		});
	}
	if(existChk == false){
		chkVal = "<span class='frG'>기본정보 조회 가능 등급</span>";
	}
	return chkVal;
}

function strToDateKr(date_str)
{
	if(date_str){
		var totalDate = '';
		var sYear = date_str.substring(0,4);
		var sMonth = date_str.substring(4,6);
		var sDate = date_str.substring(6,8);
		if(sDate == '00' ){
			sDate = '00';
		}
		totalDate += sYear+'년 ';
		if(sMonth!=""){
			totalDate += sMonth+'월 ';
		}
		if(sDate!=""){
			totalDate += sDate+'일';
		}
		return totalDate;
	}else{
		return null;
	}
}

//브라우저별 첨부파일 다운로드 Javascript Ver.
function attFileDown(url){
	var browserName = undefined;
	var userAgent = navigator.userAgent;

	switch (true) {
	    case /Trident|MSIE/.test(userAgent):
	        browserName = 'ie';
	        break;

	    case /Edge/.test(userAgent):
	        browserName = 'edge';
	        break;

	    case /Chrome/.test(userAgent):
	        browserName = 'chrome';
	        break;

	    case /Safari/.test(userAgent):
	        browserName = 'safari';
	        break;

	    case /Firefox/.test(userAgent):
	        browserName = 'firefox';
	        break;

	    case /Opera/.test(userAgent):
	        browserName = 'opera';
	        break;

	    default:
	        browserName = 'unknown';
	}


	//ie 브라우저 및 EDGE 브라우저 
	if (browserName == 'ie' || browserName == 'edge') {
		const uri = getContextPath()+url;
		const encoded = encodeURI(uri);
	    //ie11
	    var _window = window.open(encoded, "_blank");
	    /*_window.document.close();
	    _window.document.execCommand('SaveAs', true, "file.hwp" || url);
	    _window.close();*/
	} else {

	    //chrome
	    var filename = url.substring(url.lastIndexOf("/") + 1).split("?")[0];
		var a = document.createElement('a');
        a.href = getContextPath()+url // xhr.response is a blob
        a.download = filename; // Set the file name.
        a.style.display = 'none';
        document.body.appendChild(a);
        a.click();
        delete a;
	}
}

function mouseOverEvent(e){
	var selId = e.currentTarget.id;
	var hoverChk = $("#"+selId).data('hover');
	var pngNo;
	switch(selId){
		case "infoAdd":
			pngNo = 1;
			break;
		case "infoParagraph":
			pngNo = 2;
			break;
		case "infoObject":
			pngNo = 3;
			break;
		case "infoReward":
			pngNo = 4;
			break;
	}
	var img = $("#"+selId).find('img');
	if(hoverChk == 'off'){
		// 2021-05-26 : bmna - 이미지 경로 수정.
		img[0].src = getContextPath() + '/css/gzonei/SRC/images/map/icon-'+pngNo+'_ov.png';
		$("#"+selId).data('hover','on');
		$("#"+selId).css('color','black');
		$("#"+selId).css('background','#fbcb00');
	}else{
		// 2021-05-26 : bmna - 이미지 경로 수정.
		img[0].src = getContextPath() + '/css/gzonei/SRC/images/map/icon-'+pngNo+'.png';
		$("#"+selId).data('hover','off');
		$("#"+selId).css('color','white');
		$("#"+selId).css('background','#7b7b7b');
	}
}

function setUnitLabel(formNm,unitTy){
	var formj = $('#'+formNm);
	var labelTxt1 = '';
	var labelTxt2 = '';
	var labelUnit = '';
	var labelPlaceHolder = '';
	
	switch(unitTy){
	//철도,도로
	case"길이":
		labelTxt1 = '길이/km';
		labelTxt2 = 'km';
		labelUnit = 'm 자동환산 (1㎞ = 1,000m)';
		labelPlaceHolder = '연장(길이)를 입력하세요';
		break;
	case"면적":
		labelTxt1 = '면적/㎡';
		labelTxt2 = '㎡';
		labelUnit = '평 (자동환산 1㎡ * 121/400 = 0.3025평)';
		labelPlaceHolder = '면적(평)을 입력하세요';
		break;
	}
	if(formNm == "devInfoAdminDtlForm"){
		formj.find('#adDtllabtxt1').text(labelTxt1);
		formj.find('#adDtllabtxt2').text(labelTxt2);
		formj.find('#adDtlUnit').text(labelUnit);
		formj.find('[name=bsnsArMeter]').attr('placeholder',labelPlaceHolder);
		formj.find('[name=bsnsArPyeong]').attr('placeholder',labelPlaceHolder);
	}else{
		formj.find('#adInsrtlabtxt1').text(labelTxt1);
		formj.find('#adInsrtlabtxt2').text(labelTxt2);
		formj.find('#adInsrtUnit').text(labelUnit);
		formj.find('[name=bsnsArMeter]').attr('placeholder',labelPlaceHolder);
		formj.find('[name=bsnsArPyeong]').attr('placeholder',labelPlaceHolder);
	}
}

function numberToKorean(number){
    var inputNumber  = number < 0 ? false : number;
    var unitWords    = ['', '만', '억', '조', '경'];
    var splitUnit    = 10000;
    var splitCount   = unitWords.length;
    var resultArray  = [];
    var resultString = '';

    for (var i = 0; i < splitCount; i++){
         var unitResult = (inputNumber % Math.pow(splitUnit, i + 1)) / Math.pow(splitUnit, i);
        unitResult = Math.floor(unitResult);
        if (unitResult > 0){
            resultArray[i] = unitResult;
        }
    }

    for (var i = 0; i < resultArray.length; i++){
        if(!resultArray[i]) continue;
        resultString = String(addComma(resultArray[i])) + unitWords[i] + ' ' +resultString;
    }
    resultString += '원';
    
    return resultString.replace(" 원","원");;
}

function clearWctLct(){
	$('#dtlWctStr').html('');
	$('#dtlLctStr').html('');
	$('#insrtWctStr').html('');
	$('#insrtLctStr').html('');
}

