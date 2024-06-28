<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/css/orderDetailnquriy.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/vars.css">

<style>
a, button, input, select, h1, h2, h3, h4, h5, * {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
	border: none;
	text-decoration: none;
	background: none;
	-webkit-font-smoothing: antialiased;
}

menu, ol, ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
}
</style>
<title>Document</title>
</head>
<body>
	<div class="mypage-orderlist">
		<div class="body">
			<div class="order-detail-page">
				<div class="order-detail-header">
					<div class="div">주문 상세 내역</div>
					<div class="line-5"></div>
						<span> <span class="order-date-text">주문일자</span> <span
							class="order-date-info">2024.02.12. 12:08:25</span>
						</span>
					<div class="order_code">
						<span> <span class="order-code-text">주문번호</span> <span
							class="order-code-info">202305301027050001</span>
						</span>
					</div>	
					</div>
					
				</div>
				<div class="order-detail-board">
					<div class="order-info-board">
						<div class="order-product-board">주문상품</div>
						<div class="order-status">구매확정완료</div>
						<div class="order-info"></div>
						<img class="product-img" src="product-img0.png" />
						<div class="order-product-name">
							<span> <span class="order-product-name-text]">[소락]
									오가닉 코튼 자수 손수건</span>

							</span>
						</div>
						<div class="ask-board">
							<span> <span class="ask">문의 &gt;</span>
							</span>
						</div>
						<div class="product-price">
							<span> <span class="product-price-text">5000원</span>
							</span>
						</div>
						<div class="product-quantity">
							<span> <span class="product-quantity-text">수량 1개</span></span>
						</div>
						<div class="prodcut-price">
							<span> <span class="prodcut-price-text">7000원</span>
							</span>
						</div>
						<div class="line"></div>

						<div class="order-return">
							<div class="order-return-text">반품 요청</div>
						</div>
					</div>

					<div class="order-delivery-board">
						<div class="order-delivery-text">배송지 정보</div>

						<div class="div8">
							<div class="info-item">
								<span class="info-title">이름:</span> <span class="info-content">${orderDetail.recipient}</span>
							</div>
							<div class="info-item">
								<span class="info-title">연락처:</span> <span class="info-content"></span>
							</div>
							<div class="info-item">
								<span class="info-title">배송지 주소:</span> <span
									class="info-content"></span>
							</div>
							<div class="info-item">
								<span class="info-title">배송 메시지:</span> <span
									class="info-content"></span>
							</div>
						</div>
						<div class="order-delivery-info"></div>

					</div>
					<div class="order-pay-board">
						<div class="order-pay-text">결제 정보</div>

						<div class="div10">
							<div class="info-item">
								<span class="info-title">주문 금액:</span> <span
									class="info-content">${orderDetail.totalOrderPrice}</span>
							</div>
							<div class="info-item">
								<span class="info-title">할인 합계:</span>
							</div>
							<div class="info-item">
								<span class="info-title">최종 결제 금액:</span>
							</div>
						</div>
						<div class="order-pay-info"></div>

					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>