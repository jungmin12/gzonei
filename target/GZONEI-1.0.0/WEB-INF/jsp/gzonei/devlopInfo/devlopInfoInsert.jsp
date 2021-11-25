<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insrt title here</title>
<style>
.paginated{width:100%};
input{};
</style>
</head>
<body>
	<div id="devlopInfoInsrtModal" class="devlopInfoInsrtModal w3-modal">
		<!-- <div class="w3-modal-content w3-card-4 w3-animate-zoom"> -->
		<div class="w3-modal-content w3-card-4 ">
			<header class="w3-container w3-blue">
				<span id="devlopInfoInsrtModal_CloseSpan" class="w3-button w3-blue w3-xlarge w3-display-topright">&times;</span>
				<h2>등록</h2>
			</header>
	
			<div class="w3-bar w3-border-bottom">
				<select class='area1' id='InsrtArea1' name='area1'>
					<option value='all'>시도</option>
				</select> 
				<select class='area2' id='InsrtArea2' name='area2'>
					<option value='all'>시군구</option>
				</select> 
				<select class='dsCode' id='InsrtDsCodeList' name='dsCode'>
					<option>사업지구</option>
				</select> 
			</div>
			<form id="InsrtForm" name="InsrtForm" method="post">
				<input type="hidden" name="devlopInfoSn"/>
				<div id="contents" class="w3-container">
					<table class="paginated" >
						<tbody id="detailInsrtTbodyContents">
							<tr>
								<th style="border: solid 1px ;">개발사업명</th>
								<td style="border: 1px solid;">
									<input type="text" name="dwkNm" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">사업내용</th>
								<td style="border: 1px solid;">
									<input type="text" name="bsnsCn" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">위치</th>
								<td style="border: 1px solid;">
									<input type="text" name="geom" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">면적</th>
								<td style="border: 1px solid;">
									<input type="text" name="bsnsArMeter" style="width:100%"/>
									<input type="text" name="bsnsArPyeong" style="width:100%"/>
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">시행사</th>
								<td style="border: 1px solid;">
									<input type="text" name="opertnCmpny" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">적용법률</th>
								<td style="border: 1px solid;">
									<input type="text" name="applcLaw" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">사업방식</th>
								<td style="border: 1px solid;">
									<input type="text" name="bsnsMthdCode" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">사업인증 고시일</th>
								<td style="border: 1px solid;">
									<input type="text" name="bsnsrcognNtfcNm" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">담당 부서</th>
								<td style="border: 1px solid;">
									<input type="text" name="chrgDept" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">작성자 의견</th>
								<td style="border: 1px solid;">
									<input type="text" name="wrterOpinion" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">GZONE 멘트</th>
								<td style="border: 1px solid;">
									<input type="text" name="gzMent" style="width:100%" >     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">예상 보상 상태</th>
								<td style="border: 1px solid;">
									<input type="text" name="expectRewardCode" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">예상 보상 시기</th>
								<td style="border: 1px solid;">
									<input type="text" name="expectRewardEra" style="width:100%" >     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">관리자 수정일자</th>
								<td style="border: 1px solid;">
									<input type="text" name="lastUpdtPnttm" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">공개여부</th>
								<td style="border: 1px solid;">
									<input type="text" name="dwkOthbcAt" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">첨부파일</th>
								<td style="border: 1px solid;">
									<input type="text" name="atchFileId" style="width:100%">     
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</form>
			<div class="w3-container w3-light-grey w3-padding">
				<button class="w3-button w3-right w3-white w3-border" id='devlopInfoInsrtCancleBtn'>목록</button>
				<button class="w3-button w3-right w3-white w3-border" id='devlopInfoInsrtBtn'>등록</button>			
			</div>
			
		</div>
	</div>
</body>
</html>