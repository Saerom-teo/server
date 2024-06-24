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
	href="${pageContext.request.contextPath}/static/css/review.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">
<title>Review</title>
<script></script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="wrapper">
		<div style="display: flex; ">
			<div>
				<%@ include file="/WEB-INF/views/common/mypage-nav.jsp"%>
			</div>
			<div class="height_line"></div>
			<div class="review_section">
				<div class="title">구매후기</div>
				<div class="width_line"></div>
				<div class="review_log">
					<div class="sub_title">후기 내역</div>
					<div class="period">
						<div class="lastest_period">
							<div>최근 1년</div>
							<div>1주일</div>
							<div>1개월</div>
							<div>3개월</div>
						</div>
						<div class="calendar">
							<div>
								<div>연도 - 월 - 일</div>
								<img
									src="${pageContext.request.contextPath}/static/img/date.svg">
							</div>
							<p class="width_line3"></p>
							<div>
								<div>연도 - 월 - 일</div>
								<img
									src="${pageContext.request.contextPath}/static/img/date.svg">
							</div>
						</div>
						<div class="btn_search">조회하기</div>
					</div>
				</div>
				<div class="item-container">
					<div class="item">
						<div class="item-info">
							<img
								src="${pageContext.request.contextPath}/static/img/product-img.png"
								class="item-image">
							<p>[소락] 오가닉 코튼 자수 손수건</p>
								<div class="written">2024.05.29 작성</div>
								<div class="delete-btn">✕</div>
							
						</div>
						<div class="width_line2"></div>
						<div class="star">
							<img src="${pageContext.request.contextPath}/static/img/star.svg">
							<img src="${pageContext.request.contextPath}/static/img/star.svg">
							<img src="${pageContext.request.contextPath}/static/img/star.svg">
							<img src="${pageContext.request.contextPath}/static/img/star.svg">
							<img
								src="${pageContext.request.contextPath}/static/img/star2.svg">
							<div class="num">4</div>
						</div>
						<div class="review_w">
							후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기
							후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기
						</div>
						<div style="display: flex; justify-content: space-between;">
							<img src="${pageContext.request.contextPath}/static/img/son.png"
								class="item-image2">
							<div class="modify">수정하기</div>
						</div>
					</div>
					<div class="item">
						<div class="item-info">
							<img
								src="${pageContext.request.contextPath}/static/img/product-img.png"
								class="item-image">
							<p>[소락] 오가닉 코튼 자수 손수건</p>
							<div class="written">2024.05.29 작성</div>
							<button class="delete-btn">✕</button>
						</div>
						<div class="width_line2"></div>
						<div class="star">
							<img src="${pageContext.request.contextPath}/static/img/star.svg">
							<img src="${pageContext.request.contextPath}/static/img/star.svg">
							<img src="${pageContext.request.contextPath}/static/img/star.svg">
							<img
								src="${pageContext.request.contextPath}/static/img/star2.svg">
							<img
								src="${pageContext.request.contextPath}/static/img/star2.svg">
							<div class="num">3</div>
						</div>
							<div class="review_w">
							후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기
							후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기작성후기
						</div>
						<div style="display: flex; justify-content: space-between;">
							<img src="" class="">
							<div class="modify">수정하기</div>
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
