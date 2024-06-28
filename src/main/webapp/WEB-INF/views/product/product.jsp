<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/vars.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/product.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>product</title>
</head>
<script>
</script>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="shoppingmall">
		<%@ include file="/WEB-INF/views/common/shopnav.jsp"%>
		<div class="body">
			<div class="title">전체</div>
			<div class="category-div">
				<div class="category">
					<form id="sortForm" method="get"
						action="${pageContext.request.contextPath}/products">
						<select name="sortBy" class="select"
							onchange="document.getElementById('sortForm').submit()">
							<option value="new" ${param.sortBy == 'new' ? 'selected' : ''}>신상품순</option>
							<option value="lowPrice"
								${param.sortBy == 'lowPrice' ? 'selected' : ''}>낮은가격순</option>
							<option value="highPrice"
								${param.sortBy == 'highPrice' ? 'selected' : ''}>높은가격순</option>
							<option value="discountRate"
								${param.sortBy == 'discountRate' ? 'selected' : ''}>할인율순</option>
							<option value="review"
								${param.sortBy == 'review' ? 'selected' : ''}>후기순</option>
							<option value="sales"
								${param.sortBy == 'sales' ? 'selected' : ''}>판매순</option>
						</select>
					</form>
				</div>
			</div>
			<div class="shopbody">
				<div class="item-container">
					<c:forEach var="product" items="${productList}">
						<div class="item"
							onclick="location.href='${pageContext.request.contextPath}/products/${product.productCode}'">
							<img
								src="${pageContext.request.contextPath}/static/img/product-img.png"
								class="item-image">
							<div class="item-details">
								<div>
									<p>${product.productName}</p>
								</div>
								<div class="price-container">
									<div>${product.discountedPrice}원</div>
									<c:if test="${product.discountRate > 0}">
										<div class="original-price">&nbsp;${product.productPrice}원</div>
									</c:if>
								</div>
								<c:if test="${product.discountRate > 0}">
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
	<script>
    $(document).ready(function() {
        function fetchProducts(categoryType, categoryParams) {
            $.ajax({
                url: "${pageContext.request.contextPath}/products/byCategory",
                method: "GET",
                data: {
                    categoryType: categoryType,
                    ...categoryParams
                },
                success: function(data) {
                    $("#productList").empty();
                    if (data.length > 0) {
                        data.forEach(function(product) {
                            $("#productList").append("<div>" + product.productName + " - " + product.productPrice + "원</div>");
                        });
                    } else {
                        $("#productList").append("<div>해당 카테고리에 상품이 없습니다.</div>");
                    }
                }
            });
        }

        $(".nav > li > a").click(function(event) {
            event.preventDefault();
            var category = $(this).text();
            fetchProducts('major', {majorCategory: category});
        });

        $(".nav-column > h3 > a").click(function(event) {
            event.preventDefault();
            var category = $(this).text();
            var majorCategory = $(this).closest("li").find("> a").first().text();
            fetchProducts('middle', {majorCategory: majorCategory, middleCategory: category});
        });

        $(".nav-column > ul > li > a").click(function(event) {
            event.preventDefault();
            var category = $(this).text();
            var middleCategory = $(this).closest("div.nav-column").find("h3 > a").text();
            var majorCategory = $(this).closest("li").find("> a").first().text();
            fetchProducts('small', {majorCategory: majorCategory, middleCategory: middleCategory, smallCategory: category});
        });
    });
</script>
</body>
</html>
