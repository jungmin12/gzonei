<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.paginated{width:100%};
input{};
</style>
</head>
<body>
	<div id="invtInfoDetailModal" class="invtInfoDetailModal w3-modal">
		<!-- <div class="w3-modal-content w3-card-4 w3-animate-zoom"> -->
		<div class="w3-modal-content w3-card-4 ">
			<header class="w3-container w3-blue">
				<span onclick="document.getElementById('invtInfoDetailModal').style.display='none'"
					class="w3-button w3-blue w3-xlarge w3-display-topright">&times;</span>
				<h2>Header</h2>
			</header>
	
			<div class="w3-bar w3-border-bottom">
				<select>
					<option>지역</option>
				</select> 
				<select>
					<option>구/군</option>
				</select> 
				<select>
					<option>사업지구</option>
				</select> 
			</div>
			<form id="detailForm" name="detailForm" method="post">
				<input type="hidden" name="invtInfoSn"/>
				<div id="contents" class="w3-container">
					<table class="paginated" >
						<tbody id="detailTbodyContents">
							<tr>
								<th style="border: solid 1px ;">투자정보명</th>
								<td style="border: 1px solid;">
									<input type="text" name="courtCode" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">투자정보 구분</th>
								<td style="border: 1px solid;">
									<input type="text" name="aucPblsalSeCode" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">지도코드</th>
								<td style="border: 1px solid;">
									<input type="text" name="mapCode" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">위치</th>
								<td style="border: 1px solid;">
									<input type="text" name="upperMapCode" style="width:100%"/>
									<input type="text" name="mapCode" style="width:100%"/>
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">지목용도</th>
								<td style="border: 1px solid;">
									<input type="text" name="prposOneCode" style="width:100%">     
									<input type="text" name="prposTwoCode" style="width:100%">     
									<input type="text" name="prposThreeCode" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">감정평가금액</th>
								<td style="border: 1px solid;">
									<input type="text" name="apasmtAmount" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">입찰일자</th>
								<td style="border: 1px solid;">
									<input type="text" name="apprslEvlDe" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">특기사항 프리미엄 멘트</th>
								<td style="border: 1px solid;">
									<input type="text" name="rmOne" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">공개 여부</th>
								<td style="border: 1px solid;">
									<input type="text" name="cntntsOthbcAt" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">보상 여부</th>
								<td style="border: 1px solid;">
									<input type="text" name="rewardAt" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">샘플보기여부</th>
								<td style="border: 1px solid;">
									<input type="text" name="smpleExAt" style="width:100%" >     
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</form>
			<div class="w3-container w3-light-grey w3-padding">
				<button class="w3-button w3-right w3-white w3-border" id='invtInfoCancleBtn'>목록</button>
				<button class="w3-button w3-right w3-white w3-border" id='invtInfoDeleteBtn'>삭제</button>
				<button class="w3-button w3-right w3-white w3-border" id='invtInfoUpdateBtn'>수정</button>			
			</div>
			
			<div id="useListContentsDiv" class="w3-container">
				<button id='showInsertUseFormBtn' style="float:right;">추가 +</button>
				<form id="useListForm" name="useListForm" method="post">
				<input type="hidden" name="invtInfoDetailSn"/>
				<input type="hidden" name="invtInfoSn"/>
					<label style="float:left;">지번별(용도) 목록</label>
					<table class="paginated" >
						<thead>
							<tr>
								<th>사건번호</th>
								<th>구분</th>
								<th>지번</th>
								<th>지목</th>
								<th>이용현황</th>
								<th>면적</th>
								<th>등록자ID</th>
							</tr>
						</thead>
						<tbody id="useListTbodyContents">
						</tbody>
					</table>
				</form>
			</div>
			
			<div id="proListContentsDiv" class="w3-container">
				<button id='showInsertProFormBtn' style="float:right;">추가 +</button>
				<form id="proListForm" name="proListForm" method="post">
				<input type="hidden" name="invtProgrsDtlsSn"/>
				<input type="hidden" name="invtInfoSn"/>
					<label style="float:left;">진행내역 목록</label>
					<table class="paginated" >
						<thead>
							<tr>
								<th>일련번호</th>
								<th>법원명</th>
								<th>입찰일자</th>
								<th>진행결과</th>
								<th>입찰금액</th>
								<th>낙찰금액</th>
								<th>등록자ID</th>
							</tr>
						</thead>
						<tbody id="proListTbodyContents">
						</tbody>
					</table>
				</form>
			</div>
			<div id="" class="w3-container">
				<form id="" name="" method="post">
				<input type="hidden" name=""/>
				<input type="hidden" name=""/>
					<table class="paginated" >
						<tbody id="proDetailTbodyContents">
							<tr>
								<th style="border: solid 1px ;">일련번호</th>
								<td style="border: 1px solid;">
									<input type="text" name="smCode" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">법원명</th>
								<td style="border: 1px solid;">
									<input type="text" name="courtCode" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">입찰일자</th>
								<td style="border: 1px solid;">
									<input type="text" name="bidDe" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">진행결과</th>
								<td style="border: 1px solid;">
									<input type="text" name="progrsResultCode" style="width:100%"/>
									<input type="text" name="progrsResultCode" style="width:100%"/>
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">입찰금액</th>
								<td style="border: 1px solid;">
									<input type="text" name="bidAmount" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">낙찰금액</th>
								<td style="border: 1px solid;">
									<input type="text" name="scsbidAmount" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">등록자ID</th>
								<td style="border: 1px solid;">
									<input type="text" name="frstRegisterId" style="width:100%">     
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				<button class="w3-button w3-right w3-white w3-border" id='proDetailCancleBtn'>취소</button>
				<button class="w3-button w3-right w3-white w3-border" id='proDeleteBtn'>삭제</button>
				<button class="w3-button w3-right w3-white w3-border" id='proUpdateBtn'>수정</button>
			</div>
			<div id="proInsertContentsDiv" class="w3-container">
				<form id="proInsertForm" name="proInsertForm" method="post">
				<input type="hidden" name="invtProgrsDtlsSn"/>
				<input type="hidden" name="invtInfoSn"/>
					<table class="paginated" >
						<tbody id="proInsertTbodyContents">
							<tr>
								<th style="border: solid 1px ;">일련번호</th>
								<td style="border: 1px solid;">
									<input type="text" name="smCode" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">법원명</th>
								<td style="border: 1px solid;">
									<input type="text" name="courtCode" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">입찰일자</th>
								<td style="border: 1px solid;">
									<input type="text" name="bidDe" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">진행결과</th>
								<td style="border: 1px solid;">
									<input type="text" name="progrsResultCode" style="width:100%"/>
									<input type="text" name="progrsResultCode" style="width:100%"/>
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">입찰금액</th>
								<td style="border: 1px solid;">
									<input type="text" name="bidAmount" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">낙찰금액</th>
								<td style="border: 1px solid;">
									<input type="text" name="scsbidAmount" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">등록자ID</th>
								<td style="border: 1px solid;">
									<input type="text" name="frstRegisterId" style="width:100%">     
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				<button class="w3-button w3-right w3-white w3-border" id='proInsertCancleBtn'>취소</button>
				<button class="w3-button w3-right w3-white w3-border" id='proInsertBtn'>등록</button>
			</div>
		</div>
	</div>
</body>
</html>