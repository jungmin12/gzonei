<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<script>
	$(document).ready(function() {
		$.datetimepicker.setLocale('ko');
		$("#mngrLastUpdtPnttm,#expectRewardEra, #dtlDscssRewardBeginDe, #dtlBsnsrcognNtfcDe").datetimepicker({
			timepicker : false,
			format : 'Y-m-d',
			scrollMonth : false,
			scrollInput : false,
			validateOnBlur: false
		}).on('keydown', function(event){
			onlyNum(this,event);
			});
		
		$("#dtlBsnsBgnde ,#dtlBsnsEndde").datetimepicker({
			timepicker : false,
			format : 'Y-m-d',
			scrollMonth : false,
			scrollInput : false,
			validateOnBlur: false,
			onShow:function(){
	        	var start = $("#dtlBsnsBgnde").val();
				var end = $("#dtlBsnsEndde").val();
	        	this.setOptions({
	    	      dateFormat: 'Y-m-d',
	    	      maxDate: end? end : false,
	    	      minDate: start? start : false
	    	    })
			}
		}).on('keydown', function(event){
			onlyNum(this,event);
			});
		
		$("#adInsrtPrtnBgnde, #adInsrtPrtnEndde").datetimepicker({
			timepicker : false,
			format : 'Y-m-d',
			scrollMonth : false,
			scrollInput : false,
			validateOnBlur: false,
			onShow:function(){
	        	var start = $("#adInsrtPrtnBgnde").val();
				var end = $("#adInsrtPrtnEndde").val();
	        	this.setOptions({
	    	      dateFormat: 'Y-m-d',
	    	      maxDate: end? end : false,
	    	      minDate: start? start : false
	    	    })
			}
		}).on('keydown', function(event){
			onlyNum(this,event);
			});
		$("#adDtlPrtnBgnde, #adDtlPrtnEndde").datetimepicker({
			timepicker : false,
			format : 'Y-m-d',
			scrollMonth : false,
			scrollInput : false,
			validateOnBlur: false,
			onShow:function(){
	        	var start = $("#adDtlPrtnBgnde").val();
				var end = $("#adDtlPrtnEndde").val();
	        	this.setOptions({
	    	      dateFormat: 'Y-m-d',
	    	      maxDate: end? end : false,
	    	      minDate: start? start : false
	    	    })
			}
		}).on('keydown', function(event){
			onlyNum(this,event);
			});

	});
</script>
<!-- 개발사업 정보 상세보기 ::S -->
<div id="devInfoAdminDtl" class="devInfoAdmin" style="display:none;">
    <div class="">
        <!-- Modal content-->
        <div class="modal_body">
        	<div class="top_head">
				<!-- <h3 class="h3">개발사업 정보 등록</h3> -->
				<strong class="headTitle">개발사업 정보 상세보기</strong>
			</div>
            <!-- <div class="modal__header">
               <h4 class="modal__title">개발사업 정보 등록</h4>
               <div class="modal__close-button"><button type="button" class="close" data-dismiss="modal">닫기</button></div>
            </div> -->
            <div class="modal__content" style="word-break: break-all">
                <div class="cont_wrap">
				<form id="devInfoAdminDtlForm" name="devInfoAdminDtlForm" method="post" enctype="multipart/form-data">
				<input type="hidden" name="devlopInfoSn" value=""/>
				<input type="hidden" name="dwkNo" value=""/>
				<input type="hidden" name="wkt" value=""/>
				<input type="hidden" name="atchFileId" value=""/>
				<div class="modal_form">
					<div class="form-horizontal bucket-form">
						<div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="bsnsDstrcCode">사업지구</label></div>
				            <div class="col-sm-4">
				            	<select name="adDs1" id="adDtlDs1" class="adDtlDs1 form-control" title="시행사 선택">
                                    <option value="">전체</option>
                                </select>
				            </div>
				            <div class="col-sm-3">
				            	<select name="adDs2" id="adDtlDs2" class="adDtlDs2 form-control" title="시행사 선택">
                                    <option value="">전체</option>
                                </select>
				            </div>
				            <div class="col-sm-3">
				            	<select name="adDs3" id="adDtlDs3" class="adDtlDs3 form-control" title="시행사 선택">
                                    <option value="">전체</option>
                                </select>
				            </div>
				        </div>
				        <div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="area1">시/도</label></div>
				            <div class="col-sm-4">
				            	<select name="area1" id="adDtlArea1" class="adDtlArea1 form-control" title="시행사 선택">
                                    <option value="">선택</option>
                                </select>
				            </div>
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="area2">시/군/구</label></div>
				            <div class="col-sm-4">
				            	<select name="area2" id="adDtlArea2" class="adDtlArea2 form-control" title="시행사 선택">
                                    <option value="">선택</option>
                                </select>
				            </div>
				        </div>
				        <div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="location">상세주소</label></div>
				            <div class="col-sm-10">
					            <input name="addr" title="위치" placeholder="위치를 입력하세요" class="form-control" />
				            </div>
				        </div>
						<div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="dwkNm">개발사업명</label></div>
				            <div class="col-sm-10">
					            <input name="dwkNm" title="개발사업명" placeholder="개발사업명을 입력하세요" class="form-control" />
				            </div>
				        </div>
						<div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="bsnsCn">사업내용</label></div>
				            <div class="col-sm-10">
					            <textarea name="bsnsCn" cols='80' title="사업내용" placeholder="사업내용을 입력하세요" class="form-control" ></textarea>
				            </div>
				        </div>
						<div class="form-group">
				            <div class="col-sm-2 control-label"><label id="adDtllabtxt1" class="sideAdmTitle" for="bsnsAr">면적/㎡</label></div>
				            <div class="col-sm-3">
				                <input name="bsnsArMeter" title="면적m" placeholder="면적(평)을 입력하세요" class="form-control"/>
				            </div>
				            <div class="col-sm-1 control-label"><label id="adDtllabtxt2" class="sideAdmTitle" for="㎡">㎡</label></div>
				            <div class="col-sm-3">
				                <input name="bsnsArPyeong" readOnly title="면적평" placeholder="면적(평)을 입력하세요" class="form-control" />
				            </div>
				            <div class="col-sm-3 control-label"><label id="adDtlUnit" class="sideAdmTitle" for="pyeong">평 (자동환산 1㎡ * 121/400 = 0.3025평)</label></div>
				        </div>
						<div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="opertnCmpnyCode">시행사</label></div>
				            <div class="col-sm-3">
				            	<select id="adDtlOpertnCmpnyCode" name="opertnCmpnyCode" class="form-control" title="시행사 선택">
                                    <option value="">선택</option>
                                </select>
				            </div>
				            <div class="col-sm-7">
					            <input name="opertnCmpny" title="시행사" placeholder="시행사를 입력하세요" class="form-control" />
				            </div>
				        </div>
						<div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="applcLaw">적용법률</label></div>
				            <div class="col-sm-10">
					            <input name="applcLaw" title="적용법률" placeholder="적용법률을 입력하세요" class="form-control" />
				            </div>
				        </div>
						<div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="bsnsMthdCode">사업방식</label></div>
				            <div class="col-sm-4">
				                 <select id="adDtlBsnsMthdCode"name="bsnsMthdCode" class="form-control" title="사업방식 선택">
                                    <option>전체</option>
                                </select>
				            </div>
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="bsnsrcognNtfcNm">사업인증 고시일</label></div>
				            <div class="col-sm-4">
								<input type="text" class="form-control" name="bsnsrcognNtfcNm" id="bsnsrcognNtfcNm" placeholder="사업인증고시일" title="사업인증고시일 입력">
				            </div>
				        </div>
						<div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="chrgDept">담당 부서</label></div>
				            <div class="col-sm-10">
					            <input name="chrgDept" title="담당 부서" placeholder="담당 부서를 입력하세요" class="form-control" />
				            </div>
				        </div>
						<div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="wrterOpinion">작성자 의견</label></div>
				            <div class="col-sm-10">
					            <input name="wrterOpinion" title="작성자 의견" placeholder="작성자 의견을 입력하세요" class="form-control" />
				            </div>
				        </div>
						<div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="gzMent">Gzonei 멘트</label></div>
				            <div class="col-sm-10">
					            <textarea name="gzMent" title="Gzonei 멘트" placeholder="Gzonei 멘트를 입력하세요" class="form-control" ></textarea>
				            </div>
				        </div>
						<div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="expectRewardCode">예상 보상 상태</label></div>
				            <div class="col-sm-4">
				                <select id="adDtlExpectRewardCode" name="expectRewardCode" class="form-control" title="연령대 선택">
				                    <option value=""></option>
				                </select>
				            </div>
				        </div>
				        <div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="expectRewardEra">예상 보상 시기</label></div>
				            <div class="col-sm-4">
	                            <div class="search--calendar">
									<span>
										<input type="text" class="form-control" name="expectRewardEra" id="adDtlexpectRewardEra" placeholder="예상 보상 시기" value="" title="예상 보상 시기 입력">
										<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
									</span>
								</div>
				            </div>
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="mngrLastUpdtPnttm">관리자 수정일자</label></div>
				            <div class="col-sm-4">
								<div class="search--calendar">
									<span>
										<input type="text" class="form-control" name="mngrLastUpdtPnttm" id="adDtlmngrLastUpdtPnttm" placeholder="관리자 수정 일자 " value="" title="관리자 수정 일자 입력">
                                    <button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
									</span>
								</div>
				            </div>
				        </div>
						<div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="dwkOthbcAt">공개 여부</label></div>
				            <div class="col-sm-4">
				                <input class="radio-input" type="radio" id="dtlDwkOthbcAtY" name="dwkOthbcAt" title="공개" value="Y" checked/>
				                <label class="dwkOthbcAtRadio radio-inline" for="radio1">공개</label>
				                <input class="radio-input" type="radio" id="dtlDwkOthbcAtN" name="dwkOthbcAt" title="비공개" value="N"/>
				                <label class="dwkOthbcAtRadio radio-inline" for="radio2">비공개</label>
				            </div>
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="smpleInqireAt">우리동네 공개여부</label></div>
				            <div class="col-sm-4">
				                <input class="radio-input" type="radio" id="dtlSmpleInqireAtY" name="smpleInqireAt" title="공개" value="Y"/>
				                <label class="smpleInqireRadio radio-inline" for="radio1">공개</label>
				                <input class="radio-input" type="radio" id="dtlSmpleInqireAtN" name="smpleInqireAt" title="비공개" value="N" checked/>
				                <label class="smpleInqireRadio radio-inline" for="radio2">비공개</label>
				            </div>
				        </div>
				        <div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="expectRewardEra">사업시작일</label></div>
				            <div class="col-sm-4">
	                            <div class="search--calendar">
									<span>
										<input type="text" class="form-control" name="bsnsBgnde" id="dtlBsnsBgnde" placeholder="사업시작일" value="" title="사업시작일 입력">
										<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
									</span>
								</div>
				            </div>
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="mngrLastUpdtPnttm">사업종료일</label></div>
				            <div class="col-sm-4">
								<div class="search--calendar">
									<span>
										<input type="text" class="form-control" name="bsnsEndde" id="dtlBsnsEndde" placeholder="사업종료일" value="" title="사업종료일 입력">
                                    <button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
									</span>
								</div>
				            </div>
				        </div>
				        <div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="expectRewardEra">협의보상개시일</label></div>
				            <div class="col-sm-4">
	                            <div class="search--calendar">
									<span>
										<input type="text" class="form-control" name="dscssRewardBeginDe" id="dtlDscssRewardBeginDe" placeholder="협의보상개시일" value="" title="협의보상개시일 입력">
										<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
									</span>
								</div>
				            </div>
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="mngrLastUpdtPnttm">사업인정시점</label></div>
				            <div class="col-sm-4">
								<div class="search--calendar">
									<span>
										<input type="text" class="form-control" name="bsnsrcognNtfcDe" id="dtlBsnsrcognNtfcDe" placeholder="사업인정시점" value="" title="사업인정시점 입력">
                                    <button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
									</span>
								</div>
				            </div>
				        </div>
				        <div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="wct">사업비</label></div>
				            <div class="col-sm-4">
								<input type="text" class="form-control money" name="wct" id="dtlWct" placeholder="사업비" value="" title="사업비 입력">
				            </div>
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="lct">용지비</label></div>
				            <div class="col-sm-4">
								<input type="text" class="form-control money" name="lct" id="dtlLct" placeholder="용지비" value="" title="용지비 입력">
				            </div>
				        </div>
				        <div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="birth">첨부 파일</label></div>
				            <div class="col-sm-10">
						    	<div id="file-form-upload-dtl" class="form-upload">
						    	 	<div class="file-form-group devInfoAdminFileFormG">
						    	 		<div class="form-group__upload devInfoAdminFormG">
						    	 			<input type="text" readonly="readonly" name="atchFileNm" class="form-control disabled">
						    	 			<input type="file" name="atchFile_1" id="DtlAtchFile_1" class="form-upload__file--hidden">
						    	 		</div>
						    	 		<div class="form-input__addon">
						                    <label for="DtlAtchFile_1" class="btn btn-sm btn-secondary" data-button="upload">파일첨부하기</label>
						                    <button type="button" class="btn btn-sm btn-primary file_del_btn">파일 삭제</button>
						               </div>
						    	 	</div>
						    	 	<div class="form-group file_author devInfoAdminFileAuth">
						               <input name="fileAuthor" type="hidden" value="CM00200010"/>
						    	 	</div>
						    	 	<div class="file-button">
							    	 	<button type="button" id="devInfoAdminDtlAddFile"  onclick="addFileUploadInput('devInfoAdminDtlAddFile');" class="bgNone">추가</button>
										<button type="button" id="devInfoAdminDtlDelFile" onclick="removeFileUploadInput('devInfoAdminDtlDelFile');" class="bgNone">삭제</button>
							    	</div>
						    	</div>
							</div>
				        </div>
					</div>
					<div class="text-center button_align">
						<button type="button" id="devInfoAdDtlLayerBtn" class="btn btn-primary">레이어 수정</button>
						<button type="button" id="devInfoAdDtlUpdateBtn" class="btn btn-primary">수정</button>
						<button type="button" id="devInfoAdDtlDelBtn" class="btn btn-primary">삭제</button>
						<button type="button" id="devInfoAdDtlCancleBtn" class="btn btn-default">취소</button>
					</div>
				</div>
				</form>
                <div class="top_head">
				  	<h3 class="h_title_sub">개발사업 추진내역</h3>
				  	<button type="button" class="btn btn-primary btn-sm" id="showPrtnInsrtBtn">추가</button>
                </div>
                  	<form id="adPrtnListForm" name="adPrtnListForm" method="post">
						<input type="hidden" name="bsnsPrtnSttusSn"/>
						<input type="hidden" name="devlopInfoSn"/>
					</form>
	                <div class="table-scroll">
						<table class="table table-bordered text-center">
							<caption>테이블 안내 – 구분, 부서/직위, 성명, 연락처, 홈페이지 정보 제공</caption>
							<colgroup>
								<col style="width:10%">
								<col style="width:10%">
								<col style="width:auto">
								<col style="width:10%">
								<col style="width:10%">
								<col style="width:20%">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">추진시작일</th>
									<th scope="col">추진종료일</th>
									<th scope="col">제목</th>
									<th scope="col">연관키워드1</th>
									<th scope="col">추진구분</th>
									<th scope="col">첨부파일명</th>
								</tr>
							</thead>
							<tbody id="prtnDtlContents">
							</tbody>
						</table>
					</div>
					<div id="devAdPrtnInsrt" class="devInfoAdPrtn" style="display:none;">
						<div class="top_head">
							<h3 class="h_title_sub">추진내역 등록</h3>
		                </div>
						<div class="modal_form">
							<form id="devAdPrtnInsrtForm" name="devAdPrtnInsrtForm" method="post" enctype="multipart/form-data">
							<input type="hidden" name="dwkNo"/>
							<input type="hidden" name="bsnsPrtnSttusSn"/>
							<input type="hidden" name="devlopInfoSn"/>
							<input type="hidden" name="atchFileId"/>
							<div class="form-horizontal bucket-form">
								<div class="form-group">
						            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="prtnSeCode">추진구분</label></div>
						            <div class="col-sm-4">
						                <select id="adInsrtPrtnSeCode" name="prtnSeCode" class="prtnSeCode form-control" title="추진구분 선택">
						                    <option value=""></option>
						                </select>
						            </div>
						        </div>
								<div class="prtnClCodeDiv form-group">
						            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="prtnClCode">추진내역 분류코드</label></div>
						            <div class="col-sm-4">
						                <select id="adInsrtPrtnClCode" name="prtnClCode" class="prtnClCode form-control" title="추진구분 선택">
						                    <option value=""></option>
						                </select>
						            </div>
						        </div>
								<div class="form-group">
						            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="sj">제목</label></div>
						            <div class="col-sm-10">
						                <input type="text" name="sj" class="form-control" placeholder="제목" value="" title="제목 입력">
						            </div>
						        </div>
						        <div class="form-group">
						            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="prtn_bgnde">추진시작일</label></div>
						            <div class="col-sm-4">
			                            <div class="search--calendar">
											<span>
												<input type="text" class="form-control" name="prtnBgnde" id="adInsrtPrtnBgnde" placeholder="시작일" value="" title="시작일 입력">
												<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
											</span>
										</div>
						            </div>
						            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="prtnEndde">추진종료일</label></div>
						            <div class="col-sm-4">
										<div class="search--calendar">
											<span>
												<input type="text" class="form-control" name="prtnEndde" id="adInsrtPrtnEndde" placeholder="종료일" value="" title="종료일 입력">
		                                    <button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
											</span>
										</div>
						            </div>
						        </div>
								<div class="form-group">
						            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="relateKwrd">연관키워드</label></div>
						            <div class="col-sm-10">
						                <input type="text" name="relateKwrd" class="form-control" placeholder="연관키워드" value="" title="연관키워드 입력">
						            </div>
						        </div>
						        <div class="form-group">
						            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="birth">첨부 파일</label></div>
						            <div class="col-sm-10">
								    	<div id="file-form-upload-prtnInsrt" class="form-upload">
								    	 	<div class="file-form-group devInfoAdminFileFormG">
								    	 		<div class="form-group__upload devInfoAdminFormG">
								    	 			<input type="text" readonly="readonly" name="atchFileNm" class="form-control disabled">
								    	 			<input type="file" name="atchFile_1" id="atchFile_prtnInsrt" class="form-upload__file--hidden">
								    	 		</div>
								    	 		<div class="form-input__addon">
								                    <label id="upload-btn-prtnInsrt" for="atchFile_prtnInsrt" class="btn btn-sm btn-secondary" >파일첨부하기</label>
								                    <button type="button" class="btn btn-sm btn-primary file_del_btn">파일 삭제</button>
								               </div>
								    	 	</div>
								    	 	<div class="form-group file_author devInfoAdminFileAuth">
								               <input name="fileAuthor" type="hidden" value="CM00200010"/>
								    	 	</div>
								    	 	<!-- <div class="file-button">
									    	 	<button type="button" id="adPrtnInsrtAddFile" class="bgNone addFile">추가</button>
												<button type="button" id="adPrtnInsrtDelFile" class="bgNone delFile">삭제</button>
									    	</div> -->
								    	</div>
									</div>
						            <!-- <div class="col-sm-2 control-label"><label for="birth">첨부 파일</label></div>
						            <div class="col-sm-10">
						               <div class="form-upload">
								    	 	<div class="file-form-group">
								    	 		<div class="form-group__upload">
								    	 			<input type="text" readonly="readonly" class="form-control disabled" title="1번째 파일명">
								    	 			<input type="file" name="file_1" id="atchmn_1" class="form-upload__file--hidden">
								    	 		</div>
								    	 		<div class="form-input__addon">
					                                <label for="atchmn_1" class="btn btn-sm btn-primary" data-button="upload"><span class="skip">1번째 </span>파일선택</label>
					                           </div>
								    	 	</div>
								    	 	<div class="file-form-group">
								    	 		<div class="form-group__upload">
								    	 			<input type="text" readonly="readonly" class="form-control disabled" title="1번째 파일명">
								    	 			<input type="file" name="file_1" id="atchmn_1" class="form-upload__file--hidden">
								    	 		</div>
								    	 		<div class="form-input__addon">
					                                <label for="atchmn_1" class="btn btn-sm btn-primary" data-button="upload"><span class="skip">1번째 </span>파일선택</label>
					                           </div>
								    	 	</div>
								    	 	
								    	 	<div class="file-button">
									    	 	<button type="button">추가</button>
									    	 	<button type="button">삭제</button>
									    	</div>
								    	</div>
						            </div> -->
						        </div>
							</div>
							</form>
							<div class="text-center button_align">
								<button type="button" id="adInsrtPrtnInsrt" class="btn btn-primary">등록</button>
								<button type="button" id="adInsrtPrtnCancle" class="btn btn-default">취소</button>
							</div>
						</div>
					</div>
					<div id="devAdPrtnDtl" class="devInfoAdPrtn" style="display:none;">
						<div class="top_head">
							<h3 class="h_title_sub">추진내역 상세보기</h3>
		                </div>
						<div class="modal_form">
							<form id="devAdPrtnDtlForm" name="devAdPrtnDtlForm" method="post" enctype="multipart/form-data">
							<input type="hidden" name="dwkNo"/>
							<input type="hidden" name="bsnsPrtnSttusSn"/>
							<input type="hidden" name="devlopInfoSn"/>
							<input type="hidden" name="atchFileId"/>
							<div class="form-horizontal bucket-form">
								<div class="form-group">
						            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="prtnSeCode">추진구분</label></div>
						            <div class="col-sm-4">
						                <select id="adDtlPrtnSeCode" name="prtnSeCode" class="prtnSeCode form-control" title="추진구분 선택">
						                    <option value=""></option>
						                </select>
						            </div>
						        </div>
								<div class="prtnClCodeDiv form-group">
						            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="prtnClCode">추진내역 분류코드</label></div>
						            <div class="col-sm-4">
						                <select id="adDtlPrtnClCode" name="prtnClCode" class="prtnClCode form-control" title="추진구분 선택">
						                    <option value=""></option>
						                </select>
						            </div>
						        </div>
								<div class="form-group">
						            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="sj">제목</label></div>
						            <div class="col-sm-10">
						                <input type="text" name="sj" class="form-control" placeholder="제목" value="" title="제목 입력">
						            </div>
						        </div>
						        <div class="form-group">
						            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="prtn_bgnde">추진시작일</label></div>
						            <div class="col-sm-4">
			                            <div class="search--calendar">
											<span>
												<input type="text" class="form-control" name="prtnBgnde" id="adDtlPrtnBgnde" placeholder="시작일" value="" title="시작일 입력">
												<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
											</span>
										</div>
						            </div>
						            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="prtnEndde">추진종료일</label></div>
						            <div class="col-sm-4">
										<div class="search--calendar">
											<span>
												<input type="text" class="form-control" name="prtnEndde" id="adDtlPrtnEndde" placeholder="종료일" value="" title="종료일 입력">
		                                    <button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
											</span>
										</div>
						            </div>
						        </div>
								<div class="form-group">
						            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="relateKwrd">연관키워드</label></div>
						            <div class="col-sm-10">
						                <input type="text" name="relateKwrd" class="form-control" placeholder="연관키워드" value="" title="연관키워드 입력">
						            </div>
						        </div>
						        <div class="form-group">
						            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="birth">첨부 파일</label></div>
						            <div class="col-sm-10">
								    	<div id="file-form-upload-prtnDtl" class="form-upload">
								    	 	<div class="file-form-group devInfoAdminFileFormG">
								    	 		<div class="form-group__upload devInfoAdminFormG">
								    	 			<input type="text" readonly="readonly" name="atchFileNm" class="form-control disabled">
								    	 			<input type="file" name="atchFile_1" id="atchFile_prtnDtl" class="form-upload__file--hidden">
								    	 		</div>
								    	 		<div class="form-input__addon">
								                    <label id="upload-btn-prtnDtl" for="atchFile_prtnDtl" class="btn btn-sm btn-secondary" data-button="upload">파일첨부하기</label>
								                    <button type="button" class="btn btn-sm btn-primary file_del_btn">파일 삭제</button>
								               </div>
								    	 	</div>
								    	 	<div class="form-group file_author devInfoAdminFileAuth">
								               <input name="fileAuthor" type="hidden" value="CM00200010"/>
								    	 	</div>
								    	 	<!-- <div class="file-button">
									    	 	<button type="button" id="adPrtnDtlAddFile" class="bgNone addFile">추가</button>
												<button type="button" id="adPrtnDtlDelFile" class="bgNone delFile">삭제</button>
									    	</div> -->
								    	</div>
									</div>
						            <!-- <div class="col-sm-2 control-label"><label for="birth">첨부 파일</label></div>
						            <div class="col-sm-10">
						               <div class="form-upload">
								    	 	<div class="file-form-group">
								    	 		<div class="form-group__upload">
								    	 			<input type="text" readonly="readonly" class="form-control disabled" title="1번째 파일명">
								    	 			<input type="file" name="file_1" id="atchmn_1" class="form-upload__file--hidden">
								    	 		</div>
								    	 		<div class="form-input__addon">
					                                <label for="atchmn_1" class="btn btn-sm btn-primary" data-button="upload"><span class="skip">1번째 </span>파일선택</label>
					                           </div>
								    	 	</div>
								    	 	<div class="file-form-group">
								    	 		<div class="form-group__upload">
								    	 			<input type="text" readonly="readonly" class="form-control disabled" title="1번째 파일명">
								    	 			<input type="file" name="file_1" id="atchmn_1" class="form-upload__file--hidden">
								    	 		</div>
								    	 		<div class="form-input__addon">
					                                <label for="atchmn_1" class="btn btn-sm btn-primary" data-button="upload"><span class="skip">1번째 </span>파일선택</label>
					                           </div>
								    	 	</div>
								    	 	
								    	 	<div class="file-button">
									    	 	<button type="button">추가</button>
									    	 	<button type="button">삭제</button>
									    	</div>
								    	</div>
						            </div> -->
						        </div>
							</div>
							</form>
							<div class="text-center button_align">
								<button type="button" id="adDtlPrtnUpdate" class="btn btn-primary">수정</button>
								<button type="button" id="adDtlPrtnDelete" class="btn btn-primary">삭제</button>
								<button type="button" id="adDtlPrtnCanle" class="btn btn-default">취소</button>
							</div>
						</div>
					</div>
                </div>
            </div>
        </div>
    </div>
</div>
