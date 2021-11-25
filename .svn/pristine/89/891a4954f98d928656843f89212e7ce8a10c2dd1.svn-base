  <%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<div class="modal fade" id="modal-search" role="dialog" data-ly-type="content" data-ly-target="reward-search">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal__body">
            <div class="modal__header">
                <h4 class="modal__title">개발정보 등록</h4>
                <div class="modal__close-button">
                    <button type="button" class="close" data-dismiss="modal">닫기</button>
                </div>
            </div>
            <div id="rewardDevlopInsertModal" class="rewardDevlopInsertModal">
                <div class="cont_wrap">
                    <div class="modal__board">
                        <div class="form-horizontal bucket-form" style="padding:0;">
                            <form id="rewardDevlopInsertForm" name="rewardDevlopInsertForm"  onsubmit="return false;">
                                <fieldset>
                                    <legend>검색</legend>
                                     <div class="search custom-search" style="margin-bottom: unset;padding: 1px 10px;">
<!--                                         <div class="form-group p-row" style="margin-top: 14px;"> -->
<!--                                             <div class="p-col-7 p-col-sm-18"> -->
<!--                                                 <select id="searchCondition" name="searchCondition" class="p-control"> -->
<!--                                                     <option value="dwkNm">사업명</option> -->
<!--                                                     <option value="dwkNo">사업번호</option> -->
<!--                                                 </select> -->
<!--                                             </div> -->
<!--                                             <div class="p-col-10 p-col-sm-18"> -->
<!--                                                 <input type="text" name="textSearch" title="검색어를 입력해주세요" placeholder="검색어를 입력해주세요" class="p-control" onkeypress="return enterkey1()"> -->
<!--                                             </div> -->
<!--                                             <div class="p-col-5  p-col-sm-24"> -->
<!--                                                 <button type="button" class="searchMember" onclick="javascript:;" id="rewardDevlopListSearch">검색</button> -->
<!--                                             </div> -->
<!--                                         </div> -->
										<div class="form-group p-row" style="margin-top: 14px;">
	                                             <div class="p-col-3 control-label" style="text-align: center;"><label class="mapTitle" for="area1">지　역</label></div>
	                                             <div class="p-col-6 p-col-sm-18">
	                                             <select id='rwdArea1' name='area1' class="rwdArea1 p-control" >
													<option value="">전체</option>
	                                             </select>
	                                             </div>
	                                            <div class="p-col-10 p-col-sm-18">
	                                             <select id='rwdArea2' name='area2' class="rwdArea2 p-control" >
													<option value="">전체</option>
	                                             </select>
	                                             </div>
                                           </div>
											<div class="form-group p-row" style="margin-top: 14px;">
												<div class="p-col-3 control-label" style="text-align: center;"><label class="mapTitle" for="area1">검색어</label></div>
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
	                                                  <button type="button" class="searchMember" onclick="javascript:;" id="rwdDevlopListSearch"  onkeypress="return enterkey1()">검색</button>
	                                             </div>
                                           </div>
                                    </div>
                                </fieldset>
                                <input type="hidden" name="devlopInfoSn">
                                <input type="hidden" name="pageIndex" id="pageIndexReward">
                                <input type="hidden" name="pageUnit" value="5">
                                <input type="hidden" name="pageSize" value="5">
                                <div id="contents" class="modal__content" style="word-break: break-all">
                                    <label>총 <span id="rewardDevlopTotalCount"></span> 건</label>
                                    <table class="paginated table_info">
                                        <colgroup>
                                            <col style="width:30%">
                                            <col style="width:auto">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th>
													개발사업번호
                                                </th>
                                                <th>
													개발사업명
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody id="rewardDevlopContents"></tbody>
                                    </table>
                                </div>
                                <div id="rewardDevlopPagination" style="text-align: center;">
                                    
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal__footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="rewardDevlopCancleBtn">닫기</button>
            </div>
        </div>
    </div>
</div>
<script>
function enterkey1() {
		if (window.event.keyCode == 13) { //javascript에서는 13이 enter키를 의미함 
			$("#rwdDevlopListSearch").click();
		}
	}
</script>