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
	<div id="devlopInfoDetailModal" class="devlopInfoDetailModal w3-modal">
		<!-- <div class="w3-modal-content w3-card-4 w3-animate-zoom"> -->
		<div class="w3-modal-content w3-card-4 ">
			<header class="w3-container w3-blue">
				<span id="devlopInfoDetailModal_CloseSpan" class="w3-button w3-blue w3-xlarge w3-display-topright">&times;</span>
				<h2>상세보기</h2>
			</header>
	
			<div class="w3-bar w3-border-bottom">
				<select class='area1' id='detailArea1' name='area1'>
					<option value='all'>시도</option>
				</select> 
				<select class='area2' id='detailArea2' name='area2'>
					<option value='all'>시군구</option>
				</select> 
				<select class='dsCode' id='detailDsCodeList' name='dsCode'>
					<option>사업지구</option>
				</select>  
			</div>
			<form id="detailForm" name="detailForm" method="post">
				<input type="hidden" name="devlopInfoSn"/>
				<input type="hidden" name="dwkNo"/>
				<div id="contents" class="w3-container">
					<table class="paginated" >
						<tbody id="detailTbodyContents">
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
				<button class="w3-button w3-right w3-white w3-border" id='devlopInfoCancleBtn'>목록</button>
				<button class="w3-button w3-right w3-white w3-border" id='devlopInfoDeleteBtn'>삭제</button>
				<button class="w3-button w3-right w3-white w3-border" id='devlopInfoInsrtBtn'>수정</button>			
			</div>
			<div id="prtnListContentsDiv" class="w3-container">
				<button id='showInsrtFormBtn' style="float:right;">추가 +</button>
				<form id="prtnListForm" name="prtnListForm" method="post">
				<input type="hidden" name="bsnsPrtnSttusSn"/>
				<input type="hidden" name="devlopInfoSn"/>
					<label style="float:left;">개발사업 추진내역</label>
					<table class="paginated" >
						<thead>
							<tr>
								<th>일련번호</th>
								<th>추진시작일</th>
								<th>추진종료일</th>
								<th>제목</th>
								<th>연관키워드</th>
								<th>추진구분</th>
								<th>첨부파일명</th>
							</tr>
						</thead>
						<tbody id="prtnListTbodyContents">
						</tbody>
					</table>
				</form>
			</div>
			<div id="prtnDetailContentsDiv" class="w3-container">
				<form id="prtnDetailForm" name="prtnDetailForm" method="post">
				<input type="hidden" name="bsnsPrtnSttusSn"/>
				<input type="hidden" name="devlopInfoSn"/>
					<table class="paginated" >
						<tbody id="prtnDetailTbodyContents">
							<tr>
								<th style="border: solid 1px ;">개발사업번호</th>
								<td style="border: 1px solid;">
									<input type="text" name="dwkNo" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">추진구분</th>
								<td style="border: 1px solid;">
									<input type="text" name="prtnSeCode" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">제목</th>
								<td style="border: 1px solid;">
									<input type="text" name="sj" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">추진시작일</th>
								<td style="border: 1px solid;">
									<input type="text" name="prtnBgnde" style="width:100%"/>
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">추진종료일</th>
								<td style="border: 1px solid;">
									<input type="text" name="prtnEndde" style="width:100%"/>     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">연관키워드</th>
								<td style="border: 1px solid;">
									<input type="text" name="relateKwrd" style="width:100%">     
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
				</form>
				<button class="w3-button w3-right w3-white w3-border" id='PrtnDetailCancleBtn'>취소</button>
				<button class="w3-button w3-right w3-white w3-border" id='PrtnDeleteBtn'>삭제</button>
				<button class="w3-button w3-right w3-white w3-border" id='PrtnUpdateBtn'>수정</button>
			</div>
			<div id="prtnInsrtContentsDiv" class="w3-container">
				<form id="prtnInsrtForm" name="prtnInsrtForm" method="post" enctype="multipart/form-data">
				<input type="hidden" name="bsnsPrtnSttusSn"/>
				<input type="hidden" name="devlopInfoSn"/>
				<input type="hidden" name="atchFileId"/>
				<%-- <input type="hidden" id="atchPosblFileNumber" name="atchPosblFileNumber" value="<c:out value='${boardMasterVO.atchPosblFileNumber}'/>" />
				<input type="hidden" name="atchPosblFileSize" value="<c:out value='${boardMasterVO.atchPosblFileSize}'/>" /> --%>
					<table class="paginated" >
						<tbody id="prtnInsrtTbodyContents">
							<tr>
								<th style="border: solid 1px ;">개발사업번호</th>
								<td style="border: 1px solid;">
									<input type="text" name="dwkNo" style="width:100%" readonly>     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">추진구분</th>
								<td style="border: 1px solid;">
									<input type="text" name="prtnSeCode" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">제목</th>
								<td style="border: 1px solid;">
									<input type="text" name="sj" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">추진시작일</th>
								<td style="border: 1px solid;">
									<input type="text" name="prtnBgnde" style="width:100%"/>
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">추진종료일</th>
								<td style="border: 1px solid;">
									<input type="text" name="prtnEndde" style="width:100%"/>     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">연관키워드</th>
								<td style="border: 1px solid;">
									<input type="text" name="relateKwrd" style="width:100%">     
								</td>
							</tr>
							<tr>
								<th style="border: solid 1px ;">첨부파일</th>
								<td style="border: 1px solid;">
                                	<input id="devlopInfo_file" type="file" name="atchFileId_file" accept=".jpg,.png,.jpeg,.bmp,.xls,.xlsx,.hwp,.pdf"/>
			    					<!-- <div id="egovComFileList"></div> -->
								     
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				<button class="w3-button w3-right w3-white w3-border" id='PrtnInsrtCancleBtn'>취소</button>
				<button class="w3-button w3-right w3-white w3-border" id='PrtnInsrtBtn'>등록</button>
			</div>
		</div>
	</div>
</body>
</html>