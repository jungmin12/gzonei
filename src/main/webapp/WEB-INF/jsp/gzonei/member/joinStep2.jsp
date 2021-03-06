<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang='ko'>
<head>
<%@ include file="/WEB-INF/jsp/gzonei/layout/header.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/jsp/gzonei/layout/top.jsp" %>
<!-- header -->
<script>
window.name = "agreement";
$(document).ready(function(){
	// 체크박스 전체 선택
	$(".agree").on("click", "#agree_confirm_all", function () {
	    $(this).parents(".agree").find('input').prop("checked", $(this).is(":checked"));
	});
	
});
function openPCCWindow(){ 
	var PCC_window = window.open('', 'PCCV3Window', 'width=430, height=560, resizable=1, scrollbars=no, status=0, titlebar=0, toolbar=0, left=300, top=200' );

	if(PCC_window == null){ 
		alert(" ※ 윈도우 XP SP2 또는 인터넷 익스플로러 7 사용자일 경우에는 \n    화면 상단에 있는 팝업 차단 알림줄을 클릭하여 팝업을 허용해 주시기 바랍니다. \n\n※ MSN,야후,구글 팝업 차단 툴바가 설치된 경우 팝업허용을 해주시기 바랍니다.");
	}

	return true;
}	
function joinStep3() {
	var agreeYn;
	var totCnt = 0;
	var agreeCnt = 0;
	$('input[name=agree]').each(function(){
		agreeYn = $(this).is(":checked");
		totCnt++;
		if(agreeYn){
			agreeCnt++;
		}
		
	});
	if (totCnt != agreeCnt) {
		Common.Dialog.alert({
            content: '약관에 동의해주십시오.'
        });
		return;
	}

	var mberGradCode = $('#mberGradCode').val();
	
	if (mberGradCode == '01') {
		openPCCWindow();
		document.reqCBAForm.submit();
	}
	else if (mberGradCode == '02') {
		document.theForm2.action = "<c:url value='/joinStep3.do'/>";
		document.theForm2.submit();
	}
}
</script>

<!-- 구현부 : S -->
<div id="body_layout">	
    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
        	<form name="theForm2" id="theForm2" method="post">
				<input type="hidden" name="mberGradCode" id="mberGradCode" value="${mberGradCode}">
			</form>
			<c:if  test="${certVO != null or fn:length(certVO) != 0 }">
				<form name="resultForm" id="resultForm" method="post">
					<input type="hidden" name="retInfo" id="retInfo" value="${certVO.retInfo} }">
				</form>
			</c:if>
			
			<form name="reqCBAForm" method="post" action="<c:url value='/pccSendSeed.do'/>" target="PCCV3Window" border="0">
				<input type="hidden" name="id" value = "SGZN001">
				<input type="hidden" name="srvNo" value="${paramVO.serviceNum}">
				<input type="hidden" name="reqNum" value="${paramVO.reqNum }">
				<input type="hidden" name="certGb" value="H">                             
				<input type="hidden" name="certDate" value="${paramVO.certDate}">
				<input type="hidden" name="addVar" value="<c:url value='/joinStep3.do?psnMemCd=01'/>">
				<input type="hidden" name="retUrl" value="${paramVO.returnUrl}<%=request.getContextPath()%>/pccRecieveSeed.do">
			</form>
            <div id="txt">
            <!-- content 영역입니다. -->
				<ul class="step_list">
				    <li><span></span>회원선택</li>
				    <li class="on"><span></span>약관동의</li>
				    <li><span></span>정보입력</li>
				    <li><span></span>가입완료</li>
				</ul>
				<div class="agree">
				    <div class="top">
				        <p>소중한 회원님의 정보는 동의 없이 공개 되지 않으며 개인정보보호정책에 의거하여 보호 받고 있습니다.  지존에서는 회원님들의 개인정보보호를 위해 최선을 다할 것을 약속 드립니다. <b>이용약관, 개인정보 취급방침  및 휴면계정 약관에 대한 내용을 모두 확인하고 동의합니다.</b></p>
				        <div class="ui_radio--custom">
				            <input type="checkbox" name="" id="agree_confirm_all">
				            <label for="agree_confirm_all"><span class="chk_ball"></span>모두 동의합니다</label>
				        </div>
				    </div>
				            
				    <h2 class="h2">이용약관</h2>
				    <div class="agree-box">
				        <h2 class="h2 ">&#91; 제 1 장 총칙 &#93;</h2>
	                    <h3 class="h3">제 1 조 (목적)</h3>
	                    <p>본 약관은 (주)지존(이하&#34;회사&#34;라 함)에서 제공하는 인터넷상의 부동산 개발정보 및 보상과 관련된 정보서비스(서비스명 :<a href="http://www.gzonei.com"> http://www.gzonei.com</a>)이하 &#34;서비스&#34;라 함)의 이용조건 및 절차에 관한 사항과 기타 이용에 필요한 사항을 규정함을 목적으로 한다.</p>
	                    <h3 class="h3">제 2 조 (약관의 효력 및 변경)</h3>
	                    <ul>
	                        <li>1. 본 약관은 이용자가 회원에 가입함과 동시에 효력을 발생한다.</li>
	                        <li>2. 본 약관의 내용은 서비스의 화면에 게시하며 회사는 필요하다고 인정되는 경우 이 약관을 개정할 수 있으며, 변경된 약관은 회사가 제공하는 서비스를 통해 공지한다.</li>
	                        <li>3. 변경된 약관은 공지된 시점 이후에 효력을 발생한다.</li>
	                    </ul>
	                    <h3 class="h3">제 3 조 (용어의 정의)</h3>
	                    <p>본 약관에서 사용하는 용어의 정의는 다음과 같다.</p>
	                    <ul>
	                        <li>1. &#34;이용자&#34;라 함은 회사와 서비스 이용계약을 체결하고 회원등록 후 이용자번호를 부여받은 개인 또는 법인을 말한다.</li>
	                        <li>2. &#34;이용자번호(ID)&#34;라 함은 서비스 이용을 위하여 서비스 계약 체결 시 이용자의 선택에 의하여 회사가 부여하는 문자와 숫자의 조합을 말한다. <br>
	                        &#34;비밀번호(PW)&#34;라 함은 이용자번호와 일치된 이용자임을 확인하고 이용자 자신의 비밀을 보호하기 위하여 이용자 자신이 설정한 문자와 숫자의 조합을 말한다.</li>
	                        <li>3. &#34;회원&#34;이라 함은 유료 또는 무료와 무관하게 회원가입 절차를 거쳐 “회사”의 서비스 이용계약을 체결한 후 승인된 자를 말한다.</li>
	                        <li>4. &#34;이용요금&#34;이라 함은 유료서비스 계약체결 후 해지 전까지 부과되는 정보이용료로 부가가치세가 포함된 금액을 말한다.</li>
	                        <li>5. &#34;본 Site&#34;라 함은 <a href="www.gzonei.com">www.gzonei.com</a>을 말한다.</li>
	                    </ul>
	                    <h2 class="h2">&#91; 제 2 장 서비스 이용 계약 체결 &#93;</h2>
	                    <h3 class="h3">제 4 조 (이용 계약의 성립)</h3>
	                    <ul>
	                        <li>1. 이용계약은 회원의 이용신청과 회사의 이용승인에 의해 성립한다.</li>
	                        <li>2. 회사는 이용자가 모든 사항을 성실히 기재하여 이용신청을 완료하였을 때에는 필요사항을 확인한 후 지체없이 이용신청에 대하여 승인한다.</li>
	                        <li>3. 회사는 필요하다 인정될 경우 회원가입 및 이용승인 전에 관련 사항에 대하여 대면 면접, 유선 통화 등의 사전이행요건을 요구할 수 있다.</li>
	                        <li>4. 회원가입에 관련한 이용계약 외에 본 Site에서 제공하는 컨텐츠의 이용은 결제함과 동시에 계약이 성립된 것으로 한다.</li>
	                    </ul>
	                    <h3 class="h3">제 5 조 (이용계약의 유보 및 미승인)</h3>
	                    <ul>
	                        <li>1. 회사는 다음에 해당하는 경우에는 이용계약의 승인을 유보할 수 있다.
	                            <ul>
	                                <li>가. 서비스 설비용량에 여유가 없는 경우.</li>
	                                <li>나. 서비스를 제공하기에는 기술적으로 문제가 있다고 판단되는 경우.</li>
	                                <li>다. 기타 회사가 필요하다고 인정되는 경우.</li>
	                            </ul>
	                        </li>
	                        <li>2. 회사는 다음에 해당하는 경우에는 이용계약의 승인이 불가할 수 있다.
	                            <ul>
	                                <li>가. 주민등록표상의 본인 실명과 다른 비실명으로 이용신청을 하였을 경우.</li>
	                                <li>나. 이용신청서의 내용을 허위로 기재하였거나 허위서류를 첨부하여 이용신청을 하였을 경우.</li>
	                            </ul>
	                        </li>
	                    </ul>
	                    <h3 class="h3">제 6 조 (이용신청)</h3>
	                    <ul>
	                        <li>1. 이용계약은 이용자의 이용신청 및 이용약관에 대한 동의와 회사의 승인으로 성립된다.</li>
	                        <li>2. 회원에 가입하여 서비스를 이용하고자 하는 희망자는 회사에서 요청하는 개인 신상 정보 및 회사에서 요구하는 기타정보를 제공해야 하며 개인정보 미제공에 따른 정보 및 서비스 이용의 제한에 어떠한 이의도 제기하지 않기로 한다.</li>
	                        <li>3. 이용신청은 인터넷 상에서 <a href="http://www.gzonei.com">http://www.gzonei.com</a>로 접속한 후 소정의 양식에 의하여 등록 신청하고 회사가 요구하는 경우에 필요한 서류를 제출하여야 한다. 단 부득이한 경우에 회사 소정의 이용신청서를 작성하여 우편 또는 FAX 를 통하여 신청할 수 있다.</li>
	                        <li>4. 이용신청자가 미성년자(민법상의 행위 무능력자 포함)일 경우에는 이용요금 납입자를 법정대리인(친권자인 부모 등)으로 하여 이용신청을 할 수 있다. 서비스 이용자와 이용요금 납입자가 다를 경우 회사는 이를 확인할 제증명을 요구할 수 있다.</li>
	                    </ul>
	                    <h3 class="h3">제 7 조 (이용자번호 등의 관리)</h3>
	                    <ul>
	                        <li>1. 이용자번호는 주민등록상의 본인 실명으로 개인에게 하나만을 발급하는 것을 원칙으로 한다. 그러나 법인 또는 그에 준하는 단체가 회사와 별도로 이용계약을 체결할 경우, 이용자번호에 대해 일괄 이용계약을 체결할 수 있다.</li>
	                        <li>2. 이용자번호는 본명(실명)이 이용자명과 연계되어야 하며 회사가 특별히 정하는 경우 개인명 외에 법인 또는 그에 준하는 단체명도 가능하다. 이용자번호를 소유한 이용자는 이용자번호 및 비밀번호에 대한 관리책임이 있으며, 서비스 이용상의 과실 또는 제3자에 의한 부정 사용 등으로 인해 발생하는 모든 불이익에 대해 책임을 진다. 다만, &#34;회사&#34;에 고의 또는 중대한 과실이 있는 경우는 예외로 한다.</li>
	                    </ul>
	                    <h3 class="h3">제 8 조 (이용계약사항의 변경)</h3>
	                    <ul>
	                        <li>1. 이용자는 다음에 해당하는 변경사항이 있을 경우에는 즉시 서비스에 접속하여 이를 변경하여야만 한다.
	                            <ul>
	                                <li>가. 주소 및 전화번호.</li>
	                                <li>나. 비밀번호.</li>
	                                <li>다. 이름</li>
	                                <li>라. 기타 회사가 인정하는 사항.</li>
	                            </ul>
	                        </li>
	                        <li>2. 이용자번호(ID)는 변경할 수 없다.</li>
	                    </ul>
	                    <h3 class="h3">제 9조 (&#34;게시물&#34;의 저작권)</h3>
	                    <ul>
	                        <li>1. &#34;서비스&#34;에 대한 저작권 및 지적재산권은 회사에 귀속되며, 무단전재, 복제, 배포, 전손을 금지한다. 단, 회원의 게시물 및 제휴계약에 따라 제공된 저작물 등은 제외한다.</li>
	                        <li>2. 회원의 게시물이 &#34;정보통신망법&#34; 및 &#34;저작권법&#34; 등 관련법에 위반되는 내용을 포함하는 경우, 권리자는 관련법이 정한 절차에 따라 해당 게시물의 게시중단 및 삭제 등을 요청할 수 있으며, 회사는 관련법에 따라 조치를 취하여야 한다.</li>
	                        <li>3. 회사는 전항에 따른 권리자의 요청이 없는 경우라도 권리침해가 인정될 만한 사유가 있거나 기타 회사 정책 및 관련법에 위반되는 경우에는 관련법에 따라 해당 게시물에 대해 임시조치 등을 취할 수 있다.</li>
	                        <li>4. 회원이 서비스 내에 게시한 게시물의 저작권은 해당 게시물의 저작권에게 귀속되며, 게시한 게시물은 검색결과 또는 서비스 및 관련 프로모션 등에 노출될 수 있으며 해당 노출을 위해 필요한 범위 내에서는 일부 수정, 복제, 편집되어 게시될 수 있다. 이 경우 회사는 저작권법 규정을 준수하며 회원은 언제든지 고객센터 또는 서비스 내 관리기능을 통해 해당 게시물에 대해 삭제, 검색결과 제외, 비공개 등의 처리를 취할 수 있다.</li>
	                    </ul>
	                    <h2 class="h2">&#91; 제 3 장 서비스의 이용 &#93;</h2>
	                    <h3 class="h3">제 10 조 (서비스 종류)</h3>
	                    <p>회사는 부동산 개발정보를 중심으로 부동산경매 및 한국자산관리공사 공매 등 토지보상 관련된 유료정보 서비스와 공익정보 서비스를 비롯한 무료정보 서비스를 운영할 수 있으며, 각 서비스 이용에 필요한 제반 사항은 회사가 정하여 홈페이지를 통하여 공지한다.</p>
	                    <h3 class="h3">제 11 조 (서비스 이용시간 및 기간)</h3>
	                    <ul>
	                        <li>1. 서비스의 제공은 회사의 이용 승인일로부터 개시되며, 회사의 업무상 또는 기술상 특별한 경우를 제외하고는 연중무휴 1일 24시간을 원칙으로 한다. 단, 서비스 설비 및 시스템의 정기점검이나 보수가 있을 경우에는 공지사항을 통해 전달한 후 서비스를 일시 중단할 수 있다.</li>
	                        <li>2. 유료 회원의 서비스 이용기간은 “본 Site”내에 게시된 회원등급 및 서비스 이용표에 따른다.</li>
	                    </ul>
	                    <h3 class="h3">제 12 조 (서비스내용 변경)</h3>
	                    <p>서비스 내용이 추가, 변경 또는 삭제되는 경우에는 회사가 제공하는 서비스를 통해 이를 공시한다.</p>
	                    <h3 class="h3">제 13 조 (서비스 이용의 제한 및 중지)</h3>
	                    <ul>
	                        <li>1. 회사는 회원이 다음에 해당하는 경우에는 서비스 이용을 제한하거나 중지할 수 있다. 이 경우 회사는 수령한 이용요금을 반환하지 않는다.
	                            <ul>
	                                <li>가. 서비스 운영을 고의 또는 과실로 방해한 경우.</li>
	                                <li>나. 서비스 이용요금을 정한 기일 내에 납입하지 아니한 경우.</li>
	                                <li>다. &#34;본 Site&#34;에서 제공되는 자료를 활용하여 “회사”를 사칭할 경우.</li>
	                                <li>라. &#34;회사&#34;의 서면 동의 없이 저작권 및 지적 재산권을 침해하여 &#34;본 Site&#34;에서 제공되는 자료를 3자에게 가공배포 할 경우.</li>
	                                <li>마. 제15조의 회원의 의무를 위반할 경우.</li>
	                                <li>바. 투자자 모집행위 등 &#34;본Site&#34;의 운영취지에 맞지 않는 행위를 하는 경우.</li>
	                                <li>사. &#34;본 site&#34;내 정보를 크롤링, 이미지 캡쳐 등의 취득방법을 불문하고 대량으로 취득하는 행위.</li>
	                                <li>아. 제 14조 2항의 규칙을 위반한 경우</li>
	                                <li>자. 전기통신사업법에 규정된 기간통신사업자가 전기통신 서비스를 중지했을 경우.</li>
	                                <li>차. 국가비상사태, 서비스 설비의 장애 또는 서비스 이용의 폭주 등으로 서비스 이용에 지장이 있을 때.</li>
	                                <li>카. 기타 회사가 회원으로서 부적당하다고 판단되는 경우.</li>
	                            </ul>
	                        </li>
	                    </ul>
	                    <h3 class="h3">제 14 조 (회사의 의무)</h3>
	                    <ul>
	                        <li>1. 회사는 설치된 서비스용 설비를 지속적이고 안정적인 서비스 제공에 적합하도록 유지하여야 하며 서비스용 설비에 장애가 발생하거나 또는 그 설비가 못쓰게 된 경우 즉시 그 설비를 수리하거나 복구한다.</li>
	                        <li>2. 회사는 서비스의 제공과 관련해서 알고 있는 회원의 정보를 본인의 허락 없이 제3자에게 누설, 배포하지 않는다. 단, 다음에 해당하는 경우에는 회사는 책임을 면한다.
	                            <ul>
	                                <li>가.회원이 일부 서비스의 이용목적으로 정보제공자 또는 제3자에게 개별적으로 제공한 회원 정보를 정보제공자 또는 제3자가 누설한 경우.</li>
	                                <li>나.회원이 일부 서비스인 동호회 등 회원가입 신청 시 입력한 이용자 정보를 운영자가 누출한 경우.</li>
	                                <li>다.관계기관으로 부터 수사에 필요한 서류의 열람이나 제출을 서면으로 통지받은 경우.</li>
	                            </ul>
	                        </li>
	                    </ul>
	                    <h3 class="h3">제 15 조 (이용자의 의무)</h3>
	                    <ul>
	                        <li>1. 이용자는 다음에 해당하는 행위를 하지 않아야 한다.
	                            <ul>
	                                <li>가. 타인의 이용자번호 및 비밀번호를 부정하게 사용하는 행위</li>
	                                <li>나. 서비스를 이용하여 얻은 정보를 회사의 사전 허락 없이 이용자의 이용 이외의 목적으로 복제, 출판, 방송 등에 사용하거나 제3자에게 제공하는 행위</li>
	                                <li>다. 타인의 명예를 손상 시키거나 불이익을 주는 행위</li>
	                                <li>라. 공공질서 또는 미풍양속에 위배되는 내용의 정보, 문장, 도형, 음성 등을 유포하는 행위</li>
	                                <li>마. 범죄적 행위와 결부된다고 판단되는 행위</li>
	                                <li>바. 지적재산권을 침해하는 행위</li>
	                                <li>사. 컴퓨터 바이러스 감염자료를 등록하는 행위</li>
	                                <li>아. Site내 정보를 과다하게 수집하거나 저장하는 행위</li>
	                                <li>자. 기타 관계법령에 위배되는 행위</li>
	                            </ul>
	                        </li>
	                        <li>2. 이용자는 이용요금의 납입의무를 충실히 수행하여야 하며, 이용요금의 미납으로 인하여 발생 되는 모든 책임은 회원 및 이용요금 납입자에게 있다. 단, 회사에 고의 또는 중과실이 있는 경우는 예외로 한다.</li>
	                        <li>3. 이용자는 회사에서 허용하는 경우를 제외하고는 서비스를 이용하여 영업행위를 할 수 없다. 이용자는 주소, 전화번호, 사업자등록번호 등 이용계약사항에 변동이 있을 경우에는 당해 내용을 지체 없이 회사에 고지하거나 서비스를 통해 변경한 후 변경내용을 확인하여야 한다. (단, 법인의 경우에는 회사가 정한 방법에 의한다.) 고지 누락으로 인한 불이익에 대해서는 이용자의 책임으로 한다.</li>
	                        <li>4. &#34;본 site&#34;내 정보를 크롤링, 이미지 캡쳐 등의 취득방법을 불문하고 대량으로 취득해서는 안된다.</li>
	                    </ul>
	                    <h3 class="h3">제 16 조 (양도금지)</h3>
	                    <p>이용자가 받을 서비스 권리는 이를 양도하거나 증여 등을 할 수 없으며 질권의 목적으로 사용할 수 없다. 단. &#34;회사&#34;의 서면 동의를 받은 경우는 양도할 수 있다.</p>
	                    <h2 class="h2">&#91; 제 4 장 서비스 이용요금 &#93;</h2>
	                    <h3 class="h3">제 17 조 (이용요금)</h3>
	                    <ul>
	                        <li>1. 회사가 &#34;본 Site&#34; 통해 별도의 공지하는 내용에 따른다.</li>
	                        <li>2. 이용자는 회사가 운영하는 유료정보 내용을 충분히 확인한 후 결제하여야 하며 유료서비스를 구매한 회원은 서비스 이용 잔여기간에 대하여 환불을 청구 할 수 없다. 단, 회사의 귀책사유가 있는 경우에는 예외로 하며 이 때는 서비스 잔여기간에 대하여 최소 단위인 일일 이용 금액을 기준으로 결제금액에서 공제 후 환불한다.</li>
	                    </ul>
	                    <h3 class="h3">제 18 조 (이용요금의 납입)</h3>
	                    <ul>
	                        <li>1. 이용요금은 서비스를 이용하기 전에 납입하는 것을 원칙으로 한다. 다만, 회사가 일정 데모 기간을 두는 것은 예외로 한다.</li>
	                        <li>2. 회사가 별도로 정하는 경우를 제외하고는 이용자번호를 단위로 하여 월별로 청구한다.</li>
	                        <li>3. 회사는 해당 월의 이용요금을 납입 기한을 정하여 이용자가 선택한 납입방법 별로 서비스 이용 전에 청구한다.</li>
	                        <li>4. 회사는 미납금을 최근 청구 월 요금에 청구할 수 있다.</li>
	                    </ul>
	                    <h3 class="h3">제 19조 (이용요금 납입방법)</h3>
	                    <ul>
	                        <li>1.이용 요금은 &#34;본 Site&#34;내에 개설된 결제방법을 이용하기로 한다.</li>
	                    </ul>
	                    <h3 class="h3">제 20 조 (이용요금 납입자)</h3>
	                    <ul>
	                        <li>1. 이용요금 납입자는 서비스 이용자를 원칙으로 한다. 단, 회사가 인정하는 경우에는 타인을 이용요금 납입자로 할 수 있다.</li>
	                        <li>2. 제1항의 단서규정에 의한 이용요금 납입자는 이용자가 회사에 납입하여야 할 이용요금 등의 모든 채무를 이용자와 연대하여 회사에 납입 할 책임이 있다.</li>
	                        <li>3. 이용요금 납입자를 변경하는 경우 변경 전의 이용요금 납입자가 납입하여야 할 미납요금에 대해서도 납입 책임이 있다.</li>
	                        <li>4. 이용자와 이용요금 납입자가 동일하지 않거나 구분이 모호할 경우 제13조(서비스 이용의 제한 및 중지)및 제15조(이용자의 의무)는 이용자 및 납입자 모두에게 적용하기로 한다.</li>
	                    </ul>
	                    <h3 class="h3">제 21조 (이용요금에 대한 이의신청)</h3>
	                    <ul>
	                        <li>1. 회사는 이용요금청구 등에 오류가 있는 경우에는 이용자의 이의신청에 따라 다음에 해당하는 조치를 한다.
	                            <ul>
	                                <li>가. 과다 납입한 요금 등에 대하여는 그 금액을 반환한다. 다만, 이용자가 동의할 경우 다음 달에 청구할 요금에서 해당 금액만큼을 감하여 청구한다.</li>
	                                <li>나. 요금을 반환받아야 할 이용자가 요금체납이 있는 경우에는 반환해야 할 요금에서 이를 우선 공제하고 반환한다.</li>
	                                <li>다. 회사는 과소 청구액에 대해서는 익월에 합산 청구한다.</li>
	                                <li>라. 이용요금에 관한 이의신청은 그 사유가 발생한 날로부터 3개월 이내에 하여야 한다.</li>
	                            </ul>
	                        </li>
	                    </ul>
	                    <h2 class="h2">&#91; 제 5 장 계약의 해지 &#93;</h2>
	                    <h3 class="h3">제 22 조 (이용계약의 해지)</h3>
	                    <p>이용자가 서비스 이용계약을 해지하고자 하는 때에는 이용자 본인이 직접 온라인을 통해 개인정보 변경 및 탈퇴 메뉴를 선택하여 해지 신청을 하여야 한다. 회사는 이용자가 아래와 같은 사항에 해당하는 행위를 하였을 경우 회사는 사전통보 없이 계약을 해지할 수 있으며, 회사에 손해를 입혔을 경우 가입자에게 손해배상을 청구할 수 있다.</p>
	                    <ul>
	                        <li>가. 본 회사의 명예를 훼손하였을 경우.</li>
	                        <li>나. 서비스 운영을 고의로 방해한 경우.</li>
	                        <li>다. 제15조,제13조에 해당하는 행위를 했을 경우.</li>
	                        <li>라. 타인의 계좌번호,신용카드 번호,사용자 ID 또는 비밀번호를 도용한 경우</li>
	                        <li>마. 선량한 풍속 기타 사회질서에 반하는 행위를 한 경우.</li>
	                        <li>바. 범죄적 행위에 관련되는 경우.</li>
	                        <li>사. 이용자가 국익 또는 사회적 공익을 저해할 목적으로 서비스 이용을 계획 또는 실행할 경우.</li>
	                        <li>아. 가입신청서를 허위로 작성한 경우.</li>
	                        <li>자. 타인의 명예를 손상시키거나 불이익을 주는 경우.</li>
	                        <li>차. 같은 사용자가 다른 아이디로 이중 등록을 한 경우.</li>
	                        <li>카. 서비스 이용요금을 10일 이상 납부하지 않은 경우.</li>
	                        <li>타. 서비스에 위해를 가하는 등 서비스의 건전한 이용을 저해하는 경우.</li>
	                        <li>파. 회사의 사전승인 없이 서비스를 이용하여 영업활동을 하거나 타인에게 서비스를 제공한 경우.</li>
	                        <li>하. 기타 관련법령이나 회사에서 정한 이용조건에 위배되는 경우.</li>
	                    </ul>
	                    <h3 class="h3">제 23 조 (계약해지의 효과)</h3>
	                    <ul>
	                        <li>1. 회사는 이용제한을 하고자 하는 경우에는 그 사유, 일시 및 기간을 정하여 서면 또는 전화 등의 방법에 의하여 해당 이용자 또는 대리인에게 통지한다. 다만, 회사가 긴급하게 이용을 정지할 필요가 있다고 인정하는 경우에는 예외로 한다.</li>
	                        <li>2. 제 1항의 규정에 의하여 이용정지의 통지를 받은 이용자 또는 그 대리인은 그 이용정지의 통지에 대하여 이의가 있을 때에는 이의 신청을 할 수 있다.</li>
	                        <li>3. 회사는 제2항의 규정에 의한 이의신청에 대하여 그 확인을 위한 기간까지 이용정지를 일시 연기할 수 있으며, 그 결과를 이용자 또는 그 대리인에게 통지한다.</li>
	                        <li>4. 회사는 이용정지 기간 중에 그 이용정지 사유가 해소된 것이 확인되는 경우에는 이용정지 조치를 즉시 해제한다.</li>
	                        <li>5. 이용계약의 해지 시 회사는 최종요금납부 이후 이용한 서비스에 대한 이용료를 모두 청구하며, 이용료 납입자는 이를 모두 납입하여야 한다. 이 경우 해지 당월의 정보이용료는 정액으로 부과한다. 해지 신청이 접수되면 회사는 해당 월의 말일 24시를 기해 서비스 이용을 제한하고 서비스 이용 요금 중 미납액은 다음 달에 부과한다. 이용요금 납입자가 해지한 당월까지의 모든 이용요금을 완납한 경우에는 회사는 해지 처리를 완료한다.</li>
	                    </ul>
	                    <h2 class="h2">&#91; 제 6 장 손해배상 등 &#93;</h2>
	                    <h3 class="h3">제 24 조 (손해배상)</h3>
	                    <ul>
	                        <li>1. 회사는 서비스 제공에 있어 회사의 귀책사유로 인해 전체 서비스를 제공하지 못했을 때 이용자가 회사에 통보하여 확인되거나 또는 회사가 인지할 수 있었던 시각부터 계산하여 24시간 이상 연속적으로 그 상태가 계속될 때에는 이용자의 청구에 대하여 손해배상 책임이 있다. 손해배상액의 범위는 이용자가 회사에 통보하여 확인되거나 또는 회사가 알 수 있었던 시간으로부터 계산하여 서비스 이용이 가능해진 시간까지의 미 사용일수로 한다.</li>
	                        <li>2. 회사에서 제공하는 정보내용은 참고용이며 이와 관련하여 회사에서는 어떠한 책임도 지지 않는 면책조건으로 정보를 제공한다.</li>
	                    </ul>
	                    <h3 class="h3">제 25 조 (면책조항)</h3>
	                    <ul>
	                        <li>1. 회사는 천재지변, 기타 불가항력적인 사유로 인해 서비스를 제공할 수 없는 경우에는 서비스 제공 중지에 대한 책임을 면한다.</li>
	                        <li>2. 회사는 이용자의 귀책사유로 인한 서비스 이용의 장애에 대하여는 책임을 면한다.</li>
	                        <li>3. 회사는 이용자가 서비스를 이용하여 얻은 정보 등으로 인해 입은 손해 등에 대하여는 책임을 면한다.</li>
	                        <li>4. 회사는 회사의 서비스망을 통해 제공되는 IP 정보와 이용자가 게시하거나 전송한 정보 등의 신뢰도나 정확성에 대하여는 책임을 면한다.</li>
	                    </ul>
	                    <h3 class="h3">제 26 조 (관할법원)</h3>
	                    <p>서비스 이용요금 등 서비스 이용상 발생한 분쟁에 대해서는 본사의 주소지 관할 법원으로 한다.</p>
	                    <h3 class="h3">제 27 조 (규정의 준용)</h3>
	                    <p>본 약관에 명시되지 않은 사항에 대해서는 상법 및 정보통신사업법 등 관계법령과 법에 명시되지 않은 부분에 대하여는 관습에 의한다.</p>
	                    <h2 class="h2">&#91; 제 7 장 이용자의 정보보호 &#93;</h2>
	                    <h3 class="h3">제 28 조 (정보보호에 관한 건)</h3>
	                    <p>회사는 관련법령이 정하는 바에 따라서 이용자 등록 정보를 포함한 이용자의 개인정보를 보호하기 위하여 노력한다. 이용자의 개인정보보호에 관해서는 관련법령 및 회사가 정하는 &#34;회원정보보호정책&#34;에 정한 바에 따른다.</p>
	                    <h3 class="h3">제 29 조 (정보보유기간)</h3>
	                    <p>회사는 이용자의 정보를 이용자가 탈퇴할 때까지만 보유한다. 단, 이용자의 동의를 얻을 시에는 이용자가 합의한 기간 동안 보유할 수 있다.</p>
	                    <h2 class="h2">&#91; 부 칙 &#93;</h2>
	                    <ul>
	                        <li>1. 본 약관은 공시일인 2012년 6월 01일로부터 시행한다.</li>
	                        <li>2. 본 약관은 공시일인 2021년 4월 01일로부터 시행한다.<span>(2021.04.01.개정)</span></li>
	                    </ul>  
					    </div>
					    <div class="ui_radio--custom">
					        <input type="checkbox" name="agree" id="agree_confirm_1">
					        <label for="agree_confirm_1"><span class="chk_ball"></span>약관에 동의합니다(필수)</label>
					    </div>
					
					
					    <h2 class="h2">개인정보 취급방침</h2>
					    <div class="agree-box">
					        <h2 class="h2">&#91; 개인정보의 처리 목적 &#93;</h2>
		                    <p>(주)지존(이하&#34;회사&#34;라 함)은 개인정보를 다음의 목적이외의 용도로는 이용하지 않으며 이용 목적이 변경될 경우에는 동의를 받아 처리하겠습니다.</p>
		                    <ul>
		                        <li>1. 서비스 제공
		                            <p>부동산 개발정보 및 보상과 관련된 정보서비스 제공, 본인인증, 전자결제 관련한 목적으로 개인정보를 처리합니다.</p>                            
		                        </li>
		                        <li>2. 회원등급 조정
		                            <p>결제 시스템이 아닌 오프라인 결제에 대해 회원등급 조정을 위한 목적으로 개인정보를 처리합니다.</p>                            
		                        </li>                        
		                    </ul>
		                    <h2 class="h2">&#91; 개인정보의 수집 및 보유 &#93;</h2>
		                    <p>회사는 정보 주체의 동의에 의해서만 개인정보를 수집&#183;보유합니다. 회사가 정보 주체의 동의에 근거하여 수집·보유하고 있는 주요 개인정보 파일은 다음과 같습니다.</p>
		                    <h2 class="h2">&#91; 개인정보의 제3자 제공 &#93;</h2>
		                    <p>회사는 수집·보유하고 있는 개인정보는 이용자의 동의 없이는 제3자에게 제공하지 않으며 다음의 경우에는 개인정보를 제3자에게 제공할 수 있습니다.</p>
		                    <ul>
		                        <li>1. 정보 주체로부터 동의를 받은 경우</li>
		                        <li>2. 법률에 특별한 규정이 있거나 법령상 의무를 준수하기 위하여 불가피한 경우.</li>
		                        <li>3. 정보 주체 또는 그 법정대리인이 의사표시를 할 수 없는 상태에 있거나 주소불명 등으로 사전 동의를 받을 수 없는 경우로서 명백히 정보 주체 또는 제3자의 급박한 생명, 신체, 재산의 이익을 위하여 필요하다고 인정되는 경우.</li>
		                        <li>4. 다음 각 호의 어느 하나에 해당하는 경우에는 정보 주체 또는 제3자의 이익을 부당하게 침해할 우려가 있을 때를 제외하고는 이용자의 개인정보를 목적 외의 용도로 이용하거나 이를 제3자에게 제공할 수 있습니다.
		                            <ul>
		                                <li>가. 정보 주체로부터 별도의 동의를 받은 경우.</li>
		                                <li>나. 다른 법률에 특별한 규정이 있는 경우.</li>
		                                <li>다. 정보 주체 또는 그 법정대리인이 의사표시를 할 수 없는 상태에 있거나 주소불명 등으로 사전 동의를 받을 수 없는 경우로서 명백히 정보 주체 또는 제3자의 급박한 생명, 신체, 재산의 이익을 위하여 필요하다고 인정되는 경우.</li>
		                                <li>라. 통계작성 및 학술연구 등의 목적을 위하여 필요한 경우로서 특정 개인을 알아볼 수 없는 형태로 개인정보를 제공하는 경우.</li>
		                                <li>마. 개인정보를 목적 외의 용도로 이용하거나 이를 제3자에게 제공하지 아니하면 다른 법률에서 정하는 소관 업무를 수행할 수 없는 경우로서 보호위원회의 심의·의결을 거친 경우.</li>
		                                <li>바. 조약, 그 밖의 국제협정의 이행을 위하여 외국정부 또는 국제기구에 제공하기 위하여 필요한 경우.</li>
		                                <li>사. 범죄의 수사와 공소의 제기 및 유지를 위하여 필요한 경우.</li>
		                                <li>아. 법원의 재판업무 수행을 위하여 필요한 경우.</li>
		                                <li>자. 형(刑) 및 감호, 보호처분의 집행을 위하여 필요한 경우.</li>
		                            </ul>
		                        </li>
		                    </ul>
		                    <h2 class="h2">&#91; 정보 주체의 권리&#183;의무 및 그 행사방법 &#93;</h2>
		                    <P>이용자는 정보 주체로서 다음과 같은 권리를 행사할 수 있습니다.</P>
		                    <ul>
		                        <li>1. 개인정보 열람 요구 : 회사에서 보유하고 있는 개인정보 파일은 「개인정보보호법」 제35조(개인정보의 열람)에 따라 열람을 요구할 수 있습니다.</li>
		                        <li>2. 개인정보 정정·삭제 요구 : 회사에서 보유하고 있는 개인정보 파일에 대해서는 「개인정보보호법」 제36조(개인정보의 정정·삭제)에 따라 회사에 개인정보의 정정·삭제를 요구할 수 있습니다.</li>
		                        <li>3. 개인정보 처리정지 요구 : 회사에서 보유하고 있는 개인정보파일에 대해서는 「개인정보보호법」 제37조(개인정보의 처리정지 등)에 따라 회사에 개인정보의 처리정지를 요구할 수 있습니다.</li>
		                        <li>4. 개인정보의 열람, 정정·삭제, 처리정지 요구에 대해서는 10일 이내에 해당 사항에 대한 회사의 조치를 통지합니다. 개인정보의 열람, 정정·삭제, 처리정지 요구는 해당 부서를 통해서 가능하며, 이용자가 본인의 정보에 한하여 홈페이지를 통해 직접 처리할 수 있습니다. 다만, 개인정보 외에 거래정보는 삭제할 수 없습니다.</li>
		                        <li>5. 개인정보의 열람, 정정·삭제, 처리정지 요구 접수·처리 부서와 담당자는 아래와 같습니다.
		                            <ul>
		                                <li>부서 : (주)지존 전산팀</li>
		                                <li>담당자 : 이호간 TEL. 02-322-3152, FAX. 02-322-3154</li>
		                                <li>주소 : 서울특별시 영등포구 당산로 246 VIEWTIFUL 6층, 8층</li>
		                            </ul>
		                        </li>
		                    </ul>
		                    <h2 class="h2">&#91; 파기 &#93;</h2>
		                    <p>회사는 원칙적으로 개인정보의 보유기간이 경과했거나 처리목적이 달성된 경우에는 지체없이 해당 개인정보를 파기합니다. 파기의 절차, 기한 및 방법은 다음과 같습니다.</p>
		                    <ul>
		                        <li>1. 파기절차
		                            <p>이용자가 입력한 정보는 보유기간이 경과했거나 처리 목적 달성 후 내부 방침 및 관련 법령에 따라 파기합니다.</p>
		                        </li>
		                        <li>2. 파기기한
		                            <p>이용자의 개인정보는 개인정보의 보유 기간이 경과된 경우 보유 기간의 종료일로부터 5일 이내에, 개인정보의 처리 목적 달성 등 그 개인정보가 불필요하게 되었을 때에는 개인정보의 처리가 불필요한 것으로 인정되는 날로부터 5일 이내에 그 개인정보를 파기합니다.</p>
		                        </li>
		                        <li>3. 파기방법
		                            <p>회사에서 처리하는 개인정보를 파기할 때에는 다음의 방법으로 파기합니다.</p>
		                            <ul>
		                                <li>가. 전자적 파일 형태인 경우: 복원이 불가능한 방법으로 영구삭제.</li>
		                                <li>나. 전자적 파일의 형태 외의 기록물, 인쇄물, 서면, 그 밖의 기록매체인 경우: 파쇄 또는 소각.</li>
		                            </ul>
		                        </li>
		                    </ul>
		                    <h2 class="h2">&#91; 개인정보의 안전성 확보 조치 &#93;</h2>
		                    <p>회사는 「개인정보보호법」 제29조에 따라 다음과 같이 안전성 확보에 필요한 기술적, 관리적 조치를 하고 있습니다.</p>
		                    <h2 class="h2">&#91; 개인정보 보호책임자 &#93;</h2>
		                    <p>회사는 개인정보를 보호하고 개인정보와 관련된 사항을 처리하기 위하여 아래와 같이 개인정보 보호책임자 및 실무담당자를 지정하고 있습니다.</p>
		                    <ul>
		                        <li>부서 : (주)지존 전산팀</li>
		                        <li>담당자 : 이호간 TEL. 02-322-3152, FAX. 02-322-3154</li>
		                        <li>주소 : 서울특별시 영등포구 당산로 246 VIEWTIFUL 6층, 8층</li>
		                    </ul>
		                    <h2 class="h2">&#91; 개인정보 처리방침의 변경 &#93;</h2>
		                    <p>이 개인정보처리방침은 시행일로부터 적용되며, 법령 및 방침에 따른 변경내용의 추가, 삭제 및 정정이 있는 경우에는 가능한 변경사항의 시행 7일 전부터 공지사항을 통하여 고지할 것입니다. <span>(시행일자 : 2012년 9월 10일)</span></p>
		                    <h2 class="h2">&#91; 권익침해 구제방법 &#93;</h2>
		                    <p>정보주체는 개인정보침해로 인한 구제를 받기 위하여 개인정보분쟁조정위원회, 한국인터넷진흥원 개인정보침해신고센터 등에 분쟁해결이나 상담 등을 신청할 수 있습니다. 이 밖에 기타 개인정보침해의 신고, 상담에 대하여는 아래의 기관에 문의하시기 바랍니다.</p>
		                    <ul>
		                        <li>1. 개인정보분쟁조정위원회 : (국번없이) 118(내선2번)</li>
		                        <li>2. 정보보호마크인증위원회 : 02-580-0533~4 (<a href="http://eprivacy.or.kr"> http://eprivacy.or.kr</a>)</li>
		                        <li>3. 대검찰청 사이버범죄수사단 : 02-3480-3582 (<a href="http://www.spo.go.kr/"> http://www.spo.go.kr/</a>)</li>
		                        <li>4. 경찰청 사이버테러대응센터 : 1566-0112 (<a href="http://www.netan.go.kr/"> http://www.netan.go.kr/</a>)</li>
		                    </ul>
				    </div>
				    <div class="ui_radio--custom">
				        <input type="checkbox" name="agree" id="agree_confirm_2">
				        <label for="agree_confirm_2"><span class="chk_ball"></span>약관에 동의합니다(필수)</label>
				    </div>
				
				
				
<!-- 				    <h2 class="h2">휴면 계정 약관</h2> -->
<!-- 				    <div class="agree-box"> -->
<!-- 				        <p>내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.</p> -->
<!-- 				    </div> -->
<!-- 				    <div class="ui_radio--custom"> -->
<!-- 				        <input type="checkbox" name="agree" id="agree_confirm_3"> -->
<!-- 				        <label for="agree_confirm_3"><span class="chk_ball"></span>약관에 동의합니다(필수)</label> -->
<!-- 				    </div> -->
				
				
				       
				    <div class="text-center">
				        <button type="button" class="btn btn-default" onclick="location.href='<c:url value='/joinStep1.do'/>'">취소</button>
				        <button type="button" class="btn btn-primary" onclick="javascript:joinStep3();">다음</button>
				    </div>
				            
				</div>


    
            <!-- content 영역입니다. -->	
            </div>
        </div>
    </div>
    <!-- layout -->
</div>

<!-- 구현부 : E -->

<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>
</body>
</html>

