<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<script>
	$(document).ready(function() {
		$.datetimepicker.setLocale('ko');
		$("#mngrLastUpdtPnttm, #expectRewardEra , #insrtDscssRewardBeginDe, #insrtBsnsrcognNtfcDe").datetimepicker({
			timepicker : false,
			format : 'Y-m-d',
			scrollMonth : false,
			scrollInput : false,
			validateOnBlur: false
		}).on('keydown', function(event){
			onlyNum(this,event);
			});
		$("#insrtBsnsBgnde ,#insrtBsnsEndde").datetimepicker({
			timepicker : false,
			format : 'Y-m-d',
			scrollMonth : false,
			scrollInput : false,
			validateOnBlur: false,
			onShow:function(){
				var end = $("#insrtBsnsEndde").val();
	        	var start = $("#insrtBsnsBgnde").val();
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
<!-- 개발사업 정보 등록 ::S -->
<div id="devInfoAdminInsrt" class="devInfoAdmin" style="display:none;">
    <div>
        <!-- Modal content-->
        <div>
        	<div class="top_head">
				<!-- <h3 class="h3">개발사업 정보 등록</h3> -->
				<strong class="headTitle">개발사업 정보 등록</strong>
			</div>
            <!-- <div class="modal__header">
               <h4 class="modal__title">개발사업 정보 등록</h4>
               <div class="modal__close-button"><button type="button" class="close" data-dismiss="modal">닫기</button></div>
            </div> -->
            <div class="modal__content" style="word-break: break-all">
                <div class="cont_wrap">
				<form id="devInfoAdminInsrtForm" name="devInfoAdminInsrtForm" method="post" enctype="multipart/form-data">
				<input type="hidden" name="wkt" value=""/>
				<input type="hidden" name="atchFileId" value=""/>
				<input type="hidden" name="thumbFileId" value=""/>
				<div class="modal_form">
					<div class="form-horizontal bucket-form">
						<div class="form-group">
							<div class="col-sm-2 control-label"><label class="thumbnailLabel" for="thumbnail">대표 이미지</label></div>
							<div class="col-sm-8">
				            	<!-- <input type="file" class="thumbFileInsrtBtn" name="thumbFile" accept="image/png, image/jpeg"/> -->
								<div class="file-form-group devInfoAdminFileFormG">
									<div class="form-group__upload devInfoAdminFormG">
										<input type="text" readonly="readonly" name="thumbFileNm" class="form-control disabled"> 
										<input type="file" name="thumbFile" id="insrtThumbFile" class="form-upload__file--hidden" accept="image/png, image/jpeg">
									</div>
									<div class="form-input__addon">
										<label for="insrtThumbFile" class="btn btn-sm btn-secondary" data-button="upload">파일첨부하기</label>
										<button type="button" class="btn btn-sm btn-primary file_del_btn">파일 삭제</button>
									</div>
								</div>
							</div>
						</div>
						<div class="form-group">
				            <div class="col-sm-2 control-label"><span class="devPilsu"></span><label class="sideAdmTitle" for="bsnsDstrcCode">사업지구</label></div>
				            <div class="col-sm-4">
				            	<select name="adDs1" id="adDs1" class="adDs1 form-control" title="시행사 선택">
                                    <option value="">전체</option>
                                </select>
				            </div>
				            <div class="col-sm-3">
				            	<select name="adDs2" id="adDs2" class="adDs2 form-control" title="시행사 선택">
                                    <option value="">전체</option>
                                </select>
				            </div>
				            <div class="col-sm-3">
				            	<select name="adDs3" id="adDs3" class="adDs3 form-control" title="시행사 선택">
                                    <option value="">전체</option>
                                </select>
				            </div>
				        </div>
				        <div class="form-group">
				            <div class="col-sm-2 control-label"><span class="devPilsu"></span><label class="sideAdmTitle" for="area1">시/도</label></div>
				            <div class="col-sm-4">
				            	<select name="area1" id="adArea1" class="adArea1 form-control" title="시행사 선택">
                                    <option value="">선택</option>
                                </select>
				            </div>
				            <div class="col-sm-2 control-label"><span class="devPilsu"></span><label class="sideAdmTitle" for="area2">시/군/구</label></div>
				            <div class="col-sm-4">
				            	<select name="area2" id="adArea2" class="adArea2 form-control" title="시행사 선택">
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
				            <div class="col-sm-2 control-label"><span class="devPilsu"></span><label class="sideAdmTitle" for="dwkNo">개발사업명</label></div>
				            <div class="col-sm-10">
					            <input name="dwkNm" title="개발사업명" placeholder="개발사업명을 입력하세요" class="form-control" />
				            </div>
				        </div>
						<div class="form-group">
				            <div class="col-sm-2 control-label"><span class="devPilsu"></span><label class="sideAdmTitle" for="bsnsCn">사업내용</label></div>
				            <div class="col-sm-10">
					            <textarea name="bsnsCn" cols='80' title="사업내용" placeholder="사업내용을 입력하세요" class="form-control" ></textarea>
				            </div>
				        </div>
						<div class="form-group">
				            <div class="col-sm-2 control-label"><label id="adInsrtlabtxt1" class="sideAdmTitle" for="bsnsAr">면적/㎡</label></div>
				            <div class="col-sm-3">
				                <input name="bsnsArMeter" title="면적m" placeholder="면적(평)을 입력하세요" class="form-control" />
				            </div>
				            <div class="col-sm-1 control-label"><label id="adInsrtlabtxt2" class="sideAdmTitle" for="㎡">㎡</label></div>
				            <div class="col-sm-3">
				                <input name="bsnsArPyeong" readOnly title="면적평" placeholder="면적(평)을 입력하세요" class="form-control" />
				            </div>
				            <div class="col-sm-3 control-label"><label id="adInsrtUnit" class="sideAdmTitle" for="pyeong">평  (자동환산 1㎡ * 121/400 = 0.3025평)</label></div>
				        </div>
						<div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="opertnCmpnyCode">시행사</label></div>
				            <div class="col-sm-3">
				            	<select id="adCp1" name="adCp1" class="adCp1 form-control" title="시행사 선택">
                                    <option value="">선택</option>
                                </select>
				            </div>
				            <div class="col-sm-4">
				            	<select id="adCp2" name="adCp2" class="adCp2 form-control" title="시행사 선택">
                                    <option value="">선택</option>
                                </select>
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
				                 <select id="adBsnsMthdCode"name="bsnsMthdCode" class="form-control" title="사업방식 선택">
                                    <option>전체</option>
                                </select>
				            </div>
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="bsnsrcognNtfcNm">사업인정시점</label></div>
				            <div class="col-sm-4">
								<input type="text" class="form-control" name="bsnsrcognNtfcNm" id="bsnsrcognNtfcNm" placeholder="사업인정시점" title="사업인정시점 입력">
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
				                <select id="adExpectRewardCode" name="expectRewardCode" class="form-control" title="연령대 선택">
				                    <option value=""></option>
				                </select>
				            </div>
				        </div>
				        <div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="expectRewardEra">예상 보상 시기</label></div>
				            <div class="col-sm-4">
	                            <div class="search--calendar">
									<span>
										<input type="text" class="form-control" name="expectRewardEra" id="expectRewardEra" placeholder="예상 보상 시기" value="" title="예상 보상 시기 입력">
										<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
									</span>
								</div>
				            </div>
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="mngrLastUpdtPnttm">관리자 수정일자</label></div>
				            <div class="col-sm-4">
								<div class="search--calendar">
									<span>
										<input type="text" class="form-control" name="mngrLastUpdtPnttm" id="mngrLastUpdtPnttm" placeholder="관리자 수정 일자 " value="" title="관리자 수정 일자 입력">
                                    <button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
									</span>
								</div>
				            </div>
				        </div>
						<div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="dwkOthbcAt">공개 여부</label></div>
				            <div class="col-sm-4">
				                <input class="radio-input" type="radio" id="insrtDwkOthbcAtY" name="dwkOthbcAt" title="공개" value="Y" />
				                <label class="dwkOthbcAtRadio radio-inline" for="radio1">공개</label>
				                <input class="radio-input" type="radio" id="insrtDwkOthbcAtN" name="dwkOthbcAt" title="비공개" value="N" checked/>
				                <label class="dwkOthbcAtRadio radio-inline" for="radio2">비공개</label>
				            </div>
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="smpleInqireAt">우리동네 공개여부 (준공)</label></div>
				            <div class="col-sm-4">
				                <input class="radio-input" type="radio" id="insrtSmpleInqireAtY" name="smpleInqireAt" title="공개" value="Y"/>
				                <label class="smpleInqireRadio radio-inline" for="radio1">공개</label>
				                <input class="radio-input" type="radio" id="insrtSmpleInqireAtN" name="smpleInqireAt" title="비공개" value="N" checked/>
				                <label class="smpleInqireRadio radio-inline" for="radio2">비공개</label>
				            </div>
				        </div>
				        <div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="expectRewardEra">사업시작일</label></div>
				            <div class="col-sm-4">
	                            <div class="search--calendar">
									<span>
										<input type="text" class="form-control" name="bsnsBgnde" id="insrtBsnsBgnde" placeholder="사업시작일" value="" title="사업시작일 입력">
										<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
									</span>
								</div>
				            </div>
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="mngrLastUpdtPnttm">사업종료일</label></div>
				            <div class="col-sm-4">
								<div class="search--calendar">
									<span>
										<input type="text" class="form-control" name="bsnsEndde" id="insrtBsnsEndde" placeholder="사업종료일" value="" title="사업종료일 입력">
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
										<input type="text" class="form-control" name="dscssRewardBeginDe" id="insrtDscssRewardBeginDe" placeholder="협의보상개시일" value="" title="협의보상개시일 입력">
										<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
									</span>
								</div>
				            </div>
				            <!-- <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="mngrLastUpdtPnttm">사업인정시점</label></div>
				            <div class="col-sm-4">
								<div class="search--calendar">
									<span>
										<input type="text" class="form-control" name="bsnsrcognNtfcDe" id="insrtBsnsrcognNtfcDe" placeholder="사업인정시점" value="" title="사업인정시점 입력">
                                    <button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
									</span>
								</div>
				            </div> -->
				        </div>
				        <div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="wct">사업비</label></div>
				            <div class="col-sm-2">
								<input type="text" class="form-control moneyDev" name="wct" id="insrtWct" placeholder="사업비" value="" title="사업비 입력">
				            </div>
				            <div class="col-sm-2">
								<label id="insrtWctStr" class="sideAdmTitle moneyDevRe" for="wctStr"></label>
				            </div>
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="lct">용지비</label></div>
				            <div class="col-sm-2">
								<input type="text" class="form-control moneyDev" name="lct" id="insrtLct" placeholder="용지비" value="" title="용지비 입력">
				            </div>
				            <div class="col-sm-2">
								<label id="insrtLctStr" class="sideAdmTitle moneyDevRe" for="lctStr"></label>
				            </div>
				        </div>
				        <div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="birth">첨부 파일</label></div>
				            <div class="col-sm-10">
						    	<div id="file-form-upload-insrt" class="form-upload">
						    	 	<div class="file-form-group devInfoAdminFileFormG">
						    	 		<div class="form-group__upload devInfoAdminFormG">
						    	 			<input type="text" readonly="readonly" name="atchFileNm" class="form-control disabled">
						    	 			<input type="file" name="atchFile_1" id="InsrtAtchFile_1" class="form-upload__file--hidden">
<!-- 						    	 			<input type="file" name="atchFile_1" id="InsrtAtchFile_1" class="form-upload__file--hidden"> -->
						    	 		</div>
						    	 		<div class="form-input__addon">
						                    <label for="InsrtAtchFile_1" class="btn btn-sm btn-secondary" data-button="upload">파일첨부하기</label>
						                    <button type="button" class="btn btn-sm btn-primary file_del_btn">파일 삭제</button>
						               </div>
						    	 	</div>
						    	 	<div class="form-group file_author devInfoAdminFileAuth">
						               <input name="fileAuthor" type="hidden" value="CM00200010"/>
						    	 	</div>
						    	 	<div class="file-button">
							    	 	<button type="button" id="devInfoAdminInsrtAddFile" onclick="addFileUploadInput('devInfoAdminInsrtAddFile');" class="bgNone ">추가</button>
										<button type="button" id="devInfoAdminInsrtDelFile" onclick="removeFileUploadInput('devInfoAdminInsrtDelFile');" class="bgNone ">삭제</button>
							    	</div>
						    	</div>
							</div>
				        </div>
					</div>
					<div class="text-center button_align">
						<!-- <button type="button" id="devInfoAdminInsrtBtn" onclick="addFileUploadInput('devInfoAdminInsrtBtn');" class="btn btn-primary">등록</button>
						<button type="button" id="devInfoAdminCancleBtn" onclick="removeFileUploadInput('devInfoAdminCancleBtn');" class="btn btn-default">취소</button> -->
						<button type="button" id="devInfoAdminInsrtBtn" class="btn btn-primary">등록</button>
						<button type="button" id="devInfoAdminCancleBtn" class="btn btn-default">취소</button>
					</div>
				</div>
				</form>
                  
                </div>
            </div>
        </div>
    </div>
</div>
