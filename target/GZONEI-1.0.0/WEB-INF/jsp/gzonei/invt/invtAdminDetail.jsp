<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<!-- 경/공매 쓰기 -->
<div id="invtInfoAdminDtl" class="scroll" style="display: none;">
	<strong class="title">투자정보 상세보기</strong>
	<div class="modal__content" style="word-break: break-all">
		<div class="cont_wrap">
			<form id="invDetailDiv" name="invDetailDiv">
				<input type="hidden" name="invtInfoSn" />
				<input type="hidden" name="aucPblsalSeCodeDt" />
				<div class="modal_form">
					<div class="form-horizontal bucket-form">
						<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2">
								<label class="sideAdmTitle" for="select">경/공매 구분​</label>
							</div>
							<div class="col-sm-4">
								<select name="aucPblsalSeCodeDtl" id="aucPblsalSeCodeDtl"
									class="form-control">
									<option value="CM00110001">경매</option>
									<option value="CM00110002">공매</option>
								</select>
							</div>
							<div class="col-sm-1">
								<label class="btn btn-sm btn-secondary" id="showModalBtnDtl"
									name="showModalBtn" data-ly-btn="invt-search"><span
									class="skip"></span>개발정보</label>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2">
								<label class="sideAdmTitle" for="select">개발사업번호​</label>
							</div>
							<div class="col-sm-4">
								<input type="text" id="dwkno" name="dwkno"
									class="form-control disabled" value="" readonly>
							</div>
							<div class="col-sm-2 control-label col-lg-2">
								<label class="sideAdmTitle" for="select">개발사업명​</label>
							</div>
							<div class="col-sm-4">
								<input type="text" id="dwknm" name="dwknm"
									class="form-control disabled" value="" readonly>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2">
								<label class="sideAdmTitle" for="select">편입 여부​</label>
							</div>
							<div class="col-sm-4">
								<select name="incrprAtDtl" id="incrprAtDtl" class="form-control">
									<option value="Y">편입</option>
									<option value="N">인근</option>
								</select>
							</div>
							<div class="col-sm-2 control-label col-lg-2">
								<labelclass="sideAdmTitle"  for="select">편입 면적​</label>
							</div>
							<div class="col-sm-4">
								<input type="text" id="incrprAr" name="incrprAr"
									class="form-control" value="">
							</div>
						</div>
						<div id="aucAdmDivDtl1">
							<div class="form-group">
								<div class="col-sm-2 control-label col-lg-2">
									<label class="sideAdmTitle" for="select">법 원​</label>
								</div>
								<div class="col-sm-4">
									<select name="courtNmDtl" id="courtNmDtl" class="form-control">
										<option value="CM00110001">법원1</option>
									</select>
								</div>
								<div class="col-sm-2 control-label col-lg-2">
									<label class="sideAdmTitle" for="select">계코드​</label>
								</div>
								<div class="col-sm-4">
									<input type="text" id="smCode" name="smCode" title="계코드 입력"
										class="form-control" value="">
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-2 control-label col-lg-2">
									<label class="sideAdmTitle" for="select">물건번호​</label>
								</div>
								<div class="col-sm-4">
									<input type="text" id="thingNo" name="thingNo" title="물건번호 입력"
										class="form-control" value="">
								</div>
								<div class="col-sm-2 control-label col-lg-2">
									<label class="sideAdmTitle" for="select">사건번호​</label>
								</div>
								<div class="col-sm-4">
									<input type="text" id="incdntManageNo" name="incdntManageNo"
										title="사건번호 입력" class="form-control" value="">
								</div>
							</div>
						</div>
						<div id="paucAdmDivDtl1" class="form-group" style="display: none;">
							<div class="col-sm-2 control-label col-lg-2">
								<label class="sideAdmTitle" for="select">사건번호​</label>
							</div>
							<div class="col-sm-6">
								<input type="text" id="pincdntManageNo" name="pincdntManageNo"
									title="사건번호 입력" class="form-control" value="">
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2">
								<label class="sideAdmTitle" for="select">주 소​</label>
							</div>
							<div class="col-sm-2">
								<select name="invAdmAreaAddDtl1" id="invAdmAreaAddDtl1"
									class="form-control invAdmAreaAddDtl1">
									<option value="">-- 전체 --</option>
								</select>
							</div>
							<div class="col-sm-2">
								<select name="invAdmAreaAddDtl2" id="invAdmAreaAddDtl2"
									class="form-control invAdmAreaAddDtl2">
									<option value="">-- 전체 --</option>
								</select>
							</div>
							<div class="col-sm-5">
								<input type="text" id="addr" name="addr" title="이름 입력"
									class="form-control" value="">
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2">
								<label class="sideAdmTitle" for="select">대표 위치​</label>
							</div>
							<div class="col-sm-6">
								<input type="text" id="locDtl" title="이름 입력"
									class="form-control" value="">
							</div>
							<div class="col-sm-1">
								<label class="btn btn-sm btn-secondary" id="findLocDtl"><span
									class="skip"></span>위치입력</label>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2">
								<label class="sideAdmTitle" for="select">경도(X)​</label>
							</div>
							<div class="col-sm-2 control-label col-lg-2">
								<input type="text" class="form-control disabled" id="loDtl" name="loDtl" readonly>
							</div>
							<div class="col-sm-2 control-label col-lg-2">
								<label class="sideAdmTitle" for="select">위도(Y)​</label>
							</div>
							<div class="col-sm-2 control-label col-lg-2">
								<input type="text" class="form-control disabled" id="laDtl" name="laDtl" readonly>
							</div>
							<div class="col-sm-1">
								<label class="btn btn-sm btn-secondary" id="checkLocDtl"><span
									class="skip"></span>위치확인</label>
							</div>
							<div class="col-sm-1">
								<label class="btn btn-sm btn-secondary" id="moveInvtDtl"><span
									class="skip"></span>위치변경</label>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2">
								<label class="sideAdmTitle" for="select">지목용도​</label>
							</div>
							<div class="col-sm-4">
								<select name="prposCodeDtl1" id="prposCodeDtl1"
									class="form-control prposCodeDtl1">
								</select> <select name="prposCodeDtl2" id="prposCodeDtl2"
									class="form-control prposCodeDtl2">
								</select> <select name="prposCodeDtl3" id="prposCodeDtl3"
									class="form-control prposCodeDtl3">
								</select>
							</div>
							<div class="col-sm-2 control-label col-lg-2">
								<label class="sideAdmTitle" for="select">감정평가금액​</label>
							</div>
							<div class="col-sm-4">
								<input type="text" id="apasmtAmount" name="apasmtAmount"
									title="사건번호 입력" class="form-control" value="">
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2">
								<label class="sideAdmTitle" id="aucAdmDivDtl2" for="select">입찰일​</label> <label
									class="sideAdmTitle" id="paucAdmDivDtl4" for="select" style="display: none;">입찰시작일​</label>
							</div>
							<div class="col-sm-4" id="paucAdmDivDtl3" style="display: none;">
								<div class="search--calendar">
									<span> <input type="text" class="form-control"
										name="startDate" id="startDateIAD" placeholder="시작일" value=""
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
										name="endDate" id="endDateIAD" placeholder="시작일" value=""
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
								<input class="radio-input" type="radio" id="radioYdt"
									name="cntntsOthbcAt" value="Y"> <label
									class="radio-inline cntntsOthbcAtBtn" for="radioYdt">예</label> <input
									class="radio-input" type="radio" id="radioNdt"
									name="cntntsOthbcAt" value="N"> <label
									class="radio-inline cntntsOthbcAtBtn" for="radioNdt">아니요</label>
							</div>
							<div class="col-sm-2 control-label">
								<label class="sideAdmTitle" for="select">샘플보기여부</label>
							</div>
							<div class="col-sm-4">
								<input class="radio-input" type="radio" id="radio3dt"
									name="smpleExAt" value="Y"> <label class="radio-inline"
									for="radio3dt">예</label> <input class="radio-input" type="radio"
									id="radio4dt" name="smpleExAt" value="N"> <label
									class="radio-inline" for="radio4dt">아니요</label>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-2 control-label">
								<label class="sideAdmTitle" for="select">보상여부</label>
							</div>
							<div class="col-sm-10">
								<input class="radio-input" type="radio" id="radio5dt"
									name="rewardAt" value="CM00160001"> <label
									class="radio-inline" for="radio5dt">보상중</label> <input
									class="radio-input" type="radio" id="radio6dt" name="rewardAt"
									value="CM00160002"> <label class="radio-inline"
									for="radio6dt">보상예정</label> <input class="radio-input"
									type="radio" id="radio7dt" name="rewardAt" value="CM00160003">
								<label class="radio-inline" for="radio7dt">보상완료</label>
								<!-- 					<input -->
								<!-- 					class="radio-input" type="radio" id="radio8" name="rewardAt"> <label -->
								<!-- 					class="radio-inline" for="radio8">환지</label> <input -->
								<!-- 					class="radio-input" type="radio" id="radio9" name="rewardAt"> <label -->
								<!-- 					class="radio-inline" for="radio9">기타</label> -->
							</div>
						</div>
					</div>
					<div class="text-center button_align">
						<button type="button" id="invtnfoAdDtlUpdateBtn"
							class="btn btn-primary">수정</button>
						<button type="button" id="invtInfoAdDtlDelBtn"
							class="btn btn-primary">삭제</button>
						<button type="button" class="btn btn-default" id="invtInfoAdDtlCanBtn"
							>취소</button>
					</div>
				</div>
			</form>


			<div class="top_head">
				<h3 class="h_title_sub">투자정보 진행내역</h3>
				<button type="button" class="btn btn-primary btn-sm"
					id="showProInsrtBtn">추가</button>
			</div>
			<form id="proListForm" name="proListForm" method="post">
				<input type="hidden" name="invtProgrsDtlsSn" /> <input
					type="hidden" name="invtInfoSn" />
			</form>
			<div id="proListTbody" class="table-scroll"></div>

			<div id="proAucInsert" class="devInfoAdPrtn" style="display: none;">
				<div class="top_head">
					<h3 class="h_title_sub">경매 진행내역 등록</h3>
				</div>
				<div class="modal_form">
					<form id="proAInsertForm" name="proAInsertForm" method="post"
						enctype="multipart/form-data">
						<div class="form-horizontal bucket-form">
							<input type="hidden" name="invtProgrsDtlsSnAI" /> <input
							type="hidden" name="invtInfoSnAI" />
							<div class="form-group">
								<div class="col-sm-2 control-label">
									<label class="sideAdmTitle">입찰금액</label>
								</div>
								<div class="col-sm-4">
									<input type="text" name="bidAmountAI" class="form-control"
										placeholder="제목" value="" title="제목 입력">
								</div>
								<div class="col-sm-2 control-label">
									<label class="sideAdmTitle">입찰일자</label>
								</div>
								<div class="col-sm-4">
									<div class="search--calendar">
										<span> <input type="text" class="form-control"
											name="bidDeAI" id="bidDeAI" placeholder="입찰일" >
											<button type="button" class="btn__calendar">
												<span class="skip">달력선택</span>
											</button>
										</span>
									</div>
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-2 control-label">
									<label class="sideAdmTitle">진행결과</label>
								</div>
								<div class="col-sm-4">
									<select id="progrsResultCodeAI" name="progrsResultCodeAI"
										class="prtnClCode form-control" title="진행결과 선택">
										<option value=""></option>
									</select>
								</div>
								<div class="col-sm-2 control-label">
									<label class="sideAdmTitle">낙찰금액</label>
								</div>
								<div class="col-sm-4">
									<input type="text" name="scsbidAmountAI" class="form-control"
										placeholder="낙찰금액" value="" title="제목 입력">
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-2 control-label">
									<label class="sideAdmTitle">낙찰자 명</label>
								</div>
								<div class="col-sm-4">
									<input type="text" name="sucbidrNmAI" class="form-control"
										placeholder="낙찰자명" value="" title="제목 입력">
								</div>
								<div class="col-sm-2 control-label">
									<label class="sideAdmTitle">응찰자 수</label>
								</div>
								<div class="col-sm-4">
									<input type="text" name="entendManCoAI" class="form-control"
										placeholder="응찰자수" value="" title="제목 입력">
								</div>
							</div>
							<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2">
								<label class="sideAdmTitle">비 고&ZeroWidthSpace;
								</label>
							</div>
							<div class="col-sm-10">
								<textarea class="form-control" id="rmAI" name="rmAI" title="내용 입력" rows="20" style="height: 100px"> </textarea>
							</div>
							</div>
							
						</div>
					</form>
					<div class="text-center button_align">
						<button type="button" id="proAucInsertBtn" class="btn btn-primary">등록</button>
						<button type="button" id="proAucCancleBtn" class="btn btn-default">취소</button>
					</div>
				</div>
			</div>
			
			<div id="proPaucInsert" class="devInfoAdPrtn" style="display: none;">
				<div class="top_head">
					<h3 class="h_title_sub">공매 진행내역 등록</h3>
				</div>
				<div class="modal_form">
					<form id="proDInsertForm" name="proDInsertForm"method="post"
						enctype="multipart/form-data">
						<div class="form-horizontal bucket-form">
							<input type="hidden" name="invtProgrsDtlsSnPI" /> <input
							type="hidden" name="invtInfoSnPI" />
							<div class="form-group">
								<div class="col-sm-2 control-label">
									<label class="sideAdmTitle">입찰시작일자</label>
								</div>
								<div class="col-sm-4">
									<div class="search--calendar">
										<span> <input type="text" class="form-control"
											name="bidBgndePI" id="bidBgndePI" placeholder="입찰일" >
											<button type="button" class="btn__calendar">
												<span class="skip">달력선택</span>
											</button>
										</span>
									</div>
								</div>
								<div class="col-sm-2 control-label">
									<label class="sideAdmTitle">입찰종료일자</label>
								</div>
								<div class="col-sm-4">
									<div class="search--calendar">
										<span> <input type="text" class="form-control"
											name="bidEnddePI" id="bidEnddePI" placeholder="입찰일" >
											<button type="button" class="btn__calendar">
												<span class="skip">달력선택</span>
											</button>
										</span>
									</div>
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-2 control-label">
									<label class="sideAdmTitle">진행결과</label>
								</div>
								<div class="col-sm-4">
									<select id="progrsResultCodePI" name="progrsResultCodePI"
										class="prtnClCode form-control" title="진행결과 선택">
										<option value=""></option>
									</select>
								</div>
								<div class="col-sm-2 control-label">
									<label class="sideAdmTitle">최저금액</label>
								</div>
								<div class="col-sm-4">
									<input type="text" name="lwetAmountPI" class="form-control"
										placeholder="최저금액" value="" >
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-2 control-label">
									<label class="sideAdmTitle">개찰일시</label>
								</div>
								<div class="col-sm-4">
									<input type="text" name="opengDtPI" class="form-control"
										placeholder="개찰일시 Ex)20210420" value="">
								</div>
								<div class="col-sm-2 control-label">
									<label class="sideAdmTitle">낙찰금액</label>
								</div>
								<div class="col-sm-4">
									<input type="text" name="scsbidAmountPI" class="form-control"
										placeholder="낙찰금액" value="" >
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-2 control-label">
									<label class="sideAdmTitle">응찰자수</label>
								</div>
								<div class="col-sm-4">
									<input type="text" name="entendManCoPI" class="form-control"
										placeholder="응찰자수" value="" title="제목 입력">
								</div>
							</div>
							<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2">
								<label class="sideAdmTitle">비 고&ZeroWidthSpace;
								</label>
							</div>
							<div class="col-sm-10">
								<textarea class="form-control" id="rmPI" name="rmPI" title="내용 입력" rows="20" style="height: 100px"> </textarea>
							</div>
							</div>
							
						</div>
					</form>
					<div class="text-center button_align">
						<button type="button" id="proPaucInsertBtn" class="btn btn-primary">등록</button>
						<button type="button" id="proPaucCancleBtn" class="btn btn-default">취소</button>
					</div>
				</div>
			</div>
			
			<div id="proAucDt" class="devInfoAdPrtn" style="display: none;">
				<div class="top_head">
					<h3 class="h_title_sub">경매 진행내역 상세보기</h3>
				</div>
				<div class="modal_form">
					<form id="proADetailForm" name="proADetailForm" method="post"
						enctype="multipart/form-data">
						<div class="form-horizontal bucket-form">
							<input type="hidden" name="invtProgrsDtlsSnAD" /> <input
							type="hidden" name="invtInfoSnAD" />
							<div class="form-group">
								<div class="col-sm-2 control-label">
									<label class="sideAdmTitle">입찰금액</label>
								</div>
								<div class="col-sm-4">
									<input type="text" name="bidAmountAD" class="form-control"
										placeholder="입찰금액" value="" title="입찰금액 입력">
								</div>
								<div class="col-sm-2 control-label">
									<label class="sideAdmTitle">입찰일자</label>
								</div>
								<div class="col-sm-4">
									<div class="search--calendar">
										<span> <input type="text" class="form-control"
											name="bidDeAD" id="bidDeAD" placeholder="입찰일" >
											<button type="button" class="btn__calendar">
												<span class="skip">달력선택</span>
											</button>
										</span>
									</div>
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-2 control-label">
									<label class="sideAdmTitle">진행결과</label>
								</div>
								<div class="col-sm-4">
									<select id="progrsResultCodeAD" name="progrsResultCodeAD"
										class="prtnClCode form-control" title="진행결과 선택">
										<option value=""></option>
									</select>
								</div>
								<div class="col-sm-2 control-label">
									<label class="sideAdmTitle">낙찰금액</label>
								</div>
								<div class="col-sm-4">
									<input type="text" name="scsbidAmountAD" class="form-control"
										placeholder="낙찰금액" value="" title="낙찰금액 입력">
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-2 control-label">
									<label class="sideAdmTitle">낙찰자 명</label>
								</div>
								<div class="col-sm-4">
									<input type="text" name="sucbidrNmAD" class="form-control"
										placeholder="낙찰자명" value="" title="낙찰자명 입력">
								</div>
								<div class="col-sm-2 control-label">
									<label class="sideAdmTitle">응찰자 수</label>
								</div>
								<div class="col-sm-4">
									<input type="text" name="entendManCoAD" class="form-control"
										placeholder="응찰자수" value="" title="응찰자수 입력">
								</div>
							</div>
							<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2">
								<label class="sideAdmTitle">비 고&ZeroWidthSpace;
								</label>
							</div>
							<div class="col-sm-10">
								<textarea class="form-control" id="rmAD" name="rmAD" title="내용 입력" rows="20" style="height: 100px"> </textarea>
							</div>
							</div>
							
						</div>
					</form>
					<div class="text-center button_align">
						<button type="button" id="proAucUpdateBtn" class="btn btn-primary">수정</button>
						<button type="button" id="proAucDeleteBtn" class="btn btn-primary">삭제</button>
						<button type="button" id="proAucCancleBtn" class="btn btn-default">취소</button>
					</div>
				</div>
			</div>
			
			<div id="proPaucDt" class="devInfoAdPrtn" style="display: none;">
				<div class="top_head">
					<h3 class="h_title_sub">공매 진행내역 상세보기</h3>
				</div>
				<div class="modal_form">
					<form id="proPDetailForm" name="proPDetailForm" method="post"
						enctype="multipart/form-data">
						<div class="form-horizontal bucket-form">
							<input type="hidden" name="invtProgrsDtlsSnPD" /> <input
							type="hidden" name="invtInfoSnPD" />
							<div class="form-group">
								<div class="col-sm-2 control-label">
									<label class="sideAdmTitle">입찰시작일자</label>
								</div>
								<div class="col-sm-4">
									<div class="search--calendar">
										<span> <input type="text" class="form-control"
											name="bidBgndePD" id="bidBgndePD" placeholder="입찰일" >
											<button type="button" class="btn__calendar">
												<span class="skip">달력선택</span>
											</button>
										</span>
									</div>
								</div>
								<div class="col-sm-2 control-label">
									<label class="sideAdmTitle">입찰종료일자</label>
								</div>
								<div class="col-sm-4">
									<div class="search--calendar">
										<span> <input type="text" class="form-control"
											name="bidEnddePD" id="bidEnddePD" placeholder="입찰일" >
											<button type="button" class="btn__calendar">
												<span class="skip">달력선택</span>
											</button>
										</span>
									</div>
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-2 control-label">
									<label class="sideAdmTitle">진행결과</label>
								</div>
								<div class="col-sm-4">
									<select id="progrsResultCodePD" name="progrsResultCodePD"
										class="prtnClCode form-control" title="진행결과 선택">
										<option value=""></option>
									</select>
								</div>
								<div class="col-sm-2 control-label">
									<label class="sideAdmTitle">최저금액</label>
								</div>
								<div class="col-sm-4">
									<input type="text" name="lwetAmountPD" class="form-control"
										placeholder="최저금액" value="" >
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-2 control-label">
									<label class="sideAdmTitle">개찰일시</label>
								</div>
								<div class="col-sm-4">
									<input type="text" name="opengDtPD" class="form-control"
										placeholder="개찰일시" value="">
								</div>
								<div class="col-sm-2 control-label">
									<label class="sideAdmTitle">낙찰금액</label>
								</div>
								<div class="col-sm-4">
									<input type="text" name="scsbidAmountPD" class="form-control"
										placeholder="낙찰금액" value="" >
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-2 control-label">
									<label class="sideAdmTitle">응찰자수</label>
								</div>
								<div class="col-sm-4">
									<input type="text" name="entendManCoPD" class="form-control"
										placeholder="응찰자수" value="" title="응찰자수 입력">
								</div>
							</div>
							<div class="form-group">
							<div class="col-sm-2 control-label col-lg-2">
								<label class="sideAdmTitle">비 고&ZeroWidthSpace;
								</label>
							</div>
							<div class="col-sm-10">
								<textarea class="form-control" id="rmPD" name="rmPD" title="내용 입력" rows="20" style="height: 100px"> </textarea>
							</div>
							</div>
							
						</div>
					</form>
					<div class="text-center button_align">
						<button type="button" id="proPaucUpdateBtn" class="btn btn-primary">수정</button>
						<button type="button" id="proPaucDeleteBtn" class="btn btn-primary">삭제</button>
						<button type="button" id="proDetailPCancleBtn" class="btn btn-default">취소</button>
					</div>
				</div>
			</div>
		</div>

		<!-- 경/공매 쓰기 -->
		<link rel="stylesheet"
			href="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/jQueryDatepicker/jquery.datetimepicker.min.css' />">
		<script
			src="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/jQueryDatepicker/jquery.datetimepicker.full.min.js' />"></script>
		<script>
			$(document).ready(function() {
				$.datetimepicker.setLocale('ko');
				$("#startDateIAD,#endDateIAD").datetimepicker({
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
