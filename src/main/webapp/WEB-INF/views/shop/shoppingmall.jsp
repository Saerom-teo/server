<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/vars.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/shoppingmall.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">
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

.header {
	position: fixed; 
	top: 0;
	width: 100% ;
	z-index: 1000;
}
</style>
<title>Shoppingmall</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="shoppingmall">	
		<%@ include file="/WEB-INF/views/common/shopnav.jsp"%>
		<div class="body">
			<div class="title">의류</div>
			<div class="category-div">
				<div class="category">
					<div class="div2">정렬 ▼</div>
				</div>
			</div>
			<div class="shopbody">
				<div class="item-container">
					<div class="item">
						<img
							src="${pageContext.request.contextPath}/static/img/product-img.png"
							class="item-image">
						<div class="item-details">
							<p>[소락] 오가닉 코튼 자수 손수건</p>
							<div class="price-container">
								<div>5000원</div>
								<div class="original-price">&nbsp;7000원</div>
							</div>
							<span class="sale">SALE</span> <span class="best">BEST</span>
							
						</div>
					</div>

					<div class="item">
						<img
							src="${pageContext.request.contextPath}/static/img/product-img.png"
							class="item-image">
						<div class="item-details">
							<p>[소락] 오가닉 코튼 자수 손수건</p>
							<div class="price-container">
								<div>5000원</div>
								<div class="original-price">&nbsp;7000원</div>
							</div>
							<span class="sale">SALE</span> <span class="best">BEST</span>
						
						</div>
					</div>
					<div class="item">
						<img
							src="${pageContext.request.contextPath}/static/img/product-img.png"
							class="item-image">
						<div class="item-details">
							<p>[소락] 오가닉 코튼 자수 손수건</p>
							<div class="price-container">
								<div>5000원</div>
								<div class="original-price">&nbsp;7000원</div>
							</div>
							<span class="sale">SALE</span> <span class="best">BEST</span>
							
						</div>
					</div>
					<div class="item">
						<img
							src="${pageContext.request.contextPath}/static/img/product-img.png"
							class="item-image">
						<div class="item-details">
							<p>[소락] 오가닉 코튼 자수 손수건</p>
							<div class="price-container">
								<div>5000원</div>
								<div class="original-price">&nbsp;7000원</div>
							</div>
							<span class="sale">SALE</span> <span class="best">BEST</span>
							
						</div>
					</div>
				</div>

				<div class="item-container">
					<div class="item">
						<img
							src="${pageContext.request.contextPath}/static/img/product-img.png"
							class="item-image">
						<div class="item-details">
							<p>[소락] 오가닉 코튼 자수 손수건</p>
							<div class="price-container">
								<div>5000원</div>
								<div class="original-price">&nbsp;7000원</div>
							</div>
							<span class="sale">SALE</span> <span class="best">BEST</span>
						
						</div>
					</div>

					<div class="item">
						<img
							src="${pageContext.request.contextPath}/static/img/product-img.png"
							class="item-image">
						<div class="item-details">
							<p>[소락] 오가닉 코튼 자수 손수건</p>
							<div class="price-container">
								<div>5000원</div>
								<div class="original-price">&nbsp;7000원</div>
							</div>
							<span class="sale">SALE</span> <span class="best">BEST</span>
							
						</div>
					</div>
					<div class="item">
						<img
							src="${pageContext.request.contextPath}/static/img/product-img.png"
							class="item-image">
						<div class="item-details">
							<p>[소락] 오가닉 코튼 자수 손수건</p>
							<div class="price-container">
								<div>5000원</div>
								<div class="original-price">&nbsp;7000원</div>
							</div>
							<span class="sale">SALE</span> <span class="best">BEST</span>
							
						</div>
					</div>
					<div class="item">
						<img
							src="${pageContext.request.contextPath}/static/img/product-img.png"
							class="item-image">
						<div class="item-details">
							<p>[소락] 오가닉 코튼 자수 손수건</p>
							<div class="price-container">
								<div>5000원</div>
								<div class="original-price">&nbsp;7000원</div>
							</div>
							<span class="sale">SALE</span> <span class="best">BEST</span>
							
						</div>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>

</body>
</html>