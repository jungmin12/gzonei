<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<script type="text/javascript" src="<c:url value='/js/gzonei/jquery-3.5.1.js' />"></script>
<script type="text/javascript"  src="<c:url value='/js/gzonei/devlopInfo/devlopInfo.js' />"></script>
<script type="text/javascript"  src="<c:url value='/js/gzonei/invt/invtDevlop.js' />"></script>
<script type="text/javascript"  src="<c:url value='/js/gzonei/devlopInfo/twbsPagination.js' />"></script>

<!-- JQuery Modal -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" herf="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css"/>
<!-- 임시CSS -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="<c:url value='/css/gzonei/SRC/css/acego.prog.css'/>">

<!-- header -->
<script>
$( document ).ready(function() {
	$("#mapDevInfoForm_listSearch").on('click',function(e){
		var params = $("#mapDevInfoForm").serializeArray();
		if(params[0].value == ""){
			alert('지역을 선택해 주세요');
		}else{
			if(params[2].value !=""){
				var legaldongNm = {'name':'textSearch','value':$('#sampleArea3 option:selected').text()};
				params.push(legaldongNm);
				$.ajax({
			        type : 'POST',
			        url : "selectSimpleList.ajax",
			        async: false,
			        datatype : 'json',
			        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
			        data: params,
			        success : function(data){ 
			        	var resData = JSON.parse(data);
		        	},
		            error:function(e){
		            	console.log(e);
		            	alert('selectSimpleList 조회 실패' + e);
		        	}
				});
			}else{
				//area1, area2만 있는경우
			}
		}
	});
});
</script>
<!-- contents -->
<div>
	<!-- 상단 -->
	<form id="listForm" name="listForm" method="post">
	<input type="hidden" name="pageIndex" value=""/>
	<div class="mp_top">
		<div class="l"><!-- left layout -->
			<h3 class="m_tit01 mt15">개발정보 목록</h3>
			<div style="height:200px">
				<select id='searchCondition' name='searchCondition'>
					<option value='dwkNm'>사업명</option>
					<option value='dwkNo'>사업번호</option>
				</select>
				<input type="text" name="textSearch" style="width:500px;" value="${searchVO.textSearch }"/>
				<br>
				<label>공개여부</label>
				<select id='disclosure' name='disclosure'>
					<option value='open'>전체</option>
					<option value='close'>비공개</option>
				</select>
				<label>지역1</label>
				<select class='area1' id='area1' name='area1'>
					<option value=''>시도</option>
				</select>
				<label>지역2</label>
				<select class='area2' id='area2' name='area2'>
					<option value=''>시군구</option>
				</select>
				<label>지역3</label>
				<select class='area3' id='area3' name='area3'>
					<option value=''>읍면동</option>
				</select>
				
				<a href="javascript:;" id="listSearch">검색</a>
								
			</div>
		</div>
		
		<div id="pop_tbl_div" class="pop_tbl tbl_list scroll">
			DevlopInfo 내용
			<br>
			<label>총 <span id="total-count"></span> 건</label>
			
			<table class="paginated">
				<thead>
					<tr>
						<th>개발사업번호</th>
						<th>개발사업명</th>
						<th>지역1</th>
						<th>지역2</th>
						<th>등록자ID</th>
						<th>등록일</th>
						<th>최종수정일자</th>
					</tr>
				</thead>
				<tbody id="tbodyContents">
					
				</tbody>
			</table>
		</div>
	</div>
	<div id="pagination-div" class="pagination-inner" ></div>
	</form>
	<button id="showInsrtBtn">등록</button>
	<button id="showModalBtn">모달 보이기</button>
	
	<span>샘플</span>
	<form id='mapDevInfoForm' name='mapDevInfoForm'>
		<div>
			<label>지역1</label>
			<select class='area1' id='sampleArea1' name='area1'>
				<option value='all'>시도</option>
			</select>
			<label>지역2</label>
			<select class='area2' id='sampleArea2' name='area2'>
				<option value='all'>시군구</option>
			</select>
			<label>지역3</label>
			<select class='area3' id='sampleArea3' name='area3'>
				<option value='all'>읍면동</option>
			</select>
			<a href="javascript:;" id="mapDevInfoForm_listSearch">검색</a>
		</div>
	</form>
	
	<!-- 배너 -->
	<h3 class="m_tit01 mt15">배너 위치</h3><!-- 배너 -->
	<div class="mp_bn">
	</div>
	
	
	
	<jsp:include page="/WEB-INF/jsp/gzonei/devlopInfo/devlopInfoInsert.jsp"/>
	<jsp:include page="/WEB-INF/jsp/gzonei/devlopInfo/devlopInfoDetail.jsp"/>
<!-- bottom -->

</div><!-- contents -->

</html>
