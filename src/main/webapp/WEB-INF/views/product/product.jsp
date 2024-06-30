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
	<div id="menu-wrapper">
		<ul class="nav">
			<c:forEach items="${major}" var="category_major">
				<!-- 카테고리 대분류 -->
				<li><a href="#" class="major">${category_major}</a>
					<div>
						<div class="nav-column">
							<ul style="display: flex;">
								<c:forEach items="${middle}" var="category_middle">
									<c:if test="${category_middle.majorCategory == category_major}">
										<!-- 카테고리 중분류 -->
										<li class="middle_name"><a class="middle" href="#">${category_middle.middleCategory}</a>
											<ul>
												<c:forEach items="${category}" var="categoryVO">
													<c:if
														test="${categoryVO.majorCategory == category_major && categoryVO.middleCategory == category_middle.middleCategory}">
														<!-- 카테고리 소분류 -->
														<li><a class="small" href="#">${categoryVO.smallCategory}</a></li>
													</c:if>
												</c:forEach>
											</ul></li>
									</c:if>
								</c:forEach>

							</ul>
						</div>
					</div></li>
			</c:forEach>
            <li><a href="#" class="all-products">전체</a></li>
		</ul>
	</div>
	<div class="shoppingmall">
		<div class="body">
			<!-- 선택된 메뉴의 해당 대분류 카테고리 하나만 오도록 -->
			<div id="selected-category" class="title"></div>
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
                	console.log(data);
                	
                    $(".item-container").empty(); // 기존 상품 목록을 비웁니다.
                    
                    if (data.length > 0) {
                        data.forEach(function(product) {
                        	

                        	var test = product.productCode;
                        	
                            // 각 상품에 대한 HTML 생성 후 .item-container에 추가
                            var itemHtml = `<div class="item" onclick="
                            location.href='${pageContext.request.contextPath}/products/`+ product.productCode +`'">
                                <img src="${pageContext.request.contextPath}/static/img/product-img.png" class="item-image">
                                <div class="item-details">
                                    <div><p>${'${product.productName}'}</p></div>
                                    <div class="price-container">
                                        <div>${'${product.discountedPrice}'}원</div>`;
                                        
                            
                            if (product.discountRate > 0 ) {
                            	console.log(product.productPrice);
                                itemHtml += `<div class="original-price">&nbsp;${'${product.productPrice}'}원</div>`;
                            }
                            
                            itemHtml += `</div>`;
                            
                            if (product.discountRate > 0) {
                                itemHtml += `<span class="sale">SALE</span>`;
                            }
                            
                            itemHtml += `<span class="best">BEST</span>
                                </div>
                            </div>`;
                            
                            $(".item-container").append(itemHtml);
                        });
                    } else {
                        $(".item-container").append("<div class='no-product-msg'>해당 카테고리에 상품이 없습니다.</div>");
                    }
                },
                error: function(xhr, status, error) {
                    console.error("AJAX 호출 중 오류 발생:", status, error);
                }
            });
        }

        // 대분류 메뉴 클릭 시 상품 목록 요청
        $(".nav > li > a").click(function(event) {
            event.preventDefault();
            var majorCategory = $(this).text();
            
            $("#selected-category").text(majorCategory);  // 선택된 카테고리명을 표시
            
            fetchProducts('major', { majorCategory: majorCategory });
        });
        
        // 중분류 메뉴 클릭 시 상품 목록 요청
        $(".middle").click(function(event) {
            event.preventDefault();
            var middleCategory = $(this).text().trim(); // 중분류

        	// 가장 가까운 li 요소를 찾고 그 부모 ul 요소를 통해 대분류 요소를 찾음
           var majorCategory = $(this).closest("ul").closest("div").closest("li").find("> a.major").text().trim(); // 대분류 텍스트
          
           $("#selected-category").text(majorCategory); 
           
           fetchProducts('middle', { majorCategory: majorCategory, middleCategory: middleCategory });
        });

        // 소분류 메뉴 클릭 시 상품 목록 요청
        $(".small").click(function(event) {
            event.preventDefault();
            var category = $(this).text(); // 소분류
            var middleCategory =  $(this).closest("li").parent().prev("a").text();
            var majorCategory = $(this).closest("ul").closest("div").closest("li").find("> a.major").text().trim();
           
            $("#selected-category").text(majorCategory);
            
            fetchProducts('small', { majorCategory: majorCategory, middleCategory: middleCategory, smallCategory: category });
        });
        

        // 전체 카테고리 클릭 시 상품 목록 요청
        $(".all-products").click(function(event) {
            event.preventDefault();
            $("#selected-category").text("전체");
            fetchProducts('all', {});  // 전체 상품 요청
        });
    });
    </script>
</body>
</html>
