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
	href="${pageContext.request.contextPath}/static/css/news.css">
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
	width: 100%;
	z-index: 1000;
}
</style>
<title>Document</title>
</head>
<body>
	<div class="news">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<%@ include file="/WEB-INF/views/common/newsnav.jsp"%>
		<div class="searchsection">
			<div class="div">원하는 뉴스 키워드를 검색해보세요</div>
			<input class="searchbar" type="text"/>
		</div>
		<div class="body">
			<div class="category">
				<div class="categorybar">
					<div class="button-1">
						<div class="div2">뉴스 카테고리</div>
					</div>
					<div class="button-2">
						<div class="_1">1번 카테고리</div>
					</div>
					<div class="button-3">
						<div class="_1">1번 카테고리</div>
					</div>
					<div class="button-4">
						<div class="_1">1번 카테고리</div>
					</div>
					<div class="button-5">
						<div class="_1">1번 카테고리</div>
					</div>
				</div>
				<div class="_2024-05-28">2024년 05월 28일</div>
			</div>
			<div class="frame-8859">
				<div class="category-nav-bar">
					<div class="_12">1번 카테고리</div>
					<div class="category-1">
						<div class="div3">보도자료</div>
					</div>
					<div class="category-2">
						<div class="div4">뉴스</div>
					</div>
					<div class="category-3">
						<div class="div4">기사</div>
					</div>
					<div class="category-4">
						<div class="div4">네이버 뉴스</div>
					</div>
					<div class="category-5">
						<div class="div4">카카오 뉴스</div>
					</div>
				</div>
				<div class="badynews">
					<div class="news-1">
						<img class="image-17"
							src="${pageContext.request.contextPath}/static/img/news-image1.png" />
						<div class="content">
							<div class="div5">환경 오염 심각, 곧 지구 망함</div>
							<div class="div6">언제 망할지... 다들 궁금해 하는데 집에 가고 싶은데 배고프고 오늘
								마라탕 먹으니까 버틸 수 있음 보도자료 보도자료 보도자료 보도자료 보도자료 보도자료 보도자료 보도자료 보도자료
								보도자료 보도자료 보도자료 보도자료 보도자료 보도자료 보도자료 보도자료 보도자료 보도자료 보도자료 보도자료 보도자료
								보도자료 보도자료 보도자료</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>

</body>
</html>