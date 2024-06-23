<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/vars.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/basket.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>Cart</title>

</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="wrapper">
		<div style="display: flex;">
			<div>
				<%@ include file="/WEB-INF/views/common/mypage-nav.jsp"%>
			</div>
			<div class="width_line"></div>
			<div class="basket_section">
				<div class="title">장바구니</div>
				<div class="height_line"></div>
				<div class="choice">
					<div>
						<input type="checkbox" name="all"> <label for="all"
							class="checkbox-label">전체 선택</label>
					</div>
					<button class="delete-button">✕ 선택 삭제</button>
				</div>

				<div class="item-container" id="item-container">
					<!-- Items will be loaded here by JavaScript -->
				</div>

				<div class="total-container">
					<hr />
					<div class="order-summary">
						&nbsp;&nbsp;총 주문 상품&nbsp;
						<div class="order-count">
							<!-- Order count will be updated by JavaScript -->
						</div>
						개
					</div>
					<hr />
				</div>

				<div class="final-summary">
					<div class="summary-item">
						<span>상품금액</span>
						<p class="order-subtotal">0원</p>
					</div>
					<div class="plus-icon">➕︎</div>
					<div class="summary-item summary-item-left">
						<span>배송비</span>
						<p>3000원</p>
					</div>
					<div class="v-line v-line-middle"></div>
					<div class="summary-item summary-item-right">
						<span>주문금액</span>
						<p class="order-total">0원</p>
					</div>
					<button class="order-button" id="orderButton">주문하기</button>
				</div>

			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	<script type="text/javascript">
    function loadCart() {
        let cart = JSON.parse(localStorage.getItem('cart')) || [];
        let itemContainer = document.querySelector('.item-container');
        itemContainer.innerHTML = '';

        cart.forEach((item, index) => {
        	var subTotal = item.discountedPrice * item.quantity;
        	var testRate = item.discountRate;
        	console.log(testRate);
        	
            let itemElement = `
                <div class="item">
                    <div class="item-checkbox">
                    	<input type="checkbox" class="item-select" data-index="${'${index}'}">
                    </div>
                    <img src="${pageContext.request.contextPath}/static/img/product-img.png" class="item-image">
                    <div class="item-details">
                        <p>${"${item.productName}"}</p>
                        
                        <div class="price-container">
                            <span>${"${item.discountedPrice}"}원</span>
                            
                            <c:if test= "${testRate > 0}">
                            	<span class="original-price">${"${item.productPrice}"}원</span>
                       		</c:if>
                        </div>
                    </div>
                    <div class="v-line"></div>
                    <div class="quantity-container">
                        <span>수량</span>
                        <div class="quantity-control">
                            <button onclick="updateQuantity(${"${item.productCode}"}, 'decrement')">-</button>
                            <span id="quantity-${"${item.productCode}"}">${"${item.quantity}"}</span>
                            <button onclick="updateQuantity(${"${item.productCode}"}, 'increment')">+</button>
                        </div>
                    </div>
                    <div class="v-line"></div>
                    <div class="item-price">
                        <span>상품금액</span>
                        <p>${"${item.discountedPrice * item.quantity}"}원</p>
                    </div>
                    <div class="v-line"></div>
                    <div class="shipping-fee">
                        <span>배송비</span>
                        <p>3000원</p>
                    </div>
                </div>
                
                <div style="display: none;" id="test_productPrice">${"${item.productPrice}"}</div>
                <div style="display: none;" id="test_productCode">${"${item.productCode}"}</div>
            `;
            itemContainer.innerHTML += itemElement;
            console.log('Item Index:', index); // 디버깅을 위한 콘솔 로그 추가
        });

        updateTotalPrice();
    }

    function updateQuantity(productCode, action) {
        let cart = JSON.parse(localStorage.getItem('cart')) || [];
        let product = cart.find(item => item.productCode === productCode);

        if (action === 'increment') {
            product.quantity++;
        } else if (action === 'decrement' && product.quantity > 1) {
            product.quantity--;
        }

        localStorage.setItem('cart', JSON.stringify(cart));
        loadCart();
    }

    function updateTotalPrice() {
        let cart = JSON.parse(localStorage.getItem('cart')) || [];
        let totalPrice = 0;
        let selectedItems = document.querySelectorAll('.item-select:checked');

        selectedItems.forEach(checkbox => {
        	let index = parseInt(checkbox.getAttribute('data-index'), 10);
            let item = cart[index];  // `parseInt`로 인덱스를 숫자로 변환

            console.log('Selected Index:', index); // 디버깅을 위한 콘솔 로그 추가
            console.log('Selected Item:', item);   // 디버깅을 위한 콘솔 로그 추가

            if (item) {
                totalPrice += item.discountedPrice * item.quantity;
                console.log("discountedPrice : " + item.discountedPrice);
                console.log("quantity : "  + item.quantity);
                
            }
        });

        let shippingFee = totalPrice > 0 ? 3000 : 0;

        // 디버깅을 위한 콘솔 로그 추가
        //console.log('Total Price:', totalPrice);
        //console.log('Shipping Fee:', shippingFee);
        //console.log('Order Count:', selectedItems.length);

        document.querySelector('.order-subtotal').textContent = totalPrice + '원';
        document.querySelector('.order-total').textContent = (totalPrice + shippingFee) + '원';
        document.querySelector('.order-count').textContent = selectedItems.length;
    }
    
    function selectAll(selectAllCheckbox) {
        let checkboxes = document.querySelectorAll('.item-select');
        checkboxes.forEach(checkbox => {
            checkbox.checked = selectAllCheckbox.checked;
        });
        updateTotalPrice();
    }

	
	
	// 페이지 로드시 로직
	document.addEventListener('DOMContentLoaded', () => {
        loadCart();
        document.querySelector('.choice input[name="all"]').addEventListener('change', function() {
            selectAll(this);
        });
        document.addEventListener('change', event => {
            if (event.target.classList.contains('item-select')) {
                console.log('Checkbox changed:', event.target); // 디버깅을 위한 콘솔 로그 추가
                updateTotalPrice();
            }
        });
        // 결제하기 버튼
        //document.getElementById('orderButton').addEventListener('click', sendOrderData);
    });  
</script>
</body>
</html>
