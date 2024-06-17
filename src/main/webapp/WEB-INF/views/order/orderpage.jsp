<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html xmlns:th="http://www.thymeleaf.org">
<html>
<head>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<meta charset="UTF-8">


<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Checkout Page</title>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/css/styles.css">
<!-- <link rel="stylesheet" href="styles.css"> -->
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
	
	function pay() {
        var selectedPaymentMethod = document.querySelector('input[name="payment"]:checked').value;
        if (selectedPaymentMethod === "카카오페이 결제") {
            requestPay('kakaopay.TC0ONETIME', 'kakaopay', '${path}/payments/kakaoPay');
        } else if (selectedPaymentMethod === "일반결제") {
            requestPay('html5_inicis.INIpayTest', 'card', '${path}/payments/creditCard');
        }
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

</head>
<body>
	<header>
		<h1>주문/결제</h1>
	</header>
	<main>
		<div class="section">
			<div class="left-section">
				<h3>배송지</h3>
				<div class="board address">

					<div>
						<p>성명지</p>
						<p>010-1234-5678</p>
						<p>서울특별시 강남구 영동대로 123 (청담동, 현대홈타운) 105-501 (105741)</p>
						<button>변경하기</button>
					</div>
				</div>
				<h3>주문상품</h3>
				<div class="board product">
					<div th:each="product : ${orderDetailResponse.products}">
						<img src="product-image.jpg" alt="상품 이미지">
						<div class="product-info">
							<p th:text="${product.productName}"></p>
							<p>
								수량: <span th:text="${product.orderQuantity}"></span>개
							</p>
							<p>
								단일 가격: <span th:text="${product.productPrice}"></span>원
							</p>
						</div>
					</div>
				</div>

				<div>
					<div class="total-amount">
						<p>
							총 주문금액: <span th:text="${orderDetailResponse.totalOrderPrice}"></span>원
						</p>
					</div>
				</div>

				<h3>배송비</h3>
				<div class="board shipping-fee">
					<p th:text="${orderDetailResponse.shippingPrice}"></p>
					원 (50,000원 이상 구매 시 무료)
				</div>
				<h3>포인트</h3>
				<div class="board points">

					<input type="text" placeholder="포인트 입력">
					<button>적용하기</button>
				</div>
				<h3>결제수단</h3>
				<div class="board payment-method">

					<label> <input type="radio" name="payment" value="카카오페이 결제">
						카카오페이 결제
					</label> <label> <input type="radio" name="payment" value="일반결제">
						일반결제
					</label>
				</div>
			</div>
			<div class="right-section">
				<h3>결제상세</h3>
				<div class="board payment-details">

					<p>일반 결제: 9,000원</p>

				</div>

				<h3>사용한 포인트</h3>
				<div class="board point-details">

					<p>사용한 포인트: 1,000P</p>
				</div>

				<div class="card summary">
					<button class="pay-button" onclick="pay()">8,000원 결제하기</button>
				</div>
			</div>
		</div>
	</main>
	<footer>
		<div class="footer-links">
			<p>이용약관</p>
			<p>개인정보 처리 방침</p>
			<p>전자금융거래약관</p>
		</div>
		<div class="footer-info">
			<p>상호명: (주)포트리스클라우드 | 주소: 서울특별시 강남구 영동대로 123 (청담동) 현대홈타운 105-501</p>
			<p>전화번호: 02-1234-5678 | 이메일: support@example.com</p>
		</div>
		<div class="footer-social">
			<img src="facebook-icon.png" alt="Facebook"> <img
				src="instagram-icon.png" alt="Instagram"> <img
				src="twitter-icon.png" alt="Twitter">
		</div>
	</footer>


</body>
</html>
