<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<style>
	.shoppingmall {
		margin-top:120px;
	}
	.title {
		margin-bottom: 10px;
		font-size: 20px ;
		text-align: left;
	}
	.sep {
		margin-bottom: 10px;
		background: var(--gray);
		height: 1px;
		border: 0;
	}
</style>
<script>

</script>
<body>
	<%@ include file="/WEB-INF/views/collection/header.jsp"%>
	<div class="shoppingmall">
		<div class="body">
		
			<!-- 카테고리 title 부분 -->
			<c:if test="${isExist}">
				<div id="selected-category" class="title"><span style="color:black">"${keyword}"</span> 에 대한 검색 결과</div>
				<hr class="sep">
			</c:if>
			<c:if test="${!isExist}">
				<div id="selected-category" class="title"><span style="color:black">"${keyword}"</span>에 대한 검색 결과가 없습니다.</div>
				<hr class="sep">
			</c:if>
			
			
			<!-- 상품들 -->
			<div class="shopbody">
			<c:if test="${!isExist}">
						<p style="font-size:20px; font-weight: 700; color:var(--primary); margin-top: 12px;"> 추천 상품</p>
						<p style="font-size:12px">이런 상품은 어떠신가요?</p><br>
					</c:if>
			<c:if test="${isExist}">
						<p style="font-size:15px; font-weight: 500; color:var(--black); margin-top: 12px;">총 상품 개수 <span style="color:var(--primary)">${productLength}</span>건 </p>
						<br>
				
					</c:if>
				
				<div class="item-container">
					<c:forEach var="product" items="${productList}">
						<div class="item"
							onclick="location.href='${pageContext.request.contextPath}/products/${product.productCode}'">
							<img
								<%-- src="${pageContext.request.contextPath}/static/img/product-img.png" --%>
								src="${product.thumbnail}" 
								class="item-image">
							<div class="item-details">
								<div>
									<p>${product.productName}</p>
								</div>
								<div class="price-container">
									<c:if test="${product.discountRate > 0}">
										<!-- 할인율 % 표시 -->
										<div class="percent">
											<c:set var="discountRateInt"
												value="${product.discountRate * 100}" />
											<c:out value="[${fn:substringBefore(discountRateInt, '.')}%]" />
										</div>
									</c:if>
									<div>&nbsp;${product.discountedPrice}원</div>
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
		
	</div>
	<script>
	/* 카테고리별 상품 목록 가져옴 */
	var originalData = [];
    $(document).ready(function() {
    	<c:forEach var="product" items="${productList}">
        originalData.push({
            "productCode": "${product.productCode}",
            "productName": "${product.productName}",
            "productPrice": ${product.productPrice},
            "discountedPrice": ${product.discountedPrice},
            "stockQuantity": ${product.stockQuantity},
            "registrationDate": "${product.registrationDate}",
            "envMark": "${product.envMark}",
            "thumbnail": "${product.thumbnail}",
            "detailImage": "${product.detailImage}",
            "categoryNumber": ${product.categoryNumber},
            "discountCode": ${product.discountCode},
            "discountRate": ${product.discountRate != null ? product.discountRate : 0},
            "wishlistCount" : ${product.wishCount}
        });
    </c:forEach>
    
        function fetchProducts(categoryType, categoryParams) {
            $.ajax({
                url: "${pageContext.request.contextPath}/products/byCategory",
                method: "GET",
                data: {
                    categoryType: categoryType,
                    ...categoryParams
                },
                success: function(data) {
                	// test
                	console.log("Ajax 성공:", data); // Ajax 응답 로그 출력
                	
                    $(".item-container").empty(); // 기존 상품 목록 제거
                    
                    if (data.length > 0) {
                        data.forEach(function(product) {
                            // 각 상품에 대한 HTML 생성 후 .item-container에 추가
                            var itemHtml = `<div class="item" onclick="
                            location.href='${pageContext.request.contextPath}/products/`+ product.productCode +`'">
                                <img src="${pageContext.request.contextPath}/static/img/product-img.png" class="item-image">
                                <div class="item-details">
                                    <div><p>${'${product.productName}'}</p></div>
                                    <div class="price-container">
                                        <div>${'${product.discountedPrice}'}원</div>`;
                                        
                            
                            if (product.discountRate > 0 ) {
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
        
		if(!${isExist}) {
			productSort();
		}
     	
    });
	
	
    function productSort(){
	  	originalData.sort((a, b) => b.wishlistCount - a.wishlistCount);
	  	display();
	}
	
	function display(){
		$(".item-container").empty();
		
		originalData.slice(0, 4).forEach(function(product) {
            // 각 상품에 대한 HTML 생성 후 .item-container에 추가
            var itemHtml = `<div class="item" onclick="location.href='${pageContext.request.contextPath}/products/`+ product.productCode +`'">
                <img src="${pageContext.request.contextPath}/static/img/product-img.png" class="item-image">
                <div class="item-details">
                    <div><p>${'${product.productName}'}</p></div>
                    <div class="price-container">`;
                        
                    if (product.discountRate && product.discountRate > 0) {
                    // 할인율 % 표시
                    var discountRateInt = product.discountRate * 100;
                    	itemHtml += `<div class="percent">[${'${discountRateInt}'}%]</div>`;
                	}
                   
                   itemHtml += `<div>${'${product.discountedPrice}'}원</div>`;
                   
                   if (product.discountRate > 0 ) {
                       itemHtml += `<div class="original-price">&nbsp;${'${product.productPrice}'}원</div>`;
                       
                   }
                   
                   itemHtml += `</div>`;
                   
                   if (product.discountRate && product.discountRate > 0) {
                       itemHtml += `<span class="sale">SALE</span>`;
                   }
                   
                   itemHtml += `<span class="best">BEST</span>
                       </div>
                   </div>`;
            
            $(".item-container").append(itemHtml);
        });
	}
    </script>
</body>
</html>
