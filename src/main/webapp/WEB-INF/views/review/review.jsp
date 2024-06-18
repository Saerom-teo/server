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
	href="${pageContext.request.contextPath}/static/css/review.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">
<title>Review</title>
<script>
</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="container">
		<h2>후기 내역</h2>
		
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
					<img src="${pageContext.request.contextPath}/static/img/date.svg" >
				</div>
				<div>
					<div>연도 - 월 - 일</div>
					<img src="${pageContext.request.contextPath}/static/img/date.svg" >
				</div>
			</div>
			
			<div class="btn_search">조회하기</div>			
		</div>
		
		<div class="item-container">
			<div class="item">
				<div>
					<img src = "${pageContext.request.contextPath}/static/img/tower.png">
					<p>[소락] 오가닉 코튼 자수 손수건</p>
					<div>2024.05.29 작성</div>
					<button class="delete-button">✕</button>
				</div>
				<hr/>
			</div>
			<hr/>
			<div class="item">
				
			</div>
		</div>
		
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>

</html>
