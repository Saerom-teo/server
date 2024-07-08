<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html xmlns:th="http://www.thymeleaf.org">
<html>
<head>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/vars.css">
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/address_input.js"></script>
<script type="text/javascript">

var recipientInfo = {
        recipient: "${recipientInfo.recipient}",
        phoneNumber: "${recipientInfo.phoneNumber}",
        address: "${recipientInfo.address}",
        detailAddress: "${recipientInfo.detailAddress}",
        zipCode:  "${recipientInfo.zipCode}",
        deliveryMemo : "${recipientInfo.deliveryMemo}"
    };

var orderDetailResponse = {
        order: {
            orderCode: "${orderDetailResponse.order.orderCode}",
            orderDate: "${orderDetailResponse.order.orderDate}",
            orderStatus: "${orderDetailResponse.order.orderStatus}",
            userCode: "${orderDetailResponse.order.userCode}"
        },
        products: [
            <c:forEach var="product" items="${orderDetailResponse.products}" varStatus="status">
            {
                productCode: "${product.productCode}",
                productName: "${product.productName}",
                orderQuantity: "${product.orderQuantity}",
                productPrice: "${product.productPrice}",
                orderCode: "${product.orderCode}",
                orderPrice: "${product.orderPrice}",
                productImgUrl: "${product.productImgUrl}"
            }<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ],
        totalOrderPrice: "${orderDetailResponse.totalOrderPrice}",
        shippingPrice: "${orderDetailResponse.shippingPrice}"
    };

var firstProductName = orderDetailResponse.products[0].productName;
var restProductNames = orderDetailResponse.products.slice(1).map(function(product) {
    return product.productName;
}).join(', ');

var combinedString = firstProductName + (restProductNames.length > 0 ? ' 외 ' + (restProductNames.length - 1) + '건' : '');


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

	
	
	 
	var IMP = window.IMP;
	IMP.init("imp22804754");

	var today = new Date();
	var hours = today.getHours(); // 시
	var minutes = today.getMinutes(); // 분
	var seconds = today.getSeconds(); // 초
	var milliseconds = today.getMilliseconds();
	var makeMerchantUid = hours + minutes + seconds + milliseconds;

	function requestPay(pg, payMethod, url,amount) {
	  

	    const products = orderDetailResponse.products.map(product => ({
            productCode: product.productCode,
            orderQuantity: product.orderQuantity
        }));
	    
	 	
	    // 재고 확인 요청
	    $.ajax({
	        url: "${path}/payments/checkStock", // 재고 확인을 위한 엔드포인트
	        method: "POST",
	        contentType: "application/json",
	        dataType: "json",
	        data: JSON.stringify(products),
	        success: function(stockResponse) {
	        	
	            if (stockResponse.stockAvailable) {
	                // 재고가 충분한 경우 결제 요청 처리
	                IMP.request_pay({
	                    pg: pg,
	                    pay_method: payMethod,
	                    merchant_uid: "IMP" + makeMerchantUid,
	                    name: combinedString,
	                    amount: amount,
	                    buyer_email: "tjtpfks@gmail.com",
	                    buyer_name: recipientInfo.recipient,
	                    buyer_tel: recipientInfo.phoneNumber,
	                    buyer_addr: recipientInfo.address,
	                    buyer_postcode: recipientInfo.zipcode

	                
	                }, function(rsp) {
	                    if (rsp.success) {
	                    	alert("결제성공!");
	                    	var orderStatus = "PAYMENT_COMPLETED";
	                    	var usedPoints = document.getElementById('usedPoints').textContent.replace('P', '');
	                
	                    	var recipientName = document.querySelector('.recipient-name').textContent;
	                        var phoneNumber = document.querySelector('.phone-number').textContent;
	                        var address = document.querySelector('.address-details').textContent;
	                        var deliveryMemo = document.querySelector('.delivery-memo').value;
	                        
	                    	var paymentData = {
	                                orderStatus: orderStatus,
	                                usedPoints: usedPoints,
	                               	recipientName: recipientName,
	                                phoneNumber: phoneNumber,
	                                address: address,
	                                deliveryMemo:deliveryMemo 
	                            };
	                    	
				            $.ajax({
				                url: '${path}/order/paymentSuccess',
				                type: 'POST',
				                contentType: 'application/json;  charset=UTF-8',
				                data: JSON.stringify(paymentData),
				                success: function(result) {
				                    
				                   window.location.href = `${path}/order/afterOrder?status=success`; 
				                },
				                error: function(xhr, status, error) {
				                  
				                    window.location.href = `${path}/order/afterOrder?status=fail`; 
				                }
				            });
	                    } else {
	                        // 결제 실패 처리
	                        
	                        var orderStatus = "PAYMENT_FAILED";

				            $.ajax({
				                url: '${path}/order/paymentFailure',
				                type: 'POST',
				                contentType: 'text/plain; charset=UTF-8',
				                data: orderStatus,
				                success: function(result) {
				                	window.location.href = `${path}/order/afterOrder?status=fail`; 
				                },
				                error: function(xhr, status, error) {
				                	window.location.href = `${path}/order/afterOrder?status=fail`; 
				                }
				            });
	                        var msg = '결제에 실패하였습니다.';
	                        msg += rsp.error_msg;
	                        alert(msg);
	                        
	                        
	                        
	                    }
	                });
	            } else {
	                // 재고 부족 시 알림
	                alert("재고부족으로 인해 주문에 실패했습니다.");
	                window.location.href = "${path}/basket";
	            }
	        },
	        error: function(xhr, status, error) {
	            alert("재고 확인 중 오류가 발생했습니다.");
	            window.location.href = "${path}/basket";
	            
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
						<p class="address-details">${recipientInfo.address}
							${recipientInfo.detailAddress} (${recipientInfo.zipCode})</p>

					</div>
					<div id="address-edit" style="display: none;">
						<div class="button-group">
							<button class="save-button" onclick="saveRecipientInfo()">저장하기</button>
							<button class="cancel-button" onclick="toggleEditMode()">취소하기</button>
						</div>
						<div class="input-group">
							<input type="text" placeholder="수령인" class="recipient-name-edit"
								id="edit-recipient" value="${recipientInfo.recipient}">
							<input type="text" placeholder="전화번호( '-' 포함 )" class="phone-number-edit"
								id="edit-phoneNumber" value="${recipientInfo.phoneNumber}">
							<div class="zip-code-container">
								<input type="text" placeholder="주소" class="address-details-edit" id="address"
									value="${recipientInfo.address}">
								<button class="zip-code-button" onclick="execDaumPostcode()">우편번호
									찾기</button>
							</div>
							<input type="text" class="zip-code-edit" id="detailAddress"
								placeholder="상세주소를 입력해주세요"
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
					
		            if (!recipient || !phoneNumber || !fullAddress || !detailAddress) {
		                alert("배송지 정보를 모두 입력해주세요.");
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

		            toggleEditMode();
		        }
		    	</script>


				<h3>주문상품</h3>
				<c:forEach var="product"
					items="${sessionScope.orderDetailResponse.products}">
					<div class="board product">
						<img src="productImgUrl" alt="상품 이미지"
							style="width: 20%; height: 100%; margin-right: 20px; padding: 5px">

						<div class="product-info">
							<div class="product-name">
								<p>${product.productName}</p>
								
							</div>
							<div class="product-quantity">
								<p> 수량 : ${product.orderQuantity}개
							</div>
							<c:choose>
								<c:when test="${product.orderPrice != product.productPrice}">
									<p>
										<span class="order-price">${product.orderPrice*product.orderQuantity}원</span> <span
											class="product-price">${product.productPrice*product.orderQuantity}원</span>
									</p>
								</c:when>
								<c:otherwise>
									<p>
										<span class="order-price">${product.orderPrice*product.orderQuantity}원</span>
									</p>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</c:forEach>


				<div>
					<div class="total-amount">
						<p>주문금액:</p>
						<span class="total-price">${orderDetailResponse.totalOrderPrice}원</span>
					</div>
				</div>

				<h3>배송비</h3>
				<div class="board shipping-fee">
					<p class="shipping-price">${orderDetailResponse.shippingPrice}원</p>
					<p class="shipping-note">50,000원 이상 구매 시 무료배송</p>
				</div>
				<h3>포인트</h3>
				<div class="board points" data-total-points="${totalPoints}">
					<p>
						현재 <span id="totalPointsDisplay">${totalPoints}</span>P를 보유하고 계세요.
					</p>
					<div class="points-input-container">
						<input type="text" id="pointsInput" placeholder="포인트 입력">
						<button class="useAllPointsButton", id="useAllPointsButton">전액 사용</button>
					</div>
				</div>

				<script>
        		// data-total-points 속성에서 totalPoints 값을 가져오기
        		const totalPoints = document.querySelector('.board.points').getAttribute('data-total-points');

        		// totalPoints 값을 HTML에 표시
        		document.getElementById('totalPointsDisplay').textContent = totalPoints;

        		document.getElementById('pointsInput').addEventListener('input', function() {
        	        var inputPoints = parseInt(this.value);

        	        // 숫자가 아닌 값이 입력되었는지 확인
        	        if (!/^\d*$/.test(inputPoints)) {
        	            alert('숫자만 입력 가능합니다.');
        	            this.value = this.value.replace(/\D/g, ''); // 숫자가 아닌 문자 제거
        	            return;
        	        }

        	        // 보유 포인트보다 큰 값이 입력되었는지 확인
        	        var totalPoints = parseInt(document.querySelector('.board.points').getAttribute('data-total-points'));
        	        if (inputPoints > totalPoints) {
        	            alert('사용하려는 포인트가 보유 포인트보다 많습니다.');
        	            this.value = ''; // 초과 입력 시 값을 초기화
        	            return;
        	        }

        	        // 결제 상세 내역 업데이트 호출
        	        updatePaymentDetails(inputPoints);
        	    });

        	    // 전액 사용 버튼 클릭 이벤트 설정
        	    document.getElementById('useAllPointsButton').addEventListener('click', function() {
        	        var totalPoints = parseInt(document.querySelector('.board.points').getAttribute('data-total-points'));
        	        document.getElementById('pointsInput').value = totalPoints;

        	        // 결제 상세 내역 업데이트 호출
        	        updatePaymentDetails(totalPoints);
        	    });
		    </script>

				<h3>결제수단</h3>
				<div class="board payment-method">
					<label class="payment-option"> <input type="radio"
						name="payment" value="카카오페이">  <img src="${path}/static/img/kakaopay_payment.png" style="width:10%; height: auto;" alt="카카오페이 결제"> 
					</label>
					<hr>
					<label class="payment-option"> <input type="radio"
						name="payment" value="페이코"> <img src="${path}/static/img/payco_payment.png" style="width:10%; height: auto;" alt="페이코 결제"> 
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

					<p>
						총 주문금액 <span id="totalPaymentAmount" class="totalpaymentprice">${orderDetailResponse.totalOrderPrice}원</span>
					</p>

				</div>

				<h3>사용한 포인트</h3>
				<div class="board point-details">

					<p>
						포인트 <span id="usedPoints">0P</span>
					</p>
				</div>


				<button class="pay-button" onclick="pay()">원 결제하기</button>
				<button class="order-cancel-button" onclick="cancel()">주문 취소</button>
				
			</div>
		</div>

	</main>
	
	<script>
	
	
	   
		function formatPrice(price) {
	        return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	    }
	
		var totalOrderPrice = "${orderDetailResponse.totalOrderPrice}";
	    var shippingPrice = "${orderDetailResponse.shippingPrice}";
	    // 계산된 총 결제 금액 설정
	    var totalPaymentAmount = parseInt(totalOrderPrice) + parseInt(shippingPrice);
	    var totalPaymentAmountFormatted = formatPrice(totalPaymentAmount);
	    document.getElementById('totalPaymentAmount').textContent = totalPaymentAmountFormatted + "원";
	    var payButton = document.querySelector('.pay-button');
	    payButton.textContent = totalPaymentAmountFormatted + '원 결제하기';
	    
	    
	    function updatePaymentDetails(usedPoints) {
	    	
	    	
	        // 여기서 사용한 포인트 업데이트
	        var usedPointsSpan = document.getElementById('usedPoints');
	        usedPointsSpan.textContent = usedPoints + 'P';
	
	
	        // 총 결제 금액 업데이트
	        var totalPaymentAmount = parseInt('${orderDetailResponse.totalOrderPrice}') + parseInt('${orderDetailResponse.shippingPrice}');
	        var totalPaymentAfterPoints = totalPaymentAmount - usedPoints;
	        var formattedTotalPaymentAfterPoints = formatPrice(totalPaymentAfterPoints);
	
	        // 결제 버튼의 금액 업데이트
	        var payButton = document.querySelector('.pay-button');
	        payButton.textContent = formattedTotalPaymentAfterPoints + '원 결제하기';
	    }
	
	    function checkAddressModification() {
	    	var addressElement = document.querySelector('.address-details');
	    	var recipientElement = document.querySelector('.recipient-name');
	    	var phoneElement = document.querySelector('.phone-number');
	        
	        if (!addressElement) {
	            alert("주소 요소를 찾을 수 없습니다. 페이지 구조를 확인해주세요.");
	            return false;
	        }
	
	        var addressText = addressElement.textContent.trim();
	        var recipientText = recipientElement.textContent.trim();
	        var phoneText = phoneElement.textContent.trim();
	        
	     
	        
	        if (addressText === "" || addressText === "배송지 정보를 입력해주세요" || recipientText === "" || phoneText === "") {
	        	
				return false;
	        }
	        
	        
	        return true;
	    }
	
	    
		function pay() {
			
			var payButton = document.querySelector('.pay-button');
			
			if (!checkAddressModification()) {
				alert("모든 배송지 정보를 입력해주세요.");
	            return; 
	        }
	
			
	        var amountText = payButton.textContent;
	        var amount = parseInt(amountText.replace(/[^0-9]/g, ''));
	        var selectedPaymentMethodElement = document.querySelector('input[name="payment"]:checked');
	        
	        if (!selectedPaymentMethodElement) {
	            alert("결제수단을 선택해주세요.");
	            return;
	        }
	
	        var selectedPaymentMethod = selectedPaymentMethodElement.value;
	    
	
	        if (selectedPaymentMethod === "카카오페이") {
	            requestPay('kakaopay.TC0ONETIME', 'kakaopay', '${path}/payments/kakaoPay', amount);
	        } else if (selectedPaymentMethod === "일반결제") {
	            requestPay('html5_inicis.INIpayTest', 'card', '${path}/payments/creditCard', amount);
	        } else if (selectedPaymentMethod === "페이코") {
	            requestPay('payco.PARTNERTEST', 'payco', '${path}/payments/payco', amount);
	        }
	    }
	
		
		function cancel() {
			window.location.href = `${path}/order/afterOrder?status=cancel`; 
	       
	    }
	
        document.addEventListener("DOMContentLoaded", function() {
            var priceElements = document.querySelectorAll("[class*='price']");
            priceElements.forEach(function(priceElement) {
                var price = parseInt(priceElement.textContent.replace(/[^0-9]/g, ''), 10);
                priceElement.textContent = formatPrice(price) + '원';
            });
        });
        
        
      
    </script>
    </script>
</body>
</html>