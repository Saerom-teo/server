<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
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
	<title>상품 | 새롬터</title>
	</head>
<body>

	<%@ include file="/WEB-INF/views/collection/header.jsp"%>
	<%@ include file="/WEB-INF/views/common/shopnav.jsp"%>


	
	
	<div class="shoppingmall">
		<div class="body">
		
			<!-- 카테고리 title 부분 -->
			<div id="selected-category" class="title">전체</div>
			<div style="display:none;" id="selected-sub-category"><span id="selected-middle"></span> <span id="selected-small"></span></div>
			
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
			<img src="${pageContext.request.contextPath}/static/icon/up.svg" class="up" onclick="up()"/>
		</div>
		
		<%@ include file="/WEB-INF/views/collection/footer.jsp"%>
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
            
            //  wishCount가 1 이상인 경우에만 BEST 표시
            if (product.wishCount > 0) { 
                itemHtml += `<span class="best">BEST</span>`;  
            }  
            
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
    	$(window).scroll(function() {
    	    // top button controll
    	    if ($(this).scrollTop() > 500) {
    	        $('.up').fadeIn();
    	    } else {
    	        $('.up').fadeOut();
    	    }
    	});
    	
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
            $(".major").removeClass("nav-active");
            $(".all-products").removeClass("nav-active");
            $(".major"+majorCategory).addClass("nav-active");
            
            $("#selected-sub-category").css("display","none");
            $("#selected-sub-category").hide();
        });
        
        // 중분류 메뉴 클릭 시 상품 목록 요청
        $(".middle").click(function(event) {
            event.preventDefault();
            var middleCategory = $(this).text().trim(); // 중분류

        	// 가장 가까운 li 요소를 찾고 그 부모 ul 요소를 통해 대분류 요소를 찾음
           var majorCategory = $(this).closest(".navcategory-1")
                           .closest(".shopnavdetailcontent")
                           .closest(".shopnavdetail")
                           .closest(".box")
                           .find("> .major")
                           .text()
                           .trim();

           $("#selected-category").text(majorCategory); 
           
           fetchProducts('middle', { majorCategory: majorCategory, middleCategory: middleCategory });
           updateURL('middle', { majorCategory: majorCategory, middleCategory: middleCategory });
           $(".major").removeClass("nav-active");
           $(".all-products").removeClass("nav-active");
           $(".major"+majorCategory).addClass("nav-active");
           
           $("#selected-sub-category").show();
           $("#selected-middle").text(middleCategory);
           $("#selected-small").text("");
           
        });

        // 소분류 메뉴 클릭 시 상품 목록 요청
        $(".small").click(function(event) {
            event.preventDefault();
            var category = $(this).text(); // 소분류
            var middleCategory = $(this).closest(".navcategory-1")
			            .find("> .middle")
			            .text()
			            .trim();

			var majorCategory = $(this).closest(".navcategory-1")
			           .closest(".shopnavdetailcontent")
			           .closest(".shopnavdetail")
			           .closest(".box")
			           .find("> .major")
			           .text()
			           .trim();

            $("#selected-category").text(majorCategory);
            
            fetchProducts('small', { majorCategory: majorCategory, middleCategory: middleCategory, smallCategory: category });
            updateURL('small', { majorCategory: majorCategory, middleCategory: middleCategory, smallCategory: category });
        
            $(".major").removeClass("nav-active");
            $(".all-products").removeClass("nav-active");
            $(".major"+majorCategory).addClass("nav-active");
            $("#selected-sub-category").show();
            $("#selected-middle").text(middleCategory);
            $("#selected-small").text("> "+category);
        });
        
        // 전체 메뉴 클릭 시 상품 목록 요청
        $(".all-products").click(function(event) {
            event.preventDefault();
            
            $("#selected-category").text("전체");
            
            fetchProducts('all', {});  // 전체 상품 요청
            updateURL('all', {});
            
            $(".major").removeClass("nav-active");
            $(".all-products").addClass("nav-active");
            $("#selected-sub-category").hide();
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
    
    function up() {
    	$('html, body').animate({scrollTop:0}, '300');
    }
    </script>
</body>
</html>
