<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<!-- 경/공매 쓰기 -->
<div id="rewardAdminInsert" class="scroll" style="display: none;">
    <strong class="title">보상전례 등록하기</strong>
    <div class="modal__content" style="word-break: break-all">
        <div class="cont_wrap">
            <form id="rewardInsertDiv" name="rewardInsertDiv">
                <div class="modal_form">
                    <div class="form-horizontal bucket-form">
                        <div class="form-group">
                            <div class="col-sm-2 control-label">
                                <label class="sideAdmTitle" for="select">개발사업번호</label>
                            </div>
                            <div class="col-sm-4">
                                <input type="text" id="rewardDwkNo" name="dwkNo" class="form-control disabled" value="" readonly>
                            </div>
                            <div class="col-sm-1" style="padding-right: 0;">
                                <label class="sideAdmTitle" for="select">개발사업명</label>
                            </div>
                            <div class="col-sm-4">
                                <input type="text" id="rewardDwkNm" name="dwkNm" class="form-control disabled" value="" readonly>
                            </div>
                            <div class="col-sm-1">
                                <label class="btn btn-sm btn-secondary" id="modalBtn" name="modalBtn" data-ly-btn="reward-search" title="[Step-1]개발사업을 검색합니다.">
                                    <span class="skip"></span>개발정보</label>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-2">
                                <label class="sideAdmTitle" for="select">주 소</label>
                            </div>
                            <div class="col-sm-2">
                                <select name="upperMapCode" id="upperMapCodeReward" class="form-control rewardAdmAreaAdd1" onchange="areaChange(this,'mapCodeReward')">
                                    <option value="">-- 전체 --</option>
                                </select>
                            </div>
                            <div class="col-sm-2">
                                <select name="mapCode" id="mapCodeReward" class="form-control rewardAdmAreaAdd2">
                                    <option value="">-- 전체 --</option>
                                </select>
                            </div>
                            <div class="col-sm-5">
                                <input type="text" id="addrReward" name="addr" title="이름 입력" class="form-control" value="" onchange="findrewardloc('Reward')">
                            </div>
                            <div class="col-sm-1">
                                <label class="btn btn-sm btn-secondary" id="findrewardloc" name="findeLoc" onclick="findrewardloc('Reward')" title="[Step-2]입력된 주소의 좌표를 자동입력합니다.">
                                    <span class="skip"></span>위치입력</label>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-2 control-label col-lg-2">
                                <label class="sideAdmTitle" for="select">대표 위치</label>
                            </div>
                            <div class="col-sm-9">
                                <input type="text" id="locReward" name="loc" title="이름 입력" class="form-control" value="" readonly="">
                            </div>
                            <div class="col-sm-1">
                                <label class="btn btn-sm btn-secondary" id="findrewardloc" name="findeLoc" onclick="checkRewaedAddr('Reward')" title="[Step-3]입력된  좌표의 위치를 확인합니다.">
                                    <span class="skip"></span>위치확인</label>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-2 control-label col-lg-2">
                                <label class="sideAdmTitle" for="select">경도(X)</label>
                            </div>
                            <div class="col-sm-4">
                                <input type="text" class="form-control disabled" name="lo" id="loReward" readonly="">
                            </div>
                            <div class="col-sm-1">
                                <label class="sideAdmTitle" for="select">위도(Y)</label>
                            </div>
                            <div class="col-sm-4">
                                <input type="text" class="form-control disabled" name="la" id="laReward" readonly="">
                            </div>
                            <div class="col-sm-1">
                                <label class="btn btn-sm btn-secondary" id="checkRewaedAddr" name="checkLoc" onclick="changeRewaedAddr('Reward')" title="[Step-4]입력된  좌표 위치를 변경합니다.">
                                    <span class="skip"></span>위치변경</label>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-2 control-label col-lg-2">
                                <label class="sideAdmTitle" for="select">지목용도</label>
                            </div>
                            <div class="col-sm-4">
                                <select name="prposOneCode" id="prposOneCode" class="form-control" onchange="propChange('1',this)">
                                    <option value="">-- 필수항목 --</option>
                                </select>
                                <select name="prposTwoCode" id="prposTwoCode" class="form-control" style="display: none;" onchange="propChange('2',this)"></select>
                                <select name="prposThreeCode" id="prposThreeCode" class="form-control" style="display: none;"></select>
                            </div>
                            <div class="col-sm-1">
                                <label class="sideAdmTitle" for="select">면적(㎡)</label>
                            </div>
                            <div class="col-sm-5">
                                <input type="text" id="ar" name="ar" class="form-control money" value="" maxlength="15">
                            </div>
                        </div>
                        <div class="form-group">
                        	 <div class="col-sm-2">
                                <label id="aucAdmDiv2" class="sideAdmTitle" for="select">가격시점 개별지가(㎡)</label>
                            </div>
                            <div class="col-sm-4">
                                <input type="text" class="form-control money" name="pcpnttmIndvdlzPclnd" id="pcpnttmIndvdlzPclnd" maxlength="15">
                            </div>
                            <div class="col-sm-1">
                                <label class="sideAdmTitle" for="pcpnttm">가격시점</label>
                            </div>
                            <div class="col-sm-5">
                            	<div>
									<span>
										<input type="text" class="form-control" name="pcpnttm" id="pcpnttm" placeholder="가격시점" value="" title="가격시점 입력" autocomplete='off'/>
										<button type="button" class="btn__calendar"><span class="skip">달력선택</span></button>
									</span>
								</div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-2">
                                <label id="aucAdmDiv2" class="sideAdmTitle" for="select">㎡ 당 보상단가(원)</label>
                            </div>
                            <div class="col-sm-4">
                                <input type="text" class="form-control money" name="rewardCo" id="rewardCo" maxlength="15">
                            </div>
                            <div class="col-sm-2">
                                <label id="aucAdmDiv2" for="avg">산술평균 여부</label>
                            </div>
                            <div class="col-sm-4">
                                <input class="radio-input" type="radio" value="Y" id="avgY" name="arithAvrgAt" checked=""><label class="radio-inline" for="avgY">사용</label>
                                <input class="radio-input" type="radio" value="N" id="avgN" name="arithAvrgAt"><label class="radio-inline" for="avgN">미사용</label>
                            </div>
                        </div>
                        <div class="form-group">
                        	<div class="col-sm-2">
                                <label id="aucAdmDiv2" class="sideAdmTitle" for="select">이용현황</label>
                            </div>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" name="useSttus" id="useSttus">
                            </div>
                            <div class="col-sm-2">
                                <label id="aucAdmDiv2" for="dwkOthbcAt">공개여부</label>
                            </div>
                            <div class="col-sm-4">
                                <input class="radio-input" type="radio" value="Y" id="Y" name="useAt" checked=""><label class="radio-inline" for="Y">공개</label>
                                <input class="radio-input" type="radio" value="N" id="N" name="useAt"><label class="radio-inline" for="N">비공개</label>
                            </div>
                        </div>
                    </div>
                    <div class="text-center button_align">
                        <button type="button" id="rewardInfoInsertBtn" class="btn btn-primary">등록</button>
                        <button type="button" id="" class="btn btn-default" onclick="javascript:sideShow('rewardAdminList');">취소</button>
                    </div>
                </div>
            </form>
        </div>
        <!-- 경/공매 쓰기 -->
        <!-- 경/공매 리스트 -->
        <link rel="stylesheet" href="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/jQueryDatepicker/jquery.datetimepicker.min.css' />">
        <script src="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/jQueryDatepicker/jquery.datetimepicker.full.min.js' />"></script>
        <script>
            $(document).ready(function () {
                $.datetimepicker.setLocale('ko');
                $("#pcpnttm").datetimepicker({
                	timepicker: false, 
                	format: 'Y-m-d', 
                	scrollMonth: false, 
                	scrollInput: false
                }).on('keydown', function(event){
                	onlyNum(this,event);
	     		});
            });
        </script>
        <!-- List : S -->
    </div>
</div>