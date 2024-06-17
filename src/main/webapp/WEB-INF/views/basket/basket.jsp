<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <c:set var="path" value="${pageContext.servletContext.contextPath}" />
    <meta charset="UTF-8">
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
    <h2>Your Cart</h2>
    <button id="orderButton">Order Now</button>
</body>
</html>
