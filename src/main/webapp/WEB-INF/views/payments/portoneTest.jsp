
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<meta charset="UTF-8">
<!-- jQuery -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>

	function getProductInfo() {
	    var firstProductName = $(".productName").first().text();
	    var productCount = $(".productName").length;
	    return {
	        firstProductName: firstProductName,
	        productCount: productCount
	    };
	}
	
	function getPoint() {
	    var point = $(".point").text();
	   
	    return {
	    	point: point
	    };
	}
	
	function kakaoPay() {
        requestPay('kakaopay.TC0ONETIME', 'kakaopay', '${path}/payments/kakaoPay');
    }

    function cardPay() {
        requestPay('html5_inicis.INIpayTest', 'card', '${path}/payments/creditCard');
    }

	var IMP = window.IMP;
	IMP.init("imp22804754");

	var today = new Date();
	var hours = today.getHours(); // 시
	var minutes = today.getMinutes(); // 분
	var seconds = today.getSeconds(); // 초
	var milliseconds = today.getMilliseconds();
	var makeMerchantUid = hours + minutes + seconds + milliseconds;

	function requestPay(pg, payMethod, url) {
		alert("requestpay시작!!");
		$.ajax({
            url: "/buyerOrderInfo",
            method: "GET",
            contentType: "application/json",
            dataType: "json",
            success: function(responseData) {
                // 백엔드에서 받은 데이터를 사용하여 결제 요청
                IMP.request_pay({
                    pg: pg
                    pay_method: payMethod,
                    merchant_uid: "IMP" + makeMerchantUid,
                    name: responseData.productName,
                    amount: responseData.totalAmount,
                    buyer_email: responseData.recipientInfo.userEmail,
                    buyer_name: responseData.recipientInfo.recipient,
                    buyer_tel: responseData.recipientInfo.phoneNumber,
                    buyer_addr: responseData.recipientInfo.address,
                    buyer_postcode: responseData.recipientInfo.zipcode
                }, function(rsp) {
			if (rsp.success) {
				//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
				jQuery.ajax({
					url : url, //cross-domain error가 발생하지 않도록 주의해주세요
					type : 'POST',
					dataType : 'json',
					data : {
						imp_uid : rsp.imp_uid
					//기타 필요한 데이터가 있으면 추가 전달
					}
				}).done(function(data) {
					//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
					if (everythings_fine) {
						var msg = '결제가 완료되었습니다.';
						msg += '\n고유ID : ' + rsp.imp_uid;
						msg += '\n상점 거래ID : ' + rsp.merchant_uid;
						msg += '\결제 금액 : ' + rsp.paid_amount;
						msg += '카드 승인번호 : ' + rsp.apply_num;

						alert(msg);
					} else {
						//[3] 아직 제대로 결제가 되지 않았습니다.
						//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
					}
				});
			} else {
				var msg = '결제에 실패하였습니다.';
				msg += '에러내용 : ' + rsp.error_msg;

				alert(msg);
			}
		});
	}
</script>
<meta charset="UTF-8">
<title>Sample Payment</title>
</head>
<body>
	<button onclick="kakaoPay()">카카오페이 결제하기</button>
	<button onclick="cardPay()">일반 결제하기</button>
	결제하기 버튼 생성
</body>
</html>