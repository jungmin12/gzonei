<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<!-- 경/공매 쓰기 -->
<div id="rewardAdminList" class="scroll" style="display: none;">
	<strong class="title">보상전례 관리</strong>
	<button type="button" class="SideOff" id="rewardAdmSideOff"></button>
	<!-- 보상전례 리스트 -->
	<form name="rewardAdmForm" id="rewardAdmForm">
		<input type="hidden" name="pageIndex" value="" />
		<div class="modal_form">
			<div class="form-horizontal bucket-form">
				<div class="form-group">
					<div class="col-sm-1 control-label">
						<label for="birth">등록기간</label>
					</div>
					<div class="col-sm-5">
						<div class="search--calendar" style="width: 49%;">
							<span> <input type="text" class="form-control"
								name="startDate" id="startDate1" placeholder="시작일" value=""title="시작일 입력" autocomplete="off">
								<button type="button" class="btn__calendar">
									<span class="skip">달력선택</span>
								</button>
							</span>
						</div>
						<div class="search--calendar" style="width: 49%;">
							<span> <input type="text" class="form-control"
								name="endDate" id="endDate1" placeholder="종료일" value="" title="종료일 입력" autocomplete="off">
								<button type="button" class="btn__calendar">
									<span class="skip">달력선택</span>
								</button>
							</span>
						</div>
					</div>
					<div class="col-sm-1 control-label">
						<label for="searchType">지역</label>
					</div>
					<div class="col-sm-2">
						<select name="upperMapCode" id="rewardAdmArea1" class="form-control"
							title="지역1">
							<option value="">전체</option>
						</select>
					</div>
					<div class="col-sm-2">
						<select name="mapCode" id="rewardAdmArea2" class="form-control"
							title="지역2">
							<option value="">전체</option>
						</select>
					</div>
					<div class="col-sm-1">
						<input class="btn_ms" type="button" value="검색" onclick="rewardAdmListSearch();">
					</div>
				</div>
			</div>
		</div>
	</form>
	<div id="rewardInfoAdminTotalCntDiv" class="totalCnt">
		<label>총 <span id="rewardInfoAdminTotalCount"></span> 건
		</label>
	</div>
	<div id='rewardInfoAdminTableDiv' class="table-scroll">
		<table class="table table-bordered text-center">
			<caption>보상전례 목록 제공</caption>
			<colgroup>
				<col style="width: auto">
				<col style="width: 12%">
				<col style="width: 12%">
				<col style="width: 12%">
				<col style="width: 12%">
				<col style="width: 12%">
				<col style="width: 12%">
				<col style="width: 12%">
			</colgroup>
			<thead>
				<tr>
					<th>개발사업명</th>
					<th>지역</th>
					<th>보상가</th>
					<th>지목</th>
					<th>가격시점개별지가</th>
					<th>가격시점</th>
					<th>등록자ID</th>
					<th>등록일</th>
				</tr>
			</thead>
			<tbody id="rewardAdminTbody">
			</tbody>
		</table>

	</div>
	<!-- List : E -->
	<!-- Paging : S -->
	<div id="rewardAdminListPagination"></div>
	<div class="text-right button_align">
		<button id="rewardInsertShow" type="button" class="btn btn-Insert">등록</button>
	</div>
</div>
  <link rel="stylesheet" href="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/jQueryDatepicker/jquery.datetimepicker.min.css' />">
        <script src="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/jQueryDatepicker/jquery.datetimepicker.full.min.js' />"></script>
        <script>
            $(document).ready(function () {
            	$(".btn__calendar").on('click', function() {	
            		var nodeId = this.previousElementSibling.getAttribute("id");
            		$("#"+nodeId).datetimepicker('show');
            	});
                $.datetimepicker.setLocale('ko');
                $("#startDate1, #endDate1").datetimepicker({
                	timepicker: false, 
                	format: 'Y-m-d', 
                	scrollMonth: false, 
                	scrollInput: false,
                	validateOnBlur: false
                }).on('keydown', function(event){
                	onlyNum(this,event);
	     		});
            });
        </script>
<!-- Paging : E -->

<!-- 보상전례 끝 -->