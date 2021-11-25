<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<!-- 경/공매 쓰기 -->
<div id="invtAdminList" class="adminDivFormat" style="display: none;">
	<strong class="headTitle">투자정보 관리</strong>
	<button type="button" class="SideOff" id="invtAdmSideOff"></button>
	<!-- 보상전례 리스트 -->
	<form name="invtAdmForm" id="invtAdmForm">
		<input type="hidden" id="pageIndexInvAdm" name="pageIndex" value="" />
		<div class="modal_form">
			<div class="form-horizontal bucket-form">
				<div class="form-group">
					<div class="col-sm-1 control-label">
						<label class="mapTitle" for="birth">등록기간</label>
					</div>
					<div class="col-sm-4">
						<div class="search--calendar" style="width: 49%;">
							<span> <input type="text" class="form-control"
								name="startDate" id="startDateInvAd" placeholder="시작일" value=""
								title="시작일 입력">
								<button type="button" class="btn__calendar">
									<span class="skip">달력선택</span>
								</button>
							</span>
						</div>
						<div class="search--calendar" style="width: 49%;">
							<span> <input type="text" class="form-control"
								name="endDate" id="endDateInvAd" placeholder="종료일" value=""
								title="종료일 입력">
								<button type="button" class="btn__calendar">
									<span class="skip">달력선택</span>
								</button>
							</span>
						</div>
					</div>
					<div class="col-sm-1 control-label">
						<label class="mapTitle" for="searchType">지역</label>
					</div>
					<div class="col-sm-2">
						<select name="invAdmArea1" id="invAdmArea1"
							class="form-control invAdmArea1" title="지역1">
						</select>
					</div>
					<div class="col-sm-2">
						<select name="invAdmArea2" id="invAdmArea2"
							class="form-control invAdmArea2" title="지역2">
							<option value="">전체</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-1 control-label">
						<label class="sideAdmTitle" for="searchType">경공매구분</label>
					</div>
					<div class="col-sm-3">
						<select name="aucPblsalSeCode" id="aucPblsalSeCode"
							class="form-control" title="연령대 선택">
							<option value="">전체</option>
							<option value="CM00110001">경매</option>
							<option value="CM00110002">공매</option>
						</select>
					</div>
					<div class="col-sm-1 control-label">
						<label class="mapTitle" for="area1">법원</label>
					</div>
					<div class="col-sm-2">
						<select id="courtList" name="courtList"
							class="courtList form-control" title="연령대 선택"></select>
					</div>
					<div class="col-sm-1 control-label">
						<label class="mapTitle" for="area2">관리번호</label>
					</div>
					<div class="col-sm-2">
						<input title="검색어" name="incdntManageNo" id="incdntManageNo"  placeholder="관리번호를 입력하세요" class="form-control" onkeypress="return adInvListEnterkey()" onkeydown="fn_press_han(this);">
					</div>
					<div class="col-sm-1">
						<input class="btn_ms" type="button" value="검색" onclick="invAdmListSearch(1);">
					</div>
				</div>
			</div>
		</div>
	</form>
	<div id="invtInfoAdminTotalCntDiv" class="totalCnt">
		<label class="mapTitle" >총 <span id="invInfoAdminTotalCount"></span> 건
		</label>
	</div>
	<div id='invInfoAdminTableDiv' class="table-scroll">
		<table class="table table-bordered text-center">
			<caption>투자정보 목록 제공</caption>
			<colgroup>
				<col style="width: auto">
				<col style="width: 15%">
				<col style="width: 15%">
				<col style="width: 15%">
				<col style="width: 15%">
				<col style="width: 15%">
			</colgroup>
			<thead>
				<tr>
					<th>물건명</th>
					<th>지역</th>
					<th>감정평가금액</th>
					<th>공개여부</th>
					<th>등록자ID</th>
					<th>최종수정일</th>
				</tr>
			</thead>
			<tbody id="invtAdminTbody">
			</tbody>
		</table>

	</div>
	<!-- List : E -->
	<!-- Paging : S -->
	<div id="invAdminListPagination"></div>
	<div class="text-right button_align">
		<button id="invInsertShow" type="button" class="btn btn-Insert">등록</button>
	</div>
</div>
<!-- Paging : E -->