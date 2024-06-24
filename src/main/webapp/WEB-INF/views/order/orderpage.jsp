<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html xmlns:th="http://www.thymeleaf.org">
<html>
<head>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/address_input.js"></script>
<script type="text/javascript">
var recipientInfo = {
        recipient: "${recipientInfo.recipient}",
        phoneNumber: "${recipientInfo.phoneNumber}",
        address: "${recipientInfo.address}",
        detailAddress: "${recipientInfo.detailAddress}",
        zipCode:  "${recipientInfo.zipCode}",
        deliveryMemo : "${recipientInfo.deliveryMemo}"
    };

document.addEventListener("DOMContentLoaded", function() {
	
    var addressElement = document.querySelector('.address-details');
    if (recipientInfo.address && recipientInfo.address.trim() !== "") {
        addressElement.textContent = recipientInfo.address;
        if (recipientInfo.zipCode && recipientInfo.zipCode.trim() !== "") {
            addressElement.textContent += " (" + recipientInfo.zipCode + ")";
        }
    } else {
        addressElement.textContent = "배송지 정보를 입력해주세요";
    }
});
</script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/css/order.css">
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
            url: "/setOrderInfoForPay",
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
					<div id="address-display">
						<div class="buttons-container">
							<button class="edit-button" onclick="toggleEditMode()">수정하기</button>
						</div>
						<p class="recipient-name">${recipientInfo.recipient}</p>
						<p class="phone-number">${recipientInfo.phoneNumber}</p>
						<p class="address-details">${recipientInfo.address} ${recipientInfo.detailAddress} (${recipientInfo.zipCode})</p>

					</div>
					<div id="address-edit" style="display: none;">
						<div class="button-group">
							<button class="save-button" onclick="saveRecipientInfo()">저장하기</button>
							<button class="cancel-button" onclick="toggleEditMode()">취소하기</button>
						</div>
						<div class="input-group">
							<input type="text" class="recipient-name-edit"
								id="edit-recipient" value="${recipientInfo.recipient}">
							<input type="text" class="phone-number-edit"
								id="edit-phoneNumber" value="${recipientInfo.phoneNumber}">
							<div class="zip-code-container">
                    <input type="text" class="address-details-edit" id="address" value="${recipientInfo.address}">
                    <button class="zip-code-button" onclick="execDaumPostcode()">우편번호 찾기</button>
                </div>
							<input type="text" class="zip-code-edit" id="detailAddress" placeholder="상세주소를 입력해주세요"
								value="${recipientInfo.detailAddress}">
						</div>
					</div>
				
					<input type="text" class="delivery-memo" id="deliveryMemo"
						placeholder="배송 메모를 입력해주세요">
				</div>

				<script>
		        function toggleEditMode() {
		            var displayDiv = document.getElementById('address-display');
		            var editDiv = document.getElementById('address-edit');
		            if (displayDiv.style.display === 'none') {
		                displayDiv.style.display = 'block';
		                editDiv.style.display = 'none';
		                deliveryMemo.style.display = 'block'; 
		            } else {
		                displayDiv.style.display = 'none';
		                editDiv.style.display = 'block';
		                deliveryMemo.style.display = 'none';
		            }
		        }
		
		        function saveRecipientInfo() {
		            var recipient = document.getElementById('edit-recipient').value;
		            var phoneNumber = document.getElementById('edit-phoneNumber').value;
		            var fullAddress = document.getElementById('address').value;
		            var detailAddress = document.getElementById("detailAddress").value;
					
		            if (!detailAddress) {
		                alert("상세주소를 입력해주세요.");
		                return;
		            }
		            
		            // 정규표현식을 사용하여 주소와 우편번호 분리
		            var addressMatch = fullAddress.match(/(.*)\s\((\d{5})\)$/);
		            var address = addressMatch ? addressMatch[1] : fullAddress;
		            var zipCode = addressMatch ? addressMatch[2] : "";
		            
		            document.querySelector('.recipient-name').textContent = recipient;
		            document.querySelector('.phone-number').textContent = phoneNumber;
		            var addressElement = document.querySelector('.address-details');
		            addressElement.textContent = address + " " + detailAddress + " (" + zipCode + ")";
		            
		            recipientInfo.recipient = recipient;
		            recipientInfo.phoneNumber = phoneNumber;
		            recipientInfo.address = address;
		            recipientInfo.detailAddress = detailAddress;
		            recipientInfo.zipCode = zipCode;

		            console.log(address);
		            console.log("Updated recipientInfo:", recipientInfo);
		            toggleEditMode();
		        }
		    	</script>


				<h3>주문상품</h3>
				<c:forEach var="product"
					items="${sessionScope.orderDetailResponse.products}">
					<div class="board product">
						<img src="${path}/static/img/producTest.png" alt="상품 이미지"
							style="width: 20%; height: 100%; margin-right: 20px; padding: 5px">

						<div class="product-info">
							<div class="product-name-and-quantity">
								<p>${product.productName}</p>
								<p>
									<span>${product.orderQuantity}</span>개
								</p>
							</div>
							<c:choose>
								<c:when test="${product.orderPrice != product.productPrice}">
									<p>
										<span class="order-price">${product.orderPrice}원</span> <span
											class="product-price">${product.productPrice}원</span>
									</p>
								</c:when>
								<c:otherwise>
									<p>
										<span class="order-price">${product.orderPrice}원</span>
									</p>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</c:forEach>


				<div>
					<div class="total-amount">
						<p>총 주문금액:</p>
						<span class="total-price">${sessionScope.orderDetailResponse.totalOrderPrice}원</span>
					</div>
				</div>

				<h3>배송비</h3>
				<div class="board shipping-fee">
					<p class="shipping-price">${sessionScope.orderDetailResponse.shippingPrice}원</p>
					<p class="shipping-note">50,000원 이상 구매 시 무료배송</p>
				</div>
				<h3>포인트</h3>
				<div class="board points" data-total-points="${totalPoints}">
					<p>
						현재 <span id="totalPointsDisplay">${totalPoints}</span>P를 보유하고 계세요.
					</p>
					<div class="points-input-container">
						<input type="text" id="pointsInput" placeholder="포인트 입력">
						<button id="useAllPointsButton">전액 사용</button>
					</div>
				</div>

				<script>
        		// data-total-points 속성에서 totalPoints 값을 가져오기
        		const totalPoints = document.querySelector('.board.points').getAttribute('data-total-points');

        		// totalPoints 값을 HTML에 표시
        		document.getElementById('totalPointsDisplay').textContent = totalPoints;

        		// 전액 사용 버튼 클릭 이벤트 설정
		        document.getElementById('useAllPointsButton').addEventListener('click', function() {
		            document.getElementById('pointsInput').value = totalPoints;
		        });
        		
		     	// 입력 필드에서 실시간으로 값 확인
		        document.getElementById('pointsInput').addEventListener('input', function() {
		            const inputPoints = this.value;

		            // 숫자가 아닌 값이 입력되었는지 확인
		            if (!/^\d*$/.test(inputPoints)) {
		                alert("숫자만 입력 가능합니다.");
		                this.value = this.value.replace(/\D/g, ''); // 숫자가 아닌 문자 제거
		                return;
		            }

		            // 보유 포인트보다 큰 값이 입력되었는지 확인
		            if (parseInt(inputPoints) > totalPoints) {
		                alert("사용하려는 포인트가 보유 포인트보다 많습니다.");
		                this.value = ''; // 초과 입력 시 값을 초기화
		            }
		        });
		    </script>

				<h3>결제수단</h3>
				<div class="board payment-method">
					<label class="payment-option"> <input type="radio"
						name="payment" value="카카오페이 결제"> 카카오페이 결제
					</label>
					<hr>
					<label class="payment-option"> <input type="radio"
						name="payment" value="일반결제"> 일반결제
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

	<script>
        function formatPrice(price) {
            return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
        }

        document.addEventListener("DOMContentLoaded", function() {
            var priceElements = document.querySelectorAll("[class*='price']");
            priceElements.forEach(function(priceElement) {
                var price = parseInt(priceElement.textContent.replace(/[^0-9]/g, ''), 10);
                priceElement.textContent = formatPrice(price) + '원';
            });
        });
    </script>
</body>
</html>
