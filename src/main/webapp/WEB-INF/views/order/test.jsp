<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<meta charset="UTF-8">
<head>
    <meta charset="UTF-8">
    <title>Cart</title>
    <script>
        function sendOrderData() {
            const orderDetailRequest = {
            		products: [
            	        {
            	        	productName : "손수건" ,
            	            productCode: 101,
            	            orderQuantity: 2,
            	            productPrice: 1500,
            	            orderPrice:1500,
            	            productImgUrl: null,
            	            orderCode: null
            	        },
            	        {
            	        	productName : "가방",
            	            productCode: 102,
            	            orderQuantity: 12,
            	            productPrice: 3000,
            	            orderPrice:2000,
            	            productImgUrl: null,
            	            orderCode: null
            	        }
            	    ],
            	    shippingPrice : 3000,
            	    totalOrderPrice : 6000
            	    	
            };

            fetch('/app/order/createOrderAndProducts', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(orderDetailRequest)
            })
            .then(response => {
                if (response.ok) {
                    // 응답이 성공적이면 주문 확인 페이지로 리디렉션
                    window.location.href = '/app/order/orderpage';
                } else {
                    // 응답이 실패하면 에러 메시지를 콘솔에 출력
                    return response.json().then(errorData => {
                        console.error('Error:', errorData);
                    });
                }
            })
            .catch(error => console.error('Error:', error));
        }

        function init() {
            document.getElementById('orderButton').addEventListener('click', sendOrderData);
        }

        window.onload = init;
    </script>
</head>
<body>
    <h2>Your Cart</h2>
    <button id="orderButton">Order Now</button>
</body>
</html>
