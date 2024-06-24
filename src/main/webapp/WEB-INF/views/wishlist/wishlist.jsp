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
<title>WishList</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="wrapper">
		<div style="display: flex;">
			<div>
				<%@ include file="/WEB-INF/views/common/mypage-nav.jsp"%>
			</div>
			<div class="height_line"></div>
			<div class="wishlist_section">
				<div class="title">위시리스트</div>
				<div class="width_line"></div>
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
							<div class="heart_cnt">
								<div>
									<img
										src="${pageContext.request.contextPath}/static/img/heart.svg">
								</div>
								<div>10</div>
							</div>
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
							<div class="heart_cnt">
								<div>
									<img
										src="${pageContext.request.contextPath}/static/img/heart.svg">
								</div>
								<div>10</div>
							</div>
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
							<div class="heart_cnt">
								<div>
									<img
										src="${pageContext.request.contextPath}/static/img/heart.svg">
								</div>
								<div>10</div>
							</div>
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
							<div class="heart_cnt">
								<div>
									<img
										src="${pageContext.request.contextPath}/static/img/heart.svg">
								</div>
								<div>10</div>
							</div>
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
							<div class="heart_cnt">
								<div>
									<img
										src="${pageContext.request.contextPath}/static/img/heart.svg">
								</div>
								<div>10</div>
							</div>
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
							<div class="heart_cnt">
								<div>
									<img
										src="${pageContext.request.contextPath}/static/img/heart.svg">
								</div>
								<div>10</div>
							</div>
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
							<div class="heart_cnt">
								<div>
									<img
										src="${pageContext.request.contextPath}/static/img/heart.svg">
								</div>
								<div>&nbsp;10</div>
							</div>
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
							<div class="heart_cnt">
								<div>
									<img
										src="${pageContext.request.contextPath}/static/img/heart.svg">
								</div>
								<div>10</div>
							</div>
						</div>
					</div>
				</div>

				<div class="page">
					<img src="${pageContext.request.contextPath}/static/img/left.svg">
					<div>
						<div>1</div>
						<div>2</div>
						<div>3</div>
					</div>
					<img src="${pageContext.request.contextPath}/static/img/right.svg">
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>

</html>
