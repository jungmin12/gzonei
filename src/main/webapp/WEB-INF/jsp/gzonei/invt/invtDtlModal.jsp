<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<!-- 투자 정보 상세보기 ::S -->
			<div class="modal fade" role="dialog" data-ly-type="content"
				data-ly-target="modal-map2">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal__body">
						<div class="modal__header">
							<h4 class="modal__title">투자 정보 상세보기</h4>
							<div class="modal__close-button">
								<button type="button" class="close" data-dismiss="modal">닫기</button>
							</div>
						</div>
						<div class="modal__content" style="word-break: break-all">
							<div class="cont_wrap">

								<div class="modal_form">
									<div class="form-horizontal bucket-form">
										<div class="form-group">
											<div class="col-sm-2 control-label">
												<label for="birth">Gzonei 멘트</label>
											</div>
											<div class="col-sm-2">
												<select name="tel" class="form-control" title="연령대 선택">
													<option>국민은행</option>
												</select>
											</div>
											<div class="col-sm-8">
												<textarea title="Gzonei 멘트" placeholder="Gzonei 멘트를 입력하세요."
													class="form-control"></textarea>
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-2 control-label">
												<label for="birth">예상 보상 상태</label>
											</div>
											<div class="col-sm-4">
												<select id="tel1" name="tel" class="form-control"
													title="연령대 선택">
													<option value=""></option>
												</select>
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-2 control-label">
												<label for="brhs">예상 보상 시기</label>
											</div>
											<div class="col-sm-4">
												<div class="search--calendar">
													<span> <input type="text" class="form-control"
														name="startDate" id="startDate" placeholder="시작일" value=""
														title="시작일 입력">
														<button type="button" class="btn__calendar">
															<span class="skip">달력선택</span>
														</button>
													</span>
												</div>
											</div>
											<div class="col-sm-2 control-label">
												<label for="">관리자 수정일자</label>
											</div>
											<div class="col-sm-4">
												<div class="search--calendar">
													<span> <input type="text" class="form-control"
														name="endDate" id="endDate" placeholder="종료일" value=""
														title="종료일 입력">
														<button type="button" class="btn__calendar">
															<span class="skip">달력선택</span>
														</button>
													</span>
												</div>
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-2 control-label">
												<label for="brhs">공개 여부</label>
											</div>
											<div class="col-sm-4">
												<input class="radio-input" type="radio" id="radio1"
													name="ch_01_01" title="개발정보" value="a"> <label
													class="radio-inline" for="radio1">공개 여부2</label> <input
													class="radio-input" type="radio" id="radio2"
													name="ch_01_01" title="투자정보" value="b"> <label
													class="radio-inline" for="radio2">공개 여부1</label>
											</div>
											<div class="col-sm-2 control-label">
												<label for="">샘플 보기 여부</label>
											</div>
											<div class="col-sm-4">
												<input class="radio-input" type="radio" id="radio1"
													name="ch_01_01" title="개발정보" value="a"> <label
													class="radio-inline" for="radio1">샘플 보기 여부1</label> <input
													class="radio-input" type="radio" id="radio2"
													name="ch_01_01" title="투자정보" value="b"> <label
													class="radio-inline" for="radio2">샘플 보기 여부2</label>
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-2 control-label">
												<label for="birth">첨부 파일</label>
											</div>
											<div class="col-sm-10">
												<div class="form-upload">
													<div class="file-form-group">
														<div class="form-group__upload">
															<input type="text" readonly="readonly"
																class="form-control disabled" title="1번째 파일명"> <input
																type="file" name="file_1" id="atchmn_1"
																class="form-upload__file--hidden">
														</div>
														<div class="form-input__addon">
															<label for="atchmn_1" class="btn btn-sm btn-primary"
																data-button="upload"><span class="skip">1번째
															</span>파일선택</label>
														</div>
													</div>
													<div class="file-form-group">
														<div class="form-group__upload">
															<input type="text" readonly="readonly"
																class="form-control disabled" title="1번째 파일명"> <input
																type="file" name="file_1" id="atchmn_1"
																class="form-upload__file--hidden">
														</div>
														<div class="form-input__addon">
															<label for="atchmn_1" class="btn btn-sm btn-primary"
																data-button="upload"><span class="skip">1번째
															</span>파일선택</label>
														</div>
													</div>

													<div class="file-button">
														<button type="button">추가</button>
														<button type="button">삭제</button>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="text-center button_align">
										<button type="button" class="btn btn-default">취소</button>
										<button type="button" class="btn btn-default">삭제</button>
										<button type="button" class="btn btn-primary">수정</button>
									</div>
								</div>

								<div class="top_head">
									<h3 class="h_title_sub">개발사업 추진내역</h3>
									<button type="button" class="btn btn-primary btn-sm"
										onclick="formAdd()">추가</button>
								</div>
								<div class="table-scroll">
									<table class="table table-bordered text-center">
										<caption>테이블 안내 – 구분, 부서/직위, 성명, 연락처, 홈페이지 정보 제공</caption>
										<colgroup>
											<col style="width: 12%">
											<col style="width: 10%">
											<col style="width: 10%">

											<col style="width: auto">
											<col style="width: 10%">
											<col style="width: 10%">
											<col style="width: 10%">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">일련번호</th>
												<th scope="col">추진시작일</th>
												<th scope="col">추진종료일</th>
												<th scope="col">제목</th>
												<th scope="col">연관키워드1</th>
												<th scope="col">추진구분</th>
												<th scope="col">첨부파일명</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="top_head" style="margin-top: 20px;">
									<h3 class="h_title_sub">개발사업 추진내역</h3>
									<button type="button" class="btn btn-primary btn-sm"
										onclick="formAdd()">추가</button>
								</div>

								<div class="table-scroll">
									<table class="table table-bordered text-center">
										<caption>테이블 안내 – 구분, 부서/직위, 성명, 연락처, 홈페이지 정보 제공</caption>
										<colgroup>
											<col style="width: 12%">
											<col style="width: 10%">
											<col style="width: 10%">

											<col style="width: auto">
											<col style="width: 10%">
											<col style="width: 10%">
											<col style="width: 10%">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">일련번호</th>
												<th scope="col">추진시작일</th>
												<th scope="col">추진종료일</th>
												<th scope="col">제목</th>
												<th scope="col">연관키워드1</th>
												<th scope="col">추진구분</th>
												<th scope="col">첨부파일명</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
											<tr>
												<th scope="row">일련번호</th>
												<td>추진시작일</td>
												<td>추진종료일</td>
												<td>제목</td>
												<td>연관키워드1</td>
												<td>추진구분</td>
												<td>첨부파일명</td>
											</tr>
										</tbody>
									</table>
								</div>
								<div id="form-map" style="display: none;">
									<div class="top_head">
										<h3 class="h_title_sub">추진내역 등록</h3>
									</div>
									<div class="modal_form">
										<div class="form-horizontal bucket-form">

											<div class="form-group">
												<div class="col-sm-2 control-label">
													<label for="birth">예상 보상 상태</label>
												</div>
												<div class="col-sm-4">
													<input type="text" class="form-control"
														placeholder="예상 보상 상태" value="" title="예상 보상 상태 입력">
												</div>
												<div class="col-sm-2 control-label">
													<label for="birth">추진구분</label>
												</div>
												<div class="col-sm-4">
													<select id="" name="" class="form-control" title="추진구분 선택">
														<option value=""></option>
													</select>
												</div>
											</div>

											<div class="form-group">
												<div class="col-sm-2 control-label">
													<label for="">제목</label>
												</div>
												<div class="col-sm-10">
													<input type="text" class="form-control" placeholder="제목"
														value="" title="제목 입력">
												</div>
											</div>
											<div class="form-group">
												<div class="col-sm-2 control-label">
													<label for="brhs">추진시작일</label>
												</div>
												<div class="col-sm-4">
													<div class="search--calendar">
														<span> <input type="text" class="form-control"
															name="startDate" id="startDate" placeholder="시작일"
															value="" title="시작일 입력">
															<button type="button" class="btn__calendar">
																<span class="skip">달력선택</span>
															</button>
														</span>
													</div>
												</div>
												<div class="col-sm-2 control-label">
													<label for="">추진종료일</label>
												</div>
												<div class="col-sm-4">
													<div class="search--calendar">
														<span> <input type="text" class="form-control"
															name="endDate" id="endDate" placeholder="종료일" value=""
															title="종료일 입력">
															<button type="button" class="btn__calendar">
																<span class="skip">달력선택</span>
															</button>
														</span>
													</div>
												</div>
											</div>
											<div class="form-group">
												<div class="col-sm-2 control-label">
													<label for="brhs">공개 여부</label>
												</div>
												<div class="col-sm-4">
													<input class="radio-input" type="radio" id="radio1"
														name="ch_01_01" title="개발정보" value="a"> <label
														class="radio-inline" for="radio1">공개 여부2</label> <input
														class="radio-input" type="radio" id="radio2"
														name="ch_01_01" title="투자정보" value="b"> <label
														class="radio-inline" for="radio2">공개 여부1</label>
												</div>
												<div class="col-sm-2 control-label">
													<label for="">샘플 보기 여부</label>
												</div>
												<div class="col-sm-4">
													<input class="radio-input" type="radio" id="radio1"
														name="ch_01_01" title="개발정보" value="a"> <label
														class="radio-inline" for="radio1">샘플 보기 여부1</label> <input
														class="radio-input" type="radio" id="radio2"
														name="ch_01_01" title="투자정보" value="b"> <label
														class="radio-inline" for="radio2">샘플 보기 여부2</label>
												</div>
											</div>
											<div class="form-group">
												<div class="col-sm-2 control-label">
													<label for="">연관키워드</label>
												</div>
												<div class="col-sm-10">
													<input type="text" class="form-control" placeholder="연관키워드"
														value="" title="연관키워드 입력">
												</div>
											</div>
											<div class="form-group">
												<div class="col-sm-2 control-label">
													<label for="birth">첨부 파일</label>
												</div>
												<div class="col-sm-2">
													<select name="tel" class="form-control" title="연령대 선택">
														<option>등급</option>
													</select>
												</div>
												<div class="col-sm-8">
													<div class="form-upload">
														<div class="file-form-group">
															<div class="form-group__upload">
																<input type="text" readonly="readonly"
																	class="form-control disabled" title="1번째 파일명">
																<input type="file" name="file_1" id="atchmn_1"
																	class="form-upload__file--hidden">
															</div>
															<div class="form-input__addon">
																<label for="atchmn_1" class="btn btn-sm btn-primary"
																	data-button="upload"><span class="skip">1번째
																</span>파일선택</label>
															</div>
														</div>
														<div class="file-form-group">
															<div class="form-group__upload">
																<input type="text" readonly="readonly"
																	class="form-control disabled" title="1번째 파일명">
																<input type="file" name="file_1" id="atchmn_1"
																	class="form-upload__file--hidden">
															</div>
															<div class="form-input__addon">
																<label for="atchmn_1" class="btn btn-sm btn-primary"
																	data-button="upload"><span class="skip">1번째
																</span>파일선택</label>
															</div>
														</div>

														<div class="file-button">
															<button type="button">추가</button>
															<button type="button">삭제</button>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="text-center button_align">
											<button type="button" class="btn btn-default">취소</button>
											<button type="button" class="btn btn-primary">등록</button>
										</div>
									</div>
								</div>

							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 투자 정보 상세보기 ::E -->
