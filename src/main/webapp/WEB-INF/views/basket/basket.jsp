<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
					<!--  여기 상품 로드  --> 
				</div>

				<div class="total-container">
					<hr />
					<div class="order-summary">
						&nbsp;&nbsp;총 주문 상품&nbsp;
						<div class="order-count">
							<!-- 주문금액 업데이트 -->
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
                    
                    
                    <div style="display: none;" class="hidden-product-price">${"${item.productPrice}"}</div>
                    <div style="display: none;" class="hidden-product-code">${"${item.productCode}"}</div>
                </div>
            `;
            
            itemContainer.innerHTML += itemElement;
            /* console.log('Item Index:', index);  */
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
            let item = cart[index]; 

            /* console.log('Selected Index:', index);
            console.log('Selected Item:', item);   */

            if (item) {
                totalPrice += item.discountedPrice * item.quantity;
                /* console.log("discountedPrice : " + item.discountedPrice);
                console.log("quantity : "  + item.quantity); */
                
            }
        });

        let shippingFee = totalPrice > 0 ? 3000 : 0;

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
    
    // --------------- 주문으로 데이터 전달 부분 
/*     function collectSelectedItems() {
        const selectedItems = [];
        document.querySelectorAll('.item-select:checked').forEach(checkbox => {
            const parentItem = checkbox.closest('.item'); // 부모 요소 찾기
            //const productCode = checkbox.getAttribute('data-index'); // 데이터 인덱스 사용
            const productCode = parentItem.querySelector('.hidden-product-code').textContent;
            //const productCode = document.getElementById(`hidden-product-code-${index}`);
            
            
            const productName = parentItem.querySelector('.item-details p').textContent;
            const orderQuantity = parentItem.querySelector('.quantity-control span').textContent;
            //const productPrice = parentItem.querySelector('.original-price') ? parentItem.querySelector('.original-price').textContent.replace('원', '') : 0;
            const productPrice = parentItem.querySelector('.hidden-product-price').textContent;
            //const productPrice = document.getElementById(`hidden-product-price-${index}`);
            
            
            const orderPrice = parentItem.querySelector('.price-container span').textContent.replace('원', '');
            const shippingPrice = parentItem.querySelector('.shipping-fee p').textContent.replace('원', '');

            selectedItems.push({
                productCode,
                //productCode:parseInt(productCode),	// int값으로 전달
                productName,
                orderQuantity: parseInt(orderQuantity),
                productPrice: parseFloat(productPrice),
                orderPrice: parseFloat(orderPrice),
                shippingPrice: parseFloat(shippingPrice),
                orderCode:null
            });
        });
        return selectedItems;
    	}
    	
    	function sendOrderData() {
    	    const orderItems = collectSelectedItems();
    	    if (orderItems.length === 0) {
    	        alert('선택된 상품이 없습니다.');
    	        return;
    	    }
    	    
    	    const orderTotalElement = document.querySelector('.order-total');
    	    const totalOrderPrice = parseFloat(orderTotalElement.textContent.replace('원', '').replace(/,/g, ''));

    	    // 주문 상세 정보를 구성
    	    const orderDetailRequest = {
    	        products: orderItems.map(item => ({
    	            productCode: item.productCode,
    	            orderQuantity: item.orderQuantity,
    	            productPrice: item.productPrice,
    	            orderPrice: item.orderPrice,
    	            orderCode: item.orderCode
    	        })),
    	        shippingPrice: 3000,
    	        totalOrderPrice: totalOrderPrice
    	    };
    	    
    	    // 데이터 정합성 테스트
    	    // 클라이언트 콘솔 로그 출력
    	    console.log('Sending order detail request:', orderDetailRequest);
    	    // products 배열의 내용을 각각 출력
    	    orderDetailRequest.products.forEach((product, index) => {
    	        console.log(`Product ${index + 1}:`, product);
    	    });

    	    // 서버로 주문 데이터 전송
    	    fetch('/app/order/createOrderAndProducts', {
    	        method: 'POST',
    	        headers: {
    	            'Content-Type': 'application/json'
    	        },
    	        body: JSON.stringify(orderDetailRequest)
    	    })
    	    .then(response => {
    	        if (response.ok) {
    	            window.location.href = '/app/order/orderpage'; // 주문 확인 페이지로 이동
    	        } else {
    	            return response.json().then(errorData => {
    	                console.error('Error:', errorData); // 서버에서 반환된 오류 처리
    	            });
    	        }
    	    })
    	    .catch(error => console.error('Error:', error)); // 네트워크 오류 처리
    	} */
	
	// 페이지 로드시 로직
	document.addEventListener('DOMContentLoaded', () => {
        loadCart();
        document.querySelector('.choice input[name="all"]').addEventListener('change', function() {
            selectAll(this);
        });
        document.addEventListener('change', event => {
            if (event.target.classList.contains('item-select')) {
                /* console.log('Checkbox changed:', event.target);  */
                updateTotalPrice();
            }
        });
        
        /* // 결제하기 버튼
        document.getElementById('orderButton').addEventListener('click', sendOrderData); */
    });  
</script>
</body>
</html>
