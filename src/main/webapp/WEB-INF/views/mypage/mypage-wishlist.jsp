<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/vars.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/wishlist.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">
<title>위시리스트 | 새롬터</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/collection/header.jsp" %>
	<div class="wrapper">
		<div style="display: flex;">
			<div>
				<%@ include file="/WEB-INF/views/common/mypage-nav.jsp"%>
			</div>

			<div class="wishlist_section">
				<div class="title">위시리스트</div>
				<div class="width_line"></div>
				<div class="item-container">
					  <c:forEach var="item" items="${wishList}">
                        <div class="item" data-index="${item.productCode}" data-user-id="${item.userId}">
							<img class="prd_img"
                                src="${pageContext.request.contextPath}/static/img/product-img.png"
                               onclick="location.href='${pageContext.request.contextPath}/products/${item.productCode}'">
							<div class="item-details">
								<div><p>${item.product.productName}</p></div>
								<div style="display: flex; justify-content: space-between; width: 100%;">
									<div>
										<div class="price-container">
											<div class="order-price">
												${item.product.discountedPrice}원</div>
											<c:if test="${item.discount.discountRate > 0}">
												<div class="original-price">${item.product.productPrice}원</div>
											</c:if>
										</div>
										<c:if test="${item.discount.discountRate > 0}">
											<span class="sale">SALE</span>
										</c:if>
										<span class="best">BEST</span>
									</div>
									<div class="heart_cnt">
										<div class="deleteSelectedButton">
											 <img id="heart-${item.productCode}" 
												src="${pageContext.request.contextPath}/static/img/heart.svg">
										</div>
									</div>

								</div>
							
							</div>
						</div>
					</c:forEach>
				</div>

				<div class="pagination">
	        		<a href="" class="prev-page"><img src="${pageContext.request.contextPath}/static/icon/mypage-toggle/chevron-left.svg" style="width: 10px;"/></a>
					    <c:forEach var="i" begin="1" end="${totalPages}">
					        <a href="?page=${i}" class="page-link ${i == currentPage ? 'active' : ''}" data-page="${i}">${i}</a>
					    </c:forEach>
					<a href="" class="next-page"><img src="${pageContext.request.contextPath}/static/icon/mypage-toggle/chevron-right.svg"style="width: 10px;"/></a>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/collection/footer.jsp"%>
	<script>
	document.addEventListener('DOMContentLoaded', () => {
	    document.querySelectorAll('.deleteSelectedButton').forEach(button => {
	        button.addEventListener('click', deleteWishData);
	    });
	});

	function deleteWishData(event) {
	    const itemElement = event.currentTarget.closest('.item');
	    const productCode = itemElement.getAttribute('data-index');
	    let userId;
	    const url = '${pageContext.request.contextPath}/mypage/wishlist/delete/' + productCode + '/' + userId;
	    
	    console.log('Request URL:', url);  // URL 확인을 위한 로그 추가
	    
        const imgElement = document.getElementById('heart-' + productCode);
        if (imgElement) {
            imgElement.src = '${pageContext.request.contextPath}/static/img/empty_heart.svg';
        }
	    
	    fetch(url, {
	        method: 'DELETE',
	        headers: {
	            'Content-Type': 'application/json'
	        }
	    })
	    .then(response => {
	        if (response.ok) {
	            alert('선택된 항목이 삭제되었습니다.');
	            window.location.href = '${pageContext.request.contextPath}/mypage/wishlist';
	        } else {
	            return response.text().then(text => {
	                console.error('Error:', text);
	                alert('삭제 중 오류가 발생했습니다: ' + text);
	            });
	        }
	    })
	    .catch(error => {
	        console.error('Error:', error);
	        alert('삭제 중 오류가 발생했습니다: ' + error);
	    });
	}
	
	$(document).ready(function() {
	    var currentPage = ${param.page != null ? param.page : 1};
	    var totalPages = ${totalPages};

	    if (currentPage <= 1) {
	        $('.prev-page').addClass('disabled');
	    }

	    if (currentPage >= totalPages) {
	        $('.next-page').addClass('disabled');
	    }

	    $('.prev-page').click(function(e) {
	        e.preventDefault();
	        if (currentPage > 1) {
	            window.location.href = '?page=' + (currentPage - 1);
	        }
	    });

	    $('.next-page').click(function(e) {
	        e.preventDefault();
	        if (currentPage < totalPages) {
	            window.location.href = '?page=' + (currentPage + 1);
	        }
	    });
	});
	</script>
</body>

</html>
