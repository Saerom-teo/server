<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/css/orderInquiry.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/vars.css">

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
      border: 1px solid var(--primary, #499268);
      border-radius: 10px; 
      padding: 10px; 
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .ui-datepicker-header {
      background: var(--primary, #499268);
      color: #fff; 
      padding: 5px 0; 
      border-bottom: 1px solid var(--primary, #499268);
    }

    .ui-datepicker-title {
      font-size: 16px; 
      font-weight: bold; 
    }

    .ui-datepicker .ui-datepicker-prev, 
    .ui-datepicker .ui-datepicker-next {
      color: var(--primary, #499268);
      border: 1px solid var(--primary, #499268);
      border-radius: 50%; 
      width: 20px; 
      height: 20px; 
    }

    .ui-datepicker .ui-datepicker-prev:hover, 
    .ui-datepicker .ui-datepicker-next:hover {
      background: var(--primary, #499268);
      color: #fff;
    }

    .ui-datepicker-calendar {
      margin: 10px 0; 
    }

    .ui-datepicker-calendar th {
      color: var(--primary, #499268);
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
      background: var(--primary, #499268);
      border-color: var(--primary, #499268);
      color: #fff; 
    }

    .ui-datepicker-calendar .ui-state-highlight {
      background: #ffd700; 
      color: #000; 
    }

    .ui-datepicker-calendar .ui-state-active {
      background: var(--primary, #499268);
      border-color:var(--primary, #499268);
      color: #fff; 
    }
  </style>

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
							<input type="text" class="start-date-text"
								placeholder="연도 - 월 - 일">
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
					<div class="order-list">
						<div class="div2">주문상세 &gt;</div>
						<div class="order-status">
							<div class="div3">결제완료</div>
							<div class="order-cancel">
								<div class="div4">주문 취소</div>
							</div>
						</div>
						<div class="order-detail-board">
							<img class="product-img" src="product-img0.png" />
							<div class="order-detail">
								<div class="_2024-02-12-12-08-25">
									<span> <span class="_2024-02-12-12-08-25-span">
											2024.02.12. 12:08:25 결제 </span> <span
										class="_2024-02-12-12-08-25-span2"></span> <span
										class="_2024-02-12-12-08-25-span3"></span> <span
										class="_2024-02-12-12-08-25-span4"></span> <span
										class="_2024-02-12-12-08-25-span5"></span>
									</span>
								</div>
								<div class="div5">
									<span> <span class="div-5-span">[소락] 오가닉 코튼 자수
											손수건</span> <span class="div-5-span2"></span>
									</span>
								</div>
								<div class="_5000">
									<span> <span class="_5000-span">5000원</span> <span
										class="_5000-span2"></span> <span class="_5000-span3"></span>
									</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>