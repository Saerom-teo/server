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
<script>
	function deleteReview(reviewId) {
		if(confirm("작성한 후기를 삭제하시겠습니까?"))
		$.ajax({
			url:"/app/review/deleteReview/" + reviewId,
			type: "DELETE",
			success: function(response) {
				alert("후기를 삭제하였습니다.");
				location.href = "/app/review"
			}, error: function(xhr, status, error) {
				alert("삭제 실패");
			}
		})
	}
	
	function readDate(standard) {
		$.ajax({
			url:"/app/review/readByDate",
			type: "GET",
			data: {
				"standard":standard
			},
			success: function(response) {
				alert("성공");
			}, error: function(xhr, status, error) {
				alert("로딩 실패");
			}
		})
		
	}
	
	function readBetweenDate() {
		var startDate = $(".startdate").val();
		var endDate = $(".enddate").val();
		var endDate
		$.ajax({
			url:"/app/review/readByBetweenDate",
			type: "GET",
			data: {
				"startDate" : startDate,
				"endDate" : endDate
			},
			success: function(response) {
				alert("성공");
			}, error: function(xhr, status, error) {
				alert("생성 실패");
			}
		})
		
	}

</script>
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
							<div onclick="readDate(365)">최근 1년</div>
							<div onclick="readDate(7)">1주일</div>
							<div onclick="readDate(30)">1개월</div>
							<div onclick="readDate(90)">3개월</div>
						</div>
						<div class="calendar">
							<input class="startdate" type="date" placeholder="연도 - 월 - 일">
							<p class="width_line3"></p>
							<input class="enddate" type="date" placeholder="연도 - 월 - 일">
						</div>
						<div class="btn_search" onclick="readBetweenDate()">조회하기</div>
					</div>
				</div>
				<div class="item-container">
					<c:forEach var="review" items="${reviewList}">
					<div class="item">
						<div class="item-info">
							<img
								src="${pageContext.request.contextPath}/static/img/product-img.png"
								class="item-image">
							<p>[소락] 오가닉 코튼 자수 손수건</p>
								<div class="written">${review.writeDate} 작성</div>
								<div class="delete-btn" onclick="deleteReview(${review.reviewId})">✕</div>
							
						</div>
						
						<div class="width_line2"></div>
						<div class="star">
							<c:forEach begin="0" end="${review.reviewScore-1}">
							<img src="${pageContext.request.contextPath}/static/img/star.svg">
							</c:forEach>
								<c:if test="${review.reviewScore<5}">
									<c:forEach begin="0" end="${5 - review.reviewScore-1}">
										<img src="${pageContext.request.contextPath}/static/img/star2.svg">
									</c:forEach>
								</c:if>
						</div>
						<div class="review_w">
							${review.reviewContent}
						</div>
						<div style="display: flex; justify-content: space-between;">
							<c:if test="${review.reviewImage != null }">
							<img src="${review.reviewImage}"
								class="item-image2">
								</c:if>
							<div class="modify">수정하기</div>
						</div>
					</div>
					</c:forEach>
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
