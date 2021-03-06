<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- 행정안전부 공통서비스 테스트 사이트 -->
<%@ include file="/WEB-INF/jsp/gzonei/layout/header.jsp" %>
</head>




<body topmargin="0" leftmargin="0">
<%@ include file="/WEB-INF/jsp/gzonei/layout/top.jsp" %>
	
<!-- 구현부 : S -->

<div id="body_layout">	

    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
            <div id="location" class="title_wrap">
                <h2 class="page__title">토지보상 검토의뢰</h2>
                
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do' />">HOME</a></li>
                        <li class="n2"><a href="#">부가서비스</a></li>
                        <li class="n3"><a href="<c:url value='/adisvc/reqestBbsList.do'/>" class="navi_ov">토지보상 검토의뢰</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">
	            
            <!-- content 영역입니다. -->
          <%--   	<table class="board_view" style="border:1px";>
				<colgroup>
					<col width="15%" />
					<col width="35%" />
					<col width="15%" />
					<col width="35%" />
				</colgroup>
				<caption style="background-color: #ccc">게시글 상세</caption>
				<tbody>
						<tr>
							<th scope="row">글 번호</th>
							<td>${resultList.nttNo }</td>
							<th scope="row">조회수</th>
							<td>${resultList.rdcnt }</td>
						</tr>
						<tr>
							<th scope="row">작성자</th>
							<td>${resultList.frstRegisterId }</td>
							<th scope="row">작성시간</th>
							<td>${resultList.frstRegistPnttm }</td>
						</tr>
						<tr>
							<th scope="row">제목</th>
							<td colspan="3"></td>
						</tr>
						<tr>
							<td colspan="4" style="border: 1px solid #ccc; height: 100px;">${resultList.nttCn }</td>
						</tr>
						<tr>
							<th>첨부파일</th>
							<td colspan="3"></td>
						</tr>
				</tbody>
			</table> --%>




					<!-- view : S -->
					<div class="board_view_in">
						<!-- board -->
						<div class="board">
							<div class="board_view">
								<div class="view_header">
									<span class="view_tit_number">${resultList.nttId}</span>
									<div class="view_tit">
										<p class="tit_txt" style="font-size: 28px;">${resultList.nttSj }</p>
									</div>
									<span class="view_tit_aside"><fmt:formatDate
											pattern="yyyy.MM.dd" value="${resultList.frstRegistPnttm }" /></span>
									<div class="view_data">
<%-- 										<span class="view-id"><c:out value="${resultList.frstRegisterId}"/></span> --%>
<%-- 										<span class="view-hit">${resultList.rdcnt}</span> --%>
									</div>
								</div>

								<div class="view_cont_box">
									<div class="view_cont">
										<!-- 게시글-->
										${resultList.nttCn }
										<!--// 게시글-->
									</div>
								</div>
							</div>

							<!-- 첨부파일 S  -->
							<c:if test="${!empty atchFileDetail}">
								<div class="fileArea">
									<c:forEach items="${atchFileDetail}" var="atcFile"
										varStatus="status">
										<c:set var="loginGrade"
											value="${sessionScope.loginVO.gradCode}" />
										<c:set var="downGrade" value="${atcFile.readingAuthorCode}" />
										<p>
											<c:choose>
												<c:when
													test="${downGrade eq 'CM00200005' or downGrade eq 'CM00200006'}">
													<span class="txt_blt03 state03">실버</span>
												</c:when>
												<c:when
													test="${downGrade eq 'CM00200007' or downGrade eq 'CM00200008' or downGrade eq 'CM00200009'}">
													<span class="txt_blt03 state01">골드</span>
												</c:when>
												<c:when
													test="${downGrade eq 'CM00200010' or downGrade eq 'CM00200011'}">
													<span class="txt_blt03 state02">프리미엄</span>
												</c:when>
												<c:otherwise>
													<span class="txt_blt03">무료</span>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${!empty downGrade}">
													<a
														onclick="downloadFile('${atcFile.orignlFileNm}','${atcFile.fileStreCours}','${downGrade}');"><c:out
															value="${atcFile.orignlFileNm}" /></a>
												</c:when>
												<c:otherwise>

													<a
														href="<c:url value='/cmmn/downloadFile.do?orignlFileNm=${atcFile.orignlFileNm}&fileStreCours=${atcFile.fileStreCours}'/>"><c:out
															value="${atcFile.orignlFileNm}" /></a>
												</c:otherwise>
											</c:choose>

											<span class="file_vol"> <c:if
													test="${atcFile.fileSize/1024 < 1024 }">
													<c:out value="${atcFile.fileSize/1024}" /> KB</c:if> <c:if
													test="${atcFile.fileSize/1024 >= 1024 }">
													<c:out value="${atcFile.fileSize/1024/1024}" /> MB</c:if>
											</span>
										</p>
										<input type="hidden" name="fileStreCours"
											value="<c:out value='${atcFile.fileStreCours }'/>" />
										<input type="hidden" name="orignlFileNm"
											value="<c:out value='${atcFile.orignlFileNm }'/>" />
										<input type="hidden" name="fileSn"
											value="<c:out value='${atcFile.fileSn}'/>" />
										<input type="hidden" name="atchFileId"
											value="<c:out value='${atcFile.atchFileId}'/>" />
									</c:forEach>
								</div>
							</c:if>

						</div>
						<!-- board -->

						<div class="board_btm">
							<div class="btns_area fl_r mo_block">
								<c:if
									test="${resultList.frstRegisterId eq loginVO.get('id') or loginVO.get('indvdlMberCode') eq 'CM00210003' }">
									<a href="#" class="btn btn-primary" id="updateBtn"
										onclick="updateBbs(${resultList.nttId})">수정</a>
									<a href="#" class="btn btn-secondary" id="deleteBtn"
										onclick="deleteBbs(${resultList.nttId})">삭제</a>
								</c:if>
								<a href="<c:url value='/adisvc/reqestBbsList.do'/>"
									class="btn btn-success" id="toList">목록</a>
							</div>
						</div>

						<!-- comment -->
						<div class="comment">


							<form method="post">
								<strong class="title">댓글입력</strong>
								<div class="textbox">
									<textarea class="textarea" cols="50" rows="4" id="cmnt_cntn" name="cmnt_cntn"
										placeholder="저작권 등 다른사람의 권리를 침해하거나 명예를 훼손하는 게시물은 이용약관및 관련 법률에 의해 제재를 받을 수있습니다. 건전한 토론 문화와 양질의댓글문화를 위해, 타인에게 불쾌감을 주는욕설 또는특정 계층.민족, 종교 드의 비하하는 단어들은표시가제한됩니다."></textarea>
									<input type="hidden" id="frstRegisterId" name="frstRegisterId" value="${resultList.frstRegisterId}"> 
									<input type="hidden" id="nttId" name="nttId" value="${resultList.nttId }">
									<input type="hidden" id="bbsId" name="bbsId" value="${resultList.bbsId }">	
									<input type="hidden" id="readngAuthorCode" name="readngAuthorCode" value="${resultList.readngAuthorCode }">	
									<input type="hidden" id="loginId" name="loginId" value="${loginVO.get('id')}">	
									<a href="#" type="submit" class="commentAddBtn submit">등록</a>
								</div>
							</form>

							<div class="list-item">
								<c:forEach items="${commentList}" var="commentList"
									varStatus="status">
									<div class="list">
										<!-- comment 01 -->
										<div class="list-top">
											<strong class="commentName" style="font-weight: bold;"><c:out value="${fn:substring(commentList.frstRegisterId,0,2)}"/>****</strong>
											<c:if
												test="${commentList.frstRegisterId eq loginVO.get('id') or loginVO.get('indvdlMberCode') eq 'CM00210003' }">
												<div class="commentBtns"
													style="text-align: right; float: right;">
													<a href="#n" onclick="updateBtn(${status.index})"
														class="updateBtn${status.index}">수정</a> <a href="#n"
														onclick="updateComment(${commentList.answerNo },${resultList.nttId },${status.index})"
														class="updateCmtBtn${status.index}" style="display: none">확인</a>
													<a href="#n"
														onclick="deleteComment(${commentList.answerNo },${resultList.nttId })"
														class="deleteBtn${status.index}">삭제</a> <a href="#n"
														onclick="cancleBtn(${status.index})"
														class="cancleBtn${status.index}" style="display: none">취소</a>
												</div>
											</c:if>
										</div>

										<span class="list-cont" id="ansCnt${status.index}">${commentList.answer }</span>
										<textarea id="updateAnswer${status.index}"
											style="display: none; width: 95%; height: 50px;">${commentList.answer }</textarea>
										<br> <span class="date"><fmt:formatDate
												pattern="yyyy-MM-dd HH:mm"
												value="${commentList.frstRegistPnttm }" /></span>

									</div>
									<!-- comment 01 -->
								</c:forEach>
							</div>
						</div>
						<!-- comment -->


					</div>
					<!-- view : E -->
			
			
            <!-- content 영역입니다. -->	
            </div>
        </div>
    </div>
    <!-- layout -->
</div>

<!-- 구현부 : E -->
	
	
	

		<script>
		
		// 게시글 삭제
		function deleteBbs(nttId){
// 			var msg = confirm("게시글을 삭제하시겠습니까?");
			
			Common.Dialog.confirm({
		        title: '삭제',
	            content: '현재 게시글을 삭제하시겠습니까?'
	            ,ok: function(){
					// AJAX 통신 : POST 
					$.ajax({ 
						type : "post", 
						url : "<c:url value='/adisvc/reqestDeleteBbs.do'/>",
						async: false,
						dataType: "text",
				        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
						data : {nttId:nttId},
						success : function() { 
							// 성공적인 댓글 등록 처리 알림 
							Common.Dialog.alert({
								title: '확인',
								content: '게시글이 삭제되었습니다',
								ok: function(){
								location.href="<c:url value='/adisvc/reqestBbsList.do'/>"
								}
							});
						},
						error : function( jqXHR, textStatus, errorThrown ) {
							alert( jqXHR.status );
							alert( jqXHR.statusText );
							alert( jqXHR.responseText );
							alert( jqXHR.readyState );
							location.reload();
						}
					}); 
				},cancel : function(){
		        	document.location.reload();
		        }
			});
	}
	
	
		
		// 게시글 수정
		function updateBbs(id){
			Common.Dialog.confirm({
		        title: '수정',
	            content: '현재 게시글을 수정하시겠습니까?'
	            ,ok: function(){
	            	document.location="<c:url value='/adisvc/reqestBbsUpdate.do?nttId="+id+"'/>";
	            }
		        ,cancel : function(){
		        	document.location.reload();
		        }
	        });    
		}
		
		
		// 댓글 등록
		$(".commentAddBtn").on("click",function() {
			var answer = $("#cmnt_cntn").val(); // 댓글내용
			var loginId = $("#loginId").val(); // 댓글작성자
			var nttId = $("#nttId").val(); // 댓글연결된게시글번호
			var bbsId = $("#bbsId").val(); // 댓글연결된게시글번호
			var readngAuthorCode = $("#readngAuthorCode").val(); // 댓글연결된게시글번호
			

			Common.Dialog.confirm({
		        title: '등록',
	            content: '현재 댓글을 등록하시겠습니까?'
	            ,ok: function(){
	            	if(answer != ''){
	    				// AJAX 통신 : POST 
	    				$.ajax({ 
	    					type : "post", 
	    					url : "<c:url value='/adisvc/insertComment.do'/>",
	    					async: false,
	    					dataType: "text",
	    			        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
	    					data : {answer:answer, loginId:loginId, nttId:nttId, bbsId:bbsId},
	    					success : function() { 
	    						Common.Dialog.alert({
	    							title: '확인',
	    							content: '댓글이 등록되었습니다',
	    							ok: function(){
	    								// 성공적인 댓글 등록 처리 알림 
	    								location.reload();
	    								}
	    							});
	    						},
	    						error : function( jqXHR, textStatus, errorThrown ) {
	    							alert( jqXHR.status );
	    							alert( jqXHR.statusText );
	    							alert( jqXHR.responseText );
	    							alert( jqXHR.readyState );
	    							location.reload();
	    						}
	    					}); 
	    				}else{
	    					Common.Dialog.alert({
	    						title: '확인',
	    			            content: '댓글 내용을 입력해주세요.'
	    			            ,ok : function(){
	    			            	$('#cmnt_cntn').focus();
	    			            }
	    			        });
	    				}
	            	},cancel : function(){
	    				Common.Dialog.alert({
	    					title: '확인',
	    					content: '댓글 등록 취소'
	    					});
	    				}
					});
				});
		
		
		// 댓글 삭제
		function deleteComment(answerNo, nttId){
// 			var msg = confirm("댓글 삭제하시겠습니까?");
			
			Common.Dialog.confirm({
		        title: '삭제',
	            content: '현재 댓글을 삭제하시겠습니까?'
	            ,ok: function(){
					// AJAX 통신 : POST 
					$.ajax({ 
						type : "post", 
						url : "<c:url value='/adisvc/deleteComment.do'/>",
						async: false,
						dataType: "text",
				        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
						data : {answerNo:answerNo, nttId:nttId},
						success : function() { 
							Common.Dialog.alert({
								title: '확인',
								content: '댓글이 삭제되었습니다',
								ok: function(){
									// 성공적인 댓글 삭제 처리 알림 
									location.reload();
								}
							});
						},
						error : function( jqXHR, textStatus, errorThrown ) {
							alert( jqXHR.status );
							alert( jqXHR.statusText );
							alert( jqXHR.responseText );
							alert( jqXHR.readyState );
							location.reload();
						}
					}); 
			},cancel : function(){
				Common.Dialog.alert({
					title: '확인',
					content: '댓글 삭제 취소'
					});
				}
			});
		}
			
		
		// 댓글 수정
		//수정 버튼 클릭시 확인 취소
		function updateBtn(i){
			var i = String(i);
			
			$('.updateBtn'+i).css("display","none");
			$('.updateCmtBtn'+i).css("display","inline-block");
			$('.deleteBtn'+i).css("display","none");
			$('.cancleBtn'+i).css("display","inline-block");
			
			$('#updateAnswer'+i).css("display","block");
			$('#ansCnt'+i).css("display","none");
			
			$('#updateAnswer'+i).val($("#ansCnt"+i).text());
		}
		
		// 취소 버튼 클릭시 수정 삭제
		function cancleBtn(i){
			var i = String(i);
			
			$('.updateBtn'+i).css("display","inline-block");
			$('.updateCmtBtn'+i).css("display","none");
			$('.deleteBtn'+i).css("display","inline-block");
			$('.cancleBtn'+i).css("display","none");
			
			$('#updateAnswer'+i).css("display","none");
			$('#ansCnt'+i).css("display","block");
			
			$('#updateAnswer'+i).val($("#ansCnt"+i).text());
		}
		
		//수정 확인시 수정 완료
		function updateComment(answerNo, nttId,  i){
// 			var msg = confirm("댓글 수정하시겠습니까?");
			
			var i = String(i);
			var answer = $('#updateAnswer'+i).val();
			
			Common.Dialog.confirm({
		        title: '삭제',
	            content: '현재 댓글을 수정하시겠습니까?'
	            ,ok: function(){
					if(answer!=null){
						// AJAX 통신 : POST 
						$.ajax({ 
							type : "post", 
							url : "<c:url value='/adisvc/updateComment.do'/>",
							async: false,
							dataType: "text",
					        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
							data : {answerNo:answerNo, nttId:nttId, answer:answer},
							success : function() {
								Common.Dialog.alert({
									title: '확인',
									content: '댓글이 수정되었습니다',
									ok: function(){
										// 성공적인 댓글 삭제 처리 알림 
										location.reload();
									}
								});
							},
							error : function( jqXHR, textStatus, errorThrown ) {
								alert( jqXHR.status );
								alert( jqXHR.statusText );
								alert( jqXHR.responseText );
								alert( jqXHR.readyState );
								location.reload();
							}
						});
					}
				},cancel : function(){
					Common.Dialog.alert({
						title: '확인',
						content: '댓글 수정 취소'
					});
				}
			});
		}
		

		/* 첨부파일 다운로드 */
		function downloadFile(orignlFileNm,fileStreCours,downGrade){
			debugger;
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
				location.href= "<c:url value='/cmmn/downloadFile.do?orignlFileNm="+orignlFileNm+"&fileStreCours="+fileStreCours+"'/>";
			}else if(loginGrade == 1 || loginGrade == 3){
				if(downGrade < 10){
					location.href= "<c:url value='/cmmn/downloadFile.do?orignlFileNm="+orignlFileNm+"&fileStreCours="+fileStreCours+"'/>";
				}else{
					Common.Dialog.alert({content: '권한이 부족하여 다운받을 수 없습니다. <br /> 현재 회원님의 등급은 골드등급입니다.'});
				}
			}else if(loginGrade == 2 || loginGrade == 4){
				location.href= "<c:url value='/cmmn/downloadFile.do?orignlFileNm="+orignlFileNm+"&fileStreCours="+fileStreCours+"'/>";
			}else if(loginGrade > downGrade || loginGrade == downGrade){
				location.href= "<c:url value='/cmmn/downloadFile.do?orignlFileNm="+orignlFileNm+"&fileStreCours="+fileStreCours+"'/>";
			}else{
				Common.Dialog.alert({content: '권한이 부족하여 다운받을 수 없습니다. <br /> 현재 회원님의 등급은 '+loginGradeNm+'등급입니다.'});
			}
		};
		
		</script>


		<!-- bottom -->

<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>
</body>
</html>