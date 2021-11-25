<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<!-- 개발사업 정보 상세보기 ::S -->
<div id="devInfoAdminList" class="adminDivFormat" style="display:none;">
	<strong class="headTitle">개발사업 정보 목록</strong>
	<button type="button" class="SideOff" id="devAdmSideOff"></button>
	<form id="devInfoAdminListForm" name="devInfoAdminListForm">
		<input type="hidden" name="pageIndex" value=""/>
		<div class="modal_form">
			<div class="form-horizontal bucket-form">
				<div class="form-group">
		            <div class="col-sm-1 control-label"><label class="mapTitle" for="birth">공개 여부</label></div>
		            <div class="col-sm-3">
		                <select id="tel1" name="dwkOthbcAt" class="form-control" title="연령대 선택">
		                    <option value="all">전체</option>
		                    <option value="Y">공개</option>
		                    <option value="N">비공개</option>
		                </select>
		            </div>
		            <div class="col-sm-1 control-label"><label class="mapTitle" for="area1">지역 1</label></div>
		            <div class="col-sm-3">
		                <select id="AdmArea1" name="area1" class="AdmArea1 form-control" title="연령대 선택">
		                    <option value="">전체</option>
		                </select>
		            </div>
		            <div class="col-sm-1 control-label"><label class="mapTitle" for="area2">지역 2</label></div>
		            <div class="col-sm-3">
		                <select id="AdmArea2"  name="area2" class="AdmArea2 form-control" title="연령대 선택">
		                    <option value="">전체</option>
		                </select>
		            </div>
		        </div>
		        <div class="form-group">
		            <div class="col-sm-1 control-label"><label class="sideAdmTitle" for="searchType">검색타입</label></div>
		            <div class="col-sm-3">
		                 <select name="searchType" class="form-control" title="검색타입">
                             <option value='dwkNm'>개발사업명</option>
                             <option value='dwkNo'>개발사업번호</option>
                         </select>
		            </div>
		            <div class="col-sm-1 control-label"><label class="sideAdmTitle" for="searchType">검색어</label></div>
		            <div class="col-sm-6">
			            <input title="검색어" name="textSearch" placeholder="검색어를 입력하세요" class="form-control" onkeypress="adDevListEnterkey();"/>
		            </div>
		            <div class="col-sm-1">
		            	<input id="devInfoAdminSchBtn" class="btn_ms" value="검색">
					</div>
		        </div>
			</div>
			
		</div>
		
	</form>
	<div id="devInfoAdminTotalCntDiv" class="totalCnt">
    	<label class="mapTitle">총 <span id="devInfoAdminTotalCount"></span> 건</label>
    </div>
	<div id ='devInfoAdminTableDiv' class="table-scroll">
		<table class="table table-bordered text-center">
				<caption>개발정보 목록 제공</caption>
			<colgroup>
				<col style="width:12%">
				<col style="width:auto">
				<col style="width:9%">
				<col style="width:9%">
				<col style="width:9%">
				<col style="width:9%">
				<col style="width:9%">
				<col style="width:9%">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">개발사업번호</th>
					<th scope="col">개발사업명</th>
					<th scope="col">공개여부</th>
					<th scope="col">지역1</th>
					<th scope="col">지역2</th>
					<th scope="col">등록자</th>
					<th scope="col">등록일</th>
					<th scope="col">최종수정일</th>
				</tr>
			</thead>
			<tbody id="devinfoAdminListContent">
			</tbody>
		</table>
	</div>
	<div id="devInfoAdminListPagination"></div>
	<div id="devInfoAdminInsrtBtnDiv" class="text-right button_align">
		<button id="devInfoAdminShowInsrtPage" type="button" class="btn btn-Insrt">등록</button>
	</div>
</div>
