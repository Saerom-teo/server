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
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="mypage-orderlist">
		<div style="display: flex; ">
		<div>
			<%@ include file="/WEB-INF/views/common/mypage-nav.jsp"%>
		</div>
		<div class="body">
			<div class="order-detail-page">
				<div class="order-detail-header">
					<div class="div">주문 상세 내역</div>
					<div class="order-date">
						<span> <span class="order-date-text">주문일자</span> <span
							class="order-date-info">${orderDetailInquiry[0].orderDate}</span>
						</span>
					</div>
					<div class="order-code">
						<span> <span class="order-code-text">주문번호</span> <span
							class="order-code-info">${orderDetailInquiry[0].orderCode}</span>
						</span>
					</div>
				</div>
				<div class="order-detail-main">
					<div class="order-info-board">

						<div class="order-product-text">주문상품</div>
						<div class="order-info">
							<div class="order-status">구매확정완료</div>


							<c:forEach var="detail" items="${orderDetailInquiry}">
								<div class="products">
									<c:forEach var="product" items="${detail.products}">
										<div class="order-detail-board">
											<img class="product-img" src="${product.productImgUrl}"
												alt="상품이미지" />
											<div class="order-detail">
												<div class="productName">
													<span class="productName-span">${product.productName}</span>
												</div>
												<div class="productprice">
													<span class="productprice-span">${product.orderPrice * product.orderQuantity}원
														(${product.orderQuantity})개</span>
												</div>

											</div>
										</div>
									</c:forEach>
								</div>
							</c:forEach>

							<div class="order-return">
								<div class="order-return-text"
									onclick="redirectToAfterSalesPage()">반품 요청</div>
							</div>
							<div class="ask-board">
								<span> <span class="ask">문의 &gt;</span>
								</span>
							</div>
						</div>
					</div>

					<div class="order-delivery-board">
						<div class="order-delivery-text">배송지 정보</div>
						<div class="order-delivery-info">
							<div class="div8">
								<div class="info-item">
									<span class="info-title">이름 : </span> <span
										class="info-content">${orderDetailInquiry[0].recipient}</span>
								</div>
								<div class="info-item">
									<span class="info-title">연락처 : </span> <span
										class="info-content">${orderDetailInquiry[0].phoneNumber}</span>
								</div>
								<div class="info-item">
									<span class="info-title">배송지 주소 : </span> <span
										class="info-content">${orderDetailInquiry[0].address}</span>
								</div>
								<div class="info-item">
									<span class="info-title">배송 메시지 : </span> <span
										class="info-content">${orderDetailInquiry[0].deliveryMemo}</span>
								</div>
							</div>
						</div>

					</div>
					<div class="order-pay-board">
						<div class="order-pay-text">결제 정보</div>
						<div class="order-pay-info">
							<div class="div10">
								<div class="info-item">
									<span class="order-price">주문 금액:</span> <span
										class="info-content price"> <c:set
											var="totalProductPrice" value="0" /> <c:forEach
											var="product" items="${orderDetailInquiry[0].products}">
											<c:set var="productTotal"
												value="${product.productPrice * product.orderQuantity}" />
											<c:set var="totalProductPrice"
												value="${totalProductPrice + productTotal}" />
										</c:forEach> ${totalProductPrice}
									</span>
								</div>
								<div class="info-item">
									<span class="order-price">할인 합계:</span> <span
										class="info-content price"> <c:set
											var="totalOrderPrice" value="0" /> <c:forEach var="product"
											items="${orderDetailInquiry[0].products}">
											<c:set var="orderTotal"
												value="${product.orderPrice * product.orderQuantity}" />
											<c:set var="totalOrderPrice"
												value="${totalOrderPrice + orderTotal}" />
										</c:forEach> ${totalProductPrice - totalOrderPrice}
									</span>
								</div>
								<div class="info-item">

									<span class="order-price">최종 결제 금액:</span> <span
										class="info-content price"> <c:set var="finalPrice"
											value="${totalOrderPrice < 50000 ? totalOrderPrice + 3000 : totalOrderPrice}" />
										${finalPrice}
									</span>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
	</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	<script>
        function formatNumberWithCommas(number) {
            return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }

        document.addEventListener("DOMContentLoaded", function() {
            const priceElements = document.querySelectorAll(".price");

            priceElements.forEach(element => {
                const price = parseInt(element.textContent);
                element.textContent = formatNumberWithCommas(price)+"원";
            });
        });
        
        function redirectToAfterSalesPage() {
            window.location.href = '<%=request.getContextPath()%>/afterSales/afterSales.jsp';  // 원하는 URL로 변경하세요.
        }
    </script>

</body>
</html>