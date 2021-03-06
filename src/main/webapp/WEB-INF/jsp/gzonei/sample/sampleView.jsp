<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang='ko'>
<head>
<%@ include file="/WEB-INF/jsp/gzonei/layout/header.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/jsp/gzonei/layout/top.jsp" %>

<body topmargin="0" leftmargin="0">

<!-- header -->
<script>
function search(){
	document.sampleForm.action = "<c:url value='/sample/selectSamplePage.do'/>";
	document.sampleForm.selecttest = $('#').value;
	document.sampleForm.submit();
}
function loginPage(){
	document.sampleForm.action = "<c:url value='/cmmn/gzoneiLogin.do'/>";
	document.sampleForm.submit();
}
function logout(){
	document.sampleForm.action = "<c:url value='/cmmn/gzoneiActionLogout.do'/>";
	document.sampleForm.submit();
}
$(document).ready(function(){
	$('#ckPage').on('click',function(){
		document.sampleForm.action = "<c:url value='/sample/ckuploadSamplePage.do'/>";
		document.sampleForm.submit();
	});
	$('#invPage').on('click',function(){
		document.sampleForm.action = "<c:url value='/invt/InvtList.do'/>";
		document.sampleForm.submit();
	});
	
});


function download(){
	$.ajax({
		type:"POST",
		url:"<c:url value='/sample/selectSampleExcel.do' />",
		data:{"codeIdNm": "구분"},
		dataType:'json',
		async:false,
		success:function(data){
			if (data.length > 0) {
				//데이터 있음
				exportExcel('excelDownExample', 'sheetNm', data);
				return;
			}else{
				//데이터 없음
				return;
			}
		} 
		,error : function(e) {alert("데이터 조회에 실패하였습니다.\n관리자에게 문의바랍니다.");}
		,beforeSend:function(){
			//전송 전
	    }
	    ,complete:function(){
	        //전송 후
	    }
		});
}




</script>
<div id="body_layout">	
    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
	        <div id="txt">
	        	<div class="augment_wrap">
					<h2 class="h2">로그인 세션 관련 예시</h2>
					${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/
					
					<script>
					
					</script>

					
					<button class="btn btn-default" onclick="javascript:loginPage();">로그인페이지 이동</button>
					<button class="btn btn-default" onclick="javascript:logout();">로그아웃</button>
					<br/>로그인 세션 뷰 : ${sessionScope.loginVO}
					<br/>
					<br/>아이디 id : ${sessionScope.loginVO.id}
					<br/>이름 userNm : ${sessionScope.loginVO.userNm}
					<br/>조직아이디 orgnztId : ${sessionScope.loginVO.orgnztId}
					<br/>그룹아이디 groupId : ${sessionScope.loginVO.groupId}
					<br/>회원종류(개인,법인,관리자)코드 indvdlMberCode : ${sessionScope.loginVO.indvdlMberCode }
					<br/>회원상태코드 mberSttusCode : ${sessionScope.loginVO.mberSttusCode }
					<br/>회원가입승인일 confmDe : ${sessionScope.loginVO.confmDe }
					<br/>글쓰기권한여부 sntncRegistAuthorAt : ${sessionScope.loginVO.sntncRegistAuthorAt }
					<br/>투자조회권한여부 invtInqireAuthorAt : ${sessionScope.loginVO.invtInqireAuthorAt }
					<br/>접속제한여부 conectLmttAt : ${sessionScope.loginVO.conectLmttAt }
					<br/>등급코드 gradCode : ${sessionScope.loginVO.gradCode }
					<br/>등급코드명 gradCodeNm : ${sessionScope.loginVO.gradCodeNm }
					<br/>등급만료일시 endPnttm : ${sessionScope.loginVO.endPnttm }
					<br/>등급남은일수 remindDay : ${sessionScope.loginVO.remindDay }
					<br/>상품코드 goodsCode : ${sessionScope.loginVO.goodsCode }
					<br/>결제수단구분코드 setleMnSeCode : ${sessionScope.loginVO.setleMnSeCode }
					<br/>상품상세명칭 setleDtls : ${sessionScope.loginVO.setleDtls }
					<br/>상점아이디 storeId : ${sessionScope.loginVO.storeId }
					<br/>상품종류코드 goodsKndCode : ${sessionScope.loginVO.goodsKndCode }
					<br/>서비스코드 srvcSeCode : ${sessionScope.loginVO.srvcSeCode }
				</div>
	        </div>
	        <div id="txt">
	        	<div class="augment_wrap">
					<h2 class="h2">권한 세션 관련 예시</h2>
					${sessionScope.authVO.bbs008002.menuAccesAt}
					<br/>
					<br/>
					<br/>
					<br/>
					${sessionScope.authVO.bbs008002}
					<br/>
					<br/>
					<br/>
					<br/>
					${sessionScope.authVO} 
					<%-- 
					<c:forEach items="${sessionScope.authVO}" var="resultList" varStatus="status">
					권한코드 : ${resultList.authorCode } / 권한명 : ${resultList.authorNm } / 권한설명 : ${resultList.authorDc} / 메뉴접근가능여부 : ${resultList.menuAccesAt} / 정보조회가능여부 : ${resultList.infoInqreAt}
					/ 정보등록가능여부 : ${resultList.infoRegistAt} / 정보수정가능여부 : ${resultList.infoUpdtAt} / 정보삭제가능여부 : ${resultList.infoDelAt} / 정보전시가능여부 : ${resultList.infoDspyAt} / 다운&실행여부 : ${resultList.executAt}
					<br/>////////////////////////////////////////////////////////////////////////////////////////////////////////////
					<br/>로그인 세션 뷰 : ${sessionScope.authVO} 
					</c:forEach>
					 --%>
				</div>
	        </div>
	        
	        <div id="txt">
	        	<div class="augment_wrap">
	        		<h2 class="h2">------------------------------------------------------------------------------------------</h2>
					<h2 class="h2">샘플 링크</h2>
					<br/>
					<br/>로그인 화면 :<br/> <a class="btn btn-default btn-outline btn-icon" href="<c:url value='/cmmn/gzoneiLogin.do'/>">로그인 화면</a>
					<br/>Form 샘플 화면 :<br/> <a class="btn btn-default btn-outline btn-icon" href="<c:url value='/sample/selectGuidePage.do'/>">가이드 화면</a> 
									/ <a class="btn btn-default btn-outline btn-icon" href="<c:url value='/sample/selectFormPage.do'/>">Form 화면</a>
					<br/>지도 화면 :<br/> <a class="btn btn-default btn-outline btn-icon" href="<c:url value='/sample/selectMapPage.do'/>">지도 화면</a>
					<br/>회원 화면 :<br/> <a class="btn btn-default btn-outline btn-icon" href="<c:url value='/sample/selectJoinPage.do'/>">개인회원가입 화면</a>
									/ <a class="btn btn-default btn-outline btn-icon" href="<c:url value='/sample/selectJoinUdtPage.do'/>">개인회원수정 화면</a>
									/ <a class="btn btn-default btn-outline btn-icon" href="<c:url value='/sample/selectBizJoinPage.do'/>">사업자가입 화면</a>
									/ <a class="btn btn-default btn-outline btn-icon" href="<c:url value='/sample/selectMyPage.do'/>">마이페이지 화면</a>
									/ <a class="btn btn-default btn-outline btn-icon" href="<c:url value='/sample/selectOutPage.do'/>">탈퇴신청 화면</a>
									/ <a class="btn btn-default btn-outline btn-icon" href="<c:url value='/sample/selectAgreePage.do'/>">가입동의 화면</a>
									/ <a class="btn btn-default btn-outline btn-icon" href="<c:url value='/sample/selectPayPage.do'/>">결제내역 화면</a>
									/ <a class="btn btn-default btn-outline btn-icon" href="<c:url value='/sample/selectAugmentPage.do'/>">연장결제 화면</a>
					<br/>게시판 샘플 화면 :<br/> <a class="btn btn-default btn-outline btn-icon" href="<c:url value='/sample/selectBbsListPage.do'/>">목록 화면</a> 
									/ <a class="btn btn-default btn-outline btn-icon" href="<c:url value='/sample/selectBbsDtlPage.do'/>">상세 화면</a> 
									/ <a class="btn btn-default btn-outline btn-icon" href="<c:url value='/sample/selectBbsRegPage.do'/>">등록 화면</a>
					<br/>배너 샘플 화면 :<br/> <a class="btn btn-default btn-outline btn-icon" href="<c:url value='/sample/selectBannerPage.do'/>">배너 화면</a>
					<br/>배너 샘플 화면 :<br/> <a class="btn btn-default btn-outline btn-icon" href="<c:url value='/sample/selectCodeMngPage.do'/>">코드관리</a>		
									/ <a class="btn btn-default btn-outline btn-icon" href="<c:url value='/sample/selectAuthPage.do'/>">권한관리</a> 		
					<h2 class="h2">------------------------------------------------------------------------------------------</h2>
					
				</div>
	        </div>
        </div>
    </div>
</div>
<!-- contents -->
<div>
	
	<!-- 상단 -->
	<div class="mp_top">
		<div class="l"><!-- left layout -->
			
			<div style="height:150px">
				<form name="sampleForm" method="post">
				<select id="">
				<option value="1">전체</option>
				</select>
				<input type="hidden" name="selecttest"/>
				<input type="text" name="codeIdNm" style="width:500px;" value="${searchVO.codeIdNm }"/>
				<input type="hidden" name="test"/>
				<button onclick="search();">검색</button>
				<button id='invPage'>경공매 샘플페이지</button>
				</form>				
			</div>
			<button id='ckPage'>Ckeditor 샘플페이지</button>
		</div>
		<form name="testForm" method="post">
		<input type="text" name="test2" value="다같이쓰는정보"/>
		</form>
		
		<div class="r"><!-- right layout -->
			샘플 내용
			<ul>
			<li>
			코드아이디 / 코드명 / 코드설명 / 사용여부 / 대분류코드 / 입력일 / 입력자 / 수정일 / 수정자
			</li>
			<c:choose>
				<c:when test="${resultList == null or fn:length(resultList) == 0 }">
					없음
				</c:when>
				<c:otherwise>
					<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
					<li>
					${resultInfo.codeId } / ${resultInfo.codeIdNm } / ${resultInfo.codeIdDc } / ${resultInfo.useAt } / ${resultInfo.clCode } / ${resultInfo.frstRegistPnttm } / ${resultInfo.frstRegisterId } / ${resultInfo.lastUpdtPnttm } / ${resultInfo.lastUpdusrId }
					</li>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			</ul>
		</div>
	</div>
	
	
	
	--------------------------------------------------------------------------
	
	<h3 class="m_tit01 mt15">엑셀 다운</h3><!-- 배너 -->
	<div class="mp_bn">
<!-- 		<button onclick="javascript:exportExcel('파일','시트',[{'상품명':'삼성 갤럭시 s11' , '가격':'200000'}, {'상품명':'삼성 갤럭시 s12' , '가격':'220000'}, {'상품명':'삼성 갤럭시 s13' , '가격':'230000'}]);">엑셀다운</button> -->
		<button onclick="javascript:download();">엑셀다운</button>
		
	</div>
	
	


<!-- bottom -->

</div><!-- contents -->

<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>
</body>
</html>
