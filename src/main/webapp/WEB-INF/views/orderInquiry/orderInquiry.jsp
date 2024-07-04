<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>


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

.ui-datepicker {
	background: #f5f5f5;
	border: 1px solid var(- -primary, #499268);
	border-radius: 10px;
	padding: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.ui-datepicker-header {
	background: var(- -primary, #499268);
	color: #fff;
	padding: 5px 0;
	border-bottom: 1px solid var(- -primary, #499268);
}

.ui-datepicker-title {
	font-size: 16px;
	font-weight: bold;
}

.ui-datepicker .ui-datepicker-prev, .ui-datepicker .ui-datepicker-next {
	color: var(- -primary, #499268);
	border: 1px solid var(- -primary, #499268);
	border-radius: 50%;
	width: 20px;
	height: 20px;
}

.ui-datepicker .ui-datepicker-prev:hover, .ui-datepicker .ui-datepicker-next:hover
	{
	background: var(- -primary, #499268);
	color: #fff;
}

.ui-datepicker-calendar {
	margin: 10px 0;
}

.ui-datepicker-calendar th {
	color: var(- -primary, #499268);
}

.ui-datepicker-calendar td {
	padding: 5px;
}

.ui-datepicker-calendar .ui-state-default {
	background: #fff;
	border: none;
	border-radius: 5px;
	color: #333;
}

.ui-datepicker-calendar .ui-state-default:hover {
	background: var(- -primary, #499268);
	border-color: var(- -primary, #499268);
	color: #fff;
}

.ui-datepicker-calendar .ui-state-highlight {
	background: #ffd700;
	color: #000;
}

.ui-datepicker-calendar .ui-state-active {
	background: var(- -primary, #499268);
	border-color: var(- -primary, #499268);
	color: #fff;
}
</style>

<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/css/orderInquiry.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/vars.css">



<title>Document</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="mypage-orderlist">
		<div style="display: flex;">
			<div>
				<%@ include file="/WEB-INF/views/common/mypage-nav.jsp"%>
			</div>
			<div class="body">
				<div class="order-inquiry">
					<div class="order-inquiry-head">
						<div class="div">주문조회</div>
					</div>
					<div class="order-inquiry-option">
						<div class="_1-week">
							<div class="_12">1주일</div>
						</div>
						<div class="_1-month">
							<div class="_12">1개월</div>
						</div>
						<div class="_3-months">
							<div class="_12">3개월</div>
						</div>

						<div class="_1-year">
							<div class="_1">최근 1년</div>
						</div>




						<div class="date-container">
							<div class="date-input start-date">
								<input type="text" class="start-date-text"
									placeholder="연도 - 월 - 일">
							</div>
							<span>-</span>
							<div class="date-input end-date">
								<input type="text" class="end-date-text"
									placeholder="연도 - 월 - 일">
							</div>
						</div>


						<div class="inquiry-search">
							<div class="_15">조회하기</div>
						</div>
					</div>
					<div class="order-inquiry-list">
						<c:forEach var="orderDetail" items="${orderList}">
							<c:if test="${not empty orderDetail.products}">
								<div class="order-list">
									<div class="div2 order-detail-button"
										data-order-code="${orderDetail.order.orderCode}">주문상세
										&gt;</div>
									<div class="order-status-cancel">
										<div class="order-status">
											<c:choose>
												<c:when
													test="${orderDetail.order.orderStatus == 'PAYMENT_COMPLETED'}">
													<strong>주문 완료</strong>
												</c:when>
												<c:when
													test="${orderDetail.order.orderStatus == 'SHIPPING'}">
													<strong>배송중</strong>
												</c:when>
												<c:when
													test="${orderDetail.order.orderStatus == 'DELIVERED'}">
													<strong>배송완료</strong>
												</c:when>
												<c:otherwise>
													<strong>${orderDetail.order.orderStatus}</strong>
												</c:otherwise>
											</c:choose>
										</div>

									</div>
									<div class="order-date">
										<span class="order-date-span">${orderDetail.order.orderDate}</span>
									</div>
									<div class="products">
										<c:forEach var="product" items="${orderDetail.products}">
											<div class="order-detail-board">
												<img class="product-img" src="${product.productImgUrl}"
													alt="${product.productName}" />
												<div class="order-detail">
													<div class="productName">
														<span class="productName-span">${product.productName}</span>
													</div>
													<div>
														<span class="orderQuantity">${product.orderQuantity}개</span>
													</div>
													<div class="productprice ">
														<c:set var="totalOrderPrice"
															value="${product.orderPrice * product.orderQuantity}" />
														<c:set var="totalProductPrice"
															value="${product.productPrice * product.orderQuantity}" />
														<span class="orderprice-span">${totalOrderPrice}원 </span>
														<c:if test="${totalOrderPrice != totalProductPrice}">
															<span class="originalprice-span">${totalProductPrice}원</span>
														</c:if>
													</div>
												</div>
											</div>
										</c:forEach>
									</div>
								</div>
							</c:if>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	<script>
	
	$(document).ready(function() {
	
		var arr = [];
		<c:forEach var="orderDetail" items="${orderList}" >
		arr.push({order:'${orderDetail}'});
		</c:forEach>
		console.log(arr);
		
		 $('.order-inquiry-list').on('click', '.order-detail-button', function() {
             var orderCode = $(this).data('order-code');
             window.location.href = '${path}/orderInquiry/orderDetail?orderCode=' + orderCode;
         });
		 
		

		 
	    $("._1-year ._1, ._3-months ._12, ._1-month ._12, ._1-week ._12").click(function() {
	        var period = $(this).parent().attr('class').split(' ')[0]; // 클래스 이름으로부터 기간 추출
	        var endDate = new Date();
	        var startDate = new Date();
	
	        // 현재 날짜를 종료 날짜로 지정
	        var formattedEndDate = formatDate(endDate);
	
	        // 기간에 따라 시작 날짜를 계산
	        switch (period) {
	            case '_1-week':
	                startDate.setDate(endDate.getDate() - 7);
	                break;
	            case '_1-month':
	                startDate.setMonth(endDate.getMonth() - 1);
	                break;
	            case '_3-months':
	                startDate.setMonth(endDate.getMonth() - 3);
	                break;
	            case '_1-year':
	                startDate.setFullYear(endDate.getFullYear() - 1);
	                break;
	        }
	
	        var formattedStartDate = formatDate(startDate);
	        
			
	        $.ajax({
	            url: '${path}/orderInquiry/byPeriod',
	            method: 'GET',
	            data: {
	                start: formattedStartDate,
	                end: formattedEndDate
	            },
	            success: function(response) {
	            	
                    
                    const orderListHtml = response.map(orderDetail => {
                    	
	                    let timeStamp = orderDetail.order.orderDate;
	                    let clientDate = new Date(timeStamp);
	                    let stringDate = formatOrderDate(clientDate);
	                   
                    	let orderStatusText;
                    switch(orderDetail.order.orderStatus) {
                        case 'PAYMENT_COMPLETED':
                            orderStatusText = `<strong>주문 완료</strong>`;
                            break;
                        case 'SHIPPING':
                            orderStatusText = `<strong>배송중</strong>`;
                            break;
                        case 'DELIVERED':
                            orderStatusText = `<strong>배송완료</strong>`;
                            break;
                        default:
                            orderStatusText = `<strong>${orderDetail.order.orderStatus}</strong>`;
                            break;
                    }
                    const productsHtml = orderDetail.products.map(product => {
                        	
                    	const totalOrderPrice = product.orderPrice * product.orderQuantity;
                        const totalProductPrice = product.productPrice * product.orderQuantity;
                        const originalPriceHtml = (totalOrderPrice !== totalProductPrice) ? `<span class="originalprice-span">\${totalProductPrice}원</span>` : ''; 
                        
                            return `
                                <div class="order-detail-board">
                                    <img class="product-img" src="\${product.productImgUrl}" alt="${product.productName}" />
                                    <div class="order-detail">
                                        <div class="productName">
                                            <span class="productName-span">\${product.productName}</span>
                                        </div>
                                        <div>
                                        <span class="orderQuantity">\${product.orderQuantity}개</span>
                                        </div>
                                        <div class="productprice">
                                            <span class="orderprice-span">\${totalOrderPrice}원</span>
                                            \${originalPriceHtml}
                                            
                                           
                                            </div>
                                    </div>
                                </div>
                            `;
                        }).join('');
						
                        return `
                            <div class="order-list">
                        	<div class="div2 order-detail-button" data-order-code="${orderDetail.order.orderCode}">주문상세 &gt;</div>
                                <div class="order-status-cancel">
                                    <div class="order-status">
                                        \${orderStatusText}
                                    </div>
                                  
                                </div>
                                <div class="order-date">
                                    <span class="order-date-span">\${stringDate}</span>
                                </div>
                                <div class="products">
                                    \${productsHtml}
                                </div>
                            </div>
                        `;
                    }).join('');
                
                    $(".order-inquiry-list").html(orderListHtml);
                },
	            error: function(error) {
	                console.error("Error fetching data", error);
	            }
	        });
	    });
	    
	    $(".start-date-text").datepicker({
            dateFormat: "yy-mm-dd"
        });
        $(".end-date-text").datepicker({
            dateFormat: "yy-mm-dd"
        });

	   
        
        
        $(".search ._15").on("click", function() {
            const startDate = $(".start-date-text").val();
            const endDate = $(".end-date-text").val();

            if (!startDate && !endDate) {
                alert("시작 날짜와 종료 날짜를 선택해주세요");
            } else if (!startDate) {
                alert("시작 날짜를 선택해주세요");
            } else if (!endDate) {
                alert("종료 날짜를 선택해주세요");
            } else {
          		
                $.ajax({
                    url: '${path}/orderInquiry/byPeriod',
                    method: 'GET',
                    data: {
                        start: startDate,
                        end: endDate
                    },
                    success: function(response) {
                    	const orderListHtml = response.map(orderDetail => {
                    		let timeStamp = orderDetail.order.orderDate;
    	                    let clientDate = new Date(timeStamp);
    	                    let stringDate = formatOrderDate(clientDate);
                    		let orderStatusText;
                            switch(orderDetail.order.orderStatus) {
                                case 'PAYMENT_COMPLETED':
                                    orderStatusText = `<strong>주문 완료</strong>`;
                                    break;
                                case 'SHIPPING':
                                    orderStatusText = `<strong>배송중</strong>`;
                                    break;
                                case 'DELIVERED':
                                    orderStatusText = `<strong>배송완료</strong>`;
                                    break;
                                default:
                                    orderStatusText = `<strong>${orderDetail.order.orderStatus}</strong>`;
                                    break;
                            }
                            
                            const productsHtml = orderDetail.products.map(product => {
                            	let orderStatusText;
                                switch(orderDetail.order.orderStatus) {
                                    case 'PAYMENT_COMPLETED':
                                        orderStatusText = '<strong>주문 완료</strong>';
                                        break;
                                    case 'SHIPPING':
                                        orderStatusText = '<strong>배송중</strong>';
                                        break;
                                    case 'DELIVERED':
                                        orderStatusText = '<strong>배송완료</strong>';
                                        break;
                                    default:
                                        orderStatusText = `<strong>${orderDetail.order.orderStatus}</strong>`;
                                        break;
                                }
                                const totalOrderPrice = product.orderPrice * product.orderQuantity;        
                                const totalProductPrice = product.productPrice * product.orderQuantity;   
                                return `
                                    <div class="order-detail-board">
                                        <img class="product-img" src="\${product.productImgUrl}" alt="${product.productName}" />
                                        <div class="order-detail">
                                            <div class="productName">
                                                <span class="productName-span">\${product.productName}</span>
                                                
                                            </div>
                                            <div>
                                            <span class="orderQuantity">\${product.orderQuantity}개</span>
                                            </div>
                                            <div class="productprice">
                                                <span class="orderprice-span">\${totalOrderPrice}원 </span>
                                                <span class="originalprice">\${originalPrice}원</span>
                                               
                                            </div>
                                        </div>
                                    </div>
                                `;
                            }).join('');
    			
                            return `
                                <div class="order-list">
                            	<div class="div2 order-detail-button" data-order-code="${orderDetail.order.orderCode}">주문상세 &gt;</div>
                                    <div class="order-status-cancel">
                                        <div class="order-status">
                                            ${orderStatusText}
                                        </div>
                                       
                                    </div>
                                    <div class="order-date">
                                        <span class="order-date-span">\${stringDate}</span>
                                    </div>
                                    <div class="products">
                                        \${productsHtml}
                                    </div>
                                </div>
                            `;
                        }).join('');
                        
                        $(".order-inquiry-list").html(orderListHtml);
                    },
                    error: function(error) {
                        console.error("Error fetching data", error);
                    }
                });
            }
        });
        
	    function formatDate(date) {
	        var year = date.getFullYear();
	        var month = (date.getMonth() + 1).toString().padStart(2, '0');
	        var day = date.getDate().toString().padStart(2, '0');
	        return year + '-' + month + '-' + day;
	    }
	    
	    
	    function formatPrice(number) {
	        return number.toLocaleString('ko-KR');
	    }

	    
	    function formatOrderDate(date) {
	    	
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const day = String(date.getDate()).padStart(2, '0');
            const hours = String(date.getHours()).padStart(2, '0');
            const minutes = String(date.getMinutes()).padStart(2, '0');
            const seconds = String(date.getSeconds()).padStart(2, '0');
            const milliseconds = String(Math.floor(date.getMilliseconds() / 10)).padStart(1, '0'); // 밀리초를 1자리로 맞추기 위해
			

            return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds + '.' + milliseconds;
        }
	    
	});
        
    </script>

</body>


</html>