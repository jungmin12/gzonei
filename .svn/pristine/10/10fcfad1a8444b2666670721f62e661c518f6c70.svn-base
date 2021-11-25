<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<title>(주)지존</title>
<meta name="robots" content="index,follow">
<meta name="author" content="(주)지존 ">
<meta name="keywords" content="토지보상, 부동산개발정보, 아너스클럽">
<meta name="description" content="토지보상, 부동산개발정보, 아너스클럽" />
<meta name="copyright" content="copyright (c) Gzone Corp. All rights reserved.">
<meta property="og:title" content="(주)지존" />
<meta property="og:type" content="(주)지존" />
<meta name="og:description" content="토지보상, 부동산개발정보, 아너스클럽" />
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="shortcut icon" type="image/x-icon" href="<c:url value='/css/gzonei/SRC/images/common/favicon.ico' />">
<link rel="apple-touch-icon-precomposed" href="<c:url value='/css/gzonei/SRC/images/common/favicon.png' />">
<link rel="stylesheet" href="<c:url value='/css/gzonei/SRC/pcms/common/css/common.css' />" />
<link rel="stylesheet" href="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/bootstrap/bootstrap.min.css' />" />
<link rel="stylesheet" href="<c:url value='/css/gzonei/SRC/pcms/common/font/font_gothic.css' />" media="all">
<link rel="stylesheet" href="<c:url value='/css/gzonei/SRC/pcms/common/font/font_gmarketsans.css' />" media="all">

<link rel="stylesheet" href="<c:url value='/css/gzonei/SRC/css/acego.header.css' />" />
<link rel="stylesheet" href="<c:url value='/css/gzonei/SRC/css/acego.layout_map.css' />" />
<link rel="stylesheet" href="<c:url value='/css/gzonei/SRC/css/acego.footer.css' />" />
<link rel="stylesheet" href="<c:url value='/css/gzonei/SRC/css/acego.prog.css' />" />
<link rel="stylesheet" href="<c:url value='/css/gzonei/SRC/css/acego.content_map.css' />" />

<script type="text/javascript"	src="<c:url value='/js/gzonei/map/sweetalert.min.js' />"></script>
<script src="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/jQuery/jquery-3.3.1.min.js' />"></script>
<script src="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/jQuery/jquery-migrate-1.4.1.min.js' />"></script>
<script src="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/jQueryUI/jquery-ui.min.js' />"></script>
<script src="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/bootstrap/bootstrap.min.js' />"></script>
<script src="<c:url value='/css/gzonei/SRC/pcms/common/js/acego.common.js' />"></script>
<script src="<c:url value='/css/gzonei/SRC/js/common.js' />"></script>

<!--[if lt IE 9]>
    <script src="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/html5/html5shiv.min.js' />"></script>
<![endif]-->

<script src="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/print/jQuery.print.min.js' />"></script>
<script>
(function(){
    $("[data-print=print]").on('click', function() {
        $("#txt").print({
            globalStyles : true,
            mediaPrint : false,
            iframe : true,
            noPrintSelector : ".avoid-this",
        });
     });
}());
$(document).ready(function(){
    $(document,window).bind("scroll",gnbFix);
    
    $.datetimepicker.setLocale('ko');
    $("#startDate,#endDate").datetimepicker({
        timepicker : false,
        format : 'Y-m-d',
        scrollMonth : false,
        scrollInput : false,
        validateOnBlur: false,
        onShow:function(){
        	var end = $("#endDate").val();
        	var start = $("#startDate").val();
        	this.setOptions({
    	      dateFormat: 'Y-m-d',
    	      maxDate: end? end : false,
    	      minDate: start? start : false
    	    })
    	  }
    }).on('keydown', function(event){
    	onlyNum(this,event);
		});
    
    var orderType = $('#orderType').val();
 	if (orderType != '' && orderType != null) {
           $('#orderType').val(orderType);
            $('#orderType').siblings('.selected').text($('#orderType option:selected').text());
       }
    

});

function goSearct_order() {
	var f = document.searchForm;
	var orderType = $('#orderType').val();
 	f.orderType.value=orderType;
 	f.submit();
 }
 
function goSearct_number() {
	var f = document.searchForm;
	var orderType = $('#numberType').val();
 	f.orderType.value=orderType;
 	f.submit();
 }

function openModal(num){
	if(1==num){
		$('[data-ly-target="modal-map1"]').modal('show');
	}else if(2==num){
		$('[data-ly-target="modal-map2"]').modal('show');
	}else if(3==num){
		$('[data-ly-target="board__gongmae"]').modal('show');
	}else if(4==num){
		$('[data-ly-target="board__reward"]').modal('show');
	}else if(5==num){
		$('[data-ly-target="objectInfo"]').modal('show');
	}
}
</script>

<link rel="stylesheet" href="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/jQueryDatepicker/jquery.datetimepicker.min.css' />">
<script src="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/jQueryDatepicker/jquery.datetimepicker.full.min.js' />"></script>
<script src="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/CustomSelect/jquery.design-selectbox.js' />"></script>

<!--엑셀 다운로드 JS -->
<script language="javascript" src="<c:url value='/js/gzonei/xlsx.full.min.js' />"></script>
<script language="javascript" src="<c:url value='/js/gzonei/FileSaver.min.js' />"></script>
<script language="javascript" src="<c:url value='/js/gzonei/excel.js' />"></script>
<link href="<c:url value='/css/gzonei/SRC/js/mCustomScrollbar/jquery.mCustomScrollbar.css' />" rel="stylesheet" type="text/css" /> 
<link rel="stylesheet" href="<c:url value='/css/gzonei/SRC/css/map/style.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value='/js/gzonei/map/ol.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/js/gzonei/map/ol3-layerswitcher.css' />" />
<script type="text/javascript" src="<c:url value='/js/gzonei/map/ol-debug.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/gzonei/map/ol-ext.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/gzonei/map/ol3-layerswitcher.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/gzonei/map/proj4.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/gzonei/map/epsg.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/gzonei/map/jspdf.min.js'/>"></script>
<script type="text/javascript" src="//openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=rrmdnvnov0&submodules=panorama,geocoder,drawing,visualization"></script>
<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=effad4d17be3943669dbae719f538667&libraries=services"></script> -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=effad4d17be3943669dbae719f538667&libraries=services"></script>
<script src="//maps.googleapis.com/maps/api/js?key=AIzaSyBIwzALxUPNbatRBj3Xi1Uhp0fFzwWNBkE" async></script>
<script src="<c:url value='/css/gzonei/SRC/js/mCustomScrollbar/jquery.mCustomScrollbar.concat.min.js' />"></script> 
<%-- <script src="<c:url value='/css/gzonei/SRC/js/map/app.js' />"></script> --%>
<script src="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/CustomSelect/jquery.design-selectbox.js' />"></script>

<!-- 2021-05 퍼블리싱 수정 -->
<link rel="stylesheet" href="<c:url value='/css/podo_ext.css' />" />
