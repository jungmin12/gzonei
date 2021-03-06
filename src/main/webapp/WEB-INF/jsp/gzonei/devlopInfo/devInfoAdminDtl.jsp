<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<script>
	$(document).ready(function() {
		$.datetimepicker.setLocale('ko');
		$("#mngrLastUpdtPnttm,#expectRewardEra, #adDtlmngrLastUpdtPnttm,#adDtlexpectRewardEra, #dtlDscssRewardBeginDe, #dtlBsnsrcognNtfcDe").datetimepicker({
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
<!-- ???????????? ?????? ???????????? ::S -->
<div id="devInfoAdminDtl" class="devInfoAdmin" style="display:none;">
    <div class="">
        <!-- Modal content-->
        <div class="modal_body">
        	<div class="top_head">
				<!-- <h3 class="h3">???????????? ?????? ??????</h3> -->
				<strong class="headTitle">???????????? ?????? ????????????</strong>
			</div>
            <!-- <div class="modal__header">
               <h4 class="modal__title">???????????? ?????? ??????</h4>
               <div class="modal__close-button"><button type="button" class="close" data-dismiss="modal">??????</button></div>
            </div> -->
            <div class="modal__content" style="word-break: break-all">
                <div class="cont_wrap">
				<form id="devInfoAdminDtlForm" name="devInfoAdminDtlForm" method="post" enctype="multipart/form-data">
				<input type="hidden" name="devlopInfoSn" value=""/>
				<input type="hidden" name="dwkNo" value=""/>
				<input type="hidden" name="wkt" value=""/>
				<input type="hidden" name="atchFileId" value=""/>
				<input type="hidden" name="thumbFileId" value=""/>
				<div class="modal_form">
					<div class="form-horizontal bucket-form">
						<div class="form-group">
							<div class="col-sm-2 control-label"><label class="thumbnailLabel" for="thumbnail">?????? ?????????</label></div>
							<div class="col-sm-8">
				            	<!-- <input type="file" class="thumbFileDtlBtn" name="thumbFile" accept="image/png, image/jpeg"/> -->
								<div class="file-form-group devInfoAdminFileFormG">
									<div class="form-group__upload devInfoAdminFormG">
										<input type="text" readonly="readonly" name="thumbFileNm" class="form-control disabled"> 
										<input type="file" name="thumbFile" id="dtlThumbFile" class="form-upload__file--hidden" accept="image/png, image/jpeg">
									</div>
									<div class="form-input__addon">
										<label for="dtlThumbFile" class="btn btn-sm btn-secondary" data-button="upload">??????????????????</label>
										<button type="button" class="btn btn-sm btn-primary file_del_btn">?????? ??????</button>
									</div>
								</div>
				            </div>
						</div>
						<div class="form-group">
				            <div class="col-sm-2 control-label"><span class="devPilsu"></span><label class="sideAdmTitle" for="bsnsDstrcCode">????????????</label></div>
				            <div class="col-sm-4">
				            	<select name="adDs1" id="adDtlDs1" class="adDtlDs1 form-control" title="????????? ??????">
                                    <option value="">??????</option>
                                </select>
				            </div>
				            <div class="col-sm-3">
				            	<select name="adDs2" id="adDtlDs2" class="adDtlDs2 form-control" title="????????? ??????">
                                    <option value="">??????</option>
                                </select>
				            </div>
				            <div class="col-sm-3">
				            	<select name="adDs3" id="adDtlDs3" class="adDtlDs3 form-control" title="????????? ??????">
                                    <option value="">??????</option>
                                </select>
				            </div>
				        </div>
				        <div class="form-group">
				            <div class="col-sm-2 control-label"><span class="devPilsu"></span><label class="sideAdmTitle" for="area1">???/???</label></div>
				            <div class="col-sm-4">
				            	<select name="area1" id="adDtlArea1" class="adDtlArea1 form-control" title="????????? ??????">
                                    <option value="">??????</option>
                                </select>
				            </div>
				            <div class="col-sm-2 control-label"><span class="devPilsu"></span><label class="sideAdmTitle" for="area2">???/???/???</label></div>
				            <div class="col-sm-4">
				            	<select name="area2" id="adDtlArea2" class="adDtlArea2 form-control" title="????????? ??????">
                                    <option value="">??????</option>
                                </select>
				            </div>
				        </div>
				        <div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="location">????????????</label></div>
				            <div class="col-sm-10">
					            <input name="addr" title="??????" placeholder="????????? ???????????????" class="form-control" />
				            </div>
				        </div>
						<div class="form-group">
				            <div class="col-sm-2 control-label"><span class="devPilsu"></span><label class="sideAdmTitle" for="dwkNm">???????????????</label></div>
				            <div class="col-sm-10">
					            <input name="dwkNm" title="???????????????" placeholder="?????????????????? ???????????????" class="form-control" />
				            </div>
				        </div>
						<div class="form-group">
				            <div class="col-sm-2 control-label"><span class="devPilsu"></span><label class="sideAdmTitle" for="bsnsCn">????????????</label></div>
				            <div class="col-sm-10">
					            <textarea name="bsnsCn" cols='80' title="????????????" placeholder="??????????????? ???????????????" class="form-control" ></textarea>
				            </div>
				        </div>
						<div class="form-group">
				            <div class="col-sm-2 control-label"><label id="adDtllabtxt1" class="sideAdmTitle" for="bsnsAr">??????/???</label></div>
				            <div class="col-sm-3">
				                <input name="bsnsArMeter" title="??????m" placeholder="??????(???)??? ???????????????" class="form-control"/>
				            </div>
				            <div class="col-sm-1 control-label"><label id="adDtllabtxt2" class="sideAdmTitle" for="???">???</label></div>
				            <div class="col-sm-3">
				                <input name="bsnsArPyeong" readOnly title="?????????" placeholder="??????(???)??? ???????????????" class="form-control" />
				            </div>
				            <div class="col-sm-3 control-label"><label id="adDtlUnit" class="sideAdmTitle" for="pyeong">??? (???????????? 1??? * 121/400 = 0.3025???)</label></div>
				        </div>
						<div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="opertnCmpnyCode">?????????</label></div>
				            <div class="col-sm-3">
				            	<select id="adDtlCp1" name="adDtlCp1" class="adDtlCp1 form-control" title="????????? ??????">
                                    <option value="">??????</option>
                                </select>
				            </div>
				            <div class="col-sm-4">
				            	<select id="adDtlCp2" name="adDtlCp2" class="adDtlCp2 form-control" title="????????? ??????">
                                    <option value="">??????</option>
                                </select>
					            <input name="opertnCmpny" title="?????????" placeholder="???????????? ???????????????" class="form-control" />
				            </div>
				        </div>
						<div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="applcLaw">????????????</label></div>
				            <div class="col-sm-10">
					            <input name="applcLaw" title="????????????" placeholder="??????????????? ???????????????" class="form-control" />
				            </div>
				        </div>
						<div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="bsnsMthdCode">????????????</label></div>
				            <div class="col-sm-4">
				                 <select id="adDtlBsnsMthdCode"name="bsnsMthdCode" class="form-control" title="???????????? ??????">
                                    <option>??????</option>
                                </select>
				            </div>
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="bsnsrcognNtfcNm">??????????????????</label></div>
				            <div class="col-sm-4">
								<input type="text" class="form-control" name="bsnsrcognNtfcNm" id="bsnsrcognNtfcNm" placeholder="??????????????????" title="?????????????????? ??????">
				            </div>
				        </div>
						<div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="chrgDept">?????? ??????</label></div>
				            <div class="col-sm-10">
					            <input name="chrgDept" title="?????? ??????" placeholder="?????? ????????? ???????????????" class="form-control" />
				            </div>
				        </div>
						<div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="wrterOpinion">????????? ??????</label></div>
				            <div class="col-sm-10">
					            <input name="wrterOpinion" title="????????? ??????" placeholder="????????? ????????? ???????????????" class="form-control" />
				            </div>
				        </div>
						<div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="gzMent">Gzonei ??????</label></div>
				            <div class="col-sm-10">
					            <textarea name="gzMent" title="Gzonei ??????" placeholder="Gzonei ????????? ???????????????" class="form-control" ></textarea>
				            </div>
				        </div>
						<div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="expectRewardCode">?????? ?????? ??????</label></div>
				            <div class="col-sm-4">
				                <select id="adDtlExpectRewardCode" name="expectRewardCode" class="form-control" title="????????? ??????">
				                    <option value=""></option>
				                </select>
				            </div>
				        </div>
				        <div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="expectRewardEra">?????? ?????? ??????</label></div>
				            <div class="col-sm-4">
	                            <div class="search--calendar">
									<span>
										<input type="text" class="form-control" name="expectRewardEra" id="adDtlexpectRewardEra" placeholder="?????? ?????? ??????" value="" title="?????? ?????? ?????? ??????">
										<button type="button" class="btn__calendar"><span class="skip">????????????</span></button>
									</span>
								</div>
				            </div>
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="mngrLastUpdtPnttm">????????? ????????????</label></div>
				            <div class="col-sm-4">
								<div class="search--calendar">
									<span>
										<input type="text" class="form-control" name="mngrLastUpdtPnttm" id="adDtlmngrLastUpdtPnttm" placeholder="????????? ?????? ?????? " value="" title="????????? ?????? ?????? ??????">
                                    <button type="button" class="btn__calendar"><span class="skip">????????????</span></button>
									</span>
								</div>
				            </div>
				        </div>
						<div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="dwkOthbcAt">?????? ??????</label></div>
				            <div class="col-sm-4">
				                <input class="radio-input" type="radio" id="dtlDwkOthbcAtY" name="dwkOthbcAt" title="??????" value="Y"/>
				                <label class="dwkOthbcAtRadio radio-inline" for="radio1">??????</label>
				                <input class="radio-input" type="radio" id="dtlDwkOthbcAtN" name="dwkOthbcAt" title="?????????" value="N"/>
				                <label class="dwkOthbcAtRadio radio-inline" for="radio2">?????????</label>
				            </div>
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="smpleInqireAt">???????????? ???????????? (??????)</label></div>
				            <div class="col-sm-4">
				                <input class="radio-input" type="radio" id="dtlSmpleInqireAtY" name="smpleInqireAt" title="??????" value="Y"/>
				                <label class="smpleInqireRadio radio-inline" for="radio1">??????</label>
				                <input class="radio-input" type="radio" id="dtlSmpleInqireAtN" name="smpleInqireAt" title="?????????" value="N"/>
				                <label class="smpleInqireRadio radio-inline" for="radio2">?????????</label>
				            </div>
				        </div>
				        <div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="expectRewardEra">???????????????</label></div>
				            <div class="col-sm-4">
	                            <div class="search--calendar">
									<span>
										<input type="text" class="form-control" name="bsnsBgnde" id="dtlBsnsBgnde" placeholder="???????????????" value="" title="??????????????? ??????">
										<button type="button" class="btn__calendar"><span class="skip">????????????</span></button>
									</span>
								</div>
				            </div>
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="mngrLastUpdtPnttm">???????????????</label></div>
				            <div class="col-sm-4">
								<div class="search--calendar">
									<span>
										<input type="text" class="form-control" name="bsnsEndde" id="dtlBsnsEndde" placeholder="???????????????" value="" title="??????????????? ??????">
                                    <button type="button" class="btn__calendar"><span class="skip">????????????</span></button>
									</span>
								</div>
				            </div>
				        </div>
				        <div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="expectRewardEra">?????????????????????</label></div>
				            <div class="col-sm-4">
	                            <div class="search--calendar">
									<span>
										<input type="text" class="form-control" name="dscssRewardBeginDe" id="dtlDscssRewardBeginDe" placeholder="?????????????????????" value="" title="????????????????????? ??????">
										<button type="button" class="btn__calendar"><span class="skip">????????????</span></button>
									</span>
								</div>
				            </div>
				            <!-- <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="mngrLastUpdtPnttm">??????????????????</label></div>
				            <div class="col-sm-4">
								<div class="search--calendar">
									<span>
										<input type="text" class="form-control" name="bsnsrcognNtfcDe" id="dtlBsnsrcognNtfcDe" placeholder="??????????????????" value="" title="?????????????????? ??????">
                                    <button type="button" class="btn__calendar"><span class="skip">????????????</span></button>
									</span>
								</div>
				            </div> -->
				        </div>
				        <div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="wct">?????????</label></div>
				            <div class="col-sm-2">
								<input type="text" class="form-control moneyDev" name="wct" id="dtlWct" placeholder="?????????" value="" title="????????? ??????">
				            </div>
				            <div class="col-sm-2">
								<label id="dtlWctStr" class="sideAdmTitle moneyDevRe" for="wctStr"></label>
				            </div>
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="lct">?????????</label></div>
				            <div class="col-sm-2">
								<input type="text" class="form-control moneyDev" name="lct" id="dtlLct" placeholder="?????????" value="" title="????????? ??????">
				            </div>
				            <div class="col-sm-2">
								<label id="dtlLctStr" class="sideAdmTitle moneyDevRe" for="lctStr"></label>
				            </div>
				        </div>
				        <div class="form-group">
				            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="birth">?????? ??????</label></div>
				            <div class="col-sm-10">
						    	<div id="file-form-upload-dtl" class="form-upload">
						    	 	<div class="file-form-group devInfoAdminFileFormG">
						    	 		<div class="form-group__upload devInfoAdminFormG">
						    	 			<input type="text" readonly="readonly" name="atchFileNm" class="form-control disabled">
						    	 			<input type="file" name="atchFile_1" id="DtlAtchFile_1" class="form-upload__file--hidden">
						    	 		</div>
						    	 		<div class="form-input__addon">
						                    <label for="DtlAtchFile_1" class="btn btn-sm btn-secondary" data-button="upload">??????????????????</label>
						                    <button type="button" class="btn btn-sm btn-primary file_del_btn">?????? ??????</button>
						               </div>
						    	 	</div>
						    	 	<div class="form-group file_author devInfoAdminFileAuth">
						               <input name="fileAuthor" type="hidden" value="CM00200010"/>
						    	 	</div>
						    	 	<div class="file-button">
							    	 	<button type="button" id="devInfoAdminDtlAddFile"  onclick="addFileUploadInput('devInfoAdminDtlAddFile');" class="bgNone">??????</button>
										<button type="button" id="devInfoAdminDtlDelFile" onclick="removeFileUploadInput('devInfoAdminDtlDelFile');" class="bgNone">??????</button>
							    	</div>
						    	</div>
							</div>
				        </div>
					</div>
					<div class="text-center button_align">
						<button type="button" id="devInfoAdDtlShowDtlBtn" class="btn btn-default">???????????? ??????</button>
						<button type="button" id="devInfoAdDtlLayerBtn" class="btn btn-primary">????????? ??????</button>
						<button type="button" id="devInfoAdDtlUpdateBtn" class="btn btn-primary">??????</button>
						<button type="button" id="devInfoAdDtlDelBtn" class="btn btn-primary">??????</button>
						<button type="button" id="devInfoAdDtlCancleBtn" class="btn btn-default">??????</button>
					</div>
				</div>
				</form>
                <div class="top_head">
				  	<h3 class="h_title_sub">???????????? ????????????</h3>
				  	<button type="button" class="btn btn-primary btn-sm" id="showPrtnInsrtBtn">??????</button>
                </div>
                  	<form id="adPrtnListForm" name="adPrtnListForm" method="post">
						<input type="hidden" name="bsnsPrtnSttusSn"/>
						<input type="hidden" name="devlopInfoSn"/>
					</form>
	                <div class="table-scroll">
						<table class="table table-bordered text-center">
							<caption>????????? ?????? ??? ??????, ??????/??????, ??????, ?????????, ???????????? ?????? ??????</caption>
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
									<th scope="col">???????????????</th>
									<th scope="col">???????????????</th>
									<th scope="col">??????</th>
									<th scope="col">???????????????1</th>
									<th scope="col">????????????</th>
									<th scope="col">???????????????</th>
								</tr>
							</thead>
							<tbody id="prtnDtlContents">
							</tbody>
						</table>
					</div>
					<div id="devAdPrtnInsrt" class="devInfoAdPrtn" style="display:none;">
						<div class="top_head">
							<h3 class="h_title_sub">???????????? ??????</h3>
		                </div>
						<div class="modal_form">
							<form id="devAdPrtnInsrtForm" name="devAdPrtnInsrtForm" method="post" enctype="multipart/form-data">
							<input type="hidden" name="dwkNo"/>
							<input type="hidden" name="bsnsPrtnSttusSn"/>
							<input type="hidden" name="devlopInfoSn"/>
							<input type="hidden" name="atchFileId"/>
							<div class="form-horizontal bucket-form">
								<div class="form-group">
						            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="prtnSeCode">????????????</label></div>
						            <div class="col-sm-4">
						                <select id="adInsrtPrtnSeCode" name="prtnSeCode" class="prtnSeCode form-control" title="???????????? ??????">
						                    <option value=""></option>
						                </select>
						            </div>
						        </div>
								<div class="prtnClCodeDiv form-group">
						            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="prtnClCode">???????????? ????????????</label></div>
						            <div class="col-sm-4">
						                <select id="adInsrtPrtnClCode" name="prtnClCode" class="prtnClCode form-control" title="???????????? ??????">
						                    <option value=""></option>
						                </select>
						            </div>
						        </div>
								<div class="form-group">
						            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="sj">??????</label></div>
						            <div class="col-sm-10">
						                <input type="text" name="sj" class="form-control" placeholder="??????" value="" title="?????? ??????">
						            </div>
						        </div>
						        <div class="form-group">
						            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="prtn_bgnde">???????????????</label></div>
						            <div class="col-sm-4">
			                            <div class="search--calendar">
											<span>
												<input type="text" class="form-control" name="prtnBgnde" id="adInsrtPrtnBgnde" placeholder="?????????" value="" title="????????? ??????">
												<button type="button" class="btn__calendar"><span class="skip">????????????</span></button>
											</span>
										</div>
						            </div>
						            <!-- <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="prtnEndde">???????????????</label></div>
						            <div class="col-sm-4">
										<div class="search--calendar">
											<span>
												<input type="text" class="form-control" name="prtnEndde" id="adInsrtPrtnEndde" placeholder="?????????" value="" title="????????? ??????">
		                                    <button type="button" class="btn__calendar"><span class="skip">????????????</span></button>
											</span>
										</div>
						            </div> -->
						        </div>
								<div class="form-group">
						            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="relateKwrd">???????????????</label></div>
						            <div class="col-sm-10">
						                <input type="text" name="relateKwrd" class="form-control" placeholder="???????????????" value="" title="??????????????? ??????">
						            </div>
						        </div>
						        <div class="form-group">
						            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="birth">?????? ??????</label></div>
						            <div class="col-sm-10">
								    	<div id="file-form-upload-prtnInsrt" class="form-upload">
								    	 	<div class="file-form-group devInfoAdminFileFormG">
								    	 		<div class="form-group__upload devInfoAdminFormG">
								    	 			<input type="text" readonly="readonly" name="atchFileNm" class="form-control disabled">
								    	 			<input type="file" name="atchFile_1" id="atchFile_prtnInsrt" class="form-upload__file--hidden">
								    	 		</div>
								    	 		<div class="form-input__addon">
								                    <label id="upload-btn-prtnInsrt" for="atchFile_prtnInsrt" class="btn btn-sm btn-secondary" >??????????????????</label>
								                    <button type="button" class="btn btn-sm btn-primary file_del_btn">?????? ??????</button>
								               </div>
								    	 	</div>
								    	 	<div class="form-group file_author devInfoAdminFileAuth">
								               <input name="fileAuthor" type="hidden" value="CM00200010"/>
								    	 	</div>
								    	 	<!-- <div class="file-button">
									    	 	<button type="button" id="adPrtnInsrtAddFile" class="bgNone addFile">??????</button>
												<button type="button" id="adPrtnInsrtDelFile" class="bgNone delFile">??????</button>
									    	</div> -->
								    	</div>
									</div>
						            <!-- <div class="col-sm-2 control-label"><label for="birth">?????? ??????</label></div>
						            <div class="col-sm-10">
						               <div class="form-upload">
								    	 	<div class="file-form-group">
								    	 		<div class="form-group__upload">
								    	 			<input type="text" readonly="readonly" class="form-control disabled" title="1?????? ?????????">
								    	 			<input type="file" name="file_1" id="atchmn_1" class="form-upload__file--hidden">
								    	 		</div>
								    	 		<div class="form-input__addon">
					                                <label for="atchmn_1" class="btn btn-sm btn-primary" data-button="upload"><span class="skip">1?????? </span>????????????</label>
					                           </div>
								    	 	</div>
								    	 	<div class="file-form-group">
								    	 		<div class="form-group__upload">
								    	 			<input type="text" readonly="readonly" class="form-control disabled" title="1?????? ?????????">
								    	 			<input type="file" name="file_1" id="atchmn_1" class="form-upload__file--hidden">
								    	 		</div>
								    	 		<div class="form-input__addon">
					                                <label for="atchmn_1" class="btn btn-sm btn-primary" data-button="upload"><span class="skip">1?????? </span>????????????</label>
					                           </div>
								    	 	</div>
								    	 	
								    	 	<div class="file-button">
									    	 	<button type="button">??????</button>
									    	 	<button type="button">??????</button>
									    	</div>
								    	</div>
						            </div> -->
						        </div>
							</div>
							</form>
							<div class="text-center button_align">
								<button type="button" id="adInsrtPrtnInsrt" class="btn btn-primary">??????</button>
								<button type="button" id="adInsrtPrtnCancle" class="btn btn-default">??????</button>
							</div>
						</div>
					</div>
					<div id="devAdPrtnDtl" class="devInfoAdPrtn" style="display:none;">
						<div class="top_head">
							<h3 class="h_title_sub">???????????? ????????????</h3>
		                </div>
						<div class="modal_form">
							<form id="devAdPrtnDtlForm" name="devAdPrtnDtlForm" method="post" enctype="multipart/form-data">
							<input type="hidden" name="dwkNo"/>
							<input type="hidden" name="bsnsPrtnSttusSn"/>
							<input type="hidden" name="devlopInfoSn"/>
							<input type="hidden" name="atchFileId"/>
							<div class="form-horizontal bucket-form">
								<div class="form-group">
						            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="prtnSeCode">????????????</label></div>
						            <div class="col-sm-4">
						                <select id="adDtlPrtnSeCode" name="prtnSeCode" class="prtnSeCode form-control" title="???????????? ??????">
						                    <option value=""></option>
						                </select>
						            </div>
						        </div>
								<div class="prtnClCodeDiv form-group">
						            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="prtnClCode">???????????? ????????????</label></div>
						            <div class="col-sm-4">
						                <select id="adDtlPrtnClCode" name="prtnClCode" class="prtnClCode form-control" title="???????????? ??????">
						                    <option value=""></option>
						                </select>
						            </div>
						        </div>
								<div class="form-group">
						            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="sj">??????</label></div>
						            <div class="col-sm-10">
						                <input type="text" name="sj" class="form-control" placeholder="??????" value="" title="?????? ??????">
						            </div>
						        </div>
						        <div class="form-group">
						            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="prtn_bgnde">???????????????</label></div>
						            <div class="col-sm-4">
			                            <div class="search--calendar">
											<span>
												<input type="text" class="form-control" name="prtnBgnde" id="adDtlPrtnBgnde" placeholder="?????????" value="" title="????????? ??????">
												<button type="button" class="btn__calendar"><span class="skip">????????????</span></button>
											</span>
										</div>
						            </div>
						            <!-- <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="prtnEndde">???????????????</label></div>
						            <div class="col-sm-4">
										<div class="search--calendar">
											<span>
												<input type="text" class="form-control" name="prtnEndde" id="adDtlPrtnEndde" placeholder="?????????" value="" title="????????? ??????">
		                                    <button type="button" class="btn__calendar"><span class="skip">????????????</span></button>
											</span>
										</div>
						            </div> -->
						        </div>
								<div class="form-group">
						            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="relateKwrd">???????????????</label></div>
						            <div class="col-sm-10">
						                <input type="text" name="relateKwrd" class="form-control" placeholder="???????????????" value="" title="??????????????? ??????">
						            </div>
						        </div>
						        <div class="form-group">
						            <div class="col-sm-2 control-label"><label class="sideAdmTitle" for="birth">?????? ??????</label></div>
						            <div class="col-sm-10">
								    	<div id="file-form-upload-prtnDtl" class="form-upload">
								    	 	<div class="file-form-group devInfoAdminFileFormG">
								    	 		<div class="form-group__upload devInfoAdminFormG">
								    	 			<input type="text" readonly="readonly" name="atchFileNm" class="form-control disabled">
								    	 			<input type="file" name="atchFile_1" id="atchFile_prtnDtl" class="form-upload__file--hidden">
								    	 		</div>
								    	 		<div class="form-input__addon">
								                    <label id="upload-btn-prtnDtl" for="atchFile_prtnDtl" class="btn btn-sm btn-secondary" data-button="upload">??????????????????</label>
								                    <button type="button" class="btn btn-sm btn-primary file_del_btn">?????? ??????</button>
								               </div>
								    	 	</div>
								    	 	<div class="form-group file_author devInfoAdminFileAuth">
								               <input name="fileAuthor" type="hidden" value="CM00200010"/>
								    	 	</div>
								    	 	<!-- <div class="file-button">
									    	 	<button type="button" id="adPrtnDtlAddFile" class="bgNone addFile">??????</button>
												<button type="button" id="adPrtnDtlDelFile" class="bgNone delFile">??????</button>
									    	</div> -->
								    	</div>
									</div>
						            <!-- <div class="col-sm-2 control-label"><label for="birth">?????? ??????</label></div>
						            <div class="col-sm-10">
						               <div class="form-upload">
								    	 	<div class="file-form-group">
								    	 		<div class="form-group__upload">
								    	 			<input type="text" readonly="readonly" class="form-control disabled" title="1?????? ?????????">
								    	 			<input type="file" name="file_1" id="atchmn_1" class="form-upload__file--hidden">
								    	 		</div>
								    	 		<div class="form-input__addon">
					                                <label for="atchmn_1" class="btn btn-sm btn-primary" data-button="upload"><span class="skip">1?????? </span>????????????</label>
					                           </div>
								    	 	</div>
								    	 	<div class="file-form-group">
								    	 		<div class="form-group__upload">
								    	 			<input type="text" readonly="readonly" class="form-control disabled" title="1?????? ?????????">
								    	 			<input type="file" name="file_1" id="atchmn_1" class="form-upload__file--hidden">
								    	 		</div>
								    	 		<div class="form-input__addon">
					                                <label for="atchmn_1" class="btn btn-sm btn-primary" data-button="upload"><span class="skip">1?????? </span>????????????</label>
					                           </div>
								    	 	</div>
								    	 	
								    	 	<div class="file-button">
									    	 	<button type="button">??????</button>
									    	 	<button type="button">??????</button>
									    	</div>
								    	</div>
						            </div> -->
						        </div>
							</div>
							</form>
							<div class="text-center button_align">
								<button type="button" id="adDtlPrtnUpdate" class="btn btn-primary">??????</button>
								<button type="button" id="adDtlPrtnDelete" class="btn btn-primary">??????</button>
								<button type="button" id="adDtlPrtnCanle" class="btn btn-default">??????</button>
							</div>
						</div>
					</div>
                </div>
            </div>
        </div>
    </div>
</div>
