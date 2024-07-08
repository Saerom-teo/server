<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/vars.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/mypage-collection.css">
    
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/static/icon/favicon.ico">
    <title>마이페이지 - 주문 상세 | 새롬터</title>
    
    <style>
		#detail-container {
			padding-left: 35px;
			margin: 40px 0;
			font-weight: 500;
		}
		.detail-info div {
			display: flex;
			margin: 5px;
		}
		.detail-info p {
			width: 80px;
		}
		.detail-info a {
			color: var(--gray);
		}
		.section-name {
			color: var(--primary);
			font-size: 20px;
			margin-top: 40px;
		}
		.product-container {
			border: 1px solid var(--gray);
        	border-radius: 15px;
        	padding: 20px;
        	margin: 10px 0;
        	display: flex;
        	gap: 15px;
		}
		.product-container img {
        	width: 150px;
        	height: 150px;
        	border-radius: 10px;
        }
        .product-content {
        	margin: 5px 0;
        	flex: 1;
        }
        .product-content .title {
        	font-size: 16px;
        }
        .product-content .cost {
        	font-size: 14px;
        	margin-bottom: 20px;
        }
        .product-content span {
        	text-decoration: line-through;
        	color: var(--gray);
        	font-size: 12px;
        	margin: 0 5px;
        }
        .product-end {
        	display: flex;
    		flex-direction: column;
    		justify-content: flex-end;
        }
		.product-end button {
        	background: var(--primary);
        	color: #fff;
        	font-size: 14px;
        	padding: 9px 50px;
        	border-radius: 8px;
        	cursor: pointer;
        	margin-right: 5px;
        }
        .product-end button:hover {
        	background: var(--primary-dark);
        }
        
		.my-container {
			border: 1px solid var(--gray);
        	border-radius: 15px;
        	padding: 20px;
        	padding-right: 0;
        	margin: 10px 0;
		}
		.my-container div {
			display: flex;
			margin: 8px 0;
		}
		.my-container p {
			width: 200px;
		}
		

	

        
        .order-info {
		    flex-grow: 1;
		    display: flex;
		    flex-direction: column;
		    justify-content: space-between;
        }
        .order-info .order-detail {
        	color: var(--primary);
        	font-size: 14px;
        }
        .order-info .order-detail:hover {
        	color: var(--primary-dark);
        }
        .order-info .order-button {
        	background: var(--primary);
        	color: #fff;
        	font-size: 14px;
        	padding: 9px 10px;
        	border-radius: 8px;
        	cursor: pointer;
        	width: 150px;
        	margin-right: 5px;
        }
        .order-info .order-button:hover {
        	background: var(--primary-dark);
        }
        .order-content .question {
        	display: flex;
		    flex-direction: column;
		    justify-content: flex-end;
        }
        .order-content .question a {
		    font-size: 14px;
		    color: var(--gray);
		    padding: 0 5px;
		    margin: 0 10px;
		    cursor: pointer;
        }
        .order-content .question a:hover {
		    color: var(--black);
        }
    </style>
    
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var currentPageId = "order";
            document.getElementById(currentPageId).classList.add("current-page");
        });
    </script>
    <script>
	    function searchByDate() {
	        const startDate = document.getElementById('startDate').value;
	        const endDate = document.getElementById('endDate').value;
	        if (startDate && endDate) {
	            window.location.href = `?type=custom&startDate=\${startDate}&endDate=\${endDate}`;
	        } else {
	            alert('날짜를 선택해주세요.');
	        }
	    }
	</script>
</head>

<body>
    <%@ include file="/WEB-INF/views/collection/header.jsp" %>
    <div class="wrapper">
        <%@ include file="/WEB-INF/views/common/mypage-nav.jsp" %>
        <div class="collection-content">
            <div class="collection-name">
                <h1>주문 상세 내역</h1>
            </div>
            <div id="detail-container">
				<div class="detail-info">
					<div><p>주문일자</p><a>${orderDetailInquiry[0].orderDate}</a></div>
					<div><p>주문번호</p><a>${orderDetailInquiry[0].orderCode}</a></div>
					<div><p>상태</p><a>${orderDetailInquiry[0].orderStatus }</a></div>
				</div>
				
				<div class="order-product">
					<p class="section-name">주문 상품</p>
					
					<c:forEach var="product" items="${orderDetailInquiry[0].products}" varStatus="status">
						<div class="product-container">
							<img src="${product.productImgUrl}">
							<div class="product-content">
								<p class="title">${product.productName}</p>
								<p class="cost">${product.orderPrice}원<span>${product.productPrice}월</span></p>
								<p>수량 ${product.orderQuantity}개</p>
							</div>
							<div class="product-end">
								<button onclick="location.href='${pageContext.request.contextPath}/mypage/order-return/${orderDetailInquiry[0].orderCode}' ">반품 / 교환</button>
							</div>
						</div>
						<c:set var="totalOrderPrice" value="${totalOrderPrice + product.orderPrice}" />
        				<c:set var="totalProductPrice" value="${totalProductPrice + product.productPrice}" />
					</c:forEach>
				</div>					
				
				<div class="delivery-address">
					<p class="section-name">배송지 정보</p>
					<div class="my-container">
						<div><p>이름</p><a>${orderDetailInquiry[0].recipient}</a></div>
						
						<div><p>연락처</p><a>${orderDetailInquiry[0].phoneNumber}</a></div>
						<div><p>배송지 주소</p><a>${orderDetailInquiry[0].address}</a></div>
						<div><p>배송 메세지</p><a>${orderDetailInquiry[0].deliveryMemo}</a></div>
					</div>
				</div>
				
				<div class="payment_info">
				    <p class="section-name">결제 정보</p>
				    <div class="my-container">
				        <div><p>주문 금액</p><a>${totalOrderPrice}원</a></div>
				        
				        <c:choose>
				            <c:when test="${totalOrderPrice >= 50000}">
				                <div><p>배송비 합계</p><a>0원</a></div>
				            </c:when>
				            <c:otherwise>
				                <div><p>배송비 합계</p><a>3000원</a></div>
				            </c:otherwise>
				        </c:choose>
				        
				        <div><p>할인 합계</p><a>${totalProductPrice - totalOrderPrice}원</a></div>
				        <div><p>최종 결제 금액</p><a>${totalOrderPrice + (totalOrderPrice >= 50000 ? 0 : 3000)}원</a></div>
				    </div>
				</div>
				
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/views/collection/footer.jsp"%>
</body>

</html>
