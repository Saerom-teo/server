<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html lang="ko">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
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

				<div class="item-container">
					<div class="item">
						<div class="item-checkbox">
							<input type="checkbox">
						</div>
						<img src="${pageContext.request.contextPath}/static/img/product-img.png" 
							class="item-image">
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
						<img src="${pageContext.request.contextPath}/static/img/product-img.png" height="144" width="134" alt="상품 이미지"
							class="item-image">
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
		</div>
	</div>

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>

</html>