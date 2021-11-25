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

<!-- 구현부 : S -->
<div id="body_layout">	

    <!-- layout -->
    <div class="body_wrap layout">      
        <div id="contens" class="contents_wrap">
            <div id="location" class="title_wrap">
                <h2 class="page__title">등급 권한 관리</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="/site/kr/">HOME</a></li>
                        <li class="n2"><a href="/kr/html/sub01/010101.html">지존스토어</a></li>
                        <li class="n3"><a href="/kr/html/sub01/010101.html" class="navi_ov">보상판례</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                    <!-- 프린트 시작 -->
                    <ul class="print_wrap setting-box__group">
                        <li id="sns_layout" class="n2">
                            <button data-target="ui-open">SNS공유</button>
                            <div class="sns_wrap" data-id="ui-open">
                                <button data-button="sns_share" data-service="naver" data-title="네이버 SNS공유" title="새창열림" target="_blank"><span class="sr-only">네이버 SNS</span>공유하기</button>
                                <button data-button="sns_share" data-service="facebook" data-title="페이스북 SNS공유" title="새창열림" target="_blank"><span class="sr-only">페이스북 SNS </span>공유하기</button>
                                <button data-target="ui-close">닫기</button>
                            </div>
                        </li>                    
                        <li class="n1" id="print"><button data-print="print">프린트</button></li>
                    </ul>
                    <!-- 프린트 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">
	            <h2 class="h2">권한 목록</h2>
             	<div class="board_btm2">
                    <div class="btns_area fl_r mo_block">
                        <a href="#" class="btn btn-default btn-sm">신규</a>
                        <a href="#" class="btn btn-secondary btn-sm">미사용</a>
                    </div>
                </div>
	            <div class="table_wrap">
                    <table class="table_info">
						<colgroup>
							<col style="width:10%">
							<col style="width:10%">
							<col style="width:10%">
							<col style="width:auto">
							<col style="width:10%">
							<col style="width:10%">
						</colgroup>
                        <thead>
                            <tr>
                                <th>선택</th>
                                <th>사용여부</th>
                                <th>권한명</th>
                                <th>권한설명</th>
                                <th>등록자</th>
                                <th>등록일</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
	                                <input class="checkbox-input" type="checkbox" id="checkbox1" name="" title="선택" value="a">
                                </td>
                                <td>사용</td>
                                <td>XXXX</td>
                                <td class="subject">XXXXXXXXXXXXX</td>
                                <td>XXX</td>
                                <td>2021-02-09</td>
                            </tr>
                        </tbody>                            
                    </table>
                </div>
                <h2 class="h2">등급 권한 기본정보</h2>
                <div class="table_wrap">
                    <table class="table_info">
	                    <colgroup>
							<col style="width:10%">
							<col style="width:10%">
							<col style="width:10%">
							<col style="width:auto">
							<col style="width:10%">
							<col style="width:10%">
						</colgroup>
                        <tbody>
                            <tr>
                                <th>사용여부</th>
                                <td>
	                                <input class="checkbox-input" type="checkbox" id="checkbox1" name="" title="사용" value="a">
				                    <label class="checkbox-inline" for="checkbox1">사용</label>
                                </td>
                                <th>권한명</th>
                                <td>
	                                <input type="text" id="name" name="name" title="" class="form-control" value="">
                                </td>
                                <th>권한설명</th>
                                <td>
	                                <input type="text" id="name" name="name" title="" class="form-control" value="">
                                </td>
                            </tr>
                            <tr>
                                <th rowspan="3">금액</th>
                                <td>
	                                3개월
                                </td>
                                <td colspan="2">
	                                <input type="text" id="name" name="name" title="" class="form-control" value="">
                                </td>
                                <th>사용여부</th>
                                <td>
	                                <input class="checkbox-input" type="checkbox" id="checkbox1" name="" title="사용" value="a">
				                    <label class="checkbox-inline" for="checkbox1">사용</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
	                                6개월
                                </td>
                                <td colspan="2">
	                                <input type="text" id="name" name="name" title="" class="form-control" value="">
                                </td>
                                <th>사용여부</th>
                                <td>
	                                <input class="checkbox-input" type="checkbox" id="checkbox1" name="" title="사용" value="a">
				                    <label class="checkbox-inline" for="checkbox1">사용</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
	                                12개월
                                </td>
                                <td colspan="2">
	                                <input type="text" id="name" name="name" title="" class="form-control" value="">
                                </td>
                                <th>사용여부</th>
                                <td>
	                                <input class="checkbox-input" type="checkbox" id="checkbox1" name="" title="사용" value="a">
				                    <label class="checkbox-inline" for="checkbox1">사용</label>
                                </td>
                            </tr>
                             <tr>
                                <th>
	                                서비스 지역
                                </th>
                                <td colspan="5">
	                                <input type="text" id="name" name="name" title="" class="form-control" value="">
                                </td>
                            </tr>
                        </tbody>                            
                    </table>
                </div>
                
                <h2 class="h2">등급 권한 상세</h2>
                <div class="table_wrap">
                    <table class="table_info">
						<colgroup>
							<col style="width:7%">
							<col style="width:10%">
							<col style="width:auto">
							<col style="width:10%">
							<col style="width:10%">
							<col style="width:10%">
							<col style="width:10%">
							<col style="width:10%">
						</colgroup>
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th>메뉴 이름</th>
                                <th>메뉴 설명</th>
                                <th>읽기 권한</th>
                                <th>작성 권한</th>
                                <th>수정 권한</th>
                                <th>삭제 권한</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
	                                1
                                </td>
                                <td>XXXX</td>
                                <td class="subject">XXXXXXXXXXXXX</td>
                                <td>
	                                <input class="checkbox-input" type="checkbox" id="checkbox1" name="" title="선택" value="a">
	                                <input class="checkbox-input" type="checkbox" id="checkbox1" name="" title="선택" value="a">
	                            </td>
                                <td>
	                                <input class="checkbox-input" type="checkbox" id="checkbox1" name="" title="선택" value="a">
	                                <input class="checkbox-input" type="checkbox" id="checkbox1" name="" title="선택" value="a">
	                            </td>
                                <td>
	                                <input class="checkbox-input" type="checkbox" id="checkbox1" name="" title="선택" value="a">
	                                <input class="checkbox-input" type="checkbox" id="checkbox1" name="" title="선택" value="a">
	                            </td>
                                <td>
	                                <input class="checkbox-input" type="checkbox" id="checkbox1" name="" title="선택" value="a">
	                                <input class="checkbox-input" type="checkbox" id="checkbox1" name="" title="선택" value="a">
	                            </td>
                                <td>
	                                <input class="checkbox-input" type="checkbox" id="checkbox1" name="" title="선택" value="a">
	                                <input class="checkbox-input" type="checkbox" id="checkbox1" name="" title="선택" value="a">
	                            </td>
                            </tr>
                        </tbody>                            
                    </table>
                </div>
	            
			
                    <div class="board_btm">
                        <div class="btns_area fl_r mo_block">
                            <a href="#" class="btn btn-default">수정</a>
                            <a href="#" class="btn btn-primary">저장</a>
							<a href="#" class="btn btn-secondary">취소</a>
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
