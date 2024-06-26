<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>

<!-- <style>
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
</style> -->

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

<script>
    $(document).ready(function() {
        var selectedPeriod = null; // 선택된 기간을 저장할 변수

        // 기간 버튼 클릭 이벤트
        $("._1-year ._1, ._3-months ._12, ._1-month ._12, ._1-week ._12").click(function() {
            selectedPeriod = $(this).parent().attr('class').split(' ')[0]; // 클래스 이름으로부터 기간 추출
            alert(selectedPeriod); // 선택된 기간을 확인하는 alert (디버깅용)
        });

        // 조회하기 버튼 클릭 이벤트
        $(".search").click(function() {
            var startDate = $(".start-date-text").val();
            var endDate = $(".end-date-text").val();

            var requestData = {};

            // 데이터 검증 및 요청 데이터 설정
            if (selectedPeriod) {
                var today = new Date();
                var calculatedStartDate;

                switch (selectedPeriod) {
                    case "_1-year":
                        calculatedStartDate = new Date(today.setFullYear(today.getFullYear() - 1));
                        break;
                    case "_3-months":
                        calculatedStartDate = new Date(today.setMonth(today.getMonth() - 3));
                        break;
                    case "_1-month":
                        calculatedStartDate = new Date(today.setMonth(today.getMonth() - 1));
                        break;
                    case "_1-week":
                        calculatedStartDate = new Date(today.setDate(today.getDate() - 7));
                        break;
                    default:
                        calculatedStartDate = null;
                }

                if (calculatedStartDate) {
                    requestData.startDate = calculatedStartDate.toISOString().split('T')[0]; // yyyy-mm-dd 형식으로 변환
                    requestData.endDate = new Date().toISOString().split('T')[0];
                }
            } else if (startDate && endDate) {
                requestData.startDate = startDate;
                requestData.endDate = endDate;
            } else {
                alert("기간을 선택하거나 시작 날짜와 종료 날짜를 입력하세요.");
                return;
            }

            $.ajax({
                url: '${path}/orderInquiry/byPeriod',
                method: 'GET',
                data: requestData,
                success: function(response) {
                    // 기존 주문 목록을 새로운 내용으로 업데이트
                    $(".order-inquiry-list").html(response);
                },
                error: function(error) {
                    console.log("Error:", error);
                }
            });
        });
    });
</script>



<title>Document</title>
</head>
<body>
	<div class="mypage-orderlist">
    <div class="body">
        <div class="order-inquiry">
            <div class="order-inquiry-head">
                <div class="div">주문조회</div>
            </div>
            <div class="order-inquiry-option">
                <div class="_1-year">
                    <div class="_1">최근 1년</div>
                </div>
                <div class="_3-months">
                    <div class="_12">3개월</div>
                </div>
                <div class="_1-month">
                    <div class="_12">1개월</div>
                </div>
                <div class="_1-week">
                    <div class="_12">1주일</div>
                </div>
                <div class="date-container">
                    <div class="date-input start-date">
                        <input type="text" class="start-date-text" placeholder="연도 - 월 - 일">
                    </div>
                    <span>-</span>
                    <div class="date-input end-date">
                        <input type="text" class="end-date-text" placeholder="연도 - 월 - 일">
                    </div>
                </div>

                <script>
                    $(function() {
                        $(".start-date-text").datepicker({
                            dateFormat: "yy-mm-dd"
                        });
                        $(".end-date-text").datepicker({
                            dateFormat: "yy-mm-dd"
                        });
                    });
                </script>

                <div class="search">
                    <div class="_15">조회하기</div>
                </div>
            </div>
            <div class="order-inquiry-list">
                <c:forEach var="orderDetail" items="${orderList}">
                    <c:if test="${not empty orderDetail.products}">
                        <div class="order-list">
                        <div class="div2">주문상세 &gt;</div>
                            <div class="order-status-cancel">
                                <div class="order-status">
									<c:choose>
                                       <c:when test="${orderDetail.order.orderStatus == 'PAYMENT_COMPLETED'}"><strong>주문 완료</strong></c:when>
								       <c:when test="${orderDetail.order.orderStatus == 'SHIPPING'}"><strong>배송중</strong></c:when>
								       <c:when test="${orderDetail.order.orderStatus == 'DELIVERED'}"><strong>배송완료</strong></c:when>
       									<c:otherwise><strong>${orderDetail.order.orderStatus}</strong></c:otherwise>
                                    </c:choose></div>
                                <div class="order-cancel">
                                    <div class="div4">주문 취소</div>
                                </div>
                            </div>
                            <div class="order-date">
                                <span class="order-date-span">${orderDetail.order.orderDate}</span>
                            </div>
                            <div class="products">
                                <c:forEach var="product" items="${orderDetail.products}">
                                    <div class="order-detail-board">
                                        <img class="product-img" src="${product.productImgUrl}" alt="${product.productName}" />
                                        <div class="order-detail">
                                            <div class="productName">
                                                <span class="productName-span">${product.productName}</span>
                                            </div>
                                            <div class="productprice">
                                                <c:set var="totalOrderPrice" value="${product.orderPrice * product.orderQuantity}" />
                                                <span class="productprice-span">${totalOrderPrice}원 (${product.orderQuantity}개)</span>
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

</body>
</html>