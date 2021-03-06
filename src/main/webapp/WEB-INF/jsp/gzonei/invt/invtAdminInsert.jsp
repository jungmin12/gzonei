<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<!-- 경/공매 쓰기 -->
<div id="invtAdminInsert" class="scroll" style="display: none;">
	<strong class="title">투자정보 등록하기</strong>
	<div class="modal__content" style="word-break: break-all">
		<div class="cont_wrap">
			<form id="invInsertDiv" name="invInsertDiv">
				<div class="modal_form">
					<div class="form-horizontal bucket-form">
						<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2">
								<label class="sideAdmTitle" for="select">경/공매 구분​</label>
							</div>
							<div class="col-sm-4">
								<input class="radio-input aucPblsalSeCode" type="radio" id="radioSeCdoe1" name="aucPblsalSeCode" value="CM00110001" checked>
									<label class="radio-inline" for="radioSeCdoe1">경매</label>
								<input class="radio-input aucPblsalSeCode" type="radio" id="radioSeCdoe2" name="aucPblsalSeCode" value="CM00110002" >
									<label class="radio-inline" for="radioSeCdoe2" >공매</label>
							</div>
							<div class="col-sm-4">
								<label class="btn btn-sm btn-secondary" id="showModalBtn"
									name="showModalBtn" data-ly-btn="invt-search"><span class="skip"></span>개발정보 찾기</label>
								<label class="btn btn-sm btn-secondary" id="PreViewdevBtnI"
									name="PreViewdevBtn"><span class="skip"></span>개발정보 미리보기</label>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2">
								<label class="sideAdmTitle" for="select">주 소​</label>
							</div>
							<div class="col-sm-2">
								<select name="invAdmAreaAdd1" id="invAdmAreaAdd1"
									class="form-control invAdmAreaAdd1">
								</select>
							</div>
							<div class="col-sm-2">
								<select name="invAdmAreaAdd2" id="invAdmAreaAdd2"
									class="form-control invAdmAreaAdd2">
									<option value="">-</option>
								</select>
							</div>
							<div class="col-sm-5">
								<input type="text" name="addr" title="상세 주소 입력"
									class="form-control" placeholder="Ex)당산동6가 236 외 2필지 " onchange="findAddrAuto()">
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2">
								<label class="sideAdmTitle" for="select">대표 위치​</label>
							</div>
							<div class="col-sm-6">
								<input type="text" id="loc" name="loc" title="대표 위치 입력"
									class="form-control" placeholder="Ex)서울특별시 영등포구 당산동6가 236">
							</div>
							<div class="col-sm-1">
								<label class="btn btn-sm btn-secondary" id="findLoc"
									name="findeLoc"><span class="skip"></span>위치입력</label>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2">
								<label class="sideAdmTitle" for="select">경도(X)​</label>
							</div>
							<div class="col-sm-2 control-label col-lg-2">
								<input type="text" class="form-control disabled" name="lo" readonly
									id="lo">
							</div>
							<div class="col-sm-2 control-label col-lg-2">
								<label class="sideAdmTitle" for="select">위도(Y)​</label>
							</div>
							<div class="col-sm-2 control-label col-lg-2">
								<input type="text" class="form-control disabled" name="la" readonly
									id="la">
							</div>
							<div class="col-sm-1">
								<label class="btn btn-sm btn-secondary" id="checkLoc"
									name="checkLoc"><span class="skip"></span>위치확인</label>
							</div>
						</div>
						<div class="form-group">
								<div class="col-sm-2 control-label col-lg-2">
									<label class="sideAdmTitle" for="select">개발사업번호​</label>
								</div>
								<div class="col-sm-4">
									<input type="text" id="dwkno" name="dwkno" readonly data-ly-btn="invt-search" onclick="invDevlopListSearch(2);"
										class="form-control disabled" value="">
								</div>
								<div class="col-sm-2 control-label col-lg-2">
									<label class="sideAdmTitle" for="select">개발사업명​</label>
								</div>
								<div class="col-sm-4">
									<input type="text" id="dwknm" name="dwknm" readonly data-ly-btn="invt-search" onclick="invDevlopListSearch(2);"
										class="form-control disabled" value="">
								</div>
						</div>
						<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2">
								<label class="sideAdmTitle" for="select">편입 여부​</label>
							</div>
							<div class="col-sm-4">
								<input class="radio-input incrprAt" type="radio" id="radioincrprAt1" name="incrprAt" value="Y" checked>
									<label class="radio-inline" for="radioincrprAt1">편입</label>
								<input class="radio-input incrprAt" type="radio" id="radioincrprAt2" name="incrprAt" value="N" >
									<label class="radio-inline" for="radioincrprAt2">인근</label>
							</div>
							<div class="col-sm-2 control-label col-lg-2">
								<label class="sideAdmTitle" for="select">편입 면적​</label>
							</div>
							<div class="col-sm-4">
								<input type="text" id="incrprAr" name="incrprAr"
									class="form-control" value="" placeholder="Ex)전면적 or 100000">
							</div>
						</div>
						<div id="aucAdmDiv1">
							<div class="form-group">
								<div class="col-sm-2 control-label col-lg-2">
									<label class="sideAdmTitle" for="select">법 원​</label>
								</div>
								<div class="col-sm-4">
									<select name="courtNm" id="courtNm" class="form-control">
									</select>
								</div>
								<div class="col-sm-2 control-label col-lg-2">
									<label class="sideAdmTitle" for="select">계코드​</label>
								</div>
								<div class="col-sm-4">
									<input type="text" id="smCode" name="smCode" title="계코드 입력"
										class="form-control" value="" placeholder="Ex)2">
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-2 control-label col-lg-2">
									<label class="sideAdmTitle" for="select">사건번호​</label>
								</div>
								<div class="col-sm-4">
									<input type="text" id="incdntManageNo" name="incdntManageNo"
										title="사건번호 입력" class="form-control" placeholder="Ex)2021-12345">
								</div>
								<div class="col-sm-2 control-label col-lg-2">
									<label class="sideAdmTitle" for="select">물건번호​</label>
								</div>
								<div class="col-sm-4">
									<input type="text" id="thingNo" name="thingNo" title="물건번호 입력"
										class="form-control" value="" placeholder="Ex)3">
								</div>
							</div>
						</div>
						<div id="paucAdmDiv1" class="form-group" style="display: none;">
							<div class="col-sm-2 control-label col-lg-2">
								<label class="sideAdmTitle" for="select">사건번호​</label>
							</div>
							<div class="col-sm-6">
								<input type="text" id="pincdntManageNo" name="pincdntManageNo"
									title="사건번호 입력" class="form-control" placeholder="Ex)2021-123-45678">
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2">
								<label class="sideAdmTitle" for="select">지목용도​</label>
							</div>
							<div class="col-sm-4">
								<select name="prposCode1" id="prposCode1"
									class="form-control prposCode1">
								</select> <select name="prposCode2" id="prposCode2"
									class="form-control prposCode2" style="display: none;">
								</select> <select name="prposCode3" id="prposCode3"
									class="form-control prposCode3" style="display: none;">
								</select>
							</div>
							<div class="col-sm-2 control-label col-lg-2">
								<label class="sideAdmTitle" for="select">감정평가금액​</label>
							</div>
							<div class="col-sm-4">
								<input type="text" id="apasmtAmount" name="apasmtAmount" onchange="addComma(this);"
									title="사건번호 입력" class="form-control" placeholder="Ex)25,000,000">
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2">
								<label class="sideAdmTitle" id="aucAdmDiv2" for="select">입찰일​</label> <label
									id="paucAdmDiv4" class="sideAdmTitle" for="select" style="display: none;">입찰시작일​</label>
							</div>
							<div class="col-sm-4" id="paucAdmDiv3" style="display: none;">
								<div class="search--calendar">
									<span> <input type="text" class="form-control"
										name="startDate" id="startDateIAI" placeholder="시작일" value=""
										title="입찰일 입력">
										<button type="button" class="btn__calendar">
											<span class="skip">달력선택</span>
										</button>
									</span>
								</div>
							</div>
							<div class="col-sm-2 control-label col-lg-2" id="paucAdmDiv2"
								style="display: none;">
								<label class="sideAdmTitle" for="select">입찰종료일​</label>
							</div>
							<div class="col-sm-4">
								<div class="search--calendar">
									<span> <input type="text" class="form-control"
										name="endDate" id="endDateIAI" placeholder="시작일" value=""
										title="입찰종료일 입력">
										<button type="button" class="btn__calendar">
											<span class="skip">달력선택</span>
										</button>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2">
								<label class="sideAdmTitle" for="select">특기사항<br>프리미엄<br>전용서비스​
								</label>
							</div>
							<div class="col-sm-10">
								<textarea class="form-control" id="rmOne" name="rmOne"
									title="내용 입력" rows="20" style="height: 100px"> </textarea>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-2 control-label">
								<label class="sideAdmTitle" for="select">공개여부</label>
							</div>
							<div class="col-sm-4">
								<input class="radio-input" type="radio" id="radioY"
									name="cntntsOthbcAt" value="Y" > <label
									class="radio-inline cntntsOthbcAtBtn" for="radioY">예</label> <input
									class="radio-input" type="radio" id="radioN"
									name="cntntsOthbcAt" value="N" checked> <label
									class="radio-inline cntntsOthbcAtBtn" for="radioN">아니요</label>
							</div>
							<div class="col-sm-2 control-label">
								<label class="sideAdmTitle" for="select">샘플보기여부</label>
							</div>
							<div class="col-sm-4">
								<input class="radio-input" type="radio" id="radio3"
									name="smpleExAt" value="Y"> <label class="radio-inline"
									for="radio3">예</label> <input class="radio-input" type="radio"
									id="radio4" name="smpleExAt" value="N" checked> <label
									class="radio-inline" for="radio4" >아니요</label>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-2 control-label">
								<label class="sideAdmTitle" for="select">보상여부</label>
							</div>
							<div class="col-sm-10">
								<input class="radio-input" type="radio" id="radio5"
									name="rewardAt" value="CM00160001" checked> <label
									class="radio-inline" for="radio5" >보상중</label>
								<input class="radio-input" type="radio" id="radio6" name="rewardAt" value="CM00160002" checked>
								<label class="radio-inline" for="radio6">보상예정</label> 
								<input class="radio-input" type="radio" id="radio7" name="rewardAt" value="CM00160003">
								<label class="radio-inline" for="radio7">환 지</label>
								<input class="radio-input" type="radio" id="radio8" name="rewardAt" value="CM00160004">
								<label class="radio-inline" for="radio8">기 타</label>
							</div>
						</div>
					</div>
					<div class="text-center button_align">
						<button type="button" id="invtInfoInsertBtn"
							class="btn btn-primary">등록</button>
						<button type="button" class="btn btn-default"
							onclick="javascript:sideShow('invtAdminList');">취소</button>
					</div>
				</div>
				<input type="hidden" name="devlopInfoSn" />
			</form>
		</div>
		<!-- 경/공매 쓰기 -->

		<link rel="stylesheet"
			href="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/jQueryDatepicker/jquery.datetimepicker.min.css' />">
		<script
			src="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/jQueryDatepicker/jquery.datetimepicker.full.min.js' />"></script>
		<script>
			$(document).ready(function() {

				$.datetimepicker.setLocale('ko');
				$("#startDateIAI,#endDateIAI").datetimepicker({
					timepicker : false,
					format : 'Y-m-d',
					scrollMonth : false,
					scrollInput : false
				});

			});
		</script>
		<!-- List : S -->
	</div>
</div>