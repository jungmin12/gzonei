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
                <h2 class="page__title">요금 안내</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="<c:url value='/design/useGuidanceView.do'/>">서비스 안내</a></li>
                        <li class="n3"><a href="<c:url value='/design/chrgeGuidanceView.do'/>" class="navi_ov">요금 안내</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">
            <!-- content 영역입니다. -->

                <div class="sub0902_wrap">
                    <h2 class="h2">이용요금 안내</h2>
                    <ul class="list-1st">
                        <li>Gzone의 정보를 이용하기 위해서는 회원가입 및 결제를 하셔야 합니다.</li>
                        <li>이용요금은 회원등급과 이용기간에 따라 아래와 같은 요금제를 적용합니다.</li>
                        <li>결제하신 모든내역은 <strong>마이페이지>나의 결제내역</strong>에서 확인이 가능합니다.</li>
                    </ul>
                    <div class="member">
                        <div class="mem_inner mem_1">
                            <strong>실버</strong>
                            <ul class="box">
                                <li class="box_inner box_1">
                                    <p>이코노미</p>
                                    <div class="txt">
                                        <span class="txt_inner">3개월<em>77,000</em></span>
                                        <span class="txt_inner">6개월<em>139,000</em></span>
                                        <span class="txt_inner">12개월<em>250,000</em></span>
                                    </div>
                                </li>
                                <li class="box_inner box_2">
                                    <p>스페셜</p>
                                    <div class="txt">
                                        <span class="txt_inner">3개월<em>110,000</em></span>
                                        <span class="txt_inner">6개월<em>198,000</em></span>
                                        <span class="txt_inner">12개월<em>356,000</em></span>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="mem_inner mem_2">
                            <strong>골드</strong>
                            <ul class="box">
                                <li class="box_inner box_1">
                                    <p>이코노미</p>
                                    <div class="txt">
                                        <span class="txt_inner">3개월<em>770,000</em></span>
                                        <span class="txt_inner">6개월<em>1,386,000</em></span>
                                        <span class="txt_inner">12개월<em>2,495,000</em></span>
                                    </div>
                                </li>
                                <li class="box_inner box_2">
                                    <p>비즈니스</p>
                                    <div class="txt">
                                        <span class="txt_inner">3개월<em>1,848,000</em></span>
                                        <span class="txt_inner">6개월<em>3,326,000</em></span>
                                        <span class="txt_inner">12개월<em>5,987,000</em></span>
                                    </div>
                                </li>
                                <li class="box_inner box_3">
                                    <p>스페셜</p>
                                    <div class="txt">
                                        <span class="txt_inner">3개월<em>1,100,000</em></span>
                                        <span class="txt_inner">6개월<em>1,980,000</em></span>
                                        <span class="txt_inner">12개월<em>3,564,000</em></span>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="mem_inner mem_3">
                            <strong>프리미엄</strong>
                            <ul class="box">
                                <li class="box_inner box_1">
                                    <p>이코노미</p>
                                    <div class="txt">
                                        <span class="txt_inner">6개월<em>9,300,000</em></span>
                                        <span class="txt_inner">12개월<em>16,830,000</em></span>
                                    </div>
                                </li>
                                <li class="box_inner box_2">
                                    <p>스페셜</p>
                                    <div class="txt">
                                        <span class="txt_inner">6개월<em>18,700,000</em></span>
                                        <span class="txt_inner">12개월<em>33,660,000</em></span>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <p class="date">기준일 : 2021년 05월 20일​, 부가세 포함 금액(원)</p>
                    <h2 class="h2 pay">결제방법</h2>
                    <h3 class="h3">카드</h3>
                    <p class="p_txt pt1">- 카드 결제인 경우 즉시 정보이용이 가능합니다. </p>
                    <p class="p_txt pt1">- 사용가능한 신용카드는  <strong class="bold">국민, 삼성, 신한, 현대, 롯데, 하나, 농협</strong>카드 입니다.</p>
                    <p class="p_txt pt1">- 신용카드 결제는 <strong class="bold">1,000,000원 이하</strong>로 가능합니다</p>
                    <p class="p_txt pt1">-  카드 결제 관련 문의사항  <strong class="bold">연락처 : 02-322-3152</strong>(평일 09:00 ~ 18:00)</p>
                    <h3 class="h3">무통장 입금안내</h3>
                    <p class="p_txt pt1">무통장 입금인 경우 즉시 정보이용이 불가능 하며 <strong class="bold">입금 후 반드시 유선으로 요청</strong>을 하셔야 정보를 이용하실 수 있습니다.</p>
                    <p class="p_txt"><strong class="bold"> 입금 후 연락처 : 02-322-3152 </strong>(평일 09:00 ~ 18:00)</p>
                    <p>※ 서비스 기간은 요청을 받은 날로 부터 시작 합니다.</p>
                    <ul class="bank">
                        <li><em>입금계좌안내</em>예금주 : (주)지존</li>
                        <li><em><img src="<c:url value='/css/gzonei/SRC/images/contents/sub09/0902_img01.jpg'/>" alt="우리은행"></em><span>1005-002-840924</span></li>
                        <li><em><img src="<c:url value='/css/gzonei/SRC/images/contents/sub09/0902_img02.jpg'/>" alt="KEB하나은행"></em><span>373-910009-01404</span></li>
                    </ul>
                    <div>
                    <h2 class="h2 mem_info" style="display: inline-block;">회원등급별 정보이용범위</h2>
                    <span style="display: inline-block;margin-left: 10px;color: blue;font-weight: bold;">※ 기본정보 Ⅰ - 사업면적, 사업비, 사업기간 / 기본정보 Ⅱ - 시행사, 적용법률, 사업인정시점, 용지비</span>
                    </div>
                    <a href="#business" class="btn btn-default btn-create busi_btn"> 사업지구분류보기</a>
                    <div class="table-responsive mt_20 mem_table">
                        <table class="table table-bordered text-center">
                            <caption>테이블 안내 – 무료회원, 기업회원, 실버회원, 골드회원, 프리미엄회원 혜택 안내</caption>
                            <colgroup>
                                <col style="width: 10%">
                                <col style="width: 10%">
                                <col style="width: *">
                                <col style="width: 9%">
                                <col style="width: 9%">
                                <col style="width: 9%">
                            </colgroup>
                            <thead>
                                <tr class="mem_ser">
                                    <th scope="col" colspan="3">회원 등급별 서비스 제공 범위 및 내용​</th>
                                    <th scope="col" colspan="3">기간별 서비스 이용 요금/원​(부가세 포함금액)​</th>
                                </tr>
                                <tr class="mem_level">
                                    <th scope="col">기본등급</th>
                                    <th scope="col">세부등급</th>
                                    <th scope="col">서비스 제공 내용</th>
                                    <th scope="col">3개월</th>
                                    <th scope="col">6개월</th>
                                    <th scope="col">12개월</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <th scope="row" rowspan="2" class="mem_premium"><strong>프리미엄</strong></th>
                                    <td class="mem_premium">스페셜</td>
                                    <td>
                                        <ul class="list-1st mem_list">
                                            <li>프리미엄 이코노믹 회원 + 투자정보(편입 경, 공매물건) 모두 열람 가능</li>
<!--                                             <li>낙찰전례 + 보상전례 지도서비스 이용 가능</li> -->
                                            <li>전용서비스 'Call - in help desk' 이용 가능</li>
                                            <li>사전 가입심사로 인원(15명 이내) 제한</li>
                                        </ul>
                                    </td>
                                    <td>-</td>
                                    <td>18,700,000</td>
                                    <td>33,660,000</td>
                                </tr>
                                <tr>
                                    <td class="mem_premium">이코노미</td>
                                    <td>
                                        <ul class="list-1st mem_list">
                                            <li>골드 스페셜 회원 + 기타 사업지구 [Ⅱ] 포함한 모든 개발정보 상세정보 열람 가능</li>
<!--                                             <li>모든 개발정보의 '프리미엄 존' 열람 가능</li> -->
                                            <li>투자정보(편입 경, 공매물건) 열람 가능 (단, 감정가 1억원 이하 물건에 한함)</li>
                                            <li>e-book(기본내용+상세내용) 열람 가능</li>
                                            <li>게시판(자료실, 보상판례) 프리미엄 등급 열람 가능</li>
                                            <li>낙찰 전례 지도서비스 이용 가능</li>
                                        </ul>
                                    </td>
                                    <td>-</td>
                                    <td>9,300,000</td>
                                    <td>16,830,000</td>
                                </tr>
                                <tr>
                                    <th scope="row" rowspan="3" class="mem_gold"><strong>골드</strong></th>
                                    <td class="mem_gold">스페셜</td>
                                    <td>
                                        <ul class="list-1st mem_list">
                                            <li>골드 이코노미 회원 + 기타 사업지구 [Ⅰ] 개발정보 상세정보 열람 가능</li>
<!--                                             <li>기타사업지구 [Ⅱ] 개발정보 기본정보 열람 가능(단, 프리미엄 존 이용 불가)​</li> -->
                                            <li>Today`s 보상계획 공고 열람 가능​</li>
                                        </ul>
                                    </td>
                                    <td>1,100,000</td>
                                    <td>1,980,000</td>
                                    <td>3,564,000</td>
                                </tr>
                                <tr>
                                    <td class="mem_gold">비즈니스</td>
                                    <td>
                                        <ul class="list-1st mem_list">
                                            <li>골드 이코노미 회원 + 멀티 로그인(ID 당 동시접속 3개까지 가능) 허용</li>
                                        </ul>
                                    </td>
                                    <td>1,848,000</td>
                                    <td>3,326,000</td>
                                    <td>5,987,000</td>
                                </tr>
                                <tr>
                                    <td class="mem_gold">이코노미</td>
                                    <td>
                                        <ul class="list-1st mem_list">
                                            <li>실버 스페셜 회원 + 일반사업지구 [Ⅱ] 개발정보 상세정보 열람 가능</li>
<!--                                             <li>개발정보 '골드 존' 열람 가능</li> -->
                                            <li>기타사업지구[Ⅰ], [Ⅱ] 개발정보의 기본정보[Ⅱ] 열람 가능</li>
<!--                                             <li>개발정보의 향후 추진계획 및 대표주소 상세주소 열람 가능</li> -->
                                            <li>부가서비스(자료실+보상판례) 골드등급 열람 가능</li>
                                            <li>커뮤니티 Q&A게시판 글쓰기, 댓글 달기 가능</li>
                                        </ul>
                                    </td>
                                    <td>770,000</td>
                                    <td>1,386,000</td>
                                    <td>2,495,000</td>
                                </tr>
                                <tr>
                                    <th scope="row" rowspan="2" class="mem_basic"><strong>실버</strong></th>
                                    <td class="mem_basic">스페셜</td>
                                    <td>
                                        <ul class="list-1st mem_list">
                                            <li>실버 이코노미 회원 + 일반사업지구 [Ⅱ] 및 기타사업지구 [Ⅰ] , [Ⅱ]   개발정보 중 사업 주요 내용 열람 가능</li>
                                        </ul>
                                    </td>
                                    <td>110,000</td>
                                    <td>198,000</td>
                                    <td>356,000</td>
                                </tr>
                                <tr>
                                    <td class="mem_basic">이코노미</td>
                                    <td>
                                        <ul class="list-1st mem_list">
                                            <li>무료회원 서비스 + 일반사업지구[Ⅰ] 개발정보 상세정보 열람 가능</li>
                                            <li>일반사업지구 [Ⅱ] 및 기타사업지구 [Ⅰ] , [Ⅱ] 개발정보 중 기본정보[Ⅰ] 과 추진내역 중 (구역,지구,단지,결정) 고시 및 (사업시행, 지구계획, 개발계획, 실시계획 승인) 고시 열람 가능</li>
                                            <li>부가서비스(자료실+보상판례) 실버 등급 열람 가능</li>
                                            <li>커뮤니티 '칼럼' 열람 가능</li>
                                        </ul>
                                    </td>
                                    <td>77,000</td>
                                    <td>139,000</td>
                                    <td>250,000</td>
                                </tr>
                                <tr>
                                    <th scope="row" colspan="2" class="mem_basic"><strong>무료회원</strong></th>
                                    <td>
                                        <ul class="list-1st mem_list">
                                            <li>준공된 개발사업지구 개발정보 상세열람 가능 + 해당 투자정보(편입 경,공매물건) 보기</li>
                                            <li>무료샘플 및 사이트 활용법 이용 가능</li>
                                            <li>'우리 동네 개발사업이 궁금하세요' 이용 가능 (단, 일반사업지구[Ⅰ] [Ⅱ]의 기본정보[Ⅰ] 에 한함)</li>
                                            <li>커뮤니티 공지사항, 지존포커스, 토지보상 뉴스, 및 보도자료 열람 가능</li>
                                            <li>지존 스토어 e-book(기본내용) 열람 가능</li>
                                        </ul>
                                    </td>
                                    <td>-</td>
                                    <td>-</td>
                                    <td>-</td>
                                </tr>
                                <tr>
                                    <th scope="row" colspan="2" class="mem_basic"><strong>기업회원</strong></th>
                                    <td class="mem_deci">협의 후 결정(ID개수 및 정보제공 범위)<span>(동시접속이 가능한 ID 10개 이상이 필요한 건설사를 비롯한 <br>기업 및 금융권 등을 대상으로 제공되는 서비스)</span></td>
                                    <td>-</td>
                                    <td>-</td>
                                    <td>-</td>
                                </tr>
                            </tbody>
                        </table>                        
                    </div>
                    <div id="business"></div>
                    <h2 class="h2 busi_sort" id="busi_sort">사업지구 분류</h2>
                    <div class="list_box box1">
                        <h3 class="h3 busi_name">일반<span>사업지구(I)</span></h3>
                        <ul class="list-1st list_n1">
                            <li>공공주택지구</li>
                            <li>공공지원민간임대주택 공급촉진지구</li>
                            <li>기업형임대주택 공급촉진지구</li>
                            <li>택지개발예정지구</li>
                        </ul>
                        <ul class="list-1st list_n2">
                            <li>국민임대주택지구</li>
                            <li>행복주택지구</li>
                            <li>친수구역 조성사업</li>
                            <li>재정비 사업지구
                                <ul class="list-2st">
                                    <li>주거환경개선사업</li>
                                    <li>재정비촉진지구</li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                    <div class="list_box">
                        <h3 class="h3 busi_name">일반<span>사업지구(II)</span></h3>
                        <ul class="list-1st list_n1">
                            <li>산업단지(농공단지)</li>
                            <li>경제자유구역
                                <ul class="list-2st">
                                    <li>인천경제자유역</li>
                                    <li>부산진해경제자유구역</li>
                                    <li>광양만경제자유구역</li>
                                    <li>대구경북경제자유구역</li>
                                    <li>새만금경제자유구역</li>
                                    <li>경기경제자유구역</li>
                                    <li>충북경제자유구역</li>
                                    <li>동해안경제자유구역</li>
                                    <li>울산경제자유구역</li>
                                </ul>
                            </li>
                        </ul>
                        <ul class="list-1st list_n2">
                            <li>물류(유통)단지</li>
                            <li>관광지 조성사업</li>
                            <li>관광단지 조성사업</li>
                            <li>역세권개발사업</li>
                            <li>연구개발특구</li>
                            <li>투자선도지구</li>
                            <li>도시개발사업</li>
                        </ul>
                    </div>
                    <div class="list_box">
                        <h3 class="h3 busi_name">기타<span>사업지구(I)</span></h3>
                        <ul class="list-1st list_n1">
                            <li>발전소 건설사업</li>
                            <li>댐 건설사업</li>
                            <li>국방, 군사시설사업</li>
                            <li>법조타운신축 및 이전사업</li>
                        </ul>
                        <ul class="list-1st list_n2">
                            <li>하천 정비사업
                                <ul class="list-2st">
                                    <li>국가하천</li>
                                    <li>지방하천</li>
                                    <li>소하천</li>
                                </ul>
                            </li>
                            <li>공항 및 항만 건설사업
                                <ul class="list-2st">
                                    <li>공항 건설사업</li>
                                    <li>항만 건설사업</li>
                                </ul>
                            </li>
                        </ul>
                        <ul class="list-1st list_n3">
                            <li>철도건설사업
                                <ul class="list-2st">
                                    <li>철도건설사업</li>
                                    <li>역사신축 및 이전사업</li>
                                </ul>
                            </li>
                            <li>고속도로 및 고속화도로</li>
                            <li>국도 및 대체우회도로</li>
                            <li>지방도 및 대체우회도로</li>
                        </ul>
                        
                    </div>
                    <div class="list_box">
                        <h3 class="h3 busi_name">기타<span>사업지구(II)</span></h3>
                        <ul class="list-1st list_n1">
                            <li>장기미집행 도시계획시설
                                <ul class="list-2st">
                                    <li>도시계획 도로</li>
                                    <li>유원지</li>
                                    <li>운동장</li>
                                    <li>녹지</li>
                                    <li>광장</li>
                                    <li>자동차정류장</li>
                                    <li>공영차고지</li>
                                    <li>화물자동차휴게소</li>
                                    <li>복합환승센터</li>
                                    <li>학교</li>
                                    <li>공공청사</li>
                                    <li>기타</li>
                                </ul>
                            </li>
                            <li>특수사업지구
                                <ul class="list-2st">
                                    <li>미불용지</li>
                                    <li>기타</li>
                                </ul>
                            </li>
                        </ul>
                        <ul class="list-1st list_n2">
                        	<li>지구단위계획구역</li>
                            <li>성장관리방안</li>
                            <li>시가화예정용지</li>
                            <li>도시자연공원구역</li>
                        	<li>도시계획시설(예정지)
                                <ul class="list-2st">
                                    <li>도시계획 도로</li>
                                    <li>유원지</li>
                                    <li>운동장</li>
                                    <li>녹지</li>
                                    <li>광장</li>
                                    <li>자동차정류장</li>
                                    <li>공영차고지</li>
                                    <li>화물자동차휴게소</li>
                                    <li>복합환승센터</li>
                                    <li>학교</li>
                                    <li>공공청사</li>
                                    <li>기타</li>
                                </ul>
                            </li>
                            
                        </ul>
                        <ul class="list-1st list_n3">
                        	<li>도시공원 조성사업
                                <ul class="list-2st">
                                    <li>도시자연공원</li>
                                    <li>근린공원</li>
                                    <li>소공원</li>
                                    <li>어린이공원</li>
                                    <li>기타</li>
                                </ul>
                            </li>
                        	
                            <li>자연공원 조성사업
                                <ul class="list-2st">
                                    <li>국립공원 조성사업</li>
                                    <li>도립공원 조성사업</li>
                                    <li>군립공원 조성사업</li>
                                    <li>시립공원 조성사업</li>
                                    <li>구립공원 조성사업</li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                    <h2 class="h2 id_acce">ID 동시접속 제어안내</h2>
                    <ul class="guide_list">
                        <li>
                            <span class="ir ico1"></span>
                            <div class="txt">
                                <p>사이트 보안을 위해 1개 ID로 다수의 사용자가 동시에 로그인하여 사용할 경우(동일PC도 적용) 해당 ID에 대해 모두 자동 로그아웃되며 24시간 동안 로그인을 할 수 없도록 제한합니다.</p>
                            </div>
                        </li>
                        <li>
                            <span class="ir ico2"></span>
                            <div class="txt">
                                <p>단, 법인 회원의 경우 허용 동시접속자까지 동시접속이 가능하며 초과하는 경우 24시간 동안 로그인을 할 수 없도록 제한합니다.</p>
                            </div>
                        </li>
                        <li>
                            <span class="ir ico3"></span>
                            <div class="txt">
                                <p>사용하지 않을 경우 로그아웃을 해야 불이익을 피할 수 있으며, 페이지 갱신없이 (브라우저를 종료하는 등) 60분이 경과한 경우 자동 로그아웃이 됩니다.</p>
                            </div>
                        </li>
                    </ul>
                    <div class="mem_btn">
                        <button type="button" data-toggle="modal" class="btn btn-default btn-create join_btn" onclick="location.href='<%=request.getContextPath()%>/joinStep1.do'">회원가입</button>
                        <button type="button" data-toggle="modal" class="btn btn-primary btn-update" onclick="location.href='<%=request.getContextPath()%>/mypage/payReqst.do'">결제</button>
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
