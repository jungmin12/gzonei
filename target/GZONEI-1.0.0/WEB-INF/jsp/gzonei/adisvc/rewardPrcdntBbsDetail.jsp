<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

<!-- 구현부 : S -->

<div id="body_layout">	

    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
            <div id="location" class="title_wrap">
                <h2 class="page__title">보상판례</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="<c:url value='/adisvc/rewardPrcdntBbsList.do'/>" >부가서비스</a></li>
                        <li class="n3"><a href="<c:url value='/adisvc/rewardPrcdntBbsList.do'/>" class="navi_ov">보상판례</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                    <!-- 프린트 시작 -->
                    <!-- <ul class="print_wrap setting-box__group">
                        <li id="sns_layout" class="n2">
                            <button data-target="ui-open">SNS공유</button>
                            <div class="sns_wrap" data-id="ui-open">
                                <button data-button="sns_share" data-service="naver" data-title="네이버 SNS공유" title="새창열림" target="_blank"><span class="sr-only">네이버 SNS</span>공유하기</button>
                                <button data-button="sns_share" data-service="facebook" data-title="페이스북 SNS공유" title="새창열림" target="_blank"><span class="sr-only">페이스북 SNS </span>공유하기</button>
                                <button data-target="ui-close">닫기</button>
                            </div>
                        </li>                    
                        <li class="n1" id="print"><button data-print="print">프린트</button></li>
                    </ul> -->
                    <!-- 프린트 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">
	            
			<div class="nav-4th">
				<ul>
					<li <c:if test="${searchVO.seCode eq null or searchVO.seCode eq ''}"> class="active"</c:if>><a href="<c:url value='/adisvc/rewardPrcdntBbsList.do'/>">전체보기 </a></li>
					<li <c:if test="${searchVO.seCode eq 'prcdnt'}"> class="active"</c:if>><a href="<c:url value='/adisvc/rewardPrcdntList.do'/>">보상판례 </a></li>
					<li <c:if test="${searchVO.seCode eq 'instrc'}"> class="active"</c:if>><a href="<c:url value='/adisvc/rewardInstructionList.do'/>">지침 </a></li>
					<li <c:if test="${searchVO.seCode eq 'reg'}"> class="active"</c:if>><a href="<c:url value='/adisvc/rewardRegList.do'/>">규정 </a></li>
				</ul>
			</div>
            <!-- content 영역입니다. -->
			<!-- view : S -->
			<form id="articleModifyForm" enctype="multipart/form-data" method="POST">
			<div class="board_view_in">
                    <!-- board -->
                    <div class="board">
                        <div class="board_view">
                            <div class="view_header">
	                            <span class="view_tit_number">${articleNum}</span>
                                <div class="view_tit">
                                    <p class="tit_txt">${resultList.nttSj}</p>
                                </div>
                                <span class="view_tit_aside"><fmt:formatDate pattern="yyyy-MM-dd" value="${resultList.frstRegistPnttm }"/></span>
<!--                                 <div class="view_data"> -->
<%-- 	                               <span class="view-id">${resultList.frstRegisterId}</span>   --%>
<%-- 	                               <span class="view-hit">${resultList.rdcnt}</span>      --%>
<!--                                 </div> -->
                            </div>
                            
                            <div class="view_cont_box">
                                <div class="view_cont">
                                <!-- 게시글-->
								${resultList.nttCn}
                                <!--// 게시글-->
                                </div>
                            </div>
                        </div>
                        <c:if test="${!empty atchFileDetail}">                     
	                        <div class="fileArea">
							    <c:forEach items="${atchFileDetail}" var="atcFile" varStatus="status">
							    <c:set var="loginGrade" value="${sessionScope.loginVO.gradCode}"/>
							    <c:set var="downGrade" value="${atcFile.readingAuthorCode}"/>
							        <p>
							        <c:choose>											
										<c:when test = "${downGrade eq 'bbs010005'}"><span class="txt_blt03 state03">실버</span></c:when>
										<c:when test = "${downGrade eq 'bbs010006'}"><span class="txt_blt03 state01">골드</span></c:when>
										<c:when test = "${downGrade eq 'bbs010007'}"><span class="txt_blt03 state02">프리미엄</span></c:when>
									</c:choose>
									<c:choose>
										<c:when test="${!empty downGrade}">
											<a onclick="downloadFile('${atcFile.orignlFileNm}','${atcFile.fileStreCours}','${downGrade}');"><c:out value="${atcFile.orignlFileNm}" /></a>
										</c:when>
										<c:otherwise>
											<a href="<c:url value='/cmmn/downloadFile.do?orignlFileNm=${atcFile.orignlFileNm}&fileStreCours=${atcFile.fileStreCours}'/>"><c:out value="${atcFile.orignlFileNm}" /></a>
										</c:otherwise>
									</c:choose>
							            
							            <span class="file_vol">
							                <c:if test="${atcFile.fileSize/1024 < 1024 }"><c:out value="${atcFile.fileSize/1024}"/> KB</c:if>									
							                <c:if test="${atcFile.fileSize/1024 >= 1024 }"><c:out value="${atcFile.fileSize/1024/1024}"/> MB</c:if>									
							            </span>
							        </p>
							        <input type="hidden"  name="fileStreCours" value="<c:out value='${atcFile.fileStreCours }'/>"/>
							        <input type="hidden"  name="orignlFileNm" value="<c:out value='${atcFile.orignlFileNm }'/>"/>
							        <input type="hidden"  name="fileSn" value="<c:out value='${atcFile.fileSn}'/>"/>
							        <input type="hidden"  name="atchFileId" value="<c:out value='${atcFile.atchFileId}'/>"/>
							    </c:forEach>
							</div>
						</c:if>
                    </div>
                    <!-- board -->

                    <div class="board_btm">
                        <div class="btns_area fl_r mo_block">
                        	<input type="hidden"  name="bbsId" value="<c:out value='${resultList.bbsId}'/>"/>
                        	<input type="hidden" name="nttId" value="<c:out value='${resultList.nttId }'/>"/>
                        	<input type="hidden" name="articleNum" value="<c:out value='${articleNum}'/>"/>
                        	<c:if test="${sessionScope.loginVO.indvdlMberCode eq 'CM00210003'}">
                            	<a href="#" class="btn btn-primary edit_btn">수정</a>
                            	<a href="#" class="btn btn-secondary del_btn">삭제</a>
                            </c:if>
                            <c:if test="${searchVO.pageIndex != null}">	
               		        <c:if test="${searchVO.seCode eq null}"> <a href="javascript:toDetail('/adisvc/rewardPrcdntBbsList.do?pageIndex=${searchVO.pageIndex}&startDate=${searchVO.startDate}&endDate=${searchVO.endDate}&searchType=${searchVO.searchType}&keyword=${searchVO.keyword}&orderType=${searchVO.orderType}')" class="btn btn-success" id="toList">목록</a></c:if>
               		        <c:if test="${searchVO.seCode eq 'prcdnt'}"> <a href="javascript:toDetail('/adisvc/rewardPrcdntList.do?pageIndex=${searchVO.pageIndex}&startDate=${searchVO.startDate}&endDate=${searchVO.endDate}&searchType=${searchVO.searchType}&keyword=${searchVO.keyword}&orderType=${searchVO.orderType}')" class="btn btn-success" id="toList">목록</a></c:if>
		                    <c:if test="${searchVO.seCode eq 'instrc'}"> <a href="javascript:toDetail('/adisvc/rewardInstructionList.do?pageIndex=${searchVO.pageIndex}&startDate=${searchVO.startDate}&endDate=${searchVO.endDate}&searchType=${searchVO.searchType}&keyword=${searchVO.keyword}&orderType=${searchVO.orderType}')" class="btn btn-success" id="toList">목록</a></c:if>
		                    <c:if test="${searchVO.seCode eq 'reg'}"> <a href="javascript:toDetail('/adisvc/rewardRegList.do?pageIndex=${searchVO.pageIndex}&startDate=${searchVO.startDate}&endDate=${searchVO.endDate}&searchType=${searchVO.searchType}&keyword=${searchVO.keyword}&orderType=${searchVO.orderType}')" class="btn btn-success" id="toList">목록</a></c:if>
                        	</c:if>
                        	<c:if test="${searchVO.pageIndex == null}">
                        	<c:if test="${searchVO.seCode eq null}"> <a href="<c:url value='/adisvc/rewardPrcdntBbsList.do'/>" class="btn btn-success" id="toList">목록</a></c:if>
               		        <c:if test="${searchVO.seCode eq 'prcdnt'}"> <a href="<c:url value='/adisvc/rewardPrcdntList.do'/>" class="btn btn-success" id="toList">목록</a></c:if>
		                    <c:if test="${searchVO.seCode eq 'instrc'}"> <a href="<c:url value='/adisvc/rewardInstructionList.do'/>" class="btn btn-success" id="toList">목록</a></c:if>
		                    <c:if test="${searchVO.seCode eq 'reg'}"> <a href="<c:url value='/adisvc/rewardRegList.do'/>" class="btn btn-success" id="toList">목록</a></c:if>
                        	</c:if>
                        </div>
                    </div>



					</div>
					</form>
				<!-- view : E -->
			
			
            <!-- content 영역입니다. -->	
            </div>
        </div>
    </div>
    <!-- layout -->
</div>
<!-- 구현부 : E -->

<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>
</body>
<script>

function toDetail(url){
	const uri = getContextPath()+url;
	const encoded = encodeURI(uri);
	console.log(encoded);
	location.href = encoded;
}


/* 게시물 삭제 */
$('.del_btn').on('click',function(){
	Common.Dialog.confirm({
        title: '삭제',
        content: '현재 게시글을 삭제하시겠습니까?'
        ,ok: function(){
        	$('#articleModifyForm').attr("action","<c:url value='/adisvc/rewardPrcdntBbsDelete.do'/>");  
    		$('#articleModifyForm').submit();
        }
        ,cancel : function(){
        	document.location.reload();
        }
    }); 
});
/* 게시물 수정 */
$('.edit_btn').on('click',function(){
	var seCode = '${searchVO.seCode}';

	Common.Dialog.confirm({
        title: '삭제',
        content: '현재 게시글을 수정하시겠습니까?'
        ,ok: function(){
        	$('#articleModifyForm').attr("action","<c:url value='/adisvc/rewardPrcdntBbsUpdate.do?seCode="+seCode+"'/>");  
        	$('#articleModifyForm').submit();
        }
        ,cancel : function(){
        	document.location.reload();
        }
    }); 
});

// /* 첨부파일 다운로드 */
// function downloadFile(orignlFileNm,fileStreCours,downGrade){
// 	var loginGrade = parseInt("${loginGrade}".substring("${loginGrade}".length-2));
// 	var downGrade = parseInt(downGrade.substring(downGrade.length-2));
// 	var loginGradeNm;
// 	if(loginGrade == 5 || loginGrade == 6){
// 		loginGradeNm = "실버";
// 	}else if(loginGrade == 7 || loginGrade == 8 || loginGrade == 9){
// 		loginGradeNm = "곧드";
// 	}else if(loginGrade == 10 || loginGrade == 11){
// 		loginGradeNm = "프리미엄";
// 	}else{
// 		loginGradeNm = "무료";
// 	}
// 	console.log('loginGrade : '+loginGrade);
// 	console.log('downGrade : '+downGrade);
// 	if(downGrade == 98 || downGrade == "" || downGrade == null){
// 		location.href= "<c:url value='/cmmn/downloadFile.do?orignlFileNm="+orignlFileNm+"&fileStreCours="+fileStreCours+"'/>";
// 	}else if(loginGrade == 1 || loginGrade == 3){
// 		if(downGrade < 10){
// 			location.href= "<c:url value='/cmmn/downloadFile.do?orignlFileNm="+orignlFileNm+"&fileStreCours="+fileStreCours+"'/>";
// 		}else{
// 			Common.Dialog.alert({content: '권한이 부족하여 다운받을 수 없습니다. <br /> 현재 회원님의 등급은 골드등급입니다.'});
// 		}
// 	}else if(loginGrade == 2 || loginGrade == 4){
// 		location.href= "<c:url value='/cmmn/downloadFile.do?orignlFileNm="+orignlFileNm+"&fileStreCours="+fileStreCours+"'/>";
// 	}else if(loginGrade > downGrade || loginGrade == downGrade){
// 		location.href= "<c:url value='/cmmn/downloadFile.do?orignlFileNm="+orignlFileNm+"&fileStreCours="+fileStreCours+"'/>";
// 	}else{
// 		Common.Dialog.alert({content: '권한이 부족하여 다운받을 수 없습니다. <br /> 현재 회원님의 등급은 '+loginGradeNm+'등급입니다.'});
// 	}
// };

/* 첨부파일 다운로드 */
function downloadFile(orignlFileNm,fileStreCours,downGrade){
   var loginGrade = parseInt("${loginGrade}".substring("${loginGrade}".length-2));
   var downGrade = parseInt(downGrade.substring(downGrade.length-2));
   var loginGradeNm;
   if(loginGrade == 5 || loginGrade == 6){
      loginGradeNm = "실버";
   }else if(loginGrade == 7 || loginGrade == 8 || loginGrade == 9){
      loginGradeNm = "곧드";
   }else if(loginGrade == 10 || loginGrade == 11){
      loginGradeNm = "프리미엄";
   }else{
      loginGradeNm = "무료";
   }
   console.log('loginGrade : '+loginGrade);
   console.log('downGrade : '+downGrade);
   if(downGrade == 98){
	   attUrlFileDown(getContextPath()+'/cmmn/downloadFile.do?orignlFileNm='+orignlFileNm+'&fileStreCours='+fileStreCours);
      //location.href= "<c:url value='/cmmn/downloadFile.do?orignlFileNm="+orignlFileNm+"&fileStreCours="+fileStreCours+"'/>";
   }else if(loginGrade == 1 || loginGrade == 3){
      if(downGrade < 10){
    	 attUrlFileDown(getContextPath()+'/cmmn/downloadFile.do?orignlFileNm='+orignlFileNm+'&fileStreCours='+fileStreCours);
         //location.href= "<c:url value='/cmmn/downloadFile.do?orignlFileNm="+orignlFileNm+"&fileStreCours="+fileStreCours+"'/>";
      }else{
         Common.Dialog.alert({content: '권한이 부족하여 다운받을 수 없습니다. <br /> 현재 회원님의 등급은 골드등급입니다.'});
      }
   }else if(loginGrade == 2 || loginGrade == 4){
	   attUrlFileDown(getContextPath()+'/cmmn/downloadFile.do?orignlFileNm='+orignlFileNm+'&fileStreCours='+fileStreCours);
	   //location.href= "<c:url value='/cmmn/downloadFile.do?orignlFileNm="+orignlFileNm+"&fileStreCours="+fileStreCours+"'/>";
   }else if(loginGrade > downGrade || loginGrade == downGrade){
	   attUrlFileDown(getContextPath()+'/cmmn/downloadFile.do?orignlFileNm='+orignlFileNm+'&fileStreCours='+fileStreCours);
      //location.href= "<c:url value='/cmmn/downloadFile.do?orignlFileNm="+orignlFileNm+"&fileStreCours="+fileStreCours+"'/>";
   }else{
      Common.Dialog.alert({content: '권한이 부족하여 다운받을 수 없습니다. <br /> 현재 회원님의 등급은 '+loginGradeNm+'등급입니다.'});
   }
};
</script>
</html>