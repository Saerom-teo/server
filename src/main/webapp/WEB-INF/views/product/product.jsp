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
<script>
</script>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div id="menu-wrapper">
	
	<!-- 카테고리 선택 -->
		<ul class="nav">
			<c:forEach items="${major}" var="category_major">
				<!-- 카테고리 대분류 -->
				<li><a href="#" class="major">${category_major}</a>
					<div>
						<div class="nav-column">
							<ul style="display: flex;">
								<c:forEach items="${middle}" var="category_middle">
								    <!-- 해당 대분류에 속하는 중분류 카테고리 생성 -->
									<c:if test="${category_middle.majorCategory == category_major}">
										<!-- 카테고리 중분류 -->
										<li class="middle_name"><a class="middle" href="#">${category_middle.middleCategory}</a>
											<ul>
												<c:forEach items="${category}" var="categoryVO">
													<!-- 해당 대분류 및 중분류에 속하는 소분류 카테고리 생성 -->
													<c:if test="${categoryVO.majorCategory == category_major && categoryVO.middleCategory == category_middle.middleCategory}">
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
		
			<!-- 카테고리 title 부분 -->
			<div id="selected-category" class="title"></div>
			
			<!-- 상품 정렬버튼 -->
			<div class="category-div">
				<div class="category">
					<form id="sortForm" method="get" action="${pageContext.request.contextPath}/products">
						<select name="sortBy" class="select" id="sortBy" onchange="productSort()">
							<option value="new" >신상품순</option>
							<option value="lowPrice">낮은가격순</option>
							<option value="highPrice">높은가격순</option>
							<option value="discountRate">할인율순</option>
							<option value="popularity">인기순</option>
						</select>
					</form>
				</div>
			</div>
			
			<!-- 상품들 -->
			<div class="shopbody">
				<div class="item-container"> </div>
			</div>
			
		</div>
		
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>
	<script>
	var originalData = [];
	
	/* 상품 정렬 */
	function productSort(){
	    var sortBy = $("#sortBy").val(); 
	    
	    if(sortBy == "new"){
	        originalData.sort((a, b) => b.registrationDate - a.registrationDate);
	    } else if(sortBy == "lowPrice"){
	        originalData.sort((a, b) => {
	            // 할인된 가격이 있을 경우 그 가격으로 비교
	            var priceA = a.discountRate > 0 ? a.discountedPrice : a.productPrice;
	            var priceB = b.discountRate > 0 ? b.discountedPrice : b.productPrice;
	            return priceA - priceB;
	        });
	    } else if(sortBy == "highPrice"){
	        originalData.sort((a, b) => {
	            // 할인된 가격이 있을 경우 그 가격으로 비교
	            var priceA = a.discountRate > 0 ? a.discountedPrice : a.productPrice;
	            var priceB = b.discountRate > 0 ? b.discountedPrice : b.productPrice;
	            return priceB - priceA;
	        });
	    } else if(sortBy == "discountRate"){
	        originalData.sort((a, b) => b.discountRate - a.discountRate);
	    } else if(sortBy == "popularity"){ // 인기순 정렬
	        originalData.sort((a, b) => b.wishCount - a.wishCount);
	    } 
    
	    display();
	}


	/* 카테고리별 상품 목록 가져옴 */
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
            	originalData = data;
            	
                $(".item-container").empty(); // 기존 상품 목록 제거
                
                if (data.length > 0) {
                    display();
                } else {
                    $(".item-container").append("<div class='no-product-msg'>해당 카테고리에 상품이 없습니다.</div>");
                }
            },
            error: function(xhr, status, error) {
                console.error("AJAX 호출 중 오류 발생:", status, error);
            }
        });
    }
	
    
	function display(){
		$(".item-container").empty();
		originalData.forEach(function(product) {
            // 각 상품에 대한 HTML 생성 후 .item-container에 추가
            var itemHtml = `<div class="item" onclick="location.href='${pageContext.request.contextPath}/products/`+ product.productCode +`'">
                <img src="${pageContext.request.contextPath}/static/img/product-img.png" class="item-image">
                <div class="item-details">
                    <div><p>${'${product.productName}'}</p></div>
                    <div class="price-container">`;
                        
            if (product.discountRate > 0) {
             // 할인율 % 표시
             var discountRateInt = product.discountRate * 100;
             	itemHtml += `<div class="percent">[${'${discountRateInt}'}%]</div>`;
             }
            
            itemHtml += `<div>${'${product.discountedPrice}'}원</div>`;
            
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
            
         	// 위시리스트 카운트 추가
           /*  itemHtml += `<div class="wishlist-count">인기: ${'${product.wishCount}'}명</div>
                </div>
            </div>`;  */
            
            $(".item-container").append(itemHtml);
        });
	}
	
    // 페이지 새로 고침해도 동일한 상태 유지
    function updateURL(categoryType, categoryParams) {
        const params = new URLSearchParams(categoryParams);
        params.set("categoryType", categoryType);
        history.pushState(null, '', '?' + params.toString());
    }
    
	
    $(document).ready(function() {
    	<c:forEach var="product" items="${productList}">
    		originalData.push({"productCode":'${product.productCode}',
    							"productName":'${product.productName}',
    							"productPrice" : ${product.productPrice},
    							"stockQuantity": ${product.stockQuantity},
    							"registrationDate": ${product.registrationDate},
    							"envMark": '${product.envMark}',
    							"thumbnail": '${product.thumbnail}',
    							"detailImage": '${product.detailImage}',
    							"categoryNumber": ${product.categoryNumber},
    							"discountCode": ${product.discountCode},
/*     							"discountRate": ${product.discountRate},
    						    "discountedPrice": ${product.discountedPrice},
    						    "brand": '${product.brand}', */
    							"wishlistCount" : ${product.wishCount}
    						 });
    	</c:forEach>
    	
        // 대분류 메뉴 클릭 시 상품 목록 요청
        $(".major").click(function(event) {
            event.preventDefault();
            var majorCategory = $(this).text();
            
            $("#selected-category").text(majorCategory);  // title 표시 부분
            
            fetchProducts('major', { majorCategory: majorCategory });
            updateURL('major', { majorCategory: majorCategory });
        });
        
        // 중분류 메뉴 클릭 시 상품 목록 요청
        $(".middle").click(function(event) {
            event.preventDefault();
            var middleCategory = $(this).text().trim(); // 중분류

        	// 가장 가까운 li 요소를 찾고 그 부모 ul 요소를 통해 대분류 요소를 찾음
           var majorCategory = $(this).closest("ul").closest("div").closest("li").find("> a.major").text().trim(); // 대분류 텍스트
          
           $("#selected-category").text(majorCategory); 
           
           fetchProducts('middle', { majorCategory: majorCategory, middleCategory: middleCategory });
           updateURL('middle', { majorCategory: majorCategory, middleCategory: middleCategory });
        });

        // 소분류 메뉴 클릭 시 상품 목록 요청
        $(".small").click(function(event) {
            event.preventDefault();
            var category = $(this).text(); // 소분류
            var middleCategory =  $(this).closest("li").parent().prev("a").text();
            var majorCategory = $(this).closest("ul").closest("div").closest("li").find("> a.major").text().trim();
           
            $("#selected-category").text(majorCategory);
            
            fetchProducts('small', { majorCategory: majorCategory, middleCategory: middleCategory, smallCategory: category });
            updateURL('small', { majorCategory: majorCategory, middleCategory: middleCategory, smallCategory: category });
        });
        
        // 전체 메뉴 클릭 시 상품 목록 요청
        $(".all-products").click(function(event) {
            event.preventDefault();
            
            $("#selected-category").text("전체");
            
            fetchProducts('all', {});  // 전체 상품 요청
            updateURL('all', {});
        });
        
     	// 페이지 로드 시 쿼리 파라미터에 따른 상품 목록 요청
        const urlParams = new URLSearchParams(window.location.search);
        const categoryType = urlParams.get('categoryType');
        const categoryParams = {};
        if (categoryType) {
            
            if (urlParams.get('majorCategory')) {
                categoryParams.majorCategory = urlParams.get('majorCategory');
                $("#selected-category").text(urlParams.get('majorCategory'));  // title 표시 부분
            }
            if (urlParams.get('middleCategory')) categoryParams.middleCategory = urlParams.get('middleCategory');
            if (urlParams.get('smallCategory')) categoryParams.smallCategory = urlParams.get('smallCategory');
            if (urlParams.get('sortBy')) categoryParams.sortBy = urlParams.get('sortBy');
            
            fetchProducts(categoryType, categoryParams);
        }else{
        	fetchProducts("all", categoryParams);
        }
    });
    </script>
</body>
</html>
