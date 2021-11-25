<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.paginated {
	width: 100%
}

;
input {
	
}
;
</style>
</head>
<body>
	<div id="invtInfoInsertModal" class="invtInfoInsertModal w3-modal">
		<!-- <div class="w3-modal-content w3-card-4 w3-animate-zoom"> -->
		<div class="w3-modal-content w3-card-4 ">
			<header class="w3-container w3-blue">
				<span id="invtInfoInsertModal_CloseSpan"
					class="w3-button w3-blue w3-xlarge w3-display-topright">&times;</span>
				<h2>투자 정보 등록</h2>
			</header>
			<div class="w3-bar w3-border-bottom">
				경/공매 구분 <label><input type="radio" name="showAuc" value="1"
					id="aucInsertShow" checked> 경매</label> <label><input
					type="radio" name="showAuc" value="2" id="paucInsertShow">
					공매</label>
			</div>
			<form id="invtAucInsertForm" name="invtAucInsertForm" method="post">
				<input type="hidden" name="invtInfoSn" /> 
				<input type="hidden" name="aucPblsalSeCode" value="CM00270001" />
				<input type="hidden" name="devlopInfoSn" value="" />
				<div id="contents" class="w3-container">
					<table class="paginated" id="aucDiv">
						<tbody id="detailInsertAuc">
							<tr>
								<th style="border: solid 1px;">개발사업 번호(물건전시용)</th>
								<td style="border: 1px solid;">
								<a href="#" id="showModalBtn">
								<input type="text" name="dwkno" style="width: 20%" readonly>
								<input type="text" name="dwknm" style="width: 50%" readonly>
								</a>
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px;">법원코드</th>
								<td style="border: 1px solid;"><select name="courtCode"
									style="width: 100%"><option value="1">선택</option>
										<option value="2">선택2</option></select></td>
							</tr>
							<tr>
								<th style="border: solid 1px;">계코드</th>
								<td style="border: 1px solid;"><input type="text"
									name="smCode" style="width: 100%"></td>
							</tr>
							<tr>
								<th style="border: solid 1px;">물건번호</th>
								<td style="border: 1px solid;"><input type="text"
									name="thingNo" style="width: 100%"></td>
							</tr>
							<tr>
								<th style="border: solid 1px;">경매종류</th>
								<td style="border: 1px solid;"><select name="aucKndCode"
									style="width: 100%"><option value="1">선택</option>
										<option value="2">선택2</option></select></td>
							</tr>
							<tr>
								<th style="border: solid 1px;">사건번호</th>
								<td style="border: 1px solid;"><input type="text"
									name="incdntManageNo" style="width: 100%"></td>
							</tr>
							<tr>
								<th style="border: solid 1px;">지도코드</th>
								<td style="border: 1px solid;"><select name="upperMapCode"
									style="width: 48%"><option value="1">선택</option>
										<option value="2">선택2</option></select> <select name="mapCode"
									style="width: 48%"><option value="1">선택</option>
										<option value="2">선택2</option></select></td>
							</tr>
							<tr>
								<th style="border: solid 1px;">위치</th>
								<td style="border: 1px solid;"><input type="text"
									name="prposTwoCode" style="width: 100%" /></td>
							</tr>
							<tr>
								<th style="border: solid 1px;">지목용도</th>
								<td style="border: 1px solid;"><select name="prposOneCode"
									style="width: 100%"><option value="1">선택</option>
										<option value="2">선택2</option></select></td>
							</tr>
							<tr>
								<th style="border: solid 1px;">감정평가금액</th>
								<td style="border: 1px solid;"><input type="text"
									name="apasmtAmount" style="width: 100%"></td>
							</tr>
							<tr>
								<th style="border: solid 1px;">GZONE 멘트</th>
								<td style="border: 1px solid;"><input type="text"
									name="rmOne" style="width: 100%"></td>
							</tr>
							<tr>
								<th style="border: solid 1px;">공개여부</th>
								<td style="border: 1px solid;"><label><input
										type="radio" name="cntntsOthbcAt" value="Y" id="aucShow" checked>
										예</label> <label><input type="radio" name="cntntsOthbcAt" value="N"
										id="aucShow"> 아니요</label></td>
							</tr>
							<tr>
								<th style="border: solid 1px;">보상여부</th>
								<td style="border: 1px solid;"><label><input
										type="radio" name="rewardAt" value="1" id="paucShow" checked>
										보상중</label> <label><input type="radio" name="rewardAt" value="2"
										id="paucShow"> 보상예정</label> <label><input type="radio"
										name="rewardAt" value="3" id="paucShow"> 보상취소</label> <label><input
										type="radio" name="rewardAt" value="4" id="paucShow"> 환지</label>
									<label><input type="radio" name="rewardAt" value="5"
										id="paucShow"> 기타</label></td>
							</tr>
							<tr>
								<th style="border: solid 1px;">샘플보기여부</th>
								<td style="border: 1px solid;"><label><input
										type="radio" name="smpleExAt" value="Y" id="aucShow2" checked>
										예</label> <label><input type="radio" name="smpleExAt" value="N"
										id="aucShow2"> 아니요</label></td>
							</tr>
							<tr>
								<th style="border: solid 1px;">첨부파일</th>
								<td style="border: 1px solid;"><input type="text"
									name="atchFileId" style="width: 100%"></td>
							</tr>
						</tbody>
					</table>
				</div>
			</form>
			<!-- 							공매 -->
			<form id="invtPaucInsertForm" name="invtPaucInsertForm" method="post">
				<input type="hidden" name="invtInfoSn" />
				<input type="hidden" name="aucPblsalSeCode" value="CM00270002" />
				<input type="hidden" name="courtCode" value="0"/>
				<input type="hidden" name="smCode" value="0" />
				<input type="hidden" name="thingNo" value="0" />
				<div id="contents" class="w3-container">
					<table class="paginated" id="paucDiv" style="display: none">
						<tbody id="detailInsertPauc">
							<tr>
								<th style="border: solid 1px;">사건번호</th>
								<td style="border: 1px solid;"><input type="text"
									name="incdntManageNo" style="width: 100%"></td>
							</tr>
							<tr>
								<th style="border: solid 1px;">지도코드</th>
								<td style="border: 1px solid;"><select name="upperMapCode"
									style="width: 48%"><option value="1">선택</option>
										<option value="2">선택2</option></select> <select name="mapCode"
									style="width: 48%"><option value="1">선택</option>
										<option value="2">선택2</option></select></td>
							</tr>
							<tr>
								<th style="border: solid 1px;">위치</th>
								<td style="border: 1px solid;"><input type="text"
									name="prposTwoCode" style="width: 100%" /></td>
							</tr>
							<tr>
								<th style="border: solid 1px;">지목용도</th>
								<td style="border: 1px solid;"><select name="prposOneCode"
									style="width: 100%"><option value="1">선택</option>
										<option value="2">선택2</option></select></td>
							</tr>
							<tr>
								<th style="border: solid 1px;">감정평가금액</th>
								<td style="border: 1px solid;"><input type="text"
									name="apasmtAmount" style="width: 100%"></td>
							</tr>
							<tr>
								<th style="border: solid 1px;">입찰기간</th>
								<td style="border: 1px solid;"><input type="text"
									name="beginPnttm" style="width: 48%" />
									<input type="text"
									name="endPnttm" style="width: 48%" />
									</td>
							</tr>
							<tr>
								<th style="border: solid 1px;">GZONE 멘트</th>
								<td style="border: 1px solid;"><input type="text"
									name="rmOne" style="width: 100%"></td>
							</tr>
							<tr>
								<th style="border: solid 1px;">공개여부</th>
								<td style="border: 1px solid;"><label><input
										type="radio" name="cntntsOthbcAt" value="Y" id="aucShow" checked>
										예</label> <label><input type="radio" name="cntntsOthbcAt" value="N"
										id="aucShow"> 아니요</label></td>
							</tr>
							<tr>
								<th style="border: solid 1px;">보상여부</th>
								<td style="border: 1px solid;"><label><input
										type="radio" name="rewardAt" value="1" id="paucShow" checked>
										보상중</label> <label><input type="radio" name="rewardAt" value="2"
										id="paucShow"> 보상예정</label> <label><input type="radio"
										name="rewardAt" value="3" id="paucShow"> 보상취소</label> <label><input
										type="radio" name="rewardAt" value="4" id="paucShow"> 환지</label>
									<label><input type="radio" name="rewardAt" value="5"
										id="paucShow"> 기타</label></td>
							</tr>
							<tr>
								<th style="border: solid 1px;">샘플보기여부</th>
								<td style="border: 1px solid;"><label><input
										type="radio" name="smpleExAt" value="Y" id="aucShow2" checked>
										예</label> <label><input type="radio" name="smpleExAt" value="N"
										id="aucShow2"> 아니요</label></td>
							</tr>
							<tr>
								<th style="border: solid 1px;">첨부파일</th>
								<td style="border: 1px solid;"><input type="text"
									name="atchFileId" style="width: 100%"></td>
							</tr>
						</tbody>
					</table>
				</div>
			</form>
			<div class="w3-container w3-light-grey w3-padding">
				<button class="w3-button w3-right w3-white w3-border"
					id='invtInfoInsertCancleBtn'>목록</button>
				<button class="w3-button w3-right w3-white w3-border"
					id='invtInfoInsertBtn'>등록</button>
			</div>

		</div>
	</div>
</body>
</html>