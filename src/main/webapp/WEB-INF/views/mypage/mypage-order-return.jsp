<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/vars.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/mypage-collection.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/mypage-order.css">
    
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/static/icon/favicon.ico">
    <title>마이페이지 - 반품/환불 | 새롬터</title>
    
    <style>
		.item {
		    width: 100%;
		    border-radius: 20px;
		    display: flex;
		    padding: 30px 20px;
		    border: 1px solid #B9B7B7;
		    margin-bottom: 15px;
		    gap: 40px;
		    font-size: 14px;
		}		
		.item img {
			height: 90px;
    		width: 90px;
    		border-radius: 10px;
		}
		.item-checkbox {
			align-content: center;
		}
		.item-details {
			align-content: center;
			flex: 1;
		}
		.quantity-container {
			text-align: center;
			align-content: center;
		}
		.item-price {
			text-align: center;		
			align-content: center;
		}
		.item-price p{
			margin-top: 5px;
		}
		.quantity-controller {
			border: 1px solid var(--gray);
			display: flex;
			font-size: 12px;
			height: 22px;
			align-items: center;
			margin-top: 5px;
		}
		.quantity-controller div {
			padding: 0 7px;
			height: 100%;
		}
		.quantity-controller .controller-box {
			cursor: pointer;
		}
		.quantity-controller .quantity-box {
			border: solid var(--gray);
			border-width: 0 1px 0 1px;
			padding: 0 12px;
			width: 41px;
			text-align: center;
		}
		.v-line {
			border-left: 1px solid var(--gray);
			height: 100px;
		}
		.original-price {
			text-decoration: line-through;
		    color: var(--gray);
		    font-size: 12px;
		    margin: 0 5px;
		}
		
		.exchange-return-info {
			padding: 20px;
		}
		.exchange-return-info div {
			margin: 15px 0;
		}
		.exchange-return-info .return-type div {
			margin: 0;
			margin-right: 15px;
			font-size: 14px;
		}
		.exchange-return-info .return-type input {
			margin-right: 5px;
		}
		.exchange-return-info select {
			border: 1px solid var(--gray);
			width: 300px;
			padding: 5px;
		}
		.exchange-return-info textarea {
			border: 1px solid var(--gray);
			padding: 5px;
			width: 100%;
		}
		
		.exchange-info {
			display: flex;
			justify-content: center;
			gap: 40px;
		}
		.exchange-info div{
			display: flex;
			flex-direction: column;
			justify-content: center;
		}
		.exchange-info p{
			text-align: center;
			width: 100%;
			margin: 7px 0;
		}
		.exchange-info .text-con{
			font-size: 14px;
		}
		#result-cost {
			color: var(--primary);
		}
		.submit-div {
			margin: 40px 0;
			display: flex;
    		justify-content: center;
		}
		.submit-div button {
			background-color: var(--primary);
			color: #fff;
			padding: 13px 50px;
			border-radius: 10px;
		}

    </style>
    
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var currentPageId = "order";
            document.getElementById(currentPageId).classList.add("current-page");
        });
    </script>
	<script>
    document.addEventListener("DOMContentLoaded", function() {
        // 초기 수량 정보를 저장
        var initialQuantities = {};
        document.querySelectorAll(".quantity").forEach(function(quantityBox) {
            var productCode = quantityBox.id.split("-")[1];
            initialQuantities[productCode] = parseInt(quantityBox.textContent);
        });

        // 수량 변경 이벤트 리스너 등록
        document.querySelectorAll(".controller-box").forEach(function(controller) {
            controller.addEventListener("click", function() {
                var quantityBox = this.parentElement.querySelector(".quantity");
                var currentQuantity = parseInt(quantityBox.textContent);
                var productCode = quantityBox.id.split("-")[1];
                var initialQuantity = initialQuantities[productCode];

                if (this.id === "quantity-decrease") {
                    if (currentQuantity > 1) {
                        quantityBox.textContent = currentQuantity - 1;
                    }
                } else if (this.id === "quantity-increase") {
                    if (currentQuantity < initialQuantity) {
                        quantityBox.textContent = currentQuantity + 1;
                    }
                }

                // 상품금액 업데이트
                updateItemPrice(productCode);
                updateCancelCostSum();
            });
        });

        // 체크박스 이벤트 리스너 등록
        document.querySelectorAll(".item-select").forEach(function(checkbox) {
            checkbox.addEventListener("change", function() {
                updateCancelCostSum();
            });
        });

        function updateItemPrice(productCode) {
            var quantity = parseInt(document.getElementById(`quantity-\${productCode}`).textContent);
            var orderPrice = parseInt(document.querySelector(`#order-price-\${productCode}`).getAttribute("data-order-price"));
            var totalPrice = quantity * orderPrice;
            document.getElementById(`price-\${productCode}`).textContent = `\${totalPrice}원`;
        }

        function updateCancelCostSum() {
            var cancelCostSum = 0;
            document.querySelectorAll(".item-select:checked").forEach(function(checkbox) {
                var productCode = checkbox.getAttribute("data-index");
                var quantity = parseInt(document.getElementById(`quantity-\${productCode}`).textContent);
                var orderPrice = parseInt(document.querySelector(`#order-price-\${productCode}`).getAttribute("data-order-price"));
                cancelCostSum += quantity * orderPrice;
            });
            document.getElementById("cancel-cost-sum").textContent = `\${cancelCostSum}원`;

            var resultCost = cancelCostSum - 3000; // 추가 배송비 3000원
            document.getElementById("result-cost").textContent = `\${resultCost}원`;
        }

        // submit-button 클릭 이벤트 리스너 등록
        document.querySelector(".submit-button").addEventListener("click", function() {
            var selectedItems = [];
            document.querySelectorAll(".item-select:checked").forEach(function(checkbox) {
                var productCode = checkbox.getAttribute("data-index");
                var quantity = parseInt(document.getElementById(`quantity-\${productCode}`).textContent);
                selectedItems.push({
                    productCode: productCode,
                    quantity: quantity
                });
            });

            var requestData = {
                orderDate: "${orderDetailInquiry[0].orderDate}",
                orderCode: "${orderDetailInquiry[0].orderCode}",
                items: selectedItems,
                returnType: document.querySelector("input[name='chk-type']:checked") ? document.querySelector("input[name='chk-type']:checked").id : "",
                reason: document.getElementById("lang").value,
                message: document.getElementById("message").value,
                cancelCostSum: document.getElementById("cancel-cost-sum").textContent,
                resultCost: document.getElementById("result-cost").textContent
            };

            // 데이터 콘솔에 출력
            console.log('Request Data:', requestData);

            // AJAX 요청 보내기
            $.ajax({
                url: '특정_URL',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(requestData),
                success: function(response) {
                    alert('요청이 성공적으로 전송되었습니다.');
                    console.log('Success:', response);
                },
                error: function(error) {
                    console.error('Error:', error);
                }
            });
        });
    });
</script>


</head>

<body>
    <%@ include file="/WEB-INF/views/collection/header.jsp" %>
    <div class="wrapper">
        <%@ include file="/WEB-INF/views/common/mypage-nav.jsp" %>
        <div class="collection-content">
            <div class="collection-name">
                <h1>주문 상세 내역</h1>
            </div>
            <div id="detail-container">
				<div class="detail-info">
					<div><p>주문일자</p><a>${orderDetailInquiry[0].orderDate}</a></div>
					<div><p>주문번호</p><a>${orderDetailInquiry[0].orderCode}</a></div>
				</div>
				
				<div class="order-product">
					<p class="section-name">주문 상품</p>
					
					
					<div class="item-container" id="item-container">
						<c:forEach var="product" items="${orderDetailInquiry[0].products}">
							<div class="item">
								<div class="item-checkbox">
									<input type="checkbox" class="item-select" data-index="${product.productCode}">
								</div>
								<img src="${pageContext.request.contextPath}/static/img/product-img.png" class="item-image">
								<div class="item-details">
									<p>${product.productName}</p>
									<div class="price-container">
										<span id="order-price-${product.productCode}" class="order-price" data-order-price="${product.orderPrice}">${product.orderPrice}원</span>
										<c:if test="${product.orderPrice != product.productPrice}">
											<span class="original-price">${product.productPrice}원</span>
										</c:if>
									</div>
								</div>
								<div class="v-line"></div>
								<div class="quantity-container">
									<span>수량</span>
									
									<div class="quantity-controller">
										<div class="controller-box" id="quantity-decrease">-</div>
										<div class="quantity-box">
											<p class="quantity" id="quantity-${product.productCode}">${product.orderQuantity}</p>
										</div>
										<div class="controller-box" id="quantity-increase">+</div>
									</div>
									
								</div>
								<div class="v-line"></div>
								<div class="item-price">
									<span>상품금액</span>
									<p id="price-${product.productCode}">${product.orderPrice * product.orderQuantity}원</p>
								</div>
								<div></div>
							</div>
						</c:forEach>
					</div>

				</div>					

				
				<div class="delivery-address">
					<p class="section-name">반품 / 교환 수거 정보 입력</p>
					<div class="my-container exchange-return-info">
						
						<div class="return-type">
							<div>
								<input type="radio" name="chk-type" id="return">
								<label class="check-label" for="flexRadioDefault1">반품</label>
							</div>
							<div>
								<input type="radio" name="chk-type" id="exchange">
								<label class="check-label" for="flexRadioDefault1">교환</label>
							</div>
						</div>
						
						<div>
							<select name="languages" id="lang">
								<option value="" disabled selected>반품 사유를 선택해주세요</option>
							    <option value="change-of-mind">단순 변심</option>
							</select>
						</div>
						
						<div>
						  <textarea id="message" name="message" rows="4" cols="50">상세 사유 입력(선택 사항)</textarea>
						</div>  
					</div>
				</div>

				
				<div class="payment_info">
					<p class="section-name">환불 정보</p>
					<div class="my-container exchange-info">
						<div>
							<p class="text-con">취소 상품 총 금액 합계</p>
							<p id="cancel-cost-sum">0원</p>
						</div>
						<div>
							<p>-</p>
						</div>
						<div>
							<p class="text-con">반품 시 추가 배송비</p>
							<p>3000원</p>
						</div>
						<div class="v-line"></div>
						<div>
							<p class="text-con">환불 예정 금액</p>
							<p id="result-cost">0원</p>
						</div>
					</div>
				</div>
				
				<div class="submit-div">
					<button class="submit-button">반품 / 교환 신청</button>
				</div>
				
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/views/collection/footer.jsp"%>
</body>

</html>
