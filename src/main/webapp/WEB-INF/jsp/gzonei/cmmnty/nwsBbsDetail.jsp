<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
                <h2 class="page__title">보도자료
</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a  href="<c:url value='/cmmnty/noticeBbsList.do'/>">커뮤니티</a></li>
                        <li class="n3"><a href="<c:url value='/cmmnty/nwsBbsList.do'/>" class="navi_ov">보도자료</a></li>
                    </ul>                       
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">
	           
            <!-- content 영역입니다. -->
			<!-- view : S -->
			<script>
		      $(document).ready(function(){
		          $(".view_cont a").attr("target","_blank");
		       });
			function pageDelete(id){
	               Common.Dialog.confirm({
	                    title: '삭제',
	                     content: '현재 게시글을 삭제하시겠습니까?'
	                     ,ok: function(){
	                        Common.Dialog.alert({
	                        title: '확인',
	                        content: '게시글이 삭제되었습니다',
	                        ok: function(){
	                        	document.location="<c:url value='/cmmnty/nwsBbsDelete.do?nttId="+id+"'/>";
	                        }
	                     });
	                  },cancel : function(){
	                       return false;
	                    }
	                 }); 
	            }

				function pageUpdate(id){
					 Common.Dialog.confirm({
					        title: '수정',
				            content: '현재 게시글을 수정하시겠습니까?'
				            ,ok: function(){
				            	document.location="<c:url value='/cmmnty/nwsBbsUpdate.do?nttId="+id+"'/>";
				            }
					        ,cancel : function(){
					        	return false;
					        }
				        });    
				}
				function toDetail(url){
					const uri = getContextPath() + url;
					const encoded = encodeURI(uri);
					console.log(encoded);
					location.href = encoded;
				}
			</script>
			<div class="board_view_in">
                    <!-- board -->
                    <div class="board">
                        <div class="board_view">
                            <div class="view_header">
	                            <span class="view_tit_number">${articleNum}</span>
                                <div class="view_tit">
                                    <p class="tit_txt">
										${result.nttSj}
                                    </p>
                                </div>
                                <span class="view_tit_aside"><fmt:formatDate  value="${result.articlDe}" pattern="yyyy-MM-dd" /></span>
<!--                                 <div class="view_data"> -->
<%-- 	                               <span class="view-id">${result.frstRegisterId}</span>   --%>
<%-- 	                               <span class="view-hit">${result.rdcnt}</span>      --%>
<!--                                 </div> -->
                            </div>
                            
                            <div class="view_cont_box">
                                <div class="view_cont">
                                <!--  뉴스 리스트 -->
                                <c:forEach items="${newslist}" var="list">
                                <b>${list.nsprcNm}  -  <a href="${list.linkUrl}" target="_blank">${list.linkSj}</a></b></br>
                                
                                </c:forEach>
                               
                                <!-- 게시글-->
								${result.nttCn}
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
<%-- 							        <c:choose>											 --%>
<%-- 										<c:when test = "${downGrade eq 'CM00200005' or downGrade eq 'CM00200006'}"><span class="txt_blt03 state03">실버</span></c:when> --%>
<%-- 										<c:when test = "${downGrade eq 'CM00200007' or downGrade eq 'CM00200008' or downGrade eq 'CM00200009'}"><span class="txt_blt03 state01">골드</span></c:when> --%>
<%-- 										<c:when test = "${downGrade eq 'CM00200010' or downGrade eq 'CM00200011'}"><span class="txt_blt03 state02">프리미엄</span></c:when> --%>
<%-- 										<c:otherwise><span class="txt_blt03">무료</span></c:otherwise> --%>
<%-- 									</c:choose> --%>
									<a onclick="downloadFile('${atcFile.orignlFileNm}','${atcFile.fileStreCours}','${downGrade}');"><c:out value="${atcFile.orignlFileNm}" /></a>
							            
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
                           <c:if test="${sessionScope.authVO.bbs006002.infoUpdtAt eq 'Y'}">
                            <a onclick="pageUpdate('${result.nttId}');" class="btn btn-primary">수정</a>
                            </c:if>
                           	<c:if test="${result.delAt eq 'N' && sessionScope.authVO.bbs006002.infoDelAt eq 'Y'}" >
                           	<a onclick="pageDelete('${result.nttId}');"  class="btn btn-secondary">삭제</a>
                            </c:if>
                            <c:if test="${pageIndex != null}">
<%--                            <a href="<c:url value='/cmmnty/nwsBbsList.do?pageIndex=${pageIndex}&startDate=${searchVO.startDate}&endDate=${searchVO.endDate}&searchType=${searchVO.searchType}&keyword=${searchVO.keyword}&orderType=${searchVO.orderType}' />"	class="btn btn-default" >목록</a> --%>
                        	<a	class="btn btn-default" href="javascript:toDetail('/cmmnty/nwsBbsList.do?pageIndex=${pageIndex}&startDate=${searchVO.startDate}&endDate=${searchVO.endDate}&searchType=${searchVO.searchType}&keyword=${searchVO.keyword}&orderType=${searchVO.orderType}')">목록</a>
                        	</c:if>
                        	<c:if test="${pageIndex == null}">
                        	<a href="<c:url value='/cmmnty/nwsBbsList.do' />"	class="btn btn-default" >목록</a>                        	
                        	</c:if>
                        </div>
                    </div>
					</div>       
                </div>

            </div>
        </div>
<script>
/* 첨부파일 다운로드 */
function downloadFile(orignlFileNm,fileStreCours,downGrade){
   var loginGrade = parseInt("${loginGrade}".substring("${loginGrade}".length-2));
   var downGrade = parseInt(downGrade.substring(downGrade.length-2));
   console.log('loginGrade : '+loginGrade);
   console.log('downGrade : '+downGrade);
	attUrlFileDown(getContextPath()+'/cmmn/downloadFile.do?orignlFileNm='+orignlFileNm+'&fileStreCours='+fileStreCours);

};
					</script>
    <!-- layout -->
</div>

<!-- 구현부 : E -->

<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>
</body>
</html>
