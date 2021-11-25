<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang='ko'>
<head>
<%@ include file="/WEB-INF/jsp/gzonei/layout/header.jsp"%>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/gzonei/layout/admintop.jsp" %>
	<!-- 구현부 : S -->
	<div id="body_layout">

		<!-- layout -->
		<div id="contens" class="contents_wrap">
			<div id="location" class="title_wrap">
				<h2 class="page__title">사업지구 관리</h2>
				<!-- 유틸 시작 -->
				<div class="utile_wrap">
					<!-- 로케이션 시작 -->
					<ul class="location_wrap">
						<li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
						<li class="n2"><a href="/admin/gradAuth/gradAuthManage.do">등급권한관리</a></li>
						<li class="n3"><a href="<c:url value='amdin/bsnsDstrc/selectBsnsDstrc.do'/>" class="navi_ov">사업지구 관리</a></li>
					</ul>
					<!-- 로케이션 끝 -->
				</div>
				<!-- 유틸 끝 -->
			</div>
			<!-- content 영역입니다. -->
			<div class="p-row" style="padding: 0 10% 5% 10%;">
				<div>
					<h2 class="h2" style="padding-top: 3%; padding-left: 2%">사업지구
						목록</h2>
					<div class="table_wrap table_scroll" style="text-align: center;">
						<table class="table_info" style="table-layout: fixed; border-collapse: collapse;" id="bsnsInfo">
							<colgroup>
								<col style="width: 10%">
								<col style="width: 35%">
								<col style="width: 35%">
								<col style="width: auto">
								
							</colgroup>
							<thead>
								<tr class="bsns_thead">
									<th>코드레벨</th>
									<th>코드 ID</th>
									<th>코드명</th>
									<th>사용여부</th>
								</tr>
							</thead>
							<tbody>

								<c:forEach var="list" items="${bsnsList}">
									<tr>
										<td><c:out value="${list.codeLevel}" /></td>
										<td><c:out value="${list.codeId}" /></td>
										<td><c:out value="${list.codeIdNm}" /></td>
										<td style="display: none"><c:out value="${list.applcGrad}" /></td>
										<td style="display: none"><c:out value="${list.upperCodeAt}" /></td>
										<td style="display: none"><c:out value="${list.upperCodeId}" /></td>
										<td ><c:out value="${list.useAt}" /></td>
										<td style="display: none"><c:out value="${list.sortOrdr}" /></td>
										<td style="display: none"><c:out value="${list.bsnsDstrcCodeSn}" /></td>
										<td style="display: none"><c:out value="${list.unitTy}" /></td>
									</tr>
								</c:forEach>

							</tbody>
						</table>
					</div>
				</div>
				<div class="board_btm">
					<div class="btns_area fl_r mo_block" style="padding: 2% 1% 1% 1%;">
						<a  class="btn btn-default" id="createBtn" onclick="createBsns();">신규</a>
					</div>
				</div>
				<div class="p-col-24 p-col-sm-24 detailInfo">
					<h2 class="h2" style="padding-top: 3%; padding-left: 2%">상세정보</h2>
					<div class="table_wrap">
						<form id="bsnsDstrcForm" name="bsnsDstrcForm" method="post">
							<table class="table_info" id="bsnsTb"  >
							<colgroup>
								<col style="width: 20%">
								<col style="width: auto">	
							</colgroup>
								<tbody>
									<tr>
										<th>코드레벨</th>
										<td><input type="text" id="codeLevel" name="codeLevel"  class="form-control p-col-6" value="" ></td>
									</tr>
									<tr>
										<th>코드 ID</th>
										<td><input type="text" id="codeId" name="codeId"  class="form-control p-col-6" value="" ></td>
									</tr>
									<tr>
										<th>코드명</th>
										<td><input type="text" id="codeIdNm" name="codeIdNm"  class="form-control p-col-6" value="" ></td>
									</tr>
									<tr>
										<th>상위코드 여부</th>
										<td style="text-align:left;"><input type="radio" id="upperCodeAtY" name="upperCodeAt"  value="Y" >&nbsp;&nbsp;Y
																	<input type="radio" id="upperCodeAtN" name="upperCodeAt"  value="N" >&nbsp;&nbsp;N</td>
									</tr>
									<tr>
										<th>상위코드 ID</th>
										<td><input type="text" id="upperCodeId" name="upperCodeId" class="form-control p-col-6" value="" ></td>
									</tr>
									<tr>
										<th>사용여부</th>
										<td style="text-align:left;">
											<c:if test="${sessionScope.authVO.adm005002.infoDelAt == 'Y'}">
												<input type="radio" id="useAtY" name="useAt" value="Y" >&nbsp;&nbsp;Y
												<input type="radio" id="useAtN" name="useAt" value="N" >&nbsp;&nbsp;N
											</c:if>
											<c:if test="${sessionScope.authVO.adm005002.infoDelAt == 'N'}">
												<label for="useAt">수정불가</label>
		                                		<input type="hidden" id="useAtN" name="useAt" value="N" >
											</c:if>
										</td>
									</tr>
									<tr>
										<th>단위유형</th>
										<td style="text-align:left;"><input type="radio" id="unitTyL" name="unitTy" value="길이" >&nbsp;&nbsp;길이
																	<input type="radio" id="unitTyA" name="unitTy" value="면적" >&nbsp;&nbsp;면적</td>
									</tr>
									<tr>
										<th>정렬순서</th>
										<td><input type="text" id="sortOrdr" name="sortOrdr" class="form-control p-col-6" value="" >
											<input type="hidden" id="bsnsDstrcCodeSn" name="bsnsDstrcCodeSn" value="">
										</td>
									</tr>
									<tr>
										<th>권한</th>
										<td id="grade" style="text-align:left;">
											<c:forEach items="${authorList}"  var="auth">
												<input type="checkbox" id="${auth.gradAuthorCode}" name="applcGrad" value="${auth.gradAuthorCode}" >&nbsp;&nbsp;<label for="${auth.gradAuthorCode}">${auth.gradAuthorCode} - ${auth.gradAuthorNm} - ${auth.gradAuthorDc}</label><br>
											</c:forEach>
										</td>

									</tr>
								</tbody>
							</table>
						</form>
					</div>
				<div class="board_btm">
					<div class="btns_area fl_r mo_block">
						<a class="btn btn-secondary" id="cancelBtn" onclick="cancelBsns();">취소</a>
						<a class="btn btn-default" id="updateBtn" onclick="updateBsns();">수정</a> 
						<a class="btn btn-primary" id="saveBtn" onclick="savaBsns();">저장</a>
						<a class="btn btn-primary" id="saveNewBtn" onclick="savaNewBsns();">저장</a>
					</div>
				</div>
				</div>
			</div>
			<!-- content 영역입니다. -->
			<script>				
				$(document).ready(function() {
					checkAuth("adm005002", "menuAccesAt","");
					$('#saveBtn').hide();
					$('#saveNewBtn').hide();
					$('#updateBtn').hide();
					$('#bsnsTb input').attr('disabled',true);
					$('.detailInfo').hide();
					// 대분류 테이블의 Row 클릭시 값 가져오기
					$("#bsnsInfo").on('click', 'tr', function(e) {
						$('.detailInfo').show();
						$('#bsnsTb input').attr('disabled',true);
						$("#grade").children("input").prop("checked", $(this).is(":checked"));
						$('#updateBtn').show();
						$('#saveNewBtn').hide();
						$('#saveBtn').hide();
						$('#default').hide();
						$('#createBtn').show();
						$('#bsnsInfo tr').css('background-color', '');
						$(this).css('background-color', '#fbcb00');

						var str = "";
						var tdArr = new Array(); // 배열 선언

						// 현재 클릭된 Row(<tr>)
						var tr = $(this);
						var td = tr.children();

						// tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
						console.log("클릭한 Row의 모든 데이터 : " + tr.text());

						// 반복문을 이용해서 배열에 값을 담아 사용할 수 도 있다.
						td.each(function(i) {
							tdArr.push(td.eq(i).text());
						});

						console.log("배열에 담긴 값 : " + tdArr);
						// td.eq(index)를 통해 값을 가져올 수도 있다.
						var codeLevel = td.eq(0).text();
						var codeId = td.eq(1).text();
						var codeIdNm = td.eq(2).text();
						var applcGrad = td.eq(3).text();
						if(td.eq(4).text()=='Y'){
							$("#upperCodeAtY").attr('checked',true);
						}else{
							$("#upperCodeAtN").attr('checked',true);
						}
						var upperCodeId = td.eq(5).text();
						if(td.eq(6).text()=='Y'){
							$("#useAtY").attr('checked',true);
						}else{
							$("#useAtN").attr('checked',true);
						}
						var sortOrdr = td.eq(7).text();
						var bsnsDstrcCodeSn = td.eq(8).text();
						if(applcGrad != ""){
							var	appstr = applcGrad.trim().split(',');
// 							var	appstr = applcGrad.replaceAll(" ","").split(',')
							var grade ="";
							var gradee = "";
							for (var i=0; i < appstr.length ; i++){
							grade = "#"+appstr[i];
							gradee = $(grade).val();
								if(gradee == appstr[i]){
// 									$(grade).attr('checked',true);
									$(grade).prop('checked',true);
// 									$(grade).checked = true;
								}				
	 						}
// 							$("#CM00200001").attr('checked',true);
							
						}
						var bsnsDstrcCodeSn = td.eq(8).text();
						$("#codeLevel").val(codeLevel);
						$("#codeId").val(codeId);
						$("#codeIdNm").val(codeIdNm);
						$("#upperCodeId").val(upperCodeId);
						$("#sortOrdr").val(sortOrdr);
						$("#bsnsDstrcCodeSn").val(bsnsDstrcCodeSn);
						//단위유형
						var unitTy = td.eq(9).text();
						if(unitTy=='길이'){
							$("#unitTyL").attr('checked',true);
						}else{
							$("#unitTyA").attr('checked',true);
						}
					});
				});
				function cancelBsns(){  //취소
					$('#bsnsTb input').removeAttr('disabled');
					$("#grade").children("input").prop("checked", $(this).is(":checked"));
					$("#codeLevel").val('');
					$("#codeId").val('');
					$("#codeIdNm").val('');
					$("#upperCodeId").val('');
					$("#upperCodeAtY").attr('checked',false);
					$("#upperCodeAtN").attr('checked',true);
					$("#useAtY").attr('checked',true);
					$("#useAtN").attr('checked',false);
					//단위유형
					$("#unitTyL").attr('checked',false);
					$("#unitTyA").attr('checked',true);
					//
					$("#sortOrdr").val('');
					$('.detailInfo').hide();
				}
				function createBsns(){  //신규
					$('.detailInfo').show();
					$('#bsnsTb input').removeAttr('disabled');
					
					$("#grade").children("input").prop("checked", $(this).is(":checked"));
					$("#codeLevel").val('');
					$("#codeId").val('');
					$("#codeIdNm").val('');
					$("#upperCodeId").val('');
					$("#upperCodeAtY").attr('checked',false);
					$("#upperCodeAtN").attr('checked',true);
					$("#useAtY").attr('checked',true);
					$("#useAtN").attr('checked',false);
					//단위유형
					$("#unitTyL").attr('checked',false);
					$("#unitTyA").attr('checked',true);
					//
					$("#sortOrdr").val('');
					$('#saveBtn').hide();
					$('#updateBtn').hide();
					$('#saveNewBtn').show();
					$("#codeLevel").focus();

				}
				function validation(){
					var cdIdLength = $('#codeId').val().length;
					if ($('#codeLevel').val() == '') {
						Common.Dialog.alert({
				            content: '코드레벨을 입력해주세요'
				            ,ok : function(){
				            	$('#codeLevel').focus();
				            }
				        });
						return false;
					}
					if ($('#codeId').val() == '') {
						Common.Dialog.alert({
				            content: '코드레벨을 입력해주세요'
				            ,ok : function(){
				            	$('#codeLevel').focus();
				            }
				        });
						return false;
					}
					if ($('#codeId').val().length <= 9 || $('#codeId').val().length >= 11) {
						Common.Dialog.alert({
				            content: '코드 ID는 10자 입니다'
				            ,ok : function(){
				            	$('#codeId').focus();
				            }
				        });
						return false;
					}
					if ($('#codeIdNm').val() == '') {
						Common.Dialog.alert({
				            content: '코드명 입력해주세요'
				            ,ok : function(){
				            	$('#codeIdNm').focus();
				            }
				        });
						return false;
					}
					if ($('#upperCodeAt').val() == '') {
						Common.Dialog.alert({
				            content: '상위코드 여부를 입력해주세요'
				            ,ok : function(){
				            	$('#upperCodeAt').focus();
				            }
				        });
						return false;
					}
					if($("#upperCodeAtY").attr('checked',true)){
						if ($('#upperCodeId').val().length <= 9 || $('#upperCodeId').val().length >= 11) {
							Common.Dialog.alert({
					            content: '상위코드ID는 10자 입니다'
					            ,ok : function(){
					            	$('#upperCodeId').focus();
					            }
					        });
							return false;
						}
					}
					if ($('#useAt').val() == '') {
						Common.Dialog.alert({
				            content: '사용여부를 입력해주세요'
				            ,ok : function(){
				            	$('#useAt').focus();
				            }
				        });
						return false;
					}
					if ($('#sortOrdr').val() == '') {
						Common.Dialog.alert({
				            content: '정렬순서를 입력해주세요'
				            ,ok : function(){
				            	$('#sortOrdr').focus();
				            }
				        });
						return false;
					}
					return true;
				}
				function updateBsns(){
					checkAuth("adm005002", "infoUpdtAt","");
					$('#bsnsTb input').attr('disabled',false);
					$('#updateBtn').hide();
					$('#saveBtn').show();
				}
				function savaBsns(){
					
					if(validation()){	
						Common.Dialog.confirm({
					        title: '저장',
				            content: '현재 정보를 저장하시겠습니까?'
				            ,ok: function(){
				            	document.bsnsDstrcForm.action="<c:url value='/admin/bsnsDstrc/saveBsnsDstrc.do'/>";
								document.bsnsDstrcForm.submit();
				            }
					        ,cancel : function(){
					        	return;
					        }
				        });    
						}
				}
				function savaNewBsns(){
					
					if(validation()){	
						Common.Dialog.confirm({
					        title: '저장',
				            content: '현재 정보를 저장하시겠습니까?'
				            ,ok: function(){
				            	document.bsnsDstrcForm.action="<c:url value='/admin/bsnsDstrc/saveNewBsnsDstrc.do'/>";
								document.bsnsDstrcForm.submit();
				            }
					        ,cancel : function(){
					        	return;
					        }
				        });    
					}
				}

				</script>

		</div>

	</div>
	<!-- 구현부 : E -->

	<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp"%>
</body>
</html>
