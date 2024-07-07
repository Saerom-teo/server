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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
<title>장바구니 | 새롬터</title>

</head>
<body>
	<%@ include file="/WEB-INF/views/collection/header.jsp" %>
	<div class="wrapper">
		<div style="display: flex;">
			<div>
				<%@ include file="/WEB-INF/views/common/mypage-nav.jsp"%>
			</div>
			<div class="basket_section" style="width: 100%;">
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
							<div class="item_section1">
								<div class="item-checkbox">
									<input type="checkbox" class="item-select"
										data-index="${item.productCode}" data-user-id="${item.userId}">
								</div>
								<div>
									<img
										src="${pageContext.request.contextPath}/static/img/product-img.png"
										class="item-image">
								</div>
								<div class="item-details">
									<p style="font-weight: 550;">${item.product.productName}</p>
									<div class="price-container">
										<span class="order-price">${item.product.discountedPrice}원</span>
										<c:if test="${item.discount.discountRate > 0}">
											<span class="original-price">${item.product.productPrice}원</span>
										</c:if>
									</div>
								</div>
							</div>
							<div class="item_section2">
								<div class="quantity-container">
									<div><span>수량</span></div>
									<div class="frame-116">
										<div class="frame-117" id="quantity-decrease">
											<div id="div4" class="decrement-btn"
												data-product-code="${item.productCode}">-</div>
										</div>
										<div class="frame-118">
											<div class="_1" id="quantity-${item.productCode}">${item.productQuantity}</div>
										</div>
										<div class="frame-119" id="quantity-increase">
											<div id="div4" class="increment-btn"
												data-product-code="${item.productCode}">+</div>
										</div>
									</div>
								</div>
							</div>
							<div class="item_section3">
								<div class="item-price">
									<span>상품금액</span>
									<p id="price-${item.productCode}"
										data-discounted-price="${item.product.discountedPrice}">${item.product.discountedPrice * item.productQuantity}원</p>
								</div>
							</div>
						</div>
						
						
					</c:forEach>
				</div>

				<div class="total-container">
					<hr />
					<div class="order-summary">
						&nbsp;&nbsp;총 주문 상품&nbsp;
						<div class="order-count">0</div>
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
						<p class="shipping-price">0원</p>
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

	<%@ include file="/WEB-INF/views/collection/footer.jsp"%>
    <script type="text/javascript">
    
    let userId;

    document.addEventListener('DOMContentLoaded', () => {
        // 사용자 ID 가져오기
        fetch('${pageContext.request.contextPath}/mypage/basket/getUserId', {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            }
        })
        .then(response => response.json())
        .then(data => {
            userId = data; // userId를 전역 변수에 설정
        })
        .catch(error => {
            console.error('Error:', error);
        });

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
        
        // 수량 증가 및 감소 버튼 이벤트 핸들러 
        document.querySelectorAll('.decrement-btn').forEach(button => {
            button.addEventListener('click', function() {
                let productCode = this.getAttribute('data-product-code');
                let quantityElement = document.getElementById('quantity-' + productCode);
                if (quantityElement) { 
                    let quantity = parseInt(quantityElement.textContent);
                    if (quantity > 1) {
                        quantity--;
                        updateQuantity(productCode, quantity);
                    }
                } else {
                    console.error('Element not found for product code:', productCode);
                }
            });
        });

        document.querySelectorAll('.increment-btn').forEach(button => {
            button.addEventListener('click', function() {
                let productCode = this.getAttribute('data-product-code');
                let quantityElement = document.getElementById('quantity-' + productCode);
                if (quantityElement) {
                    let quantity = parseInt(quantityElement.textContent);
                    quantity++;
                    updateQuantity(productCode, quantity);
                } else {
                    console.error('Element not found for product code:', productCode);
                }
            });
        });
        
        // 전체 선택 체크박스를 초기 페이지 로드 시 체크 상태로 설정
        const selectAllCheckbox = document.querySelector('#selectAllCheckbox');
        selectAllCheckbox.checked = true;  
        selectAll(selectAllCheckbox); 
    });

    function updateTotalPrice() {
        let totalPrice = 0;
        let totalItems = 0;
        let selectedItems = document.querySelectorAll('.item-select:checked');

        selectedItems.forEach(checkbox => {
            let parentItem = checkbox.closest('.item');
            let priceText = parentItem.querySelector('.item-price p').textContent.replace('원', '').trim();
            let productPrice = parseFloat(priceText.replace(/,/g, ''));
            totalPrice += productPrice;
            
            let quantityElement = parentItem.querySelector('.frame-118 ._1');
            
            if (quantityElement) {
                let quantity = parseInt(quantityElement.textContent);
                totalItems += quantity; // 각 선택된 상품의 수량을 총 수량에 더함
            }
        });

        let shippingFee = totalPrice >= 50000 ? 0 : 3000;

        document.querySelector('.order-subtotal').textContent = totalPrice + '원';
        document.querySelector('.shipping-price').textContent = shippingFee + '원';
        document.querySelector('.order-total').textContent = (totalPrice + shippingFee) + '원';
        
        document.querySelector('.order-count').textContent = totalItems; // 총 수량 업데이트
    }

    function selectAll(selectAllCheckbox) {
        let checkboxes = document.querySelectorAll('.item-select');
        checkboxes.forEach(checkbox => {
            checkbox.checked = selectAllCheckbox.checked;
        });
        updateTotalPrice();
    }

    function updateQuantity(productCode, quantity) {
        let quantityElement = document.getElementById('quantity-' + productCode);
        let priceElement = document.getElementById('price-' + productCode);
        let discountedPrice = parseFloat(priceElement.getAttribute('data-discounted-price'));
        
        if (quantityElement && priceElement) { 
            quantityElement.textContent = quantity;
            
            priceElement.textContent = (discountedPrice * quantity).toLocaleString() + '원';
            
            // 여기서 서버로 수량 업데이트 요청 보냄
            $.ajax({
                url: '${pageContext.request.contextPath}/mypage/basket/updateBasket', 
                type: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify({ productCode: productCode, productQuantity: quantity, userId: userId }), 
                success: function(response) {
                    updateTotalPrice();
                },
                error: function(xhr, status, error) {
                    alert('수량 업데이트 중 오류가 발생했습니다.');
                }
            });
        } else {
            console.error('Element not found for product code:', productCode);
        }
    }

    function deleteBasketData(){
        // 선택된 항목의 ID를 배열로 수집
        var selectedItems = [];
        $('.item-select:checked').each(function() {
            selectedItems.push({
                productCode: $(this).data('index'),  
                userId: userId  // userId 사용
            });
        });

        // 선택된 항목이 없으면 경고 표시
        if (selectedItems.length === 0) {
            alert('삭제할 항목을 선택하세요.');
            return;
        }
        
        $.ajax({
            url: '${pageContext.request.contextPath}/mypage/basket/delete',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(selectedItems),
            success: function(response) {
                alert('선택된 항목이 삭제되었습니다.');
                window.location.href = "${pageContext.request.contextPath}/mypage/basket"
            },
            error: function(xhr, status, error) {
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
            const orderQuantity = parentItem.querySelector('._1').textContent;
            let productPrice = parentItem.querySelector('.original-price');
            productPrice = productPrice ? parseFloat(productPrice.textContent.replace('원', '')) : parseFloat(parentItem.querySelector('.order-price').textContent.replace('원', ''));
            const orderPrice = parseFloat(parentItem.querySelector('.order-price').textContent.replace('원', ''));
                      
            selectedItems.push({
                productCode,
                productName,
                orderQuantity: parseInt(orderQuantity),
                productPrice,
                orderPrice,
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
        const shippingTotalElement = document.querySelector('.shipping-price');
        const shippingPrice = parseFloat(shippingTotalElement.textContent.replace('원', ''));
        const totalOrderPrice = parseFloat(orderTotalElement.textContent.replace('원', '').replace(/,/g, ''));
        
        const orderDetailRequest = {
            products: orderItems.map(item => ({
                productCode: item.productCode,
                productName: item.productName,
                orderQuantity: item.orderQuantity, 
                productPrice: item.productPrice,  // 할인율 포함 안된 1개 가격
                orderPrice: item.orderPrice, // 할인율 포함된 1개 가격
                orderCode: item.orderCode
            })),
            shippingPrice: shippingPrice, 
            totalOrderPrice: totalOrderPrice
        };

        console.log('requeset test:', orderDetailRequest);
        orderDetailRequest.products.forEach((product, index) => {
            console.log(`Product ${index + 1}:`, product);
        });

        fetch('${pageContext.request.contextPath}/order/createOrderAndProducts', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(orderDetailRequest)
        })
        .then(response => {
            if (response.ok) {
            	window.location.href = '${pageContext.request.contextPath}/order/orderpage';
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
