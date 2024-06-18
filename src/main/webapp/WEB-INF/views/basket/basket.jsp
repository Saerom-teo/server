<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html lang="ko">
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
<title>Cart</title>
<script>
        // 장바구니 데이터 가져옴
	    function fetchCartProducts() {
	    	  return fetch('${path}/basket/readAll')
              .then(response => {
                  if (!response.ok) {
                      throw new Error('Network response was not ok');
                  }
                  return response.json();
              })
              .then(data => {
                  console.log('가져온 장바구니 상품:', data); // 데이터 확인용
                  return data;
              })
              .catch(error => {
                  console.error('장바구니 상품 가져오기 오류:', error);
                  return [];
              });
	    }
    
        // 장바구니 데이터 사용하여 주문 요청 만듬
        function sendOrderData(products) {
        	
        	const totalProductPrice = products.reduce((total, product) => 
              		total + (product.productPrice * (1 - (product.discountRate || 0))) * product.productQuantity, 0);

          	const shippingPrice = totalProductPrice >= 30000 ? 0 : 3000;

            const orderDetailRequest = {
                products: products.map(product => ({
                    productCode: product.productCode,
                    orderQuantity: product.productQuantity, // 주문 수량
                    productPrice: product.productPrice, // 원가격
                    orderPrice: product.productPrice * (1 - (product.discountRate || 0)), // 할인 반영된 가격
                    productImgUrl: product.thumbnail, 
                    orderCode: null 
                })),
                shippingPrice: shippingPrice, // 배송비
                // 총 주문 금액 = 할인된가격 + 배송비 
                totalOrderPrice: totalProductPrice + shippingPrice
            };

            // 서버에 주문 데이터 전송
            fetch('${path}/order/createOrderAndProducts', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(orderDetailRequest)
            })
            .then(response => {
                if (response.ok) {
                    // 주문 성공 시 주문 확인 페이지로 리디렉션
                    window.location.href = '${path}/order/orderpage';
                } else {
                    // 주문 실패 시 에러 메시지를 콘솔에 출력
                    return response.json().then(errorData => {
                        console.error('Error:', errorData);
                    });
                }
            })
            .catch(error => console.error('Error:', error)); // 네트워크 에러 처리
        }


        // 페이지 로드시 초기화 작업 수행
       function init() {
            fetchCartProducts().then(products => {
                document.getElementById('orderButton').addEventListener('click', () => 
                sendOrderData(products));
            });
        }

        // 페이지가 로드시 init 함수 호출하여 초기화 
        window.onload = init;
    </script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div>
		<div class="container">
			<div>
				<input type="checkbox" name="all"> <label for="all"
					class="checkbox-label">전체 선택</label>
			</div>
			<button class="delete-button">✕ 선택 삭제</button>
		</div>

		<div class="item-container">
			<div class="item">
				<div class="item-checkbox">
					<input type="checkbox">
				</div>
				<img src="" height="144" width="134" alt="상품 이미지" class="item-image">
				<div class="item-details">
					<p>[소락] 오가닉 코튼 자수 손수건</p>
					<div class="price-container">
						<span>5000원</span> <span class="original-price">7000원</span>
					</div>
				</div>
				<div class="v-line"></div>
				<div class="quantity-container">
					<span>수량</span>
					<div class="quantity-control">
						<button onclick="updateQuantity(102, 'decrement')">-</button>
						<span id="quantity-102">2</span>
						<button onclick="updateQuantity(102, 'increment')">+</button>
					</div>
				</div>
				<div class="v-line"></div>
				<div class="item-price">
					<span>상품금액</span>
					<p>5000원</p>
				</div>
				<div class="v-line"></div>
				<div class="shipping-fee">
					<span>배송비</span>
					<p>3000원</p>
				</div>
			</div>
			<div class="item">
				<div class="item-checkbox">
					<input type="checkbox">
				</div>
				<img src="" height="144" width="134" alt="상품 이미지" class="item-image">
				<div class="item-details">
					<p>[소락] 오가닉 코튼 자수 손수건</p>
					<div class="price-container">
						<span>5000원</span> <span class="original-price">7000원</span>
					</div>
				</div>
				<div class="v-line"></div>
				<div class="quantity-container">
					<span>수량</span>
					<div class="quantity-control">
						<button onclick="updateQuantity(102, 'decrement')">-</button>
						<span id="quantity-102">2</span>
						<button onclick="updateQuantity(102, 'increment')">+</button>
					</div>
				</div>
				<div class="v-line"></div>
				<div class="item-price">
					<span>상품금액</span>
					<p>5000원</p>
				</div>
				<div class="v-line"></div>
				<div class="shipping-fee">
					<span>배송비</span>
					<p>3000원</p>
				</div>
			</div>
		</div>

		<div class="total-container">
			<hr />
			<div class="order-summary">
				&nbsp;&nbsp;총 주문 상품&nbsp;
				<div class="order-count">2</div>
				개
			</div>
			<hr />
		</div>

		<div class="final-summary">
			<div class="summary-item">
				<span>상품금액</span>
				<p>15000원</p>
			</div>
			<div class="plus-icon">➕︎</div>
			<div class="summary-item summary-item-left">
				<span>배송비</span>
				<p>3000원</p>
			</div>
			<div class="v-line v-line-middle"></div>
			<div class="summary-item summary-item-right">
				<span>주문금액</span>
				<p class="order-total">18000원</p>
			</div>
			<button class="order-button">주문하기</button>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>

</html>