<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang='ko' style="display: block !important;visibility: visible !important;">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<%@ include file="/WEB-INF/jsp/gzonei/layout/header.jsp" %>
</head>
<body style="display: block !important;visibility: visible !important;">
<%@ include file="/WEB-INF/jsp/gzonei/layout/top.jsp" %>
<!-- InnoPay 결제연동 스크립트(필수) -->
<script type="text/javascript" src="https://pg.innopay.co.kr/ipay/js/innopay-2.0.js" charset="utf-8"></script>
<!-- <script type="text/javascript" src="https://pg.innopay.co.kr/ipay/js/jquery-2.1.4.min.js"></script> -->
<script>
 $(document).ready(function(){
	 $("input[name='setleMnSeCode']").on('click',function(){	
		 var payMethod = $("input[name='setleMnSeCode']:checked").val();
		 if(payMethod == 'CM00250001'){
			 $("#bankNotice").attr("style","display:none");
			 $("#cardNotice").removeAttr("style");
		 } else{
			 $("#cardNotice").attr("style","display:none");
			 $("#bankNotice").removeAttr("style");
		 }
		 
	 });
	 
 });
/*********************************************************
 * 등급 클릭시 
 ******************************************************** */
 function fn_chkgoodsDtCd(sn){
	var gradAuthorSn = sn;
	$.ajax({
			type:"POST",
			url:"<c:url value='/mypage/selectGoodsCode.do' />",
			data:{"gradAuthorSn": gradAuthorSn },
			dataType:'json',
			async:false,
			success:function(result){
				$("#useMonth").html("");
				if(result != null){
					var html = "";
					for(var i =0; i<result.length; i++){	
						html += "<li>";
						html += "<input class='radio-input' type='radio' name='useMonthCo' id='useMonthCo"+i+"' value='"+result[i].gradAmountSn+"' onclick='javascript:fn_payInfo(this.value);'>";
						html += "<label class='radio-inline' for='useMonthCo"+i+"'>"+result[i].useMonthCo+"개월</label>";
						html += "</li>";''
					}
					$("#useMonth").append(html);
				}
			}
	});
	$("#payInfo").html("");
	$("#orderTit").html("");
	$("#orderGrad").html("");
	$("#orderAmount").html("");
	$("#payAmount").html("");
	$("#CalcAmountInDsc").html("");
	$("#cardlabel").attr('style','display:none;');
	$("#CM00250004").prop('checked',true);
	var payMethod = $("input[name='setleMnSeCode']:checked").val();
	 if(payMethod == 'CM00250001'){
		 $("#bankNotice").attr("style","display:none");
		 $("#cardNotice").removeAttr("style");
	 } else{
		 $("#cardNotice").attr("style","display:none");
		 $("#bankNotice").removeAttr("style");
	 }
}
/*********************************************************
  * 개월수 클릭시 
 ******************************************************** */
function fn_payInfo(sn){
	 	
	var gradAmountSn = sn;
		$.ajax({
			type:"POST",
			url:"<c:url value='/mypage/selectPayInfo.do' />",
			data:{"gradAmountSn": gradAmountSn },
			dataType:'json',
			async:false,
			success:function(result){
				$("#payInfo").html("");
				var html = "";
				$("#orderTit").html("");
				$("#orderGrad").html("");
				$("#orderAmount").html("");
				$("#payAmount").html("");
				$("#CalcAmountInDsc").html("");
				var goodsNm = result.goodsNm;
				var gN = goodsNm.split(" ");
				goodsNm = gN[0];
				if(result.srvcSeCode == "S001"){
					if(goodsNm.includes("골드")){
						$("#orderTit").html("전국 "+result.useMonthCo+"개월<span class='txt_blt03 state01'>"+goodsNm+"</span>");
					}else if(goodsNm.includes("실버")){
						$("#orderTit").html("전국 "+result.useMonthCo+"개월<span class='txt_blt03 state03'>"+goodsNm+"</span>");
					}else{
						$("#orderTit").html("전국 "+result.useMonthCo+"개월<span class='txt_blt03 state02'>"+goodsNm+"</span>");
					}
				}
				$("#orderGrad").html(result.goodsNm);
				
				var Amount = result.amount;
				Amount = Amount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				
				$("#orderAmount").html(Amount);
				$("#payAmount").html(Amount);
				$("#CalcAmountInDsc").html(Amount);
				
				Amount = Amount.replace(/,/gi,'');
				Amount = Number(Amount);
				//카드결제 추가
				if(Amount <= 1000000 ){
					$("#cardlabel").removeAttr('style');
					$("#CM00250004").removeAttr('checked');
				}else{
					$("#cardlabel").attr('style','display:none;');
					$("#CM00250004").prop('checked',true);
				}
				html += "<input type='hidden' name='goodsNm' value='"+result.goodsNm+"'>";
				html += "<input type='hidden' name='useMonthCo' value='"+result.useMonthCo+"'>";
				html += "<input type='hidden' name='gradAmountSn' value='"+result.gradAmountSn+"'>";	
				html += "<input type='hidden' name='setleAmount' value='"+result.amount+"'>";
				html += "<input type='hidden' name='srvcCode' value='"+result.srvcSeCode+"'>";
				if(result.srvcSeCode =="S001"){
					html += "<input type='hidden' name='setleDtls' value='전국 "+result.useMonthCo+"개월 "+goodsNm+"'>";
				}
				$("#payInfo").html(html);
			}
		});
}


/*********************************************************
 * 서비스 선택시
 ******************************************************** */
//  function fn_chkSrvcCd(srvcCode){
// 	 var useMonthCo = $("input[name='useMonthCo']:checked").val();
// 	 var goodsDetailCode = $("input[name='goodsDetailCode']:checked").val();
	 
// 	 if(($("input[name='goodsDetailCode']:checked").length > 0) &&($("input[name='useMonthCo']:checked").length > 0) ){
// 			console.log("코드:"+goodsDetailCode);
// 			console.log("개월수:"+useMonthCo+"개월");
// 			console.log("서비스코드:"+srvcCode);
// 			$.ajax({
// 				type:"POST",
// 				url:"<c:url value='/mypage/selectGoodsCode.do' />",
// 	 			data:{"goodsDetailCode": goodsDetailCode , "useMonthCo" : useMonthCo , "srvcCode" : srvcCode },
// 				dataType:'json',
// 				async:false,
// 				success:function(result){
// 					$("#payInfo").html("");
// 					var html = "";
// 					$("#orderTit").html("");
// 					$("#orderGrad").html("");
// 					$("#orderAmount").html("");
// 					$("#payAmount").html("");
// 					$("#CalcAmountInDsc").html("");
// 					var codeIdNm = result.codeIdNm;
// 					if(srvcCode == "S001"){
// 						if(codeIdNm.includes("골드")){						
// 							$("#orderTit").html("전국 "+useMonthCo+"개월<span class='txt_blt03 state01'>"+result.codeIdNm+"</span>");
// 						}else if(codeIdNm.includes("실버")){
// 							$("#orderTit").html("전국 "+useMonthCo+"개월<span class='txt_blt03 state03'>"+result.codeIdNm+"</span>");
// 						}else{
// 							$("#orderTit").html("전국 "+useMonthCo+"개월<span class='txt_blt03 state02'>"+result.codeIdNm+"</span>");
// 						}
// 					}
// 					$("#orderGrad").html(result.codeIdNm);
					
					
// 					html += "<input type='hidden' name='goodsCode' value='"+result.goodsCode+"'>";
// 					html += "<input type='hidden' name='goodsNm' value='"+result.goodsNm+"'>";
					
// 					$("#payInfo").html(html);
					
// 				}
// 	 			,error : function(e) {alert("데이터 조회에 실패하였습니다.\n관리자에게 문의바랍니다.");}
// 				,beforeSend:function(){
// 					//전송 전
// 			    }
// 			    ,complete:function(){
// 			        //전송 후
// 			    }
// 			});
// 		}
// }

 

/*********************************************************
* 결제 버튼 클릭
******************************************************** */
function fn_paymentReqst(){
	$("#PayMethod").remove();
	$("#MID").remove();
	$("#MerchantKey").remove();
	$("#ResultYN").remove();
	$("#ReturnURL").remove();
	$("#BuyerEmail").remove();
	var payMethod = $("input[name='setleMnSeCode']:checked").val();

	if("CM00250001" ==payMethod){
		var html = "";
		var urlAdres = getUrl();

		html += "<input type='hidden' id='PayMethod' name='PayMethod' value='CARD'>";
// 		html += "<input type='hidden' id='MID' name='MID' value='testpay01m'>";
		html += "<input type='hidden' id='MID' name='MID' value='pginfordem'>";
// 		html += "<input type='hidden' id='MerchantKey' name='MerchantKey' value='Ma29gyAFhvv/+e4/AHpV6pISQIvSKziLIbrNoXPbRS5nfTx2DOs8OJve+NzwyoaQ8p9Uy1AN4S1I0Um5v7oNUg=='>";
		html += "<input type='hidden' id='MerchantKey' name='MerchantKey' value='6wvGxxy2Xujd4x2iyzY1uFeadCX7osG26VrDt6Kh8eibCpk2g//Sm2cvv3yKcTTVDxBbSGkZB0nn0Ac2paHVKg=='>";
		html += "<input type='hidden' id='ResultYN' name='ResultYN' value='Y'>";
	    html += "<input type='hidden' id='ReturnURL' name='ReturnURL' value='"+urlAdres+"mypage/cardPayReqst.do'>";
	    html += "<input type='hidden' id='BuyerEmail' name='BuyerEmail' value=''>";
		$("#payInfo").append(html);
		
		
	}
	
	if($("input[name='goodsDetailCode']:checked").length < 1){
		Common.Dialog.alert({
            title: '결제/연장'
            ,content: '등급을 선택해주세요.'
        	,ok: function(){
        		return;
                console.log('확인 클릭');
            }
        });  
	}else if($("input[name='useMonthCo']:checked").length < 1){
		Common.Dialog.alert({
            title: '결제/연장'
            ,content: '기간을 선택해주세요.'
        	,ok: function(){
        		return;
                console.log('확인 클릭');
            }
        });
	}else if($("input[id='agree_confirm_1']:checked").length < 1){
		Common.Dialog.alert({
            title: '결제/연장'
            ,content: '서비스 이용 안내에 동의해주세요.'
        	,ok: function(){
        		return;
                console.log('확인 클릭');
            }
        });
	}else if($("input[id='agree_confirm_2']:checked").length < 1){
		Common.Dialog.alert({
            title: '결제/연장'
            ,content: '사업지구 안내에 동의해주세요.'
        	,ok: function(){
        		return;
                console.log('확인 클릭');
            }
        });
	}else if($("input[name='setleMnSeCode']:checked").length < 1 ){
		Common.Dialog.alert({
            title: '결제/연장'
            ,content: '결제수단을 선택해주세요.'
        	,ok: function(){
        		return;
                console.log('확인 클릭');
            }
        });
	}else if("CM00250001" ==payMethod){
		Common.Dialog.confirm({
	        title: '결제/연장',
            content: '해당 상품에 포함된 사업지구를 확인하셨나요?'
            ,ok: function(){
        		innopay.goPay({
        			//// 필수 파라미터
        			PayMethod: mypayFrm.PayMethod.value,		// 결제수단(CARD,BANK,VBANK,CARS,CSMS,DSMS,EPAY,EBANK)
        			MID: mypayFrm.MID.value,							// 가맹점 MID
        			MerchantKey:mypayFrm.MerchantKey.value,	// 가맹점 라이센스키
        			GoodsName:mypayFrm.goodsNm.value,		// 상품명
        			Amt:mypayFrm.setleAmount.value,							// 결제금액(과세)
//         			Amt:'100',
        			BuyerName:'${sessionScope.loginVO.userNm}',		// 고객명
        			BuyerTel:'${sessionScope.loginVO.mbtlnum}',				// 고객전화번호
        			BuyerEmail:mypayFrm.BuyerEmail.value,			// 고객이메일
        			ResultYN:mypayFrm.ResultYN.value,				// 결제결과창 출력유뮤
        	        Moid: mypayFrm.gradAmountSn.value,			// 가맹점에서 생성한 주문번호 셋팅
        			//// 선택 파라미터
        			ReturnURL:mypayFrm.ReturnURL.value,			// 결제결과 전송 URL(없는 경우 아래 innopay_result 함수에 결제결과가 전송됨)
//         			ReturnURL:mypayFrm.ReturnURL.value,			// 결제결과 전송 URL(없는 경우 아래 innopay_result 함수에 결제결과가 전송됨)
//        			ArsConnType:'02', 							///* ARS 결제 연동시 필수 01:호전환, 02(가상번호), 03:대표번호 */

//        			FORWARD:'',									// 결제창 연동방식 (X:레이어, 기본값)
//        			GoodsCnt:'',									// 상품갯수 (가맹점 참고용)
//        			MallReserved:'',								// 가맹점 데이터
//        			OfferingPeriod:'',								// 제공기간
//        			DutyFreeAmt:'',								// 결제금액(복합과세/면세 가맹점의 경우 금액설정)
//        			EncodingType:'utf-8',						// 가맹점 서버 인코딩 타입 (utf-8, euc-kr)
//        			MallIP:'',											// 가맹점 서버 IP
//        			UserIP:'',											// 고객 PC IP
//        			mallUserID:'',									// 가맹점 고객ID
//        			User_ID:'',										// Innopay에 등록된 영업사원ID
        			Currency:''										// 통화코드가 원화가 아닌 경우만 사용(KRW/USD)
        		  });	
            }
	        ,cancel : function(){
	        	return;
	        }
        });  	
	}else{
		 Common.Dialog.confirm({
		        title: '결제/연장',
	            content: '결제/연장 신청하시겠습니까?'
	            ,ok: function(){
	            	 var param = $("#mypayFrm").serialize();		
	        		 Common.Dialog.confirm({
	        			        title: '결제/연장',
	        		            content: '해당 상품의 사업지구를 확인하셨나요?'
	        		            ,ok: function(){
	        		            	$.ajax({
	        		            		cache:false,
	        		            		url:"<c:url value='/mypage/paymentReqst.do' />",
	        		            		type:"POST",
	        		            		data:param,
	        		            		dataType:'json',
	        		            		async:false,
	        		            		success:function(data){
	        		            			if(data.result == 1){
	        		            				location.href="<c:url value='/mypage/paymentReqstCompt.do'/>";
	        		            			}else{
	        		            				Common.Dialog.alert({
	        		                                title: '결제/연장'
	        		                                ,content: '결제/연장 신청 처리에 실패했습니다.'
	        		                            });
	        		            			}
	        		            			
	        		            		}
	        		            		,error : function(e) {alert("관리자에게 문의바랍니다.");}
	        		            		,beforeSend:function(){		
	        		        				//전송 전
	        		        				$('.wrap-loading').removeClass('display-none');	
	        		        		    }
	        		        		    ,complete:function(){
	        		        		        //전송 후
	        		        		    	$('.wrap-loading').addClass('display-none');
	        		        		    }
	        		            		
	        		            	});
	        		                
	        		    	}
	        			    ,cancel : function(){
	        			        	
	        			    }
	        		  });
	            }
		        ,cancel : function(){
		        	console.log("캔슬버튼 클릭 후 로그");
		        }
	        });   
		
	}



	
	
}
function innopay_result(data){
	var a = JSON.stringify(data);
	// Sample
	var mid = data.MID;					// 가맹점 MID
	var tid = data.TID;					// 거래고유번호
	var amt = data.Amt;					// 금액
	var moid = data.MOID;				// 주문번호
	var authdate = data.AuthDate;		// 승인일자
	var authcode = data.AuthCode;		// 승인번호
	var resultcode = data.ResultCode;	// 결과코드(PG)
	var resultmsg = data.ResultMsg;		// 결과메세지(PG)
	var errorcode = data.ErrorCode;		// 에러코드(상위기관)
	var errormsg = data.ErrorMsg;		// 에러메세지(상위기관)
	var EPayCl   = data.EPayCl;
	var name 	 = data.name;			//결제자 이름
	var fn_cd 	 = data.fn_cd;			//결제카드사 코드
	var fn_name  = data.fn_name;		//결제카드사명
	var acquCardCode = data.AcquCardCode; //매입사코드
	var acquCardName = data.AcquCardName; //매입사카드명
	var cardQuota	 = data.CardQuata;    //할부개월수
	var mallUserID   = data.mallUserID;  //가맹점 회원ID
	var goodsName    = data.GoodsName;   //상품명
	var buyerEmail   = data.BuyerEmail;  //구매자  email
	
	alert("["+resultcode+"]"+resultmsg);
}


</script>
<!-- 구현부 : S -->

<div id="body_layout">	

    <!-- layout -->
    <div class="body_wrap layout">      
			
		
<!-- contents -->
	<div id="contens" class="contents_wrap">
		<div id="location" class="title_wrap">
                <h2 class="page__title">결제/연장하기</h2>
                <!-- 유틸 시작 -->
                <div class="utile_wrap">
                    <!-- 로케이션 시작 -->
                    <ul class="location_wrap">
                        <li class="n1 navi_home"><a href="<c:url value='/main.do'/>">HOME</a></li>
                        <li class="n2"><a href="<c:url value='/mypage/modifyMyInfo.do'/>">마이페이지</a></li>
                        <li class="n3"><a href="<c:url value='/mypage/payReqst.do'/>" class="navi_ov">결제/연장하기</a></li>
                    </ul>                           
                    <!-- 로케이션 끝 -->
                    <!-- 프린트 시작 -->
                    <!-- 프린트 끝 -->
                </div>
                <!-- 유틸 끝 -->   
            </div>
			
			<div id="txt">
            <!-- content 영역입니다. -->				
				<div class="augment_wrap">
					<h2 class="h2">이용요금 안내</h2>
					<div class="payInfo n3">
						<div class="price_info exception n2">
							<strong class="title">실버</strong>
							<div class="inner">
								<div class="item">
									<div class="obj">
										<em>이코노미</em>
										<ul>
											<li>3개월<strong>77,000</strong></li>
											<li>6개월<strong>139,000</strong></li>
											<li>12개월<strong>250,000</strong></li>
										</ul>
									</div>
								</div>
								<div class="item">
									<div class="obj">
										<em>스페셜</em>
										<ul>
											<li>3개월<strong>110,000</strong></li>
											<li>6개월<strong>198,000</strong></li>
											<li>12개월<strong>356,000</strong></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
						
						<div class="price_info gold n3">
							<strong class="title">골드</strong>
							<div class="inner">
								<div class="item">
									<div class="obj">
										<em>이코노미</em>
										<ul>
											<li>3개월<strong>770,000</strong></li>
											<li>6개월<strong>1,386,000</strong></li>
											<li>12개월<strong>2,495,000</strong></li>
										</ul>
									</div>
								</div>
								<div class="item">
									<div class="obj">
										<em>비즈니스</em>
										<ul>
											<li>3개월<strong>1,848,000</strong></li>
											<li>6개월<strong>3,326,000</strong></li>
											<li>12개월<strong>5,987,000</strong></li>
										</ul>
									</div>
								</div>
								<div class="item">
									<div class="obj">
										<em>스페셜</em>
										<ul>
											<li>3개월<strong>1,100,000</strong></li>
											<li>6개월<strong>1,980,000</strong></li>
											<li>12개월<strong>3,564,000</strong></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
						<div class="price_info premium n2">
							<strong class="title">프리미엄</strong>
							<div class="inner">
								<div class="item">
									<div class="obj">
										<em>이코노미</em>
										<ul>
											<li>6개월<strong>9,300,000</strong></li>
											<li>12개월<strong>16,8020,000</strong></li>
										</ul>
									</div>
								</div>
								<div class="item">
									<div class="obj">
										<em>스페셜</em>
										<ul>
											<li>6개월<strong>18,700,000</strong></li>
											<li>12개월<strong>33,660,000</strong></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
					<span class="time">기준일 : 2021년 05월 20일, 부가세포함금액/원</span>
					<h2 class="h2">나의 이용요금 확인</h2>
					<div class="mypay-box">
					<div class="mypay">
						<div class="item">
							<div class="inner" style="overflow-y: scroll;height: 287px;">
								<strong>회원등급선택</strong>
								<ul>
									<c:forEach items="${gradCdList }" var="gradList" varStatus="status" >
									 <c:if test="${gradList.gradAuthorCode ne 'CM00200013' and gradList.gradAuthorCode ne 'CM00200014' and gradList.gradAuthorCode ne 'CM00200015'}">
										<li>
											<input class="radio-input" name="goodsDetailCode" type="radio" id="goodsDetailCode${status.count }" value="${gradList.gradAuthorSn }" onclick="javascript:fn_chkgoodsDtCd(this.value);">
											<label class="radio-inline" for="goodsDetailCode${status.count }">${gradList.gradAuthorNm }</label>
										</li>
									 </c:if>
									</c:forEach>
								</ul>
							</div>
						</div>
<!-- 						<div class="item" style="display:none;"> -->
<!-- 							<div class="inner" style="overflow-y: scroll;height: 287px;"> -->
<!-- 								<strong>서비스 선택</strong> -->
<!-- 								<ul> -->
<!-- 										<li> -->
<!-- 											<input class="radio-input" name="srvcCode" type="radio" id="srvcCode" value="S001" checked onclick="javascript:fn_chkSrvcCd(this.value);"> -->
<!-- 											<label class="radio-inline" for="srvcCode">전국</label> -->
<!-- 										</li> -->
									
<!-- 								</ul> -->
<!-- 							</div> -->
<!-- 						</div> -->
						<div class="item">
							<div class="inner" style="overflow-y: scroll;height: 287px;">
								<strong>기간 선택</strong>
								<ul id="useMonth">
<!-- 									<li> -->
<!-- 										<input class="radio-input" name="useMonthCo" type="radio" id="useMonthCo1"  value="3" onclick="javascript:fn_chkMonthCo(this.value);"> -->
<!-- 										<label class="radio-inline" for="useMonthCo1">3개월</label> -->
<!-- 									</li> -->
<!-- 									<li> -->
<!-- 										<input class="radio-input"  name="useMonthCo" type="radio" id="useMonthCo2" value="6" onclick="javascript:fn_chkMonthCo(this.value);"> -->
<!-- 										<label class="radio-inline" for="useMonthCo2">6개월</label> -->
<!-- 									</li> -->
<!-- 									<li> -->
<!-- 										<input class="radio-input"  name="useMonthCo" type="radio" id="useMonthCo3" value="12" onclick="javascript:fn_chkMonthCo(this.value);"> -->
<!-- 										<label class="radio-inline" for="useMonthCo3">12개월</label> -->
<!-- 									</li> -->
								</ul>
							</div>
						</div>
						<div class="item payfiner">
							<form name="mypayFrm" method="post" id="mypayFrm">
							<div style="display:none" id="payInfo">
							</div>
							<div class="inner">
								<div class="order_title">
									<h4 class="title" id="orderTit"></h4>
									<!-- <h4 class="title">전국 12개월<span class="txt_blt03 state02">프리미엄</span></h4> -->
									<!-- <h4 class="title">전국 12개월<span class="txt_blt03 state03">특별</span></h4> -->
									
									<div class="price_field">
										<dl>
											<dt>이용요금</dt>
											<dd><em class="number" id="orderAmount">0</em></dd>
										</dl>
									</div>
									<div class="price_field">
										<dl>
											<dt>결제금액</dt>
											<dd><em class="number" id="payAmount"> 0</em></dd>
										</dl>
									</div>
								</div>
								<div class="order_content">
									<div class="order_total_price">
										<h4 class="txt_price">결제 할 요금</h4>
										<span class="price"><em class="number" id="CalcAmountInDsc">0</em></span>
									</div>
									<div class="order_total_price">
										<h4 class="txt_price">결제방법</h4>
										<span class="price" id="price">
											<input class="radio-input" type="radio" id="CM00250001"   name="setleMnSeCode" value="CM00250001" >
											<label class="radio-inline" id="cardlabel" for="CM00250001" style="display:none">카드결제</label>
											<input class="radio-input" type="radio" id="CM00250004"   name="setleMnSeCode" value="CM00250004" checked>
											<label class="radio-inline" for="CM00250004">무통장입금</label>
										</span>
									</div>
								</div>
							</div>
							</form>
						</div>
					</div>
					</div>
					<p class="text-right" style="color:red;">※ 신용카드 결제는 1,000,000원 이하로 가능합니다.</p>
					
					<strong class="s-title txt-tip">서비스 이용요금 선택 시 꼭 확인해주세요!</strong>
					<ul>
						<li>- 한번 결제된 요금은 이용 중에 환불이 불가합니다.</li>
						<li>- 서비스가 만료되기 전 연장결제를 하실 경우, 이용중인 서비스가 끝나는 익일부터 새롭게 결제하신 내역으로 서비스가 시작됩니다.</li>
						<li>- 상품 결제전 등급별 적용되는 <a style="color:red;text-decoration: underline;" href="/design/chrgeGuidanceView.do">사업지구</a>를 확인해주세요.</li>
					</ul>
					<div id="bankNotice">
						<strong class="s-title txt-tip">무통장 입금안내</strong>
						<p>무통장 입금인 경우 즉시 정보이용이 불가능 하며 <em>입금 후 반드시 유선으로 요청</em>을 하셔야 정보를  이용하실 수 있습니다.  <em>입금 후 연락처 : 02-322-3152 </em>(평일 09:00 ~ 18:00)</p>
						<p>※ 서비스 기간은 요청을 받은 날로 부터 시작 합니다.</p>
						
						<div class="bank">
							<div class="item">
								<strong>입금계좌안내</strong>
								<em>예금주 : (주)전국개발정보지존</em>
							</div>
							<div class="item woori">
								<strong>우리은행</strong>
								<em>1005-002-840924</em>
							</div>
							<div class="item hana">
								<strong>하나은행</strong>
								<em>1005-002-840924</em>
							</div>
						</div>
					</div>
					<div id="cardNotice" style="display:none;">
						<strong class="s-title txt-tip">카드 결제안내</strong>
						<ul>
							<li>- 카드 결제인 경우 즉시 정보이용이 가능합니다. </li>
							<li>- 사용가능한 신용카드는 <em style="color:red;">국민, 삼성, 신한, 현대, 롯데, 하나, 농협</em>카드 입니다.</li>
							<li>- 신용카드 결제는 <em style="color:red;">1,000,000원 이하</em>로 가능합니다.</li>
							<li>-  카드 결제 관련 문의사항  <em>연락처 : 02-322-3152</em>(평일 09:00 ~ 18:00)</li>
						</ul>
					</div>
					<div class="ui_radio--custom">
				        <input type="checkbox" id="agree_confirm_1">
				        <label for="agree_confirm_1"><span class="chk_ball"></span>서비스 이용안내 내용을 확인하였으며 상기 내용에 동의합니다.</label>
				         <input type="checkbox" id="agree_confirm_2">
				        <label for="agree_confirm_2"><span class="chk_ball"></span>해당 상품에 포함되는 사업지구를 확인하였음에 동의합니다.</label>
				    </div>
					
					<div class="text-center">
				        <button type="button" class="btn btn-default" onclick="javascript:history.back();">취소</button>
				        <button type="button" class="btn btn-primary" onclick="javascript:fn_paymentReqst();">결제</button>
				    </div>
					
				</div>
				
            <!-- content 영역입니다. -->	
            </div>
            

			
</div>
<!-- contents -->	
    </div>
    <!-- layout -->
</div>

<!-- 구현부 : E -->

<%@ include file="/WEB-INF/jsp/gzonei/layout/footer.jsp" %>
</body>
</html>


