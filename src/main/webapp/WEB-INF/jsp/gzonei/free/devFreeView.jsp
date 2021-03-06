<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
                <h2 class="page__title">개발정보 샘플보기</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
<!--                         <li class="n2"><a href="#">개발정보</a></li>    이미지 변경해야됨-->
                        <li class="n2"><a href="<c:url value='/free/devFreeView.do?smpleNo=1'/>" class="navi_ov">개발정보 샘플보기</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">
	            
			<div class="nav-4th">
				<ul>
					<li <c:if test="${param.smpleNo == '1' }">class="active"</c:if>><a href="<c:url value='/free/devFreeView.do?smpleNo=1'/>">개발정보 샘플 1</a></li>
					<li <c:if test="${param.smpleNo == '2' }">class="active"</c:if>><a href="<c:url value='/free/devFreeView.do?smpleNo=2'/>">개발정보 샘플 2</a></li>
					<li <c:if test="${param.smpleNo == '3' }">class="active"</c:if>><a href="<c:url value='/free/devFreeView.do?smpleNo=3'/>">개발정보 샘플 3</a></li>
					<li <c:if test="${param.smpleNo == '4' }">class="active"</c:if>><a href="<c:url value='/free/devFreeView.do?smpleNo=4'/>">개발정보 샘플 4</a></li>
				</ul>
			</div>
            <!-- content 영역입니다. -->
            
  			<div id="info" class="sample" >
					<div class="button-map" style="margin-bottom: 60px">
						<button type="button" class="devInfoImgBtn" id="infoAdd" data-hover="off"><img style=" width: 15px;height: 15px;" src='<c:url value='/css/gzonei/SRC/images/map/icon-1.png' />'/><span>관심정보등록</span></button>
						<button type="button" class="devInfoImgBtn" id="infoParagraph" data-hover="off"><img style=" width: 15px;height: 15px;" src='<c:url value='/css/gzonei/SRC/images/map/icon-2.png' />'/><span>관련기사</span></button>
						<button type="button" class="devInfoImgBtn" id="infoObject" data-hover="off"><img style=" width: 15px;height: 15px;" src='<c:url value='/css/gzonei/SRC/images/map/icon-3.png'/>'><span>투자정보</span></button>
						<button type="button" class="devInfoImgBtn" id="infoReward" data-hover="off"><img style=" width: 15px;height: 15px;" src='<c:url value='/css/gzonei/SRC/images/map/icon-4.png' />'/><span>보상전례</span></button>
					</div>
					<strong class="title"><em>${lcNm.legaldongNm}</em>${bestFree.dwkNm}</strong>
					<div class="photoArea">
						<div class="thumbnail">
							<a ><img src="/file/displayFile.do?filePath=/upload/gzone/images/file/${imageLink.flpth}/${imageLink.streFileNm}&fileName=${imageLink.streFileNm}" alt=""></a>
						</div>
						<div class="photoList">
							<ul>
<!-- 								상세주소 -->
								<c:if test="${bestFree.addr != null  && !empty bestFree.addr}"><li><strong>상세주소</strong>${bestFree.addr}</li></c:if>
<!-- 								면적 -->
								<c:if test="${bestFree.bsnsArMeter != null  && !empty bestFree.bsnsArMeter}">
									<li>
										<c:choose>
	                                		<c:when test="${bestFree.unitTy =='길이'}">
	                                			<strong>길이</strong>
												<fmt:formatNumber type="number" maxFractionDigits="3" value="${bestFree.bsnsArMeter}"/>km (<fmt:formatNumber type="number" maxFractionDigits="3" value="${bestFree.bsnsArPyeong}"/>m)
	                                		</c:when>
	                                		<c:otherwise>
	                                			<strong>면적</strong>
	                                			<fmt:formatNumber type="number" maxFractionDigits="3" value="${bestFree.bsnsArMeter}"/>m<sup>2</sup> (<fmt:formatNumber type="number" maxFractionDigits="3" value="${bestFree.bsnsArPyeong}"/>평)
	                                		</c:otherwise>
                                		</c:choose>
									<li>
								</c:if>
<!-- 								사업기간 -->
								<c:if test="${bestFree.bsnsBgnde != null  && !empty bestFree.bsnsBgnde}"><li><strong>사업기간</strong>${bestFree.bsnsBgnde}~${bestFree.bsnsEndde}</li></c:if>
<!-- 								사업비 -->
								<c:if test="${bestFree.wct != null  && !empty bestFree.wct}"><li><strong>사업비</strong>${bestFree.wct}</li></c:if>
<!-- 								시행사 -->
								<c:if test="${bestFree.opertnCmpny != null && !empty bestFree.opertnCmpny}">
									<li><strong>시행사</strong>
										<c:choose>
		                              		<c:when test="${bestFree.opertnCmpnyNm == '직접입력' || empty bestFree.opertnCmpnyNm}">
				                                <li>${bestFree.opertnCmpny}</li>
		                                	</c:when>
		                                	<c:otherwise>
		                               			<li>${bestFree.opertnCmpnyNm}</li>
		                               		</c:otherwise>
		                           		</c:choose>
	                           		</li>
                           		</c:if>
<!--                            	적용법률 -->
								<c:if test="${bestFree.applcLaw != null  && !empty bestFree.applcLaw}"><li><strong>적용법률</strong>${bestFree.applcLaw}</li></c:if>
<!-- 								사업방식 -->
								<c:if test="${bestFree.bsnsMthdCodeNm != null && !empty bestFree.bsnsMthdCodeNm}">
									<li><strong>사업방식</strong>
										<%-- <c:out value="${bestFree.bsnsrcognNtfcNm}"/> --%>
										<c:out value="${bestFree.bsnsMthdCodeNm}"/>
									</li>
								</c:if>
<!-- 								사업인정시점 -->
								<c:if test="${bestFree.bsnsrcognNtfcNm != null && !empty bestFree.bsnsrcognNtfcNm}"><li><strong>사업인정시점</strong><c:out value="${bestFree.bsnsrcognNtfcNm}"/></li></c:if>
<!-- 								용지비 -->
								<c:if test="${bestFree.lct != null && !empty bestFree.lct}"><li><strong>용지비</strong><c:out value="${bestFree.lct}"/></li></c:if>
							</ul>
						</div>
					</div>
					
					
					<div class="map__header">
						<span class="map__title">사업주요내용</span>
					</div>
					<div class="map__content">
						<c:set var="bsnscn" value="${fn:split(bestFree.bsnsCn,'\\\\r\\\\n')}" />
						<ul>
							<c:forEach items="${bsnscn}"  var="cn">
								<li>${cn}</li>
							</c:forEach>
						</ul>
							
					</div>
					
					<div class="map__header">
						<span class="map__title">추진내역</span>
					</div>
					<div class="map__content">
						<ul>
							<c:forEach items="${sttusList}" var="sttus">
								<c:if test="${sttus.prtnSeCode == 'CM00170001'}">
									<li>
										<div class="tableCellTxt"><strong>${fn:substring(sttus.prtnBgnde,0,4)}.${fn:substring(sttus.prtnBgnde,4,6)}.${fn:substring(sttus.prtnBgnde,6,8)}</strong>
										<c:if test="${(sttus.prtnEndde != '' && sttus.prtnEndde != undefined) }"><strong> ~&nbsp;&nbsp;${fn:substring(sttus.prtnEndde,0,4)}.${fn:substring(sttus.prtnEndde,4,6)}.${fn:substring(sttus.prtnEndde,6,8)}</strong></c:if></div>
										<div class="tableCellTxt scd">&nbsp;&nbsp;${sttus.sj}</div></li>
										<c:if test="${sttus.atchFilePath != null}"><a class='down fr' href='<c:url value="/free/devFreeSubdownload.do?fileNm=${sttus.fileNm}&filePath=${sttus.atchFilePath}&atchFileId=${sttus.atchFileId}"></c:url>' >파일</a></c:if>
								</c:if>
							</c:forEach>
						</ul>
					</div>
					<div class="map__header">
						<span class="map__title">향후 추진계획</span>
						<span class="map__title pnttmText"><fmt:formatDate pattern="yyyy.MM.dd" value="${bestFree.lastdate}"/> 기준 작성(이후 변경가능)</span>
					</div>
					<div class="map__content">
						<ul >
							<c:forEach items="${sttusList}" var="sttus">
								<c:if test="${sttus.prtnSeCode == 'CM00170002'}">
									<li>
										<div style="display: table-cell;    max-width: 20%"><strong>${fn:substring(sttus.prtnBgnde,0,4)}.${fn:substring(sttus.prtnBgnde,4,6)}.${fn:substring(sttus.prtnBgnde,6,8)}</strong>
										<c:if test="${(sttus.prtnEndde != '' && sttus.prtnEndde != undefined)}"><strong> ~&nbsp;&nbsp;${fn:substring(sttus.prtnEndde,0,4)}.${fn:substring(sttus.prtnEndde,4,6)}.${fn:substring(sttus.prtnEndde,6,8)}</strong></c:if></div>
										<div style="display: table-cell;width: 83%">${sttus.sj}</div>
										
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</div>
					<div class="map__header">
						<span class="map__title">토지조서 및  보고서 다운로드</span>
					</div>
					<div class="map__content">
						<div class="ui-banner__box">
						<c:if test="${oldfileInfo.fileNm1 != null}">
								<div class="banner__box down">
									<a href='<c:url value="/free/devFreedownload.do?fileNm=${oldfileInfo.fileNm1}&filePath=${oldfileInfo.filePath1}"></c:url>' class="down">
										<strong class="ui-banner__title">${oldfileInfo.fileDisNm1}</strong>
									</a>
								</div>
						</c:if>
						<c:if test="${oldfileInfo.fileNm2 != null}">
								<div class="banner__box down">
									<a href='<c:url value="/free/devFreedownload.do?fileNm=${oldfileInfo.fileNm2}&filePath=${oldfileInfo.filePath2}"></c:url>' class="down">
										<strong class="ui-banner__title">${oldfileInfo.fileDisNm2}</strong>
									</a>
								</div>
						</c:if>
						<c:if test="${oldfileInfo.fileNm3 != null}">
								<div class="banner__box down">
									<a href='<c:url value="/free/devFreedownload.do?fileNm=${oldfileInfo.fileNm3}&filePath=${oldfileInfo.filePath3}"></c:url>' class="down">
										<strong class="ui-banner__title">${oldfileInfo.fileDisNm3}</strong>
									</a>
								</div>
						</c:if>
						<c:if test="${oldfileInfo.fileNm4 != null}">
								<div class="banner__box down">
									<a href="<c:url value="/free/devFreedownload.do?fileNm=${oldfileInfo.fileNm4}&filePath=${oldfileInfo.filePath4}"></c:url>" class="down">
										<strong class="ui-banner__title">${oldfileInfo.fileDisNm4}</strong>
									</a>
								</div>
						</c:if>
						<c:if test="${oldfileInfo.fileNm5 != null}">
								<div class="banner__box down">
									<a href="<c:url value="/free/devFreedownload.do?fileNm=${oldfileInfo.fileNm5}&filePath=${oldfileInfo.filePath5}"></c:url>" class="down">
										<strong class="ui-banner__title">${oldfileInfo.fileDisNm5}</strong>
									</a>
								</div>
						</c:if>
						<c:if test="${oldfileInfo.fileNm6 != null}">
								<div class="banner__box down">
									<a href="<c:url value="/free/devFreedownload.do?fileNm=${oldfileInfo.fileNm6}&filePath=${oldfileInfo.filePath6}"></c:url>" class="down">
										<strong class="ui-banner__title">${oldfileInfo.fileDisNm6}</strong>
									</a>
								</div>
						</c:if>
						<c:if test="${oldfileInfo.fileNm7 != null}">
								<div class="banner__box down">
									<a href="<c:url value="/free/devFreedownload.do?fileNm=${oldfileInfo.fileNm7}&filePath=${oldfileInfo.filePath7}"></c:url>" class="down">
										<strong class="ui-banner__title">${oldfileInfo.fileDisNm7}</strong>
									</a>
								</div>
						</c:if>
						<c:if test="${oldfileInfo.fileNm8 != null}">
								<div class="banner__box down">
									<a href="<c:url value="/free/devFreedownload.do?fileNm=${oldfileInfo.fileNm8}&filePath=${oldfileInfo.filePath8}"></c:url>" class="down">
										<strong class="ui-banner__title">${oldfileInfo.fileDisNm8}</strong>
									</a>
								</div>
						</c:if>
						<c:if test="${oldfileInfo.fileNm9 != null}">
								<div class="banner__box down">
									<a href="<c:url value="/free/devFreedownload.do?fileNm=${oldfileInfo.fileNm9}&filePath=${oldfileInfo.filePath9}"></c:url>" class="down">
										<strong class="ui-banner__title">${oldfileInfo.fileDisNm9}</strong>
									</a>
								</div>
						</c:if>
						<c:if test="${oldfileInfo.fileNm10 != null}">
								<div class="banner__box down">
									<a href="<c:url value="/free/devFreedownload.do?fileNm=${oldfileInfo.fileNm10}&filePath=${oldfileInfo.filePath10}"></c:url>" class="down">
										<strong class="ui-banner__title">${oldfileInfo.fileDisNm10}</strong>
									</a>
								</div>
						</c:if>
						<c:if test="${oldfileInfo.fileNm11 != null}">
								<div class="banner__box down">
									<a href="<c:url value="/free/devFreedownload.do?fileNm=${oldfileInfo.fileNm11}&filePath=${oldfileInfo.filePath11}"></c:url>" class="down">
										<strong class="ui-banner__title">${oldfileInfo.fileDisNm11}</strong>
									</a>
								</div>
						</c:if>
						<c:if test="${oldfileInfo.fileNm12 != null}">
								<div class="banner__box down">
									<a href="<c:url value="/free/devFreedownload.do?fileNm=${oldfileInfo.fileNm12}&filePath=${oldfileInfo.filePath12}"></c:url>" class="down">
										<strong class="ui-banner__title">${oldfileInfo.fileDisNm12}</strong>
									</a>
								</div>
						</c:if>
						<c:if test="${oldfileInfo.fileNm13 != null}">
								<div class="banner__box down">
									<a href="<c:url value="/free/devFreedownload.do?fileNm=${oldfileInfo.fileNm13}&filePath=${oldfileInfo.filePath13}"></c:url>" class="down">
										<strong class="ui-banner__title">${oldfileInfo.fileDisNm13}</strong>
									</a>
								</div>
						</c:if>
						<c:if test="${oldfileInfo.fileNm14 != null}">
								<div class="banner__box down">
									<a href="<c:url value="/free/devFreedownload.do?fileNm=${oldfileInfo.fileNm14}&filePath=${oldfileInfo.filePath14}"></c:url>" class="down">
										<strong class="ui-banner__title">${oldfileInfo.fileDisNm14}</strong>
									</a>
								</div>
						</c:if>
						<c:if test="${oldfileInfo.fileNm15 != null}">
								<div class="banner__box down">
									<a href="<c:url value="/free/devFreedownload.do?fileNm=${oldfileInfo.fileNm15}&filePath=${oldfileInfo.filePath15}"></c:url>" class="down">
										<strong class="ui-banner__title">${oldfileInfo.fileDisNm15}</strong>
									</a>
								</div>
						</c:if>
						<c:if test="${!empty newfileInfo}">
								<div class="banner__box down">
									<a href="'<c:url value="/cmmm/downloadFile.do?orignlFileNm=${newfileInfo.originlFileNm}&streFileNm=${newfileInfo.originlFileNm}"></c:url>'" class="down">
										<strong class="ui-banner__title">${newfileInfo.originlFileNm}</strong>
									</a>
								</div>
						</c:if>
						</div>
					</div>
					<div class="menteu">
						<c:set var="gzment" value="${fn:split(bestFree.gzMent,'\\\\r\\\\n')}" />
							<ul>
								<c:forEach items="${gzment}"  var="ment">
									<li>${ment}</li>
								</c:forEach>
							</ul>
					</div>
					<div class="ui-tip__box">
						<p class="txt-tip txt-small">본 개발정보는 <span id='mngrLastUpdtPnttmText' class="empTxt">2021년 02월 08일</span>까지 공개된 자료와 Gzone 당사가 직접 취재한 내용을 바탕으로 최종 수정된 자료입니다. 금일 이후 사업시행자의 사정 또는 경제여건의 변화 등에 따라 사업은 축소.확대.변경.취소 및 지연될 수 있으니 이용자께서는 이점 유의하시길 바랍니다.</p>
						<p class="txt-tip txt-small">본 개발정보는 참고사항이며 당사는 이에 대해 어떠한 경우라도 법적인 책임을 지지 않습니다.</p>
						<p class="txt-tip txt-small">본 개발정보의 지적소유권은 당사에 있으며 당사의 사전 서면 허락없이 이를 무단으로 전제, 복제 할 경우 저작권법에 따라 처벌을 받을 수 있습니다.</p>
						<p class="txt-tip txt-small">개발정보 상세내역에 대한 <span class="empTxt">출력[인쇄하기]</span>은 <span class="empTxt">하루 최대 20회</span>로 제한되어 있습니다. <span class="empTxt">인쇄하기 횟수는 클릭 시 차감</span>됩니다. 이용자께서는 이점 유의하시길 바랍니다.</p>
					</div>
					<div class="ui-tip__box">
						<p class="crTxt txt-small">copyright (c) Gzone Corp. All rights reserved.</p>
					</div>
				</div>
			</div>
            <!-- content 영역입니다. -->	
        </div>

    </div>
</div>
<!-- 구현부 : E -->

<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>
</body>
</html>
