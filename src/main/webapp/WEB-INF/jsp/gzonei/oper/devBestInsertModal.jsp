  <%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	 	<div class="modal fade" id="devModal" role="dialog" data-ly-type="content" >
 			<div class="modal-dialog"> 
 		                <!-- Modal content-->
		                <div class="modal__body" >
		                    <div class="modal__header">
		                       <h4 class="modal__title">개발정보 등록</h4>
		                        <div class="modal__close-button"><button type="button" class="close" data-dismiss="modal">닫기</button></div>
		                    </div>
		                    
		                    	<div id="devBestInsertModal" class="devBestInsertModal">
		                        <div class="cont_wrap">
		                            <div class="table_wrap">
		                            <form id="devBestInsertForm" name="devBestInsertForm" method="post">
		                            <fieldset>
                                        <legend>검색</legend>
                                        <div class="search custom-search" style="margin-bottom: unset;padding: 1px 10px;">
<!--                                           <div class="form-group p-row" style="margin-top: 14px;"> -->
<!--                                              <div class="p-col-7 p-col-sm-18"> -->
<!--                                              <select id='searchCondition' name='searchCondition' class="p-control" > -->
<!-- 												<option value='dwkNm'>사업명</option> -->
<!-- 												<option value='dwkNo'>사업번호</option> -->
<!--                                              </select> -->
<!--                                              </div> -->
<!--                                              <div class="p-col-10 p-col-sm-18"> -->
<!--                                                       <input type="text" name="textSearch" id="textSearch" title="검색어를 입력해주세요" placeholder="검색어를 입력해주세요" class="p-control" onkeypress="return enterkeyInv();"> -->
<!--                                                   </div> -->
<!--                                              <div class="p-col-5  p-col-sm-24"> -->
<!--                                                       <button type="button" class="searchMember" onclick="javascript:;" id="devBestListSearch">검색</button> -->
<!--                                              </div> -->
<!--                                            </div> -->
											<div class="form-group p-row" style="margin-top: 14px;">
	                                             <div class="p-col-3 control-label" style="text-align: center;"><label class="mapTitle" for="area1" style="margin-top:16px;">지　역</label></div>
	                                             <div class="p-col-6 p-col-sm-18">
	                                             <select id='bestDevArea1' name='area1' class="bestDevArea1 p-control" >
													<option value="">전체</option>
	                                             </select>
	                                             </div>
	                                            <div class="p-col-10 p-col-sm-18">
	                                             <select id='bestDevArea2' name='area2' class="bestDevArea2 p-control" >
													<option value="">전체</option>
	                                             </select>
	                                             </div>
                                           </div>
											<div class="form-group p-row" style="margin-top: 14px;">
												<div class="p-col-3 control-label" style="text-align: center;"><label class="mapTitle" for="area1" style="margin-top:16px;">검색어</label></div>
	                                             <div class="p-col-6 p-col-sm-18">
	                                             <select id='searchCondition' name='searchCondition' class="p-control" >
													<option value='dwkNm'>사업명</option>
													<option value='dwkNo'>사업번호</option>
	                                             </select>
	                                             </div>
	                                             <div class="p-col-10 p-col-sm-18">
	                                                 <input type="text" name="textSearch"  title="검색어를 입력해주세요" placeholder="검색어를 입력해주세요" class="p-control" onkeypress="return enterkeyInv();">
	                                             </div>
	                                             <div class="p-col-5  p-col-sm-24">
	                                                  <button type="button" class="searchMember" onclick="javascript:;" id="devBestListSearch"  onkeypress="return enterkeyInv()">검색</button>
	                                             </div>
                                           </div>
                                          </div>
                                     </fieldset>
                                     	<input type="hidden" name="devlopInfoSn" />
										<input type="hidden" name="pageIndex" id="pageIndexDevBest" /> 
										<input type="hidden" name="pageUnit" value="5" />
										<input type="hidden" name="pageSize" value="5" />
<!-- 		                            	<div style="height: 50px; margin-top: 20px; text-align:center;"> -->
<!-- 											<select id='searchCondition' name='searchCondition'> -->
<!-- 												<option value='dwkNm'>사업명</option> -->
<!-- 												<option value='dwkNo'>사업번호</option> -->
<!-- 											</select>  -->
<!-- 											<input type="text" name="textSearch" style="background-color: #F2F2F2; border-radius: 30px;width:40%;"/>  -->
<!-- 												<a class="btn-sm btn-primary" href="javascript:;" id="devBestListSearch"  style="border-radius: 10px;">검색</a> -->
<!-- 										</div> -->
<!-- 										<input type="hidden" name="devlopInfoSn" /> -->
<!-- 										<input type="hidden" name="pageIndex" />  -->
<!-- 										<input type="hidden" name="pageUnit" value="5" /> -->
<!-- 										<input type="hidden" name="pageSize" value="5" /> -->
										
										<div id="contents" class="modal__content" style="word-break: break-all">
			                            <label style="">총 <span id="devBestTotalCount"></span> 건</label>
		                                <table class="paginated table_info">
		                                    <colgroup>
												<col style="width:30%">
												<col style="width:auto">
											</colgroup>
		                                    <thead>
		                                        <tr>
		                                            <th>개발사업번호</th>
		                                            <th>개발사업명</th>
		                                        </tr>
		                                    </thead>
											<tbody id="devBestContents">
											</tbody>                         
		                                </table>
		                                </div>
		                               <div id="devBestPagination" style="text-align: center;"></div>          
		                            </form>
		                            </div>

		                        </div>
		                    	</div>
		                     
		                    <div class="modal__footer">
			                    <button type="button" class="btn btn-default" data-dismiss="modal" id='devBestCancleBtn'>닫기</button>
			                 </div>
			                
		                </div> 
		            </div>
		        </div>
<script>
function enterkeyInv() {
		if (window.event.keyCode == 13) { //javascript에서는 13이 enter키를 의미함 
			event.preventDefault();
			devBestListSearch('',1);
		}
	}
</script>	
		       