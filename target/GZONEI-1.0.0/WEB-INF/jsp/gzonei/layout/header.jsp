<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<title>전국개발정보 지존</title>
<meta name="robots" content="index,follow">
<meta name="author" content="전국개발정보 지존 ">
<meta name="keywords" content="토지보상, 부동산개발정보, 아너스클럽">
<meta name="description" content="토지보상, 부동산개발정보, 아너스클럽" />
<meta name="copyright" content="copyright (c) Gzone Corp. All rights reserved.">
<meta property="og:title" content="전국개발정보 지존" />
<meta property="og:type" content="전국개발정보 지존" />
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
<link rel="stylesheet" href="<c:url value='/css/gzonei/SRC/css/acego.layout.css' />" />
<link rel="stylesheet" href="<c:url value='/css/gzonei/SRC/css/acego.footer.css' />" />
<link rel="stylesheet" href="<c:url value='/css/gzonei/SRC/css/acego.prog.css' />" />
<link rel="stylesheet" href="<c:url value='/css/gzonei/SRC/css/acego.content.css' />" />


<link rel="stylesheet" href="<c:url value='/css/podo.css' />" />
<script type="text/javascript"	src="<c:url value='/js/gzonei/map/sweetalert.min.js' />"></script>

<!-- <script type="text/javascript" src="https://pg.innopay.co.kr/ipay/js/jquery-2.1.4.min.js"></script> -->
<script src="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/jQuery/jquery-3.3.1.min.js' />"></script>
<%-- <script src="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/jQuery/jquery-migrate-1.4.1.min.js' />"></script> --%>
<script src="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/jQueryUI/jquery-ui.min.js' />"></script>
<script src="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/bootstrap/bootstrap.min.js' />"></script>
<script src="<c:url value='/css/gzonei/SRC/pcms/common/js/acego.common.js' />"></script>
<script src="<c:url value='/css/gzonei/SRC/js/common.js' />"></script>
<script src="<c:url value='/js/gzonei/fileUtil.js' />"></script>
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
	
});
</script>

<link rel="stylesheet" href="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/jQueryDatepicker/jquery.datetimepicker.min.css' />">
<script src="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/jQueryDatepicker/jquery.datetimepicker.full.min.js' />"></script>
<script>
$(document).ready(function(){
	$(".btn__calendar").on('click', function() {	
		var nodeId = this.previousElementSibling.getAttribute("id");
		$("#"+nodeId).datetimepicker('show');
	});
    $.datetimepicker.setLocale('ko');
    $("#startDate").datetimepicker({
        timepicker : false,
        format : 'Y-m-d',
        scrollMonth : false,
        scrollInput : false,
        validateOnBlur: false,
        formatMask: function(format){
            return format
                .replace(/Y{4}/g, '9999')
                .replace(/Y{2}/g, '99')
                .replace(/M{2}/g, '19')
                .replace(/D{2}/g, '39')
                .replace(/H{2}/g, '29')
                .replace(/m{2}/g, '59')
                .replace(/s{2}/g, '59');
        },
        onShow:function(){
            var end = $("#endDate").val();
            var start = $("#startDate").val();
            this.setOptions({
              maxDate: end? end : false,
              dateFormat: 'Y-m-d'
              
            })
          }
    	
    }).on('keydown', function(event){
    	onlyNum(this,event);
	});
    
    $("#endDate").datetimepicker({
        timepicker : false,
        format : 'Y-m-d',
        scrollMonth : false,
        scrollInput : false,
        validateOnBlur: false,
        onShow:function(){
           // var end = $("#endDate").val();
            var start = $("#startDate").val();
            this.setOptions({
              minDate: start? start : false,
              dateFormat: 'Y-m-d'
             
            })
          }
    	
    }).on('keydown', function(event){
    	onlyNum(this,event);
		});
    
    
}); 
</script> 


<script src="<c:url value='/css/gzonei/SRC/pcms/common/pluigs/CustomSelect/jquery.design-selectbox.js' />"></script>
<script type="text/javascript">
	 function goSearct_order() {
		var f = document.searchForm;
		var orderType = $('#orderType').val();
	 	f.orderType.value=orderType;
	 	f.submit();
	 }
	$(document).ready(function(e) {
    	var orderType = $('#orderType').val();
     	if (orderType != '' && orderType != null) {
               $('#orderType').val(orderType);
                $('#orderType').siblings('.selected').text($('#orderType option:selected').text());
           }
	});	
</script>

<!--엑셀 다운로드 JS -->
<script language="javascript" src="<c:url value='/js/gzonei/xlsx.full.min.js' />"></script>
<script language="javascript" src="<c:url value='/js/gzonei/FileSaver.min.js' />"></script>
<script language="javascript" src="<c:url value='/js/gzonei/excel.js' />"></script>



