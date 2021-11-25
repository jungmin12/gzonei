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
                <h2 class="page__title">유용한사이트</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="<c:url value='/adisvc/recsroomBbsList.do'/> ">부가서비스</a></li>
                        <li class="n3"><a href="<c:url value='/design/usfulSiteView.do'/>" class="navi_ov">유용한사이트</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>  
        
            <div id="txt">
            <!-- content 영역입니다. -->

                <div class="sub0703_wrap">
                    <h2 class="h2">공사</h2>
                    <ul class="inner2">
                    	<li>
                            <a href="https://www.lh.or.kr/index.do" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/0703_img15.jpg" alt="LH 한국토지주택공사 로고"></em></a>
                        </li>
                    </ul>
					<div style="height: 0px;"><hr></div>    
                    <ul class="inner2">
                    	<h2 class="h2" >도시공사</h2>
                        <li>
                        	<a href="https://www.i-sh.co.kr/main/index.do" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/0703_img14.jpg" alt="서울주택도시공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="http://www.gh.or.kr/" target="_blank"> <em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070301_img02.jpg" alt="경기주택도시공사 로고"></em></a>
                        </li>
                        <li>
                            <a href="https://www.ih.co.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070301_img03.jpg" alt="인천도시공사 로고"></em></a>
                        </li>
                        <li>
                            <a href="https://www.duco.or.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070301_img04.jpg" alt="대구도시공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="https://www.dcco.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070301_img05.jpg" alt="대전도시공사 로고"></em></a>
                        </li>
                        <li>
                            <a href="https://www.bmc.busan.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070301_img06.jpg" alt="부산도시공사 로고"></em></a>
                        </li>
                        <li>
                            <a href="https://www.umca.co.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070301_img07.jpg" alt="울산도시공사 로고"></em></a>
                        </li>
                        <li>
                            <a href="http://www.gmcc.co.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070301_img08.jpg" alt="광조광역시도시공사 로고"></em></a>
                        </li>
                    </ul>
					<div style="height: 0px;"><hr></div>    
                    <ul class="inner2">
                    	<h2 class="h2" >지방공사</h2>
                        <li>
                        	<a href="https://www.gdco.co.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070302_img01.jpg" alt="강원도개발공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="https://www.cndc.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070302_img02.jpg" alt="충남개발공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="http://www.cbdc.co.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070302_img03.jpg" alt="충북개발공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="https://www.jndc.co.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070302_img04.jpg" alt="전남개발공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="http://www.jbdc.co.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070302_img05.jpg" alt="전북개발공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="http://www.gndc.co.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070302_img06.jpg" alt="경상남도개발공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="https://www.gbdc.co.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070302_img07.jpg" alt="경상북도개발공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="https://www.jpdc.co.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070302_img08.jpg" alt="제주특별자치도개발공사 로고"></em></a>
                        </li>
                    </ul>
					<div style="height: 0px;"><hr></div>    
                    <ul class="inner2">
                    	<h2 class="h2" >기초지자체 공사</h2>
                        <li>
                        	<a href="https://www.gcuc.or.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070303_img01.jpg" alt="과천도시공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="https://www.gmuc.co.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070303_img02.jpg" alt="광명도시공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="http://www.guriuc.or.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070303_img03.jpg" alt="구리도시공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="https://gunpouc.or.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070303_img04.jpg" alt="군포도시공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="ttps://www.guc.or.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070303_img05.jpg" alt="김포도시공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="https://ghdc.or.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070303_img06.jpg" alt="김해시도시개발공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="https://www.ncuc.or.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070303_img07.jpg" alt="남양주도시공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="https://www.best.or.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070303_img08.jpg" alt="부천도시공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="http://www.isdc.co.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070303_img09.jpg" alt="성남도시개발공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="https://www.suwonudc.co.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070303_img10.jpg" alt="수원도시공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="https://www.shsi.or.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070303_img11.jpg" alt="시흥도시공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="https://www.ansanuc.net/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070303_img12.jpg" alt="안산도시공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="https://www.auc.or.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070303_img13.jpg" alt="안양도시공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="https://www.yp21.go.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070303_img14.jpg" alt="양평도시공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="https://www.ygpa.or.kr/kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070303_img15.jpg" alt="여수광양항만공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="https://www.yuc.co.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070303_img16.jpg" alt="용인도시공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="http://www.uuc.or.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070303_img17.jpg" alt="의왕도시공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="https://cfmc.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070303_img18.jpg" alt="창녕군개발공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="https://www.cuc.or.kr/companyCI.do" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070303_img19.jpg" alt="춘천도시공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="https://www.puc.or.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070303_img20.jpg" alt="평택도시공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="https://www.pcuc.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070303_img21.jpg" alt="포천도시공사ㅣ로고"></em></a>
                        </li>
                        <li>
                        	<a href="http://www.huic.co.kr/www/index.do" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070303_img22.jpg" alt="하남도시공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="http://www.halc.co.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070303_img23.jpg" alt="함안지방공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="https://www.hsuco.or.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070303_img24.jpg" alt="화성도시공사 로고"></em></a>
                        </li>
                    </ul>
					<div style="height: 0px;"><hr></div>    
                    <ul class="inner2">
                    	<h2 class="h2" >기타 공사</h2>
                        <li>
                        	<a href="https://www.kwater.or.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070304_img01.jpg" alt="한국수자원공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="https://www.ekr.or.kr/" target="_blank"><em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070304_img02.jpg" alt="한국농어촌공사 로고"></em></a>
                        </li>
                        <li>
                        	<a href="https://kto.visitkorea.or.kr/" target="_blank"> <em class="logo"><img src="/css/gzonei/SRC/images/contents/sub07/070304_img03.jpg" alt="한국관광공사 로고"></em></a>
                        </li>
                    </ul>
                    
                    <h2 class="h2">정부/공공기관</h2>
                    <ul class="inner">
                        <li>
                        	<a href="https://www.courtauction.go.kr/" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img01.jpg'/>" alt="대한민국 법원 법원경매정보 로고" /></em></a>
                            <span class="tit">대법원경매</span>
                        </li>
                        <li>
                        	<a href="http://www.iros.go.kr/PMainJ.jsp" target="_blank"> <em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img02.jpg'/>" alt="대한민국 법원 인터넷등기소 로고" /></em></a>
                            <span class="tit">대법원 인터넷등기소</span>
                        </li>
                        <li>
                            <a href="https://scourt.go.kr/portal/information/events/search/search.jsp" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img04.jpg'/>" alt="대법원 로고" /></em></a>
                            <span class="tit">대법원사건검색</span>
                        </li>
                        <li>
                        	<a href="https://www.onbid.co.kr/op/dsa/main/main.do" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img05.jpg'/>" alt="원스탑 자산처분시스템 온비드 로고" /></em></a>
                            <span class="tit">온비드공매</span>
                        </li>
                        <li>
                            <a href="http://www.molit.go.kr/" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img06.jpg'/>" alt="국토교통부 로고" /></em></a>
                            <span class="tit">국토교통부</span>
                        </li>
                        <li>
                            <a href="http://www.realtyprice.kr/notice/main/mainBody.htm" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img07.jpg'/>" alt="국토교통부 로고" /></em></a>
                            <span class="tit">부동산 공시지가 알리미</span>
                        </li>
                        <li>
                            <a href="http://www.eum.go.kr​" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img08.jpg'/>" alt="토지e음 로고" /></em></a>
                            <span class="tit">토지이음</span>
                        </li>
                        <li>
                            <a href="http://app1.kab.co.kr:8082/stat001.html" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img09.jpg'/>" alt="SEE REAL 로고" /></em></a>
                            <span class="tit">지가변동률</span>
                        </li>
                        <li>
                            <a href="https://seereal.lh.or.kr/main.do" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img10.jpg'/>" alt="SEE REAL 로고" /></em></a>
                            <span class="tit">SEE:REAL</span>
                        </li>
                        <li>
                            <a href="http://www.nsdi.go.kr/lxportal/?menuno=2679" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img44.jpg'/>" alt="국가공간정보포털 로고" /></em></a>
                            <span class="tit">국가공간정보포털</span>
                        </li>
                        <li>
                        	<a href="http://kras.gg.go.kr/" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img48.jpg'/>" alt="부동산정보 통합열람​ 로고" /></em></a>
                            <span class="tit">부동산정보 통합열람​</span>
                        </li>
                        <li>
                        	<a href="https://www.gov.kr/portal/main" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img12.jpg'/>" alt="정부24 로고" /></em></a>
                            <span class="tit">전자민원G4C</span>
                        </li>
                        <li>
                            <a href="https://gwanbo.go.kr/main.do" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img13.jpg'/>" alt="대한민국 전자관보 로고" /></em></a>
                            <span class="tit">전자관보</span>
                        </li>
<!--                         <li> -->
<%--                             <a href="https://www.lh.or.kr/index.do" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img15.jpg'/>" alt="LH 한국토지주택공사 로고" /></em></a> --%>
<!--                             <span class="tit">LH공사</span> -->
<!--                         </li> -->
<!--                         <li> -->
<%--                             <a href="https://www.i-sh.co.kr/main/index.do" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img14.jpg'/>" alt="SH서울주택도시공사 로고" /></em></a> --%>
<!--                             <span class="tit">SH공사</span> -->
<!--                         </li> -->
                        <li>
                            <a href="http://fez.go.kr/global/index.do" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img45.jpg'/>" alt="Korean Free Economic Zone 로고" /></em></a>
                            <span class="tit">대한민국 경제자유구역</span>
                        </li>
                        <li>
                            <a href="https://www.saemangeum.go.kr/sda/main.do" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img46.jpg'/>" alt="새만금개발청 로고" /></em></a>
                            <span class="tit">새만금개발청</span>
                        </li>
                        <%-- 
                        <li>
                            <em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img15.jpg'/>" alt="LH 한국토지주택공사 로고" /></em>
                            <span class="tit">한국토지주택공사</span>
                        </li>
                         --%>
                    </ul>
                    <h2 class="h2">지방자치단체</h2>
                    <ul class="inner">
                        <li>
                            <a href="https://www.seoul.go.kr/main/index.jsp" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img16.jpg'/>" alt="서울특별시 로고" /></em></a>
                        </li>
                        <li>
                            <a href="https://www.sejong.go.kr/index.jsp" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img17.jpg'/>" alt="세종시 로고" /></em></a>
                        </li>
                        <li>
                            <a href="https://www.busan.go.kr/open/index.jsp" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img18.jpg'/>" alt="부산광역시 로고" /></em></a>
                        </li>
                        <li>
                            <a href="https://www.daegu.go.kr/index.do" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img19.jpg'/>" alt="대구광역시 로고" /></em></a>
                        </li>
                        <li>
                            <a href="https://www.incheon.go.kr/intro/index" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img20.jpg'/>" alt="인천광역시 로고" /></em></a>
                        </li>
                        <li>
                            <a href="https://www.gwangju.go.kr/index.do?S=S01" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img21.jpg'/>" alt="광주광역시 로고" /></em></a>
                        </li>
                        <li>
                            <a href="https://www.daejeon.go.kr/intro_main.jsp" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img22.jpg'/>" alt="대전광역시 로고" /></em></a>
                        </li>
                        <li>
                            <a href="https://www.ulsan.go.kr/u/rep/main.ulsan" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img23.jpg'/>" alt="울산광역시 로고" /></em></a>
                        </li>
                        <li>
                            <a href="https://www.gg.go.kr/" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img24.jpg'/>" alt="경기도 로고" /></em></a>
                        </li>
                        <li>
                            <a href="http://www.provin.gangwon.kr/gw/portal" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img25.jpg'/>" alt="강원도 로고" /></em></a>
                        </li>
                        <li>
                            <a href="https://www.chungbuk.go.kr/intro/index.html" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img26.jpg'/>" alt="충청북도 로고" /></em></a>
                        </li>
                        <li>
                            <a href="http://www.chungnam.go.kr/" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img27.jpg'/>" alt="충청남도 로고" /></em></a>
                        </li>
                        <li>
                            <a href="https://www.jeonbuk.go.kr/index.jeonbuk" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img28.jpg'/>" alt="전라북도 로고" /></em></a>
                        </li>
                        <li>
                            <a href="https://www.jeonnam.go.kr/" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img29.jpg'/>" alt="전라남도 로고" /></em></a>
                        </li>
                        <li>
                            <a href="https://www.gb.go.kr/Main/index.html" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img30.jpg'/>" alt="경상북도 로고" /></em></a>
                        </li>
                        <li>
                            <a href="https://www.gyeongnam.go.kr/intro.html" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img31.jpg'/>" alt="경상남도 로고" /></em></a>
                        </li>
                        <li>
                            <a href="https://www.jeju.go.kr/corona19.jsp" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img32.jpg'/>" alt="제주도 로고" /></em></a>
                        </li>
                    </ul>
                    <%-- 
                    <h2 class="h2">정부/공공기관</h2>
                    <ul class="inner">
                        <li>
                            <em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img33.jpg'/>" alt="ifez 인천 경제자유구역 로고" /></em>
                            <span class="tit">인천 경제자유구역청</span>
                        </li>
                        <li>
                            <em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img34.jpg'/>" alt="BJFEZ 부산진해 경제자유구역청 로고" /></em>
                            <span class="tit">부산진해 경제자유구역청</span>
                        </li>
                        <li>
                            <em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img35.jpg'/>" alt="황해 경제자유구역청 로고" /></em>
                            <span class="tit">황해 경제자유구역청</span>
                        </li>
                        <li>
                            <em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img36.jpg'/>" alt="SGFEZ 로고" /></em>
                            <span class="tit">새만금 경제자유구역청</span>
                        </li>
                        <li>
                            <em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img37.jpg'/>" alt="GFEZ 광양만권 경제자유구역청 로고" /></em>
                            <span class="tit">광양만권 경제자유구역청</span>
                        </li>
                        <li>
                            <em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img38.jpg'/>" alt="DGFEZ 대구경북 경제자유구역청 로고" /></em>
                            <span class="tit">대구경북 경제자유구역청</span>
                        </li>
                        <li>
                            <em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img39.jpg'/>" alt="충북 경제자유구역청 로고" /></em>
                            <span class="tit">충북 경제자유구역청</span>
                        </li>
                        <li>
                            <em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img40.jpg'/>" alt="efez 동해안권 경제자유구역청 로고" /></em>
                            <span class="tit">동해안권 경제자유구역청</span>
                        </li>
                    </ul>
                     --%>
                        <%-- 
                    <h2 class="h2">기타 정보업체</h2>
                    <ul class="inner">
                        <li>
                            <a href="http://www.kar.or.kr/pinfo/brokersearchNew.asp" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img41.jpg'/>" alt="KAR 한국공인중개사협회 로고" /></em></a>
                            <span class="tit">중개사무소검색</span>
                        </li>
                        <li>
                            <a href="https://www.nongji114.com/" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img42.jpg'/>" alt="농지114 로고" /></em></a>
                            <span class="tit">농지114</span>
                        </li>
                        <li>
                            <a href="https://map.kakao.com/?index.jsp" target="_blank"><em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img43.jpg'/>" alt="kakao map 로고" /></em></a>
                            <span class="tit">다음지도</span>
                        </li>
                        <li>
                            <em class="logo"><img src="<c:url value='/css/gzonei/SRC/images/contents/sub07/0703_img47.jpg'/>" alt="서울신문 로고" /></em>
                            <span class="tit">서울신문</span>
                        </li>
                    </ul>
                         --%>
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
