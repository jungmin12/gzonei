<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<div id="info" style="display: none;">
	<a href="#" class="side_toggle">사이드토글</a>
	<div class="scroll innerScroll">
		<strong class="title"><em id='devInfoDtl_area'></em><span id='devInfoDtl_dwkNm'></span></strong>
		<form id='devInfoDtlForm' name='devInfoDtlForm'>
			<input type='hidden' name='devlopInfoSn' value=''/>
			<input type='hidden' name='dwkNm' value=''/>
			<input type='hidden' name='dwkNo' value=''/>
			<div class="photoArea">
				<div id="devInfoDtl_thumbnail" class="thumbnail">
					<img id='devInfoTbImg' src="<c:url value='/images/develop/noImage.png'/>" alt="">
				</div>
				<div class="photoList">
					<ul>
						<li><strong>상세주소</strong><span id='devInfoDtl_addr'></span></li>
						<li><strong>면적</strong><span id='devInfoDtl_bsnsAr'></span></li>
						<li><strong>사업비</strong><span id='devInfoDtl_wct'></span></li>
						<li><strong>사업기간</strong><span id='devInfoDtl_bsnsDe'></span></li>
						<li><strong>시행사</strong><span id='devInfoDtl_opertnCmpny'></span></li>
						<li><strong>적용법률</strong><span id='devInfoDtl_applcLaw'></span></li>
						<li><strong>사업방식</strong><span id='devInfoDtl_bsnsMthdCode'></span></li>
						<li><strong>사업인정시점</strong><span id='devInfoDtl_bsnsrcognNtfcNm'></span></li>
						<li><strong>용지비</strong><span id='devInfoDtl_lct'></span></li>
					</ul>
				</div>
			</div>

			<div class="map__header">
				<span class="map__title">사업주요내용</span>
			</div>
			<div class="map__content">
				<ul id="devInfoDtl_bsnsCn">
				</ul>
			</div>

			<div class="map__header">
				<span class="map__title">추진내역</span>
			</div>
			<div class="map__content">
				<ul id="devInfoDtl_prtnList">
				</ul>
			</div>
			
			<div class="map__header">
				<span class="map__title">향후 추진계획</span>
				<span class="map__title pnttmText"></span>
			</div>
			<div class="map__content">
				<ul id="devInfoDtl_prtnPlanList">
				</ul>
			</div>
			
			<div class="map__header">
				<span class="map__title">첨부파일 다운로드</span>
			</div>
			<div class="map__content">
				<div id="devInfoDtl_fileList" class="ui-banner__box">
				</div>
			</div>
			
			<div class="map__header map__ment">
				<div class="menteu">
				<img class="gzMentImg" alt="" src="<c:url value='/css/gzonei/SRC/images/program/icon-title.png' />">
					<ul id="devInfoDtl_gzMent">
					</ul>
				</div>
			</div>


			<div class="ui-tip__box">
				<p class="txt-tip txt-small">본 개발정보는 <span id='mngrLastUpdtPnttmText' class="empTxt">2021년 02월 08일</span>까지 공개된 자료와 Gzone 당사가 직접 취재한 내용을 바탕으로 최종 수정된 자료입니다. 금일 이후 사업시행자의 사정 또는 경제여건의 변화 등에 따라 사업은 축소.확대.변경.취소 및 지연될 수 있으니 이용자께서는 이점 유의하시길 바랍니다.</p>
				<p class="txt-tip txt-small">본 개발정보는 참고사항이며 당사는 이에 대해 어떠한 경우라도 법적인 책임을 지지 않습니다.</p>
				<p class="txt-tip txt-small">본 개발정보의 지적소유권은 당사에 있으며 당사의 사전 서면 허락없이 이를 무단으로 전제, 복제 할 경우 저작권법에 따라 처벌을 받을 수 있습니다.</p>
				<p class="txt-tip txt-small">개발정보 상세내역에 대한 <span class="empTxt">출력[인쇄하기]</span>은 <span class="empTxt">하루 최대 20회</span>로 제한되어 있습니다. <span class="empTxt">인쇄하기 횟수는 클릭 시 차감</span>됩니다. 이용자께서는 이점 유의하시길 바랍니다.</p>
			</div>
			<p class="text-center print">
				<a id="printCntChk" class="btn btn-default1" ><i class="icon-print"></i>인쇄하기</a>
			</p>
			<div class="ui-tip__box">
				<p class="crTxt txt-small">copyright (c) Gzone Corp. All rights reserved.</p>
				<br/>
			</div>
		</form>
	</div>
	<div class="button-map">
		<button type="button" class="devInfoImgBtn" id="infoAdd" data-hover="off"><img src='<c:url value='/css/gzonei/SRC/images/map/icon-1.png' />'/><span>관심정보등록</span></button>
		<button type="button" class="devInfoImgBtn" id="infoParagraph" data-hover="off"><img src='<c:url value='/css/gzonei/SRC/images/map/icon-2.png' />'/><span>관련기사</span></button>
		<%-- <button type="button" class="devInfoImgBtn" id="infoObject" data-hover="off"><img src='<c:url value='/css/gzonei/SRC/images/map/icon-3.png' />'/><!-- 투자정보 --></button> --%>
		<button type="button" class="devInfoImgBtn" id="infoObject" data-hover="off"><img src='<c:url value='/css/gzonei/SRC/images/map/icon-3.png'/>'><span>투자정보</span></button>
		<c:if test="${authVO.adm009001.infoInqireAt eq 'Y'}">
			<button type="button" class="devInfoImgBtn" id="infoReward" data-hover="off"><img src='<c:url value='/css/gzonei/SRC/images/map/icon-4.png' />'/><span>보상전례</span></button>
		</c:if>
		<!-- 2021-05 class add -->
		<!-- <button type="button" id="infoAdd" class="txt_blt03 state05" >관심정보등록</button>
		<button type="button" id="infoParagraph" class="txt_blt03 state05">관련기사</button>
		<button type="button" id="infoObject" class="txt_blt03 state05">투자정보</button>
		<button type="button" id="infoReward" class="txt_blt03 state05">보상전례</button> -->
	</div>
	<button type="button" id="info_close">
		<span class="skip">정보창</span>
	</button>
</div>
<!-- 투자정보 물건보기 팝업/모달-->
<div id="modalInvtShowDev" class="modal" data-ly-type="content" >
	<div class="modal-dialog">
	<!-- Modal content-->
		<div id="devInfoDtlInvtModalBody" class="modal__body">
			<div class="modal__header">
				<h4 class="modal__title">투자정보 물건보기</h4>
				<div class="modal__close-button">
					<button type="button" class="close devInfoCloseBtn" data-dismiss="modal">닫기</button>
				</div>
			</div>
			<div class="modal__content" style="word-break: break-all">
				<div id="devInfoDtlInvtContent" class='box-list all__list'>
				<!-- LIST -->
					<div class="item">
					</div>
				</div>
				
			</div>
		</div>
	</div>
</div>
<!-- 관심정보 등록 팝업 -->
<div id="modalIntrst" class="modal" data-ly-type="content" >
	<div class="modal-dialog">
	<!-- Modal content-->
		<div id="devInfoModifyGroup" class="modal__body">
			<div class="modal__header">
				<h4 class="modal__title">관심정보 등록</h4>
				<div class="modal__close-button">
					<button type="button" class="close devInfoCloseBtn" data-dismiss="modal">닫기</button>
				</div>
			</div>
			<div class="modal__content">
				<form id='devInfoIntrst' name='devInfoIntrst'>
				<h2 class="h2">관심정보 추가</h2><!-- <strong id="group_title">관심정보 추가</strong> -->
				<div class="form-group" id="group_devInfoIntrst">
					<select class="form-control" id="devlopIntrstThingSn" name='devlopIntrstThingSn'>
						<option value=''></option>
					</select>
				</div>
				<div class="form-group" id="group_devInfoIntrst">
					<button type="button" id="devInfoIntrstGroupBtn"class="intrstBtn btn btn-default">관심그룹추가</button>
					<button type="button" id="devInfoIntrstAddBtn"class="intrstBtn btn btn-default">추가</button>
				</div>
				</form>
			</div>
		</div>
	</div>
</div>