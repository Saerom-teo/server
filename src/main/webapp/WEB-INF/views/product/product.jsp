<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/vars.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/shoppingmall.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>product</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="shoppingmall">	
		<%@ include file="/WEB-INF/views/common/shopnav.jsp"%>
		<div class="body">
			<div class="title">전체</div>
			<div class="category-div">
				<div class="category">
					<div class="div2">정렬 ▼</div>
				</div>
			</div>
			<div class="shopbody">
				<div class="item-container">
					<c:forEach var="product" items="${productList}">
						<div class="item">
							<%-- <img src="${product.thumbnail}" class="item-image"> --%>
							<img src="${pageContext.request.contextPath}/static/img/product-img.png"
							class="item-image">
							<div class="item-details">
								<div><p>${product.product_Name}</p></div>
								<div class="price-container">
									<div>${product.discountedPrice}원</div>
									<c:if test="${product.discount_Rate > 0}">
										<div class="original-price">&nbsp;${product.product_Price}원</div>
									</c:if>
								</div>
								<c:if test="${product.discount_Rate > 0}">
									<span class="sale">SALE</span>
								</c:if>
								<span class="best">BEST</span>
							</div>
						</div>
						
					</c:forEach>
				</div>
			</div>
		</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>
</body>
</html>
