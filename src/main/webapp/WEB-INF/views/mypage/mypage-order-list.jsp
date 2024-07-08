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
    <title>마이페이지 - 주문 내역 | 새롬터</title>
    
    <style>
        #order-list{
        	margin-top: 40px;
        	margin-bottom: 80px;
        	padding-left: 35px;
        }
        .category {
			box-sizing: border-box;
		    margin: 20px 0;
		    display: flex;
		    flex-direction: row;
		    justify-content: space-between;
        }
        
		 .category a {
            border: 1px solid var(--primary);
            border-radius: 8px;
            padding: 4px 25px;
            margin: 0 5px;
            cursor: pointer;
            text-decoration: none;
            color: var(--black);
            font-size: 14px;
        }
        
        
        .category a:hover {
			background-color: var(--tertiary);    
        }
        .category input {
        	border: 1px solid var(--primary);
        	padding: 4px 20px;
        	border-radius: 8px;
        	color: var(--black);
        	margin: 0 5px;
        }
        .category input:hover {
			background-color: var(--tertiary);
        }
        
        .category input:focus  {
			border-color: var(--primary);
        }
        .category button  {
			background-color: var(--primary);
			color: #fff;
			padding: 4px 20px;
			border-radius: 8px;
			font-size: 14px;
        }
        
        
        .order-box {
        	color: var(--black);
        	font-weight: 500;
        	border: 1px solid var(--gray);
        	border-radius: 15px;
        	padding: 20px;
        	margin: 20px 0;
        }
        .order-box:hover {
			background: #F9F9F9;
        }
         .order-box .type {
			margin-bottom: 10px;
			color: var(--black);
			font-size: 20px;
			font-weight: bold;
        }
        .order-content {
        	display: flex;
        	gap: 15px;
        }        
        .order-content img {
        	width: 150px;
        	height: 150px;
        	border-radius: 10px;
        }
        .order-content {
        	margin: 5px 0;
        }
        .order-content .day {
        	color: var(--gray);
        	font-size: 14px;
        }
        .order-content .title {
        	font-size: 16px;
        }
        .order-content .cost {
        	font-size: 14px;
        }
        .order-content span {
        	text-decoration: line-through;
        	color: var(--gray);
        	font-size: 12px;
        	margin: 0 5px;
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
                <h1>주문내역</h1>
            </div>
            <div id="order-list">
            	<div class="category">
            		<div>
						<a href="?type=all" id="year" class="">최근 1년</a>
            			<a href="?type=week" id="week" class="">1주일</a>
            			<a href="?type=one-month" id="one-month" class="">1개월</a>
            			<a href="?type=three-month" id="three-month" class="">3개월</a>
            		</div>
            		<div>
			            <input type="date" id="startDate"></input>
			            <input type="date" id="endDate"></input>
			            <button onclick="searchByDate()">조회하기</button>
            		</div>
            	</div>
                <div id="order-table">
                    
                     <c:forEach var="order" items="${orderList}" varStatus="status">
	                    <div class="order-box">
							<p class="type">
								<c:choose>
									<c:when test="${order.order.orderStatus == 'PAYMENT_COMPLETED'}">결제 완료</c:when>
									<c:when test="${order.order.orderStatus == 'SHIPPING'}">배송 중</c:when>
									<c:when test="${order.order.orderStatus == 'DELIVERED'}">배송 완료</c:when>
									<c:when test="${order.order.orderStatus == 'PAYMENT_CONFIRMED'}">구매확정 완료</c:when>
									<c:when test="${order.order.orderStatus == 'RETURN_REFUND_COMPLETED'}">반품환불 완료</c:when>
									<c:otherwise>알 수 없음</c:otherwise>
								</c:choose>
							</p>
	                    	<div class="order-content">
	                   			<img src="${order.products[0].productImgUrl}">
	                    		<div class="order-info">
	                    			<div>
		                    			<p class="day">${order.order.orderDate} 결제</p>
		                    			<p class="title">${order.products[0].productName} 외 <c:out value="${fn:length(order.products)}"/>개</p>
		                    			<p class="cost">${order.products[0].orderPrice}원<span>${order.products[0].productPrice}원</span></p>
	                    			</div>
	                    			<div>
		                    			<a href="${pageContext.request.contextPath}/mypage/order-detail/${order.order.orderCode}" class="order-detail">주문상세 ></a><br>
	                    			</div>
	                    			<div>
		                    			
									<c:choose>
										<c:when test="${order.order.orderStatus == 'PAYMENT_COMPLETED'}"><button class="order-button">주문취소</button></c:when>
										<c:when test="${order.order.orderStatus == 'SHIPPING'}"><button class="order-button">배송조회</button></c:when>
										<c:when test="${order.order.orderStatus == 'DELIVERED'}"><button class="order-button">배송조회</button><button class="order-button">교환 / 반품 신청</button></c:when>
										<c:when test="${order.order.orderStatus == 'PAYMENT_CONFIRMED'}"><button class="order-button">리뷰쓰기</button></c:when>
										<c:when test="${order.order.orderStatus == 'RETURN_REFUND_COMPLETED'}"><button class="order-button">???</button></c:when>
									</c:choose>
		                    			
	                    			</div>
	                    		</div>
	                    		<div class="question">
	                    			<a href="${pageContext.request.contextPath}/question/readAll">문의 ></a>
	                    		</div>
	                    	</div>
	                    </div>
                     </c:forEach>
                    
                </div>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/views/collection/footer.jsp"%>
</body>

</html>
