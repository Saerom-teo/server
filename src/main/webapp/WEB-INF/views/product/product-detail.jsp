<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/vars.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/product-detail-review.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<title>Product-Detail</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<%@ include file="/WEB-INF/views/common/shopnav.jsp"%>
	<div class="shop-detail">
		<div class="body">
			<div class="first">
				<img class="_1-15487" src="${pageContext.request.contextPath}/static/img/product-img.png" />
				<div class="explanation">
					<div class="ex-title">
						<div class="div">${product.productName}</div>
						<div class="price-container">
							<div>
								<div class="price-container-span">${product.discountedPrice}원</div>
								<c:if test="${product.discountRate > 0}">
									<div class="price-container-span2">&nbsp;${product.productPrice}원</div>
								</c:if>
							</div>
						</div>
						<div class="price-container-span3">
							<c:if test="${product.discountRate > 0}">
								<c:set var="discountAmount" value="${product.productPrice * product.discountRate}" />
								<div class="discountAmount">
									<div>새싹 등급으로 할인된 가격</div>
									<div class="discountWon">
										-<fmt:formatNumber value="${discountAmount}" type="number" maxFractionDigits="0" />원
									</div>
								</div>
							</c:if>
						</div>
					</div>
					<div class="ex-body-1">
						<div class="div2">
							***환경 인증 마크를 받은 제품입니다. <br /> 이 상품은 오르가닉 손수건으로 슬플 때 이걸로 눈물을 닦으면
							마법처럼 눈물이 사라지는 손수건입니다.
						</div>
						<div class="_3-000-50-000">
							<span>
								<span class="_3-000-50-000-span">원산지</span>
								<span class="_3-000-50-000-span2"> 대한민국 <br /></span>
								<span class="_3-000-50-000-span3">브랜드</span>
								<span class="_3-000-50-000-span4"> 새롬터 <br /></span>
								<span class="_3-000-50-000-span5">배송 방법</span>
								<span class="_3-000-50-000-span6"> 택배 <br /></span>
								<span class="_3-000-50-000-span7">배송비</span>
								<span class="_3-000-50-000-span8"> 3,000원 (50,000원 이상 무료배송) | 도서산간 배송비 추가 </span>
							</span>
						</div>
						<div class="frame-114">
							<div class="div3">수량</div>
							<div class="frame-115">
								<div class="frame-116">
									<div class="frame-117" id="quantity-decrease">
										<div class="div4">-</div>
									</div>
									<div class="frame-118">
										<div class="_1" id="quantity">1</div>
									</div>
									<div class="frame-119" id="quantity-increase">
										<div class="div4">+</div>
									</div>
								</div>
								<div class="_4000" id="total-price">${product.discountedPrice}원</div>
							</div>
						</div>
					</div>
					<div class="ex-body-2">
						<div class="_12">총 상품금액 (<span id="total-quantity">1</span>개)</div>
						<div class="_40002" id="grand-total">${product.discountedPrice}원</div>
					</div>
					<div class="ex-footer">
						<div class="frame-110" onclick="location.href='${pageContext.request.contextPath}/order/orderpage'">
							<div class="div5">구매하기</div>
						</div>
						<div class="frame-111" id="add-to-cart">
							<div class="div6">장바구니</div>
						</div>
						<img class="frame-112" src="${pageContext.request.contextPath}/static/img/hart.svg" />
					</div>
				</div>
			</div>
			<div class="shop-detail-box">
				<div class="button-1">
					<div class="div7" onclick="location.href='${pageContext.request.contextPath}/products/{productCode}'">상품 상세</div>
				</div>
				<div class="button-2" onclick="location.href='${pageContext.request.contextPath}/products/review'">
					<div class="div8">상품 후기</div>
				</div>
			</div>
			<div class="detail-image">
				<img class="image-29" src="${pageContext.request.contextPath}/static/img/detail-img.png" />
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	<script>
		document.addEventListener('DOMContentLoaded', function() {
			const quantityDecrease = document.getElementById('quantity-decrease');
			const quantityIncrease = document.getElementById('quantity-increase');
			const quantityDisplay = document.getElementById('quantity');
			const totalQuantityDisplay = document.getElementById('total-quantity');
			const totalPriceDisplay = document.getElementById('total-price');
			const grandTotalDisplay = document.getElementById('grand-total');
			const addToCartButton = document.getElementById('add-to-cart');
			const productPrice = ${product.discountedPrice};

			let quantity = 1;

			quantityDecrease.addEventListener('click', function() {
				if (quantity > 1) {
					quantity--;
					updateQuantity();
				}
			});

			quantityIncrease.addEventListener('click', function() {
				quantity++;
				updateQuantity();
			});

			addToCartButton.addEventListener('click', function() {
				addToCart(${product.productCode}, "${product.productName}", ${product.productPrice}, ${product.discountRate}, quantity);
				window.location.href = "${pageContext.request.contextPath}/basket";
			});

			function updateQuantity() {
				quantityDisplay.textContent = quantity;
				totalQuantityDisplay.textContent = quantity;
				const totalPrice = productPrice * quantity;
				totalPriceDisplay.textContent = totalPrice.toLocaleString() + '원';
				grandTotalDisplay.textContent = totalPrice.toLocaleString() + '원';
			}
		});

		function addToCart(productCode, productName, productPrice, discountRate, quantity) {
			let cart = JSON.parse(localStorage.getItem('cart')) || [];
			let existingProduct = cart.find(item => item.productCode === productCode);
			
			if (existingProduct) {
				existingProduct.quantity += quantity;
			} else {
				cart.push({
					productCode: productCode,
					productName: productName,
					productPrice: productPrice,
					discountRate: discountRate,
					discountedPrice: productPrice * (1 - discountRate),
					quantity: quantity
				});
			}

			localStorage.setItem('cart', JSON.stringify(cart));
		}
	</script>
</body>
</html>
