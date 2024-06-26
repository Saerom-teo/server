<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
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
						<input type="checkbox" name="all" id="selectAllCheckbox">
						<label for="all" class="checkbox-label">전체 선택</label>
					</div>
					<button class="delete-button" id="deleteSelectedButton">✕
						선택 삭제</button>
				</div>

				<div class="item-container" id="item-container">
					<c:forEach var="item" items="${basketList}">
						<div class="item">
							<div class="item-checkbox">
								<input type="checkbox" class="item-select"
									data-index="${item.productCode}" data-user-id="${item.userId}">
							</div>
							<img
								src="${pageContext.request.contextPath}/static/img/product-img.png"
								class="item-image">
							<div class="item-details">
								<p>${item.product.productName}</p>
								<div class="price-container">
									<span>${item.product.discountedPrice}원</span>
									<c:if test="${item.discount.discountRate > 0}">
										<span class="original-price">${item.product.productPrice}원</span>
									</c:if>
								</div>
							</div>
							<div class="v-line"></div>
							<div class="quantity-container">
								<span>수량</span>
								<div class="quantity-control">
									<!-- 수량 감소 버튼 -->
									<button class="decrement-btn"
										data-product-code="${item.productCode}"
										data-discounted-price="${item.product.discountedPrice}">-</button>
									<span id="quantity-${item.productCode}">${item.productQuantity}</span>
									<!-- 수량 증가 버튼 -->
									<button class="increment-btn"
										data-product-code="${item.productCode}"
										data-discounted-price="${item.product.discountedPrice}">+</button>
								</div>
							</div>
							<div class="v-line"></div>
							<div class="item-price">
								<span>상품금액</span>
								<p id="price-${item.productCode}"
									data-discounted-price="${item.product.discountedPrice}">${item.product.discountedPrice * item.productQuantity}원</p>
							</div>
							<div class="v-line"></div>
							<div class="shipping-fee">
								<span>배송비</span>
								<p>3000원</p>
							</div>
						</div>
					</c:forEach>
				</div>

				<div class="total-container">
					<hr />
					<div class="order-summary">
						&nbsp;&nbsp;총 주문 상품&nbsp;
						<div class="order-count">${fn:length(basketList)}</div>
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
    function updateTotalPrice() {
        let totalPrice = 0;
        let selectedItems = document.querySelectorAll('.item-select:checked');

        selectedItems.forEach(checkbox => {
            let parentItem = checkbox.closest('.item');
            let productPrice = parseFloat(parentItem.querySelector('.item-price p').textContent.replace('원', ''));
            totalPrice += productPrice;
        });

        let shippingFee = totalPrice > 0 ? 3000 : 0;

        document.querySelector('.order-subtotal').textContent = totalPrice + '원';
        document.querySelector('.order-total').textContent = (totalPrice + shippingFee) + '원';
    }
    
 	// 수량 업데이트 함수
    function updateQuantity(productCode, action, discountedPrice) {
        const quantityElement = document.getElementById(`quantity-${productCode}`);
        const priceElement = document.getElementById(`price-${productCode}`);
        let quantity = parseInt(quantityElement.textContent);
        const userId = quantityElement.closest('.item').querySelector('.item-select').getAttribute('data-user-id');

        if (action === 'increment') {
            quantity++;
        } else if (action === 'decrement' && quantity > 1) {
            quantity--;
        }

        fetch(`${pageContext.request.contextPath}/basket/updateBasket`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                productCode: productCode,
                userId: userId,
                productQuantity: quantity
            })
        })
        .then(response => {
            if (response.ok) {
                quantityElement.textContent = quantity;
                priceElement.textContent = (discountedPrice * quantity).toLocaleString() + '원';
                updateTotalPrice();
            } else {
                return response.text().then(text => { throw new Error(text); });
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('수량을 업데이트하는 데 실패했습니다.');
        });
    }

    function selectAll(selectAllCheckbox) {
        let checkboxes = document.querySelectorAll('.item-select');
        checkboxes.forEach(checkbox => {
            checkbox.checked = selectAllCheckbox.checked;
        });
        updateTotalPrice();
    }


    document.addEventListener('DOMContentLoaded', () => {
        document.querySelector('#selectAllCheckbox').addEventListener('change', function() {
            selectAll(this);
        });
        document.addEventListener('change', event => {
            if (event.target.classList.contains('item-select')) {
                updateTotalPrice();
            }
        });
        document.getElementById('orderButton').addEventListener('click', sendOrderData);
        document.getElementById('deleteSelectedButton').addEventListener('click', deleteBasketData);
        
        
        // 수량 감소 버튼 이벤트 리스너
        document.querySelectorAll('.decrement-btn').forEach(button => {
            button.addEventListener('click', function() {
                const productCode = this.getAttribute('data-product-code');
                const discountedPrice = parseFloat(this.getAttribute('data-discounted-price'));
                updateQuantity(productCode, 'decrement', discountedPrice);
            });
        });

        // 수량 증가 버튼 이벤트 리스너
        document.querySelectorAll('.increment-btn').forEach(button => {
            button.addEventListener('click', function() {
                const productCode = this.getAttribute('data-product-code');
                const discountedPrice = parseFloat(this.getAttribute('data-discounted-price'));
                updateQuantity(productCode, 'increment', discountedPrice);
            });
        });
    });
   
    function deleteBasketData(){
    	// 선택된 항목의 ID를 배열로 수집
       	var selectedItems = [];
	    $('.item-select:checked').each(function() {
	        selectedItems.push({
	            productCode: $(this).data('index'),  // data-index 속성에서 productCode를 가져옵니다.
	            userId:1
	            //userId: $(this).data('user-id')  // data-user-id 속성에서 userId를 가져옵니다.
	        });
	    });

        // 선택된 항목이 없으면 경고 표시
        if (selectedItems.length === 0) {
            alert('삭제할 항목을 선택하세요.');
            return;
        }
		//test
        console.log('전송할 데이터:', JSON.stringify(selectedItems));
		
        // 서버로 Ajax 요청 보내기
        $.ajax({
            url: '/app/basket/delete',  // 서버의 API 엔드포인트
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(selectedItems),
            success: function(response) {
                // 성공적으로 삭제된 후의 동작
                alert('선택된 항목이 삭제되었습니다.');
                window.location.href = "/app/basket"
            },
            error: function(xhr, status, error) {
                // 에러 발생 시의 동작
                alert('삭제 중 오류가 발생했습니다: ' + error);
            }
        });
    }
    
    
    /* -------------결제 페이지로 데이터 전달--------------- */
    function collectSelectedItems() {
        const selectedItems = [];
        document.querySelectorAll('.item-select:checked').forEach(checkbox => {
            const parentItem = checkbox.closest('.item');
            const productCode = checkbox.getAttribute('data-index');
            const productName = parentItem.querySelector('.item-details p').textContent;
            const orderQuantity = parentItem.querySelector('.quantity-control span').textContent;
            const productPrice = parseFloat(parentItem.querySelector('.item-details .price-container span').textContent.replace('원', ''));
            const orderPrice = parseFloat(parentItem.querySelector('.item-price p').textContent.replace('원', ''));
            const shippingPrice = parseFloat(parentItem.querySelector('.shipping-fee p').textContent.replace('원', ''));
            selectedItems.push({
                productCode,
                productName,
                orderQuantity: parseInt(orderQuantity),
                productPrice,
                orderPrice,
                shippingPrice,
                orderCode: null
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
        
        const orderDetailRequest = {
            products: orderItems.map(item => ({
                productCode: item.productCode,
                orderQuantity: item.orderQuantity,
                productPrice: item.productPrice, // 할인율 포함 가격
                orderPrice: item.orderPrice,
                orderCode: item.orderCode
            })),
            shippingPrice: 3000,
            totalOrderPrice: totalOrderPrice
        };

        console.log('requeset test:', orderDetailRequest);
        orderDetailRequest.products.forEach((product, index) => {
            console.log(`Product ${index + 1}:`, product);
        });

        fetch('/app/order/createOrderAndProducts', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(orderDetailRequest)
        })
        .then(response => {
            if (response.ok) {
                window.location.href = '/app/order/orderpage';
            } else {
                return response.json().then(errorData => {
                    console.error('Error:', errorData);
                });
            }
        })
        .catch(error => console.error('Error:', error));
    }
    
    
    

    
    </script>
</body>
</html>
